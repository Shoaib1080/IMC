# Pipeline Performance Metrics

Collect these data points across multiple runs (n > 20):

- Total duration and per-stage duration (build/test/scan/deploy)
- Runner resource use (CPU, memory)
- Cache hit/miss for package & docker layers
- Queue time
- Artifact upload/download time

Suggested tooling:
- GitHub Actions: use `actions/cache` and record timings; use GitHub Actions API to extract durations
- Jenkins: install Prometheus exporter plugin and record metrics to Prometheus, Grafana for dashboards

Reporting:
- Capture median (p50), p90, p95 durations over a sample set and compare across tools.
