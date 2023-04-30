# # # Import-Module .\lib\MyModule.psm1
# # # Return-MrOsVersion
# # # Write-Output "good"


$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json


# # # $json.users | ForEach-Object {
# # #     $user = $_.name
# # #     $_.roles | ForEach-Object {
# # #         $role = $_
# # #         Write-Output "User: $user"
# # #         Write-Output "Role: $role"
# # #         #Add-RoleToUser $user $role
# # #     }
# # # }


# Stage any windows certificates that need to be setup on the linux side
New-Item -ItemType Directory -Force -Path .\certs
$json.certificates | ForEach-Object {
    $thumbprint =  $_.thumbprint
    $fileName = $_.exportFileNameBase

    $cert = Get-ChildItem -path "Cert:\*$thumbprint" -Recurse | Select-Object -First 1
    Export-Certificate -Cert $cert -Type CERT -FilePath .\wslSetup\certs\$fileName.cer
    certutil.exe -encode .\wslSetup\certs\$fileName.cer .\wslSetup\certs\$fileName.pem
    Remove-Item -Path .\wslSetup\certs\$fileName.cer -Force
}

Get-ChildItem .\wslSetup\certs -include *.pem -rec | ForEach-Object {gc $_; ""} | out-file .\wslSetup\wincerts.pem


# Create our WSL instance
Copy-item -Force -Recurse -Verbose .\wslSetup -Destination \\wsl$\Ubuntu-22.04\home\beolson

wsl --shell-type standard -d Ubuntu-22.04 --user beolson --exec  sudo ./wslSetup/bootstrap.sh
