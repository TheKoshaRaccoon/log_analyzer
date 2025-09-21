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
elif [ "$1" = "all" ]; then

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

if [ "$1" = "--help" ]; then
    echo "----------------------------------------------------"
    echo "Usage: ./log_inspector.sh [mode] [options] <keyword>"
    echo ""
    echo "Modes:"
    echo "  time        Show error distribution over time"
    echo "  count       Show total count of matches"
    echo "  all         Show all matching lines"
    echo "  --help      Show this help message"
    echo ""
    echo "Options:"
    echo "  -i          Ignore case (case-insensitive search)"
    echo ""
    echo "Examples:"
    echo "  ./log_inspector.sh time ERROR"
    echo "  ./log_inspector.sh count -i error"
    echo "  ./log_inspector.sh all -i warning"
    echo "----------------------------------------------------"
fi