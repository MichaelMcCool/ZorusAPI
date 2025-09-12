function Set-ZorusEndpoint {
    [CmdletBinding()]
        param (
        [Parameter(Mandatory=$true)]$Uuid,
        [Parameter(Mandatory=$false,ParameterSetName="Enable")][switch]$Enable,
        [Parameter(Mandatory=$false,ParameterSetName="Disable")][switch]$Disable,
        [Parameter(Mandatory=$false,ParameterSetName="RestartService")][switch]$RestartService,
        [Parameter(Mandatory=$false,ParameterSetName="Release")][switch]$Release,
        [Parameter(Mandatory=$false,ParameterSetName="Isolate")][switch]$Isolate,
        [Parameter(Mandatory=$true,ParameterSetName="Isolate")]$Reason,
        [Parameter(Mandatory=$true,ParameterSetName="Isolate")]$Passphrase
    )

    $body=@{}
    if (!([string]::IsNullOrWhiteSpace($uuid))){
        $body.add('endpointUuid',$uuid)
    }
    if ($Enable){
        $URI="/api/endpoints/$uuid/actions/enable"
    }
    if ($Disable){
        $URI="/api/endpoints/$uuid/actions/disable"
    }
    if ($RestartService){
        $URI="/api/endpoints/$uuid/actions/restart-service"
    }
    if ($Release){
        $URI="/api/endpoints/$uuid/actions/release"
    }
    if ($Isolate){
        $URI="/api/endpoints/$uuid/actions/isolate"
        $body.add('reason',$Reason)
        $body.add('passphrase',$Passphrase)
    }
    $data=New-ZorusQuery -method POST -body $Body -uri $URI
    
    $data
}