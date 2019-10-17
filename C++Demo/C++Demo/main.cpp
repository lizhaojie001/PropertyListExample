//
//  main.cpp
//  C++Demo
//
//  Created by xdf_yanqing on 2019/9/6.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#include <iostream>
#include <cmath>
void test();
void test4();
using namespace std;


/**
 字符串
 */
void test5() {
    char ch[8] = { '1' , 'A' , 'O' , '9'};
    cout << ch << endl <<  sizeof(ch) << endl;
}

/**
 数组
 */
void test4 (){
    int a[4];
    a[0] = 1;
    a[1] = 2;
    a[2] = 3;
    a[3] = 4;
    int b = 0 ;
    cout << a << endl << sizeof a << endl << sizeof b << endl;
    cout << sizeof(int) << endl;
    *a = 9;
    cout << a[0] << endl;
    
    short things[]  = {2,3,4,5};
    int num_things_elements = sizeof(things)/sizeof(short);
    cout << num_things_elements << endl;
}

/**
 输入字符
 */
void test3(){
    char ch;
    cin >> ch;
    cout << oct;
    cout << ch << endl;
    int n;
    cin >> n;
    cout << n << endl;
}

/**
 输入输出
 */
void test2() {
    std::cout << "Hello, World!\n";
    cout << "Come up and C++ me someTime" ;
    cout << endl;
    cout << "YOU won't regret it" << endl;
    
    int carrots;
    cout << "How manay carrots do you have ?" << endl;
    cin >> carrots;
    cout << "Here are two more ";
    cout << "Now you have "
    << carrots
    << " carrots"
    << endl;
}


/**
 打印
 */
void test() {
 
    double area;
    cout << "Knter the floor area , in square feet , of your home ";
    cin >> area;
    double side;
    side = sqrt(area);
    cout << "This is the equivalent of square " << side
         << " feet to the side" << endl;
    cout << "hOW FASCINATING! " << endl;
    
}

int main(int argc, const char * argv[]) {
    test5();
    return 0;
}
