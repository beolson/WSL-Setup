


$json = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$distributionName = $json.wslDistribution
$wslUserName = $json.userName

New-Item -ItemType Directory -Force -Path .\wslSetup\certs

# Stage any windows certificates that need to be setup on the linux side
New-Item -ItemType Directory -Force -Path .\certs
$json.certificates | ForEach-Object {
    $thumbprint =  $_.thumbprint

    $cert = Get-ChildItem -path "Cert:\*$thumbprint" -Recurse | Select-Object -First 1
    Export-Certificate -Cert $cert -Type CERT -FilePath .\wslSetup\certs\$thumbprint.cer
    certutil.exe -encode .\wslSetup\certs\$thumbprint.cer .\wslSetup\certs\$thumbprint.pem
    Remove-Item -Path .\wslSetup\certs\$thumbprint.cer -Force
}

# merge all our certificate pem files into one called "wincerts.pem"
Get-ChildItem .\wslSetup\certs -include *.pem -rec | ForEach-Object {gc $_; ""} | out-file .\wslSetup\wincerts.pem

# cleanup our certificates working directory
Remove-Item -Path .\wslSetup\certs\ -Force -Recurse

wsl --shell-type standard -d $distributionName --user $wslUserName --exec  sudo ./wslSetup/bootstrap.sh


Remove-Item -Path .\wslSetup\wincerts.pem -Force 