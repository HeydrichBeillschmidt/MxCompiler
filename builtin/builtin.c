#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>

void _print$$YGXPAD$Z(const char* str) {
    printf("%s", str);
}

void _println$$YGXPAD$Z(const char* str) {
    printf("%s\n", str);
}

void _printInt$$YGXH$Z(int n) {
    printf("%d", n);
}

void _printlnInt$$YGXH$Z(int n) {
    printf("%d\n", n);
}

const char* _getString$$YGPADXZ() {
    char* buf = malloc(sizeof(char)*1024);
    scanf("%s", buf);
    return buf;
}

int _getInt$$YGHXZ() {
    int buf;
    scanf("%d", &buf);
    return buf;
}

const char* _toString$$YGPADH$Z(int i) {
    char* buf = malloc(sizeof(char)*16);
    sprintf(buf,"%d",i);
    return buf;
}

char* _malloc$$YGPADH$Z(int size) {
    return malloc(size);
}

int _length$string$$QEAHXZ(const char* str) {
    return strlen(str);
}

const char* _substring$string$$QEAPADHH$Z(const char* str, int left, int right) {
   char* buf = malloc(sizeof(char)*(right-left+1));
   memcpy(buf, str+left, right-left);
   buf[right-left] = '\0';
   return buf;
}

int _parseInt$string$$QEAHXZ(const char* str) {
    int ret;
    sscanf(str, "%d", &ret);
    return ret;
}

int _ord$string$$QEAHH$Z(const char* str, int pos) {
    return str[pos];
}

const char* _strcat$$YGPADPADPAD$Z(const char* str1, const char* str2) {
    char* buf = malloc(sizeof(char)*1024);
    strcpy(buf, str1);
    strcat(buf, str2);
    return buf;
}

bool _strcmp_eq$$YG_NPADPAD$Z(const char* str1, const char* str2) {
    return strcmp(str1, str2)==0;
}

bool _strcmp_neq$$YG_NPADPAD$Z(const char* str1, const char* str2) {
    return strcmp(str1, str2)!=0;
}

bool _strcmp_lt$$YG_NPADPAD$Z(const char* str1, const char* str2) {
    return strcmp(str1, str2)<0;
}

bool _strcmp_gt$$YG_NPADPAD$Z(const char* str1, const char* str2) {
    return strcmp(str1, str2)>0;
}

bool _strcmp_le$$YG_NPADPAD$Z(const char* str1, const char* str2) {
    return strcmp(str1, str2)<=0;
}

bool _strcmp_ge$$YG_NPADPAD$Z(const char* str1, const char* str2) {
    return strcmp(str1, str2)>=0;
}