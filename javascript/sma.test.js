// Simple tests with no dependencies for sma.js
//
// $ node sma.test.js
//
const { QuestionSelector, getDayOfYear, getCategoriesForDay, getQuestionIndicesForDayOfYear, getQuestionIndicesForDate } = require('./sma.js');

function test(cond, message) {
  console.log(message + (cond ? ': pass' : ': fail'));
}

// Test cases for dayOfYear
console.log('\nRunning tests for dayOfYear...');
test(getDayOfYear(new Date(2023, 0, 1)) === 1, 'Day of year for Jan 1, 2023');
test(getDayOfYear(new Date(2023, 11, 31)) === 365, 'Day of year for Dec 31, 2023');
test(getDayOfYear(new Date(2023, 5, 15)) === 165, 'Day of year for Jun 15, 2023');
test(getDayOfYear(new Date(2023, 9, 01)) === 273, 'Day of year for Oct 1, 2023');

// Test cases for getCategoriesForDay
console.log('\nRunning tests for getCategoriesForDay...');
test(JSON.stringify(getCategoriesForDay(1, 3)) === JSON.stringify([0, 1, 2, 0]), 'Categories for day 1 with 3 categories');
test(JSON.stringify(getCategoriesForDay(2, 3)) === JSON.stringify([1, 2, 0, 1]), 'Categories for day 2 with 3 categories');
test(JSON.stringify(getCategoriesForDay(3, 3)) === JSON.stringify([2, 0, 1, 2]), 'Categories for day 3 with 3 categories');
test(JSON.stringify(getCategoriesForDay(4, 3)) === JSON.stringify([0, 1, 2, 0]), 'Categories for day 4 with 3 categories');
test(JSON.stringify(getCategoriesForDay(365, 3)) === JSON.stringify([1, 2, 0, 1]), 'Categories for day 365 with 3 categories');
test(JSON.stringify(getCategoriesForDay(1, 5)) === JSON.stringify([0, 1, 2, 3]), 'Categories for day 1 with 5 categories');
test(JSON.stringify(getCategoriesForDay(2, 5)) === JSON.stringify([1, 2, 3, 4]), 'Categories for day 2 with 5 categories');
test(JSON.stringify(getCategoriesForDay(3, 5)) === JSON.stringify([2, 3, 4, 0]), 'Categories for day 3 with 5 categories');
test(JSON.stringify(getCategoriesForDay(4, 5)) === JSON.stringify([3, 4, 0, 1]), 'Categories for day 4 with 5 categories');
test(JSON.stringify(getCategoriesForDay(5, 5)) === JSON.stringify([4, 0, 1, 2]), 'Categories for day 5 with 5 categories');
test(JSON.stringify(getCategoriesForDay(365, 5)) === JSON.stringify([4, 0, 1, 2]), 'Categories for day 365 with 5 categories');

// Test cases for getQuestionIndicesForDayOfYear
console.log('\nRunning tests for getQuestionIndicesForDayOfYear...');
const categories = [0, 1, 2, 3];
const categoryCount = 5;
const questionCounts = [10, 15, 20, 25, 8];

var calculated = getQuestionIndicesForDayOfYear(1, categories, categoryCount, questionCounts);
var expected = [0, 0, 0, 0];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 1');

calculated = getQuestionIndicesForDayOfYear(2, categories, categoryCount, questionCounts);
expected = [0, 1, 1, 1];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 2');

calculated = getQuestionIndicesForDayOfYear(3, categories, categoryCount, questionCounts);
expected = [1, 1, 2, 2];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 3');

calculated = getQuestionIndicesForDayOfYear(4, categories, categoryCount, questionCounts);
expected = [2, 2, 2, 3];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 4');

calculated = getQuestionIndicesForDayOfYear(5, categories, categoryCount, questionCounts);
expected = [3, 3, 3, 3];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 5');

calculated = getQuestionIndicesForDayOfYear(10, categories, categoryCount, questionCounts);
expected = [7, 7, 7, 7];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 10');

calculated = getQuestionIndicesForDayOfYear(15, categories, categoryCount, questionCounts);
expected = [1, 11, 11, 11];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 15');

calculated = getQuestionIndicesForDayOfYear(20, categories, categoryCount, questionCounts);
expected = [5, 0, 15, 15];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 20');

calculated = getQuestionIndicesForDayOfYear(25, categories, categoryCount, questionCounts);
expected = [9, 4, 19, 19];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 25');

calculated = getQuestionIndicesForDayOfYear(365, categories, categoryCount, questionCounts);
expected = [1, 6, 11, 16];
test(JSON.stringify(calculated) === JSON.stringify(expected), 'Question indices for day 365');

// Test cases for getQuestionIndicesForDate
console.log('\nRunning tests for getQuestionIndicesForDate...');
const date1 = new Date(2023, 0, 1); // Jan 1, 2023
const date2 = new Date(2023, 0, 2); // Jan 2, 2023
const date3 = new Date(2023, 0, 3); // Jan 3, 2023
const date4 = new Date(2023, 0, 4); // Jan 4, 2023
const date5 = new Date(2023, 0, 5); // Jan 5, 2023
const date10 = new Date(2023, 0, 10); // Jan 10, 2023
const date15 = new Date(2023, 0, 15); // Jan 15, 2023
const date20 = new Date(2023, 0, 20); // Jan 20, 2023
const date25 = new Date(2023, 0, 25); // Jan 25, 2023
const date365 = new Date(2023, 11, 31); // Dec 31, 2023

test(JSON.stringify(getQuestionIndicesForDate(date1, categoryCount, questionCounts)) === JSON.stringify([0, 0, 0, 0]), 'Question indices for Jan 1, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date2, categoryCount, questionCounts)) === JSON.stringify([0, 1, 1, 1]), 'Question indices for Jan 2, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date3, categoryCount, questionCounts)) === JSON.stringify([1, 1, 2, 2]), 'Question indices for Jan 3, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date4, categoryCount, questionCounts)) === JSON.stringify([2, 2, 2, 3]), 'Question indices for Jan 4, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date5, categoryCount, questionCounts)) === JSON.stringify([3, 3, 3, 3]), 'Question indices for Jan 5, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date10, categoryCount, questionCounts)) === JSON.stringify([7, 7, 7, 7]), 'Question indices for Jan 10, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date15, categoryCount, questionCounts)) === JSON.stringify([3, 1, 11, 11]), 'Question indices for Jan 15, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date20, categoryCount, questionCounts)) === JSON.stringify([7, 5, 0, 15]), 'Question indices for Jan 20, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date25, categoryCount, questionCounts)) === JSON.stringify([3, 9, 4, 19]), 'Question indices for Jan 25, 2023');
test(JSON.stringify(getQuestionIndicesForDate(date365, categoryCount, questionCounts)) === JSON.stringify([3, 1, 6, 11]), 'Question indices for Dec 31, 2023');


// // Method 1: Using explicit timezone offset
// const d = new Date('2023-01-01T00:00:00Z'); // 'Z' indicates UTC timezone
// console.log('With Z suffix:', d.getFullYear());
// 
// // Method 2: Using explicit date parts
// const d2 = new Date(2023, 0, 1); // months are 0-based
// console.log('Using constructor:', d2.getFullYear());
// 
// // Method 3: Using Date.UTC
// const d3 = new Date(Date.UTC(2023, 0, 1));
// console.log('Using Date.UTC:', d3.getFullYear());
//

module.exports = { QuestionSelector, getDayOfYear, getCategoriesForDay, getQuestionIndicesForDayOfYear, getQuestionIndicesForDate };

