#!/bin/bash

# Security Reporting - List Risks
# From @gocardless - Updated for Big Sur
# https://github.com/gocardless/CIS-for-macOS-BigSur-CP
#
# Updated: 2.26.2022 @ Robjschroeder

# Security Reporting - List Risks

auditfile=/Library/Application\ Support/SecurityScoring/org_audit
echo "<result>$(cat "$auditfile")</result>"
