# CI/CD Setup Guide

This document explains how to set up the CI/CD pipelines using GitHub Actions and Jenkins, plus integrations with SonarQube and Trivy.

## GitHub Actions
- Pipeline located in `.github/workflows/ci.yml`.
- Steps include checkout, install, tests, build image, scan image with Trivy, optional SonarQube analysis.

## Jenkins
- Jenkins pipeline at `ci-cd/jenkins/Jenkinsfile`.
- Requires Docker on the Jenkins agent host for building images.

## SonarQube
- Add SonarQube server and token in secrets (`SONAR_TOKEN`).
- Configure job to include SonarQube analysis step. Use SonarCloud for SaaS.

## Trivy
- Use `aquasecurity/trivy-action` for GitHub Actions and `aquasec/trivy:latest` container for Jenkins.

## Artifact Management
- Use GHCR or cloud provider registries. For enterprise, use Nexus or Artifactory.

## Notes
- All secrets (cloud creds, Sonar token) should be stored in environment-specific secrets managers or GitHub secrets.
- Consider adding caching for Python packages and Docker layers to improve pipeline performance.
