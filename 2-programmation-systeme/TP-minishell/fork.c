#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

// Greeting shell during startup
void init_shell()
{
    
    printf("\n\t**** TP-MINISHELL **** \n");
    
    char* username = getenv("USER");
    printf("\nUSER is: @%s", username);
    printf("\n\n");
    sleep(1);
}

// Function to take input
char takeInput(void)
{
    char *input = NULL;
    size_t size = 0;
    getline(&input, &size, stdin); // updates the size as it goes along
    return *input;
}

void execCmd(char path, char *tab[]) {
    pid_t pid;
    pid = fork();
    
    if (pid == -1) {
        perror("erreur fork");
        exit(1);
    }
	else if (pid == 0) { 
        execv(path, tab);
	} else {
    	while (pid != wait(0));
    }

}

int main(int argc, char *argv[])
{   
    init_shell();
    
    char choice;
    while (choice != 100) {
        printf("Choose an action to do (a, b, c or d) : \n a) get date \n" 
        " b) get system name \n c) get running instances \n d) stop program  \n >>> ");
    
        choice = takeInput();
        // a = 97, b = 98, c = 99, d = 100

        int system(const char *command);
    
    
        if(choice == 99) {
            printf("\n");
            execv("/usr/bin/top", ["top"]);
            printf("\n\n");
        } else if(choice == 100) {
            printf("\n\n ... quitting \n\n");
            exit(0);
        } else if(choice == 97) {
            printf("\n");
            execCmd("usr/bin/date", ["date", "+%Hh%M"]);
            printf("\n\n");
        } else if(choice == 98) {
            printf("\n");
            execv("/usr/bin/uname", ["uname", "-a"]);
            printf("\n\n");
        } else {
            printf("\n\nthis option is not available \n\n");
        }
        sleep(1); 
    }
}