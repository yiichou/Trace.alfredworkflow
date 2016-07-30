#!/bin/bash

# Source the workflow library
. workflowHandler.sh

# Config file
PROFILE_CONF='proxy.conf'

# Icons folder
ICONS_DIR="./icons"

# Current device
DEVICE=''

# ======== private ========
function get_curr_proxy_url()
{
    networksetup -getautoproxyurl $DEVICE | grep URL | awk '{print $2}'
}

function get_curr_socks_server()
{
    networksetup -getsocksfirewallproxy $DEVICE | grep Server | awk '{print $2}'
}

function get_curr_socks_port()
{
    networksetup -getsocksfirewallproxy $DEVICE | grep Port | awk '{print $2}'
}

function get_curr_proxy_state()
{
    networksetup -getautoproxyurl $DEVICE | grep Enabled | awk '{print $2}'
}

function get_curr_socks_state()
{
    networksetup -getsocksfirewallproxy $DEVICE | grep -E '^Enabled' | awk '{print $2}'
}

function get_curr_proxy_setting()
{
    if [[ $(get_curr_proxy_state) = 'Yes' ]]; then
        proxy_setting=$(get_curr_proxy_url)
    elif [[ $(get_curr_socks_state) = 'Yes' ]]; then
        proxy_setting="$(get_curr_socks_server):$(get_curr_socks_port)"
    else
        proxy_setting=''
    fi
    
    echo $proxy_setting
}
# ======== private ========

# Generate feedback results
function list_proxy()
{
    local cnt=0
    local curr_setting=$(get_curr_proxy_setting)
    local title subtitle arg icon
    
    while IFS=' ' read proxy_name proxy_setting; do
        uid="trace-$cnt"
        let cnt+=1
    
        icon="$ICONS_DIR/$proxy_name.png"
    
        # Use default workflow icon if not found
        if [ ! -f "$icon" ]; then
            icon="icon.png"
        fi
    
        if [[ $curr_setting = $proxy_setting ]]; then
            title="Now: $proxy_name"
        else
            title="$proxy_name"
        fi
        
        if [ ${proxy_setting:0:4} = 'http' ]; then
            title="$title [AutoProxy]"
        else
            title="$title"
        fi

        subtitle="$proxy_setting"
        arg="$proxy_name $proxy_setting"

        addResult "$uid" "$arg" "$title" "$subtitle" "$icon" "yes"
    done <<EOF
`grep -vE '^#.*' $PROFILE_CONF`
off Close all proxy
EOF
    
    # Show feedback results
    getXMLResults
}

# Turn on the choice proxy
function on()
{
    if [ ${2:0:4} = 'http' ]; then
        sudo networksetup -setsocksfirewallproxystate $DEVICE off
        sudo networksetup -setautoproxyurl $DEVICE $2
        echo "$1 AutoProxy, TRACE ON"
    else
        domain=$(echo "$2" | awk -F: '{print $1}')
        port=$(echo "$2" | awk -F: '{print $2}')
        
        if [[ $domain != '' ]]&&[[ $port != '' ]]; then
            sudo networksetup -setautoproxystate $DEVICE off
            sudo networksetup -setsocksfirewallproxy $DEVICE $domain $port
            echo "$1, TRACE ON！"
        else
            echo "TRACE FAILED"
        fi
    fi
}

# Turn off all proxy
function off()
{
    sudo networksetup -setautoproxystate $DEVICE off
    sudo networksetup -setsocksfirewallproxystate $DEVICE off
    echo "TRACE END"
}

# The main entry
function main()
{
    local device=$(networksetup -listnetworkserviceorder | awk '
        BEGIN {
            "netstat -rn | grep default " | getline var
            split(var, ARRAY, " ")
        }

        { if ($5 ~ ARRAY[6]) { NAME=$3 } }

        END { print NAME }
    ')
    
    DEVICE=${device%,*}
    
    case $1 in
        list_proxy)
        list_proxy $2
        ;;
        
        off)
        off
        ;;
        
        *)
        on "$1" "$2"
        ;;
    esac
}

main "$@" # Run from here
