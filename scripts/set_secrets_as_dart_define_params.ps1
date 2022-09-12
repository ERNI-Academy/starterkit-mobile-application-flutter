# This script should be run in project directory

$env = $args[0]

$secrets = Get-Content ".secrets/$env.secrets" | out-string | ConvertFrom-Json
$dartDefines = ""

foreach ($info in $secrets.PSObject.Properties) {
  $key = $info.Name
  $value = $info.Value
  $dartDefines += "--dart-define `"$key=$value`" "
}

Write-Output $dartDefines