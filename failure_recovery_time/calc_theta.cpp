#include <iostream>
#include <vector>
#include <fstream>
#include <limits>
#include <cmath>

double calc_mu_l(int l, int N, int m, int mu) {
    return (l < N - m) ? (m * mu) : ((N - l) * mu);
}

double calc_theta(int N, int n, double lambda, int mu, int m) {
    if (n == N) return 1.0 / (N * lambda);

    double theta = 1.0 / (n * lambda);
    double product = 1.0;

    for (int j = n + 1; j <= N; ++j) {
        product *= calc_mu_l(j - 1, N, m, mu) / ((j - 1) * lambda);
        theta += product / (j * lambda);
    }

    return theta;
}

int main() {
    int N = 65536;

    std::vector<double> lambda_values = {1e-5, 1e-6, 1e-7, 1e-8, 1e-9};
    std::vector<int> mu_values = {1, 10, 100, 1000};
    std::vector<int> m_values = {1, 2, 3, 4};
    std::vector<int> n_values;
    for (int i = 65526; i <= 65536; i++) {
        n_values.push_back(i);
    }

    std::ofstream fileTheta_mu("data/theta_mu.dat");
    std::ofstream fileTheta_lambda("data/theta_lambda.dat");
    std::ofstream fileTheta_m("data/theta_m.dat");

    // График зависимости Θ(n) от μ
    for (int mu : mu_values) {
        for (int n : n_values) {
            double theta = calc_theta(N, n, lambda_values[0], mu, m_values[0]);
            fileTheta_mu << n << " " << mu << " " << theta << "\n";
        }
        fileTheta_mu << "\n";
    }
    fileTheta_mu.close();

    // График зависимости Θ(n) от λ
    for (double lambda : lambda_values) {
        for (int n : n_values) {
            double theta = calc_theta(N, n, lambda, mu_values[0], m_values[0]);
            fileTheta_lambda << n << " " << lambda << " " << theta << "\n";
        }
        fileTheta_lambda << "\n";
    }
    fileTheta_lambda.close();

    // График зависимости Θ(n) от m
    for (int m : m_values) {
        for (int n : n_values) {
            double theta = calc_theta(N, n, lambda_values[0], mu_values[0], m);
            fileTheta_m << n << " " << m << " " << theta << "\n";
        }
        fileTheta_m << "\n";
    }
    fileTheta_m.close();

    return 0;
}