package com.magicbydesign.codingfun;

import java.util.Arrays;

public class MergeSort {
    
    static final boolean DEBUG = false;
    
    // convenience method
    public static int sort(int[] arr) {
        if (arr == null)
            return -1;

        return sort(arr, 0, arr.length - 1);    
    }
    
    /**
     * Sort given array in ascending order.
     * 
     * @param arr array to be sorted
     * @param leftIndex  index to left subarray
     * @param rightIndex  index to right subarray
     * @return  0 on success, non-zero on failure
     */
    public static int sort(int[] arr, int leftIndex, int rightIndex) {
        if (arr == null) {
            return -1;
        }

        if (leftIndex < 0 || rightIndex < 0 || rightIndex < leftIndex) {
            return -1;
        }

        if (arr.length <= 1 || leftIndex == rightIndex) {
            return 0;
        }

        int middleIndex = (leftIndex + rightIndex)/2;   // find the middle
        sort(arr, leftIndex, middleIndex);     // sort left
        sort(arr, middleIndex+1, rightIndex);   // sort right
        merge(arr, leftIndex, middleIndex, rightIndex); // merge the two
        
        if (DEBUG) {
            System.out.println("Sorted: " + Arrays.toString(arr));
        }
        return 0;
    }

    private static int merge(int[] arr, int leftIndex, int middleIndex, int rightIndex) {
        // get sizes of both sides
        int leftSize = middleIndex - leftIndex + 1;
        int rightSize = rightIndex - middleIndex;
        
        // make some temp arrays
        int leftHalf[]  = new int[leftSize];
        int rightHalf[] = new int[rightSize];
        
        System.arraycopy(arr, leftIndex, leftHalf, 0, leftSize);
        System.arraycopy(arr, middleIndex+1, rightHalf, 0, rightSize);

        if (DEBUG) {
            System.out.println("leftIndex=" + leftIndex + ", middleIndex=" + middleIndex + ", rightIndex=" + rightIndex);
            System.out.println(Arrays.toString(arr));
            System.out.println(Arrays.toString(leftHalf));
            System.out.println(Arrays.toString(rightHalf));
        }
        
        int i = 0, j = 0;  // left and right half indices
        int k = leftIndex; // index in the target array, arr
        
        // merge L and R into arr
        while (i < leftSize && j < rightSize) {
            if (leftHalf[i] <= rightHalf[j]) {
                arr[k] = leftHalf[i];
                i++;
            }
            else {
                arr[k] = rightHalf[j];
                j++;
            }
            k++;
        }

        // copy anything left on the left
        if (i < leftSize) {
            System.arraycopy(leftHalf, i, arr, k, leftSize - i);
        }
        
        // copy anything left on the right
        if (j < rightSize) {
            System.arraycopy(rightHalf, j, arr, k, rightSize - j);
        }

        return 0;
    }
    
    public static void test(boolean cond, String testName) {
        System.out.println(testName + (cond ? ": pass" : ": fail"));
    }

    public static void main(String[] args) {
        int[] testEmpty  = {};
        int[] testSingle = {5};
        int[] testOne    = {5, 6, 1, 3, 2, 4};
        int[] testTwo    = {3, 2, 1, 0, -1, -2};
        
        // edge cases
        MergeSort.test(MergeSort.sort(null) == -1, "sort null");
        MergeSort.test(MergeSort.sort(testEmpty) == -1, "sort length zero");
        MergeSort.test(MergeSort.sort(testEmpty, 0, testEmpty.length - 1) == -1, "param sort length zero");
        MergeSort.test(MergeSort.sort(testSingle, -1, 3) == -1, "left < 0");
        MergeSort.test(MergeSort.sort(testSingle, 0, -1) == -1, "right < 0");
        MergeSort.test(MergeSort.sort(testSingle, 5, 1) == -1, "right < left");
        MergeSort.test(MergeSort.sort(testSingle) == 0, "sort length one");
        MergeSort.test(testSingle[0] == 5, "testSingle unchanged");
        MergeSort.test(MergeSort.sort(testSingle, 0, testSingle.length - 1) == 0, "param sort length one");
        MergeSort.test(testSingle[0] == 5, "testSingle still unchanged");
        
        // array tests
        MergeSort.test(MergeSort.sort(testOne) == 0, "sort testOne");
        MergeSort.test(Arrays.toString(testOne).equals("[1, 2, 3, 4, 5, 6]"), "testOne sorted");
        MergeSort.test(MergeSort.sort(testTwo) == 0, "sort testTwo");
        MergeSort.test(Arrays.toString(testTwo).equals("[-2, -1, 0, 1, 2, 3]"), "testTwo sorted");
    }
}
