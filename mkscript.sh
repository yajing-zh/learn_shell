#!/bin/bash
#1写一个脚本，完成如下功能(使用函数)：
#1、脚本使用格式：
#mkscript.sh [-D|--description "script description"] [-A|--author "script author"]   文件名
#2、如果文件事先不存在，则创建；且前几行内容如下所示：
#!/bin/bash
# Description: script description
# Author: script author
#
#3、如果文件事先存在，但不空，且第一行不是“#!/bin/bash”，则提示语法错误并退出；如果第一行是“#!/bin/bash”，则使用vim打开脚本；把光标直接定位至最后一行
#4、打开脚本后关闭时判断脚本是否有语法错误
#如果有，提示输入y继续编辑，输入n放弃并退出；
#如果没有，则给此文件以执行权限；



echo $1 > a
echo "1: $1"
echo "2: $2"
echo "Count for args is: $#"

#文件不存在
if [ ! -f "$2" ]; then
    touch "$2"
    echo "#!/bin/bash" >> $2
	description=`sed 's/\[\|\]\|"//g' aa |awk '{print $1}' | awk -F-- '{print $2}'`
    #echo $description  
    #description
    #echo ${#description}
    #把description中的首字母大写
    #echo ${description:0:1}
    first_up_1=`echo ${description:0:1} | tr '[a-z]' '[A-Z]'`
    echo "#$first_up_1${description:1:${#description}}:":`sed 's/\[\|\]\|"//g' aa |awk '{print $2,$3}'` >> $2
	
    author=`sed 's/\[\|\]\|"//g' aa |awk '{print $4}' | awk -F-- '{print $2}'`
    #echo $author 
    #计算author的长度
    #echo ${#author}
    #把author中的首字母大写
    #echo ${author:0:1}
    first_up_2=`echo ${author:0:1} | tr '[a-z]' '[A-Z]'`  
    echo "#$first_up_2${author:1:${#author}}:"`sed 's/\[\|\]\|"//g' aa |awk '{print $5,$6}'` >> $2
    echo "#" >> $2
#文件存在
else	
	#文件为空
	if [ ! -s $2 ]; then
		echo "file is empty"
	#文件不空
	else
		#第一行不是“#!/bin/bash”
		firstLine=`sed -n '1p' $2`
		#字符串比较符两边一定要有空格
		if [ "$firstLine" != "#!/bin/bash" ]; then
			echo "Error command" && exit
		#第一行是“#!/bin/bash”
		else
			#使用vim打开脚本；把光标直接定位至最后一行
			vim + $2
			关闭文件
			
			#判断脚本有无语法错误
			bash -n $2
			#有语法错误
			if [ $? -ne 0 ]; then
				echo "$2 has grammar mistakes"
				read -p "Pls input y(continue this edit)/n(quit without saved): " choice
				while true;do
					if [[ $choice == y ]] ;then
						#继续编辑
					elif [[ $choice == n ]] ;then
						exit
					else
						echo -n "Error,"
					fi
					read -p "Input again y(continue this edit)/n(quit without saved): " choice
				done
			else
				#关闭文件
				chomd a+x $2
			fi
		fi
		
	fi
	#if [ `cat $2`!="" && `sed -n '1p' $2`!="#!/bin/bash" ]; then
	#	
	#fi
fi






