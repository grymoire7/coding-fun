// Description: Given two arrays, arrayA and arrayB, where arrayA
// contains the indices of arrayB and arrayB contains the values at
// each index, write a function that will traverse the arrays and
// return the maximum value encountered in arrayB. The traversal starts
// at the first element of arrayA and continues until the first element
// of arrayA is reached again. If the first element of arrayA is reached
// again, the function should return the maximum value encountered in
// arrayB.
// 
// Example:
// arrayA = [2, 4, 3, 1, 6]
// arrayB = [4, 0, 3, 2, 0]
//
// The traversal of the arrays would be as follows:
// arrayA[0] = 2, arrayB[2] = 3
// arrayA[3] = 1, arrayB[1] = 0
//
// The maximum value encountered in arrayB is 3.

function gloriaArrayTraversal(arrayA, arrayB) {
    let indexA = 0;
    let indexB = -1;
    let max_value = Number.MIN_VALUE;

    while (true) {
        indexB = arrayA[indexA];
        if (arrayB[indexB] > max_value) {
            max_value = arrayB[indexB];
        }
        indexA = arrayB[indexB];
        if (indexA === 0) {
            return max_value;
        }
    }
}

(() => {
    const arrayA = [2, 4, 3, 1, 6];
    const arrayB = [4, 0, 3, 2, 0];

    console.log("Maximum value encountered in arrayB:", gloriaArrayTraversal(arrayA, arrayB));
    // Prints:
    // Maximum value encountered in arrayB: 3
})();
