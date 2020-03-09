#include <algorithm>
#include <array>
#include <cmath>
#include <iomanip>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

using namespace std;

// read to vector
// for example M_RTV(as, int, n) expands to the below:
// ```
// vector<int> as(n);
// for(int lcnt = 0; lcnt < n; lcnt++) cin >> as[lcnt];
// ```
#define M_RTV(ident, type, cnt) \
    vector<type> ident(cnt);\
    do {\
        for(int lcnt = 0; lcnt < cnt; lcnt++) cin >> ident[lcnt];\
    } while(false)

// shorthand for range
#define M_RG(ident) ident.begin(), ident.end()

// https://qiita.com/EqualL2/items/b4683db7ab4e90545bb2
int ctoi(const char c){
    return (c-'0');
}

int main() {
}
