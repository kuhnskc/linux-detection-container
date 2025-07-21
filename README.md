# CrowdStrike Falcon Linux Sensor Detection Test Container

## ⚠️ Disclaimer
This is a community project and is not officially supported or affiliated with CrowdStrike. It is provided "as is" without warranty of any kind. Use at your own risk. 

## Overview
This container provides a safe, controlled environment for validating CrowdStrike Falcon Linux sensor detections. It generates various detection patterns to help confirm proper sensor deployment and configuration. All tests run as a non-root user, demonstrating CrowdStrike's ability to detect malicious behavior regardless of privilege level.

### Detection Scenarios
The container runs through the following detection scenarios:

1. **File Masquerading Tests**
   - Simulates malware attempting to masquerade as legitimate documents
   - Tests multiple file extensions and execution patterns
   - Generates Defense Evasion detections

2. **Credential Collection Simulation**
   - Simulates attempts to gather system credential information
   - Generates credential access detections
   - Tests collection and discovery capabilities

3. **Cryptocurrency Mining Simulation**
   - Simulates crypto-jacking attempts using XMRig
   - Uses dummy wallet addresses (no actual mining occurs)
   - Generates cryptocurrency mining detections

## Prerequisites

- Docker installed and running
- CrowdStrike Falcon sensor installed and running
- Falcon sensor policies configured for:
  - Detection-only mode (not Prevention)
  - Enhanced Visibility enabled

## Usage

### 1. Clone the Repository
```bash
git clone https://github.com/jmckenzie-cs/linux-detection-container.git
cd linux-detection-container
```

### 2. Build the Container
```bash
docker build -t edr-test .
```

### 3. Run the Container
```bash
docker run --name detection-test edr-test
```

### What to Expect
- The container will run through two iterations of tests
- Each iteration includes file masquerading, credential collection, and cryptocurrency mining simulations
- Total runtime is approximately 3-4 minutes
- All activities are benign simulations - no systems will be harmed
- All tests run as non-root user

### Expected Detections
After running the container, check your Falcon console for:
1. Multiple file masquerading detections (Defense Evasion)
2. Credential access attempts (Collection)
3. Cryptocurrency mining activity (Cryptojacking)

## Important Notes
- All activities are simulated and pose no risk to your systems
- The cryptocurrency miner uses dummy wallet addresses and performs no actual mining
- Tests run automatically and require no user interaction
- Container automatically stops after completing all tests
- All tests execute with non-root privileges

## License
[MIT License](LICENSE)
