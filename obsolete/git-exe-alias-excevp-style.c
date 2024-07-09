//Compile this code to git.exe, such as with `tcc git-exe-alias.c -o git.exe`, and put it at the top of the path. But only if you need to do the exact same workaround I needed.
//The point of this program is to call git in wsl with all the arguments, to try a different way of aliasing git into wsl, one which will hopefully work better than a random failure I'm having.

//#include <unistd.h> //I guess this is where exec lives, but I get a hard header not found if I include it, but only a soft implicit declaration warning if I exclude it, at least in tcc... //This is actually explained, I think, in https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/execvp?view=msvc-170 (it's deprecated, for naming-convention reasons, in favor of _execvp)
#include <stdio.h>
int main(int argc, char **argv){ //remember: arg0 is the name of the program! eg {"git.exe", "status"...}
  //This would be trivial using execvp, but we need an extra argument so it's trivial+1.
  char *newarray[256] = {"wsl-git-exec-alias-abomination", "git"}; //this should be argc+1 length, but, ah, C standards law....
  int i = 1;
  while(argv[i]){
    puts(argv[i]);
    if(i==256){
      puts("256 wasn't enough, you fool!");
    }
    newarray[i+1] = argv[i];
    i++;
  }
  return execvp("wsl", newarray); //search path for wsl and then execute it with the arguments.
}
