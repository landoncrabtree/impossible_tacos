wget https://raw.githubusercontent.com/klaver/sysctl/master/sysctl.conf -O /etc/sysctl.conf

# change kernel.kptr_restrict = 1 to kernel.kptr_restrict = 2
sed -i 's/kernel.kptr_restrict = 1/kernel.kptr_restrict = 2/g' /etc/sysctl.conf

# Add the following lines to the end of the file:
# net.ipv6.conf.all.disable_ipv6 = 1
# kernel.dmesg_restrict = 1
# kernel.unprivileged_userns_clone = 0

echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "kernel.dmesg_restrict = 1" >> /etc/sysctl.conf
echo "kernel.unprivileged_userns_clone = 0" >> /etc/sysctl.conf

sysctl -p
sudo echo "" > /etc/ufw/sysctl.conf