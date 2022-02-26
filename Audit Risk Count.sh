#!/bin/bash

# Security Reporting - Count Risks
# From @gocardless - Updated for Big Sur
# https://github.com/gocardless/CIS-for-macOS-BigSur-CP
#
# Updated: 2.26.2022 @ Robjschroeder

# Security Reporting - Count Risks

auditfile=/Library/Application\ Support/SecurityScoring/org_audit
echo "<result>$(cat "$auditfile" | grep "*" | wc -l | tr -d '[:space:]')</result>"
