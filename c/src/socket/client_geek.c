#include "unp.h"

void  client_do(FILE *, int);

int main(int argc, char **argv)
{
    int sockfd, n;
    socklen_t len;
    char recvline[MAXLINE +1 ];
    struct sockaddr_in servaddr, cliaddr;

    if (argc != 2){
        err_quit("usage: telnet <IPaddress>");
    }

    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0){
        err_sys("socket error");
    }

    bzero(&servaddr, sizeof(servaddr));

    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(1313);
    //　将地址字符串表达格式转换为地址结构二进制格式
    if(inet_pton(AF_INET, argv[1], &servaddr.sin_addr) <= 0){
        err_quit("inet_pon error for %s", argv[1]);
    }

    if (connect(sockfd, (SA *) &servaddr, sizeof(servaddr))) {
        err_sys("connect error");
    }

    client_do(stdin, sockfd);

    exit(0);
}

void client_do(FILE *fp, int sockfd)
{
    int maxfdp1, n;
    fd_set rset;
    char sendline[MAXLINE], recvline[MAXLINE];

    FD_ZERO(&rset);

    for ( ; ; ){
        FD_SET(fileno(fp), &rset);
        FD_SET(sockfd, &rset);
        maxfdp1 = max(fileno(fp),sockfd) +1;
        Select(maxfdp1, &rset, NULL, NULL, NULL);

        if (FD_ISSET(sockfd, &rset)) {
            if((n = read(sockfd, recvline, MAXLINE)) == 0)
                err_quit("client: server terminated prematurely");
            recvline[n] = 0;
            Fputs(recvline, stdout);
            Fputs("\n", stdout);
        }

        if (FD_ISSET(fileno(fp), &rset)) {
            if (Fgets(sendline, MAXLINE, fp) == NULL)
                return;
            // 消除字符串中的换行符
            int i = strlen(sendline);
            if (sendline[i-1] == '\n'){
                sendline[i-1] = 0;
            }

            if (strncmp("quit", sendline, strlen(sendline)) == 0){
                Shutdown(sockfd, 1);
            }
            Writen(sockfd, sendline, strlen(sendline));
        }

    }
}