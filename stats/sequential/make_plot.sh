#!/bin/bash

rm -f stats.txt

echo -ne "Degree\t" >> stats.txt

cat stats_deg1.txt | \
  sed -n 186,197p | \
  sort | \
  sed -E 's/^[[:blank:]]*(([[:alnum:]]|\_)*)[[:blank:]]+[[:digit:]]\.[[:digit:]]+[[:blank:]]+([[:digit:]]\.[[:digit:]]+)[[:blank:]].*/\1/' | \
  sed -E 's/_/\-/g' | \
  tr "\n" "\t" >> stats.txt;

echo '' >> stats.txt;

for i in {1..7};
do
  echo -ne "${i}\t" >> stats.txt
  cat stats_deg${i}.txt | \
    sed -n 186,197p | \
    sort | \
    sed -E 's/^[[:blank:]]*(([[:alnum:]]|\_)*)[[:blank:]]+[[:digit:]]\.[[:digit:]]+[[:blank:]]+([[:digit:]]\.[[:digit:]]+)[[:blank:]].*/\3/' | \
    tr "\n" "\t" >> stats.txt;

  echo '' >> stats.txt;
done;


gnuplot << EOF
set term epslatex size 8cm,10cm
set output "sequential.tex"
set key below autotitle columnhead
set ylabel "Speedup"
set xlabel "Prefetching degree"
plot for [i=1:7] 'stats.txt' using 1:i+1 with lines
EOF
