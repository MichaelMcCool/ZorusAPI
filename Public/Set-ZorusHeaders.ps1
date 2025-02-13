function Set-ZorusHeaders ($object){
    $CurrentVerbose=$VerbosePreference
    $VerbosePreference='Continue'
    write-verbose "This cmdlet, Set-ZorusHeaders, has been depreciated. The headers script block can now be ommited."
    write-verbose "The new command to use is `"Set-ZorusAPIKey -APIKey <Zorus API Key>`"."
    write-verbose "Please update your script to use the new command for future use."
    write-verbose "The `$Headers value has been set. There is no need to run the new cmdlet at this time."
    $VerbosePreference=$CurrentVerbose
    $script:Headers=$object
}