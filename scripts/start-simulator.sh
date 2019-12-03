#!/bin/bash
# This script boots and starts an iOS simulator using its name as parameter
# It requires applesimutils to be installed (https://github.com/wix/AppleSimulatorUtils)

if [ $# -eq 0 ]; then
    echo "Usage $0 [name]"
    exit 1
fi

simulator_name=$1

# Test is simulator is already booted
booted_udid=$(applesimutils --byName "$simulator_name" --booted -l | awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'udid'\042/){print $(i+1)}}}' | tr -d '"' | sed -n 1p| tr -d '[:space:]')

# If no : boot it
if [ "$booted_udid" = "" ]; then 
    udid=$(applesimutils --byName "$simulator_name" -l | awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'udid'\042/){print $(i+1)}}}' | tr -d '"' | sed -n 1p| tr -d '[:space:]')
    if [ "$udid" = "" ]; then
        # Device not found
        echo "No simulator with name \"$simulator_name\" found"
        exit 1
    fi
    xcrun simctl boot $udid
fi

# Then start it
open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/