# Prompt for the sAMAccountName of the user to search
$Username = Read-Host "Enter the username (sAMAccountName) of the user"

# Attempt to retrieve the user object from the current domain
try {
    $User = Get-ADUser -Filter {SamAccountName -eq $Username} -Properties whenChanged

    if ($User) {
        Write-Output "Username: $($User.SamAccountName)"
        Write-Output "Last modified: $($User.whenChanged)"
    } else {
        Write-Output "User '$Username' was not found."
    }
}
catch {
    Write-Output "An error occurred while retrieving user data: $_"
}
