set terminal png size 1000,700
set xlabel "Число работающих ЭМ, n"
set ylabel "Среднее время безотказной работы (часы)"
set grid

# График зависимости Θ(n) от μ
set output 'charts/theta_mu.png'
set title "Среднее время безотказной работы (N = 65536, λ = 10^{-5} ч^{-1}, m = 1)"
set logscale y 2
set format y "%.0f"
set ytics 4
set yrange [1:280000]
set xtics 1
plot "data/theta_mu.dat" using 1:($2 == 1 ? $3 : NaN) with linespoints title "μ=1", \
     "" using 1:($2 == 10 ? $3 : NaN) with linespoints title "μ=10", \
     "" using 1:($2 == 100 ? $3 : NaN) with linespoints title "μ=100", \
     "" using 1:($2 == 1000 ? $3 : NaN) with linespoints title "μ=1000"

# График зависимости Θ(n) от λ
set output 'charts/theta_lambda.png'
set title "Среднее время безотказной работы (N = 65536, μ = 1 ч^{-1}, m = 1)"
set logscale y 10
set format y "10^{%L}"
set yrange [1:1e50]
set ytics ("10^{0}" 1, "10^{5}" 1e5, "10^{10}" 1e10, "10^{15}" 1e15, "10^{20}" 1e20, "10^{25}" 1e25, "10^{30}" 1e30, "10^{35}" 1e35, "10^{40}" 1e40, "10^{45}" 1e45, "10^{50}" 1e50)
set xtics 1
plot "data/theta_lambda.dat" using 1:($2 == 1e-05 ? $3 : NaN) with linespoints title "λ=10^{-5}", \
     "" using 1:($2 == 1e-06 ? $3 : NaN) with linespoints title "λ=10^{-6}", \
     "" using 1:($2 == 1e-07 ? $3 : NaN) with linespoints title "λ=10^{-7}", \
     "" using 1:($2 == 1e-08 ? $3 : NaN) with linespoints title "λ=10^{-8}", \
     "" using 1:($2 == 1e-09 ? $3 : NaN) with linespoints title "λ=10^{-9}"

# График зависимости Θ(n) от m
set output 'charts/theta_m.png'
set title "Среднее время безотказной работы (N = 65536, λ = 10^{-5} ч^{-1}, μ = 1 ч^{-1})"
set logscale y 10
set format y "10^{%L}"
set ytics 10
set xtics 1
set yrange [1:1e8]
plot "data/theta_m.dat" using 1:($2 == 1 ? $3 : NaN) with linespoints title "m=1", \
     "" using 1:($2 == 2 ? $3 : NaN) with linespoints title "m=2", \
     "" using 1:($2 == 3 ? $3 : NaN) with linespoints title "m=3", \
     "" using 1:($2 == 4 ? $3 : NaN) with linespoints title "m=4"
