<#

.DESCRIPTION
Intune Remediation that remediates missing Credential Guard configuration and additional MDM-registry cleanup for correct Intune-reporting.
Based on: https://docs.microsoft.com/en-us/windows/security/threat-protection/device-guard/enable-virtualization-based-protection-of-code-integrity#securityservicesconfigured
Removes reporting values for Intune, then adds required Credential Guard configuration (UEFI-Lock Enabled).

#>
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
    exit 0
else {
    Write-Host "Failed to remediate the status of Credential Guard..."
    exit 1
}
}
catch {
Write-Error $_.Exception
exit 1
}
