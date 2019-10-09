# Left Center Right dice game

See [code sample here](left_center_right.rb) with [specs](spec/left_center_right_spec.rb).
Note that the sample code does not implement any of the variations.

## Game Description
Each player receives at least 3 chips. Players take turns to roll three
six-sided dice, each of which is marked with "L", "C", "R" on one side, and a
single dot on the three remaining sides. For each "L" or "R" thrown, the player
must pass one chip to the player to their left or right, respectively. A "C"
indicates a chip to the center (pot). A dot has no effect.

If a player has fewer than three chips left, they are still in the game but
their number of chips is the number of dice they roll on their turn, rather
than rolling all three. When a player has zero chips, they pass the dice on
their turn, but may receive chips from others and take their next turn
accordingly. The winner is the last player with chips left.

## Variants
### A rule sometimes used to shorten the game
The player who does not receive chips after two passes is out of the game.

### Wild
One side on each die is marked with a Wild symbol in place of one of the dots.

The rules for LCR Wild are the same as with regular LCR, except for the
following difference:

If you roll any Wilds on your turn, take the following action:

* If you roll 1 Wild, take one chip from any opponent.
* If you roll 2 Wilds, take two chips from any opponent, or take one
  chip each from two different opponents.
* If you roll 3 Wilds, you take all the chips from the center pot and
  instantly win the game!

### Left Brain, Right Brain, Consume Brain
I restyled LCR for zombies in a game called "Left Brain, Right Brain, Consume
Brain" played with gummy brains instead of chips. Instead of discarding brain
to the center, you eat the brain (no pot). Halloween party fun for the whole
zombie family!

## References
* [Rules and variants from Dice Game Depot](https://www.dicegamedepot.com/lcr-dice-game-rules/)
* [Description and rules from Wikipedia](https://en.wikipedia.org/wiki/LCR_(dice_game))

