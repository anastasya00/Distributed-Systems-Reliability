set terminal png size 1000,700
set xlabel "Число работающих ЭМ, n"
set ylabel "Среднее время восстановления (часы)"
set grid

# График зависимости T от μ
set output 'charts/T_mu.png'
set title "Среднее время восстановления (N = 1000, λ = 10^{-3} ч^{-1}, m = 1)"
set logscale y 2
set format y "%.2f"
set ytics 0.5
set xtics 10
plot "data/T_mu.dat" using 1:($2 == 1 ? $3 : NaN) with linespoints title "μ=1", \
     "" using 1:($2 == 2 ? $3 : NaN) with linespoints title "μ=2", \
     "" using 1:($2 == 4 ? $3 : NaN) with linespoints title "μ=4", \
     "" using 1:($2 == 6 ? $3 : NaN) with linespoints title "μ=6"

# График зависимости T от λ
set output 'charts/T_lambda.png'
set title "Среднее время восстановления (N = 8192, μ = 1 ч^{-1}, m = 1)"
set ytics ("0.95" 0.00000, "1.00" 0.00001, "1.01" 0.00006, "1.02" 0.00051, "1.03" 0.00410, "1.10" 0.13107)
# set yrange [0.95:1.20]

set logscale y 10
set format y "%.5f"
# set ytics 0.1
set yrange [0.000001:0.15]
set xtics 10

plot "data/T_lambda.dat" using 1:($2 == 1e-05 ? $3 : NaN) with linespoints title "λ=10^{-5}", \
     "" using 1:($2 == 1e-06 ? $3 : NaN) with linespoints title "λ=10^{-6}", \
     "" using 1:($2 == 1e-07 ? $3 : NaN) with linespoints title "λ=10^{-7}", \
     "" using 1:($2 == 1e-08 ? $3 : NaN) with linespoints title "λ=10^{-8}", \
     "" using 1:($2 == 1e-09 ? $3 : NaN) with linespoints title "λ=10^{-9}"

# График зависимости T от m
set output 'charts/T_m.png'
set title "Среднее время восстановления (N = 8192, λ = 10^{-5} ч^{-1}, μ = 1 ч^{-1})"
unset logscale y
set format y "%.2f"
set xtics 10
set ytics 0.01
set yrange [0.001:0.1]

plot "data/T_m.dat" using 1:($2 == 1 ? $3 : NaN) with linespoints title "m=1", \
     "" using 1:($2 == 2 ? $3 : NaN) with linespoints title "m=2", \
     "" using 1:($2 == 3 ? $3 : NaN) with linespoints title "m=3", \
     "" using 1:($2 == 4 ? $3 : NaN) with linespoints title "m=4"