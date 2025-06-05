# Define the Organizational Unit (OU) path in the current domain
$TargetOU = "OU=Users,DC=example,DC=com"

# Attempt to fetch users from the specified OU in the current domain
try {
    $Users = Get-ADUser -Filter * -SearchBase $TargetOU -Properties DisplayName, SamAccountName

    if ($Users.Count -eq 0) {
        # No users found in the given OU
        Write-Host "No users found in OU '$TargetOU' in the current domain."
    } else {
        # Users found, display basic information
        Write-Host "Users found in OU $TargetOU"
        $Users | Select-Object DisplayName, SamAccountName | Format-Table -AutoSize
    }
} catch {
    # Handle any errors that occurred during the query
    Write-Error "Error retrieving users: $_"
}
