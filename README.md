# PNC IT Hub System for Datto RMM
This is PNC IT's effort to create a system of modularized code that can be used across a variety of components within the Datto RMM system. The hope is that this will allow Datto RMM users to use tested and sophisticated code without having to repeat code within components themselves. This speeds up component development, raises the bar for what can be reasonably be accomplished in a component, and opens the possibility for a variety of tight integrations with other systems.
## Requirements
This system assumes you are running **PowerShell 5.0**. We know for sure it will fail on versions prior to 3.0, and *no attempt is made for backward compatibility*. Keep your software updated.
## System Overview
The idea is limit code duplication and, as much as possible, allow components to inherit bug fixes and enhancements over time without modifying those components themselves. To this end, within Datto you need only attach one file and add one line of code to a component to give it access to all of the functions in the project. This means that with one line in your component, you have access to an unlimited number of functions that may perform complex operations and facilitate integrations with any system that has an API.
We have abstracted as much as we can from that file so that system changes should almost never necessitate updating all of the components that are using it. 
### The three files
In a live environment, three files and one line of code enable you to include a limitless number of functions within your components - including bug fixes and enhancements. The three files are:
#### hubFunctions.psm1.zip
This is a PowerShell module with all of the functions defined. It is compiled out of the functions in the folder (and subfolders under) `/functions`.
#### hubFunctionsConfig.ps1.AES
This is a configuration file that defines a variety of PowerShell variables. It can include sensitive information, such as passwords, non-public webhooks, and API keys. For this reason, it is encrypted (the code to encrypt and decrypt this file is included in this project and can be updated as cryptography technology changes).
#### Get-HubFunctions.ps1
This is the file you attach to your components. It contains the code necessary to download and import `hubFunctions.psm1` and download, decrypt, and include `hubFunctionsConfig.ps1.AES` so that by running it within your component you are, in one line, defining dozens of functions and making any number of configuration settings and constants available to you.
### Notes
1. Two things are static (or at least cumbersome to change):
- The names and location of files that are served on a web server
- Anything done by or defined in Get-HubFunctions.ps1
2. There are security concerns. `hubFunctionsConfig.ps1.AES` is encrypted, but where do you store the key so that your component can use it? We have anticipated three options (detailed later under Deployment>Environment Configuration>Encryption key value (3 options)).
3. The project is structured fairly simply at this point. There are three folders:
- **functions** These are the functions that drive the components. They are divided into subfolders for better organization, and one functions is defined per file with the file name repeating the function name.
- **dattoRmm** These are the files and scripts that control deployment in Datto RMM.
- **scripts** These are scripts that leverage the functions defined under **functions**. In Datto RMM, these form the 'script' portion of custom Components.
## Contributing
We would love to get feedback and contributions. If you are interested in contributing, please contact [rgg](https://success.autotask.net/t5/user/viewprofilepage/user-id/35934)
## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details
