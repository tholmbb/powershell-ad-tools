# Prompt for the sAMAccountName of the user to search
$SamAccountName = Read-Host "Enter the username (sAMAccountName) of the user"

# Attempt to retrieve the user object from the current domain
try {
    $User = Get-ADUser -Filter {SamAccountName -eq $SamAccountName} -Properties whenChanged

    if ($User) {
        Write-Output "Username: $($User.SamAccountName)"
        Write-Output "Last modified: $($User.whenChanged)"
    } else {
        Write-Output "User '$SamAccountName' was not found."
    }
}
catch {
    Write-Output "An error occurred while retrieving user data: $_"
}
