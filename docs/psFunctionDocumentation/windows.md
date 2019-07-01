# Functions:
- [Test-ModuleDataSecurity](#Test-ModuleDataSecurity)

 - [Test-PendingReboot](#Test-PendingReboot)

 - [Test-RegistryKeyValueData](#Test-RegistryKeyValueData)

 - [Write-Log](#Write-Log)



&nbsp;
&nbsp;
&nbsp;
# Test-ModuleDataSecurity

## SYNOPSIS
Checks whether module logging is turned on and exits if so

## SYNTAX

```
Test-ModuleDataSecurity
```

## DESCRIPTION
If module logging is enabled, private data may be written to the windows event log.
This function checks for whether logging is enabled and exits if it is.

## EXAMPLES

### EXAMPLE 1
```
$moduleDataSecure = Test-ModuleDataSecurity
```

## PARAMETERS

## INPUTS

## OUTPUTS

### [Boolean]
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Test-PendingReboot

## SYNOPSIS
Test the pending reboot status on a local and/or remote computer.

## SYNTAX

```
Test-PendingReboot [[-ComputerName] <String[]>] [-Credential <PSCredential>] [-Detailed]
 [-SkipConfigurationManagerClientCheck] [-SkipPendingFileRenameOperationsCheck] [<CommonParameters>]
```

## DESCRIPTION
This function will query the registry on a local and/or remote computer and determine if the
system is pending a reboot, from Microsoft/Windows updates, Configuration Manager Client SDK, Pending
Computer Rename, Domain Join, Pending File Rename Operations and Component Based Servicing.

ComponentBasedServicing = Component Based Servicing
WindowsUpdate = Windows Update / Auto Update
CCMClientSDK = SCCM 2012 Clients only (DetermineifRebootPending method) otherwise $null value
PendingComputerRenameDomainJoin = Detects a pending computer rename and/or pending domain join
PendingFileRenameOperations = PendingFileRenameOperations, when this property returns true,
                              it can be a false positive
PendingFileRenameOperationsValue = PendingFilerenameOperations registry value; used to filter if need be,
                                   Anti-Virus will leverage this key property for def/dat removal,
                                   giving a false positive

## EXAMPLES

### EXAMPLE 1
```
Test-PendingReboot
```

ComputerName IsRebootPending
------------ ---------------
WKS01                   True

This example returns the ComputerName and IsRebootPending properties.

### EXAMPLE 2
```
(Test-PendingReboot).IsRebootPending
```

True

This example will return a bool value based on the pending reboot test for the local computer.

### EXAMPLE 3
```
Test-PendingReboot -ComputerName DC01 -Detailed
```

ComputerName                     : dc01
ComponentBasedServicing          : True
PendingComputerRenameDomainJoin  : False
PendingFileRenameOperations      : False
PendingFileRenameOperationsValue :
SystemCenterConfigManager        : False
WindowsUpdateAutoUpdate          : True
IsRebootPending                  : True

This example will test the pending reboot status for dc01, providing detailed information

### EXAMPLE 4
```
Test-PendingReboot -ComputerName DC01 -SkipConfigurationManagerClientCheck -SkipPendingFileRenameOperationsCheck -Detailed
```

CommputerName                    : dc01
ComponentBasedServicing          : True
PendingComputerRenameDomainJoin  : False
PendingFileRenameOperations      : False
PendingFileRenameOperationsValue :
SystemCenterConfigManager        :
WindowsUpdateAutoUpdate          : True
IsRebootPending                  : True

## PARAMETERS

### -ComputerName
A single computer name or an array of computer names. 
The default is localhost ($env:COMPUTERNAME).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: CN, Computer

Required: False
Position: 1
Default value: $env:COMPUTERNAME
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.
Type a username, such as User01, Domain01\User01, or User@Contoso.com.
Or, enter a PSCredential object,
such as an object that is returned by the Get-Credential cmdlet.
When you type a user name, you are
prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Detailed
Indicates that this function returns a detailed result of pending reboot information, why the system is
pending a reboot, not just a true/false response.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipConfigurationManagerClientCheck
Indicates that this function will not test the Client SDK WMI class that is provided by the System
Center Configuration Manager Client. 
This parameter is useful when SCCM is not used/installed on
the targeted systems.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipPendingFileRenameOperationsCheck
Indicates that this function will not test the PendingFileRenameOperations MultiValue String property
of the Session Manager registry key. 
This parameter is useful for eliminating possible false positives.
Many Anti-Virus packages will use the PendingFileRenameOperations MultiString Value in order to remove
stale definitions and/or .dat files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author:  Brian Wilhite
Email:   bcwilhite (at) live.com
Source: https://github.com/bcwilhite/PendingReboot

MIT License

Copyright (c) 2018 Brian Wilhite

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## RELATED LINKS

[Background:
https://blogs.technet.microsoft.com/heyscriptingguy/2013/06/10/determine-pending-reboot-statuspowershell-style-part-1/
https://blogs.technet.microsoft.com/heyscriptingguy/2013/06/11/determine-pending-reboot-statuspowershell-style-part-2/

Component-Based Servicing:
http://technet.microsoft.com/en-us/library/cc756291(v=WS.10).aspx

PendingFileRename/Auto Update:
http://support.microsoft.com/kb/2723674
http://technet.microsoft.com/en-us/library/cc960241.aspx
http://blogs.msdn.com/b/hansr/archive/2006/02/17/patchreboot.aspx

CCM_ClientSDK:
http://msdn.microsoft.com/en-us/library/jj902723.aspx](Background:
https://blogs.technet.microsoft.com/heyscriptingguy/2013/06/10/determine-pending-reboot-statuspowershell-style-part-1/
https://blogs.technet.microsoft.com/heyscriptingguy/2013/06/11/determine-pending-reboot-statuspowershell-style-part-2/

Component-Based Servicing:
http://technet.microsoft.com/en-us/library/cc756291(v=WS.10).aspx

PendingFileRename/Auto Update:
http://support.microsoft.com/kb/2723674
http://technet.microsoft.com/en-us/library/cc960241.aspx
http://blogs.msdn.com/b/hansr/archive/2006/02/17/patchreboot.aspx

CCM_ClientSDK:
http://msdn.microsoft.com/en-us/library/jj902723.aspx)


&nbsp;
&nbsp;
&nbsp;
# Test-RegistryKeyValueData

## SYNOPSIS
Tests the value of a registry key

## SYNTAX

```
Test-RegistryKeyValueData [-Key] <String> [-Value] <String> [-TestValueData] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns true if a registry value exists and matches the given value.
Otherwise, returns false.

## EXAMPLES

### EXAMPLE 1
```
Test-registryentry -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging' -key 'EnableModuleLogging' -value '1'
```

## PARAMETERS

### -Key
Registry key to look in

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
Value to check (must be a string.
If not, this function will return $false)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestValueData
Value data to compare to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [Boolean]
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Write-Log

## SYNOPSIS
Writes to the event log and the Datto RMM stdout window.

## SYNTAX

```
Write-Log [-message] <String> [-entryType] <String> [[-eventID] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Creates a Weindows event event log source "Datto RMM" and writes log messages to that log.
Simultaneously writes to stdout.

## EXAMPLES

### EXAMPLE 1
```
Write-Log -Message "This is a log message`nThat spans two lines" -EntryType "Information" -EventID 10
```

This example writes an information message to the event log and puts the same text into the stdout so it is viewable from within the Datto RMM interface

## PARAMETERS

### -message
The text to write to the event log and stdout

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entryType
The event log entry type.
Must be "Information", "Warning", or "Error"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -eventID
The event log event id (default = 20).
0 = Adding Windows Eventlog source, 10 = Global Functions, 20 = Script components

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 20
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
