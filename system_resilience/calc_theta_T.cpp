#include <iostream>
#include <vector>
#include <fstream>
#include <cmath>

std::vector<double> calc_mu_l(int N, int m, int mu) {
    std::vector<double> mu_l(N);
    for (int l = 0; l < N; ++l) {
        mu_l[l] = (l < N - m) ? (m * mu) : ((N - l) * mu);
    }
    return mu_l;
}

double calc_theta(int N, int n, double lambda, const std::vector<double>& mu_l, int index) {
    if (n == N) return 1.0 / (N * lambda);

    double theta = 1.0 / (n * lambda);
    double product = 1.0;

    for (int j = n + 1; j <= N; ++j) {
        product *= mu_l[j - 1] / ((j - 1) * lambda);
        theta += product / (j * lambda);
    }

    return theta;
}

double calc_T(int N, int n, double lambda, const std::vector<double>& mu_l, int index) {
    if (n == 1) return 1.0 / mu_l[0];

    double t1 = 1.0;
    for (int l = 1; l <= n - 1; l++) {
        t1 *= (l * lambda) / mu_l[l];
    }
    t1 /= mu_l[0];

    double sum_t = 0.0;
    double t2 = 1.0;
    for (int j = 1; j < n - 1; j++) {
        t2 *= (j * lambda) / mu_l[j];
        sum_t += t2 / (j * lambda);
    }

    return t1 + sum_t;
}

int main() {
    int N = 65536;

    std::vector<double> lambda_values = {1e-5, 1e-6, 1e-7};
    std::vector<int> mu_values = {1, 10, 100, 1000};
    std::vector<int> m_values = {1, 2, 3};
    std::vector<int> n_values;
    for (int i = 65527; i <= 65536; i++) {
        n_values.push_back(i);
    }

    std::ofstream fileData("data/data.dat");
    fileData << "№\tλ\tμ\tm\tn\tΘ\tT" << "\n";

    int index = 1;
    for (double lambda : lambda_values) {
        for (int mu : mu_values) {
            for (int m : m_values) {
                std::vector<double> mu_l = calc_mu_l(N, m, mu);
                for (int n : n_values) {
                    double theta = calc_theta(N, n, lambda, mu_l, index);
                    double t = calc_T(N, n, lambda, mu_l, index);
                    fileData << index++ << "\t" << lambda << "\t" << mu << "\t" << m << "\t" << n << "\t" << theta << "\t" << t << "\n";
                }
            }
        }
    }

    fileData.close();
    
    return 0;
}