
@adb shell setprop persist.service.thermal 0
@adb wait-for-device

@adb root
@adb wait-for-device
@adb remount

@for /f "tokens=*" %%i in ('adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies') do @set var=%%i 

@echo All cpufreqs are: %var%

@set /p last=please input your freq:

::@echo My cpufreq is: %last%

@adb push .\run.sh /system/bin/

@adb shell chmod -R 777 /system/bin

@adb shell /system/bin/run.sh --Cpufreq=%last%






