param (
    [switch] $replace = $false
)

$distributionName = "Ubuntu-24.04"

if ($replace) {
    write-host "Replacing existing distro"
    wsl --set-version 2
    wsl --unregister $distributionName
    wsl --install -d $distributionName
}

function Run-Script-In-Wsl {
    param(
        [string]$scriptPath
    )

    # convert from windows line endings to unix line endings
    ((Get-Content $scriptPath) -join "`n") + "`n" | Set-Content -NoNewline $scriptPath

    wsl --shell-type standard --distribution $distributionName --user root --exec bash ./$scriptPath
}

# Run-Script-In-Wsl -scriptPath 'install_scripts/apt_upgrade.sh' 
# Run-Script-In-Wsl -scriptPath 'install_scripts/configure_ca_certs.sh' 
# Run-Script-In-Wsl -scriptPath 'install_scripts/install_git_cred_manager.sh' 
# Run-Script-In-Wsl -scriptPath 'install_scripts/install_dotnet-sdk-8.0.403.sh' 
# Run-Script-In-Wsl -scriptPath 'install_scripts/install_dotnet-sdk-9.0.100.sh' 
