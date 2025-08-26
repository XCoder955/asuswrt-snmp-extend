#!/bin/sh

# "创建必要的目录"
mkdir -p /jffs/scripts/snmp

# "复制脚本文件"
cp -r scripts/* /jffs/scripts/snmp/
chmod +x /jffs/scripts/snmp/*.sh

# "复制配置文件"
cp configs/snmpd.conf.add /jffs/configs/
