function Send-Office365MailMessage {
    <#
    .SYNOPSIS 
    Posts a message via o365 email

    .DESCRIPTION
    Uses a pre-created webhook to post a message to a Teams channel

    .PARAMETER from
    email address to send from

    .PARAMETER to
    email address to send to

    .PARAMETER subject
    email subject

    .PARAMETER bodyAsHtml
    Message (as html)

    .PARAMETER credential
    Credential object for from account

    .OUTPUTS
    None

    .EXAMPLE
    $o365PasswordSecure = ConvertTo-SecureString "mypassword" -AsPlainText -Force
    $o365Credential = New-Object System.Management.Automation.PSCredential( "sender@conosto.com" , $o365PasswordSecure )
    Send-Office365MailMessage -from "sender@conosto.com" -credential $o365Credential -to "recipient@conosto.com" -subject "message subject" -bodyAsHtml "<html><body>Hello</body></html>"
    #>
    
    param(
        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$from = $o365Account,

        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [PSCredential]$Credential = $o365AccountCredential,
        
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$to,

        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$subject,

        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$bodyAsHtml
    )

    $o365SmtpServer = "smtp.office365.com"
    $o365SmtpPort = "587"

    Send-MailMessage -From $from -To $to -Subject $subject -bodyAsHtml $bodyAsHtml -SmtpServer $o365SmtpServer -Port $o365SmtpPort -UseSsl -Credential $credential

}