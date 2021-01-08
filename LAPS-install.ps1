Import-Module AdmPwd.PS
Update-AdmPwdADSchema
$ServerOU = Get-ADOrganizationalUnit -Filter  {Name -like '*Servers*'} | select -ExpandProperty DistinguishedName
$ComputerOU = Get-ADOrganizationalUnit -filter {Name -like '*Equipos*'} | select -ExpandProperty DistinguishedName
$Serverou | ForEach-Object{ Set-AdmPwdComputerSelfPermission -OrgUnit $_ }
$ComputerOU | ForEach-Object{ Set-AdmPwdComputerSelfPermission -OrgUnit $_ }
$Serverou | ForEach-Object{ Set-AdmPwdReadPasswordPermission -OrgUnit $_ -AllowedPrincipals 'SCG\LAPS - Server Administrators' }
$ComputerOU | ForEach-Object{ Set-AdmPwdReadPasswordPermission -OrgUnit $_ -AllowedPrincipals 'SCG\LAPS - Computer Administrators' }
$Serverou | ForEach-Object{ Find-AdmPwdExtendedRights -Identity $_ | select -ExpandProperty ExtendedRightHolders }
Get-AdmPwdPassword -ComputerName 31am05p61 | select ComputerName, Password, ExpirationTimestamp
