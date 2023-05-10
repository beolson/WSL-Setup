


$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution
$wslUserName = $json.userName
# $linuxBootstrapCmd = "sed 's/\r$//' ./wslSetup/bootstrap.sh | sudo sh";
$linuxBootstrapCmd = 'sudo ./wslSetup/bootstrap.sh'


if($json.certificates.count -gt 0){
    New-Item -ItemType Directory -Force -Path .\wslSetup\certs

    # Stage any windows certificates that need to be setup on the linux side
    New-Item -ItemType Directory -Force -Path .\certs
    $json.certificates | ForEach-Object {
        $thumbprint =  $_.thumbprint

        $cert = Get-ChildItem -path "Cert:\*$thumbprint" -Recurse | Select-Object -First 1
        Export-Certificate -Cert $cert -Type CERT -FilePath .\wslSetup\certs\$thumbprint.cer
        certutil.exe -encode .\wslSetup\certs\$thumbprint.cer .\wslSetup\certs\$thumbprint.crt
        Remove-Item -Path .\wslSetup\certs\$thumbprint.cer -Force
    }


    # merge all our certificate pem files into one called "wincerts.pem"
    Get-ChildItem .\wslSetup\certs -include *.crt -rec | ForEach-Object {gc $_; ""} | out-file .\wslSetup\certs\wincerts.pem
}
# cleanup our certificates working directory
# Remove-Item -Path .\wslSetup\certs\ -Force -Recurse

# Update our shell script to remove windows line endings
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./wslSetup/bootstrap.sh
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sudo ./wslSetup/bootstrap.sh

if(Test-Path -Path .\wslSetup\certs){
    Remove-Item -Path .\wslSetup\certs\ -Force -Recurse
}