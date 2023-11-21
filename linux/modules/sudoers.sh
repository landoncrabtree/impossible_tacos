# Delete 'Defaults !authenticate' from sudoers file
sed -i '/Defaults !authenticate/d' /etc/sudoers

# Change NOPASSWD to PASSWD for sudoers
sed -i 's/NOPASSWD/PASSWD/g' /etc/sudoers

# Do the same for sudoers.d/*
sed -i '/Defaults !authenticate/d' /etc/sudoers.d/*
sed -i 's/NOPASSWD/PASSWD/g' /etc/sudoers.d/*




