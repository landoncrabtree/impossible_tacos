apt install clamav clamav-daemon -y
systemctl stop clamav-freshclam
freshclam
systemctl start clamav-freshclam
clamscan -l clamav.log --infected --remove --recursive /