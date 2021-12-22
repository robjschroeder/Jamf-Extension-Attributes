!/bin/sh
####

firmwarePass="$(firmwarepasswd -check)";

if [ "$firmwarePass" == "Password Enabled: Yes" ]; then echo "<result>Set</result>";
else echo "<result>Not Set</result>"
fi