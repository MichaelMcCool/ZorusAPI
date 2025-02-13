function New-ZorusQuery {
    param (
        $body,
        $URI,
        $method
    )

    # If the value is not set, use the default of https://developer.zorustech.com.
    if ([string]::IsNullOrWhiteSpace($script:BaseURL)){
        $BaseURL='https://developer.zorustech.com'
        Set-ZorusBaseURL $BaseURL
    }
    $URI=$script:BaseURL+$URI
    if ($null -eq $script:Headers){
        throw "Headers/APIKey value not configured. See README.md to configure."
    }
    if (($body.gettype()).name -eq 'HashTable'){
        $body=$body | ConvertTo-Json -depth 6
    }
    $retry=$false
    $retrycount=0
    do{
        try{
            $response=Invoke-WebRequest -Method Post -Headers $script:headers -body $Body -Uri $URI
            $Errorcode=$response.statuscode
        }
        catch {
            $Errorcode=$_.Exception.Response.statuscode.Value__
        }
        switch ($Errorcode) {
            200 {
                # Everything successful. Exit Loop.
                $retry=$false
            }
            401 {
                throw "401 : Unauthorized. Check API key."
            }
            406 {
                throw "406 : Invalid Query. Check request body."
            }
            409 {
                # This is a conflict status returned when creating deployment tokens with name already used.
                throw "409 : Conflict. An existing entry with that name already exists."
            }
            default {
                write-host "StatusCode $Errorcode recieved. Waiting 5 seconds and retrying request." -ForegroundColor Yellow
                $retry=$true
                start-sleep 5
            }
        }
        if ($retry){
            $retrycount++
        }
        if ($retrycount -gt 3){
            write-host "Max retry count reached. Aborting."
            $retry=$false
        }
    }
    until ($retry -eq $false)
    $Response.content | ConvertFrom-Json
}