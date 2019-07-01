# Using the PNC IT Hub System in your Datto RMM Environment
## Requirements
This system assumes you are running **PowerShell 5.0**. We know for sure it will fail on versions prior to 3.0, and *no attempt is made for backward compatibility*.
## Deployment
All PS commands as written below should be executed from the top of the repo
### Starting Out
The first time you use this system you need to create some files excluded from the repo for security reasons. This only has to be repeated if your encryption key is compromised or if there is a change to the ".\dattoRmm\protected\Get-HubFunctions.ps1" file, which will always be avoided when possible.
```
#create a protected directory excluded from the GitHub repo
New-Item ".\dattoRmm\protected" -ItemType directory 
New-Item ".\dattoRmm\protected\.gitignore" -ItemType File -Value "#ignore everything`n*"
#copy the templates over
Copy-Item ".\dattoRmm\templates\hubFunctionsConfig.ps1" ".\dattoRmm\protected\hubFunctionsConfig.ps1"
Copy-Item ".\dattoRmm\templates\Get-HubFunctions.ps1" ".\dattoRmm\protected\Get-HubFunctions.ps1"
#create an encryption key
. ".\functions\cryptography\New-CryptographyKey.ps1"
New-CryptographyKey -AsPlainText | Set-Content ".\dattoRmm\protected\encryptionKey.AES"
```
### Environment configurations
You need to establish a few fixed facts about your live environment. These settings are hard to change later, because that will require changing all components that use this system. When first deploying the system, define the following variables in `.\dattoRmm\protected\Get-HubFunctions.ps1`. Put serious thought into this - making changes down the road may be difficult, as you will have to change the Get-HubFunctions.ps1 file attached to every component that uses it.
#### Location of hub function data
```
$hubFunctionsSource = "https://example.com/hubFunctions.zip"
```
This is the web location of `hubFunctions.zip` (will be created later)
#### Encryption key value (3 options)
The configuration file (`.\dattoRmm\protected\hubFunctionsConfig.ps1`, which will be set up later) is expected to contain API keys, passwords, and any manner of private data. It needs to be publicly available so that Datto RMM components can download it, but it needs to be protected via encryption. The question then is where/how to store the encryption key.
##### Option 1
```
$hubFunctionsConfigSourceKey = "JRLC07qB2x4M7xuU9vog4xcxsj2Ffia/zM2K17/u3N4="
```
This is simple, but storing the encryption key in plaintext in Get-HubFunctions.ps1 is not ideal. Although we expect temporary files to be deleted after a component runs, it cannot be guaranteed that a key will never be left on a device. In addition, if the key is compromised and has to be changed, all components will have to be updated with a new version of `Get-HubFunctions.ps1`.
##### Option 2
```
$hubFunctionsConfigSourceKey = $env:encryptionKey
```
With this method, when creating a component, you can add a component variable with the value of the encryption key. This prevents the value from ever being written on a client device, temporarily or otherwise. *However*, if this method is used on a component monitor, all defined variable values will be included in alert descriptions. In addition, if the key is compromised and has to be changed, all components will have to be updated.
##### Option 3
```
$hubFunctionsConfigSourceKey = $env:udf_30
```
With this method, the encryption key is stored in udf30 for every device in the account. This value will never be written anywhere, but will be visible to anyone who can view udf values. In addition, you will need to define it for every new device. 
If using this mehod, you can update all udfs at any time (whether they are online or not) with the command
```
.\dattoRmm\Set-EncryptionKeyUdf.ps1
```
### Setting up the config file
`.\dattoRmm\protected\hubFunctionsConfig.ps1` needs to be updated to match your tools and environment. Sample values are included. If you do not use a particular integration, you do not need to define those variables.
### Building your deployment
When your environment is first set up and whenever updates are made within the /functions folder or to your config file, you need to rebuild by running
```
.\dattoRmm\Build-HubFunctions.ps1
```
This will create three files - `.\dattoRmm\protected\hubFunctions.psm1`, `.\dattoRmm\protected\hubFunctionsConfig.ps1.AES`, and `.\dattoRmm\protected\hubFunctions.zip` (the zip file contains the other two). Put `.\dattoRmm\protected\hubFunctions.zip` into the location you set via `$hubFunctionsSource` in `.\dattoRmm\protected\Get-HubFunctions.ps1`
## Using the system within a component
Using the system within a component is a two-step process. After this is done, all functions defined in /functions will be available for use, as will all variables defined in your config file :
1. Attach `Get-HubFunctions.ps1` to any PowerShell component
2. Add the following line to the component script, ideally at the beginning
```
.\Get-HubFunctions.ps1
```
## Updating After Deployment
If you make changes to any functions or the config file, you will need to rerun
```
.\dattoRmm\Build-HubFunctions.ps1
```
and re-upload the newly generated `.\dattoRmm\protected\hubFunctions.zip` into the location you set via `$hubFunctionsSource` in `.\dattoRmm\protected\Get-HubFunctions.ps1`