# mynix

## Local

```bash
# Start interactive nix container
make it
# Enable flakes
echo "experimental-features = nix-command flakes" >>/etc/nix/nix.conf
# Build package
nix build .#my-go
```

## Update

```bash
nix run github:Mic92/nix-update -- --flake kubernetes
```
