function Send-Office365MailMessage {
    <#
    .SYNOPSIS 
    Posts a message via o365 email

    .DESCRIPTION
    Sends an email from an Office365 account with HTML-encoded message content.

    .PARAMETER From
    Email address to send from

    .PARAMETER Credential
    Credential object containing credentials for $o365Account

    .PARAMETER To
    Email address to send to

    .PARAMETER Subject
    Email subject

    .PARAMETER BodyAsHtml
    Message (as html)
    #>
    
    param(
        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$From = $O365Account,

        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [PSCredential]$Credential = $o365AccountCredential,
        
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$To,

        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$Subject,

        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$BodyAsHtml
    )

    $o365SmtpServer = "smtp.office365.com"
    $o365SmtpPort = "587"

    Send-MailMessage -From $from -To $to -Subject $subject -bodyAsHtml $bodyAsHtml -SmtpServer $o365SmtpServer -Port $o365SmtpPort -UseSsl -Credential $credential

}