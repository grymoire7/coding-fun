package com.magicbydesign.codingfun;

import java.util.function.Function;

public class Palindrome {
    
    static final boolean DEBUG = false;
    static int testsTotal  = 0;
    static int testsPassed = 0;
    
    private static void log(String message) {
        if (DEBUG) { System.out.println(message); }
    }
    
    /**
     * Check for palindrome using an index into the string.
     * 
     * @param p
     * @return true if p is a palindrome, false otherwise
     * @throws IllegalArgumentException
     */
    public static boolean checkWithIndex(String p) {
        if (p == null || p.length() == 0) {
            throw new IllegalArgumentException();
        }
        
        // normalize the input: no non-alpha chars, lowercase
        // assume default locale
        String n = p.toLowerCase().replaceAll("[^a-zA-Z]+", "");
        log( "string: " + p + "\nnormalized: " + n  );
        
        // check for palindrome
        for (int i=0, l = n.length(); i < l/2; i++) {
            if (n.charAt(i) != n.charAt(l - i - 1)) {
                return false;
            }
        }

        return true;
    } 
    
    /**
     * Check for palindrome without using an index.
     * 
     * @param p
     * @return true if p is a palindrome, false otherwise
     * @throws IllegalArgumentException
     */
    public static boolean checkWithoutIndex(String p) {

        if (p == null || p.length() == 0) {
            throw new IllegalArgumentException();
        }
        
        // normalize the input: no non-alpha chars, lowercase
        // assume default locale
        String n = p.toLowerCase().replaceAll("[^a-zA-Z]+", "");
        log( "string: " + p + "\nnormalized: " + n );
        
        // check for palindrome w/o index
        String r = new StringBuilder(n).reverse().toString();
        if (! n.equals(r)) {
            return false;
        }

        return true;
    } 

    public static void testPalFunc(String fname, Function<String, Boolean> palFunc) {

        String testName = fname + ": null argument";
        try {
            test(palFunc.apply(null) == false, testName);
            test(true, testName);
        }
        catch (IllegalArgumentException ex) {
            test(true, testName);
        }

        testName = fname + ": zero length argument";
        try {
            test(palFunc.apply("") == false, testName);
            test(false, testName);
        }
        catch (IllegalArgumentException ex) {
            test(true, testName);
        }

        test(palFunc.apply("a") == true, fname + ": one char");
        test(palFunc.apply(" ") == true, fname + ": one space");
        test(palFunc.apply("Racecar") == true, fname + ": Racecar");
        test(palFunc.apply("aabaa") == true, fname + ": aabaa");
        test(palFunc.apply("abaa") == false, fname + ": abaa");
        test(palFunc.apply("aaba") == false, fname + ": aaba");
        test(palFunc.apply("ab") == false, fname + ": ab");
        test(palFunc.apply("A man, a plan, a canal.  Panama!") == true, fname + ": panama");
        test(palFunc.apply("Was it a cat I saw?") == true, fname + ": i saw a cat");
        test(palFunc.apply("#$@?!") == true, fname + ": cursing symbols");
    }

    public static void test(boolean cond, String testName) {
        System.out.println(testName + ( cond ? ": pass" : ": fail"));
        testsTotal++;
        if (cond) { testsPassed++; }
    }
    public static void testReport() {
        System.out.println("Tests passed: " + testsPassed + "/" + testsTotal);
    }

    public static void main(String[] args) {
        testPalFunc("checkWithIndex", Palindrome::checkWithIndex);
        testPalFunc("checkWithoutIndex", Palindrome::checkWithoutIndex);
        testReport();
    }

}
