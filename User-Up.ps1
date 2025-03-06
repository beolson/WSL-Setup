param (
    [string] $user = "beolson"
)

$distributionName = "Ubuntu-24.04"

function Run-Script-In-Wsl {
    param(
        [string]$scriptPath
    )

    # convert from windows line endings to unix line endings
    ((Get-Content $scriptPath) -join "`n") + "`n" | Set-Content -NoNewline $scriptPath

    echo --shell-type standard --distribution $distributionName --user $user --exec bash ./$scriptPath

    wsl --shell-type standard --distribution $distributionName --user $user --exec bash ./$scriptPath
}

Run-Script-In-Wsl -scriptPath 'user_install_scripts/install_rust.sh' 
Run-Script-In-Wsl -scriptPath 'user_install_scripts/install_oh_my_bash.sh'
Run-Script-In-Wsl -scriptPath 'user_install_scripts/install_node_tools.sh'
Run-Script-In-Wsl -scriptPath 'user_install_scripts/install_dot_files.sh'