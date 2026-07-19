#!/usr/bin/tcc -run

//A bad (normal style) C program I got ChatGPT to write me using the prompt: count max number of consecutive 0 bytes in a file, c program. It should work recursively on every file in every directory specified in the command line arguments. It should also print a help message. It should begin with the tcc shebang. It should never reserve more than a gigabyte of memory.

/*
 * maxzero.c
 *
 * Recursively scans files under the paths given on the command line and
 * reports the maximum number of consecutive 0x00 bytes found in each file.
 *
 * Features:
 *  - Recursive directory traversal
 *  - Works on regular files
 *  - Constant memory usage (~1 MiB buffer)
 *  - Never allocates anywhere near 1 GiB
 *  - Help message
 *
 * Usage:
 *   ./maxzero.c PATH...
 *   ./maxzero.c --help
 */

#define _FILE_OFFSET_BITS 64

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <unistd.h>
#include <limits.h>

#ifndef PATH_MAX
#define PATH_MAX 4096
#endif

#define BUFFER_SIZE (1024 * 1024)   /* 1 MiB */

static void print_help(const char *prog)
{
    printf(
        "Usage: %s [PATH...]\n"
        "\n"
        "Recursively scans every regular file beneath each specified path\n"
        "and prints the maximum number of consecutive zero (0x00) bytes\n"
        "found in each file.\n"
        "\n"
        "Options:\n"
        "  -h, --help    Show this help message.\n"
        "\n"
        "Example:\n"
        "  %s dir file.bin\n",
        prog, prog);
}

static void scan_file(const char *path)
{
    FILE *fp = fopen(path, "rb");
    if (!fp) {
        fprintf(stderr, "%s: %s\n", path, strerror(errno));
        return;
    }

    unsigned char *buf = malloc(BUFFER_SIZE);
    if (!buf) {
        fprintf(stderr, "Out of memory.\n");
        fclose(fp);
        exit(EXIT_FAILURE);
    }

    uint64_t current = 0;
    uint64_t maximum = 0;

    while (1) {
        size_t n = fread(buf, 1, BUFFER_SIZE, fp);

        for (size_t i = 0; i < n; i++) {
            if (buf[i] == 0) {
                current++;
                if (current > maximum)
                    maximum = current;
            } else {
                current = 0;
            }
        }

        if (n < BUFFER_SIZE) {
            if (ferror(fp))
                fprintf(stderr, "%s: read error\n", path);
            break;
        }
    }

    printf("%llu\t%s\n",
           (unsigned long long)maximum,
           path);

    free(buf);
    fclose(fp);
}

static void scan_path(const char *path)
{
    struct stat st;

    if (lstat(path, &st) != 0) {
        fprintf(stderr, "%s: %s\n", path, strerror(errno));
        return;
    }

    if (S_ISREG(st.st_mode)) {
        scan_file(path);
        return;
    }

    if (!S_ISDIR(st.st_mode))
        return;

    DIR *dir = opendir(path);
    if (!dir) {
        fprintf(stderr, "%s: %s\n", path, strerror(errno));
        return;
    }

    struct dirent *ent;

    while ((ent = readdir(dir)) != NULL) {
        if (strcmp(ent->d_name, ".") == 0 ||
            strcmp(ent->d_name, "..") == 0)
            continue;

        size_t len = strlen(path) + strlen(ent->d_name) + 2;

        if (len > PATH_MAX) {
            fprintf(stderr, "Path too long: %s/%s\n",
                    path, ent->d_name);
            continue;
        }

        char child[PATH_MAX];
        snprintf(child, sizeof(child), "%s/%s", path, ent->d_name);

        scan_path(child);
    }

    closedir(dir);
}

int main(int argc, char **argv)
{
    if (argc < 2) {
        print_help(argv[0]);
        return EXIT_FAILURE;
    }

    for (int i = 1; i < argc; i++) {
        if (!strcmp(argv[i], "-h") ||
            !strcmp(argv[i], "--help")) {
            print_help(argv[0]);
            return EXIT_SUCCESS;
        }
    }

    for (int i = 1; i < argc; i++)
        scan_path(argv[i]);

    return EXIT_SUCCESS;
}
