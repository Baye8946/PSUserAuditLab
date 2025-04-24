# PSUserAuditLab.ps1 - PowerShell Core Compatible User Audit Script

Write-Host "🕵️ Running User Audit Script (PowerShell Core Version)..." -ForegroundColor Cyan

# Get local user accounts
$users = Get-CimInstance -ClassName Win32_UserAccount | Where-Object { $_.LocalAccount -eq $true }

# Format report
$report = foreach ($user in $users) {
    [PSCustomObject]@{
        Username          = $user.Name
        Domain            = $user.Domain
        Disabled          = $user.Disabled
        Lockout           = $user.Lockout
        PasswordRequired  = $user.PasswordRequired
    }
}

# Display report in table
$report | Format-Table -AutoSize

# Save report to CSV
$csvPath = "./UserAuditReport.csv"
$report | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "`n✅ Report saved to $csvPath" -ForegroundColor Green
