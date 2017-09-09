package com.magicbydesign.codingfun;

import java.util.HashMap;

public class ChangeMaker {
    
    public enum Coins {
        QUARTER(25), DIME(10), NICKEL(5), PENNY(1);
        
        private int value;
        Coins(int value) { this.value = value; }
        public int value() { return value; }
    }
    
    /**
     * Takes a US currency amount and returns a hash of change representing
     * that amount in the fewest possible US coins (quarters, dimes, nickels,
     * pennies).
     * 
     * @param amount
     * @return hash of change
     */
    public static HashMap<Coins, Integer> makeChange(double amount) {
    	// first make sure this is a currency amount
        int cents = (int)( (amount + 0.005)*100 );
        if (amount != cents/100.0 || amount < 0) {
            return null;
        }

        HashMap<Coins, Integer> register = new HashMap<>();

        for (Coins c: Coins.values()) {
            int numCoin = cents / c.value();
            cents = cents % c.value();
            register.put(c, numCoin);
        }

        return register;
    }
    
    public static void test(boolean cond, String name) {
        System.out.println(name + (cond ? ": pass" : ": fail"));
    }

    public static void main(String[] args) {
        HashMap<Coins, Integer> register = ChangeMaker.makeChange(1.053);
        ChangeMaker.test(null == register, "1.053 invalid input");
        
        register = ChangeMaker.makeChange(-1.50);
        ChangeMaker.test(null == register, "-1.50 invalid input");

        register = ChangeMaker.makeChange(0);
        ChangeMaker.test(null != register, "0 valid input");
        if (null != register) {
            for (Coins c : register.keySet()) {
                ChangeMaker.test(register.get(c) == 0, "0 " + c.name().toLowerCase() + " " + register.get(c));
            }
        }

        register = ChangeMaker.makeChange(1.05);
        ChangeMaker.test(null != register, "1.05 valid input");
        if (null != register) {
            ChangeMaker.test(register.get(Coins.QUARTER) == 4, "1.05 quarters " + register.get(Coins.QUARTER));
            ChangeMaker.test(register.get(Coins.DIME)    == 0, "1.05 dimes "    + register.get(Coins.DIME));
            ChangeMaker.test(register.get(Coins.NICKEL)  == 1, "1.05 nickels "  + register.get(Coins.NICKEL));
            ChangeMaker.test(register.get(Coins.PENNY)   == 0, "1.05 cents "    + register.get(Coins.PENNY));
        }

        register = ChangeMaker.makeChange(1.16);
        ChangeMaker.test(null != register, "1.16 valid input");
        if (null != register) {
            ChangeMaker.test(register.get(Coins.QUARTER) == 4, "1.16 quarters " + register.get(Coins.QUARTER));
            ChangeMaker.test(register.get(Coins.DIME)    == 1, "1.16 dimes "    + register.get(Coins.DIME));
            ChangeMaker.test(register.get(Coins.NICKEL)  == 1, "1.16 nickels "  + register.get(Coins.NICKEL));
            ChangeMaker.test(register.get(Coins.PENNY)   == 1, "1.16 cents "    + register.get(Coins.PENNY));
        }
    }
}
