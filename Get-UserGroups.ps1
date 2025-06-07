# Prompt for the user's AD username (without domain)
$username = Read-Host "Enter the username"

# Attempt to retrieve the user's group memberships using current credentials
try {
    $groups = Get-ADPrincipalGroupMembership -Identity $username

    Write-Host "`nUser $username is a member of the following groups:"
    $groups | Select-Object -ExpandProperty Name
}
catch {
    Write-Error "Error retrieving user's groups: $_"
}
