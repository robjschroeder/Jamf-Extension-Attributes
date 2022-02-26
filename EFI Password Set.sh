#!/bin/bash

# Reports if EFI Password is currently set on computer
#
# Updated: 2.26.2022 @ Robjschroeder

firmwarePass="$(firmwarepasswd -check)";

if [ "$firmwarePass" == "Password Enabled: Yes" ]; then echo "<result>Set</result>";
else echo "<result>Not Set</result>"
fi

exit
