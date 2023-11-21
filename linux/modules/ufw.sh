apt install ufw -y
ufw enable
ufw default deny incoming
ufw default allow outgoing

echo "Enter ports to allow, separated by spaces:"
echo "Example: 22 80 443"
read ports

for port in $ports
do
    ufw allow $port
done


# if services go down, let's just allow all
#ufw allow in from any to any
#ufw allow out from any to any
# ufw default allow incoming
# ufw default allow outgoing

