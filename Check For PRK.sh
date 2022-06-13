#!/bin/bash

# Script will check for the existence of
# a Personal Recovery Key on a macOS computer. 
#
# Created: 06.13.2022 @robjschroeder

RESULT=$(/usr/bin/fdesetup haspersonalrecoverykey)

/bin/echo "<result>$RESULT</result>"
