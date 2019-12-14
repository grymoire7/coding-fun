#!/usr/bin/env python

import unittest
from left_center_right import Game, Player
import logging

class TestPlayer(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        super(TestPlayer, cls).setUpClass()
        FORMAT = '%(levelname)-8s: %(message)s'
        logging.basicConfig(format=FORMAT, level=logging.INFO)

    def setUp(self):
        self.player_a = Player("Alice", 3)
        self.player_b = Player("Bob", 3)

    def test_init(self):
        a = Player("Alice", 3)
        self.assertTrue(isinstance(a, Player))
        self.assertEqual(a.name, "Alice")
        self.assertEqual(a.num_chips, 3)

    def test_transfer_chips_to(self):
        chips_a = self.player_a.num_chips
        chips_b = self.player_b.num_chips
        self.player_a.transfer_chip_to(self.player_b)
        self.assertEqual(self.player_a.num_chips, chips_a - 1)
        self.assertEqual(self.player_b.num_chips, chips_b + 1)


class TestGame(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        super(TestGame, cls).setUpClass()
        FORMAT = '%(levelname)-8s: %(message)s'
        logging.basicConfig(format=FORMAT, level=logging.INFO)

    def setUp(self):
        self.player_names = ["Alice", "Bob", "Carol"]
        self.lcr = Game(*(self.player_names))

    def test_game_with_not_enough_players(self):
        with self.assertRaisesRegex(Exception, '.* at least three .*'):
            g = Game()
        with self.assertRaisesRegex(Exception, '.* at least three .*'):
            g = Game("Alice")
        with self.assertRaisesRegex(Exception, '.* at least three .*'):
            g = Game("Alice", "Bob")

    def test_number_of_players(self):
        self.assertEqual(len(self.lcr.players), len(self.player_names))

    def test_game(self):
        self.assertTrue(isinstance(self.lcr, Game))
        self.assertEqual(4, 4)

if __name__ == '__main__':
    unittest.main()
