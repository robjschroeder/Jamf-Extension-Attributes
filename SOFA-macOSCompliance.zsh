#!/bin/zsh --no-rcs
# Check macOS version compatibility with latest release or security release within last 30 days. 

# You can use the N-Rule variable to set the amount of compliant minior releases previous to the latest version

# autoload is-at-least module for version comparisons
autoload -U is-at-least

# N-rule variable [How many previous minor OS path versions will be marked as compliant, i.e., if the latest release is 14.6, set this variable to "2" to mark `14.5` and `14.4.1` as compliant
n="2"

# URL to the online JSON data
online_json_url="https://sofafeed.macadmins.io/v1/macos_data_feed.json"
user_agent="SOFA-Jamf-EA-macOSVersionCheck/1.0"

# local store
json_cache_dir="/private/tmp/sofa"
json_cache="$json_cache_dir/macos_data_feed.json"
etag_cache="$json_cache_dir/macos_data_feed_etag.txt"

# ensure local cache folder exists
/bin/mkdir -p "$json_cache_dir"

# check local vs online using etag
if [[ -f "$etag_cache" && -f "$json_cache" ]]; then
    echo "e-tag stored, will download only if e-tag doesn't match"
    etag_old=$(/bin/cat "$etag_cache")
    /usr/bin/curl --compressed --silent --etag-compare "$etag_cache" --etag-save "$etag_cache" --header "User-Agent: $user_agent" "$online_json_url" --output "$json_cache"
    etag_new=$(/bin/cat "$etag_cache")
    if [[ "$etag_old" == "$etag_new" ]]; then
        echo "Cached ETag matched online ETag - cached json file is up to date"
    else
        echo "Cached ETag did not match online ETag, so downloaded new SOFA json file"
    fi
else
    echo "No e-tag cached, proceeding to download SOFA json file"
    /usr/bin/curl --compressed --location --max-time 3 --silent --header "User-Agent: $user_agent" "$online_json_url" --etag-save "$etag_cache" --output "$json_cache"
fi

echo

# 1. Get model (DeviceID)
model=$(/usr/sbin/sysctl -n hw.model)
echo "Model Identifier: $model"

# check that the model is virtual or is in the feed at all
if [[ $model == "VirtualMac"* ]]; then
    # if virtual, we need to arbitrarily choose a model that supports all current OSes. Plucked for an M1 Mac mini
    model="Macmini9,1"
elif ! grep -q "$model" "$json_cache"; then
    echo "<result>Unsupported Hardware</result>"
    exit
fi

# 2. Get current system OS
system_version=$( /usr/bin/sw_vers -productVersion )
# system_version=15.0.1 # UNCOMMENT TO TEST OLDER VERSIONS
system_os=$(cut -d. -f1 <<< "$system_version")
echo "System Version: $system_version"

if [[ $system_version == *".0" ]]; then
    system_version=${system_version%.0}
    echo "Corrected System Version: $system_version"
fi

echo

# exit if less than macOS 12
if ! is-at-least 12 "$system_os"; then
    echo "<result>Unsupported macOS</result>"
    exit
fi

# 3. idenfity latest compatible major OS
latest_compatible_os=$(/usr/bin/plutil -extract "Models.$model.SupportedOS.0" raw -expect string "$json_cache" | /usr/bin/head -n 1)
echo "Latest Compatible macOS: $latest_compatible_os"

# 4. Get OSVersions.Latest.ProductVersion
for i in {0..3}; do
    os_version=$(/usr/bin/plutil -extract "OSVersions.$i.OSVersion" raw "$json_cache" | /usr/bin/head -n 1 | grep -v "<stdin>")
    if [[ $os_version ]]; then
        if [[ "$os_version" == "$latest_compatible_os" ]]; then
            product_version=$(/usr/bin/plutil -extract "OSVersions.$i.Latest.ProductVersion" raw "$json_cache" | /usr/bin/head -n 1)
            echo "Latest Compatible macOS Version: $product_version"
        fi
    fi
done

echo

if is-at-least "$product_version" "$system_version"; then
    echo "System is up to date"
    echo "<result>Compliant OS Version</result>"
    exit
fi


# Current date and date 30 days ago in seconds since epoch
current_date=$(date +%s)
days_ago_30=$(date -v-30d +%s)

# Loop through OS versions to find matching and latest OS version
security_update_within_30_days=false
latest_version_match=false

for i in {0..3}; do
    os_version=$(/usr/bin/plutil -extract "OSVersions.$i.OSVersion" raw "$json_cache" | /usr/bin/head -n 1)
    
    if [[ -z "$os_version" ]]; then
        break
    fi

    latest_product_version=$(/usr/bin/plutil -extract "OSVersions.$i.Latest.ProductVersion" raw "$json_cache" | /usr/bin/head -n 1)

    if [[ "$latest_product_version" == "$system_version" ]]; then
        latest_version_match=true
        break
    fi

    num_security_releases=$(/usr/bin/plutil -extract "OSVersions.$i.SecurityReleases" raw "$json_cache" | xargs | awk '{ print $1}' )

    if [ -n "$num_security_releases" ] && [ "$num_security_releases" -eq "$num_security_releases" ] 2>/dev/null; then
        for ((j=0; j<num_security_releases; j++)); do
            security_release_product_version=$(/usr/bin/plutil -extract "OSVersions.$i.SecurityReleases.$j.ProductVersion" raw "$json_cache" | /usr/bin/head -n 1)
            if [[ "${system_version}" == "${security_release_product_version}" ]]; then
                echo "$security_release_version"
                security_release_date=$(/usr/bin/plutil -extract "OSVersions.$i.SecurityReleases.$j.ReleaseDate" raw "$json_cache" | /usr/bin/head -n 1)
                echo "Security Release Date: $security_release_date"
                security_release_date_epoch=$(date -jf "%Y-%m-%dT%H:%M:%SZ" "$security_release_date" +%s)
                echo "Security Release Date EPOCH: $security_release_date_epoch"
                if (( $j <= "$n" )); then
                    echo "This is within n-$n release, should be marked compliant"
                    n_rule=true
                else
                    echo "This is more than n-$n, non-compliant OS" > /dev/null 2>&1
                fi

            else
                echo "Checking next security release..." > /dev/null 2>&1
            fi
            
            if [[ $security_release_date_epoch -ge $days_ago_30 ]]; then
                security_update_within_30_days=true
            fi
        done

    else
        echo not a number > /dev/null 2>&1
    fi
done
   
if [[ "$latest_version_match" == true ]] || [[ "$security_update_within_30_days" == true ]] || [[ "$n_rule" == true ]]; then
    echo "<result>Compliant OS Version</result>"
else
    echo "<result>Non-Compliant OS Version</result>"
fi
