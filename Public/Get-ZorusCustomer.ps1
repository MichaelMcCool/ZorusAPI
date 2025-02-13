function Get-ZorusCustomer {
    [CmdletBinding()]
    param (
        $nameContains,
        $isEnabled,
        $uuid,
        $CreatedAfter,
        $CreatedBefore
    )

    $URI='/api/customers/search'
    
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