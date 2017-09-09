package com.magicbydesign.codingfun;

public class RomanNumerals {
    
    public enum Numeral {
        M(1000), CM(900), D(500), CD(400), C(100), XC(90), L(50), XL(40), X(10), IX(9), V(5), IV(4), I(1);
        
        private int value;
        Numeral(int value) { this.value = value; }
        public int value() { return value; }
    }

    public static String toRoman(long number) {
    	// check for the supported range for Roman numerals
        if ( number <= 0 || number >= 4000) {
            return null;
        }
        StringBuilder buf = new StringBuilder();
        for ( Numeral numeral : Numeral.values()) {
            while (number >= numeral.value()) {
                buf.append(numeral.name());
                number -= numeral.value();
            }
        }
        return buf.toString();
    }

    public static void test(boolean cond, String name) {
        System.out.println(name + (cond ? ": pass" : ": fail"));
    }

    public static void main(String[] args) {
        test(toRoman(-1) == null, "-1 null");
        test(toRoman(0) == null, "0 null");
        test(toRoman(4000) == null, "4000 null");
        test(toRoman(3).equals("III"), "3 III");
        test(toRoman(4).equals("IV"), "4 IV");
        test(toRoman(9).equals("IX"), "9 IX");
        test(toRoman(10).equals("X"), "10 X");
        test(toRoman(900).equals("CM"), "900 CM");
        test(toRoman(990).equals("CMXC"), "990 CMXC");
        test(toRoman(59).equals("LIX"), "59 LIX");
        test(toRoman(3999).equals("MMMCMXCIX"), "3999 MMMCMXCIX");
    }
}
