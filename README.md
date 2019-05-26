# PNC IT Hub System for Datto RMM
This is PNC IT's effort to create a system of modularized code that can be used across a variety of components within the Datto RMM system. The hope is that this will allow Datto RMM users to use tested and sophisticated code without having to repeat code within components themselves. This speeds up component development, raises the bar for what can be reasonably be accomplished in a component, and opens the possibility for a variety of tight integrations with other systems.
## Requirements
This system assumes you are running **PowerShell 5.0**. We know for sure it will fail on versions prior to 3.0, and *no attempt is made for backward compatibility*.
## System Overview
The idea is limit code duplication and, as much as possible, allow components to inherit bug fixes and enhancements over time without modifying those components themselves. To this end, within Datto you need only attach one file and add one line of code to a component to give it access to all of the functions in the project. We have abstracted as much as we can from that file so that system changes should almost never necessitate updating all of the components that are using it. 
### The three files
In a live environment, three files and one line of code enable you to include a limitless number of functions within your components - including bug fixes and enhancements. The three files are:
#### hubFunctions.psm1.zip
This is a PowerShell module with all of the funcitons defined. It is compiled out of the functions in the folder (and subfolders under) `/functions`.
#### hubFunctionsConfig.ps1.AES
This is a configuration file that defines a variety of PowerShell variables. It can include very sensitive information, such as passwords, non-public webhooks, and API keys. For this reason, it is encrypted (the code to encrypt and decrypt this file is included in this project and can be updated over time as cryptography technology changes).
#### Get-HubFunctions.ps1
This is the file you attach to your components. It contains the code necessary to download and import `hubFunctions.psm1` and download, decrypt, and include `hubFunctionsConfig.ps1.AES` so that by running it within your component you are, in one line, defining dozens of functions and making any number of configuration settings and constants available to you.
### Notes
- Two things are static (or at least cumbersome to change):
1. The names and location of files that are served on a web server
2. The encryption key used to encrypt sensitive information in files stored on a web server
- There are security concerns. `hubFunctionsConfig.ps1.AES` is encrypted, but where do you store the key so that your component can use it? We have anticipated three options (detailed later under Deployment>Environment Configuration>Encryption key value (3 options)).
- The project is structured fairly simply at this point. There are three folders:
1. **functions** These are the functions that drive the COMs. They are divided into subfolders for better organization, and one functions is defined per file with the file name repeating the function name.
2. **control** These are the files and scripts that control deployment.
## Deployment
In order to get a copy of the project running on your own machine for development, you simply have to clone this repo. It consists almost exclusively of powershell files, and the individual functions can be read, modified, and tested as is. See deployment for notes on how to deploy the project in your Datto environment for live use.

In order to deploy this in your Datto environment, follow these steps. All PS commands as written should be run from the top of the repo
### Starting Out
The first time you use this system you need to create some files excluded from the repo for security reasons. This only has to be repeated if your encryption key is comprimised or if there is a change to the ".\control\protected\Get-HubFunctions.ps1" file, which will always be avoided when possible.
```
. ".\functions\cryptography\New-CryptographyKey.ps1"
New-CryptographyKey -AsPlainText | Set-Content ".\control\protected\encryptionKey.AES"
Copy-Item ".\control\templates\hubFunctionsConfig.ps1" ".\control\protected\hubFunctionsConfig.ps1"
Copy-Item ".\control\templates\Get-HubFunctions.ps1" ".\control\protected\Get-HubFunctions.ps1"
```
### Building the functions module
When your environment is first set up and whenever updates are made within the /functions folder, the functions module will need to be rebuilt.
```
.\control\Build-HubFunctions.ps1
```
This will create two files - `.\control\protected\hubFunctions.psm1` and `.\control\protected\hubFunctions.psm1.zip`
### Environment configurations
You need to establish a few fixed facts about your live environment. These settings are hard to change later, because that will require changing all COMs that use this system. When first deploying the system, define the following variables in `.\control\protected\Get-HubFunctions.ps1`. Put serious thought into this - making changes down the road may be difficult, as you will have to change the Get-HubFunctions.ps1 file attached to every component that uses it.
#### Location of function definitions
```
$hubFunctionsSource = "https://example.com/hubFunctions.psm1.zip"
```
This is the web location of `hubFunctions.psm1.zip` (will be created later)
#### Location of encrypted config file
```
$hubFunctionsConfigSource = "https://example.com/hubFunctionsConfig.ps1.AES"
```
This is the web location of `hubFunctionsConfig.ps1.AES` (will be created later)
#### Encryption key value (3 options)
```
$hubFunctionsConfigSourceKey = "JRLC07qB2x4M7xuU9vog4xcxsj2Ffia/zM2K17/u3N4="
```
This is simple, but storing the encryption key in plaintext in Get-HubFunctions.ps1 is not ideal. Although we expect temporary files to be deleted after a component runs, it cannot be guaranteed that a key will never be left on a device. 
```
$hubFunctionsConfigSourceKey = $env:encryptionKey
```
With this method, when creating a com, you can add a component variable with the value of the encryption key. This prevents the value from ever being written on a client device, temporarily or otherwise. *However*, if this method is used on a component monitor, all defined variable values will be included in alert descriptions.
```
$hubFunctionsConfigSourceKey = $env:udf_30
```
With this method, the encryption key is stored in udf30 for every device in the account. This value will never be written anywhere, but will be visible to anyone who can view udf values. If using this mehod, you can update all udfs at any time with the command
```
.\control\Set-EncryptionKeyUdf.ps1
```
### Encrypting the config file
`hubFunctionsConfig.ps1` stores all configuration settings by simply defining a set of variables. When your environment is first set up and whenever updates are made to `hubFunctionsConfig.ps1`, it needs to be encrypted. This config file is expected to contain API keys, passwords, and any manner of private data.
```
.\control\Build-ProtectedhubFunctionsConfig.ps1 
```
### Uploading files to a web server
New versions of `.\control\protected\hubFunctionsConfig.ps1.AES` and `.\control\protected\hubFunctions.psm1.zip` should be copied to your web server at locations and with names that match your settings in `.\control\protected\Get-HubFunctions.ps1`
## Using the system within a COM
Using the system within a COM is a two-step process. After this is done, all functions defined in /functions will be available for use, as will all variables defined in your config file :
1. Attach `Get-HubFunctions.ps1` to any PowerShell COM
2. Add the following line to the COM script, ideally at the beginning
```
.\Get-HubFunctions.ps1
```
## Contributing
We would love to get feedback and contributions. If you are interested in contributing, please contact [rgg](https://success.autotask.net/t5/user/viewprofilepage/user-id/35934)
## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details
