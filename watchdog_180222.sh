#!/bin/bash


#Check if mounted

if  mountpoint -q /media/sd1
  then
                echo "SD is mounted"
                
            else
                echo "SD is not mounted"
                
fi


# Check Disk Usage

PERCENTSTRING=$(df --output=source,pcent | grep root | awk ' { print $2"\t"$5 } ' | grep -o '[0-9]*')
PERCENT=$(expr $PERCENTSTRING)
echo $PERCENT
MAXPERCENT=90

if [ $PERCENT -gt $MAXPERCENT ]; then
    echo $PERCENT
    echo $MAXPERCENT
    echo "We are full, send a mail"
fi

# Check if Files get generated
# Input file
FILE=$(find /home/pi/u5b_su/ -mmin -15 -type f -print | head -1)

if [ -z "$FILE" ]; then
    echo "file is not there"
fi

echo "all is well"

exit 0
