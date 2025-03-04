# mynix

## Local

```bash
# Start interactive nix container
make env
# Build only package
nix build .#my-go
# Build and run package
nix run .#my-go
```

## Update

```bash
nix run github:Mic92/nix-update -- --flake kubernetes
```
