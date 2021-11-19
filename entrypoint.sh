#!/usr/bin/env sh

######################################################################
# @author      : chedim (chedim@couchbaser)
# @file        : cmd
# @created     : Friday Nov 19, 2021 03:44:41 EST
#
# @description : CMD for docker 
######################################################################

exec 2>&1

echo Starting Couchbase
# Create directories where couchbase stores its data
cd /opt/couchbase
mkdir -p var/lib/couchbase \
         var/lib/couchbase/config \
         var/lib/couchbase/data \
         var/lib/couchbase/stats \
         var/lib/couchbase/logs \
         var/lib/moxi

# Ensure everything in var is owned and writable to Server.
# Skip "inbox" as it may contain readonly-mounted things like k8s certs.
find var -path var/lib/couchbase/inbox -prune -o -print0 | \
  xargs -0 chown --no-dereference couchbase:couchbase

if [ "$(whoami)" = "couchbase" ]; then
  nohup /opt/couchbase/bin/couchbase-server -- -kernel global_enable_tracing false -noinput &
else
  nohup chpst -ucouchbase  /opt/couchbase/bin/couchbase-server -- -kernel global_enable_tracing false -noinput &
fi

cd /home/jovyan
echo Starting jupyter
sudo -u jovyan /home/jovyan/.local/bin/jupyter notebook --debug


