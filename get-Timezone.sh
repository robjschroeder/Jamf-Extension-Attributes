#!/bin/bash

# Reports computer's current timezone
#
# Updated: 2.23.2022 @ Robjschroeder
#

timezone=$(systemsetup -gettimezone | cut -b 12-)

echo "<result>${timezone}</result>"

exit 0
