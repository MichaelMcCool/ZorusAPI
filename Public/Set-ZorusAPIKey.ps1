function Set-ZorusAPIKey ($APIKey){
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add('Content-Type','application/json')
    $headers.Add('Authorization',"Impersonation $APIKey")
    $headers.Add('Zorus-Api-Version','1.0')
    $headers.Add('accept','text/plain')
    $script:Headers=$Headers
}

