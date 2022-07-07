<# 
.DESCRIPTION
Detects if RunAsPPL is configured (Local Security Authority (LSA) protection)
RunAsPPL forces LSA to run as Protected Process Light (PPL).
If LSA isn't running as a protected process, attackers could easily abuse the low process integrity for attacks (such as Pass-the-Hash).
#>

# Collect current configured values
try {
    $LSAPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA"
    $LSAValue = (Get-ItemProperty -Path $LSAPath -Name "RunAsPPL" -ErrorAction SilentlyContinue)
    if ($LSAValue.RunAsPPL -eq '1')
{
    # Run As PPL Value in place. OK! 
    Write-Host "$LSAPath\$LSAValue is configured!"
    exit 0
}
else {
    # Remediation needed!
    Write-Host "$LSAPath\RunAsPPL not found!"
    exit 1
}
}
catch {
Write-Error $_.Exception
exit 1
}