# Import the Active Directory module
Import-Module ActiveDirectory

# Prompt for the number of days in the past to search for deleted accounts
$daysInput = Read-Host "Enter how many days back to look for deleted accounts (e.g., 180)"
$daysAgo = (Get-Date).AddDays(-[int]$daysInput)

# Retrieve deleted accounts from the target domain
$deletedAccounts = Get-ADObject -Filter {isDeleted -eq $true -and whenChanged -ge $daysAgo} `
    -IncludeDeletedObjects `
    -Properties whenChanged, samAccountName, distinguishedName, lastKnownParent `

# Output the deleted accounts
if ($deletedAccounts) {
    $deletedAccounts | Select-Object samAccountName, UserPrincipalName, whenChanged | Format-Table -Wrap -AutoSize
} else {
    Write-Output "No deleted accounts found."
}
