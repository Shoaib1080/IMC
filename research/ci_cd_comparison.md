# CI/CD Tool Comparison and Performance Metrics

## Tools
- Jenkins: Highly customizable, on-prem or cloud. Requires maintenance for scaling.
- GitHub Actions: Hosted, integrated with GitHub, convenient. Limits and secret management.
- GitLab CI: Integrated with GitLab, flexible runners.

## Recommendation
- For GitHub hosted repos and small-medium teams: GitHub Actions
- For centralized enterprise runners and custom agents: Jenkins or GitLab with self-hosted runners.

## Performance Metrics to Collect
- Pipeline duration by stage (checkout, build, test, scan, deploy)
- Resource utilization (CPU/RAM I/O) of runners
- Queue times (waiting for runners)
- Flakiness rate (re-runs)

## Methodology
- Use a consistent standard job and multiple runs (n > 20) to collect averages/percentiles.
- Compare cold vs warm runs, network differences, caching impacts.

