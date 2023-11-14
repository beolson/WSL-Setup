$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution

wsl --unregister $distributionName
wsl --install -d $distributionName 