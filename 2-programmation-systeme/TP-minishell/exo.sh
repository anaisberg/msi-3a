#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

// Greeting shell during startup
void init_shell()
{
    printf("\n********************************");
    printf("\n\t**** MINISHELL ****");
    printf("\n********************************");
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
            printf("you chose c ");
        } else if(choice == 100) {
            printf("\n ... quitting \n");
        } else if(choice == 97) {
            system("date");
            printf("\n");
        } else if(choice == 98) {
            system("uname -a");
         printf("\n");
        } else {
            printf("this option is not available");
        }
    }
    



    pid_t pid;
    pid = fork();
    
    if (pid == -1) {
        perror("erreur fork");
        exit(EXIT_FAILURE);
    }
	if (pid == 0) { 
        /* Processus fils */
        printf("Hello from child process with pid: %d and parent pid: %d\n",
            getpid(),
            getppid()
        );
	} else {
    	while (pid != wait(0));
        /* Processus pere */
        printf("Hello from parent process with pid: %d and child pid: %d\n",
            getpid(),
            pid
        );
    }
    exit(EXIT_SUCCESS);
}