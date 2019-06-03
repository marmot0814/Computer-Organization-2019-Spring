#include <iostream>
#include <stdio.h>
#include <math.h>
#include <iomanip>

using namespace std;

struct cache_content
{
	bool v;
	unsigned int tag;
    // unsigned int	data[16];
};

const int K = 1024;

double log2(double n)
{  
    // log(n) / log(2) is log2.
    return log(n) / log(double(2));
}


double simulate(int cache_size, int block_size, string filename)
{
	unsigned int tag, index, x;

	int offset_bit = (int)log2(block_size);
	int index_bit = (int)log2(cache_size / block_size);
	int line = cache_size >> (offset_bit);

	cache_content *cache = new cache_content[line];

    // cout << "cache line: " << line << endl;

	for(int j = 0; j < line; j++)
		cache[j].v = false;

    FILE *fp = fopen(("../../test/" + filename).c_str(), "r");  // read file

    unsigned int total = 0, miss = 0;
	
	while(fscanf(fp, "%x", &x) != EOF)
    {
		// cout << hex << x << " ";
		index = (x >> offset_bit) & (line - 1);
		tag = x >> (index_bit + offset_bit);
        total++;
		if(cache[index].v && cache[index].tag == tag)
			cache[index].v = true;    // hit
        else
        {
            miss++;
			cache[index].v = true;  // miss
			cache[index].tag = tag;
		}
	}
	fclose(fp);
	delete [] cache;
    return 100.0 * miss / total;
}

void runTest(string filename) {
    cout << "Input file: " << filename << '\n';
    cout << "      ";
    for (int block_size = 16 ; block_size <= 256 ; block_size <<= 1)
        cout << setw(8) << block_size;
    cout << "\n-----------------------------------------------\n";
    for (int cache_size = 4 ; cache_size <= 256 ; cache_size <<= 2) {
        cout << setw(3) << cache_size << "K: ";
        for (int block_size = 16 ; block_size <= 256 ; block_size <<= 1)
            cout << setw(8) << fixed << setprecision(3) << simulate(cache_size * K, block_size, filename);
        cout << '\n';
    }
    cout << '\n';
}

int main()
{
    cout << "direct_mapped_cache.cpp, cache_size to block_size\n\n";
    runTest("ICACHE.txt");
    runTest("DCACHE.txt");
    runTest("LU.txt");
    runTest("RADIX.txt");
}
