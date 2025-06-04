# Define the target domain (e.g., "domain.local")
$TargetDomain = "your.domain"

# Define the Organizational Unit (OU) path in the target domain
$TargetOU = "OU=Users,DC=example,DC=com"

# Attempt to fetch users from the specified OU in the target domain
try {
    $Users = Get-ADUser -Filter * -SearchBase $TargetOU -Server $TargetDomain -Properties DisplayName, SamAccountName

    if ($Users.Count -eq 0) {
        # No users found in the given OU and domain
        Write-Host "No users found in OU '$TargetOU' in domain '$TargetDomain'."
    } else {
        # Users found, display basic information
        Write-Host "Users found in domain $TargetDomain under OU $TargetOU"
        $Users | Select-Object DisplayName, SamAccountName | Format-Table -AutoSize
    }
} catch {
    # Handle any errors that occurred during the query
    Write-Error "Error retrieving users: $_"
}
