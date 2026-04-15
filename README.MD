# Eribank-Automation

This project contains Maestro automation flows for the Eribank mobile app.

## Documentation
- [QA Test Strategy](QA_Test_Strategy.md) - Comprehensive test approach and planning
- [Test Execution Plan](Test_Execution_Plan.md) - Detailed procedures for running tests

## Structure
- `flows/` : Contains YAML files defining test flows
- `tests/` : Contains test files and JUnit results
- `artifacts/Reports/` : Contains generated reports (JUnit XML, HTML)
- `artifacts/screenshots/` : Contains screenshots taken during tests

### Install Java (JDK 11 or newer)
      https://adoptopenjdk.net/

### verify Java
    java -version
### Install Android SDK (for Android automation)
    Download and install Android Studio → this will install the SDK + Emulator
    https://developer.android.com/studio

     Once installed:

    Open Android Studio once → set up emulator/device

### Add SDK tools to PATH:
     export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH

### macOS - Install Xcode (for iOS automation)
    Download Xcode from App Store:
    https://apps.apple.com/us/app/xcode/id497799835

      Open Xcode once and accept the license:

      sudo xcodebuild -license accept

###  Install Maestro

#### macOS / Linux
     curl -Ls "https://get.maestro.mobile.dev" | bash
#### Windows (PowerShell)
     iwr https://get.maestro.mobile.dev -useb | iex
####   Verify Maestro installation
    maestro --version
### Set up emulator / device
#### Use Android Studio AVD Manager → create and start an emulator OR connect a real device (USB debugging enabled)

### T o install Junit viewer for reporting
 `npm install -g junit-viewer`


### To execute a particular test
`maestro test tests/login.yaml --test-output-dir artifacts/screenshots --format junit --output ../artifacts/Reports/test-results.xml`

### To execute all tests in the folder (from root folder)
`maestro test tests/ --test-output-dir artifacts/screenshots --format junit --output artifacts/Reports/test-results.xml`

> **Note**: The `--test-output-dir` parameter is required to ensure screenshots are saved to the correct directory. Without this parameter, screenshots will be saved in timestamped subdirectories within the artifacts folder.

### To execute all tests with HTML report (recommended)
`maestro test tests/ --test-output-dir artifacts/screenshots --format HTML-DETAILED --output artifacts/Reports/report.html`

### To execute on Adb device with HTML report
`maestro --device emulator-5554 test tests/ --test-output-dir artifacts/screenshots --format HTML --output artifacts/Reports/report.html`

### Alternative: Generate JUnit XML and convert to HTML with junit-viewer
`maestro test tests/ --test-output-dir artifacts/screenshots --format junit --output artifacts/Reports/test-results.xml`
`junit-viewer --results=artifacts/Reports/test-results.xml --save=artifacts/Reports/report.html`

### Enhanced Reports with Embedded Screenshots (Recommended)
For reports that include embedded screenshots, run the PowerShell script after executing tests:
`.\generate-enhanced-report.ps1`

This will generate an enhanced HTML report at `artifacts/Reports/enhanced-report.html` that includes both the test execution summary and all captured screenshots.

### Run the below command if running scripts are disabled on the system
`Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`


## Project Folder Structure

```plaintext
Eribank-Automation/
├── artifacts/
│   ├── Reports/
│   │   ├── report.html
│   │   └── test-results.xml
│   └── screenshots/
│       ├── Login-credentials.png
│       ├── Successful-login.png
│       ├── UnSuccessful-login.png
│       ├── Successful-logout.png
│       ├── MakePayments-Screen.png
│       ├── Payments-Successful.png
│       ├── Cancel-Payment.png
│       
│       
├── flows/
│   ├── applaunch.yaml
│   
├── inputs/
├── tests/
│   ├── cancelPayment.yaml
│   ├── invalidLogin.yaml
│   ├── validLogin.yaml
│   ├── logout.yaml
│   ├── makePayment.yaml
├── QA_Test_Strategy.md
├── Test_Execution_Plan.md
├── generate-auto-report.ps1
├
└── README.md
```
## Screenshots
https://github.com/user-attachments/assets/f1212ae0-34a1-4ce7-bf25-d2239655c03f
