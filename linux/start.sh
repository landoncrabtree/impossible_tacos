# check if the user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install linux."
    exit 1
fi

mkdir -p /root/ccdc/backups
cp -r /etc /root/ccdc/backups/etc
cp -r /home /root/ccdc/backups/home
cp -r /var /root/ccdc/backups/var

# Load update.sh
chmod +x ./modules/update.sh
./modules/update.sh
echo "Update complete"

# Load sudoers.sh
# - Ensures sudoers file has no 'Defaults !authenticate'
# - Ensures sudoers file has 'PASSWD' instead of 'NOPASSWD'
# - Ensures sudoers.d/* files have no 'Defaults !authenticate'
# - Ensures sudoers.d/* files have 'PASSWD' instead of 'NOPASSWD'
chmod +x ./modules/sudoers.sh
./modules/sudoers.sh
echo "Sudoers updated."

# Load world_writable.sh
# - Ensures no world-writable files or directories exist
chmod +x ./modules/world_writable.sh
./modules/world_writable.sh
echo "World-writable files and directories fixed."

# Load suid.sh
# - Ensures no suid files exist
chmod +x ./modules/suid.sh
./modules/suid.sh
echo "Ran GTFONow to identify possible GTFOBins."

# Load sysctl.sh
# - Ensures sysctl.conf has the correct settings
chmod +x ./modules/sysctl.sh
./modules/sysctl.sh
echo "Sysctl.conf updated."

# Load lynis.sh
# - Runs lynis audit
chmod +x ./modules/lynis.sh
./modules/lynis.sh
echo "Lynis audit complete."

# Load clamav.sh
# - Runs clamav audit
chmod +x ./modules/clamav.sh
./modules/clamav.sh
echo "ClamAV audit complete."

# Load permissions.sh
# - Ensures all files and directories have the correct permissions
chmod +x ./modules/permissions.sh
./modules/permissions.sh
echo "Filesystem Permissions updated."

# Load apparmor.sh
# - Ensures apparmor is installed
# - Ensures apparmor is enabled
chmod +x ./modules/apparmor.sh
./modules/apparmor.sh
echo "AppArmor installed and enabled."

# Load grub.sh
# - Ensures grub is installed
# - Ensures grub has a password set
chmod +x ./modules/grub.sh
./modules/grub.sh
echo "Grub password set."

# Load ufw.sh
# - Ensures ufw is installed
# - Ensures ufw is enabled
# - Open necessary ports
chmod +x ./modules/ufw.sh
./modules/ufw.sh
echo "UFW installed and enabled."

# Load password_policy.sh
# - Ensures password policy is set
chmod +x ./modules/password_policy.sh
./modules/password_policy.sh
echo "Password policy updated."

# Load users.sh
# - Ensures all authorized users exist
# - Ensures all administrators have sudo access
# - Removes sudo access from non-administrators
# - Removes non-authorized users
chmod +x ./modules/users.sh
./modules/users.sh
echo "Authorized users created"
echo "Administrators (sudo/wheel/admin) updated"
echo "Non-authorized users removed"

# Load change_passwords.sh
# - Change all user passwords to meet new complexity requirements
chmod +x ./modules/change_passwords.sh
./modules/change_passwords.sh
echo "All user passwords changed."








