#!/bin/bash

# Function to get total CPU usage
cpu_usage() {
  echo "Total CPU Usage:"
  top -bn1 | grep "Cpu(s)" | \
  sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
  awk '{print 100 - $1"% used"}'
}

# Function to get total memory usage
memory_usage() {
  echo "Total Memory Usage:"
  free -h | awk '/^Mem/ { printf("Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3/$2 * 100.0) }'
}

# Function to get total disk usage
disk_usage() {
  echo "Total Disk Usage:"
  df -h --total | awk '/^total/ { printf("Used: %s / Total: %s (%.2f%%)\n", $3, $2, $5) }'
}

# Function to get top 5 processes by CPU usage
top_cpu_processes() {
  echo "Top 5 Processes by CPU Usage:"
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function to get top 5 processes by memory usage
top_mem_processes() {
  echo "Top 5 Processes by Memory Usage:"
  ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Displaying the stats
echo "Server Performance Statistics:"
echo "------------------------------"
cpu_usage
echo ""
memory_usage
echo ""
disk_usage
echo ""
top_cpu_processes
echo ""
top_mem_processes
echo ""
echo "The script is finished."
