#generate md formatted documentation from powershell code
#utilizes platyPS
#https://github.com/PowerShell/platyPS

Install-Module -Name platyPS -Scope CurrentUser
Import-Module platyPS
. .\dattoRmm\Update-HubFunctions.ps1
Update-HubFunctions
Remove-Item –path .\docs\* -Include *.md -Exclude installationInstructions.md
New-MarkdownHelp -Module hubFunctions -OutputFolder '.\docs' -Force
Get-ChildItem '.\docs' *-*md | Get-Content | Set-Content '.\docs\functionDocumentation.md' -Force
Remove-Item –path .\docs\* -Include *.md -Exclude functionDocumentation.md