#!/bin/sh
set -e

if test "$(whoami)" != "root"; then
	echo "===> Error! Shell should be executed by root."
	exit 2
fi

configFolderPath=/etc/wireguard

read -p "New client name: " newClient
if test -d "${configFolderPath}/client_keys/${newClient}"; then
	echo "===> Error. '${newClient}' already exists."
	exit 2
fi

mkdir -p ${configFolderPath}/client_keys/${newClient}
wg genkey | tee ${configFolderPath}/client_keys/${newClient}/privatekey | wg pubkey > ${configFolderPath}/client_keys/${newClient}/publickey

echo "===> Client keys is generated in '${configFolderPath}/client_keys/${newClient}'"
