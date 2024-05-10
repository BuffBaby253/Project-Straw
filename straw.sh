#!/bin/bash

# Author: BuffBaby253
# Title: Project Straw
# Description: Captures all nearby WiFi Traffic into PCAP form
# Version 1.2

echo "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNk:,,:xWWWWWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWKd:o0NNkclXWWWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNOlckNWWWWWKlc0WWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWXx:o0WWWWWWWWWNd:kWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW0o:dXWWWWWWWWWWWWWO:oNWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNkclONWWWWWWWWWWWWWWWWKccKWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWW0d:dKWWWWWWWWWWWWWWWWWWWWNo:kWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWNOlckNWWWWWWWWWWWWWWWWWWWWWWWWx:OWW
WWWWWWWWWWWWWWWWWWWWWWWWWKx:o0WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWOlcxXWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWWWWWWWWXxclOWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWWWWWW0o:dXWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWWWNkclkNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWKd:dKWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWOlcxNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWXxclOWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWW0dcdKWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWNOllkNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWNdd0WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"

echo "Hello, please plug in your wifi adapter and tell me how long you want this to run in seconds"

read sleep

echo "I will now do as you wish, wait quietly please and thank you"

sleep 3

# Define the output directory
output_dir="captures"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Set Wlan1 to monitor mode
airmon-ng start wlan1

# Start airodump-ng to capture traffic
airodump-ng --write "$output_dir/capture" --output-format pcap wlan1 &

# Wait for a few seconds to allow airodump-ng to capture some data
sleep $sleep

echo "One moment please as I sort all the work"

# Extract SSIDs from the capture file

ssids=$(tshark -r capture-01.pcap -Y wlan.ssid -T fields -e wlan.ssid | uniq)

sleep $sleep

# Loop through each SSID and save the output to a separate file

for ssid in $ssids; do

  echo "Saving output for SSID $ssid..."

  tshark -r capture-01.pcap -Y wlan.ssid==$ssid -w "$ssid".pcap

done

sleep 10

echo "Capture completed. Files saved in $output_dir."

sleep 3
