Quickstart guide to connecting to the Zorus API.

Step 1) Review Zorus documentation - https://support.zorustech.com/api-quickstart

Step 2) Generate an API key as documented.

Use the following script to set everyting up:

    Install-Module -name ZorusAPI
    Import-Module -name ZorusAPI
    
    $APIKey='<api key>'
    Set-ZorusAPIKey $APIKey

    $BaseURL='https://developer.zorustech.com' # Optional - Can be omitted.
    Set-ZorusBaseURL $BaseURL # Optional - Can be omitted.

    
    # Sample command and output.
    $Customers=Get-ZorusCustomer
    $Customers