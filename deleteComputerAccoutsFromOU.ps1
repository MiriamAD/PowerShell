#############################################################
# Title:       deleteComputerAccoutsFromOU.ps1              #
# Description: To delete all computer accounts from a       #
#              specified OU                                 #
# Author:      Miriam Dyck                                  #
# Date:        2019/10/29                                   #
# Version:     1.0                                          #
#############################################################
 
# Configure the following variable to adjust the OU search
$Keyword = 'OU NAME'
$check = 'n'
$check = Read-Host -Prompt 'Are you sure you want to delete all computer accounts from the [OU NAME] OU? [y] yes or [n] no'
$check = $check.ToLower()
 
if($check -eq 'y'){
    (Get-ADForest).Domains | % {
        $Domain = $_ #default domain name require to prevent breaking the first time
        $DN = (Get-ADDomain -Identity $Domain).DistinguishedName #stores the current domains distinguished name
        $OUs = (Get-ADOrganizationalUnit -Filter {Name -like $Keyword} -Server $Domain -SearchBase $DN -SearchScope Subtree -Properties *).DistinguishedName #DN of the OU
 
        If ($OUs -ne $null) {
            $OUs | % {
                $OU = $_
                Write-Host "Targetting OU: $OU" -ForegroundColor Cyan
                $Computers = Get-ADComputer -SearchBase $OU -SearchScope Subtree -Server $Domain -Filter *
                $Computers | % {
                $DN = $_.DistinguishedName
                $Name = $_.Name
                Write-Host "`tAccount: $Name" -ForegroundColor DarkCyan
                Remove-ADComputer -Identity $Name -Confirm:$false
                }
            }
        }
    }
}
