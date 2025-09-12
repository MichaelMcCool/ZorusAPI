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
        $CurrentVerbose=$VerbosePreference
        $VerbosePreference='Continue'
        switch ($Errorcode) {
            200 {
                # Everything successful. Exit Loop.
                $retry=$false
            }
            202 {
                # Request was accepted. Exit Loop.
                $retry=$false
            }
            401 {
                throw "401 : Unauthorized. Check API key."
            }
            404 {
                # Not found
                throw "404 : Not Found."
            }
            406 {
                throw "406 : Invalid Query. Check request body."
            }
            409 {
                # Minimize the impact of setting an endpoint to the same state it currently has.
                if ($URI -match "/api/endpoints/"){
                    write-verbose "The endpoint is already in the selected state."
                }
                elseif ($URI -match "/api/deployment-token"){
                    # This is a conflict status returned when creating deployment tokens with name already used.
                    throw "409: A deployment token with that name already exists."
                }
                else {
                    # Any other use case of the 409 error response that isn't otherwise known.
                    throw "409 : Conflict."
                }
                
            }
            default {
                write-host "StatusCode $Errorcode recieved. Waiting 5 seconds and retrying request." -ForegroundColor Yellow
                $retry=$true
                start-sleep 5
            }
        }
        $VerbosePreference=$CurrentVerbose
        if ($retry){
            $retrycount++
        }
        if ($retrycount -gt 3){
            write-host "Max retry count reached. Aborting."
            $retry=$false
        }
    }
    until ($retry -eq $false)
    # Moved this to a try/catch in order to work with the verbose only errors for endpoint state changes.
    try {$Response.content | ConvertFrom-Json -erroraction stop}
    catch {$response}
}