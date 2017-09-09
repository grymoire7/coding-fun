package com.magicbydesign.codingfun;

import java.util.function.Function;

public class Fibonacci {

    static final boolean DEBUG = false;

    // TODO: properly handle negative numbers
    // now if n < 0 we just return n

    public static int fibRecursive(int n) {
        if (n <= 1) {
            return n;
        }
        return fibRecursive(n-1) + fibRecursive(n-2);
    } 

    public static int fibOptimized(int n) {
        int a = 0, b = 1, c = 1;
        if (n <= 1) {
            return n;
        }
        for (int i=2; i <=n; i++) {
            c = a + b;
            a = b;
            b = c;
        }
        return c;
    }

    public static void testFibFunc(String fname, Function<Integer, Integer> fibFunc) {
        test(fibFunc.apply(-1) == -1, fname + ": -1 -> -1");
        test(fibFunc.apply(0) == 0, fname + ": 0 -> 0");
        test(fibFunc.apply(1) == 1, fname + ": 1 -> 1");
        test(fibFunc.apply(2) == 1, fname + ": 2 -> 1");
        test(fibFunc.apply(3) == 2, fname + ": 3 -> 2");
        test(fibFunc.apply(4) == 3, fname + ": 4 -> 3");
        test(fibFunc.apply(5) == 5, fname + ": 5 -> 5");
        test(fibFunc.apply(6) == 8, fname + ": 5 -> 8");
        test(fibFunc.apply(7) == 13, fname + ": 5 -> 13");
        test(fibFunc.apply(8) == 21, fname + ": 5 -> 21");
        test(fibFunc.apply(9) == 34, fname + ": 5 -> 34");
    }

    public static void test(boolean cond, String testName) {
        System.out.println(testName + (cond ? ": pass" : ": fail"));
    }

    public static void main(String[] args) {
        testFibFunc("recursive", Fibonacci::fibRecursive);
        testFibFunc("optimized", Fibonacci::fibOptimized);
    }
}
