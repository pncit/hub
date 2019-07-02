function Get-CustomUdf {
    <#
    .SYNOPSIS 
    Gets a custom udf value for the current device

    .PARAMETER udf
    Custom udf to get value of (1-30)

    .OUTPUTS
    [String] udf value

    .EXAMPLE
    $value = Get-CustomUdf 26

    .NOTES
    #>

    Param(
    
    [Parameter(Mandatory=$true,Position=0)]
    [validateNotNullOrEmpty()]
    [int]$udf

    )

    $value = Get-ChildItem -Path Env:* | Where-Object { $_.Name.ToLower() -eq "udf_$udf" } | Select-Object -ExpandProperty Value
    return $value
}