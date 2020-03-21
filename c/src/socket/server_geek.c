#include	"unp.h"

char *run_cmd(char *cmd);

int
main(int argc, char **argv)
{
	int					listenfd, connfd, n;
	struct sockaddr_in	servaddr, cliaddr; // IPV4 套接字地址结构
	char				buff[MAXLINE];
	socklen_t len;

	//　创建socket
	listenfd = Socket(AF_INET, SOCK_STREAM, 0);
	// 将套接字地址结构清零
	bzero(&servaddr, sizeof(servaddr));
	// 初始化套接字结构
	servaddr.sin_family      = AF_INET;
	servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
	servaddr.sin_port        = htons(1313);	

	//　打开　SO_REUSEADDR　选项
	int on = 1;
	setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
	//　将协议地址与socket绑定
	Bind(listenfd, (SA *) &servaddr, sizeof(servaddr));
	//　转换为监听套接字（socket函数创建的套接字被假定为主动套接字）
	Listen(listenfd, LISTENQ);

	for ( ; ; ) {
		len = sizeof(cliaddr);
		connfd = Accept(listenfd, (SA *) &cliaddr, &len);
		printf("connection from %s, port %d\n",
				inet_ntop(AF_INET, &cliaddr.sin_addr, buff, sizeof(buff)),
				ntohs(cliaddr.sin_port));
		while (1) 
		{
			n = read(connfd, buff, sizeof(buff));
			if(n < 0){
				err_quit("error read");
			}else if (n == 0){
				printf("client closed \n");
				close(connfd);
				break;
			}

			buff[n] = 0;

			if (strncmp(buff, "ls", n) == 0) {
                char *result = run_cmd("ls");
                if (send(connfd, result, strlen(result), 0) < 0)
                    return 1;
				free(result);
            } else if (strncmp(buff, "pwd", n) == 0) {
                char buf[256];
                char *result = getcwd(buf, 256);
                if (send(connfd, result, strlen(result), 0) < 0){
                    return 1;
                 }
            } else if (strncmp(buff, "cd ", 3) == 0) {
                char target[256];
                bzero(target, sizeof(target));
                memcpy(target, buff + 3, strlen(buff) - 3);
                if (chdir(target) == -1) {
                    printf("change dir failed, %s\n", target);
                }
            } else {
                char *error = "error: unknown input type";
                if (send(connfd, error, strlen(error), 0) < 0)
                    return 1;
            }
		}
	}
}


char *run_cmd(char *cmd) {
    char *data = malloc(16384);
    bzero(data, sizeof(data));
    FILE *fdp;
    const int max_buffer = 256;
    char buffer[max_buffer];
    fdp = popen(cmd, "r");
    char *data_index = data;
    if (fdp) {
        while (!feof(fdp)) {
            if (fgets(buffer, max_buffer, fdp) != NULL) {
                int len = strlen(buffer);
                memcpy(data_index, buffer, len);
                data_index += len;
            }
        }
        pclose(fdp);
    }
    return data;
}