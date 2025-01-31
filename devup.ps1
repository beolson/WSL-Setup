$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution
$wslUserName = $json.userName

wsl --set-version 2
wsl --unregister $distributionName
wsl --install -d $distributionName 

$crt = Get-ChildItem -path 'Cert:\*d72f47d87420e3f0f9bdcac6f03a566743c481b9' -Recurse 

if ($crt -ne $null){
    Remove-Item certs\zscaler.crt
    Export-Certificate -Cert $crt[0] -FilePath certs\zscaler.cer
    certutil -encode certs\zscaler.cer certs\zscaler.pem
    Rename-Item -Path certs\zscaler.pem -NewName zscaler.crt
    Remove-Item certs\zscaler.cer
}




$scripts = @(
    'apt_upgrade.sh'
    'install_wsl_tools.sh'
    'install_git_cred_manager.sh'
    'install_oh_my_bash.sh'
    'configure_dot_files.sh'
)

if ($crt -ne $null){
    $scripts = ,"configure_ca_certs.sh" + $scripts
}
#concat the file instead, then run one file?  fix the sudo password problem?
# https://stackoverflow.com/questions/8749929/how-do-i-concatenate-two-text-files-in-powershell

Get-Content $scripts | Set-Content config_sys.sh

wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./config_sys.sh
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec bash ./config_sys.sh

Remove-Item config_sys.sh