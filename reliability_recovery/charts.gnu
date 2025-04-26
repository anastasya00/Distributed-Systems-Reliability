set terminal pngcairo enhanced font "arial,10" size 800,600
set grid

set output 'charts/R.png'
set title "Оперативная надежность R*(t)"
set xlabel "Время (ч)"
set ylabel "R*(t)"
set xrange [0:24]
plot "data/R.dat" using 1:2 title "n=8" with lines, \
     "" using 1:3 title "n=9" with lines, \
     "" using 1:4 title "n=10" with lines

set output 'charts/U.png'
set title "Оперативная восстановимость U*(t)"
set xlabel "Время (ч)"
set ylabel "U*(t)"
set xrange [0:24]
set key right bottom
plot "data/U.dat" using 1:2 title "n=10" with lines, \
     "" using 1:3 title "n=11" with lines, \
     ""using 1:4 title "n=12" with lines, \
     "" using 1:5 title "n=13" with lines, \
     "" using 1:6 title "n=14" with lines, \
     "" using 1:7 title "n=15" with lines, \
     "" using 1:8 title "n=16" with lines
