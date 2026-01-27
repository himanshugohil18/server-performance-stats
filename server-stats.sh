#!/bin/bash

echo "======================================"
echo "        SERVER PERFORMANCE STATS"
echo "======================================"
echo

# ---------- CPU USAGE ----------
echo " CPU Usage:"
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo "Total CPU Usage: $cpu_usage %"
echo

# ---------- MEMORY USAGE ----------
echo " Memory Usage:"
free -m | awk 'NR==2{
    used=$3; free=$4; total=$2;
    printf "Used: %s MB\nFree: %s MB\nTotal: %s MB\nUsage: %.2f%%\n", used, free, total, used/total*100
}'
echo

# ---------- DISK USAGE ----------
echo " Disk Usage:"
df -h / | awk 'NR==2{
    printf "Used: %s\nFree: %s\nTotal: %s\nUsage: %s\n", $3, $4, $2, $5
}'
echo

# ---------- TOP CPU PROCESSES ----------
echo " Top 5 Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# ---------- TOP MEMORY PROCESSES ----------
echo " Top 5 Processes by Memory:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# ---------- EXTRA STATS ----------
echo " System Info:"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "OS: $(uname -a)"
echo "Logged in users: $(who | wc -l)"

echo
echo "======================================"
echo "          END OF REPORT"
echo "======================================"

