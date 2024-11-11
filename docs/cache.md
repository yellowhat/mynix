# Nix cache

## Hosted on cachix

1. [cachix.org](https://cachix.org) > `New Cache`:
  * `Unique name`: ``
  * `Visibility`: `Public`
  * `Signing`: `Managed by Cachix`
2. Cache > `Settings` > `Auth Token`, copy token to `CACHIX_AUTH_TOKEN`

### Test

```bash
podman run \
    --interactive \
    --tty \
    --rm \
    docker.io/nixos/nix:latest

nix-channel --add https://github.com/yellowhat/mynix/archive/main.tar.gz mynix
nix-channel --update
nix-channel --list

nix profile install \
    github:yellowhat/mynix#my-go \
    --extra-substituters https://mynix-cache.cachix.org \
    --extra-trusted-public-keys mynix-cache.cachix.org-1:tM9YqUHoCWI7FQwQ0vzmp8RY3pRmwylTC/xHCFU6A6E= \
    --no-write-lock-file \
    --impure

# non-flake version
# nix-env \
#     --install \
#     --attr mynix.my-go \
#     --extra-substituters https://mynix-cache.cachix.org \
#     --extra-trusted-public-keys mynix-cache.cachix.org-1:tM9YqUHoCWI7FQwQ0vzmp8RY3pRmwylTC/xHCFU6A6E= \
#     --dry-run
```

## Hosted on GitHub Pages

Enable Pages: `Settings` > `Pages` > `Build and deployment`:
  * `Source`: `GitHub Actions`

### Local

```bash
podman run \
    --interactive \
    --tty \
    --rm \
    --volume "${PWD}:/data" \
    --workdir /data \
    --security-opt label=disable \
    docker.io/nixos/nix:latest

# Build
# nix-build -E 'with import <nixpkgs> {}; callPackage ./packages/hello/default.nix {}'
nix-build
./result/bin/hello

nix-store --query --references ./result
```

### Test?

```bash
# echo "experimental-features = nix-command flakes" >>/etc/nix/nix.conf
# echo "extra-substituters = https://yellowhat.github.io/mynix" >>/etc/nix/nix.conf
# echo "extra-trusted-public-keys = yellowhat.github.io:My56...Q==%" >>/etc/nix/nix.conf

nix-channel --add https://github.com/yellowhat/mynix/archive/main.tar.gz mynix
nix-channel --update
nix-channel --list

nix-env --query --available --status -f https://github.com/yellowhat/mynix/archive/main.tar.gz

curl https://yellowhat.github.io/mynix/cache.nar | nix-store --import

# nix-env --install --attr mynix.my-go
nix-env --install --attr mynix.my-go --substituters https://yellowhat.github.io/mynix --dry-run
```

```bash
curl https://yellowhat.github.io/mynix/nix-cache-info
curl https://yellowhat.github.io/mynix/a15rcr5mv738jdy153axxa31bsmrdx4d-my-go-1.0.0.narinfo
curl https://yellowhat.github.io/mynix/nar/a15rcr5mv738jdy153axxa31bsmrdx4d-my-go-1.0.0.nar -o /tmp/nar
```

### Links

* <https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/deploying.html>
* <https://bmcgee.ie/posts/2023/06/nats-building-a-nix-binary-cache/>
* <https://github.com/fzakaria/nix-http-binary-cache-api-spec/blob/main/api.yaml>
