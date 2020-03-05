//
//  Lesson_2.c
//  main
//
//  Created by Дмитрий Константинов on 24.01.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

#include <stdio.h>
#define ARR_SIZE 100

void solution1();
void solution2();
void menu();

int bin[ARR_SIZE] = {0};
int size = 0;
int i = 0;
int p = 1;

int tenToTwo(int a, int i)
{
    bin[i] = a % 2;
    i += 1;
    size = i;
    
    if (a >= 2) {
        printf("%d", a % 2);
        return(tenToTwo(a / 2, i));
    } else {
        return a % 2;
    }
}

int aDegreeBa(int a, int b, int p)
{
    while(b) {
        p = p * a;
        b -= 1;
    }
    
    return p;
}

int aDegreeBb(int a, int b, int p)
{
    if (b > 0) {
        return aDegreeBb(a, b - 1, p * a);
    } else {
        return p;
    }
}

int aDegreeBc(int a, int b, int p)
{
    if (b > 0) {
        if (b % 2 == 0) {
            return aDegreeBc(a * a, b / 2, p);
        } else {
        return aDegreeBc(a, b - 1, p * a);
        }
    } else {
        return p;
    }
}

int main(int argc, const char * argv[]) {
    int sel = 0;
    do
    {
        menu();
        scanf("%i", &sel);
        switch (sel)
        {
            case 1:
                solution1();
                break;
            case 2:
                solution2();
                break;
            case 3:
                solution3();
                break;
            case 0:
                printf("Bye-bey\n");
                break;
            default:
                printf("Wrong selected\n");
        }
    } while (sel != 0);

    printf("Hello, World!\n");
    return 0;
}

void solution1()
{
    printf("Solution 1\n");

    //1. Реализовать функцию перевода из десятичной системы в двоичную, используя рекурсию.

    int a;

    printf("Input your integer : \n");
    scanf("%d", &a);

    printf("%d : In the binary system it looks like this, read [<-] \n",tenToTwo(a, 0));
    printf("Or so if you want to read normally [->] : ");
    
    for(i = size - 1; i >= 0; i--)
        printf("%d", bin[i]);
    printf("\n");
    
}

void solution2()
{
    printf("Solution 2\n");

    //2. 2. Реализовать функцию возведения числа a в степень b: a. без рекурсии; b. рекурсивно; c. *рекурсивно, используя свойство четности степени.
   
    int a;
    int b;

    printf("Inpit a^b integers, like 2-3 : \n");
    scanf("%d-%d", &a, &b);

    printf("Option 'a' : %d\n",aDegreeBa(a, b, 1));
    printf("Option 'b' : %d\n",aDegreeBb(a, b, 1));
    printf("Option 'c' : %d\n",aDegreeBc(a, b, 1));
    
    
}

void menu()
{
    printf("1 - task 1\n");
    printf("2 - task 2\n");
    printf("0 - exit\n");
}
