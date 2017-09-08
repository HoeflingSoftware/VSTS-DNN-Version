[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation
try {
    Import-VstsLocStrings "$PSScriptRoot\buildtask\task.json"

    # Get inputs.
    $input_source = Get-VstsInput -Name 'sourceDirectory' -Require
    $input_version = Get-VstsInput -Name 'moduleVersion' -Require

    # load XML file
    $xml = New-Object XML
    $xml.Load($input_source)

    # select node and update version
    $nodes = $xml.SelectNodes("/dotnetnuke/packages/package")
    $nodes.SetAttribute("version", $input_version)

    $xml.Save($input_source)   

    Write-Host "Hello World" 

    # Fail if any errors.
    # if ($failed) {
    #     Write-VstsSetResult -Result 'Failed' -Message "Error detected" -DoNotThrow
    # }
} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}