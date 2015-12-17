#!system//bin/sh

while [ $# -gt 0 ]; do
    case $1 in
      --Cpufreq=*)
        cpufreq=${1#--Cpufreq=}
        ;;
    esac
    shift
  done

#echo cpufreq=`echo $cpufreq`
echo $cpufreq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo $cpufreq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq  

echo $cpufreq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo $cpufreq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq  

echo scaling_min_freq=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq`
echo scaling_max_freq=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq`


echo scaling_cur_freq=
i=10
while [[ $i -gt 1 ]];
do
 cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq;
 sleep 5;
 ((i--));
done




