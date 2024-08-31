$domain = "cinar.local" # Domain adınız
$ou = "OU=Computers,DC=cinar,DC=local" # OU'nun tam LDAP path'i
$output_file = "C:\computers_with_lastlogon.txt" # Sonuçları kaydedeceğiniz dosya
$username = "cinar\administrator" # Domain kullanıcı adı
$password = "1" # Kullanıcı şifresi
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($username, $securePassword)
$computers = Get-ADComputer -SearchBase $ou -Filter * -Property Name, LastLogonDate -ResultPageSize 2000 -ResultSetSize $null -Credential $credentials |
             Select-Object Name, LastLogonDate
$computers | Out-File -FilePath $output_file
Write-Host "Tüm bilgisayar objeleri ve LastLogonDate bilgileri $output_file dosyasına kaydedildi."