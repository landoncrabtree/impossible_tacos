# Prompt for list of usernames that are authorized to use the system

echo "Enter a list of usernames that are authorized to use the system, separated by spaces:"
echo "Example: user1 user2 user3"
read -a users

# Check if user exists, if not, create user
for user in "${users[@]}"
do
    if id "$user" >/dev/null 2>&1; then
        # set shell to /bin/bash
        usermod -s /bin/bash $user
    else
        echo "Authorized user $user does not exist, creating user"
        useradd -m -s /bin/bash $user
    fi

    mkdir -p /home/$user
    chown -R $user:$user /home/$user

done

# Prompt for list of administrators
echo "Enter a list of administrators, separated by spaces:"
echo "Example: admin1 admin2 admin3"
read -a admins

# Add users to sudoers, wheel, and admin groups
for admin in "${admins[@]}"
do
    usermod -aG sudo $admin
    usermod -aG wheel $admin
    usermod -aG admin $admin
done

# Check for non-admin users in sudoers, wheel, and admin groups
wheel_users = $(getent group wheel | cut -d: -f4)
sudo_users = $(getent group sudo | cut -d: -f4)
admin_users = $(getent group admin | cut -d: -f4)

# Remove non-admin users from sudoers, wheel, and admin groups
for wheel_user in "${wheel_users[@]}"
do
    if [[ ! " ${admins[@]} " =~ " ${wheel_user} " ]]; then
        echo "Removing unauthorized user $wheel_user from wheel group"
        gpasswd -d $wheel_user wheel
    fi
done

for sudo_user in "${sudo_users[@]}"
do
    if [[ ! " ${admins[@]} " =~ " ${sudo_user} " ]]; then
        echo "Removing unauthorized user $sudo_user from sudo group"
        gpasswd -d $sudo_user sudo
    fi
done

for admin_user in "${admin_users[@]}"
do
    if [[ ! " ${admins[@]} " =~ " ${admin_user} " ]]; then
        echo "Removing unauthorized user $admin_user from admin group"
        gpasswd -d $admin_user admin
    fi
done

# Remove non-authorized users
# Get users with UID >= 1000
all_users = $(getent passwd {1000..60000} | cut -d: -f1)
authorized_users = $(echo "${users[@]} ${admins[@]}")
for user in "${all_users[@]}"
do
    if [[ ! " ${authorized_users[@]} " =~ " ${user} " ]]; then
        echo "Removing unauthorized user $user"
        crontab -r -u $user
        pkill -u $(id -u $user)
        deluser --remove-home --remove-all-files $user

    fi
done




