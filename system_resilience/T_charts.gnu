set terminal png size 1000,700
set xlabel "Число работающих ЭМ, n"
set ylabel "Среднее время восстановления (часы)"
set grid
set datafile separator "\t"
set logscale y
set format y "%.5f"

lambda_values = "1e-05 1e-06 1e-07"
mu_values = "1 10 100 1000"
m_values = "1 2 3"

### Графики T(n) при lambda = 1e-5, 1e-6, 1e-7; m = 1, 2, 3;
do for [i=1:words(lambda_values)] {
    lambda = word(lambda_values, i)
    
    do for [k=1:words(m_values)] {
        m = word(m_values, k)
        set output sprintf("charts/T/lambda_m_fixed/T_lambda%s_m%s_mu.png", lambda, m)
        set title sprintf("Зависимость T(n) от n при λ=%s, m=%s, разное μ", lambda, m)

        stats "data/data.dat" using 3:5 nooutput

        plot for [j=1:words(mu_values)] "< awk '!seen[$3,$4,$5]++' data/data.dat" \
            using ($3 == word(mu_values, j) && $4 == m ? $5 : NaN):($3 == word(mu_values, j) && $4 == m ? $7 : NaN) \
            with lines title sprintf("μ=%s", word(mu_values, j))
    }
}

### Графики T(n) при mu = 1, 10, 100, 1000; m = 1, 2, 3;
do for [j=1:words(mu_values)] {
    mu = word(mu_values, j)

    do for [k=1:words(m_values)] {
        m = word(m_values, k)
        set output sprintf("charts/T/mu_m_fixed/T_mu%s_m%s_lambda.png", mu, m)
        set title sprintf("Зависимость T(n) от n при μ=%s, m=%s, разное λ", mu, m)

        unset logscale y

        stats "data/data.dat" using 2:5 nooutput

        plot for [i=1:words(lambda_values)] "< awk '!seen[$2,$4,$5]++' data/data.dat" \
            using ($2 == word(lambda_values, i) && $4 == m ? $5 : NaN):($2 == word(lambda_values, i) && $4 == m ? $7 : NaN) \
            with lines title sprintf("λ=%s", word(lambda_values, i))
    }
}

set output
