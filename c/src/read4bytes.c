#include <stdio.h>
int main (int argc, const char * argv[]) {
    
		FILE *fp;
		int r;
		int i;
		fp = fopen(argv[1], "rb");
		fread(&r, 4, 1, fp);
	
		printf("%X \n", r);
	
		fclose(fp);
		return 0;
}