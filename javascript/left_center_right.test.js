// Simple tests with not dependencies for left_center_right.js
//
// $ node left_center_right.test.js
//
const { Die, Player, LeftCenterRight } = require('./left_center_right.js');

function test(cond, message) {
  console.log('  ' + message + (cond ? ': pass' : ': fail'));
}

console.log('\nRunning tests for Die...');

// Die#roll
console.log(' running tests for Die#roll...');

const ROLL_RESULTS = ['left', 'center', 'right', 'dot'];
let test_count = 10
let total_pass = 0;
for (let i=0; i < test_count; i++) {
  let roll = Die.roll();
  total_pass += (ROLL_RESULTS.includes(roll));
}
test(total_pass === test_count, `${test_count} rolls are all valid`)

console.log('\nRunning tests for Player...');

// Player test setup
let alice = new Player('Alice', 4);
let bob   = new Player('Bob', 3);

// Player#constructor
console.log(' running tests for Player#constructor...');

test(alice.chip_count === 4, 'chip count set');
test(alice.name === 'Alice', 'name set');

// Player#transferChipTo
console.log(' running tests for Player#transferChipTo...');

bob.transferChipTo(alice);
test(alice.chip_count === 5, 'chip count transfer target');
test(bob.chip_count === 2, 'chip count transfer source');

alice.transferChipTo();
test(alice.chip_count === 5, 'chip count transfer nil target');

// Player#roll
console.log(' running tests for Player#roll...');

alice.chip_count = 6;
test(alice.roll().length === 3, 'roll length 3 with 6 chips');
alice.chip_count = 3;
test(alice.roll().length === 3, 'roll length 3 with 3 chips');
alice.chip_count = 2;
test(alice.roll().length === 2, 'roll length 2 with 2 chips');
alice.chip_count = 1;
test(alice.roll().length === 1, 'roll length 1 with 1 chip');
alice.chip_count = 0;
test(alice.roll().length === 0, 'roll length 0 with 0 chips');

console.log('\nRunning tests for LeftCenterRight...');

// LeftCenterRight#constructor
console.log(' running tests for LeftCenterRight#constructor...');

try {
  let lcr = new LeftCenterRight(4, 'Alice')
  test(false, 'constuctor with too few players should fail');
} catch(e) {
  test(e.includes('at least three players'), 'constuctor with too few players should fail');
}

try {
  let lcr = new LeftCenterRight(0, 'Alice', 'Bob', 'Clair')
  test(false, 'constuctor with too few chips should fail');
} catch(e) {
  test(e.includes('at least one chip'), 'constuctor with too few chips should fail');
}

let lcr = new LeftCenterRight(8, 'Alice', 'Bob', 'Claire')
test(lcr.starting_chips == 8, 'sets starting_chips');
test(lcr.players.length == 3, 'creates players array of correct length');

let player_names = lcr.players.map(function(player) {
  return player.name;
});
test((player_names.includes('Alice')), 'creates a player named Alice')
test((player_names.includes('Bob')), 'creates a player named Bob')
test((player_names.includes('Claire')), 'creates a player named Claire')

let player_chips = lcr.players.map(function(player) {
  return player.chip_count;
});
test(player_chips.every(function(chips) { return chips === 8; }), 'creates players with 8 chips');

test(lcr.pot.chip_count == 0, 'the pot starts with zero chips')
test(lcr.play_counter == 0, 'the game counter at zero')

// LeftCenterRight#_reset
console.log(' running tests for LeftCenterRight#_reset...');

lcr = new LeftCenterRight(8, 'Alice', 'Bob', 'Claire');
let not_zero = 42;
lcr.players.forEach(function(player) {
  player.chip_count = not_zero;
});
lcr.play_counter = not_zero;
lcr.pot.chip_count = not_zero;
lcr._reset();

test(lcr.play_counter == 0, 'the game counter at zero');
test(lcr.pot.chip_count == 0, 'the pot chip count is zero');

player_chips = lcr.players.map(function(player) { return player.chip_count; });
test(player_chips.every(function(chips) { return chips === lcr.starting_chips; }), 'resets players with starting chips');

// LeftCenterRigth#play,  play an entire game
console.log(' running tests for LeftCenterRight#play...');

// first, let's load the dice so the outcomes are deterministic
var original_roll = Die.roll;
Die.roll_data = ['left', 'center', 'right', 'dot'];
Die.roll_idx = 0;
Die.roll = () => {
  let result = Die.roll_data[Die.roll_idx];
  Die.roll_idx = (Die.roll_idx + 1) % Die.roll_data.length;
  return result;
};

lcr = new LeftCenterRight(4, 'Alice', 'Bob', 'Claire');
// lcr.debug = true;
let results = lcr.play();
test(results.winner === 'Bob', 'Bob wins the test game');
test(results.total_turns === 16, 'Bob wins in 16 turns');

Die.roll = original_roll; // put things back where we found them
