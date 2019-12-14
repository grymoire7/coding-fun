#!/usr/bin/env python

import random

class Die:
    @staticmethod
    def roll():
        return random.choice(("L", "R", "C", "*", "*", "*"))

class Player:
    def __init__(self, name, num_chips):
        self.name = name
        self.num_chips = num_chips

    def transfer_chip_to(self, player):
        self.num_chips -= 1
        player.num_chips += 1

class Game:
    starting_chips = 3
    max_turns = 1000

    def __init__(self, *player_names):
        self.players = []
        if (len(player_names) < 3):
            raise Exception("LCR must have at least three players!")
        for player_name in player_names:
            self.players.append(Player(player_name, self.starting_chips))
        self.center = Player("center", 0)
        self.turn_count = 0
        self.max_turns = 100 * len(self.players)

    def play_turn(self):
        active_player = self.players[0]
        left_player   = self.players[-1]
        right_player  = self.players[1]
        number_of_rolls = min(active_player.num_chips, 3)

        for _ in range(number_of_rolls):
            roll = Die.roll()

            print("{:7s}: chips: {}, roll: '{}'".format(active_player.name, active_player.num_chips, roll))

            if (roll == "L"):   # player to left gets 1 chip
                active_player.transfer_chip_to(left_player)
            elif (roll == "R"): # player to right gets 1 chip
                active_player.transfer_chip_to(right_player)
            elif (roll == "C"): # chip goes to the center
                active_player.transfer_chip_to(self.center)
            else:               # roll == "*" and do nothing
                pass

        self.rotate_active_player()
        self.turn_count += 1

    def rotate_active_player(self):
        self.players = self.players[1:] + self.players[0:1]

    def game_over(self):
        # game is over when only one players has chips
        players_with_chips = 0
        for player in self.players:
            if player.num_chips > 0:
                players_with_chips += 1
        return (players_with_chips == 1 or self.turn_count > self.max_turns)

    def find_winner(self):
        if not self.game_over():
            raise Exception("Can only have a winner when game is over.")

        for player in self.players:
            if player.num_chips > 0:
                return player

    def play(self):
        while (not self.game_over()):
            self.play_turn()
        print("Game over. The winner is {} in {} turns!".format(self.find_winner().name, self.turn_count))
        print("The center has {} chips.".format(self.center.num_chips))

if __name__ == '__main__':
    mygame = Game("Alice", "Bob", "Carol", "David")
    mygame.play()
