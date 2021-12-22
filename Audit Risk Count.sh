#!/bin/bash

# Security Reporting - Count Risk

auditfile=/Library/Application\ Support/SecurityScoring/org_audit
echo "<result>$(cat "$auditfile" | grep "*" | wc -l | tr -d '[:space:]')</result>"