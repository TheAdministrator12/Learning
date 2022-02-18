#include <stdio.h>
#include <math.h>

void ToDeg(float rad, float pi){
    float math = rad * 180/pi;
    printf("Uhel[Rad] %f | Uhel[Stup] %f\n", rad, math);
}

void ToRad(float stupne, float pi){
    float math = stupne * pi/180;
    printf("Uhel[Stup] %f | Uhel[Rad] %f\n", stupne, math);
}

void Tabulka(int pi){
    printf("Sinus | Cosinus | Uhly [Radians] | Uhly [Stupne]\n");
    for(int i = 0; i <= 360; i += 30){
        float math = i * pi/180;
        printf("%f | %f | %f | %d\n", sin(math), cos(math), math, i);
    }
}

int WinMain(){ // Z nějakého důvodu tam musim mít WinMain() než Main()
    float pi = 3.14159265359;
    ToDeg(2, pi);
    ToRad(30, pi);
    Tabulka(pi);
    return 0;
}
