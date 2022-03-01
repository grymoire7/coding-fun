class Die {
  static roll() {
    const SIDES = ['left', 'center', 'right', 'dot', 'dot', 'dot'];
    return SIDES[Math.floor(Math.random()*SIDES.length)];
  }
}

class Player {
  constructor(name, chip_count) {
    this.name = name;
    this.chip_count = chip_count;
  }

  hasChips() {
    return this.chip_count > 0;
  }

  transferChipTo(player) {
    if (!player || !this.hasChips()) return;
    this.chip_count -= 1;
    player.chip_count += 1;
  }

  roll() {
    let dice_to_roll = Math.min(this.chip_count, 3);
    let rolls = [];
    for (let i=0; i < dice_to_roll; i++) {
      rolls.push(Die.roll());
    }
    return rolls;
  }
}

class LeftCenterRight {
  constructor(starting_chips, ...player_names) {
    if (player_names.length < 3) throw 'LCR needs at least three players!';
    if (starting_chips < 1) throw 'LCR needs at least one chip!';
    this.starting_chips = starting_chips;
    this.players = player_names.map(function(name) {
      return new Player(name, starting_chips);
    });
    this.pot = new Player('pot', 0); // a Player for ease of chip transfer
    this.play_counter = 0;
    this.max_plays = 100;
  }

  play() {
    this._reset();
    do { this._play_turn(); } while (! this._game_over());
    return {
      winner: this._winner(),
      total_turns: this.play_counter
    };
  }

  // ----- private functions

  _reset() {
    let game = this;
    this.players.forEach(function(player) {
      player.chip_count = this.starting_chips;
    }.bind(game));
    this.pot.chip_count = 0;
    this.play_counter = 0;
  }

  _play_turn() {
    let active_player = this._active_player();
    if (active_player.hasChips()) {
      this._handle_turn();
      if (this.debug) { this._show_state(); }
    }
    this.play_counter += 1;
  }

  _active_player(offset = 0) {
    let player_index = (offset + this.play_counter + this.players.length) % this.players.length;
    return this.players[player_index];
  }

  _handle_turn() {
    let debug = this.debug;
    let left_player   = this._active_player(-1);
    let active_player = this._active_player(0);
    let right_player  = this._active_player(1);
    let transfer_targets = {
      left: left_player,
      center: this.pot,
      right: right_player
      // dot: active_player // no point in transferring to self though
    };
    if (debug) { process.stdout.write(`[${this.play_counter}] ${active_player.name} rolls:`); }
    active_player.roll().forEach(function(roll) {
      if (debug) { process.stdout.write(' ' + roll); }
      active_player.transferChipTo(transfer_targets[roll])
    });
    if (debug) { process.stdout.write('\n'); }
  }

  _winner() {
    let player_with_chips = this.players.find(function(player) {
      return player.hasChips();
    });
    if (player_with_chips === undefined) { return 'Nobody'; }
    return player_with_chips.name;
  }

  _game_over() {
    let players_with_chips = 0;
    this.players.forEach(function(player) {
      if (player.chip_count > 0 ) { players_with_chips += 1; }
    });
    if (this.play_counter >= this.max_plays) { return true; }
    return (players_with_chips === 1);
  }

  _show_state() {
    process.stdout.write('| ');
    this.players.forEach(function(player) {
      process.stdout.write(`${player.name}: ${player.chip_count}, `);
    });
    process.stdout.write(`${this.pot.name}: ${this.pot.chip_count}\n`);
  }
}

module.exports = { Die, Player, LeftCenterRight };
