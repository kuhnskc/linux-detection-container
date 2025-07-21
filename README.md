# CrowdStrike Falcon Linux Detection Container

## ⚠️ Disclaimer and Risk Notice
This project is a community-developed tool and is **NOT** officially supported by CrowdStrike. Use at your own risk. While the container performs benign simulations, you should:
- Review all code before running in your environment
- Understand that this may generate security alerts in your environment
- Be aware that running security test tools may violate some organizations' security policies

## Overview
This container provides a safe, controlled environment for validating CrowdStrike Falcon Linux sensor detections across Docker, Kubernetes, and OpenShift environments. It generates various detection patterns to help confirm proper sensor deployment and configuration.

### Detection Scenarios
The container runs through the following detection scenarios:

1. **File Masquerading Tests**
   - Simulates malware attempting to masquerading as legitimate documents
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
- CrowdStrike Falcon sensor installed
- Falcon policies configured for:
  - Detection-only mode (not Prevention)
  - Enhanced Visibility enabled

## Docker Deployment
```bash
git clone https://github.com/kuhnskc/linux-detection-container.git
cd linux-detection-container
docker build -t detection-test .
docker run --rm detection-test
```

## Kubernetes/OpenShift Deployment

For Kubernetes:
```bash
kubectl create -f https://raw.githubusercontent.com/kuhnskc/linux-detection-container/main/deployments/job.yaml
```
```bash
kubectl logs -f job/detection-test
```

For OpenShift:
```bash
oc create -f https://raw.githubusercontent.com/kuhnskc/linux-detection-container/main/deployments/job.yaml
```
```bash
oc logs -f job/detection-test
```

## Expected Detections
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
- Container is multi-architecture (supports both AMD64 and ARM64)
=======

## License
[MIT License](LICENSE)
