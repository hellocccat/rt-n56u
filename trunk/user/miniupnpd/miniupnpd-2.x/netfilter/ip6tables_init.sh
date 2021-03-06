#! /bin/sh
# $Id: ip6tables_init.sh,v 1.2 2018/04/06 09:21:11 nanard Exp $
# Improved Miniupnpd iptables init script.
# Checks for state of filter before doing anything..

IPV6=1
EXT=1
. $(dirname "$0")/miniupnpd_functions.sh

if [ "$FDIRTY" = "${CHAIN}Chain" ]; then
	echo "Filter table dirty; Cleaning..."
elif [ "$FDIRTY" = "Chain" ]; then
	echo "Dirty filter chain but no reference..? Fixing..."
	$IPTABLES -t filter -A FORWARD -i $EXTIF ! -o $EXTIF -j $CHAIN
else
	echo "Filter table clean..initalizing.."
	$IPTABLES -t filter -N $CHAIN
	$IPTABLES -t filter -A FORWARD -i $EXTIF ! -o $EXTIF -j $CHAIN
fi
if [ "$CLEAN" = "yes" ]; then
	$IPTABLES -t filter -F $CHAIN
fi
