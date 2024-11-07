$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution

# wsl --set-version 2
# wsl --unregister $distributionName
# wsl --install -d $distributionName 

$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution
$wslUserName = $json.userName

$scripts = @(
    # 'apt_upgrade.sh'
    # 'configure_ca_certs.sh'
    # 'install_wsl_tools.sh'
    # 'install_git_cred_manager.sh'
    # 'install_oh_my_bash.sh'
    # 'configure_dot_files.sh'
    'install_node_tools.sh'
    # 'install_dotnet.sh'
    # 'install_rust.sh'
    # 'install_go.sh'
)
#concat the file instead, then run one file?  fix the sudo password problem?
# https://stackoverflow.com/questions/8749929/how-do-i-concatenate-two-text-files-in-powershell
ForEach ($script in $scripts) {

    wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./$script
    wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec bash ./$script
# reload bash env after each?
}

# # # # Update our shell script to remove windows line endings
# wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./bootstrap.sh
# wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec bash ./bootstrap.sh

# # wsl -t $distributionName

# # Update our shell script to remove windows line endings
# wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./bootstrap_step_2.sh
# wsl --shell-type standard --distribution $distributionName --user $wslUserName ./bootstrap_step_2.sh