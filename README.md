Quickstart guide to connecting to the Zorus API.

Step 1) Review Zorus documentation - https://support.zorustech.com/api-quickstart

Step 2) Generate an API key as documented.

Use the following script to set everyting up:

    $APIKey='<api key>'
    
    ## No more changes required below this line.
    $BaseURL='https://developer.zorustech.com'
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add('Content-Type','application/json')
    $headers.Add('Authorization',"Impersonation $APIKey")
    $headers.Add('Zorus-Api-Version','1.0')
    $headers.Add('accept','text/plain')

    Set-ZorusBaseURL $BaseURL
    Set-ZorusHeaders $Headers
    ## End header setup configuration.

    
    # Sample command and output.
    $Customers=Get-ZorusCustomer
    $Customers
