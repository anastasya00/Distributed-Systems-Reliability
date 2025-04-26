#include <iostream>
#include <vector>
#include <fstream>
#include <cmath>

double calc_mu_l(int l, int N, int m, int mu) {
    return (l < N - m) ? (m * mu) : ((N - l) * mu);
}

double calc_T(int N, int n, double lambda, int mu, int m) {
    if (n == 1) return 1.0 / calc_mu_l(0, N, m, mu);

    double t1 = 1.0;
    for (int l = 1; l <= n - 1; l++) {
        t1 *= (l * lambda) / calc_mu_l(l, N, m, mu);
    }
    t1 /= mu;

    double sum_t = 0.0;
    for (int j = 1; j < n - 1; j++) {
        double t2 = 1.0;
        for (int l = j; l <= n - 1; l++) {
            t2 *= (l * lambda) / calc_mu_l(l, N, m, mu);
        }
        sum_t += t2 / (j * lambda);
    }

    return t1 + sum_t;
}

int main() {
    int N1 = 1000, N2 = 8192;

    std::vector<double> lambda_values = {1e-3, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9};
    std::vector<int> mu_values = {1, 2, 4, 6};
    std::vector<int> m_values = {1, 2, 3, 4};
    std::vector<int> n1_values;
    for (int i = 900; i <= 1000; i += 10) {
        n1_values.push_back(i);
    }
    std::vector<int> n2_values;
    for (int i = 8092; i <= 8192; i += 10) {
        n2_values.push_back(i);
    }

    std::ofstream fileT_mu("data/T_mu.dat");
    std::ofstream fileT_lambda("data/T_lambda.dat");
    std::ofstream fileT_m("data/T_m.dat");

    // График зависимости T от μ
    for (int mu : mu_values) {
        for (int n : n1_values) {
            double t = calc_T(N1, n, lambda_values[0], mu, m_values[0]);
            fileT_mu << n << " " << mu << " " << t << "\n";
        }
        fileT_mu << "\n";
    }
    fileT_mu.close();

    // График зависимости T от λ
    for (double lambda : lambda_values) {
        for (int n : n2_values) {
            double t = calc_T(N2, n, lambda, mu_values[0], m_values[0]);
            fileT_lambda << n << " " << lambda << " " << t << "\n";
        }
        fileT_lambda << "\n";
    }
    fileT_lambda.close();

    // График зависимости T от m
    for (int m : m_values) {
        for (int n : n2_values) {
            double t = calc_T(N2, n, lambda_values[1], mu_values[0], m);
            fileT_m << n << " " << m << " " << t << "\n";
        }
        fileT_m << "\n";
    }
    fileT_m.close();

    return 0;
}