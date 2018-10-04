#!/bin/bash

# Anonymization framework by DKF Sivert
# Firewall configured with iptables

export BLUE='\033[1;94m'
export GREEN='\033[1;92m'
export RED='\033[1;91m'
export RESET='\033[1;00m'


VPN_PATH="/etc/openvpn/ovpn_udp/"
AUTH_PATH="/etc/openvpn/auth.txt"

IFACE="eth0"
IFACE_IP="192.168.40.1"
IFACE_NM="255.255.255.0"
IFACE_BC="192.168.40.255"


function random_vpn {
	choice=$(ls $VPN_PATH | shuf -n 1)
	VPN_IP=$( sed -n '/^remote/p' ${VPN_PATH}$choice | head -n 1 | sed 's/ /\n/g' | head -2 | tail -1 )

}

function init_fw {
	ifconfig $IFACE $IFACE_IP netmask $IFACE_NM broadcast $IFACE_BC
	service isc-dhcp-server restart
	iptables -A OUTPUT -d $VPN_IP -j ACCEPT
	iptables -A INPUT -s $VPN_IP -j ACCEPT
}

function start_daemons {
	openvpn --config $VPN_PATH$choice --auth-user-pass $AUTH_PATH --daemon
	sudo -u debian-tor tor -f /etc/tor/torrc --RunAsDaemon 1
}

function check_root {
	if [ $(id -u) -ne 0 ]; then
		echo -e "${RED}This script must be run as root${RESET}" >&2
		exit 1
	fi
}

function stop {
	echo "Stopping the anonymization framework. Please disconnect all your devices" | festival --tts
	pkill openvpn
	pkill tor
	echo -e "${RED}Disconnected. All outgoing/incoming connections are blocked.${RESET}"
}

function start {
	echo "Initializing the anonymization framework, choosing a random VPN" | festival --tts
	random_vpn
	echo -e "${RESET}Choosing VPN: ${RED}$choice${RESET} with IP: ${RED}$VPN_IP"
	echo -e "${GREEN}Starting the Anonymization Network ..."
	init_fw
	echo -e "${BLUE}Starting OpenVPN/TOR daemons ..."
	start_daemons
	echo "The anonymization framework has been initialized successfully. You are now completely anonymous." | festival --tts
	echo -e "${GREEN}Done!$RESET"
}
check_root
case "$1" in 
	start )
		start ;;
	stop ) 
		stop ;;
	* )
		echo "Usage ./anon.sh start/stop"
		exit 1
esac

