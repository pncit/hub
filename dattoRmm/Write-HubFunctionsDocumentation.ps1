#generate md formatted documentation from powershell code
#utilizes platyPS
#https://github.com/PowerShell/platyPS

Install-Module -Name platyPS -Scope CurrentUser
Import-Module platyPS
. .\dattoRmm\Update-HubFunctions.ps1
Update-HubFunctions
Remove-Item –path .\docs\functionDocumentation\* -Include *.md
New-MarkdownHelp -Module hubFunctions -OutputFolder '.\docs\functionDocumentation' -Force
Get-ChildItem '.\docs\functionDocumentation' *-*md | Get-Content | Set-Content '.\docs\functionDocumentation\README.md' -Force
