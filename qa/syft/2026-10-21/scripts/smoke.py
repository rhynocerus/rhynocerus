#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-3.0-or-later
"""Prueba funcional RIW: inventario sintético, nunca archivos personales."""
import json
import os
from pathlib import Path
import subprocess
import sys

binary = str(Path(sys.argv[1]).resolve())
out = Path(sys.argv[2]).resolve()
out.mkdir(parents=True, exist_ok=True)
fixture = out / 'fixture'
fixture.mkdir(exist_ok=True)
(fixture / 'requirements.txt').write_text('requests==2.32.3\nflask==3.0.3\n')
env = {**os.environ, 'SYFT_CHECK_FOR_APP_UPDATE': 'false'}
outputs = {fmt: out / (fmt + '.json') for fmt in ('syft-json', 'cyclonedx-json', 'spdx-json')}
cmd = [binary, 'scan', 'dir:' + str(fixture)]
for fmt, path in outputs.items():
    cmd.extend(['-o', fmt + '=' + str(path)])
run = subprocess.run(cmd, env=env, capture_output=True, text=True, timeout=120)
(out / 'stdout.log').write_text(run.stdout)
(out / 'stderr.log').write_text(run.stderr)
run.check_returncode()
syft, cdx, spdx = [json.loads(outputs[fmt].read_text()) for fmt in outputs]
expected = {('requests', '2.32.3'), ('flask', '3.0.3')}
checks = {
    'syft_packages': expected <= {(a['name'].lower(), a['version']) for a in syft['artifacts']},
    'cyclonedx_packages': expected <= {(a['name'].lower(), a.get('version')) for a in cdx['components']},
    'spdx_packages': expected <= {(a['name'].lower(), a.get('versionInfo')) for a in spdx['packages']},
    'cyclonedx_format': cdx['bomFormat'] == 'CycloneDX',
    'spdx_format': spdx['spdxVersion'].startswith('SPDX-'),
}
(out / 'checks.json').write_text(json.dumps(checks, indent=2) + '\n')
print(json.dumps(checks, indent=2))
if not all(checks.values()):
    raise SystemExit(1)
