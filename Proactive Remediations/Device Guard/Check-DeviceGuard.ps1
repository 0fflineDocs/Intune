<#

.DESCRIPTION
Proactive Remediation detection that checks if Credential Guard is configured and or running in the endpoint.
Based on: https://docs.microsoft.com/en-us/windows/security/threat-protection/device-guard/enable-virtualization-based-protection-of-code-integrity#securityservicesconfigured

#>

# Verify pre-requisite winrm is running for the DeviceGuard cmdlet, then collect values.
$WinRM = (Get-Service -Name WinRM) 
if ($WinRM.Status -ne "Running") {Start-Service -Name WinRM}
$DGStatus = (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard)

# Pre-defined strings for configured values
$CGConfigured = "Credential Guard is configured."
$HVCIConfigured = "Hypervisor Code Integrity is configured."
$SGSLConfigured = "System Guard Secure Launch is configured."
$SMMFConfigured = "SMM Firmware Measurement is configured."

# Collect current configured values
try {
    if ($DGStatus.SecurityServicesConfigured -contains 1){$DGConfigured = $CGConfigured}
    if ($DGStatus.SecurityServicesConfigured -contains 2){$DGConfigured = $HVCIConfigured}
    if ($DGStatus.SecurityServicesConfigured -contains 3){$DGConfigured = $SGSLConfigured}
    if ($DGStatus.SecurityServicesConfigured -contains 4){$DGConfigured = $SMMFConfigured}
    }
catch [System.Exception] 
{
    Write-Warning "Failed to check configuration status of Device Guard..."
    exit 1
}
catch {
Write-Error $_.Exception 
exit 1
}

# Pre-defined strings for running values
$CGRunning = "Credential Guard is running."
$HVCIRunning = "Hypervisor Code Integrity is running."
$SGSLRunning = "System Guard Secure Launch is running."
$SMMFRunning = "SMM Firmware Measurement is running."

# Collect current running values
try {
    if ($DGStatus.SecurityServicesRunning -contains 1){$DGRunning = $CGRunning}
    if ($DGStatus.SecurityServicesRunning -contains 2){$DGRunning = $HVCIRunning}
    if ($DGStatus.SecurityServicesRunning -contains 3){$DGRunning = $SGSLRunning}
    if ($DGStatus.SecurityServicesRunning -contains 4){$DGRunning = $SMMFRunning}
    }
catch [System.Exception] 
{
    Write-Warning "Failed to check running status of Device Guard..."
    exit 1
}
catch {
Write-Error $_.Exception 
exit 1
}

Write-Host $DGConfigured, $DGRunning
