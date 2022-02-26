#!/bin/bash
# set -x

# Returns the latest OS supported on a computer
#
# Updated: 2.26.2022 @ Robjschroeder

####################################################################################################
# Script Name:  Get-LatestOSSupported.sh
# By:  Zack Thompson / Created:  9/26/2017
# Version:  2.0.0 / Updated:  2/21/2022 / By:  ZT
#
# Description:  A Jamf Pro Extension Attribute to check the latest compatible version of macOS.
#
# Updates:  For each OS version released, a new Regex string and each function will need to be 
#			updated.
#
#	System Requirements can be found here:
#		Full List - https://support.apple.com/en-us/HT211683
#		Monterey - https://support.apple.com/en-us/HT212735
#		Big Sur - https://support.apple.com/en-us/HT211238 / https://support.apple.com/kb/sp833
#			* If running Mountain Lion 10.8, device will need to upgrade to El Capitan 10.11 first.
#			  first.  See:
#			* https://web.archive.org/web/20211018042220/https://www.apple.com/macos/how-to-upgrade/
#		Catalina - https://support.apple.com/en-us/HT210222 / https://support.apple.com/kb/SP803
#		Mojave - https://support.apple.com/kb/SP777
#			* MacPro5,1's = https://support.apple.com/en-us/HT208898
#		High Sierra - https://support.apple.com/kb/SP765
#		Sierra - https://support.apple.com/kb/sp742
#		El Capitan - https://support.apple.com/kb/sp728
#
####################################################################################################

##################################################
# Define Regex Strings to exclude Mac Models that *do not support* each OS Version
not_elcapitan_or_older_regex="^((MacPro|Macmini|MacBookPro)[1-2],[0-9]|iMac[1-6],[0-9]|MacBook[1-4],[0-9]|MacBookAir1,[0-9])$"
not_highsierra_regex="^(MacPro[1-4],[0-9]|iMac[1-9],[0-9]|Macmini[1-3],[0-9]|(MacBook|MacBookPro)[1-5],[0-9]|MacBookAir[1-2],[0-9])$"
not_mojave_regex="^(MacPro[1-4],[0-9]|iMac([1-9]|1[0-2]),[0-9]|Macmini[1-5],[0-9]|MacBook[1-7],[0-9]|MacBookAir[1-4],[0-9]|MacBookPro[1-8],[0-9])$"
not_catalina_regex="^(MacPro[1-5],[0-9]|iMac([1-9]|1[0-2]),[0-9]|Macmini[1-5],[0-9]|MacBook[1-7],[0-9]|MacBookAir[1-4],[0-9]|MacBookPro[1-8],[0-9])$"
not_bigsur_regex="^(MacPro[1-5],[0-9]|iMac((([1-9]|1[0-3]),[0-9])|14,[0-3])|Macmini[1-6],[0-9]|MacBook[1-7],[0-9]|MacBookAir[1-5],[0-9]|MacBookPro([1-9]|10),[0-9])$"
not_monterey_regex="^(MacPro[1-5],[0-9]|iMac([1-9]|1[0-5]),[0-9]|(Macmini|MacBookAir)[1-6],[0-9]|MacBook[1-8],[0-9]|MacBookPro(([1-9]|10),[0-9]|11,[0-3]))$"

##################################################
# Setup Functions

model_check() {
	# $1 = Mac Model Identifier
	local model="${1}"

	if [[ $model =~ $not_elcapitan_or_older_regex || $model =~ ^Xserve.*$ ]]; then
		echo "<result>Current Model Not Supported</result>"
		exit 0
	elif [[ $model =~ $not_highsierra_regex ]]; then
		echo "El Capitan"
	elif [[ $model =~ $not_mojave_regex ]]; then
		echo "High Sierra"
	elif [[ $model =~ $not_catalina_regex ]]; then
		echo "Mojave"
	elif [[ $model =~ $not_bigsur_regex ]]; then
		echo "Catalina"
	elif [[ $model =~ $not_monterey_regex ]]; then
		echo "Big Sur"
	else
		echo "Monterey"
	fi
}

