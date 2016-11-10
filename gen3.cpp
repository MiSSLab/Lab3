#include <iostream>

using namespace std;
#define PARAMS_NO 3

void generator(long n, long m, unsigned int *params) {
    unsigned int x_n_1 = params[0], x_n = params[1], y_n = params[2], tmp_x_n, product;
    if (n == 0) {
        cout << x_n_1 * y_n << ' ';
    }
    y_n = 3 * y_n - 1;
    if (n <= 1 && m >= 1) {
        cout << x_n * y_n << ' ';
    }
    long i = 1;
    while (++i <= m) {
        tmp_x_n = x_n;
        x_n ^= x_n_1;
        x_n_1 = tmp_x_n;
        y_n = 3 * y_n - 1;
        if (i >= n) {
            product = x_n * y_n;
            cout << product;
            if (i != m) {
                cout << ' ';
            }
        }
    }
}

int main(int argc, char *argv[]) {

    if (argc != 2) {
        cout << "Wrong number of arguments." << endl;
        return 1;
    }

    string args(argv[1]);
    unsigned long dash_position = args.find('-');
    long n = stoul(args.substr(0, dash_position));
    long m = stoul(args.substr(dash_position + 1, args.length()));

    unsigned int params[PARAMS_NO];

    for (int i = 0; i < PARAMS_NO; i++) {
        cin >> params[i];
    }
    generator(n, m, params);
    cout << endl;
    return 0;
}