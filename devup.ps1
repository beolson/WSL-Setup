$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution

wsl --unregister $distributionName
wsl --install -d $distributionName 

$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution
$wslUserName = $json.userName

# Update our shell script to remove windows line endings
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./bootstrap.sh
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec bash ./bootstrap.sh

# Update our shell script to remove windows line endings
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./bootstrap_step_2.sh
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec bash ./bootstrap_step_2.sh