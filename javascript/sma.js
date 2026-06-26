// In a daily trivia game we have N categoies. Each category has a number of questions.
// Each day we will have a rotating selection of four categories and one question from
// each category. The questions will be taken in order and will cycle through the
// categories and questions without skipping any.
//
// Tasks:
//
// 1. Determine which categories to use based on the day of the year.
//    Categories are cycled through in order, starting with categories [0, 1, 2, 3] on day 1.
//
// 2. Determine which question index to use within that category based on the day of the year.

class QuestionSelector {
  constructor(categoryCount, questionCounts) {
    if (categoryCount <= 0) {
      throw new Error('Category count must be greater than zero');
    }
    if (!Array.isArray(questionCounts) || questionCounts.length !== categoryCount) {
      throw new Error('Question counts must match the number of categories');
    }
    this.categoryCount = categoryCount;
    this.questionCounts = questionCounts;
  }

  getQuestionIndicesForDate(date) {
    return getQuestionIndicesForDate(date, this.categoryCount, this.questionCounts);
  }
}

function getDayOfYear(date = new Date()) {
    const start = new Date(date.getFullYear(), 0, 0);
    const diff = date - start;
    const oneDay = 1000 * 60 * 60 * 24;
    return Math.floor(diff / oneDay);
}

function getCategoriesForDay(dayOfYear, categoryCount) {
  if (categoryCount <= 0) {
    throw new Error('Category count must be greater than zero');
  }
  if (dayOfYear < 1 || dayOfYear > 365) {
    throw new Error('Day of year must be between 1 and 365');
  }

  const startIndex = (dayOfYear - 1) % categoryCount;
  const categories = [];

  for (let i = 0; i < 4; i++) {
    categories.push((startIndex + i) % categoryCount);
  }
  return categories;
}

// This functions returns the four question indices for the given day of the year.
// One for each corresponding category.
// The question indices are determined by the day of the year and the number of questions
// available in each category (questionCounts).
// The number of questions in each category may be less than 365 so we will cycle through
// the questions in each category based on the day of the year modulo the number of questions.
//
// returns an array of four indices, one for each category.
function getQuestionIndicesForDayOfYear(dayOfYear, categories, categoryCount, questionCounts) {
  if (!Array.isArray(categories) || categories.length !== 4) {
    throw new Error('Categories must be an array of four elements');
  }
  if (!Array.isArray(questionCounts) || questionCounts.length !== categoryCount) {
    throw new Error('Question counts must match the number of categories');
  }
  if (categoryCount < categories.length) {
    throw new Error('Category count must be at least the number of categories');
  }

  const indices = [];
  for (let i = 0; i < categories.length; i++) {
    const categoryIndex = categories[i];
    const questionCount = questionCounts[categoryIndex];

    if (questionCount <= 0) {
      throw new Error(`Category ${categoryIndex} has no questions available`);
    }

    seenQuestions = (dayOfYear - 1) * categories.length + i;
    const questionIndex = Math.floor(seenQuestions / categoryCount) % questionCount;
    indices.push(questionIndex);
  }
  // console.log(`Day ${dayOfYear}: Categories ${categories}, Question Indices ${indices}`);
  return indices;
}

function getQuestionIndicesForDate(date, categoryCount, questionCounts) {
  const dayOfYear = getDayOfYear(date);
  const categories = getCategoriesForDay(dayOfYear, categoryCount);

  idxs = getQuestionIndicesForDayOfYear(dayOfYear, categories, categoryCount, questionCounts);
  // console.log(`Date ${date.toISOString()}: Day: ${dayOfYear}, Categories ${categories}, Question Indices ${idxs}`);
  
  return idxs;
}

module.exports = { QuestionSelector, getDayOfYear, getCategoriesForDay, getQuestionIndicesForDayOfYear, getQuestionIndicesForDate };
