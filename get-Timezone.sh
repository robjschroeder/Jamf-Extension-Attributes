#!/bin/sh

timezone=$(systemsetup -gettimezone | cut -b 12-)

echo "<result>$timezone</result>"
