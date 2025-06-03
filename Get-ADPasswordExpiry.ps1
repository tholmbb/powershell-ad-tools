# Prompt the user to enter a username
$username = Read-Host "Enter username"

# Retrieve the user object from Active Directory, including the password expiry time
$user = Get-ADUser -Identity $username -Properties "msDS-UserPasswordExpiryTimeComputed"

# Check if the user was found
if ($user) {
    # Convert the password expiry time from file time to a readable date format
    $expiryDate = [datetime]::FromFileTime($user."msDS-UserPasswordExpiryTimeComputed")
    
    # Display the username and password expiration date
    Write-Output "User: $($user.SamAccountName)"
    Write-Output "Password expires on: $expiryDate"
} else {
    # Display a message if the user was not found
    Write-Output "User not found!"
}

# Pause the script to allow the user to read the output
Pause
