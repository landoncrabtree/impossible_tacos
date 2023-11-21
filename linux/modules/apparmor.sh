apt install apparmor -y
systemctl unmask apparmor
systemctl enable --now apparmor