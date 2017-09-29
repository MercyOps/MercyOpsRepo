Import-Module VMware.VimAutomation.Core

$LogFile = "VMSnapShot3DaysOld_" + (Get-Date -UFormat "%d-%b-%Y") + ".csv"
$ATLogFile = "C:\Scripts\VMware\" + "$LogFile"
Write-Host $ATLogFile
Connect-VIServer -Server vcentermgmt01 -User "srv_vmrep@mmcnt" -Password "mercy123!"

$Result=Get-VM | Get-Snapshot | Where {$_.Created -lt (Get-Date).AddDays(-3)} | Select-Object VM, Name, Created
$Result | Export-Csv $ATLogFile

$EmailFrom = "VMwareReports@mdmercy.com"
 $EmailTo = "DL-IT-ServerEngineeringTeam@mdmercy.com"
 $EmailSubject = "Weekly VMWare Snapshot Report"  
 $SMTPServer = "smtprelay.mmcnt.mhs.med"
 
 Send-MailMessage -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Body "VMware Snapshot Report" -Attachments "$ATLogFile" -Priority High -dno onSuccess, onFailure -SmtpServer $SMTPServer
 Start-Sleep -Seconds 10
