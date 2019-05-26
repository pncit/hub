function sendMsTeamsMessage {
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

    .EXAMPLE
    sendMsTeamsMessage -summary "Critical event" -title "Hard Drive Failure" -text "Hard drive has failed on server at hospital"
    #>
    param(
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$webhook,
        
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