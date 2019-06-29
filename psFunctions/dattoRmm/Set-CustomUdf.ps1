function Set-CustomUdf {
    <#
    .SYNOPSIS 
    Writes a value to a Datto RMM Custom UDF

    .DESCRIPTION
    Writes a specified value to a specified Datto RMM Custom UDF via the registry

    .PARAMETER Udf
    UDF to write to (1-30)

    .PARAMETER Value
    Value to write

    .EXAMPLE
    Set-CustomUdf -customUdf 22 -value 'Complete'
    #>
    param (
        [parameter(Mandatory=$true)]
        [ValidateRange(1,30)]
        [int32]$udf,
        
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]
        $Value
    )

    Set-ItemProperty -Path HKLM:\SOFTWARE\CentraStage -Name Custom$udf  -Value $Value

}