#!/bin/bash
#echo "1: $1"
#echo "2: $2"
#echo "3: $3"
#echo "Count for args is: $#"

arg2=`echo $2 | sed 's/]//'`
#echo $arg2

getIp()
{
	#echo "Count for args in getIp is: $#"
	#awk '{ip[$1]++}END{for(i in ip){print i}}' access.log > ip
	if [ $# -eq 2 ];then
		if [ "$2" == "access.log" ];then
			grep "$1" $2 | awk '/^[0-9]/{print $1}' | sort -u > ip
		elif [ "$2" == "error.log" ];then
			awk '{print $16}' $2 | sed 's/,//' | sort -u > ip
		else
			echo "Can.t find the log file, please check again."		
		fi
	else
		if [ "$1" == "access.log" ];then
			awk '/^[0-9]/{print $1}' $1 | sort -u > ip
		elif [ "$1" == "error.log" ];then
			awk '{print $16}' $1 | sed 's/,//' | sort -u > ip
		else
			echo "Can.t find the log file, please check again."		
		fi
	fi
	ip_count=`cat ip | wc -l`


	#把每个ip的记录提取出来
	for((i=1;i<=$ip_count;i++));
	do
		#逐一取出各个ip
		one_ip=`sed -n "$i"p ip`

		#根据ip筛选出属于此ip的报告记录，并统计报告次数
		list_count=`grep "$one_ip" access.log | wc -l`


		#将每个ip的报告总次数写入行首
		sed -i "$i{s/^/ $list_count /}" ip &> /dev/null

	done
}

choice()
{
	#echo "The file is $3"		

	if [ "$1" == '[-i' ]; then
		#echo "[-i $2"
		echo "Access count for $arg2 is: "`grep $2 $3 | wc -l`
	elif [ "$1" == '[-d' ]; then
		#echo "[-d $2"
		getIp $2 $3;
		#echo `awk '{printf "%20s:%-20s\n\n",$2,$1}' ip
		awk '{print $2,$1}' ip | sed 's/ /:/' 

	elif [ "$1" == '[-t' ]; then
		#echo "[-t $2"
		echo "Access count for $2 is: "`grep $2 $3 | wc -l`
	else
		echo "Error command, please check."
	fi
}

choice_2()
{
	#echo "The file is $1"
	getIp $1;
	awk '{print $2,$1}' ip | sed 's/ /:/'
}

if [ $# -eq 3 ];then
	choice $1 $arg2 $3;
elif [ $# -eq 2 ]; then
	choice_2 $2;
else
	echo "Error args, please check again."	
fi

