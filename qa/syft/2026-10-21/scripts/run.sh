#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Syft QA — v1.0 — RHYNUS Interactive Works (RIW)
set -euo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
work="${SYFT_QA_WORKDIR:-$root/.work}"
src="${SYFT_QA_SOURCE:-$work/syft}"
out="${SYFT_QA_RESULTS:-$root/results/$(date -u +%Y%m%dT%H%M%SZ)}"
if [[ -d "$work/toolchain/go/bin" ]]; then export PATH="$work/toolchain/go/bin:$PATH"; fi
export GOTOOLCHAIN=local GOMAXPROCS="${GOMAXPROCS:-4}"
[[ "$(git -C "$src" rev-parse HEAD)" == f15c3343e29dfb20cf6d82c820e7090b49808c96 ]]
[[ "$(go env GOVERSION)" == go1.26.8 ]]
mkdir -p "$out"
out="$(cd "$out" && pwd)"
cd "$src"
failed=0
record() {
  local name="$1"; shift
  local rc=0
  "$@" > "$out/$name.log" 2>&1 || rc=$?
  printf '%s\n' "$rc" > "$out/$name.exit"
  printf '%s: exit=%s\n' "$name" "$rc"
  if (( rc != 0 )); then failed=1; fi
}
record labeler python3 .github/scripts/labeler_test.py -v
record binary-fixture-size bash .github/scripts/check_binary_fixture_size.sh syft/pkg/cataloger/binary/testdata/classifiers/snippets
record go-make go test -C .make -count=1 -json ./...
record unit-selected go test -count=1 -p 2 -timeout=10m -tags=containers_image_openpgp,exclude_graphdriver_btrfs -json \
  ./syft/artifact/... ./syft/file/... ./syft/linux/... ./syft/license/... ./syft/cpe/... ./syft/pkg \
  ./syft/pkg/cataloger/javascript/... ./syft/pkg/cataloger/python/... ./syft/format/...
record build go build -p 2 -tags=containers_image_openpgp,exclude_graphdriver_btrfs -o "$out/syft" ./cmd/syft
if [[ -x "$out/syft" ]]; then
  export SYFT_BINARY_LOCATION="$out/syft" SYFT_CHECK_FOR_APP_UPDATE=false
  record cli-selected go test -count=1 -p 2 -timeout=10m -json ./test/cli \
    -run '^(TestVersionCmdPrintsToStdout|TestGGUFModelIsCataloged|TestDirectoryScanCompletesWithinTimeout|TestMalformedInputsStillProduceSBOM|Test_RequestedPathIncludesSymlink)$'
  record smoke python3 "$root/scripts/smoke.py" "$out/syft" "$out/smoke"
fi
echo "Registros: $out"
exit "$failed"
