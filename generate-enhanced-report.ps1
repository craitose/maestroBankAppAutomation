param(
    [string]$ReportTitle = "Eribank Automation Test Results",
    [string]$ResultsDir = "artifacts/Reports",
    [string]$ScreenshotsDir = "artifacts/screenshots/screenshots"
)

Write-Host "Generating enhanced report with embedded screenshots organized by test case..." -ForegroundColor Green

# Ensure directories exist
if (!(Test-Path $ResultsDir)) {
    New-Item -ItemType Directory -Path $ResultsDir | Out-Null
}

# Create screenshots subdirectory in Reports if it doesn't exist
$reportScreenshotsDir = Join-Path $ResultsDir "screenshots"
if (!(Test-Path $reportScreenshotsDir)) {
    New-Item -ItemType Directory -Path $reportScreenshotsDir | Out-Null
}

# Find screenshots in the specific subdirectory path
$specificScreenshotsDir = "artifacts/screenshots/screenshots"
$screenshotsExist = (Test-Path $specificScreenshotsDir) -and (Get-ChildItem -Path $specificScreenshotsDir -Filter "*.png" -ErrorAction SilentlyContinue)

# Copy screenshots to the report directory for proper linking
if ($screenshotsExist) {
    $sourceScreenshots = Get-ChildItem -Path $specificScreenshotsDir -Filter "*.png" -ErrorAction SilentlyContinue
    foreach ($screenshot in $sourceScreenshots) {
        $destination = Join-Path $reportScreenshotsDir $screenshot.Name
        if (Test-Path $destination) {
            Remove-Item $destination -Force
        }
        Copy-Item $screenshot.FullName $destination
    }
}

# Create enhanced report HTML
$enhancedReportContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$ReportTitle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid mt-4">
        <h1 class="text-center mb-4">$ReportTitle</h1>
        
        <!-- Screenshots Organized by Test Case -->
        <div class="row">
            <div class="col-12">
                <h2>Screenshots by Test Case</h2>
"@

# Process screenshots for display
if ($screenshotsExist) {
    $screenshots = Get-ChildItem -Path $specificScreenshotsDir -Filter "*.png" | Sort-Object Name
    
    if ($screenshots.Count -gt 0) {
        # Group screenshots by test case (based on naming convention)
        $testCases = @{}
        
        foreach ($screenshot in $screenshots) {
            $filename = [System.IO.Path]::GetFileNameWithoutExtension($screenshot.Name)

            # Extract everything before the FIRST hyphen
            if ($filename -match "^([^-]+)-") {
                $testCaseName = $matches[1]
            } else {
                $testCaseName = "General"
            }


            
            if (-not $testCases.ContainsKey($testCaseName)) {
                $testCases[$testCaseName] = @()
            }
            
            $testCases[$testCaseName] += @{
                Name = $screenshot.Name
                Caption = $filename -replace '-', ' '
            }
        }
        
        # Generate HTML for each test case
        foreach ($testCase in $testCases.Keys | Sort-Object) {
            $enhancedReportContent += @"
                <div class="mb-5">
                    <h3 class="text-primary">$testCase Test Case</h3>
                    <div class="row row-cols-1 row-cols-md-2 g-4">
"@
            
            foreach ($screenshotInfo in $testCases[$testCase]) {
                # Use correct relative path - now pointing to the copied screenshots in reports/screenshots
                $enhancedReportContent += @"
                        <div class="col">
                            <div class="card h-100">
                                <img src="screenshots/$($screenshotInfo.Name)" class="card-img-top" alt="$($screenshotInfo.Caption)" style="max-height: 300px; object-fit: contain;">
                                <div class="card-body">
                                    <h5 class="card-title">$($screenshotInfo.Caption)</h5>
                                </div>
                            </div>
                        </div>
"@
            }
            
            $enhancedReportContent += @"
                    </div>
                </div>
"@
        }
    } else {
        $enhancedReportContent += @"
                <p class="text-muted">No screenshots found in $specificScreenshotsDir directory.</p>
"@
    }
} else {
    $enhancedReportContent += @"
                <p class="text-muted">Screenshots directory not found or empty. Run tests with --test-output-dir parameter to generate screenshots.</p>
"@
}

$enhancedReportContent += @"
            </div>
        </div>
        
        <!-- Existing Reports Section -->
        <div class="row mt-5">
            <div class="col-12">
                <h2>Detailed Test Execution Report</h2>
"@

# Check for existing HTML reports and embed them
$htmlReports = Get-ChildItem -Path $ResultsDir -Filter "*.html" -Recurse -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending

if ($htmlReports.Count -gt 0) {
    $latestReport = $htmlReports[0]
    # Use correct relative path for reports
    $reportPath = "./" + $latestReport.Name
    $enhancedReportContent += @"
                <iframe src="$reportPath" width="100%" height="600px" frameborder="0"></iframe>
"@
} else {
    $enhancedReportContent += @"
                <p class="text-muted">No detailed HTML report found. Run tests with --format HTML or --format HTML-DETAILED to generate.</p>
"@
}

$enhancedReportContent += @"
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
"@

# Save the enhanced report
$enhancedReportPath = Join-Path $ResultsDir "enhanced-report.html"
$enhancedReportContent | Out-File -FilePath $enhancedReportPath -Encoding UTF8

Write-Host "Enhanced report generated at: $enhancedReportPath" -ForegroundColor Green

# Show what was processed
if ($screenshotsExist) {
    $screenshots = Get-ChildItem -Path $specificScreenshotsDir -Filter "*.png" -ErrorAction SilentlyContinue
    if ($screenshots.Count -gt 0) {
        Write-Host "Processed $($screenshots.Count) screenshots:" -ForegroundColor Yellow
        foreach ($screenshot in $screenshots) {
            Write-Host "  - $($screenshot.Name)" -ForegroundColor Yellow
        }
    }
}