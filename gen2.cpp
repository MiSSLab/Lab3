#include <iostream>

using namespace std;
#define PARAMS_NO 1

void generator(long n, long m, unsigned int *params) {
    if (n == 0) {
        cout << params[0];
        if (m > 0) {
            cout << ' ';
        }
    }
    long i = 0;
    unsigned int x_n = params[0];
    while (++i <= m) {
        x_n = 3 * x_n - 1;
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