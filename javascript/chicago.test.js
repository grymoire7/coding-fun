// Simple tests with no dependencies for left_center_right.js
//
// $ node chicago.test.js
//
const { Die, Player, Chicago } = require('./chicago.js');

function test(cond, message) {
  console.log('  ' + message + (cond ? ': pass' : ': fail'));
}

console.log('\nRunning tests for Die...');

// Die#roll
console.log(' running tests for Die#roll...');

const ROLL_RESULTS = ['left', 'center', 'right', 'dot'];
let test_count = 10
let total_pass = 0;
[...Array(test_count)].forEach((_) => {
  let roll = Die.roll();
  total_pass += (roll >= 1 && roll <= 6);
});
test(total_pass == test_count, `${test_count} rolls within range for one die`)

console.log('\nRunning tests for Player...');

// Player test setup
let alice = new Player('Alice', 2);
let bob   = new Player('Bob', 3);

// Player#constructor
console.log(' running tests for Player#constructor...');

test(alice.dice_count === 2, 'dice count set');
test(alice.name === 'Alice', 'name set');

// Player#roll
console.log(' running tests for Player#roll...');

test_count = 10;
total_pass = 0;
[...Array(test_count)].forEach((_) => {
  let roll = alice.roll();
  total_pass += (roll >= 2 && roll <= 12);
});
test(total_pass == test_count, `${test_count} rolls within range for two dice`)

test_count = 10
total_pass = 0;
[...Array(test_count)].forEach((_) => {
  let roll = bob.roll();
  total_pass += (roll >= 3 && roll <= 18);
});
test(total_pass == test_count, `${test_count} rolls within range for three dice`)

console.log('\nRunning tests for Chicago...');

// Chicago#constructor
console.log(' running tests for Chicago#constructor...');

try {
  let _ = new Chicago(2, 'Alice');
  test(false, 'constuctor with too few players should fail');
} catch(e) {
  test(e.includes('at least two players'), 'constuctor with too few players should fail');
}

try {
  let _ = new Chicago(0, 'Alice', 'Bob', 'Clair')
  test(false, 'constuctor with too few dice should fail');
} catch(e) {
  test(e.includes('at least one die'), 'constuctor with too few dice should fail');
}

let chicago = new Chicago(3, 'Alice', 'Bob', 'Claire')
test(chicago.dice_count == 3, 'sets dice_count');
test(chicago.players.length == 3, 'creates players array of correct length');

let player_names = chicago.players.map(function(player) {
  return player.name;
});
test((player_names.includes('Alice')), 'creates a player named Alice')
test((player_names.includes('Bob')), 'creates a player named Bob')
test((player_names.includes('Claire')), 'creates a player named Claire')

let player_dice = chicago.players.map(function(player) {
  return player.dice_count;
});
test(player_dice.every(function(dice) { return dice === 3; }), 'creates players with 3 dice');

// Chicago#_reset
console.log(' running tests for Chicago#_reset...');

chicago = new Chicago(2, 'Alice', 'Bob');
let not_zero = 42;
for (var key in chicago.scores) {
  chicago.scores[key] = not_zero;
}
chicago.reset();
for (var key in chicago.scores) {
  test(chicago.scores[key] == 0, 'resets player score to 0');
}

// Chicago#play,  play an entire game
console.log(' running tests for Chicago#play...');

// first, let's load the dice so the outcomes are deterministic
var original_roll = Die.roll;
Die.roll_data = [1, 2, 3, 4, 5, 6];
Die.roll_idx = 0;
Die.roll = () => {
  let result = Die.roll_data[Die.roll_idx];
  Die.roll_idx = (Die.roll_idx + 1) % Die.roll_data.length;
  return result;
};

chicago = new Chicago(3, 'Alice', 'Bob', 'Claire');
// chicago.debug = true;
const [winners, high_score] = chicago.play();
test(winners.length === 1, 'there was one winner');
test(winners[0] === 'Bob', 'that winner was Bob');
test(high_score === 2, 'Bob wins with a score of 2');

Die.roll = original_roll; // put things back where we found them
