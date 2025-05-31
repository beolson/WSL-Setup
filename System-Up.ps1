
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
# Invoke-WSLScript -scriptPath './apt_upgrade.sh' -distributionName $distributionName
# Invoke-WSLScript -scriptPath './configure_ca_certs.sh' -distributionName $distributionName
# Invoke-WSLScript -scriptPath './install_git_cred_manager.sh' -distributionName $distributionName

#user
Invoke-WSLScript -scriptPath './configure_git.sh'-distributionName $distributionName -user $userName




