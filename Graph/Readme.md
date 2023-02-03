# Graph Explorer: https://developer.microsoft.com/en-us/graph/graph-explorer
# Docs: https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/intune_graph_overview
# Docs Beta: https://developer.microsoft.com/en-us/graph/docs/api-reference/beta/resources/intune_graph_overview

# Devices Overview
https://graph.microsoft.com/V1.0/devicemanagement/manageddeviceoverview

# Intune App-Protection Policies
https://graph.microsoft.com/V1.0/deviceAppManagement/managedAppPolicies

# List Apps
https://graph.microsoft.com/V1.0/deviceAppManagement/mobileApps
https://graph.microsoft.com/V1.0/deviceAppManagement/mobileApps?$select=Displayname

# Get all Device Configuration IDs
https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations?$select=id,displayName

# For Each ID get all  Assignments based on ID
https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations/[ID]/assignments

# App Protection / App Configuration policies
https://graph.microsoft.com/beta/deviceAppManagement/managedAppPolicies

# All Compliance Policies
https://graph.microsoft.com/beta/deviceManagement/managedDevices/[ID]/deviceCompliancePolicyStates

# Specific Compliance policy and it's settings
https://graph.microsoft.com/beta/deviceManagement/managedDevices/[ID]/deviceCompliancePolicyStates/[Compliance-ID]/settingStates

# Get all Intune Roles
https://graph.microsoft.com/beta/roleManagement/deviceManagement/roleDefinitions?$select=id,displayName,isBuiltIn

# Get all Intune Role Assignments
https://graph.microsoft.com/beta/deviceManagement/roleDefinitions('[id]')?$expand=roleassignments
