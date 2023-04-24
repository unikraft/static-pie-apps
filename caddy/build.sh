#!/bin/sh

# Clean up
rm -rf caddy-*
rm -f v2.*

echo "Downloading caddy source code... "
wget -q https://github.com/caddyserver/caddy/archive/refs/tags/v2.6.2.tar.gz

echo "Unpacking caddy source code..."
tar xzf v2.6.2.tar.gz

echo "Building caddy... "
cd caddy-2.6.2/cmd/caddy
CGO_ENABLED=1 go build -buildmode=pie -ldflags "-linkmode external -extldflags "-static-pie""
echo ""
