# Prompt for the username to restore
$Restore = Read-Host "Enter the username (samAccountName) of the deleted user to restore"

# Attempt to find the deleted user account in the current domain
try {
    $deletedUser = Get-ADObject -Filter {samAccountName -eq $Restore} -IncludeDeletedObjects -Properties *

    if ($deletedUser) {
        # Restore the deleted user object
        Restore-ADObject -Identity $deletedUser.DistinguishedName

        Write-Host "User account '$Restore' has been successfully restored."
    } else {
        Write-Warning "No deleted user found with samAccountName '$Restore'."
    }
}
catch {
    Write-Error "An error occurred: $_"
}
