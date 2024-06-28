unction New-ZorusQuery {
    param (
        $body,
        $URI,
        $method
    )
    if (($body.gettype()).name -eq 'HashTable'){
        $body=$body | ConvertTo-Json -depth 6
    }
    $retry=$false
    $retrycount=0
    do{
        $Response=Invoke-WebRequest -Method Post -Headers $script:headers -body $Body -Uri $URI
        switch ($response.StatusCode) {
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
            default {
                write-host "StatusCode $_ recieved. Waiting 5 seconds and retrying request." -ForegroundColor Yellow
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