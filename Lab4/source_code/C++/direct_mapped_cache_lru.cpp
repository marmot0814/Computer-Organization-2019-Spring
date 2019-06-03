#include <iostream>
#include <fstream>
#include <cstdio>
#include <iomanip>
#include <cmath>

#define FILENAME "../../test/LU.txt"

using namespace std;

struct cache_content {
    int stamp;
    unsigned int tag;
};

const int K = 1024;
const int block_size = 64;
const int INF = 0x3f3f3f3f;

double simulate(int cache_size, int way, string filename) {
    int offset_bit = __lg(block_size);
    int line = cache_size / block_size;
    int index_bit  = __lg(line) - __lg(way);
    
    cache_content *cache = new cache_content[line];

    for (int i = 0 ; i < line ; i++)
        cache[i].stamp = -1;

    FILE *fp = fopen(("../../test/" + filename).c_str(), "r");

    unsigned int total = 0, miss = 0;
    int x; while (~fscanf(fp, "%x", &x)) {
        total++; x >>= offset_bit;
        unsigned int index = x & ((1 << index_bit) - 1);
        unsigned int tag   = x >> index_bit;

        bool hit = false;
        for (int i = 0 ; i < way ; i++) {
            if (~cache[index * way + i].stamp && cache[index * way + i].tag == tag)
                hit = true;
        }
        if (hit) continue;
        miss++;
        int target_i = -1, minV = INF;
        for (int i = 0 ; i < way ; i++)
            if (cache[index * way + i].stamp < minV)
                minV = cache[index * way + i].stamp, target_i = i;
        cache[index * way + target_i].stamp = total;
        cache[index * way + target_i].tag = tag;
    }
    fclose(fp);
    delete []cache;
    return 100.0 * miss / total;
}

void runTest(string filename) {
    cout << "Input file: " << filename << '\n';
    cout << "      ";
    for (int way = 1 ; way <= 8 ; way <<= 1)
        cout << setw(4) << way << "-way";
    cout << "\n---------------------------------------\n";
    for (int cache_size = 1 ; cache_size <= 32 ; cache_size <<= 1) {
        cout << setw(3) << cache_size << "K: ";
        for (int way = 1 ; way <= 8 ; way <<= 1)
            cout << setw(8) << fixed << setprecision(3) << simulate(cache_size * K, way, filename);
        cout << '\n';
    }
    cout << '\n';
}

int main() {
    cout << "direct_apped_cache_lru.cpp, cache_size to n-way\n\n";
    runTest("ICACHE.txt");
    runTest("DCACHE.txt");
    runTest("LU.txt");
    runTest("RADIX.txt");
}
