function Get-ZorusGroup {
    [CmdletBinding()]
    param (
        $CustomerNameContains,
        $GroupNameContains,
        $Uuid,
        $PolicyUuid,
        $CustomerUuid,
        [Boolean]$SyncOptionsToMembers,
        [Boolean]$SyncAddonsToMembers
    )
    $URI='/api/groups/search'
    
    $results=[System.Collections.ArrayList]@()
    $page=0
    do {
        $body=@{}
        $page++
        $body.add('page',$page)
        $body.add('pageSize',100)
        $body.add('sortProperty','Name')
        $body.add('sortAscending', $true)
        if (!([string]::IsNullOrWhiteSpace($CustomerNameContains))){
            $body.add('customerNameContains',$CustomerNameContains)
        }
        if (!([string]::IsNullOrWhiteSpace($NameContains))){
            $body.add('nameContains',$NameContains)
        }
        if (!([string]::IsNullOrWhiteSpace($uuid))){
            $body.add('uuidEquals',$uuid)
        }
        if (!([string]::IsNullOrWhiteSpace($PolicyUuid))){
            $body.add('policyUuidEquals',$PolicyUuid)
        }
        if (!([string]::IsNullOrWhiteSpace($CustomerUuid))){
            $body.add('customerUuidEquals',$CustomerUuid)
        }
        if ($PSBoundParameters.ContainsKey('SyncOptionsToMembers')){
            $body.add('syncOptionsToMembers',$SyncOptionsToMembers)
        }
        if ($PSBoundParameters.ContainsKey('SyncAddonsToMembers')){
            $body.add('syncAddonsToMembers',$SyncAddonsToMembers)
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