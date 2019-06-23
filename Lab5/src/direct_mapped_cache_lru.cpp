#include <iostream>
#include <fstream>
#include <cstdio>
#include <iomanip>
#include <cmath>
#include<cstring>

#define FILENAME "../../test/LU.txt"

using namespace std;

struct cache_content {
    int stamp;
    unsigned int tag;
};

const int K = 1024;
const int block_size = 64;
const int INF = 0x3f3f3f3f;
void matrix_multiplication(string filename) {
    FILE *fp = fopen(("../test/" + filename).c_str(), "r");
    
    int ADDR0, ADDR1, ADDR2, m, n, p;
    fscanf(fp, "%x %x %x %d %d %d", &ADDR0, &ADDR1, &ADDR2, &m, &n, &p);

    int A[m][n], B[n][p], C[m][p];
    memset(C, 0, sizeof(C));
    //read matrix m*n
    for (int i = 0 ; i < m ; i++) {
        for (int j = 0 ; j < n ; j++) {
            fscanf(fp, "%d ", &A[i][j]);
        }
    }
    //read matrix n*p
    for (int i = 0 ; i < n ; i++) {
        for (int j = 0 ; j < p ; j++) {
            fscanf(fp, "%d ", &B[i][j]);
        }
    }
    //compute matrix multiplication
    int count = 0;
    count += 2;//initial instruction
    for (int i = 0 ; i <= m ; i++) {
        count += 2;//check branch      
        if(i == m) 
            break;     
        count += 1;
        for (int k = 0 ; k <= n ; k++) {
            count += 2;//check branch
            if(k == n){
                count += 2;//end_j
                break;
            }
            count += 1;
            for ( int j = 0; j <= p ; j++) {
                count += 2;//check branch
                if(j == p){
                    count += 2;//end_k
                    break;
                }
                count += 18;//instruction in k_loop
                C[i][j] += A[i][k] * B[k][j];
                count += 2; //end_work
            }
        }
    }

    for(int i = 0 ; i < m ; i++)
        for(int j = 0; j < p ; j++)
            cout << C[i][j] << " \n"[j==p-1];
    cout << count << '\n';
    return ;

}
double simulate(int cache_size, int way, int type) {
    int offset_bit = __lg(block_size);
    int line = cache_size / block_size;
    int index_bit  = __lg(line) - __lg(way);
    
    cache_content *cache = new cache_content[line];

    for (int i = 0 ; i < line ; i++)
        cache[i].stamp = -1;


    unsigned int total = 0, miss = 0;
    
    int x; 

    total++; x >>= offset_bit;
    unsigned int index = x & ((1 << index_bit) - 1);
    unsigned int tag   = x >> index_bit;

    bool hit = false;
    for (int i = 0 ; i < way ; i++) {
        if (~cache[index * way + i].stamp && cache[index * way + i].tag == tag)
            hit = true, cache[index * way + i].stamp = total;
        if (hit) break;
    }
    if (hit) continue;
    miss++;
    int target_i = -1, minV = INF;
    for (int i = 0 ; i < way ; i++)
        if (cache[index * way + i].stamp < minV)
            minV = cache[index * way + i].stamp, target_i = i;
    cache[index * way + target_i].stamp = total;
    cache[index * way + target_i].tag = tag;
    
    if(type == 1)
    {
        
    }
    // fclose(fp);
    delete []cache;
    return 100.0 * miss / total;
}

void runTest(string filename) {
    cout << "Input file: " << filename << '\n';
    // cout << "      ";
    // simulate(0, 0, filename);
    matrix_multiplication(filename);
    // for (int way = 1 ; way <= 8 ; way <<= 1)
    //     cout << setw(4) << way << "-way";
    // cout << "\n---------------------------------------\n";
    // for (int cache_size = 1 ; cache_size <= 32 ; cache_size <<= 1) {
    //     cout << setw(3) << cache_size << "K: ";
    //     for (int way = 1 ; way <= 8 ; way <<= 1)
    //         cout << setw(8) << fixed << setprecision(3) << simulate(cache_size * K, way, filename);
    //     cout << '\n';
    // }
    // cout << '\n';

}

int main() {
    cout << "direct_apped_cache_lru.cpp, cache_size to n-way\n\n";
    runTest("a1xb1");
    // runTest("a2xb2.txt");
    // runTest("a3xb3.txt");
    // runTest("a4xb4.txt");
    
}
