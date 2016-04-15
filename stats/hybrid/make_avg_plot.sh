#!/bin/bash

rm -f avgs.txt;
echo -e "#Degree\tAvg" >> avgs.txt;

for i in {1..7};
do
  echo -ne "${i}\t" >> avgs.txt;
  
  cat stats_deg${i}.txt | \
    sed -n 212p | \
    sed -E 's/^.*([0-9]+\.[0-9]+)/\1/' >> avgs.txt
done;

gnuplot << EOF
set term epslatex
set output "ghbdcavg.tex"
unset key
set title "Performance of GHB-based DC/RPT/SDP hybrid prefetcher"
set xlabel "Prefetching degree"
set ylabel "Average speedup"
set boxwidth 0.5
set style fill solid
plot [][0.95:1.1] "avgs.txt" using 1:2:xtic(1) with boxes
EOF
