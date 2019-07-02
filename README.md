# PNC IT Hub System for Datto RMM
This is PNC IT's effort to create a system of modularized code that can be used across a variety of components within the Datto RMM system. The hope is that this will allow Datto RMM users to use tested and sophisticated code without having to repeat code within components themselves. This speeds up component development, raises the bar for what can be reasonably be accomplished in a component, and opens the possibility for a variety of tight integrations with any system with an API.
## Requirements
- Although most of the code is agnostic and can be run from any device running a Windows OS, we designed it explicitly to enhance Datto RMM environments.
- This system assumes you are running **PowerShell 5.0**. We know for sure it will fail on versions prior to 3.0, and *no attempt is made for backward compatibility*. Keep your software updated.
## What it is
Currently the PNC IT Hub System provides functions that 
- Create/Close tickets and add Time Entries in ConnectWise Manage 
  - Also allows generic GET/POST/PATCH requests to the API
- Get Device information/patch statuses and set UDFs via the Datto RMM API
  - Also allows generic GET/POST/PATCH requests to the API
- Send email messages via an Office365 Account
- Send Microsoft Teams messages

See the [Functions Documentation](https://github.com/pncit/hub/tree/master/docs/psFunctionDocumentation) to see what functions have developed and can be used.
## How it works
This is an overview; detailed instructions for setup and implementation are avaialable [here](https://github.com/pncit/hub/blob/master/docs/installationInstructions.md). 
The system essentially consists of 
1. `hubFunctions.zip`, a zip file with 
    1. `hubFunctions.psm1`, a PowerShell Module
    2. `hubFunctionsConfig.ps1protected`, an encrypted configuration file
2. `Get-HubFunctions.ps1`, a PowerShell script that you attach to your Datto RMM Components
3. A line of code in your Component:
```
.\Get-HubFunctions.ps1
``` 
that runs Get-HubFunctions.ps1, which downloads `hubFunctions.zip`, processes the contents, and makes all of the functions available to the Component.
## Deployment
See our [Installation Instructions](https://github.com/pncit/hub/blob/master/docs/installationInstructions.md)
## Repo Structure
The project is structured fairly simply at this point. There are three folders:
   - **docs** This contains documentation on installation and the individual functions available
   - **psFunctions** These are the functions that drive the components. They are divided into subfolders for better organization, and one function is defined per file with the file name repeating the function name.
   - **dattoRmm** These are the files and scripts that control deployment in Datto RMM. 
## Contributing
We would love to get feedback and contributions. If you are interested in contributing, please contact [rgg](https://success.autotask.net/t5/user/viewprofilepage/user-id/35934)
## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details

Some code is from external sources. At this point all such code was distributed with the MIT License and license details have been added to the individual files in accordance with that license.
