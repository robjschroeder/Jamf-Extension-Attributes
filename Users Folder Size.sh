#!/bin/bash
    usersize=$( du -h -d 0 /Users | awk '{print $1}' )
    echo "<result>$usersize</result>"
exit 0
