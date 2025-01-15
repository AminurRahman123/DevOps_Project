!/bin/bash

# Get Total CPU Usage
statscpu=$(iostat -c)
topcpu=$(ps aux | sort -nrk 3,3 | head -n 5)

# Get RAM stats 
totalmem=$(free -h | grep Mem: | awk '{print $2}')
freemem=$(free -h | grep Mem: | awk '{print $4}')
usedmem=$(free -h | grep Mem: | awk '{print $3}')
percentused=$(free | grep Mem: | awk '{print $3/$2*100}')
percentfree=$(free | grep Mem: | awk '{print $3/$4*100}')
topmem=$(ps -eo pmem,pcpu,vsize,pid,cmd | sort -k 1 -nr | head -5)


# Get Disk Stats
mountpoint=$(df -h | nl)

echo "Welcome to the Sys Admin Tool"
echo "Type in 'help' to get a list of commands"
while true; do
read -p "Please Enter Command: " command

# Total CPU Usage
if [ "$command" = "CPU" ]; then
    echo "$statscpu"

# Total Memory Usage    
elif [ "$command" = "MEM" ]; then
    echo "Total Free:  $freemem  %$percentfree"
    echo "Total Used:  $usedmem  %$percentused"
    echo "Total Memory:  $totalmem"

# Total Disk Usage    
elif [ "$command" = "DISK" ]; then
while true; do
    read -p "Please Enter Filesystem (or type 'list' to see available Filesystesm): " mount

    if [ "$mount" = "list" ]; then
        echo "$mountpoint"
    else
        # Handle specific mount point here, e.g., df for a given mount
        df -h | grep "$mount"
        break;
    fi
done

# Top 5 Processes for CPU
elif [ "$command" = "5CPU" ];then
        echo "$topcpu"

# Top 5 Processes for Memory
elif [ "$command" = "5MEM" ];then
        echo "$topmem"

# Help Options
elif [ "$command" = "help" ];then
        echo "1. CPU"
        echo "2. MEM"
        echo "3. DISK"
        echo "4. 5CPU"
        echo "5. 5MEM"
        echo "6. exit"

elif [ "$command" = "exit" ];then
        break;

else
    echo "Please Select a Valid Command"
fi
done
                                     
