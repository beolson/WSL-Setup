


$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution
$wslUserName = $json.userName
# $linuxBootstrapCmd = "sed 's/\r$//' ./wslSetup/bootstrap.sh | sudo sh";
# $linuxBootstrapCmd = 'sudo ./wslSetup/bootstrap.sh'


if($json.certificates.count -gt 0){
    New-Item -ItemType Directory -Force -Path .\ansible\certs

    # Stage any windows certificates that need to be setup on the linux side
    New-Item -ItemType Directory -Force -Path .\certs
    $json.certificates | ForEach-Object {
        $thumbprint =  $_.thumbprint

        $cert = Get-ChildItem -path "Cert:\*$thumbprint" -Recurse | Select-Object -First 1
        Export-Certificate -Cert $cert -Type CERT -FilePath .\ansible\certs\$thumbprint.cer
        certutil.exe -encode .\ansible\certs\$thumbprint.cer .\ansible\certs\$thumbprint.crt
        Remove-Item -Path .\ansible\certs\$thumbprint.cer -Force
    }


    # merge all our certificate pem files into one called "wincerts.pem"
    Get-ChildItem .\ansible\certs -include *.crt -rec | ForEach-Object {gc $_; ""} | out-file .\ansible\certs\wincerts.pem
}
# cleanup our certificates working directory
# Remove-Item -Path .\wslSetup\certs\ -Force -Recurse

# Update our shell script to remove windows line endings
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec sed -i 's/\r$//' ./ansible/bootstrap.sh
wsl --shell-type standard --distribution $distributionName --user $wslUserName --exec bash ./ansible/bootstrap.sh

if(Test-Path -Path .\ansible\certs){
    Remove-Item -Path .\ansible\certs\ -Force -Recurse
}