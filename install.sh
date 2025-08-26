#!/bin/sh

# 兼容性检查
source /koolshare/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
MODEL=
UI_TYPE=ASUSWRT
FW_TYPE_CODE=
FW_TYPE_NAME=

get_model(){
	local ODMPID=$(nvram get odmpid)
	local PRODUCTID=$(nvram get productid)
	if [ -n "${ODMPID}" ];then
		MODEL="${ODMPID}"
	else
		MODEL="${PRODUCTID}"
	fi
	echo_date 当前机型: ${MODEL}
}

get_fw_type() {
	local KS_TAG=$(nvram get extendno|grep koolshare)
	if [ -d "/koolshare" ];then
		if [ -n "${KS_TAG}" ];then
			FW_TYPE_CODE="2"
			FW_TYPE_NAME="koolshare官改固件"
		else
			FW_TYPE_CODE="4"
			FW_TYPE_NAME="koolshare梅林改版固件"
		fi
	else
		if [ "$(uname -o|grep Merlin)" ];then
			FW_TYPE_CODE="3"
			FW_TYPE_NAME="梅林原版固件"
		else
			FW_TYPE_CODE="1"
			FW_TYPE_NAME="华硕官方固件"
		fi
	fi
	echo_date 当前固件类型: ${FW_TYPE_NAME}
}

platform_test(){
	local LINUX_VER=$(uname -r|awk -F"." '{print $1$2}')
	if [ -d "/koolshare" -a -f "/usr/bin/skipd" -a "${LINUX_VER}" -ge "41" ];then
		echo_date 机型:"${MODEL} ${FW_TYPE_NAME} 符合安装要求, 开始安装插件"
	else
		exit_install 1
	fi
}
echo_date "开始兼容性检查"
get_model
get_fw_type
platform_test

echo_date "创建必要的目录"
mkdir -p /koolshare/scripts/snmp

echo_date "复制脚本文件"
cp -r scripts/* /koolshare/scripts/snmp/
chmod +x /koolshare/scripts/snmp/*.sh

echo_date "复制配置文件"
cp configs/snmpd.conf.add /jffs/configs/

echo_date "SNMP扩展插件安装完成, 请重启路由器SNMP服务"
