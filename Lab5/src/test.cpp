#include <iostream>
#include <fstream>
#include <vector>
#define resize_matrix(n, m) Matrix(n, Vector(m, 0))
using namespace std;
typedef long long LL;
typedef vector<int> Vector;
typedef vector<Vector> Matrix;

LL A_addr, B_addr, C_addr;
Matrix A, B, C;
int m, n, p;

void input_matrix(ifstream &in, Matrix &M, int m, int n) {
    M = resize_matrix(m, n);
    for (auto &vv : M)
        for (auto &v : vv)
            in >> v;
}
void input(ifstream &in) {
    in >> hex >> A_addr >> B_addr >> C_addr;
    in >> m >> n >> p;
    input_matrix(in, A, m, n);
    input_matrix(in, B, n, p);
}
Matrix matrix_mul(Matrix &M1, Matrix &M2) {
    Matrix M = resize_matrix(m, p);
    for (int i = 0 ; i < m ; i++)
        for (int j = 0 ; j < p ; j++)
            for (int k = 0 ; k < n ; k++)
                M[i][j] += A[i][k] * B[k][j];
    return M;
}
void matrix_output(ofstream &out, Matrix &M) {
    int r = M.size();
    int c = r ? M[0].size() : 0;
    for (int i = 0 ; i < r ; i++)
        for (int j = 0 ; j < c ; j++)
            out << M[i][j] << " \n"[j + 1 == c];
}
int main(int argc, char **argv) {
    if (argc != 3) {
        cout << "Usage: " << argv[0] << " <input file> <output file>\n";
        exit(0);
    }

    ifstream  in(argv[1]);
    ofstream out(argv[2]);
    input(in);
    C = matrix_mul(A, B);
    matrix_output(out, C);
}
