## All Personally-owned devices with work profile
(device.deviceOSType -eq "AndroidForWork") and (device.managementType -eq "MDM")

## All COPE Work Profile Android Enterprise
(device.enrollmentProfileName -eq "COPE Work Profile Android Enterprise")

## All Fully Managed Android Enterprise Devices
(device.deviceOSType -eq "AndroidEnterprise") -and (device.enrollmentProfileName -eq null)

## All Dedicated Devices Android Enterprise
(device.enrollmentProfileName -eq "Dedicated Devices Android Enterprise")
