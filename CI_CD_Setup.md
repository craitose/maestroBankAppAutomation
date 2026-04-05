# CI/CD Test Automation Setup Guide

This document explains how to integrate your mobile app’s automated tests (using Maestro) into the CI/CD pipeline using GitHub Actions.

## Overview
  The pipeline will:

  Set up Java and Android SDK (required for builds + emulator)

  Install and configure Maestro

  Build your app’s APK (if source code is available)

  Start an Android emulator

 Install the APK onto the emulator

 Run automated Maestro tests

 Generate and upload test artifacts (JUnit reports)

## GitHub Actions CI Workflow Example
### Create a file at:
   .github/workflows/maestro-ci.yml

## Key CI Concepts
   Trigger: The workflow runs on every push or pull request to main.

   Job: Runs on ubuntu-latest VM (Linux environment).

   Emulator: Uses reactivecircus/android-emulator-runner to launch Android emulator.

   Maestro Tests: Executes flows located in flows/ directory.

   Artifacts: JUnit XML report uploaded so you can download/view results from GitHub Actions UI.

## Viewing Test Results
    After workflow runs:

    Navigate to Actions → Workflow run → Artifacts

   Download maestro-test-results

   View or process the JUnit XML as needed (e.g., publish to reporting tools)

### Install on emulator
adb install app/build/outputs/apk/debug/app-debug.apk

### Run Maestro tests
maestro test flows/ --format junit --output artifacts/Reports/test-results.xml