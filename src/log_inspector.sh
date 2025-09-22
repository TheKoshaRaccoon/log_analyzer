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


if [ "$1" = "check" ]; then


    if [ "$2" = "uniq" ]; then
        echo "=== Unique error types ==="
        grep "$3" example.log | awk -F'[][]' '{print $3}' | sort | uniq -c | while read count error_type; do
            echo "Count: $count - Type: $error_type"
        done
    
        echo "=== Real-time monitoring ==="
        tail -f example.log | grep --line-buffered "$3" | while read -r line; do
            line_minute=$(echo "$line" | awk -F'[][]' '{print $2}' | cut -d: -f1-2)
            echo "🆕 NEW: [$line_minute] - $line"
        done
    fi


    if [ "$2" = "target" ]; then
        echo "=== Existing matches ==="
        grep "$3" example.log | while read -r line; do
            line_minute=$(echo "$line" | awk -F'[][]' '{print $2}' | cut -d: -f1-2)
            echo "[$line_minute] - $line"
        
        done
        echo "=== Real-time monitoring ==="
        tail -f example.log | grep --line-buffered "$3" | while read -r line; do
            line_minute=$(echo "$line" | awk -F'[][]' '{print $2}' | cut -d: -f1-2)
            echo "🆕 NEW: [$line_minute] - $line"
        done
    else
        echo "=== Existing matches ==="
        cat example.log | while read -r line; do
            line_minute=$(echo "$line" | awk -F'[][]' '{print $2}' | cut -d: -f1-2)
            echo "[$line_minute] - $line"
        
        done
        echo "=== Real-time monitoring ==="
        tail -f example.log | while read -r line; do
            line_minute=$(echo "$line" | awk -F'[][]' '{print $2}' | cut -d: -f1-2)
            echo "🆕 NEW: [$line_minute] - $line"
        done
    fi
fi  

if [ "$1" = "--help" ]; then
    echo "----------------------------------------------------"
    echo "Usage: ./log_inspector.sh [mode] [options] [arguments]"
    echo ""
    echo "Modes:"
    echo "  time [target <keyword>] [-i] <file>    - Time distribution"
    echo "  count [-i] <keyword> <file>            - Match counting"
    echo "  info [-i] <keyword> <file>             - Show all matches"
    echo "  check [uniq|target] <keyword>          - Real-time monitoring"
    echo "  --help                                 - This message"
    echo ""
    echo "Options:"
    echo "  -i          Case-insensitive search"
    echo ""
    echo "Examples:"
    echo "  ./log_inspector.sh time example.log"
    echo "  ./log_inspector.sh time target ERROR example.log"
    echo "  ./log_inspector.sh count -i error example.log"
    echo "  ./log_inspector.sh info WARNING example.log"
    echo "  ./log_inspector.sh check target ERROR"
    echo "----------------------------------------------------"
fi