<# 
.DESCRIPTION
Remediates 'Local Security Authority (LSA) protection'
Forces LSA to run as Protected Process Light (PPL).
If LSA isn't running as a protected process, attackers could easily abuse the low process integrity for attacks (such as Pass-the-Hash).
#>

try
{
    $LSAPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA"
    New-ItemProperty -Path $LSAPath -Name "RunAsPPL" -PropertyType "DWORD" -Value 1 -Force
    exit 0
else {
    Write-Host "Failed to remediate RunAsPPL at $LSAPath"
    exit 1
}
}
catch {
Write-Error $_.Exception
exit 1
}