#!/bin/bash&#13;
&#13;
# Security Reporting - List Risks&#13;
&#13;
auditfile=/Library/Application\ Support/SecurityScoring/org_audit&#13;
echo "<result>$(cat "$auditfile")</result>"