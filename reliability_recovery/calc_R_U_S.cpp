#include <iostream>
#include <fstream>
#include <cmath>

// Функция оперативной надежности R*(t)
long double calc_reliability(int n, int N, double lambda, double mu, int m, double t) {
    long double Rt = 0.0;

    for (int i = n; i <= N; i++) {
        long double Q = 0.0;
        long double Pi = 0.0;

        for (int l = 0; l <= N; l++) {
            double deltaX_1 = (N - i - m >= 0) ? 1.0 : 0.0;
            double deltaX_2 = (m - N + i >= 0) ? 1.0 : 0.0;

            long double ul = (pow(mu * t, l) / tgamma(l + 1)) * 
                             ((deltaX_1 * pow(m, l) * exp(-m * mu * t)) + 
                              (deltaX_2 * pow(N - i, l) * exp(-(N - i) * mu * t)));

            long double pr = 0.0;
            for (int r = 0; r <= (i - n + l); r++) {
                pr += (pow(i * lambda * t, r) / tgamma(r + 1)) * exp(-i * lambda * t);
            }

            Q += ul * pr;
        }

        long double p_i = 0.0;
        for (int l = 0; l <= N; l++) {
            p_i += pow(mu / lambda, l) / tgamma(l + 1);
        }

        Pi = pow(mu / lambda, i) / tgamma(i + 1) / p_i;
        Rt += Pi * Q;
    }

    return Rt;
}

// Функция оперативной восстановимости U*(t)
double calc_recoverability(double mu, int n, int N, double lambda, int m, double t) {
    double Pi = 0.0;

    for (int i = 0; i <= n - 1; i++) {
        double pi_r = 0.0;

        for (int r = 0; r <= N; r++) {
            double ul = 0.0;

            for (int l = 0; l <= (n - i - 1 + r); l++) {
                double deltaX_1 = (N - i - m >= 0) ? 1.0 : 0.0;
                double deltaX_2 = (m - N + i >= 0) ? 1.0 : 0.0;

                ul += (pow(mu * t, l) / tgamma(l + 1)) * 
                      ((deltaX_1 * pow(m, l) * exp(-m * mu * t)) + 
                       (deltaX_2 * pow(N - i, l) * exp(-(N - i) * mu * t)));
            }

            pi_r += ((pow(i * lambda * t, r) / tgamma(r + 1)) * exp(-i * lambda * t)) * ul;
        }

        double sumP_i = 0.0;
        for (int k = 0; k <= N; k++) {
            sumP_i += pow(mu / lambda, k) / tgamma(k + 1);
        }

        Pi += pow(mu / lambda, i) / tgamma(i + 1) * (1 / sumP_i) * pi_r;
    }

    return 1.0 - Pi;
}

// Функция коэффициента готовности S
double calc_availability_coeff(int n, int N, double lambda, double mu, int m) {
    return (m * mu) / ((N - n + 1) * lambda + m * mu);
}

int main() {
    const int N1 = 10, N2 = 16;
    const double lambda = 0.024, mu = 0.71;
    const int m_1 = 1, m_16 = 16;

    std::ofstream fileR("data/R.dat");
    std::ofstream fileU("data/U.dat");
    std::ofstream fileS("data/S.dat");

    for (int t = 0; t <= 24; t += 2) {
        // R*(t) для N = 10, n = 8, 9, 10
        fileR << t << " "
              << calc_reliability(8, N1, lambda, mu, m_1, t) << " "
              << calc_reliability(9, N1, lambda, mu, m_1, t) << " "
              << calc_reliability(10, N1, lambda, mu, m_1, t) << std::endl;

        // U*(t) для N = 16, n = 10, 11, ..., 16
        fileU << t;
        for (int n = 10; n <= 16; n++) {
            fileU << " " << calc_recoverability(mu, n, N2, lambda, m_1, t);
        }
        fileU << std::endl;      
    }    
    fileR.close();
    fileU.close();

    // S(t)
    fileS << "n\tS(m=1)\t\tS(m=16)\n";
    for (int n = 11; n <= 16; n++) {
        double S_m1 = calc_availability_coeff(n, N2, lambda, mu, m_1);
        double S_m16 = calc_availability_coeff(n, N2, lambda, mu, m_16);
        fileS << n << "\t" << S_m1 << "\t" << S_m16 << "\n";
    }
    fileS.close();

    return 0;
}