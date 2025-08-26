本项目在 [kylehase/asuswrt-snmp](https://github.com/kylehase/asuswrt-snmp) 基础上进行改造


# TODO
通过rogsoft软件中心-插件离线安装

# 背景
梅林固件内置的SNMP不支持采集温度等数据，开发此脚本扩展SNMP的数据采集

# 支持设备

[kylehase/asuswrt-snmp](https://github.com/kylehase/asuswrt-snmp) 已在 **RT-AC68U** 和 **RT-AX86U** 测试

一键安装脚本仅在 **RT-AX86U** 固件版本 **Asuswrt-Merlin-3004.388.9_2(rogsoft改版)** 上测试

# 要求
- 已安装梅林固件（默认支持SNMP ）
- 开启 SSH 
- 开启 enabled JFFS custom scripts and configs （改版固件默认开启）

# 安装
一键安装脚本, 确保网络流畅访问github
```shell
cd ~ && \
curl -L https://github.com/XCoder955/asuswrt-snmp-extend/archive/refs/heads/main.zip -o snmp-extend.zip && \
unzip snmp-extend.zip && \
cd asuswrt-snmp-extend-main && \
mkdir -p /jffs/scripts/snmp && \
cp -r asuswrt-snmp-extend-main/scripts/* /jffs/scripts/snmp && \
chmod +x /jffs/scripts/snmp/*.sh && \
cp asuswrt-snmp-extend-main/configs/snmpd.conf.add /jffs/configs/ && \
rm snmp-extend.zip && rm -r asuswrt-snmp-extend-main
```

卸载脚本, 卸载后重启snmp服务
```shell
rm -r /jffs/scripts/snmp && rm /jffs/configs/snmpd.conf.add
```


# 传感器详情
结果均以原始数据形式返回（不带单位符号），类型均是字符串。oid 对照表如下
| 传感器            | Baseoid                                                       | 类型  | 单位 |
|-------------------|---------------------------------------------------------------|-------|-------|
| CPU temp          | 1.3.6.1.2.1.25.1.8.3.1.1.4.116.101.109.112                    | INT   | °C    |
| DHCP leases       | 1.3.6.1.2.1.25.1.9.3.1.1.4.100.104.99.112                     | INT   | #     |
| Connected clients | 1.3.6.1.2.1.25.1.10.3.1.1.9.99.111.110.110.101.99.116.101.100 | INT   | #     |
| 2.4GHz radio temp | 1.3.6.1.2.1.25.1.11.3.1.1.5.99.104.105.112.49                 | INT   | °C    |
| 5GHz radio temp   | 1.3.6.1.2.1.25.1.12.3.1.1.5.99.104.105.112.50                 | INT   | °C    |
| Memory used       | 1.3.6.1.2.1.25.1.13.3.1.1.3.109.101.109                       | FLOAT | %     |
| Idle CPU          | 1.3.6.1.2.1.25.1.14.3.1.1.4.105.100.108.101                   | FLOAT | %     |
| Uptime            | 1.3.6.1.2.1.25.1.15.3.1.1.6.117.112.116.105.109.101           | INT   | days  |
| Partition use (/jffs)    | 1.3.6.1.2.1.25.1.16.3.1.1.4.106.102.102.115                   | INT   | %     |
| WAN traffic up    | 1.3.6.1.2.1.25.1.18.3.1.1.6.117.112.108.111.97.100            | FLOAT | Mbps  |
| WAN traffic down  | 1.3.6.1.2.1.25.1.17.3.1.1.8.100.111.119.110.108.111.97.100    | FLOAT | Mbps  |

# 技术参考

https://github.com/RMerl/asuswrt-merlin.ng/wiki/User-scripts

https://github.com/RMerl/asuswrt-merlin.ng/wiki/Custom-config-files