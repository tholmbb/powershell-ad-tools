# Prompt for credentials to access the target domain
$TargetDomain = Read-Host "Enter your domain (e.g., your.local)"
$User = Read-Host "Enter your username (e.g., user@your.local)"
$Password = Read-Host "Enter your password" -AsSecureString
$Credential = New-Object System.Management.Automation.PSCredential($User, $Password)

# Prompt for the username to restore
$Restore = Read-Host "Enter the username (samAccountName) of the deleted user to restore"

# Attempt to find the deleted user account in the target domain
try {
    $deletedUser = Get-ADObject -Filter {samAccountName -eq $Restore} `
        -IncludeDeletedObjects `
        -Properties * `
        -Server $TargetDomain `
        -Credential $Credential

    if ($deletedUser) {
        # Restore the deleted user object
        Restore-ADObject -Identity $deletedUser.DistinguishedName `
            -Server $TargetDomain `
            -Credential $Credential

        Write-Host "User account '$Restore' has been successfully restored."
    } else {
        Write-Warning "No deleted user found with samAccountName '$Restore'."
    }
}
catch {
    Write-Error "An error occurred: $_"
}
