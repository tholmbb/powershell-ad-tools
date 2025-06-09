# Prompt for the user's AD username (without domain)
$username = Read-Host "Enter the username"

# Define the target domain and prompt for credentials
$domain = Read-Host "Enter the domain name or domain controller"
$cred = Get-Credential -Message "Enter your credentials for the domain"

# Attempt to retrieve the user's group memberships
try {
    $groups = Get-ADPrincipalGroupMembership -Identity $username -Server $domain -Credential $cred

    # Print the group names
    Write-Host "`nUser $username is a member of the following groups:"
    $groups | Select-Object -ExpandProperty Name
}
catch {
    # Handle any errors during group retrieval
    Write-Error "Error retrieving user's groups: $_"
}
