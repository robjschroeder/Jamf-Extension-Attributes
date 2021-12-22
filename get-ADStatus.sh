#!/bin/sh

ad_domain_name=$(dsconfigad -show | grep "Active Directory Domain" | cut -d= -f2 | awk '{print $1}')

echo "<result>$ad_domain_name</result>"