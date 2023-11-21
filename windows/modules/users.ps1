# prompt user for list of authorized users

$users = Read-Host "Enter a list of usernames that are authorized to use the system, separated by spaces: "
$users = $users.Split(" ")

# Create users if they don't exist
foreach ($user in $users) {
    if (!(Get-LocalUser -Name $user -ErrorAction SilentlyContinue)) {
        Write-Host "Authorized user $user does not exist, creating user"
        New-LocalUser -Name $user -Password (ConvertTo-SecureString -AsPlainText "CyberEagles@TNTECH2023" -Force) -ErrorAction SilentlyContinue
        # Create a new user profile for each user
        $userProfile = New-Item -Path "C:\Users\$user" -ItemType Directory -ErrorAction SilentlyContinue
        # Set the user profile to be owned by the user
        $acl = Get-Acl -Path $userProfile
        $acl.SetOwner([System.Security.Principal.NTAccount]$user)
        Set-Acl -Path $userProfile -AclObject $acl
        # Set the user profile to be accessible only by the user
        $acl = Get-Acl -Path $userProfile
        $acl.Access | ForEach-Object { $acl.RemoveAccessRule($_) }
        $acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($user, "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
        Set-Acl -Path $userProfile -AclObject $acl
    } else {
        # enable user if disabled
        Set-LocalUser -Name $user -Enabled $true -ErrorAction SilentlyContinue
    }
}

# Get users that should be administrators
$admins = Read-Host "Enter a list of administrators, separated by spaces: "
$admins = $admins.Split(" ")

# Add users to administrators group
foreach ($admin in $admins) {
    Add-LocalGroupMember -Group "Administrators" -Member $admin -ErrorAction SilentlyContinue
}

# Remove non-administrators from administrators group
$nonAdmins = Get-LocalGroupMember -Group "Administrators" | Where-Object { $admins -notcontains $_.Name }
foreach ($nonAdmin in $nonAdmins) {
    Write-Host "Removing unauthorized user $($nonAdmin.Name) from Administrators"
    Remove-LocalGroupMember -Group "Administrators" -Member $nonAdmin.Name -ErrorAction SilentlyContinue
}

# Disable guest account
Set-LocalUser -Name "Guest" -Enabled $false -ErrorAction SilentlyContinue

# Disable default administrator account
Set-LocalUser -Name "Administrator" -Enabled $false -ErrorAction SilentlyContinue

# Disable any accounts that are not in the list of authorized users
$authorizedUsers = $users + $admins
$allUsers = Get-LocalUser | Where-Object { $authorizedUsers -notcontains $_.Name }
foreach ($user in $allUsers) {
    Write-Host "Removing unauthorized user $($user.Name)"
    Set-LocalUser -Name $user.Name -Enabled $false -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Users\$($user.Name)" -Recurse -Force -ErrorAction SilentlyContinue
}



