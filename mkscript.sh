#!/bin/bash
#1дһ���ű���������¹���(ʹ�ú���)��
#1���ű�ʹ�ø�ʽ��
#mkscript.sh [-D|--description "script description"] [-A|--author "script author"]   �ļ���
#2������ļ����Ȳ����ڣ��򴴽�����ǰ��������������ʾ��
#!/bin/bash
# Description: script description
# Author: script author
#
#3������ļ����ȴ��ڣ������գ��ҵ�һ�в��ǡ�#!/bin/bash��������ʾ�﷨�����˳��������һ���ǡ�#!/bin/bash������ʹ��vim�򿪽ű����ѹ��ֱ�Ӷ�λ�����һ��
#4���򿪽ű���ر�ʱ�жϽű��Ƿ����﷨����
#����У���ʾ����y�����༭������n�������˳���
#���û�У�������ļ���ִ��Ȩ�ޣ�



echo $1 > a
echo "1: $1"
echo "2: $2"
echo "Count for args is: $#"

#�ļ�������
if [ ! -f "$2" ]; then
    touch "$2"
    echo "#!/bin/bash" >> $2
	description=`sed 's/\[\|\]\|"//g' aa |awk '{print $1}' | awk -F-- '{print $2}'`
    #echo $description  
    #description
    #echo ${#description}
    #��description�е�����ĸ��д
    #echo ${description:0:1}
    first_up_1=`echo ${description:0:1} | tr '[a-z]' '[A-Z]'`
    echo "#$first_up_1${description:1:${#description}}:":`sed 's/\[\|\]\|"//g' aa |awk '{print $2,$3}'` >> $2
	
    author=`sed 's/\[\|\]\|"//g' aa |awk '{print $4}' | awk -F-- '{print $2}'`
    #echo $author 
    #����author�ĳ���
    #echo ${#author}
    #��author�е�����ĸ��д
    #echo ${author:0:1}
    first_up_2=`echo ${author:0:1} | tr '[a-z]' '[A-Z]'`  
    echo "#$first_up_2${author:1:${#author}}:"`sed 's/\[\|\]\|"//g' aa |awk '{print $5,$6}'` >> $2
    echo "#" >> $2
#�ļ�����
else	
	#�ļ�Ϊ��
	if [ ! -s $2 ]; then
		echo "file is empty"
	#�ļ�����
	else
		#��һ�в��ǡ�#!/bin/bash��
		firstLine=`sed -n '1p' $2`
		#�ַ����ȽϷ�����һ��Ҫ�пո�
		if [ "$firstLine" != "#!/bin/bash" ]; then
			echo "Error command" && exit
		#��һ���ǡ�#!/bin/bash��
		else
			#ʹ��vim�򿪽ű����ѹ��ֱ�Ӷ�λ�����һ��
			vim + $2
			�ر��ļ�
			
			#�жϽű������﷨����
			bash -n $2
			#���﷨����
			if [ $? -ne 0 ]; then
				echo "$2 has grammar mistakes"
				read -p "Pls input y(continue this edit)/n(quit without saved): " choice
				while true;do
					if [[ $choice == y ]] ;then
						#�����༭
					elif [[ $choice == n ]] ;then
						exit
					else
						echo -n "Error,"
					fi
					read -p "Input again y(continue this edit)/n(quit without saved): " choice
				done
			else
				#�ر��ļ�
				chomd a+x $2
			fi
		fi
		
	fi
	#if [ `cat $2`!="" && `sed -n '1p' $2`!="#!/bin/bash" ]; then
	#	
	#fi
fi






