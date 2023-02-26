tmp_folder_name="/tmp/clash"
download_url="https://ghproxy.com/https://raw.githubusercontent.com/peanut996/ClashOnOpenWrt/master/clash.tar.gz"

iptables -I INPUT -p tcp --dport 7890 -j ACCEPT
iptables -I INPUT -p tcp --dport 8890 -j ACCEPT
iptables -I INPUT -p tcp --dport 9090 -j ACCEPT
iptables -I INPUT -p tcp --dport 9091 -j ACCEPT
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
echo "[clash] open ports success"
echo "[clash] detect network until online..."
while ! ping -c 1 -n -w 1 cn.bing.com &> /dev/null
do
    echo "[clash] network offline...try again."
done
echo "[clash] congratulations! now it's online"
echo "[clash] kill existed clash client..."
echo `ps  |grep "clash" | grep -v grep | grep -v "/root/install.sh"`
kill $(ps  |grep "clash" | grep -v grep | grep -v "install.sh" | awk '{print $1}')
echo "[clash] start clash downloading..."
wget --no-check-certificate -O /tmp/clash.tar.gz  ${download_url}
tar -zxvf /tmp/clash.tar.gz -C /tmp > /dev/null
chmod +x ${tmp_folder_name}/clash
cd ${tmp_folder_name}
./clash > clash.log &
echo "[clash] clash start success"