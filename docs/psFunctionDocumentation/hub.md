# Functions:
- [Confirm-HubConfiguration](#Confirm-HubConfiguration)

 - [Set-HubConfiguration](#Set-HubConfiguration)



&nbsp;
&nbsp;
&nbsp;
# Confirm-HubConfiguration

## SYNOPSIS
Checks whether the needed variables have been defined as env variables

## SYNTAX

```
Confirm-HubConfiguration
```

## DESCRIPTION
Checks whether the needed variables have been defined as env variables.
This is set up to be greedy - even if not all variables are set, so long as there are no configuration errors, it will configure what it can and continue.

## EXAMPLES

### EXAMPLE 1
```
Confirm-HubConfiguration
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
# Set-HubConfiguration

## SYNOPSIS
Creates global variables for use in hub derived from environment variables defined in DattoRMM

## SYNTAX

```
Set-HubConfiguration
```

## DESCRIPTION
Creates global variables for use in hub derived from environment variables defined in DattoRMM

## EXAMPLES

### EXAMPLE 1
```
Set-HubConfiguration
```

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