os_check() {
	# $1 = Max supported OS version based on hardware model
	# $2 = Current OS major version
	# $3 = Current OS minor version
	# $4 = Current OS patch version
	local validate_os="${1}"
	local os_major="${2}"
	local os_minor="${3}"
	local os_patch="${4}"

	if [[ ! "${mac_model}" =~ ^MacPro.*$ ]]; then

		if [[ "${validate_os}" == "Monterey" && ( "${os_major}" -ge 11 || "${os_major}" -eq 10 && "${os_minor}" -ge 9 ) ]]; then
			echo "Monterey"
		elif [[ "${validate_os}" == "Big Sur" && ( "${os_major}" -ge 11 || "${os_major}" -eq 10 && "${os_minor}" -ge 9 ) ]]; then
			echo "Big Sur"
		elif [[ "${validate_os}" == "Big Sur" && ( "${os_major}" -ge 11 || "${os_major}" -eq 10 && "${os_minor}" -le 8 ) ]]; then
			echo "El Capitan / OS Limitation"
		elif [[ "${validate_os}" == "Catalina" && "${os_major}" -eq 10 && "${os_minor}" -ge 9 ]]; then
			echo "Catalina"
		elif [[ "${validate_os}" == "Catalina" && "${os_major}" -eq 10 && "${os_minor}" -le 8 ]]; then
			echo "Mojave / OS Limitation"  # (Current OS Limitation, 10.15 Catalina)
		elif [[ "${validate_os}" == "Mojave" && "${os_major}" -eq 10 && "${os_minor}" -ge 8 ]]; then
			echo "Mojave"
		elif [[ "${validate_os}" == "High Sierra" && "${os_major}" -eq 10 && "${os_minor}" -ge 8 ]]; then
			echo "High Sierra"
		elif [[ "${validate_os}" == "High Sierra" && "${os_major}" -eq 10 && ( "${os_minor}" -ge 8 || "${os_minor}" -eq 7 && "${os_patch}" -ge 5 ) ]]; then
			echo "Sierra / OS Limitation"  # (Current OS Limitation, 10.13 Compatible)
		elif [[ "${validate_os}" == "El Capitan" && "${os_major}" -eq 10 && ( "${os_minor}" -ge 7 || "${os_minor}" -eq 6 && "${os_patch}" -ge 8 ) ]]; then
			echo "El Capitan"
		else
			echo "<result>Current OS Not Supported</result>"
			exit 0
		fi

	else
		# Because Apple had to make Mojave support for MacPro's difficult...  I have to add complexity to the original "simplistic" logic in this script.

		if [[ "${validate_os}" == "Monterey" ]]; then
			# Any MacPro model that is compatible with Monterey based on model identifier alone, is 100% compatible with Monterey,
			# since they wouldn't be compatible with any OS that is old, nor could they have incompatible hardware.
			# e.g. MacPro6,1 (i.e. 2013/Trash Cans) and newer
			echo "Monterey"

		elif [[ "${validate_os}" == "Mojave" && "${os_major}" -eq 10 && ( "${os_minor}" -ge 14 || "${os_minor}" -eq 13 && "${os_patch}" -ge 6 ) ]]; then
			# Supports Mojave, but required Metal Capable Graphics Cards and FileVault must be disabled.
			mac_pro_result="Mojave"

			# Check if the Graphics Card supports Metal
			if [[ $( /usr/sbin/system_profiler SPDisplaysDataType | /usr/bin/awk -F 'Metal: ' '{print $2}' | /usr/bin/xargs ) != *"Supported"* ]]; then
				mac_pro_result+=" / GFX unsupported"
			fi

			# Check if FileVault is enabled
			if [[ $( /usr/bin/fdesetup status | /usr/bin/awk -F 'FileVault is ' '{print $2}' | /usr/bin/xargs ) != "Off." ]]; then
				mac_pro_result+=" / FV Enabled"
			fi

			echo "${mac_pro_result}"

		elif [[ "${validate_os}" == "Mojave" && "${os_major}" -eq 10 && ( "${os_minor}" -le 12 || "${os_minor}" -eq 13 && "${os_patch}" -le 5 ) ]]; then
			echo "High Sierra / OS Limitation"  # Supports Mojave or newer, but requires a stepped upgrade path

		elif [[ "${validate_os}" == "Mojave" && "${os_major}" -eq 10 && ( "${os_minor}" -ge 8 || "${os_minor}" -eq 7 && "${os_patch}" -ge 5 ) ]]; then
			echo "Sierra / OS Limitation"  # (Current OS Limitation, 10.13 Compatible)

		elif [[ "${validate_os}" == "El Capitan" && "${os_major}" -eq 10 && ( "${os_minor}" -ge 7 || "${os_minor}" -eq 6 && "${os_patch}" -ge 8 ) ]]; then
			echo "El Capitan"

		else
			echo "<result>Current OS Not Supported</result>"
			exit 0
		fi

	fi
}

