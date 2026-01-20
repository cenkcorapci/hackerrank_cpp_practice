#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;


int main() {
    // read  int, long, char, float, and double
    int i;
    long l;
    char c;
    float f;
    double d;
    scanf("%d %ld %c %f %lf", &i, &l, &c, &f, &d);
    // print them in order
    printf("%d\n%ld\n%c\n%.3f\n%.3lf\n", i, l, c, f, d);
    return 0;
}
