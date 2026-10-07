# SOC lab: SSH authentication triage

A defensive exercise for reading simulated SSH authentication logs and separating evidence from hypotheses.

## Goals

- Explain the difference between an event and an alert.
- Group failed SSH authentications by source address.
- Record what the evidence supports and what remains unknown.

## Run locally

Requires Python 3.9 or later. No third-party packages or administrator privileges are needed.

    python3 exercise/analyze_auth.py data/auth.log

Expected output:

    Failed SSH authentication attempts by source:
    198.51.100.24: 3
    Total failed attempts: 3

## Investigate

1. What pattern merits further review?
2. Why should the accepted login from 192.0.2.44 not be correlated automatically with the failures from 198.51.100.24?
3. Add a failed-password event from 203.0.113.17 to data/auth.log and run the parser again.
4. Write one sentence containing only observations and a separate sentence describing a hypothesis that needs validation.

## Scope and safety

The script reads only the text file supplied on the command line. It performs no network connections, scans, authentication attempts, blocking or system changes. The dataset is invented and uses documentation-only address ranges. Do not publish personal or operational data from real logs without redaction and authorization.

Three failures in a short interval can justify checking a wider time window, asset context, and related events. They do not by themselves prove compromise. A successful authentication from a different example IP is not evidence that those failures led to access.
