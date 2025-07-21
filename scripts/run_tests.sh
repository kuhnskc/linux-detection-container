#!/bin/bash

# Colors for output
GREEN="\033[0;32m"
BLUE="\033[0;34m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
BOLD="\033[1m"
NC="\033[0m"

# Welcome message
clear
echo -e "\n${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║       CrowdStrike Linux Sensor Detection Test Suite       ║${NC}"
echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${BOLD}Purpose:${NC}"
echo -e "${GREEN}This demonstration container validates your CrowdStrike Falcon Linux"
echo -e "sensor deployment by generating various detection patterns. It will help"
echo -e "confirm that your sensor is properly installed and detecting threats.${NC}"

echo -e "\n${BOLD}Important Notes:${NC}"
echo -e "${CYAN}• All activities are benign simulations - no systems will be harmed"
echo -e "• The cryptocurrency miner uses a dummy wallet and performs no actual mining"
echo -e "• The container will automatically run through all tests twice"
echo -e "• Total runtime will be approximately 3-4 minutes${NC}"

echo -e "\n${YELLOW}Testing will begin in:${NC}"
for i in {5..1}; do
    echo -e "${YELLOW}$i...${NC}"
    sleep 1
done
echo -e "\n"

# Function to run masquerading test
run_masq_test() {
    local binary=$1
    local filename=$2
    echo -e "\n${BLUE}→ Executing masquerading test: ${YELLOW}$filename${NC}"
    echo -e "${CYAN}   Simulating malware masquerading as legitimate document...${NC}"
    cp $binary ./$filename && ./$filename
    rm -f ./$filename
    sleep 7
}

# Function to run all tests
run_test_suite() {
    local iteration=$1
    echo -e "\n${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║              Test Iteration $iteration of 2                     ║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"

    # 1. File Masquerading Tests
    echo -e "\n${BOLD}${BLUE}▶ PHASE 1: File Masquerading Detection Tests${NC}"
    echo -e "${GREEN}Purpose: Detecting executables masquerading as legitimate documents"
    echo -e "This simulates common malware delivery techniques${NC}"
    echo -e "${CYAN}Running series of file masquerading tests...${NC}"
    
    run_masq_test "/usr/bin/whoami" "symlink_test.rtf"
    run_masq_test "/bin/ls" "fd_test.gif"
    run_masq_test "/usr/bin/whoami" "base64_test.xlsx"
    run_masq_test "/bin/ls" "path_test.docx"
    run_masq_test "/usr/bin/whoami" "ifs_test.png"
    run_masq_test "/usr/bin/whoami" "env_test.jpg"
    run_masq_test "/bin/bash" "obfuscate_test.pdf"

    echo -e "\n${GREEN}✓ File masquerading tests completed${NC}"
    sleep 5

    # 2. Credential Collection Test
    echo -e "\n${BOLD}${BLUE}▶ PHASE 2: Credential Collection Detection Test${NC}"
    echo -e "${GREEN}Purpose: Detecting attempts to gather system credential information"
    echo -e "This simulates common credential harvesting techniques${NC}"
    
    echo -e "\n${CYAN}Simulating credential collection attempt...${NC}"
    sh -c "/bin/grep 'x:0:' /etc/passwd > /tmp/passwords"
    sleep 3
    
    echo -e "${CYAN}Displaying simulated collection activity:${NC}"
    cat /tmp/passwords
    echo -e "\n${GREEN}✓ Credential collection test completed${NC}"
    sleep 5

    # 3. XMRig Test
    echo -e "\n${BOLD}${BLUE}▶ PHASE 3: Cryptocurrency Mining Detection Test${NC}"
    echo -e "${GREEN}Purpose: Detecting cryptocurrency mining activity"
    echo -e "This simulates crypto-jacking attempts using XMRig${NC}"
    
    echo -e "${CYAN}Starting simulated mining activity (30 second duration)...${NC}"
    timeout 30 /home/detector/work/xmrig/build/xmrig \
        --donate-level 1 \
        -o xmr.pool.minergate.com:45700 \
        -u 44...test...44 \
        -p x \
        --no-color \
        -k \
        --tls

    echo -e "\n${GREEN}✓ Cryptocurrency mining test completed${NC}"
    echo -e "\n${YELLOW}Test iteration $iteration completed successfully${NC}"
    sleep 5
}

# Run test suite twice
for i in {1..2}; do
    run_test_suite $i
done

# Final message
echo -e "\n${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║                  Test Suite Completed                     ║${NC}"
echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${BOLD}Expected Detections in Falcon Console:${NC}"
echo -e "${BLUE}1. Multiple File Masquerading Detections${NC}"
echo -e "${CYAN}   • Various executables masquerading as documents (.rtf, .pdf, etc.)${NC}"
echo -e "${BLUE}2. Credential Access Detection${NC}"
echo -e "${CYAN}   • Attempted access to system credential information${NC}"
echo -e "${BLUE}3. Cryptocurrency Mining Detection${NC}"
echo -e "${CYAN}   • XMRig miner execution attempt${NC}"

echo -e "\n${GREEN}Please check your Falcon console to verify these detections.${NC}"
echo -e "${RED}Container will stop automatically in 10 seconds...${NC}"
echo -e "${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
sleep 10
