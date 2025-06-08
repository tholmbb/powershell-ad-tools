# Import the Active Directory module
Import-Module ActiveDirectory

# Prompt for the target domain (e.g., "your.local")
$TargetDomain = Read-Host "Enter your domain (e.g., your.local)"

# Prompt for credentials to access the target domain
$User = Read-Host "Enter your username (e.g., user@your.local)"
$Password = Read-Host "Enter password" -AsSecureString
$Credential = New-Object System.Management.Automation.PSCredential($User, $Password)

# Prompt for the number of days in the past to search for deleted accounts
$daysInput = Read-Host "Enter how many days back to look for deleted accounts (e.g., 180)"
$daysAgo = (Get-Date).AddDays(-[int]$daysInput)

# Retrieve deleted accounts from the target domain
$deletedAccounts = Get-ADObject -Filter {isDeleted -eq $true -and whenChanged -ge $daysAgo} `
    -IncludeDeletedObjects `
    -Properties whenChanged, samAccountName, distinguishedName, lastKnownParent `
    -Server $TargetDomain `
    -Credential $Credential

# Output the deleted accounts
if ($deletedAccounts) {
    $deletedAccounts | Select-Object samAccountName, UserPrincipalName, whenChanged | Format-Table -Wrap -AutoSize
} else {
    Write-Output "No deleted accounts found."
}
