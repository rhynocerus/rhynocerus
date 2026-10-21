#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Syft QA — v1.0 — RHYNUS Interactive Works (RIW)
set -euo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
work="${SYFT_QA_WORKDIR:-$root/.work}"
sha=f15c3343e29dfb20cf6d82c820e7090b49808c96
version=1.26.8
for tool in git curl tar python3; do command -v "$tool" >/dev/null; done
[[ "$(uname -s)/$(uname -m)" == Linux/x86_64 ]] || {
  echo 'Este instalador prepara Linux x86_64. En otras plataformas instala Go 1.26.8 y usa run.sh.' >&2
  exit 2
}
mkdir -p "$work"
archive="$work/go${version}.linux-amd64.tar.gz"
curl --fail --location --retry 3 "https://go.dev/dl/go${version}.linux-amd64.tar.gz" -o "$archive"
python3 - "$archive" <<'PY'
import hashlib, pathlib, sys
p = pathlib.Path(sys.argv[1])
expected = 'd0f743b33e8d8945e6b1f432edd15785c70507121d6e2a723b21285eddf8b57b'
actual = hashlib.sha256(p.read_bytes()).hexdigest()
if actual != expected:
    raise SystemExit('SHA-256 incorrecto: descarga rechazada')
print('SHA-256 oficial verificado:', actual)
PY
mkdir -p "$work/toolchain"
tar --no-same-owner -xzf "$archive" -C "$work/toolchain"
export PATH="$work/toolchain/go/bin:$PATH"
export GOTOOLCHAIN=local
if [[ ! -e "$work/syft" ]]; then
  git init "$work/syft"
  git -C "$work/syft" remote add origin https://github.com/anchore/syft.git
  git -C "$work/syft" fetch --depth=1 origin "$sha"
  git -C "$work/syft" checkout --detach FETCH_HEAD
fi
[[ "$(git -C "$work/syft" rev-parse HEAD)" == "$sha" ]] || {
  echo 'El directorio existente corresponde a otra revisión; usa otro SYFT_QA_WORKDIR.' >&2
  exit 2
}
go -C "$work/syft" mod download
if [[ "${SYFT_QA_FIXTURES:-true}" == true ]]; then
  curl --fail --location --retry 3 \
    https://github.com/oras-project/oras/releases/download/v1.3.4/oras_1.3.4_linux_amd64.tar.gz \
    -o "$work/oras.tar.gz"
  python3 - "$work/oras.tar.gz" <<'PY'
import hashlib, pathlib, sys
actual = hashlib.sha256(pathlib.Path(sys.argv[1]).read_bytes()).hexdigest()
if actual != 'f27adb935022d94df8dc77719c322dda592c78a0d57a6f7dcdd8d900b248c454':
    raise SystemExit('SHA-256 de ORAS incorrecto')
PY
  mkdir -p "$work/oras"
  tar --no-same-owner -xzf "$work/oras.tar.gz" -C "$work/oras" oras
  (cd "$work/syft" && "$work/oras/oras" pull \
    ghcr.io/anchore/oss-cache/syft-test-fixture-cache@sha256:647e0205eadc1bcf516ce517cfa039d3738129dd3e41bba690df1f1cacc99143)
fi
go version
echo "Preparado: $work/syft"
echo "Ejecuta: bash $root/scripts/run.sh"
