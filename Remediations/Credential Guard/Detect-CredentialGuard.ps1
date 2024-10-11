<#

.DESCRIPTION
Intune Remediation detection that checks the status of Credential Guard in the endpoint.
Script will exit if Virtualization Based Security is not running.
Based on: https://docs.microsoft.com/en-us/windows/security/threat-protection/device-guard/enable-virtualization-based-protection-of-code-integrity#securityservicesconfigured

#>

# Verify pre-requisite winrm is running for the DeviceGuard cmdlet, then collect values.
$WinRM = (Get-Service -Name WinRM) 
if ($WinRM.Status -ne "Running") {Start-Service -Name WinRM}

# Check that Pre-requisite Virtualization Based Security is running.
$VBSStatus = (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard)
if ($VBSStatus.VirtualizationBasedSecurityStatus -ne '2') 
{
    Write-Host "Virtualization Based Security is not running. Exiting script..."
    exit 0
}

# Check Credential Guard services status and write-output based on if services are configured, running or not.
try
{
$LSARegistry= "HKLM:\System\CurrentControlSet\Control\LSA"
$LSAEnabled = (Get-ItemProperty -Path $LSARegistry -Name "LSACfgFlags" -ErrorAction SilentlyContinue)
$CGRegistry = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard"  
$CGEnabled = (Get-ItemProperty -Path $CGRegistry -Name "Enabled" -ErrorAction SilentlyContinue)
$CGLocked = (Get-ItemProperty -Path $CGRegistry -Name "Locked" -ErrorAction SilentlyContinue)
$CGStatus = (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard)
$Configured = ($CGStatus.SecurityServicesConfigured)
$Running = ($CGStatus.SecurityServicesRunning)
if($Configured -contains 1){$ConfiguredText = "Credential Guard is configured."}
if($Running -contains 1){$RunningText = "Credential Guard is running."}
if($Configured -notcontains 1){$ConfiguredText = "Credential Guard is not configured."}
if($Running -notcontains 1){$RunningText = "Credential Guard is not running."}
if ($Configured -contains 1 -and $Running -contains 1)
{
# Credential Guard is both configured and running!
Write-Host $ConfiguredText $Runningtext
exit 0
}
if ($LSAEnabled.LSACfgFlags -eq '1' -and $CGEnabled.Enabled -eq '1' -and $CGLocked.Locked -eq '1')
{
    # Credential Guard registry values are in place. After next PC Reboot, reporting and configuration will be ok!
    Write-Host $ConfiguredText $Runningtext
    exit 0
}
else {
    # Remediation needed!
    Write-Host $ConfiguredText $Runningtext
    exit 1
}
}
catch {
Write-Error $_.Exception
exit 1
}

# Stop WinRM after collection is finished
$WinRM = (Get-Service -Name WinRM) 
if ($WinRM.Status -eq "Running") {Stop-Service -Name WinRM}
