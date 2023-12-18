# Module: Liquit Workspace Agent

This module contains the Liquit Workspace code for deploying the Liquit Workspace Agent within an AVD host.

**Module requires the following resources:**

- Storage account for hosting the code

## How to deploy the Liquit Workspace Agent within an AVD host.

**1. Create the required storage accounts:** (See module: [Create Storage Account](https://github.com/servicesorganization/managed-cloud-hosted-desktop-and-apps/tree/main/infra-as-code/avd/modules/createStorageAccount))

**2. Copy all required files to the storage account:**

   1. Create a new  `liquit` container within the storage account
   2. Upload the `installLiquitWorkspaceAgent.ps1` PowerShell installer file to the `liquit` container
   3. Create all required `agent.xml` folders per hostpool 
   4. Adjust the `agent.xml` variables matching the customer environment configuratation and upload the `agent.xml` file to the correct hostpool folder

**3. Configure the storage account for security to only be accessibly by the AVD hosts and management endpoint(s):**
  
   1. Go to the `Networking` settings of the storage account
   2. Select `Enabled from selected virtual networks and IP addresses`
   3. Add the the `AVD subnets` to the virtual networks list
   4. Add the `IP range(s)` to allow access from the internet or your on-premises networks for management

**4. Adjust the json parameter files for the AVD pipelines:**
   
   1. Set the `customScriptExtensionCommandToExecute` variable in the json parameter file for each deployment
   2. Set the `customScriptExtensionFileUris` variable in the json parameter file for each deployment
