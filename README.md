# RPI-Anonymous-Box
Reisources necessary to set up a physically-isolated environment (using Raspberry PI 3B) for anonymous internet usage.
The setup consists of two computers, one of them is a Raspberry pi 3B connected to the internet via WiFi, and a second computer which will be connected directly to the Pi by Ethernet. The second computer can't have any other network connectivity except for this Ethernet port.

The idea is to route everything from the Workstation to the Pi, which in turn will route everything through VPN, and then through Tor.

## Requirements
Hardware requirements:
- Separate PC/Laptop, remove WiFi adapter if present
- Raspberry Pi 3B
- 1x Ethernet cable
- 1x MicroUSB power supply for the Pi
- Spare keyboard/mouse for the Pi

Software requirements (for the Pi):
- isc-dhcp-server 
- nyx (optional) for monitoring TOR usage
- tor
- openvpn

## Contents of the repository
- dhcpdc.conf - configuration for the dhcp server, which provides a mini-network on the Ethernet
- anon.sh - this script will make everything easier. After configuring iptables and dhcpd you just need to type "anon start" to initialize the Network
- rules.v4 - these are iptables rules necessary to prevent any leaks

## WARNING! YOU NEED TO REPLACE MY SETTINGS WITH YOUR OWN ESPECIALLY IN IPTABLES AND RELATED 

## Gallery




