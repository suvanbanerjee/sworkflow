#!/usr/bin/env bash

#
# Copyright (C) 2019 Saalim Quadri (danascape)
#
# SPDX-License-Identifier: Apache-2.0 license
#

# Check if the kernel config already exists for a particular device.
# This check is being performed to add support for official devices.
function check_kernel() {
	local device
	device="$1"
	echo "Checking if kernel config exists for $device"
	if [[ -n $(find -L $SW_SRC_DIR/device -maxdepth 2 -name "sworkflow.$device.config") ]]; then
		for dir in device; do
			for f in $(cd "$SW_SRC_DIR" && test -d $dir && \
				find -L $SW_SRC_DIR -maxdepth 4 -name "sworkflow.$device.config" | sort); do
				        echo "including $f"; . "$f" --source-only
			done
		done
		echo "warning: sworkflow.$device.config found"
		echo "warning: Exporting the defined variables"
	elif [[ -n $(find -L $(pwd) -maxdepth 2 -name "sworkflow.$device.config") ]]; then
		for dir in device; do
			for f in $(cd $(pwd) && test -d $dir && \
				find -L $(pwd) -maxdepth 4 -name "sworkflow.$device.config" | sort); do
				        echo "including $f"; . "$f" --source-only
			done
		done
		echo $test
		echo "warning: sworkflow.$device.config found outside the tree"
		echo "warning: Exporting the variables"
	else
		echo "error: No config file found"
		echo "error: Refer to docs for more"
	fi

}

function kernel_build() {
	echo "Starting Kernel Build!"
	device="$3"
	check_kernel $device
}
