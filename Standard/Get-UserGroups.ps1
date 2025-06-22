# Prompt for the user's AD username (without domain)
$Username = Read-Host "Enter the username"

# Attempt to retrieve the user's group memberships using current credentials
try {
    $Groups = Get-ADPrincipalGroupMembership -Identity $Username

    Write-Host "`nUser $Username is a member of the following groups:"
    $Groups | Select-Object -ExpandProperty Name
}
catch {
    Write-Error "Error retrieving user's groups: $_"
}
