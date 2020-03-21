#include "unp.h"

void str_cli(FILE *, int);

int main(int argc, char **argv)
{
    int sockfd;
    struct sockaddr_in servaddr;

    if (argc != 2)
        err_quit("usage: ./cli <IPaddress>");

    sockfd = Socket(AF_INET, SOCK_STREAM, 0);

    bzero(&servaddr, sizeof(servaddr));

    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(SERV_PORT);

    Inet_pton(AF_INET, argv[1], &servaddr.sin_addr);

    Connect(sockfd, (SA *)&servaddr, sizeof(servaddr));

    str_cli(stdin, sockfd);

    exit(0);
}

void str_cli(FILE *fp, int sockfd)
{
    ssize_t n;
    char sendline[MAXLINE];
    char recieve[MAXLINE];

    while (fgets(sendline, MAXLINE, fp) != NULL)
    {
        // 消除字符串中的换行符
        int i = strlen(sendline);
        if (sendline[i - 1] == '\n')
        {
            sendline[i - 1] = 0;
        }

        Writen(sockfd, sendline, strlen(sendline));

        if ((n = read(sockfd, recieve, MAXLINE) == 0))
            err_quit("str_cli: server terminated prematurely");

        recieve[n] = 0;
        Fputs(recieve, stdout);
        Fputs("\n", stdout);
    }
}