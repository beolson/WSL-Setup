
function Invoke-WSLScript {
    param(
        [string]$scriptPath,
        [string]$distributionName,
        [string]$user = "root"
    )

    echo "distributionName : $distributionName"

    # convert from windows line endings to unix line endings
    ((Get-Content $scriptPath) -join "`n") + "`n" | Set-Content -NoNewline $scriptPath
    
    wsl --shell-type standard --distribution $distributionName --user $user --exec bash ./$scriptPath
}


Export-ModuleMember -Function Invoke-WSLScript