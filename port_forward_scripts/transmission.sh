#/bin/sh
NEW_PEER_PORT=$1
transmission_rpc_url="http://$TRANSMISSION_RPC_USERNAME:$TRANSMISSION_RPC_PASSWORD@$TRANSMISSION_RPC_HOST:$TRANSMISSION_RPC_PORT/transmission/rpc"

sleep 30
echo "Using User $TRANSMISSION_RPC_USERNAME to configure transmission $transmission_rpc_url"

get_session_id() {
  curl --silent $transmission_rpc_url | sed "s/.*<code>//g;s/<\/code>.*//g"
}

SESSION_ID=$(get_session_id)

if [ -z "$SESSION_ID" ]; then
    echo "Failed to retrieve session ID."
    exit 1
fi

echo "Setting Peer-Port of Transmission to $NEW_PEER_PORT"
curl --silent --header "$SESSION_ID" $transmission_rpc_url -d "{\"method\":\"session-set\",\"arguments\": {\"peer-port\": $NEW_PEER_PORT}}"
