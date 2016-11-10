#include <iostream>

using namespace std;
#define PARAMS_NO 2

void generator(long n, long m, unsigned int *params) {
    if (n == 0) {
        cout << params[0] << ' ';
    }
    if (n <= 1 && m >= 1) {
        cout << params[1] << ' ';
    }
    long i = 1;
    unsigned int x_n_1 = params[0], x_n = params[1], tmp_x_n;
    while (++i <= m) {
        tmp_x_n = x_n;
        x_n ^= x_n_1;
        x_n_1 = tmp_x_n;
        if (i >= n) {
            cout << x_n;
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