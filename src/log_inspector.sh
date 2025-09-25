#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided. Use '--help' for usage information."
fi

#------------------------------------------------------
if [ "$1" = "time" ]; then
    if [ "$2" = "target" ]; then
        echo "-----------start------------" 
        if [ "$3" = "-i" ]; then
            echo "target:" $4 wich -i.
            grep -i "$4" $5 | awk -F' ' '{print $2,$3}' | cut -d: -f1-3 | sed 's/:[0-9]*\]//' | sort | uniq -c |
            while read count time type_info; do
                echo ----------------
                echo "$time ~-~ $count $type_info."
            done
        else
            echo "target:" $3.
            cat $4 | awk '{print $1,$2,$3}' | grep "$3" | awk -F' ' '{print $2,$3}' | cut -d: -f1-3 | sed 's/:[0-9]*\]//' | sort | uniq -c |
            while read count time type_info; do
                echo ----------------
                echo "$time ~-~ $count $type_info."
            done 
        echo "------------end------------" 
        fi
    else 
        echo "-----------start------------" 
        cat $2 | awk -F' ' '{print $2,$3}' | cut -d: -f1-3 | sed 's/:[0-9]*\]//' | sort | uniq -c |
            while read count time type_info; do
                echo ----------------
                echo "$time ~-~ $count $type_info"
            done
        echo "------------end------------" 
    fi
fi

#------------------------------------------------------


if [ "$1" = "count" ]; then
    if [ "$2" = "-i" ]; then
        echo "-----------start------------"
        Count=$(cat $4 | awk '{print $1,$2,$3}' | grep -c -i "$3")
        echo "Find:"$Count [$3] wich ignor_registr.
        echo "------------end------------"
    else
        echo "-----------start------------"
        Count=$(cat $3 | awk '{print $1,$2,$3}' | grep -c "$2")
        echo "Find:"$Count [$2].
        echo "------------end------------"
    fi
fi

#------------------------------------------------------


if [ "$1" = "info" ]; then
    if [ "$2" = "-i" ]; then
        echo "-----------start------------" 
        grep -i $3 $4
        echo "------------end------------"
    else
        echo "-----------start------------" 
        grep  $2 $3
        echo "------------end------------"
    fi
fi

#------------------------------------------------------

if [ "$1" = "--help" ]; then
    echo "===================================================="
    echo "              LOG INSPECTOR - Help Manual"
    echo "===================================================="
    echo ""
    echo "USAGE: ./log_inspector.sh [MODE] [OPTIONS] [ARGUMENTS]"
    echo ""
    echo "MODES:"
    echo "  time [target <keyword>] <file>    - Time distribution analysis"
    echo "  count [-i] <keyword> <file>       - Count matching lines" 
    echo "  info [-i] <keyword> <file>        - Display all matching lines"
    echo "  --help                            - Show this help"
    echo ""
    echo "OPTIONS:"
    echo "  -i          Case-insensitive search"
    echo "  target      Filter for specific keyword (time mode only)"
    echo ""
    echo "EXAMPLES:"
    echo "  Time Analysis:"
    echo "    ./log_inspector.sh time example.log              # Overall time distribution"
    echo "    ./log_inspector.sh time target ERROR example.log # ERROR time distribution"
    echo ""
    echo "  Counting:"
    echo "    ./log_inspector.sh count ERROR example.log       # Case-sensitive"
    echo "    ./log_inspector.sh count -i error example.log    # Case-insensitive"
    echo ""
    echo "  Information:"
    echo "    ./log_inspector.sh info WARNING example.log      # Show all WARNING lines"
    echo "    ./log_inspector.sh info -i timeout example.log   # Case-insensitive search"
    echo ""
    echo "Notes:"
    echo "  - Log files should contain timestamps for time analysis"
    echo "  - Use quotes for keywords with spaces: \"connection failed\""
    echo "  - File paths can be relative or absolute"
    echo "===================================================="
fi