#include <iostream>
#include <fstream>
#include <vector>
#define resize_matrix(n, m) Matrix(n, Vector(m, 0))
using namespace std;
typedef long long LL;
typedef vector<int> Vector;
typedef vector<Vector> Matrix;

LL A_addr, B_addr, C_addr;
vector<LL> addrs;
Matrix A, B, C;
int m, n, p;

void input_matrix(ifstream &in, Matrix &M, int m, int n) {
    M = resize_matrix(m, n);
    for (auto &vv : M)
        for (auto &v : vv)
            in >> v;
}
void input(ifstream &in) {
    in >> hex >> A_addr >> B_addr >> C_addr >> dec;
    in >> m >> n >> p;
    input_matrix(in, A, m, n);
    input_matrix(in, B, n, p);
    addrs.clear();
}
void matrix_output(ofstream &out, Matrix &M) {
    int r = M.size();
    int c = r ? M[0].size() : 0;
    for (int i = 0 ; i < r ; i++)
        for (int j = 0 ; j < c ; j++)
            out << M[i][j] << " \n"[j + 1 == c];
}
LL matrix_index(LL addr, int i, int j, int r, int c) {
    return addr + i * c * 4 + j * 4;
}
void matrix_mul(Matrix &M1, LL M1_addr, Matrix &M2, LL M2_addr, Matrix &M, LL M_addr) {
    M = resize_matrix(m, p);
    for (int i = 0 ; i < m ; i++)
        for (int j = 0 ; j < p ; j++)
            for (int k = 0 ; k < n ; k++)
                M[i][j] += M1[i][k] * M2[k][j],
                addrs.push_back(matrix_index(M_addr, i, j, m, p)),
                addrs.push_back(matrix_index(M1_addr, i, k, m, n)),
                addrs.push_back(matrix_index(M2_addr, k, j, n, p)),
                addrs.push_back(matrix_index(M_addr, i, j, m, p));
}
int execution_cycles() {
    return 2 + (22 * m * p * n + 2 * m * p) + (5 * m * p + 2 * m) + (5 * m + 2) + 1;
}
struct cache_content {
    int v, tag;
    cache_content() : v(-1), tag(0) {}
};
const int INF = 0x3f3f3f3f;
vector<LL> simulate(int cache_size, int block_size, int way, vector<LL> &addrs) {
    int total = 0; vector<LL> miss_addrs;
    int offset_bit = __lg(block_size);
    int index_bit  = __lg(cache_size / block_size / way);
    int line       = cache_size / block_size / way;
    vector<vector<cache_content> > cache(line, vector<cache_content>(way));
    for (auto &v : addrs) {
        int index = (v >> offset_bit) & (line - 1);
        int tag   = v >> (index_bit + offset_bit);
        bool is_miss = true;
        for (auto &item : cache[index]) {
            if (~item.v && item.tag != tag)
                continue;
            is_miss = false;
            item.v = total;
        }
        if (is_miss) {
            miss_addrs.push_back(v);
            int minIdx = -1, minV = INF;
            for (int i = 0 ; i < way ; i++)
                if (cache[index][i].v < minV)
                    minV = cache[index][i].v, minIdx = i;
            cache[index][minIdx].tag = tag;
            cache[index][minIdx].v   = total;
        }
        total++;
    }
    return miss_addrs;
}
int A_structure() {
    int total = addrs.size();
    int miss  = simulate(1 << 9, 8 * 4, 8, addrs).size();
    int hit   = total - miss;
    return miss * 836 + hit * 4;
}
int B_structure() {
    int total = addrs.size();
    int miss  = simulate(1 << 9, 8 * 4, 8, addrs).size();
    int hit   = total - miss;
    return miss * 108 + hit * 4;
}
int C_structure() {
    vector<LL> L1_miss_addrs = simulate(1 << 7, 4 * 4, 8, addrs);
    vector<LL> L2_miss_addrs = simulate(1 << 12, 32 * 4, 8, L1_miss_addrs);
    int L2_miss = L2_miss_addrs.size();
    int L1_miss = L1_miss_addrs.size() - L2_miss;
    int total   = addrs.size();
    int hit     = total - L1_miss_addrs.size();
    for (auto &v : addrs)
        cout << v << '\n';
    cout << total << '\n';
    cout << hit << '\n';
    cout << L1_miss << '\n';
    cout << L2_miss << '\n';
    return hit * 3 + L1_miss * 55 + L2_miss * 3639;
}
int main(int argc, char **argv) {
    if (argc != 3) {
        cout << "Usage: " << argv[0] << " <input file> <output file>\n";
        exit(0);
    }

    ifstream  in(argv[1]);
    ofstream out(argv[2]);
    input(in);
    matrix_mul(A, A_addr, B, B_addr, C, C_addr);
    matrix_output(out, C);
    out << execution_cycles() << ' ';
    out << A_structure() << ' ';
    out << B_structure() << ' ';
    out << C_structure() << '\n';
}
