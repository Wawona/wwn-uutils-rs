# Pristine upstream uutils/coreutils source pin (patch-overlay model). Vendored
# as the in-process ls/cat/cp/... multicall for the App-Store-compliant build
# (no fork/exec). Patched at build time by patch-coreutils-source.sh.
{ pkgs }:
pkgs.fetchFromGitHub {
  owner = "uutils";
  repo = "coreutils";
  rev = "0.12.0";
  sha256 = "sha256-/Zi7/vh8hwniMxa+keYjW7KBeq3Xg2rqDlqyN2GOZN4=";
}
