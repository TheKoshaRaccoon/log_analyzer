if [ "$1" = "time" ]; then
    grep "$2" example.log | awk -F'[][]' '{print $2}' | awk '{print $2}' | cut -d: -f1-2 | sort | uniq -c | 
    while read count time; do
        echo ----------------
        echo "$time|$count $2."
    done
elif [ "$1" = "count" ]; then
    Count=$(grep $2 example.log | wc -l)
    echo "Find:"$Count $2"."
elif [ "$1" = "all" ]; then
    echo "-----------start------------" 
    grep -n $2 example.log
    echo "------------end------------" 
fi