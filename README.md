# mynix

## Local

```bash
# Start interactive nix container
make it
# Enable flakes
echo "experimental-features = nix-command flakes" >>/etc/nix/nix.conf
# Build only package
nix build .#my-go
# Build and run package
nix run .#my-go
```

## Update

```bash
nix run github:Mic92/nix-update -- --flake kubernetes
```
