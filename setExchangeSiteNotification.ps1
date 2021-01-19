###################################################################
# Title:       setExchangeInterSiteNotification.ps1               #
# Description: This script will identify all Exchange NA servers  #
#              (GCC & SCC) and change the options attribute to    #
#              enable change notifications (options = 1)          #
# Author:      Miriam Dyck                                        #
# Date:        2019/11/06                                         #
# Version:     1.1                                                #
###################################################################
 
# From Sites and services --> Sites --> Inter-Site Transports --> IP -->
# insert site (Exchange) --> Properties --> Attribute Editor --> Options: Value = 1
 
#This command can display what will be targeted by this change
#Note that "Exchange14" happens to be in the name of all site links that qualify for this change
#Get-ADReplicationSiteLink -Filter {Name -like "*Exchange14*"}
 
#Set-ADReplicationSiteLink -Identity "NAME" -Replace @{'description'= 'test'}
 
Get-ADReplicationSiteLink -Filter {Name -like "*Exchange14*"} | % {Set-ADReplicationSiteLink $_ -Replace @{'option'= 1}}
 
#To undo this change run the following
Get-ADReplicationSiteLink -Filter {Name -like "*Exchange14*"} | % {Set-ADReplicationSiteLink $_ -Remove @{'option'= 1}}
