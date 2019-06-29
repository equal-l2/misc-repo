import std.algorithm;
import std.array;
import std.bigint;
import std.bitmanip;
import std.conv;
import std.numeric;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

T diff(T)(const ref T a, const ref T b) { return a > b ? a - b : b - a; }

T[] readToArray(T)() {
    return readln.split.to!(T[]);
}

void readInto(T...)(ref T ts) {
    auto ss = readln.split;
    foreach(ref t; ts) {
        t = ss.front.to!(typeof(t));
        ss.popFront;
    }
}

// 冪乗をmod取りつつ計算
@nogc @safe pure ulong modPow(ulong a, ulong n, ulong m) {
    ulong r = 1;
    while (n > 0) {
        if(n % 2 != 0) r = r * a % m;
        a = a * a % m;
        n /= 2;
    }
    return r;
}

// フェルマーの小定理から乗法逆元を計算
// 定理の要請により法は素数
@nogc @safe pure ulong modInv(ulong a, ulong m) {
    return modPow(a, m-2, m);
}

// mod取りつつ順列を計算
@nogc @safe pure ulong modPerm(ulong n, ulong k, ulong m) {
    if (n < k) return 0;

    ulong r = 1;
    for (ulong i = n-k+1; i <= n; i++) {
        r *= i;
        r %= m;
    }
    return r;
}

// mod取りつつ順列を計算
@nogc @safe pure ulong modFact(ulong n, ulong m) {
    return modPerm(n, n, m);
}

// mod取りつつ組み合わせを計算
// modInvを使っているので法は素数
@nogc @safe pure ulong modComb(ulong n, ulong r, ulong m) {
    return modPerm(n, r, m)*modInv(modFact(r, m), m) % m;
}

immutable ulong MOD = 1000000007;

void main() {
    ulong n, k;
    readInto(n, k);
    for (ulong i = 1; i <= k; i++) {
        writeln(modComb(n-k+1, i, MOD)*modComb(k-1, i-1, MOD) % MOD);
    }
}
