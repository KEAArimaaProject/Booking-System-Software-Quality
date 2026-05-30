
# PowerShell script to run all tests in the project (Java & Playwright)

$ErrorActionPreference = "Continue"

function Write-Header($message) {
    Write-Host "`n=== $message ===" -ForegroundColor Cyan
}

function Write-Status($message, $success) {
    if ($success) {
        Write-Host "[OK] $message" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] $message" -ForegroundColor Red
    }
}

Write-Header "Starting All Project Tests"

$totalTestsFailed = 0

# 1. Run Java Tests (Maven)
Write-Header "Running Java Tests (Maven)"
if (Test-Path ".\mvnw.cmd") {
    .\mvnw.cmd test
    if ($LASTEXITCODE -eq 0) {
        Write-Status "Java tests passed" $true
    } else {
        Write-Status "Java tests failed" $false
        $totalTestsFailed++
    }
} else {
    Write-Status "Maven wrapper (mvnw.cmd) not found" $false
    $totalTestsFailed++
}

# 2. Run Playwright API Tests (npm)
Write-Header "Running API Tests (Playwright)"
if (Test-Path "package.json") {
    npm test
    if ($LASTEXITCODE -eq 0) {
        Write-Status "Playwright tests passed" $true
    } else {
        Write-Status "Playwright tests failed" $false
        $totalTestsFailed++
    }
} else {
    Write-Status "package.json not found, skipping Playwright tests" $false
}

# 3. Run Performance Tests (k6)
Write-Header "Running Performance Tests (k6)"
if (Get-Command k6 -ErrorAction SilentlyContinue) {
    $performanceTests = @("load-test.js", "spike-test.js", "stress-test.js")
    foreach ($test in $performanceTests) {
        $testPath = "performance\$test"
        if (Test-Path $testPath) {
            Write-Host "Running $test..." -ForegroundColor Cyan
            k6 run $testPath
            if ($LASTEXITCODE -eq 0) {
                Write-Status "$test passed" $true
            } else {
                Write-Status "$test failed" $false
                $totalTestsFailed++
            }
        } else {
            Write-Status "Performance test file $testPath not found" $false
            $totalTestsFailed++
        }
    }
} else {
    Write-Host "[SKIP] k6 not found. Please install k6 to run performance tests." -ForegroundColor Yellow
}

# Summary
Write-Header "Test Summary"
if ($totalTestsFailed -eq 0) {
    Write-Host "All test suites passed successfully!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "$totalTestsFailed test suite(s) failed. Please check the logs above." -ForegroundColor Red
    exit 1
}
