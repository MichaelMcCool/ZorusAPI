function Get-ZorusPolicy {
    [CmdletBinding()]
    param (
        $CustomerNameContains,
        $GroupNameContains,
        $Uuid,
        $GroupUuid,
        $CustomerUuid,
        $CreatedAfter,
        $CreatedBefore
    )
    $URI=$script:BaseURL+'/api/policies/search'
    
    $results=[System.Collections.ArrayList]@()
    $page=0
    do {
        $body=@{}
        $page++
        $body.add('page',$page)
        $body.add('pageSize',100)
        $body.add('sortProperty','CustomerName')
        $body.add('sortAscending', $true)
        if (!([string]::IsNullOrWhiteSpace($CustomerNameContains))){
            $body.add('customerNameContains',$CustomerNameContains)
        }
        if (!([string]::IsNullOrWhiteSpace($GroupNameContains))){
            $body.add('groupNameContains',$GroupNameContains)
        }
        if (!([string]::IsNullOrWhiteSpace($uuid))){
            $body.add('uuidEquals',$uuid)
        }
        if (!([string]::IsNullOrWhiteSpace($GroupUuid))){
            $body.add('groupUuidEquals',$GroupUuid)
        }
        if (!([string]::IsNullOrWhiteSpace($CustomerUuid))){
            $body.add('customerUuidEquals',$CustomerUuid)
        }
        if (!([string]::IsNullOrWhiteSpace($CreatedAfter))){
            $body.add('createdAfter',$CreatedAfter)
        }
        if (!([string]::IsNullOrWhiteSpace($CreatedBefore))){
            $body.add('createdAfter',$CreatedBefore)
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