//Compile this code to git.exe, such as with `tcc git-exe-alias.c -o git.exe`, and put it at the top of the path. But only if you need to do the exact same workaround I needed.
//The point of this program is to call git in wsl with all the arguments, to try a different way of aliasing git into wsl, one which will hopefully work better than a random failure I'm having.

#define max_len 10000
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main(int argc, char **argv){ // Remember: arg0 is the name of the program! eg, the argv is {"git.exe", "status"...}
  char new_str[max_len];
  const char *cmd = "git.bat "; // Do I understand why only the bat file seems to work? No. Is that what I found? Yes. (nb: I think I was mistaken, and actually the execvp solution worked equivalently well.)
  strcpy(new_str, cmd);
  int str_index =strlen(cmd);
  for(int i = 1 /* argv index */; argv[i]; i++) { // loop over the arguments, excluding argv[0]. Remember, argv[n] will be a null pointer.
    puts(argv[i]);
    for(int j = 0; argv[i][j]; j++) { //strcopy into the new char array
      if(str_index==max_len){
        printf("%d wasn't enough, you fool!!!", max_len);
        return -1; // Let's early-out, why not?
      } else {
        new_str[str_index] = argv[i][j];
        str_index++;
      }
    }
    new_str[str_index++] = ' ';
  }
  new_str[str_index++] = '\0';
  puts(new_str);
  return system(new_str);
}
