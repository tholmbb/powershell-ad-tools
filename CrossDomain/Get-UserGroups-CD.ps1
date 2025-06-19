# Prompt for the user's AD username (without domain)
$Username = Read-Host "Enter the username (samAccountName)"

# Define the target domain and prompt for credentials
$Domain = Read-Host "Enter the domain name or domain controller"
$Credential = Get-Credential -Message "Enter your credentials for the domain"

# Attempt to retrieve the user's group memberships
try {
    $Groups = Get-ADPrincipalGroupMembership -Identity $Username -Server $Domain -Credential $Credential

    # Print the group names
    Write-Host "`nUser $Username is a member of the following groups:"
    $Groups | Select-Object -ExpandProperty Name
}
catch {
    # Handle any errors during group retrieval
    Write-Error "Error retrieving user's groups: $_"
}
