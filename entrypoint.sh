#!/bin/bash
set -eu

# Create SSH path if it doesn't exist
SSHPATH="$HOME/.ssh"
if [ ! -d "$SSHPATH" ]; then
  mkdir -p "$SSHPATH"
fi

# Add the deploy key to the SSH path
echo "$DEPLOY_KEY" > "$SSHPATH/key"
chmod 600 "$SSHPATH/key"

# Define the server deployment string
SERVER_DEPLOY_STRING="$USERNAME@$SERVER_IP:$SERVER_DESTINATION"

# Sync files using rsync
sh -c "rsync $ARGS -e 'ssh -i $SSHPATH/key -o StrictHostKeyChecking=no -p $SERVER_PORT' $GITHUB_WORKSPACE/$FOLDER $SERVER_DEPLOY_STRING"

# Run the specified script on the server after deployment
ssh -i "$SSHPATH/key" -o StrictHostKeyChecking=no -p "$SERVER_PORT" "$USERNAME@$SERVER_IP" << 'EOF'
$SCRIPT
EOF
