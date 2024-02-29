// [参考](https://daeudaeu.com/kurisuke_kiriage_shisyagonyu/)
#include <stdio.h>
#include <math.h>

int main() {
  // int型の割り算は切り捨て
  printf("%s\n", "-----rounding down-----");
  printf("%d\n", 5 / 2);
  printf("%d\n", (int)floor(5 / 2));
  // 四捨五入はdouble型の除算の結果に+0.5してint型に再キャストする。
  printf("%s\n", "-----rounding half up-----");
  printf("%d\n", (int)((double)5 / (double)2 + 0.5));
  printf("%d\n", (int)round((double)5 / (double)2));
  // 切り上げその1
  printf("%s\n", "-----rounding up-----");
  printf("%d\n", (int)((double)5 / (double)2 + 0.99999));
  // 切り上げその2(x + y -1) / y = x/y + (y-1/y)小数点以下の最小値は1/y
  printf("%d\n", (5 + 2 - 1) / 2);
  printf("%d\n", (int)ceil((double)5 / (double)2));
}
