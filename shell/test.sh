#!/bin/bash
#author:严青
#url:yanqinglovemengmeng.cn
echo "Shell 传递参数";
echo "执行文件名 $0";
echo "参数1 $1";
echo "参数2 $2";
echo "参数3 $3";
echo "传递参数作为一个字符显示: $*";
echo "传递参数作为$#个参数输出: $@";
echo "参数个数 $#";
echo "当前脚本进程ID $$";
echo "后台运行的最后一个进程ID $!";
echo "显示最后命令退出状态(0表示无错误) :$? ";
echo "----\$* 演示----";
for i in "$*";do 
	echo $i
done
echo "----\$@ 演示----";
for i in "$@";do
	echo $i
done
