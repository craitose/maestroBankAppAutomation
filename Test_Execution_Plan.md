# Eribank Mobile App - Test Execution Plan

## 1. Introduction

This Test Execution Plan provides detailed guidance on how to execute the automated test suite for the Eribank mobile application. It includes step-by-step instructions for running tests, generating reports, and interpreting results.

## 2. Prerequisites

Before executing tests, ensure the following prerequisites are met:

### 2.1 Software Installation
- Java JDK 11 or newer installed and configured
- Android SDK installed with emulator or physical device connected
- Maestro CLI installed (version 2.4.0 or higher)
- Node.js installed (for report generation utilities)

### 2.2 Environment Setup
- Eribank APK installed on target device/emulator
- Device/emulator properly configured with required permissions
- Internet connectivity for downloading dependencies (if needed)

### 2.3 Project Preparation
- All test scripts located in the `tests/` directory
- Application launch flow in the `flows/` directory
- Reporting utilities and scripts available

## 3. Test Execution Procedures

### 3.1 Single Test Execution

To execute a single test case:

```bash
maestro test tests/[test-file].yaml --test-output-dir artifacts/screenshots --format HTML-DETAILED --output artifacts/Reports/report.html
```

**Example for valid login test:**
```bash
maestro test tests/validLogin.yaml --test-output-dir artifacts/screenshots --format HTML-DETAILED --output artifacts/Reports/report.html
```

### 3.2 Batch Test Execution

To execute all test cases in sequence:

```bash
# Execute all tests with JUnit format for consolidation
maestro test tests/ --test-output-dir artifacts/screenshots --format junit --output artifacts/Reports/test-results.xml

# Convert to HTML report
junit-viewer --results=artifacts/Reports/test-results.xml --save=artifacts/Reports/consolidated-report.html

# Generate enhanced report with embedded screenshots
.\generate-auto-report.ps1
```

### 3.3 Device-Specific Execution

To execute tests on a specific device:

```bash
maestro --device [device-id] test tests/[test-file].yaml --test-output-dir artifacts/screenshots --format HTML-DETAILED --output artifacts/Reports/report.html
```

**Example:**
```bash
maestro --device emulator-5554 test tests/validLogin.yaml --test-output-dir artifacts/screenshots --format HTML-DETAILED --output artifacts/Reports/report.html
```

## 4. Test Case Execution Matrix

| Test Case | File Name | Description | Execution Command |
|-----------|-----------|-------------|-------------------|
| Valid Login | validLogin.yaml | Successful user authentication | `maestro test tests/validLogin.yaml ...` |
| Invalid Login | invalidLogin.yaml | Failed authentication attempt | `maestro test tests/invalidLogin.yaml ...` |
| Make Payment | makePayment.yaml | Process a payment transaction | `maestro test tests/makePayment.yaml ...` |
| Cancel Payment | cancelPayment.yaml | Cancel a payment transaction | `maestro test tests/cancelPayment.yaml ...` |
| Logout | logout.yaml | End user session | `maestro test tests/logout.yaml ...` |

## 5. Reporting Procedures

### 5.1 Automatic Enhanced Reporting

After test execution, run the automated reporting script:

```bash
.\generate-auto-report.ps1
```

This generates `artifacts/Reports/enhanced-report.html` with:
- Screenshots organized by test case
- Embedded detailed execution report
- Visual evidence for all test steps

### 5.2 Manual Reporting Options

#### JUnit XML Reports
```bash
maestro test tests/ --test-output-dir artifacts/screenshots --format junit --output artifacts/Reports/test-results.xml
```

#### Basic HTML Reports
```bash
maestro test tests/ --test-output-dir artifacts/screenshots --format HTML --output artifacts/Reports/basic-report.html
```

#### Detailed HTML Reports
```bash
maestro test tests/ --test-output-dir artifacts/screenshots --format HTML-DETAILED --output artifacts/Reports/detailed-report.html
```

## 6. Artifact Management

### 6.1 Directory Structure
```
artifacts/
├── Reports/
│   ├── test-results.xml (JUnit format)
│   ├── report.html (Basic HTML)
│   ├── detailed-report.html (Detailed HTML)
│   └── enhanced-report.html (Enhanced with screenshots)
└── screenshots/
    ├── Login-Credentials.png
    ├── Successful-Login.png
    ├── UnSuccessful-Login.png
    ├── MakePayment-Screen.png
    ├── Payment-Successful.png
    └── Cancel-Payment.png
```

### 6.2 Screenshot Naming Convention
Screenshots are automatically organized by test case based on filename prefixes:
- `[TestCase]-[Description].png` (e.g., `ValidLogin-Credentials.png`)

## 7. Troubleshooting Common Issues

### 7.1 Maestro Not Found
**Issue**: `'maestro' is not recognized as an internal or external command`
**Solution**: 
1. Verify Maestro installation: `maestro --version`
2. Add Maestro to system PATH if needed
3. Restart terminal/command prompt

### 7.2 Device Not Detected
**Issue**: `No devices found`
**Solution**:
1. Check if emulator/device is running: `adb devices`
2. Verify USB debugging is enabled (for physical devices)
3. Restart ADB server: `adb kill-server && adb start-server`

### 7.3 App Not Installed
**Issue**: `App not found`
**Solution**:
1. Install Eribank APK on device/emulator
2. Verify package name in YAML files (`com.experitest.ExperiBank`)
3. Check if app is properly signed

### 7.4 Element Not Found
**Issue**: `Element not found: Text matching regex`
**Solution**:
1. Verify UI text matches exactly (case-sensitive)
2. Add waits for dynamic content
3. Check if app state matches expectations

## 8. Validation Checklist

Before starting test execution:
- [ ] Java JDK 11+ installed and JAVA_HOME set
- [ ] Android SDK installed with ANDROID_HOME set
- [ ] Maestro CLI installed (`maestro --version` works)
- [ ] Node.js installed for report utilities
- [ ] Eribank app installed on target device
- [ ] Device/emulator connected and visible in `adb devices`
- [ ] All test YAML files present in `tests/` directory
- [ ] Reporting scripts available (`generate-auto-report.ps1`)

After test execution:
- [ ] Screenshots captured in `artifacts/screenshots/`
- [ ] Reports generated in `artifacts/Reports/`
- [ ] Enhanced report created with embedded screenshots
- [ ] All test results documented
- [ ] Defects logged for failed test cases

## 9. Test Execution Schedule

### 9.1 Daily Execution (CI/CD Integration)
- Execute smoke tests: validLogin.yaml, logout.yaml
- Generate basic HTML report
- Archive artifacts for historical tracking

### 9.2 Full Regression Execution
- Execute all test cases in sequence
- Generate detailed reports with screenshots
- Perform comprehensive defect analysis
- Update test documentation based on findings

## 10. Success Criteria

Test execution is considered successful when:
1. All test scripts execute without framework errors
2. Expected pass/fail criteria are met for each test case
3. Screenshots are captured for key validation points
4. Reports are generated and accessible
5. Any defects are properly documented with evidence

## 11. Rollback Procedure

If critical issues occur during test execution:
1. Stop current test execution (`Ctrl+C`)
2. Document current state and error messages
3. Reset test environment (clear app data/cache)
4. Reinstall Eribank APK if necessary
5. Restart device/emulator if needed
6. Resume testing from last successful point

## 12. Maintenance

Regular maintenance tasks:
- Update test scripts for UI changes
- Review and update test data
- Enhance reporting scripts based on feedback
- Optimize test execution performance
- Update this document for process improvements

---
*Document Version: 1.0*
*Last Updated: April 5, 2026*