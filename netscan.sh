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

