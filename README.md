# discover-device-ip  

使用方法: https://blog.csdn.net/happyfreeangel/article/details/97662155

源代码下载: https://github.com/HappyFreeAngel/discover-device-ip.git

如何快速获取设备ip地址

在日常调试特种设备如IOT设备，打印机，或树莓派设备，特别是没有屏幕，键盘鼠标的情况下，只是知道这个设备可以获取到一个IP地址，可能是dhcp 获取或已经设置了静态ip 地址, 同时知道这个设备的用户密码等，但是没有显示器，键盘鼠标，或者安装显示器键盘等外设比较麻烦的情况下，
如何获取这个设备的IP，进而进行控制呢?

保存下列代码为 netscan.sh 并设置执行权限 chmod +x netscan.sh
#!/usr/bin/env bash
domain=`echo $1`
ip_start=`echo $2| cut -d "," -f 1`
ip_end=`echo $2| cut -d "," -f2`
ip_crt=`echo $ip_start`

function segScan(){
        ping -c 1 $1.$2 > /dev/null && echo "$2 is alive"&
        rst=`echo $?`
        return $rst
}

while [ $ip_crt -ne $ip_end ]
do
{
        segScan $domain $ip_crt
        rst=`echo $?`
        ip_crt=$((ip_crt+1))
}
done
wait





接上你的设备 如树莓派,或其他能联网的设备
netscan.sh 192.168.2 1,255 > /tmp/withDeviceIP.txt
快速断开你的设备(断网 或断电 都可以)
执行netscan.sh 192.168.2 1,255 > /tmp/withoutDeviceIP.txt; 
diff /tmp/withDeviceIP.txt /tmp/withoutDeviceIP.txt
即可知道刚连接上的IP地址是多少。
在这里插入图片描述
这方法可以用于快速确认新连接设备的IP地址。

如果您不确定是否真的是这个IP地址,可以 ping 刚才获取的新的IP 192.168.2.130，
然后把你的设备网线/WI-FI/或断电，看看是不是ping 不通了。
如果是肯定是这个IP没有错。


一行代码批量脚步执行方法:
ipinfo="192.168.0 2,254";git clone https://github.com/HappyFreeAngel/discover-device-ip.git; cd discover-device-ip; ./netscan.sh ${ipinfo} >/tmp/1.txt;  echo "请断开设备 然后按回车"; read user_input; netscan.sh ${ipinfo} >/tmp/2.txt; sort  /tmp/1.txt >/tmp/11.txt; sort /tmp/2.txt >/tmp/12.txt;diff /tmp/11.txt /tmp/12.txt;