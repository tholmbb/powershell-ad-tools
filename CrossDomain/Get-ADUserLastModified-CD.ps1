# Prompt for the sAMAccountName of the user to search
$TargetUser = Read-Host "Enter the username (sAMAccountName) of the user"

# Prompt for the target domain (e.g., "your.local")
$TargetDomain = Read-Host "Enter your domain (e.g., your.local)"

# Prompt for credentials if needed
$Credential = Get-Credential -Message "Enter your credentials in the format DOMAIN\username"

# Attempt to retrieve the user object
try {
    $$User = Get-ADUser -Server $TargetDomain -Credential $Credential -Filter "SamAccountName -eq '$TargetUser'" -Properties whenChanged

    if ($User) {
        Write-Output "User found in domain: $TargetDomain"
        Write-Output "Username: $($User.SamAccountName)"
        Write-Output "Last modified: $($User.whenChanged)"
    } else {
        Write-Output "User '$TargetUser' was not found in domain $TargetDomain."
    }
}
catch {
    Write-Output "An error occurred while retrieving user data: $_"
}
