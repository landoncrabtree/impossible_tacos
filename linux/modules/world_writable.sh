# Find world-writable files and directories and remove world-writable permissions
df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d -perm -0002 | xargs chmod o-w