#!/bin/bash

# System Health Management Script
# Author: Folasanmi Adetola
# Date: 03/11/2025
# Description: Monitors system health and logs the status.

LOG_FILE="/var/log/system_health.log"

# Function to check CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print $2}')
    echo "CPU Usage: $CPU_USAGE%"
    echo "$(date) - CPU Usage: $CPU_USAGE%" >> $LOG_FILE
}

# Function to check memory usage
check_memory() {
    MEM_USAGE=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')
    echo "Memory Usage: $MEM_USAGE%"
    echo "$(date) - Memory Usage: $MEM_USAGE%" >> $LOG_FILE
}

# Function to check disk space
check_disk() {
    DISK_USAGE=$(df -h / | awk 'NR==2{print $5}')
    echo "Disk Usage: $DISK_USAGE"
    echo "$(date) - Disk Usage: $DISK_USAGE" >> $LOG_FILE
}


# Function to check top running processes
check_processes() {
    echo "Top 5 Processes:"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
    echo "$(date) - Top 5 Processes:" >> $LOG_FILE
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6 >> $LOG_FILE
}

# Function to check system uptime
check_uptime() {
    UPTIME=$(uptime -p)
    echo "System Uptime: $UPTIME"
    echo "$(date) - System Uptime: $UPTIME" >> $LOG_FILE
}

# Function to check logged-in users
check_users() {
    USERS=$(who | wc -l)
    echo "Logged-in Users: $USERS"
    echo "$(date) - Logged-in Users: $USERS" >> $LOG_FILE
}


# Main function
main() {
    echo "===== System Health Report ====="
    check_cpu
    check_memory
    check_disk
    check_processes
    check_uptime
    check_users
    echo "System health report saved to $LOG_FILE"
}

# Run main function
main




