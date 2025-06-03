#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <email-address>"
    exit 1
fi

EMAIL="$1"

ssh-keygen -t ed25519 -C $EMAIL
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Your SSH public key is below. Add it to your GitHub account."
cat ~/.ssh/id_ed25519.c