#!/bin/sh
set -e

if test "$(whoami)" != "root"; then
	echo "===> Error! Shell should be executed by root."
	exit 2
fi

configFolderPath=/etc/wireguard

if test -f "${configFolderPath}/server_keys/privatekey" -a -f "${configFolderPath}/server_keys/publickey"; then
	echo "===> OK! Server keys exist."
	exit
fi

wg genkey | tee ${configFolderPath}/server_keys/privatekey | wg pubkey > ${configFolderPath}/server_keys/publickey

