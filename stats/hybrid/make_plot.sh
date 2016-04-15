#!/bin/bash


cat stats_deg1.txt | \
    sed -n 186,197p | \
    sort | \
    sed -r 's/^\s*(\S+)\s+.*$/\1/' | \
    sed -r 's/_/\\-/g' | \
    tr "\n" "\t" > stats.txt;

echo '' >> stats.txt;

for i in {1..7};
do
    cat stats_deg${i}.txt | \
        sed -n 186,197p | \
        sort | \
        sed -r 's/^\s*(\S+\s+){2}(\S+)\s.*$/\2/' | \
        tr "\n" "\t" >> stats.txt;

    echo '' >> stats.txt;
done;

gnuplot << EOF
set term epslatex size 18cm,5cm
set output "ghbdc.tex"
set key outside autotitle columnhead
set ylabel "Speedup"
set xlabel "Prefetching degree"
plot [0.5:7.5] for [i=1:7] 'stats.txt' using (\$0 + 1):i
EOF
