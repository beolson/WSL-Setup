
param (
    [switch] $replace = $false
)
Import-Module -Name ..\ps_modules\Invoke-WSLScript -Verbose

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
Invoke-WSLScript -scriptPath './apt_upgrade.sh' -distributionName $distributionName
Invoke-WSLScript -scriptPath './configure_ca_certs.sh' -distributionName $distributionName
Invoke-WSLScript -scriptPath './install_git_cred_manager.sh' -distributionName $distributionName
Invoke-WSLScript -scriptPath './install_dotnet-sdk-8.0.403.sh'-distributionName $distributionName
Invoke-WSLScript -scriptPath './install_dotnet-sdk-9.0.100.sh'-distributionName $distributionName
Invoke-WSLScript -scriptPath './install_go1.23.3.sh'-distributionName $distributionName

#user
Invoke-WSLScript -scriptPath './install_oh_my_bash.sh'-distributionName $distributionName -user $userName
Invoke-WSLScript -scriptPath './configure_git.sh'-distributionName $distributionName -user $userName
Invoke-WSLScript -scriptPath './install_rust.sh'-distributionName $distributionName -user $userName
Invoke-WSLScript -scriptPath './install_node_tools.sh'-distributionName $distributionName -user $userName

#kubectl
#python - uv
# https://testdriven.io/blog/python-type-checking/ - pydantic?


