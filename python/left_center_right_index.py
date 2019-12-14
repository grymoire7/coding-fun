#!/usr/bin/env python

import random

class Player:
    numChips = 0
    def __init__(self, name, numChips):
        self.name = name
        self.numChips = numChips

class Game:
    die = ("L", "R", "C", "*", "*", "*")
    starting_chips = 3

    def __init__(self, *players):
        # initialize players
        self.players = []
        for player in players:
            self.players.append(Player(player, self.starting_chips))
        self.active_player_index = 0
        self.left_player_index = len(self.players) - 1
        self.right_player_index = 1

    def play_turn(self):
        number_of_rolls = min(self.players[self.active_player_index].numChips, 3)
        active_player = self.players[self.active_player_index]
        left_player   = self.players[self.left_player_index]
        right_player  = self.players[self.right_player_index]

        for i in range(number_of_rolls):
            roll = random.choice(self.die)

            # output
            chips = active_player.numChips
            print("player(" + active_player.name + "): chips: " + str(chips) + " roll: " + str(roll))
            if (roll == "L"):   # player to left gets 1 chip
                left_player.numChips += 1
                active_player.numChips -= 1
            elif (roll == "R"): # player to right gets 1 chip
                right_player.numChips += 1
                active_player.numChips -= 1
            elif (roll == "C"): # chip goes to the center
                active_player.numChips -= 1
            else:
                pass

        self.rotate_active_player()

    def rotate_active_player(self):
        num_players = len(self.players)
        self.active_player_index = (self.active_player_index + 1) % num_players
        self.left_player_index = (self.active_player_index - 1) % num_players
        self.right_player_index = (self.active_player_index + 1) % num_players

    def game_over(self):
        players_with_chips = 0
        for player in self.players:
            if player.numChips > 0:
                players_with_chips += 1
        return players_with_chips == 1

    def find_winner(self):
        if self.game_over():
            for player in self.players:
                if player.numChips > 0:
                    return player
        else:
            raise Exception("Can only have a winner when game is over.")

    def play(self):
        # play a turn
        # if turn didn't end the game, continue
        turn_count = 0
        max_turns = 10000
        while (not self.game_over()) and (turn_count < max_turns):
            self.play_turn()
            turn_count += 1
        print("All done, winner is: ")
        print(self.find_winner().name)

# testing the game
mygame = Game("Alice", "Bob", "Carol", "David")
mygame.play()

