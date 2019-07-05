function Get-InstalledSoftware {

    <#
    .SYNOPSIS 
    Returns a list of installed software without using wmi32

    .DESCRIPTION
    get-wmiobject win32_product is the natural way to get installed programs, but it has potentially disasterous side effects. When executed,
    it performs a consistency check on all software and may "reconfigure" products. This script gets a list of installed software without any
    negative/unintended side effects.

    .PARAMETER filterName
    Optional filter to apply to returned list

    .OUTPUTS
    [PSCustomObject] array

    .EXAMPLE
    $installedSoftware - Get-InstalledSoftware

    .NOTES
    This function was adapted fro a script originally authored by Boe Prox and modified by Michael McCool and sourced from https://mcpmag.com/articles/2017/07/27/gathering-installed-software-using-powershell.aspx.
    
    .LINK
    https://gregramsey.net/2012/02/20/win32_product-is-evil/
    #>

    Param ( 
        # Parameter help description
        [Parameter( Mandatory = $false )]
        [string]$filterName
    )

    #$programs = @{displayName = ;Version = ;InstallDate = ;Publisher = ;UninstallString = ;InstallLocation = ;InstallSource = ;HelpLink = ;EstimatedSizeMB = }
    $softwareList = @()

    $paths  = @( 
        "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall",
        "SOFTWARE\\Wow6432node\\Microsoft\\Windows\\CurrentVersion\\Uninstall"
    )    

    foreach ( $path in $paths ) {
        try {
            $reg = [microsoft.win32.registrykey]::OpenRemoteBaseKey( 'LocalMachine',$env:COMPUTERNAME,'Registry64' )
        } catch {
            Write-Error $_ 
            Continue   
        }
        
        #  Drill down into the Uninstall key using the OpenSubKey Method 
  
        try {  
            $regkey = $reg.OpenSubKey( $path )  
            # Retrieve an array of strings that contains all the subkey names 
            $subkeys = $regkey.GetSubKeyNames()      
            # Open each Subkey and use GetValue Method to return the required  values for each 
            ForEach ( $key in $subkeys ){   
                $thisKey = $Path+"\\"+$key 
                try {  
                    $thisSubKey = $reg.OpenSubKey( $thisKey )   
                    # Prevent Objects with empty displayName 
                    $displayName =  $thisSubKey.getValue( "displayName" )
                    if ( $displayName -notlike $filterName -and $PSBoundParameters.ContainsKey( 'filterName' ) ) {
                        $displayName = $null
                    }
                    if ( $displayName -and $displayName -notmatch '^Update for|rollup|^Security Update|^Service Pack|^HotFix' ) {
                        $date = $thisSubKey.GetValue( 'InstallDate' )
                        if ( $date ) {
                            try {
                                $date = [datetime]::ParseExact( $date, 'yyyyMMdd', $Null )
                            } 
                            catch{
                                Write-Warning "$( $Computer ): $_ <$( $date )>"
                                $date = $Null
                            }
                        } 

                        $publisher = try {
                            $thisSubKey.GetValue( 'Publisher' ).Trim()
                        } catch {
                            $thisSubKey.GetValue( 'Publisher' )
                        }

                        $version = try {
                            #Some weirdness with trailing [char]0 on some strings
                            $thisSubKey.GetValue( 'DisplayVersion' ).TrimEnd( ( [char[]]( 32,0 ) ) )
                        } catch {
                            $thisSubKey.GetValue( 'DisplayVersion' )
                        }

                        $uninstallString = try {
                            $thisSubKey.GetValue( 'UninstallString' ).Trim()
                        } catch {
                            $thisSubKey.GetValue( 'UninstallString' )
                        }

                        $installLocation = try {
                            $thisSubKey.GetValue( 'InstallLocation' ).Trim()
                        } catch {
                            $thisSubKey.GetValue( 'InstallLocation' )
                        }

                        $installSource = try {
                            $thisSubKey.GetValue( 'InstallSource' ).Trim()
                        } catch {
                            $thisSubKey.GetValue( 'InstallSource' )
                        }

                        $helpLink = try {
                            $thisSubKey.GetValue( 'HelpLink' ).Trim()
                        } catch {
                            $thisSubKey.GetValue( 'HelpLink' )
                        }
                        
                        $object = [PSCustomObject]@{ 
                            displayName = $displayName
                            version  = $version
                            installDate = $date
                            publisher = $publisher
                            uninstallString = $uninstallString
                            installLocation = $installLocation
                            installSource  = $installSource
                            helpLink = $helpLink
                            estimatedSizeMB = [decimal]( [math]::Round( ( $thisSubKey.GetValue( 'EstimatedSize' )*1024 )/1MB,2 ) )
                        }
                        $softwareList +=  $object
                    }
                } catch {
                    Write-Warning "$Key : $_"
                }
            }
        } catch  {}
        $reg.Close() 
    }
    return $softwareList
}