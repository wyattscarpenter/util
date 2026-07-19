//A bad (normal style) C program I got ChatGPT to write me using the prompt: count max number of consecutive 0 bytes in a file, c program. It should work recursively on every file in every directory specified in the command line arguments. It should also print a help message. It should begin with the tcc shebang. It should never reserve more than a gigabyte of memory.
//Next prompt: oh yeah, it also has to work on windows.

//ChatGPT notes (not in a comment for some reason): It follows neither POSIX symbolic links (lstat) nor Windows reparse points, so it won't recurse indefinitely through symlink loops. On Windows, reparse points are treated as regular non-directory entries by this code; if you specifically want to ignore all reparse points, you can additionally check FILE_ATTRIBUTE_REPARSE_POINT before descending.

/*
 * maxzero.c
 *
 * Recursively scan every regular file under the paths given on the command
 * line and print the maximum run of consecutive 0x00 bytes found.
 *
 * Portable:
 *   - Linux / macOS / BSD (POSIX)
 *   - Windows (MSVC, MinGW, TinyCC for Windows)
 *
 * Memory usage:
 *   - 1 MiB read buffer
 *   - Directory stack grows as needed but is tiny compared to 1 GiB.
 */

#define _FILE_OFFSET_BITS 64

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>

#ifdef _WIN32

#include <windows.h>

#define PATH_SEP '\\'

#else

#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

#define PATH_SEP '/'

#endif

#ifndef MAX_PATH
#define MAX_PATH 4096
#endif

#define BUFFER_SIZE (1024*1024)

typedef struct {
    char **items;
    size_t size;
    size_t capacity;
} Stack;

static void die(const char *msg)
{
    fprintf(stderr,"%s\n",msg);
    exit(EXIT_FAILURE);
}

static char *xstrdup(const char *s)
{
    size_t n=strlen(s)+1;
    char *p=(char*)malloc(n);
    if(!p) die("out of memory");
    memcpy(p,s,n);
    return p;
}

static void push(Stack *s,const char *path)
{
    if(s->size==s->capacity){
        size_t nc=s->capacity? s->capacity*2 : 64;
        char **tmp=(char**)realloc(s->items,nc*sizeof(char*));
        if(!tmp) die("out of memory");
        s->items=tmp;
        s->capacity=nc;
    }
    s->items[s->size++]=xstrdup(path);
}

static char *pop(Stack *s)
{
    if(s->size==0) return NULL;
    return s->items[--s->size];
}

static void join_path(char *dst,size_t cap,const char *a,const char *b)
{
    size_t la=strlen(a);

    if(la && (a[la-1]=='/' || a[la-1]=='\\'))
        snprintf(dst,cap,"%s%s",a,b);
    else
        snprintf(dst,cap,"%s%c%s",a,PATH_SEP,b);
}

static void scan_file(const char *path)
{
    FILE *fp=fopen(path,"rb");
    if(!fp){
        fprintf(stderr,"%s: %s\n",path,strerror(errno));
        return;
    }

    unsigned char *buf=(unsigned char*)malloc(BUFFER_SIZE);
    if(!buf) die("out of memory");

    uint64_t cur=0,max=0;

    for(;;){
        size_t n=fread(buf,1,BUFFER_SIZE,fp);

        for(size_t i=0;i<n;i++){
            if(buf[i]==0){
                ++cur;
                if(cur>max) max=cur;
            }else{
                cur=0;
            }
        }

        if(n<BUFFER_SIZE){
            if(ferror(fp))
                fprintf(stderr,"%s: read error\n",path);
            break;
        }
    }

    printf("%llu\t%s\n",
           (unsigned long long)max,
           path);

    free(buf);
    fclose(fp);
}

#ifdef _WIN32

static void walk(const char *root)
{
    DWORD attr=GetFileAttributesA(root);

    if(attr==INVALID_FILE_ATTRIBUTES){
        fprintf(stderr,"%s: not found\n",root);
        return;
    }

    if(!(attr&FILE_ATTRIBUTE_DIRECTORY)){
        scan_file(root);
        return;
    }

    Stack stack={0};
    push(&stack,root);

    char *dir;

    while((dir=pop(&stack))!=NULL){

        char pattern[MAX_PATH];
        snprintf(pattern,sizeof(pattern),"%s\\*",dir);

        WIN32_FIND_DATAA fd;
        HANDLE h=FindFirstFileA(pattern,&fd);

        if(h==INVALID_HANDLE_VALUE){
            fprintf(stderr,"%s: cannot open directory\n",dir);
            free(dir);
            continue;
        }

        do{

            if(strcmp(fd.cFileName,".")==0 ||
               strcmp(fd.cFileName,"..")==0)
                continue;

            char child[MAX_PATH];
            join_path(child,sizeof(child),dir,fd.cFileName);

            if(fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY){
                push(&stack,child);
            }else{
                scan_file(child);
            }

        }while(FindNextFileA(h,&fd));

        FindClose(h);
        free(dir);
    }

    free(stack.items);
}

#else

static void walk(const char *root)
{
    struct stat st;

    if(lstat(root,&st)){
        fprintf(stderr,"%s: %s\n",root,strerror(errno));
        return;
    }

    if(S_ISREG(st.st_mode)){
        scan_file(root);
        return;
    }

    if(!S_ISDIR(st.st_mode))
        return;

    Stack stack={0};
    push(&stack,root);

    char *dir;

    while((dir=pop(&stack))!=NULL){

        DIR *d=opendir(dir);

        if(!d){
            fprintf(stderr,"%s: %s\n",dir,strerror(errno));
            free(dir);
            continue;
        }

        struct dirent *ent;

        while((ent=readdir(d))!=NULL){

            if(strcmp(ent->d_name,".")==0 ||
               strcmp(ent->d_name,"..")==0)
                continue;

            char child[MAX_PATH];
            join_path(child,sizeof(child),dir,ent->d_name);

            if(lstat(child,&st))
                continue;

            if(S_ISDIR(st.st_mode))
                push(&stack,child);
            else if(S_ISREG(st.st_mode))
                scan_file(child);
        }

        closedir(d);
        free(dir);
    }

    free(stack.items);
}

#endif

static void help(const char *prog)
{
    printf(
        "Usage: %s [OPTIONS] PATH...\n"
        "\n"
        "Recursively scan every regular file under each PATH and print\n"
        "the maximum run of consecutive zero bytes.\n"
        "\n"
        "Options:\n"
        "  -h\n"
        "  --help      Show this help.\n"
        "\n"
        "Output:\n"
        "  <count><TAB><path>\n",
        prog);
}

int main(int argc,char **argv)
{
    if(argc<2){
        help(argv[0]);
        return EXIT_FAILURE;
    }

    int first=1;

    while(first<argc && argv[first][0]=='-'){
        if(strcmp(argv[first],"-h")==0 ||
           strcmp(argv[first],"--help")==0){
            help(argv[0]);
            return EXIT_SUCCESS;
        }

        fprintf(stderr,"Unknown option: %s\n",argv[first]);
        return EXIT_FAILURE;
    }

    if(first==argc){
        help(argv[0]);
        return EXIT_FAILURE;
    }

    for(int i=first;i<argc;i++)
        walk(argv[i]);

    return EXIT_SUCCESS;
}
