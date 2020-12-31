//
//  debug.cpp
//  Teeet
//
//  Created by xdf_yanqing on 12/30/20.
//

#include "debug.hpp"
#include <iostream>
#include <iomanip>
using namespace::std;
void test() {
//    int x = 8;
//    int y =6;
//    std::cout << std::endl;
//    std::cout << x - y << " " << x * y << " " << x + y;
//    std::cout << std::endl;
    std::cout << "Hello C++ \n";
    
    
    int q;
    std::cin >> q;
    std::cout << "qq:" << std::hex << q << std::endl ;
    std::cerr << "error" << std::endl;
    
}

/// 进制输出
void test2(){
    cout << "Enter an integer :" << endl ;
    int input = 0;
    cin >> input;
    cout << " Integer_ in 八进制 : " << oct << input << endl;
    cout << input << endl;
    
    cout << " 16进制 : " << hex << input << endl;
    cout << input << endl;
    
    //重置为10进制
    cout << "重置 为默认" << endl;
    cout << resetiosflags(ios_base::hex|ios_base::showbase|ios_base::uppercase);
    cout << input << endl;
    
    
}


/// 小数点与科学计数
void test3() {
    const double pi = (double)22.0/7;
    cout << pi << endl;
    cout << "设置精确度7位" << endl;
    cout << setprecision(7);
    cout << "pi =" << pi << endl;
    cout << fixed << "fixed Pi = " << pi << endl;
    cout << scientific << "scientific pi = " << pi << endl;
    
    cout << "设置精确度10位" << endl;
    cout << setprecision(10);
    cout << "pi =" << pi << endl;
    cout << fixed << "fixed Pi = " << pi << endl;
    cout << scientific << "scientific pi = " << pi << endl;
    
    
    cout << endl << "Enter a radius:" << endl;
    double radius = 0;
    cin >> radius;
    cout << "面积 : " << 2*pi*radius << endl;
}


/// 参数可设置默认值
void test4(int a = 10) {
    cout << a << 15;
}
void test5() {
   unsigned short a = 1<<15;
//    a += 1;
    cout << sizeof(a) << endl;
    cout << a << endl;
    
    int b[1024] = {0,2};
    cout << sizeof(b) << endl;
    char str[10]; //没有给char 数组初始化 \0 结束符,容易溢出
    
    cin >> str;
    cout << strlen(str) << endl;
}

/// 指针
void test6() {
    
    char a = '&';
    char * p = &a;
    // int * 作为一种类型  指针类型  p 变量 存储地址
    cout << p << endl;
    cout << *p << endl;
    cout << sizeof(a) << " " << sizeof(p) << " " << sizeof(long long *) << endl;
    
    
    char type[] = {'A','B','\0'};
    char * P = &type[0];
    for (int i = 0;  i < sizeof(type); i ++) {
        cout << type[i] << endl;
        cout << *(P+i) << endl;
    }
    
    
    //未初始化内存释放问题  
    
    bool * isOk = NULL;
    cout << "请输入y/n" << endl;
    char input = NULL;
    cin >> input;
    if (input == 'y') { //记住这个警告
        isOk = new bool;
        *isOk = true;
    }
    
    cout << isOk << endl;
    
    delete isOk;
   
}


/// 动态分配内存
void test7() {
    
    int * a = new int[10]; //这里的10表示10个字节的内存 ,bing
    int * c = a;
    cout << a << endl;
    cout << sizeof(a) << endl;
    int b = 10;
    a = &b;
    cout << a << endl << sizeof(a) << endl << b << endl;

    cout << sizeof(a) << endl;
    cout << c << endl;
    delete[] c;
 }

int main() {
    test6();
    
    
    return 0;
}
