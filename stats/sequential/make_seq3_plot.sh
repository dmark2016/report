#!/bin/bash

rm -f seq3_data.txt;

cat stats_deg3.txt | \
  sed -n 186,197p | \
  sed -E 's/^[[:blank:]]*(([[:alnum:]]|\_)*)[[:blank:]]+[[:digit:]]\.[[:digit:]]+[[:blank:]]+([[:digit:]]\.[[:digit:]]+)[[:blank:]].*/\3 \1/' | \
  sed -E 's/_/\-/g' | \
  tr " " "\t" | \
  awk '{printf "%d\t%s\n", NR, $0}' >> seq3_data.txt;

gnuplot <<EOF
set term epslatex
set output "seq3.tex"
unset key
set title "Sequential prefetcher (p=3) performance"
set ylabel "Speedup"
set xlabel "Benchmark"
set boxwidth 0.5
set style fill solid
set xtics out nomirror rotate
plot [][0.5:1.25] "seq3_data.txt" using 1:2:xtic(3) with boxes
EOF
