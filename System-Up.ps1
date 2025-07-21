
param (
    [switch] $replace = $false
)
Import-Module -Name .\ps_modules\Invoke-WSLScript -Verbose

$distributionName = "Debian"
$userName = "beolson"

if ($replace) {
    write-host "Replacing existing distro"
    wsl --set-version 2
    wsl --unregister $distributionName
    wsl --install -d $distributionName

    wsl -d $distributionName
}

#system 
Invoke-WSLScript -scriptPath './config_system.sh' -distributionName $distributionName

#user
Invoke-WSLScript -scriptPath './config_user.sh'-distributionName $distributionName -user $userName




