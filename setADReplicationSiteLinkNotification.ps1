###################################################################
# Title:       setADReplicationSiteLinkNotification.ps1           #
# Description: This script will identify all necessary            #
#              SiteLinks and enable change notifications          #
#              (options = 1)                                      #
# Author:      Miriam Dyck                                        #
# Date:        2019/11/06                                         #
# Version:     1.1                                                #
###################################################################
 
# From Sites and services --> Sites --> Inter-Site Transports --> IP -->
# insert site (Exchange) --> Properties --> Attribute Editor --> Options: Value = 1
 
#This command can display what will be targeted by this change
#Get-ADReplicationSiteLink -Filter {Name -like "*SITELINK*"}
 
#Set-ADReplicationSiteLink -Identity "SITELINK" -Replace @{'description'= 'test'}
 
Get-ADReplicationSiteLink -Filter {Name -like "*SITELINK*"} | % {Set-ADReplicationSiteLink $_ -Replace @{'option'= 1}}
 
#To undo this change run the following
Get-ADReplicationSiteLink -Filter {Name -like "*SITELINK*"} | % {Set-ADReplicationSiteLink $_ -Remove @{'option'= 1}}
