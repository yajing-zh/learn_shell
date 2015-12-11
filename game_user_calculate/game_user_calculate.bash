#!/bin/bash

#先统计有多少个用户，即有多少个ip
sed '1d' log_all > log_all_1
awk '{ip[$1]++}END{for(i in ip){print i, ip[i]}}' log_all_1 > user
awk '{ip[$1]++}END{for(i in ip){print i}}' log_all_1 > user
user_count=`cat user | wc -l`


#把每个用户的记录提取出来
for((i=1;i<=$user_count;i++));
do
	#逐一取出各个ip
	one_user=`sed -n "$i"p user`
	
	#根据ip筛选出属于此ip的报告记录，并统计报告次数
	list_count=`grep "$one_user" log_all_1 | wc -l`
	
	#根据ip筛选出属于此ip的报告记录，并从第四列分数中统计出不同分数的个数
	score_count=`grep "$one_user" log_all_1 | awk '{print $4}' | sort -u | wc -l`
	
	#将每个用户的报告总次数写入行首
	sed -i "$i{s/^/ $list_count /}" user
	
	#将每个用户的不同分数的个数，写入行尾
	sed -i "$i{s/$/ $score_count /}" user 
done


#把有记录报告次数和用户IP的文件及不同分数的文件user, 按记录次数由大到小排序，且取ip字段，并输出前十个
echo "The first 10 users online are"
sort -n -r -k 1 user | awk '{print $2}' | sed -n '1,10p' | cat -n

#-n是以数值来排序
#-r是降序排列，默认是升序
#-k指定列数


#统计一天内一直处于不活跃状态的玩家总数，
nowake=`awk '{print $3}' user | grep "1" | wc -l`

#计算不活跃状态玩家的百分比
echo Percentage of no active users is: `awk 'BEGIN{printf "%.2f%\n",('$nowake'/'$user_count')*100}'`