#Unformatted
{id: "00000000-0000-0000-0000-000000000000", displayName: "Windows10-Compliance",…}
@odata.type: "#microsoft.graph.windows10CompliancePolicy"
deviceThreatProtectionEnabled: false
deviceThreatProtectionRequiredSecurityLevel: "unavailable"
displayName: "Windows10-Compliance"
id: "00000000-0000-0000-0000-000000000000"
osMinimumVersion: "10.0.18363.778"
passwordRequiredType: "deviceDefault"
roleScopeTagIds: ["0"]
0: "0"
scheduledActionsForRule: [{ruleName: "PasswordRequired", scheduledActionConfigurations: [,…]}]
0: {ruleName: "PasswordRequired", scheduledActionConfigurations: [,…]}
ruleName: "PasswordRequired"
scheduledActionConfigurations: [,…]
0: {actionType: "block", gracePeriodHours: 0, notificationTemplateId: "", notificationMessageCCList: []}
actionType: "block"
gracePeriodHours: 0
notificationMessageCCList: []
notificationTemplateId: ""

<# POWERSHELL #>
Install-Module -Name Microsoft.Graph.Intune
Connect-MSGraph

<# POWERSHELL #>
Install-Module -Name Microsoft.Graph.Intune -force
Import-Module -Name Microsoft.Graph.Intune -verbose
Connect-MSGraph

#Windows 10 Compliance
 $Windows10Compliance = New-IntuneDeviceCompliancePolicy `
    -windows10CompliancePolicy `
    -displayName "Windows10-Compliance" `
    -osMinimumVersion 10.0.18363.778 `
    -scheduledActionsForRule `
    (New-DeviceComplianceScheduledActionForRuleObject `
        -ruleName PasswordRequired `
        -scheduledActionConfigurations `
        (New-DeviceComplianceActionItemObject `
            -gracePeriodHours 0 `
            -actionType block `
            -notificationTemplateId "" `
        ) `
    )
