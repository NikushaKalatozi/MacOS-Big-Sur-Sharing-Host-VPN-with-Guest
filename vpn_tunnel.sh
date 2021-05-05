cat << "EOF" 
 __     __  _______   __    __        ________                                        __ 
/  |   /  |/       \ /  \  /  |      /        |                                      /  |
$$ |   $$ |$$$$$$$  |$$  \ $$ |      $$$$$$$$/__    __  _______   _______    ______  $$ |
$$ |   $$ |$$ |__$$ |$$$  \$$ |         $$ | /  |  /  |/       \ /       \  /      \ $$ |
$$  \ /$$/ $$    $$/ $$$$  $$ |         $$ | $$ |  $$ |$$$$$$$  |$$$$$$$  |/$$$$$$  |$$ |
 $$  /$$/  $$$$$$$/  $$ $$ $$ |         $$ | $$ |  $$ |$$ |  $$ |$$ |  $$ |$$    $$ |$$ |
  $$ $$/   $$ |      $$ |$$$$ |         $$ | $$ \__$$ |$$ |  $$ |$$ |  $$ |$$$$$$$$/ $$ |
   $$$/    $$ |      $$ | $$$ |         $$ | $$    $$/ $$ |  $$ |$$ |  $$ |$$       |$$ |
    $/     $$/       $$/   $$/          $$/   $$$$$$/  $$/   $$/ $$/   $$/  $$$$$$$/ $$/ 
                                                                                         
                                                                                         
                                                                                         


EOF
export utunid=$(ifconfig | awk -F ":" '/^u/ {intface=$1;  next} /--/ {print intface}')
export bridge100ip=$(ifconfig bridge100 | grep 'inet ' | awk '{print $2}' | sed 's:[^.]*$:0/24:') 
sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat 2>/dev/null
sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat 2>/dev/null > newrules.conf
echo "Setting up a bridge100 and utun network interfaces for you"
echo "Your bridge100 IP is $bridge100ip , and your utun interface is $utunid" 
echo "nat on $utunid inet from $bridge100ip to any -> ($utunid) extfilter ei" > newrules.conf
sudo pfctl -a com.apple.internet-sharing/shared_v4 -N -f newrules.conf 2>/dev/null
echo "Congrats, now you are currently using $utunid network interface, feel free to tunnel your VPN"
