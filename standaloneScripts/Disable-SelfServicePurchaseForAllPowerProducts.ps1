Connect-Keeper 
Sync-Keeper

if (Get-Module -ListAvailable -Name "MSCommerce" ) {
    Import-Module -Name MSCommerce
} else {
    Install-Module -Name MSCommerce
    Import-Module -Name MSCommerce
}

$clientsToDisable = @('AMFM','AXS','BBMD','GMG','KDC','NNAI','NTC','OFP','PENT','PES','PIM','RHW','SCC','SCK','SDC','TBMD','USFM')
$clientsToDisable = @('AMFM','PENT','PES','RHW','SCK','SDC','USFM')

$clients = Get-KeeperChildItems -Path '\Clients'
foreach ( $client in $clients ) {
    $admin = $null
    $acronym = $client.Name.Substring( 0 , $client.Name.indexOf(" ") )
    if ( $clientsToDisable -contains $acronym ) {
        write-host "\Clients\$($client.Name)"
        Set-KeeperLocation -Path "\Clients\$($client.Name)"
        $records = Get-KeeperChildItems
        foreach ( $record in $records ) {
            if ( $record.name -match "Office 365 Admin" ) {
                $admin = Get-KeeperRecords -Uid $record.uid -ShowPassword
            }
        }
        if ( $null -eq $admin ) {
            Write-Warning "Unable to find admin record for $($client.Name)"
        } else {
            write-host $admin.login
            write-host $admin.password
            Connect-MSCommerce
            Get-MSCommerceProductPolicies -PolicyId AllowSelfServicePurchase | Where { $_.PolicyValue -eq “Enabled”} | forEach { 
                Update-MSCommerceProductPolicy -PolicyId AllowSelfServicePurchase -ProductId $_.ProductID -Enabled $false  
            }
        }
    }
}