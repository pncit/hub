function Send-MsTeamsMessage {
    <#
    .SYNOPSIS 
    Posts a message to Microsoft Teams

    .DESCRIPTION
    Uses a pre-created webhook to post a message to a Teams channel

    .PARAMETER webhook
    uri for webhook

    .PARAMETER summary
    Message summary

    .PARAMETER title
    Message title

    .PARAMETER text
    Message text

    .NOTES
    Summary is what shows up in the teams feed

    Title is what is bold/h1 in the message itself
    
    Text is plain text in the message itself
    .EXAMPLE
    Send-MsTeamsMessage -summary "Critical event" -title "Hard Drive Failure" -text "Hard drive has failed on server at hospital" -webhook "https://outlook.office.com/webhook/00000000-0000-0000-0000-000000000000000000000-0000-0000-0000-000000000000/IncomingWebhook/00000000000000000000000000000000/00000000-0000-0000-0000-000000000000"
    #>
    param(
        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$webhook = $msTeamsWebhook,
        
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$summary,

        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$title,

        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$text
    )

    $body = ConvertTo-JSON @{
        summary = $summary
        text = $text
        title = $title
    }

    Invoke-RestMethod -uri $webhook -Method Post -body $body -ContentType 'application/json' -UseBasicParsing

}