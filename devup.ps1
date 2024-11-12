$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution
$wslUserName = $json.userName

wsl --set-version 2
wsl --unregister $distributionName
wsl --install -d $distributionName 



$scripts = @(
    'apt_upgrade.sh'
    'configure_ca_certs.sh'
    'install_wsl_tools.sh'
    'install_git_cred_manager.sh'
    'install_oh_my_bash.sh'
  
    'install_node_tools.sh'
    'install_dotnet.sh'
    'install_rust.sh'
    'install_go.sh'
    'configure_dot_files.sh'
)
#concat the file instead, then run one file?  fix the sudo password problem?
# https://stackoverflow.com/questions/8749929/how-do-i-concatenate-two-text-files-in-powershell

Get-Content $scripts | Set-Content config_sys.sh

wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./config_sys.sh
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec bash ./config_sys.sh

Remove-Item config_sys.sh