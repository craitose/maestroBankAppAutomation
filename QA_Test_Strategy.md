# Eribank Mobile App - QA Test Strategy & Execution Plan

## 1. Introduction

This document outlines the Quality Assurance Test Strategy and Execution Plan for the Eribank mobile application automation project. The strategy focuses on ensuring the application meets functional requirements, performs reliably, and provides a seamless user experience across different scenarios.

## 2. Test Objectives

- Validate core banking functionalities including login, payments, and logout
- Ensure application stability and reliability under various conditions
- Verify error handling for invalid inputs and edge cases
- Confirm UI consistency and responsiveness
- Document test execution results with visual evidence

## 3. Scope of Testing

### 3.1 In-Scope Features
- User Authentication (Valid/Invalid Login)
- Account Balance Display
- Payment Processing (Making and Cancelling Payments)
- Session Management (Logout Functionality)
- Application Launch and Navigation

### 3.2 Out-of-Scope Features
- Backend database validation
- Performance/load testing
- Security penetration testing
- Cross-platform compatibility testing (currently focused on Android)

## 4. Test Approach

### 4.1 Test Types
1. **Functional Testing**
   - Validate all user workflows
   - Verify business logic implementation
   - Check data integrity and consistency

2. **UI Testing**
   - Screen navigation and element visibility
   - Input field validation
   - Button and control responsiveness

3. **Regression Testing**
   - Ensure new changes don't break existing functionality
   - Validate fixes for reported issues

### 4.2 Test Execution Framework
- **Tool**: Maestro Automation Framework
- **Platform**: Android (with potential iOS extension)
- **Reporting**: Automated HTML reports with embedded screenshots

## 5. Test Environment

### 5.1 Hardware Requirements
- Android Emulator (API 21+)
- Physical Android Devices (optional)
- Minimum 4GB RAM, Intel i5 processor

### 5.2 Software Requirements
- Java JDK 11+
- Android SDK
- Maestro CLI
- Node.js (for report generation)

### 5.3 Application Under Test
- **App Name**: Eribank Mobile App
- **Package ID**: com.experitest.ExperiBank
- **Version**: Latest available APK

## 6. Test Cases Overview

### 6.1 Valid Login Scenario
**Test Case ID**: TC001_ValidLogin
**Description**: Verify successful login with valid credentials
**Preconditions**: App installed, valid credentials available
**Steps**:
1. Launch the Eribank application
2. Enter valid username ("company")
3. Enter valid password ("company")
4. Tap on Login button
5. Verify account balance is displayed
6. Logout from the application
**Expected Results**: User successfully logs in, sees account balance, and can logout

### 6.2 Invalid Login Scenario
**Test Case ID**: TC002_InvalidLogin
**Description**: Verify proper handling of invalid login attempts
**Preconditions**: App installed
**Steps**:
1. Launch the Eribank application
2. Enter invalid username ("soletrader")
3. Enter invalid password ("soletrader")
4. Tap on Login button
5. Verify account balance is NOT displayed
**Expected Results**: Login fails, account balance remains hidden

### 6.3 Make Payment Scenario
**Test Case ID**: TC003_MakePayment
**Description**: Verify successful payment processing
**Preconditions**: User logged in with sufficient balance
**Steps**:
1. Navigate to Make Payment screen
2. Enter recipient phone number
3. Enter recipient name
4. Set payment amount using slider
5. Select country
6. Confirm payment
**Expected Results**: Payment processed successfully, balance updated

### 6.4 Cancel Payment Scenario
**Test Case ID**: TC004_CancelPayment
**Description**: Verify payment cancellation functionality
**Preconditions**: User on payment confirmation screen
**Steps**:
1. Initiate payment process
2. At confirmation screen, tap "No" to cancel
**Expected Results**: Payment cancelled, no transaction occurs

### 6.5 Logout Scenario
**Test Case ID**: TC005_Logout
**Description**: Verify proper session termination
**Preconditions**: User logged in
**Steps**:
1. Tap on Logout button
2. Verify login screen is displayed
**Expected Results**: User successfully logged out, redirected to login screen

## 7. Test Data

### 7.1 Valid Credentials
- Username: company
- Password: company

### 7.2 Invalid Credentials
- Username: soletrader
- Password: soletrader

### 7.3 Payment Information
- Phone: 1234567890
- Name: John Doe
- Amount: $3 (via slider)
- Country: USA

## 8. Test Execution Schedule

| Phase | Activity | Duration | Resources |
|-------|----------|----------|-----------|
| 1 | Test Environment Setup | 1 day | QA Engineer |
| 2 | Test Script Development | 2 days | Automation Engineer |
| 3 | Test Execution | 3 days | QA Team |
| 4 | Defect Reporting & Retest | 2 days | QA Team, Developers |
| 5 | Final Reporting | 1 day | QA Lead |

## 9. Entry and Exit Criteria

### 9.1 Entry Criteria
- Application build is stable and deployed
- Test environment is set up and accessible
- Test scripts are developed and reviewed
- Test data is prepared and validated

### 9.2 Exit Criteria
- All planned test cases executed
- Critical and high severity defects resolved
- Test completion report generated
- Stakeholder approval obtained

## 10. Risk Analysis

### 10.1 Identified Risks
1. **Environment Instability**: Emulator/device issues may affect test execution
   *Mitigation*: Maintain backup devices and use cloud-based testing platforms

2. **Flaky Tests**: UI elements may not be consistently detected
   *Mitigation*: Implement robust wait strategies and element identification

3. **Data Dependencies**: Tests may fail due to data setup issues
   *Mitigation*: Use isolated test environments with controlled data

### 10.2 Risk Mitigation Strategies
- Regular environment health checks
- Comprehensive error handling in test scripts
- Detailed logging and screenshot capture for troubleshooting
- Regular backup of test artifacts

## 11. Defect Management

### 11.1 Defect Lifecycle
1. **Identification**: During test execution
2. **Logging**: Using standardized defect template
3. **Prioritization**: Based on severity and impact
4. **Assignment**: To respective development team
5. **Verification**: Post-fix validation
6. **Closure**: After successful retesting

### 11.2 Severity Levels
- **Critical**: Blocks core functionality, data loss
- **High**: Major functionality issues, significant user impact
- **Medium**: Minor functionality issues, workaround available
- **Low**: Cosmetic issues, minor usability concerns

## 12. Reporting and Metrics

### 12.1 Test Metrics
- Test execution progress (%)
- Pass/Fail ratio
- Defect density
- Test cycle duration

### 12.2 Reporting Frequency
- Daily execution status
- Weekly defect summary
- Final test completion report

### 12.3 Report Contents
- Test execution summary
- Defect analysis
- Screenshots and evidence
- Recommendations for improvements

## 13. Deliverables

1. **Test Strategy Document** (This document)
2. **Automated Test Scripts** (YAML files)
3. **Test Execution Reports** (HTML with screenshots)
4. **Defect Reports** (Logged issues with evidence)
5. **Final Test Summary Report** (Comprehensive results)

## 14. Roles and Responsibilities

| Role | Responsibilities |
|------|------------------|
| QA Lead | Overall test strategy, planning, reporting |
| Automation Engineer | Script development, framework maintenance |
| QA Analyst | Test execution, defect reporting |
| Developer | Fixing identified defects |

## 15. Approval

| Name | Role | Signature | Date |
|------|------|-----------|------|
|      |QALead|           |      |
|      | P M  |           |      |
|      | P O  |           |      |

---
*Document Version: 1.0*
*Last Updated: April 5, 2026*