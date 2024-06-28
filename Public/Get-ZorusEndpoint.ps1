function Get-ZorusEndpoint {
    [CmdletBinding()]
    param (
        $NameContains,
        $isEnabled,
        $Uuid,
        $CustomerUuid,
        $GroupUuid,
        $CreatedAfter,
        $CreatedBefore
    )
    $URI=$script:BaseURL+'/api/endpoints/search'
    
    $results=[System.Collections.ArrayList]@()
    $page=0
    do {
        $body=@{}
        $page++
        $body.add('page',$page)
        $body.add('pageSize',100)
        $body.add('sortProperty','Name')
        $body.add('sortAscending', $true)
        if (!([string]::IsNullOrWhiteSpace($nameContains))){
            $body.add('nameContains',$nameContains)
        }
        if ($PSBoundParameters.ContainsKey('isEnabled')){
            $body.add('isEnabled',$isEnabled)
        }
        if (!([string]::IsNullOrWhiteSpace($uuid))){
            $body.add('uuidEquals',$uuid)
        }
        if (!([string]::IsNullOrWhiteSpace($CustomerUuid))){
            $body.add('customerUuidEquals',$CustomerUuid)
        }
        if (!([string]::IsNullOrWhiteSpace($GroupUuid))){
            $body.add('groupUuidEquals',$GroupUuid)
        }
        $data=New-ZorusQuery -method POST -body $Body -uri $URI
        foreach ($entry in $Data){
            if ($null -ne $entry){
                [void]$results.add($entry)
            }  
        }
    }
    until ($data.count -eq 0)
    $results
}