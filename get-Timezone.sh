#!/bin/sh

# Reports computer's current timezone
timezone=$(systemsetup -gettimezone | cut -b 12-)

echo "<result>$timezone</result>"
