<#
Enter your TenantId
Install-Module MSAL.PS 
Authenticate to Tenant 
#>

$authParams = @{
    ClientId    = 'd1ddf0e4-d672-4dae-b554-9d5bdfd93547'
    TenantId    = '...onmicrosoft.com'
    DeviceCode  = $true
}
$authToken = Get-MsalToken @authParams

############## Corporate ##############

#All Windows Virtual Machines
$filter = @{
    displayName = 'Windows Virtual Machines'
    description = 'Windows Virtual Machines'
    platform    = 'Windows10AndLater'
    rule        = '(device.deviceOwnership -eq "Corporate") and (device.model -startsWith "Virtual Machine")'
} | ConvertTo-Json -Depth 10

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams

#All Corporate Windows
$filter = @{
    displayName = 'Windows Corporate Devices'
    description = 'Corporate Windows Devices'
    platform    = 'Windows10AndLater'
    rule        = '(device.deviceOwnership -eq "Corporate")'
} | ConvertTo-Json -Depth 10

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams

#All Corporate iOS/iPadOS 
$filter = @{
    displayName = 'iOS/iPadOS Corporate Devices'
    description = 'Corporate iOS/iPad OS Devices'
    platform    = 'iOS'
    rule        = '(device.deviceOwnership -eq "Corporate")'
} | ConvertTo-Json -Depth 10

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams

#All Corporate Android Enterprise
$filter = @{
    displayName = "Android Enterprise Corporate Devices"
    description = "Corporate Android Enterprise Devices"
    platform = "androidForWork"
    rule = '(device.deviceOwnership -eq "Corporate")'
} | ConvertTo-Json -Depth 10

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams

#All Azure Virtual Desktop
$filter = @{
    displayName = "Azure Virtual Desktop"
    description = "Azure Virtual Desktop"
    platform = "windows10AndLater"
    rule = '(device.operatingSystemSKU -eq "ServerRdsh")'
} | ConvertTo-Json -Depth 10  

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams

#All Cloud PCs
$filter = @{
    displayName = "Cloud PCs"
    description = "Cloud PCs"
    platform = "windows10AndLater"
    rule = '(device.model -contains "CloudPC") or (device.model -contains "Cloud PC")'
} | ConvertTo-Json -Depth 10  

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams

############## Personal ##############

#All Personal Windows 10
$filter = @{
    displayName = "Windows Personal Devices"
    description = "Personal Windows Devices"
    platform = "windows10AndLater"
    rule = '(device.deviceOwnership -eq "Personal")'
} | ConvertTo-Json -Depth 10  

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams

#All Personal iOS/iPadOS 
$filter = @{
    displayName = "iOS/iPadOS Personal Devices"
    description = "Personal iOS/iPad OS Devices"
    platform = "iOS"
    rule = '(device.deviceOwnership -eq "Personal")'
} | ConvertTo-Json -Depth 10  

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams

#Personal Android for Enterprise
$filter = @{
    displayName = "Android Enterprise Personal Devices"
    description = "Personal Android Enterprise Devices"
    platform = "androidForWork"
    rule = '(device.deviceOwnership -eq "Personal")'
} | ConvertTo-Json -Depth 10  

#Post
$baseGraphUri = 'https://graph.microsoft.com/beta/deviceManagement/assignmentFilters'
$graphParams = @{
    Method          = 'Post'
    Uri             = $baseGraphUri
    Authentication  = 'OAuth'
    Token           = $authToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force
    ContentType     = 'Application/Json'
    Body            = $filter
}
Invoke-RestMethod @graphParams
