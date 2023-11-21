apt install grub-common -y
PASSWORD=$(grep '^root:' /etc/shadow | cut -d: -f2)
echo "set superusers=\"root\"" >> /etc/grub.d/40_custom
echo "password_pbkdf2 root $PASSWORD" >> /etc/grub.d/40_custom
update-grub

mkdir -p /etc/default
echo "GRUB_CMDLINE_LINUX=\"audit=1 audit_backlog_limit=8192 apparmor=1 security=apparmor\"" >> /etc/default/grub
update-grub
