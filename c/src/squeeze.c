#include <stdio.h>

void squeeze(char s1[], char s2[]);

int main(){

    char s1[] = {"abcbefg"};
    char s2[] = {"fghigkc"};

    squeeze(s1, s2);

    printf("s1: %s", s1);
}

void squeeze(char s1[], char s2[]){
    int i ,j,k;

    for (k=0; s2[k] != '\0'; k++){

        for (i = j = 0; s1[i] != '\0'; i++){
            if (s1[i] != s2[k]){
                s1[j++] = s1[i];
            }
        }
        s1[j] = '\0';
    }


}