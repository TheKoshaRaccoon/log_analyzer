if [ $# -eq 0 ]; then
    echo "Error: No arguments provided. Use '--help' for usage information."
fi

if [ "$1" = "time" ]; then
    echo "-----------start------------" 
    if [ "$2" = "-i" ]; then
        grep -i "$3" example.log | awk -F'[][]' '{print $2}' | awk '{print $2}' | cut -d: -f1-2 | uniq -c |
        while read count time; do
            echo ----------------
            echo "$time|$count $3."
        done
    else
        grep "$2" example.log | awk -F'[][]' '{print $2}' | awk '{print $2}' | cut -d: -f1-2 | uniq -c |
        while read count time; do
            echo ----------------
            echo "$time|$count $2."
        done 
    echo "------------end------------" 
    fi
fi

if [ "$1" = "count" ]; then
    if [ "$2" = "-i" ]; then
        echo "-----------start------------"
        Count=$(grep -c -i $3 example.log)
        echo "Find:"$Count $3"."
        echo "------------end------------"
    else
        echo "-----------start------------"
        Count=$(grep -c $2 example.log)
        echo "Find:"$Count $2"."
        echo "------------end------------"
    fi
fi


if [ "$1" = "all" ]; then
    if [ "$2" = "-i" ]; then
        echo "-----------start------------" 
        grep -i $3 example.log
        echo "------------end------------"
    else
        echo "-----------start------------" 
        grep  $2 example.log
        echo "------------end------------"
    fi
fi


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
    echo "Usage: ./log_inspector.sh [mode] [options] <keyword>"
    echo ""
    echo "Modes:"
    echo "  time        Show error distribution over time"
    echo "  count       Show total count of matches"
    echo "  all         Show all matching lines"
    echo "  check       Real-time log monitoring with sub-modes"
    echo "  --help      Show this help message"
    echo ""
    echo "Check Sub-modes:"
    echo "  uniq        Show unique error types with counts"
    echo "  target      Monitor specific keyword in real-time"
    echo "  (no arg)    Monitor entire log file in real-time"
    echo ""
    echo "Options:"
    echo "  -i          Ignore case (case-insensitive search)"
    echo ""
    echo "Examples:"
    echo "  ./log_inspector.sh time ERROR"
    echo "  ./log_inspector.sh count -i error"
    echo "  ./log_inspector.sh all -i warning"
    echo "  ./log_inspector.sh check uniq ERROR    # Unique errors"
    echo "  ./log_inspector.sh check target ERROR  # Real-time monitoring"
    echo "  ./log_inspector.sh check              # Monitor entire log"
    echo ""
    echo "Check Mode Features:"
    echo "  • Real-time log monitoring"
    echo "  • Unique error type analysis"
    echo "  • Timestamp-based grouping"
    echo "  • Live updates with new entries"
    echo "----------------------------------------------------"
fi