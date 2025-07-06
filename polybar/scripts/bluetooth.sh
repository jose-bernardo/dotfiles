#!/bin/bash

bluetooth_print() {
  if rc-service bluetooth status | grep -q "started"; then
    devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
    counter=0

    for device in $devices_paired; do
      device_info=$(bluetoothctl info "$device")

      if echo "$device_info" | grep -q "Connected: yes"; then
        device_output=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)
        device_battery_percent=$(echo "$device_info" | grep "Battery Percentage" | awk -F'[()]' '{print $2}')

        if [ -n "$device_battery_percent" ]; then
          device_output="$device_output ($device_battery_percent)"
        fi

        counter=$((counter + 1))

        if [ $counter -gt 1 ]; then
          printf ", %s" "$device_output"
        else
          printf "%s" "$device_output"
        fi
      fi
    done

    if [ $counter -eq 0 ]; then
      printf "No devices"
    fi
  fi
}

bluetooth_print
