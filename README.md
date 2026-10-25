# wwn-uutils-rs

[![CI](https://github.com/Wawona/wwn-uutils-rs/actions/workflows/ci.yml/badge.svg)](https://github.com/Wawona/wwn-uutils-rs/actions/workflows/ci.yml)

**Owner of Wawona's uutils/coreutils stack** for App Store Mode A (Apple-mobile
family + the same in-process path on other targets): pin, patch, safe subset,
and multicall recipes.

[uutils/coreutils](https://github.com/uutils/coreutils) is fetched pristine and
patched at build time into a static library exposing `wawona_coreutils_main()`.

Wawona (L4) only **consumes** this flake. It must not re-own the upstream pin
or invent a second safe-subset list.

## Authority files

| Path | Role |
|------|------|
| `dependencies/libs/coreutils/coreutils-src.nix` | Upstream pin (0.12.0) |
| `dependencies/libs/coreutils/patch-coreutils-source.sh` | staticlib + C entry |
| `dependencies/libs/coreutils/safe-subset.txt` | Mode A in-process util names |
| `docs/PATCH-BUDGET.md` | How to grow (or refuse) patches |
| `docs/APPLE-MOBILE-BACKENDS.md` | No Swift backends; libssh2/zsh peers |

## Use

```nix
inputs.wwn-uutils-rs.url = "github:Wawona/wwn-uutils-rs/development";

# Pristine pin (do not duplicate fetchFromGitHub in the consumer):
src = wwn-uutils-rs.lib.coreutilsSrc pkgs;

# Patched source tree for the Rust backend Cargo path-dep:
patched = wwn-uutils-rs.lib.mkPatchedSrc { inherit pkgs; platform = "ios"; };

# macOS/Android multicall binary (fork/exec-allowed platforms):
multicall = wwn-uutils-rs.lib.mkMulticall { inherit pkgs; };

# Safe subset path for sync checks:
subset = wwn-uutils-rs.lib.safeSubsetFile;
```

## Standalone build

```sh
nix build .#coreutils-multicall
nix build .#coreutils-patched-src-ios
```

## License

MIT for the Wawona Nix packaging / patches (see `LICENSE`). uutils-coreutils is MIT;
its source is fetched from upstream at build time.