check_ram_upgradeable() {
	/usr/sbin/system_profiler SPMemoryDataType | /usr/bin/awk -F "Upgradeable Memory: " '{print $2}' | /usr/bin/xargs 2&> /dev/null
}

# Check if the current RAM meets specs
ram_check() {
	# $1 = Max supported OS version based on hardware model
	local validate_os="${1}"

	# Setting the minimum RAM required for compatibility
	minimum_ram_mojave_and_older=2
	minimum_ram_catalina_and_newer=4

	# Get RAM Info
	system_ram=$(( $( /usr/sbin/sysctl -n hw.memsize ) / bytes_in_gigabytes ))

	if [[ "${validate_os}" =~ ^(Catalina|Big\sSur|Monterey)$ ]]; then
		# OS version requires 4GB RAM minimum

		if [[ $system_ram -lt $minimum_ram_catalina_and_newer ]]; then
			# Based on RAM, device does not have enough to support Catalina or newer

			if [[ "$( check_ram_upgradeable )" == "No" ]]; then
				# Device is not upgradable, so can never support Catalina or newer

				if [[ $system_ram -ge $minimum_ram_mojave_and_older ]]; then
					# Device has enough RAM to support Mojave
					validate_os="Mojave"
				else
					# Device does not have enough RAM to support any upgrade!?
					echo "<result>Not Upgradable</result>"
					exit 0
				fi

			else
				# Device does not have enough RAM to upgrade currently, but RAM capacity can be increased.
				validate_os+=" / Insufficient RAM"
			fi

		fi

	else
		# Based on model, device supports Mojave or older
		if [[ $system_ram -lt $minimum_ram_mojave_and_older ]]; then
			# Based on RAM, device does not have enough to upgrade

			if [[ "$( check_ram_upgradeable )" == "No" ]]; then
				# Device does not have enough RAM to support any upgrade!?
				echo "<result>Not Upgradable</result>"
				exit 0
			else
				# Device does not have enough RAM to upgrade currently, but RAM capacity can be increased.
				validate_os+=" / Insufficient RAM"
			fi

		fi

	fi

	echo "${validate_os}"
}

