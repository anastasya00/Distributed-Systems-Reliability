set terminal png size 1000,700
set xlabel "Число работающих ЭМ, n"
set ylabel "Среднее время безотказной работы (часы)"
set grid
set datafile separator "\t"
set logscale y
set format y "10^{%L}"
set xtics 1

lambda_values = "1e-05 1e-06 1e-07"
mu_values = "1 10 100 1000"
m_values = "1 2 3"

### Графики Theta(n) при lambda = 1e-5, 1e-6, 1e-7; m = 1, 2, 3;
do for [i=1:words(lambda_values)] {
    lambda = word(lambda_values, i)
    
    do for [k=1:words(m_values)] {
        m = word(m_values, k)
        set output sprintf("charts/theta/lambda_m_fixed/theta_lambda%s_m%s_mu.png", lambda, m)
        set title sprintf("Зависимость Θ(n) от n при λ=%s, m=%s, разное μ", lambda, m)

        set logscale y 10
        set yrange [1:1e50]
        set ytics ("10^{0}" 1, "10^{5}" 1e5, "10^{10}" 1e10, "10^{15}" 1e15, "10^{20}" 1e20, "10^{25}" 1e25, "10^{30}" 1e30, "10^{35}" 1e35, "10^{40}" 1e40, "10^{45}" 1e45, "10^{50}" 1e50)

        stats "data/data.dat" using 3:5 nooutput

        plot for [j=1:words(mu_values)] "< awk '!seen[$3,$4,$5]++' data/data.dat" \
            using ($3 == word(mu_values, j) && $4 == m ? $5 : NaN):($3 == word(mu_values, j) && $4 == m ? $6 : NaN) \
            with lines title sprintf("μ=%s", word(mu_values, j))
    }
}

### Графики Theta(n) при mu = 1, 10, 100, 1000; m = 1, 2, 3;
do for [j=1:words(mu_values)] {
    mu = word(mu_values, j)

    do for [k=1:words(m_values)] {
        m = word(m_values, k)
        set output sprintf("charts/theta/mu_m_fixed/theta_mu%s_m%s_lambda.png", mu, m)
        set title sprintf("Зависимость Θ(n) от n при μ=%s, m=%s, разное λ", mu, m)

        set logscale y 2
        set format y "%.0f"
        set ytics 4
        set yrange [1:280000]

        stats "data/data.dat" using 2:5 nooutput

        plot for [i=1:words(lambda_values)] "< awk '!seen[$2,$4,$5]++' data/data.dat" \
            using ($2 == word(lambda_values, i) && $4 == m ? $5 : NaN):($2 == word(lambda_values, i) && $4 == m ? $6 : NaN) \
            with lines title sprintf("λ=%s", word(lambda_values, i))
    }
}

### Графики Theta(n) при lambda = 1e-5, 1e-6, 1e-7; mu = 1, 10, 100, 1000;
do for [i=1:words(lambda_values)] {
    lambda = word(lambda_values, i)

    do for [j=1:words(mu_values)] {
        mu = word(mu_values, j)

        set output sprintf("charts/theta/lambda_mu_fixed/theta_lambda%s_mu%s_m.png", lambda, mu)
        set title sprintf("Зависимость Θ(n) от n при λ=%s, μ=%s, разное m", lambda, mu)

        set logscale y 10
        set format y "10^{%L}"
        set ytics 10
        set yrange [1:1e8]

        stats "data/data.dat" using 4:5 nooutput

        plot for [k=1:words(m_values)] "< awk '!seen[$2,$3,$4,$5]++' data/data.dat" \
            using ($2 == lambda && $3 == mu && $4 == word(m_values, k) ? $5 : NaN):($2 == lambda && $3 == mu && $4 == word(m_values, k) ? $6 : NaN) \
            with lines title sprintf("m=%s", word(m_values, k))
    }
}

set output