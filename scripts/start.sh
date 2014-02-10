#!/usr/bin/env bash

/opt/scripts/send_notifies.sh &
/usr/bin/nsd -d -c /etc/nsd/nsd/conf