# Check if the available free space is sufficient
storage_check() {
	# $1 = Max supported OS version based on hardware model
	# $2 = Current OS major version
	# $3 = Current OS minor version
	# $4 = Current OS patch version
	local validate_os="${1}"
	local os_major="${2}"
	local os_minor="${3}"
	local os_patch="${4}"

	# Get free space on the boot disk
	storage_free_space=$( /usr/bin/osascript -l 'JavaScript' -e "ObjC.import('Foundation'); var freeSpaceBytesRef=Ref(); $.NSURL.fileURLWithPath('/').getResourceValueForKeyError(freeSpaceBytesRef, 'NSURLVolumeAvailableCapacityForImportantUsageKey', null); Math.round(ObjC.unwrap(freeSpaceBytesRef[0]))" )

	# Set the required free space to compare.  Set space requirement in bytes:  /usr/bin/bc <<< "<space in GB> * 1073741824"
	case "${validate_os}" in
		"Monterey" )
			required_free_space_newer="27917287424" # 26GB if Sierra or later
			os_newer="10.12.0"
			required_free_space_older="47244640256" # 44GB if El Capitan or earlier
			os_older="10.11.0"
		;;
		"Big Sur" )
			required_free_space_newer="38117834752" # 35.5GB if Sierra or later
			os_newer="10.12.0"
			required_free_space_older="47781511168" # 44.5GB if El Capitan or earlier
			os_older="10.11.0"
		;;
		"Catalina"|"Mojave" )
			required_free_space_newer="13421772800" # 12.5GB if El Capitan 10.11.5 or later
			os_newer="10.11.5"
			required_free_space_older="19864223744" # 18.5GB if Yosemite or earlier
			os_older="10.10.0"
		;;
		"High Sierra" )
			required_free_space="15354508084" # 14.3GB
		;;
		"Sierra"|"El Capitan"* )
			required_free_space="9448928052" # 8.8GB
		;;
		* )
			echo "<result>Not Supported</result>"
			exit 0
		;;
	esac

	if [[ -z $required_free_space ]]; then
		newer_os_major=$( echo "${os_newer}" | /usr/bin/awk -F '.' '{print $1}' )
		newer_os_minor=$( echo "${os_newer}" | /usr/bin/awk -F '.' '{print $2}' )
		newer_os_patch=$( echo "${os_newer}" | /usr/bin/awk -F '.' '{print $3}' )
		older_os_major=$( echo "${os_older}" | /usr/bin/awk -F '.' '{print $1}' )
		older_os_minor=$( echo "${os_older}" | /usr/bin/awk -F '.' '{print $2}' )
		older_os_patch=$( echo "${os_older}" | /usr/bin/awk -F '.' '{print $3}' )

		# Check newer
		if [[ "${os_major}" -gt "${newer_os_major}" || 
			( "${os_major}" -eq "${newer_os_major}" &&
			  "${os_minor}" -ge "${newer_os_minor}" &&
			  "${os_patch}" -ge "${newer_os_patch}" ) ]]; then

			required_free_space=$required_free_space_newer

		# Check older
		elif [[ "${os_major}" -gt "${older_os_major}" || 
			  ( "${os_major}" -eq "${older_os_major}" &&
				"${os_minor}" -ge "${older_os_minor}" &&
				"${os_patch}" -ge "${older_os_patch}" ) ]]; then

			required_free_space=$required_free_space_older

		fi

	fi

	if [[  $storage_free_space -le $required_free_space ]]; then
		echo " / Insufficient Storage"
	fi

}

##################################################
# Bits Staged...

# Set the number of bytes in a gigabyte
bytes_in_gigabytes="1073741824" # $((1024 * 1024 * 1024)) # Transforms one gigabyte into bytes

# Get the current OS version
os_version=$( /usr/bin/sw_vers -productVersion )
current_os_major=$( echo "${os_version}" | /usr/bin/awk -F '.' '{print $1}' )
current_os_minor=$( echo "${os_version}" | /usr/bin/awk -F '.' '{print $2}' )
current_os_patch=$( echo "${os_version}" | /usr/bin/awk -F '.' '{print $3}' )

# Get the Model Type
mac_model=$( /usr/sbin/sysctl -n hw.model )

# Check for compatibility
model_result=$( model_check "${mac_model}" )
os_result=$( os_check  "${model_result}" "${current_os_major}" "${current_os_minor}" "${current_os_patch}" "${mac_model}" )
ram_check_results=$( ram_check "${os_result}" )
storage_check_results=$( storage_check "${os_result}" "${current_os_major}" "${current_os_minor}" "${current_os_patch}" )

echo "<result>${ram_check_results}${storage_check_results}</result>"
exit 0
