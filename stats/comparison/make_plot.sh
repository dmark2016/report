#!/bin/bash


gnuplot << EOF
set term epslatex size 8cm,8cm
set output "comparison.tex"
unset key
set title "Average speedup"
set ylabel "Average speedup"
set xtics ("Sequential" 0, "SDP" 1, "RPT" 2, "DC" 3, "Hybrid" 4)
set boxwidth 0.5
set style fill solid
plot [][0.99:1.1] "data.txt" with boxes
EOF
