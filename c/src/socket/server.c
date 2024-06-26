#include "unp.h"

void str_echo(int);

int main(int argc, char **argv)
{
    int listenfd, connfd;
    pid_t childpid;
    socklen_t clilen;
    struct sockaddr_in cliaddr, servaddr;

    listenfd = Socket(AF_INET, SOCK_STREAM, 0);

    bzero(&servaddr, sizeof(servaddr));

    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htons(INADDR_ANY);
    servaddr.sin_port = htons(SERV_PORT);

    Bind(listenfd, (SA *)&servaddr, sizeof(servaddr));

    Listen(listenfd, LISTENQ);

    for (;;)
    {
        clilen = sizeof(cliaddr);

        connfd = Accept(listenfd, (SA *)&cliaddr, &clilen);

        if ((childpid = Fork()) == 0)
        {
            Close(listenfd);
            str_echo(connfd);
            exit(0);
        }

        Close(connfd);
    }
}

void str_echo(int sockfd)
{
    ssize_t n;
    char buf[MAXLINE];

again:
    while ((n = read(sockfd, buf, MAXLINE)) > 0)
    {
        printf("write %d bytes \n", n);
        Writen(sockfd, buf, n);
        buf[n] = 0;
        printf("write: %s\n", buf);
    }

    if (n < 0 && errno == EINTR)
        goto again;
    else if (n < 0)
        err_sys("str_echo: read error");
}