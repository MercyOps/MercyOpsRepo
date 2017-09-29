Connect-VIServer -Server “vcentermgmt01” 
$ESXiHosts = Get-Cluster “MEC01_UCS_QA/TEST” | Get-VMHost
Write-Output $ESXiHosts
 foreach ($ESXi in $ESXiHosts)
 {
 Get-VMhost $ESXi | Get-ScsiLun -LunType Disk | Where-Object {$_.CanonicalName -like 'naa.*' -and $_.MultipathPolicy -like ‘RoundRobin’} | Set-ScsiLun -CommandsToSwitchPath 1 | Out-File -Append "C:\ModifyIO-OUT.txt"
 }
 