#!/bin/sh
set -e

if test "$(whoami)" != "root"; then
	echo "===> Error! Shell should be executed by root."
	exit 2
fi

configFolderPath=/etc/wireguard

echo "===> Checking basic settings"
basicSettingFilePath=${configFolderPath}/basic_env.sh
if test -f "${basicSettingFilePath}"; then
	source "${basicSettingFilePath}"
fi

if test -z "${WG_INTERFACE}"; then
	WG_INTERFACE=wg0
	echo "export WG_INTERFACE=${WG_INTERFACE}" >> ${configFolderPath}
fi
echo "- wireguard interface: ${WG_INTERFACE}"

echo "===> Checking server keys..."
if test -f "${configFolderPath}/server_keys/privatekey" -a -f "${configFolderPath}/server_keys/publickey"; then
	echo "OK! Server keys exist."
else
	echo "Server keys are not found. Creating server keys..."
	mkdir -p ${configFolderPath}/server_keys
	wg genkey | tee ${configFolderPath}/server_keys/privatekey | wg pubkey > ${configFolderPath}/server_keys/publickey
	echo "Done"
fi


