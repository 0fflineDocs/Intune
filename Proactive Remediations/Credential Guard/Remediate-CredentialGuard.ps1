<#

.DESCRIPTION
Proactive Remediation that remediates missing Credential Guard configuration and additional MDM-registry cleanup for correct MEM-reporting.
Based on: https://docs.microsoft.com/en-us/windows/security/threat-protection/device-guard/enable-virtualization-based-protection-of-code-integrity#securityservicesconfigured

#>

# Check status of Credential Guard in the registry
$CGRegistry = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard"
$CGEnabled = (Get-ItemProperty -Path $CGRegistry -Name "Enabled" -ErrorAction SilentlyContinue)
$CGLocked = (Get-ItemProperty -Path $CGRegistry -Name "Locked" -ErrorAction SilentlyContinue)

# If status is OK, do nothing. Else clean the reporting properties from HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceGuard and then enable Credential Guard with UEFI-Lock using registry values.
try
{
    $DGProperties = "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceGuard"
    Remove-ItemProperty -Path $DGProperties -Name "EnableVirtualizationBasedSecurity_ProviderSet" -Force -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $DGProperties -Name "LsaCfgFlags_ProviderSet" -Force -ErrorAction SilentlyContinue
    $DeviceGuardPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"
    If (!(Test-Path "$DeviceGuardPath\Scenarios\CredentialGuard")) {New-Item -Path "$DeviceGuardPath\Scenarios\CredentialGuard" -Force}
    New-ItemProperty -Path "$DeviceGuardPath\Scenarios\CredentialGuard" -Name "Enabled" -PropertyType "DWORD" -Value 1 -Force
    New-ItemProperty -Path "$DeviceGuardPath\Scenarios\CredentialGuard" -Name "Locked" -PropertyType "DWORD" -Value 1 -Force
    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\LSA" -Name "LsaCfgFlags" -PropertyType "DWORD" -Value 1 -Force
    if ($CGEnabled.Enabled -eq '1' -and $CGLocked.Locked -eq '1')
    {
    Write-Host "Successfully cleaned reporting values and enabled Credential Guard with UEFI-Lock in registry."
    exit 0
}
else {
    Write-Host "Failed to remediate the status of Credential Guard..."
    exit 1
}
}
catch {
Write-Error $_.Exception
exit 1
}
