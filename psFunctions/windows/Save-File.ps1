function Save-File {
    <#
    .SYNOPSIS 
    Saves file to a pre-specified location

    .DESCRIPTION
    This saves a given file to the directory specified by the $global:permDir variable. If the variable is not defined, an exception is thrown. A subdirectory path may be defined.

    .PARAMETER file
    The file to save

    .PARAMETER subdir
    Subdirectory path under $global:permDir to save to

    .NOTES

    .EXAMPLE
    Save-File -file "$env:temp\permfile.txt"
    Save-File -file "$env:temp\permfile.txt" -subdir "subfolder"
    
    #>
    param(
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$file,
        
        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$subdir = $null
    )

    if ( $null -eq $global:permDir ) {
        Throw ("No permDir variable defined. Unable to save file.")
    }

    $dir = "$global:permDir\$subdir"
    
    if ((Test-Path $dir ) -eq $false ) {
        Write-Log -Message "Creating directory $dir" -EntryType "Information" -EventID 20
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }

    Copy-Item $file $dir -Force
    
}

