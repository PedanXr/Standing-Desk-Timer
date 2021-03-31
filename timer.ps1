# PowerShell Stand-Up reminder

$StandFor = 1800 #30 Minutes in Seconds
$SitFor = 2700 #45 Minutes in Seconds
$Loop = $true

Function Show-BalloonTip ($NotificationText) {
    Add-Type -AssemblyName System.Windows.Forms
    $global:balmsg = New-Object System.Windows.Forms.NotifyIcon
    $path = (Get-Process -id $pid).Path
    $balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
    $balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning
    $balmsg.BalloonTipText = $NotificationText
    $balmsg.BalloonTipTitle = "Attention $Env:USERNAME"
    $balmsg.Visible = $true
    $balmsg.ShowBalloonTip(20000)
}

$mode = Read-Host -Prompt "Currently: `n1 = Sitting `n2 = Standing `n"

if ($mode -eq "1") {
} elseif ($mode -eq "2") {
} else {
    Write-Host -BackgroundColor Red -ForegroundColor White "Invalid Input"
    Exit-PSHostProcess
}

do {
    if ($mode -eq "1") {
        Show-BalloonTip -NotificationText "Stand up"
        Write-Host "Stand up"
        Start-Sleep -Seconds $StandFor
        $mode = "2"
    } elseif ($mode -eq "2") {
        Show-BalloonTip -NotificationText "Sit down"
        Write-Host "Sit down"
        Start-Sleep -Seconds $SitFor
        $mode = "1"
    } else {
        Write-Host -BackgroundColor Red -ForegroundColor White "Invalid Input in function"
        Exit-PSHostProcess
    }
} while ($Loop)
