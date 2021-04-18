export utunid=$(ifconfig | grep -B 1 -- -- | awk -F ":" '{print $1}' | grep ^u)
sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat #2>/dev/null
sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat #2>/dev/null > newrules.conf
echo "nat on $utunid inet from 192.168.72.0/24 to any -> ($utunid) extfilter ei" > newrules.conf
sudo pfctl -a com.apple.internet-sharing/shared_v4 -N -f newrules.conf #2>/dev/null
echo $utunid
