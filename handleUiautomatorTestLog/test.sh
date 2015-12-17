#!/bin/bash
#**************************************************************
#Description:
#	handle the Auto Test log and generate test_result.xml
#    Like this in test_result.xml
#		<?xml version="1.0" encoding="utf-8"?>
#		<result
#		  <test
#		    name="test3gpVideo"
#		    text="Fail" />
#		  <test
#		    name="testMp4Video"
#		    text="Fail" />
#	this test.sh must be saved in the same directory with 
#   log folder that contains log.txt and named with case name
#**************************************************************
function ergodic(){
for file in $(ls $1)
do
	if [ -d $1"/"$file ] #如果 file存在且是一个目录则为真
	then
		#local path=$1"/"$file #得到文件的完整的目录
		#local name=$file       #得到文件的名字
		#logName=`ls $1"/"$file`
		#logName=`echo $logName | awk -F. '{print $1}'`
		#echo path/logName=$path"/"$logName
		echo '  <test' >> test_result.xml
		echo -e '    name="\c' >> test_result.xml
		echo -e "$file\c" >> test_result.xml
		echo '"' >> test_result.xml

		cat $1"/"$file"/"log.txt | grep "OK" &>/dev/null
		if [ $? -eq 0 ] ;
		then
			echo '    text="Pass" />' >> test_result.xml	
		else
			echo '    text="Fail" />' >> test_result.xml
		fi
	#else
		#echo "file=$file"
	fi
done
}
INIT_PATH=`pwd`
echo '<?xml version="1.0" encoding="utf-8"?>' > test_result.xml
echo "<result" >> test_result.xml
ergodic $INIT_PATH 
echo "</result>" >> test_result.xml






