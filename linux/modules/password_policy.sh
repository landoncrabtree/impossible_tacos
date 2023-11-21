# add 'PASS_MIN_DAYS 10' to '/etc/login.defs'
# add 'PASS_MAX_DAYS 30' to '/etc/login.defs'
# add 'PASS_WARN_DAYS 7' to '/etc/login.defs'
# add 'ENCRYPT_METHOD SHA512' to '/etc/login.defs'

echo "PASS_MIN_DAYS 10" >> /etc/login.defs
echo "PASS_MAX_DAYS 30" >> /etc/login.defs
echo "PASS_WARN_DAYS 7" >> /etc/login.defs
echo "ENCRYPT_METHOD SHA512" >> /etc/login.defs

apt install libpam-pwquality -y

cp ./baselines/common-password /etc/pam.d/common-password


