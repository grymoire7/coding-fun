// Chicago – Dice Game
// Number of players: 2 or more
// Number of dice: 2
//
// The Chicago dice game is a simple yet fun game. The rules are not very difficult 
// and the game is decided by pure luck, but still it is very addictive. Once you 
// start you might not want to stop to see if you can do better in the next game.
//
// The game is played in 11 rounds, starting with round 2, then going to round 3 
// and continuing until round 12. In each round each player takes his or her turn 
// and rolls both dice, trying to roll the number of that round. For example, in 
// the round with number 2, you aim to roll a 1 on each dice giving you a total of 2.
//
// Every player that rolls the number of the current round gets a point and adds 
// it to his overall score. After all 11 rounds are finished the game ends and the 
// player with the higher number of points is declared the winner.

class Die {
  static roll() {
    return Math.floor(Math.random()*6) + 1;
  }
}

class Player {
  constructor(name, dice_count) {
    this.name = name;
    this.dice_count = dice_count;
  }

  roll() {
    let total = 0;
    let times = this.dice_count;
    while (times--) { total += Die.roll(); }
    return total;
  }
}

class Chicago {
  constructor(dice_count, ...player_names) {
    if (player_names.length < 2) throw 'Chicago needs at least two players!';
    if (dice_count < 1) throw 'Chicago needs at least one die!';

    this.dice_count = dice_count;
    this.players = player_names.map(function(name) {
      return new Player(name, dice_count);
    });

    this.scores = {};
    let game = this;
    this.players.forEach(function(player) {
      game.scores[player.name] = 0;
    });
  }

  reset() {
    for (const [key, _] of Object.entries(this.scores)) {
      this.scores[key] = 0;
    }
  }

  playRound(round) {
    let game = this;
    let round_results = { round: round, players: {} };
    this.players.forEach(function(player) {
      let total_roll = player.roll();
      if (total_roll === round) {
        game.scores[player.name] += 1;
      }
      round_results.players[player.name] = {
        total_roll: total_roll,
        score: game.scores[player.name],
        won_round: (total_roll === round)
      };
    }.bind(game));
    return round_results;
  }

  play() {
    let min_round = this.dice_count;
    let max_round = this.dice_count * 6;
    for (var round = min_round; round <= max_round; round++) {
      let round_results = this.playRound(round);
      if (this.debug) { console.log(round_results); }
    }
    if (this.debug) { this.showResults(); }
    return this._find_winners();
  }

  showResults() {
    for (const player of this.players) {
      console.log(`${player.name}: ${this.scores[player.name]}`)
    }
    const [winners, high_score] = this._find_winners();
    let verb = (winners.length > 1) ? 'tie' : 'wins';
    console.log(`${winners.join(' and ')} ${verb} with a score of ${high_score}.`);
  }

  _find_winners() {
    let winners = [];
    let high_score = Math.max(...Object.values(this.scores));
    for (const player of this.players) {
      if (this.scores[player.name] == high_score) { winners.push(player.name) };
    }
    return [winners, high_score];
  }
}

module.exports = { Die, Player, Chicago };
