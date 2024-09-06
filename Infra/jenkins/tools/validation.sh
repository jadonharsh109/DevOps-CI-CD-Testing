#!/bin/bash

# Function to check if a command exists and print the version
check_command() {
    local cmd=$1
    local name=$2
    local version_flag=$3

    if command -v $cmd &> /dev/null; then
        echo "$name is installed."
        
        # Check if a custom version flag is needed
        if [ "$version_flag" == "kubectl" ]; then
            echo "$($cmd version --client 2>&1)"
        elif [ "$version_flag" == "helm" ]; then
            echo "$($cmd version --short 2>&1)"
        else
            echo "$($cmd --version 2>&1 | head -n 1)"
        fi
    else
        echo "$name is NOT installed."
        exit 1  # Exit the script with an error code if a tool is missing
    fi
    echo
}

# Check if Trivy is installed
check_command "trivy" "Trivy" "default"

# Check if Docker is installed
check_command "docker" "Docker" "default"

# Check if AWS CLI is installed
check_command "aws" "AWS CLI" "default"

# Check if Kubectl is installed
check_command "kubectl" "Kubectl" "kubectl"

# Check if Helm is installed
check_command "helm" "Helm" "helm"

# Print a final message
echo "Validation of tools completed."