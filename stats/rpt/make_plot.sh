#!/bin/bash

rm -f data.txt;

cat stats_deg1.txt | \
  sed -n 186,197p | \
  sed -E 's/^[[:blank:]]*(([[:alnum:]]|\_)*)[[:blank:]]+[[:digit:]]\.[[:digit:]]+[[:blank:]]+([[:digit:]]\.[[:digit:]]+)[[:blank:]].*/\3 \1/' | \
  sed -E 's/_/\-/g' | \
  tr " " "\t" | \
  awk '{printf "%d\t%s\n", NR, $0}' >> data.txt;

gnuplot <<EOF
set term epslatex
set output "rpt.tex"
unset key
set title "Reference Prediction Table"
set ylabel "Speedup"
set xlabel "Benchmark"
set boxwidth 0.5
set style fill solid
set xtics out nomirror rotate
plot [][0.5:1.25] "data.txt" using 1:2:xtic(3) with boxes
EOF
