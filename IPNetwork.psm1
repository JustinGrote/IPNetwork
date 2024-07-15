using namespace System.Net
$debugBinPath = Join-Path $PSScriptRoot '.\bin\Debug\netstandard2.0\publish'
if (Test-Path $PSScriptRoot\IPNetwork.dll) {
  #This is a release version
  Add-Type -Path (Resolve-Path (Join-Path $PSScriptRoot '*.dll'))
} elseif (Test-Path (Join-Path $debugBinPath 'IPNetwork.dll')) {
  Write-Warning "Detected debug version. Loading Assemblies from $debugBinPath"
  Add-Type -Path (Join-Path $DebugBinPath '*.dll')
} else {
  throw 'IPNetwork.dll not found. If you are working with the source, please run dotnet publish first.'
}

filter Get-IPNetwork {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [string]$Address
  )
  [IPNetwork2]::Parse($Address)
}
