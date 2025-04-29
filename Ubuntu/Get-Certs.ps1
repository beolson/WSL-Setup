$crt = Get-ChildItem -path 'Cert:\*d72f47d87420e3f0f9bdcac6f03a566743c481b9' -Recurse 

if ($crt -ne $null){
    Remove-Item certs\zscaler.crt
    Export-Certificate -Cert $crt[0] -FilePath certs\zscaler.cer
    certutil -encode certs\zscaler.cer certs\zscaler.pem
    Rename-Item -Path certs\zscaler.pem -NewName zscaler.crt
    Remove-Item certs\zscaler.cer
}
