#!/bin/bash&#13;
LastStart=$(echo $(echo $(last reboot | head -1)) | awk '{print $3" "$4" "$5" "$6}')&#13;
echo “<result>$LastStart</result>”