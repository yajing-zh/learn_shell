#!/bin/bash
#1、写一个脚本getinterface.sh，脚本可以接受参数(i,I,a)，完成以下任务：
#   (1)使用以下形式：getinterface.sh [-i interface|-I IP|-a]
#   (2)当用户使用-i选项时，显示其指定网卡的IP地址；
#   (3)当用户使用-I选项时，显示其后面的IP地址所属的网络接口；（如 192.168.199.183：eth0）
#   (4)当用户单独使用-a选项时，显示所有网络接口及其IP地址（lo除外）
#echo $1
#echo $2'

arg2=`echo $2 | sed 's/]//'`
#echo $arg2

if [ "$1" == '[-i' ];then
	if `ifconfig | grep $arg2 &> /dev/null`; then
		echo "Ip for $arg2 is:"`ifconfig $arg2 | grep "inet addr" | awk '{print $2}' | awk -F: '{print $2}'`
	else
		echo "No this interface, please input again."
	fi
elif [ "$1" == '[-I' ];then
	if `ifconfig | grep $arg2 &> /dev/null`; then
		echo $arg2:`ip addr show | grep $arg2 | awk '{print $7}'`
	else
		echo "No this ip address, please input again."
	fi
elif [ "$1" == '[-a]' ];then
	jiekou=`ifconfig | grep "Link encap" | awk '{print $1}' | grep -v "lo"`
	echo $jiekou:`ifconfig $jiekou | grep "inet addr" | awk '{print $2}' | awk -F: '{print $2}'`

else
	echo "you input error command. Please input as getinterface.sh [-i interface|-I IP|-a]"
fi
