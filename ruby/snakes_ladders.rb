# frozen_string_literal: true

=begin
# Snakes and Ladders
Source: https://www.hackerrank.com/challenges/the-quickest-way-up/problem

## Description

=end

require 'rspec/autorun'
require 'set'

QueueEntry = Struct.new(:vertex, :dist)

# Complete the quickest_way_up function below.
def quickest_way_up(ladders, snakes)
  grid_size = 100 # 10 x 10 grid
  wormholes = ladders.to_h.merge(snakes.to_h)

  visited = Array.new(grid_size, false)
  queue = [] # BFS queue

  # mark first cell as visited and enqueue it
  visited[0] = true
  queue.push QueueEntry.new(0, 0)

  q_entry = QueueEntry.new

  until queue.empty?
    q_entry = queue.shift
    v = q_entry.vertex
    # puts "dequeue v = #{v}"

    break if v == grid_size - 1

    j = v + 1

    while (j <= (v + 6)) && (j < grid_size)
      # process only unvisited
      unless visited[j]
        # puts "> process j = #{j}"
        # calc distance & mark as visited
        a = QueueEntry.new(j, q_entry.dist + 1)
        visited[j] = true

        # Check if there's a wormhole (snake or ladder)
        # at 'j' then other end of wormhole becomes the adjacent of 'j'
        a.vertex = wormholes[j] if wormholes.key? j

        queue.push a
      end
      j += 1
    end
  end

  q_entry.dist
end

RSpec.describe '#quickest_way_up' do
  let(:ladders1) { [[32, 62], [42, 68], [12, 98]] }
  let(:snakes1) { [[95, 13], [97, 25], [93, 37], [79, 27], [75, 19], [49, 47], [67, 17]] }

  let(:ladders2) { [[8, 52], [6, 80], [26, 42], [2, 72]] }
  let(:snakes2) { [[51, 19], [39, 11], [37, 29], [81, 3], [59, 5], [79, 23], [53, 7], [43, 33], [77, 21]] }

  let(:ladders3) { [] }
  let(:snakes3) { [] }

  let(:ladders4) { [[1, 55], [56, 99]] }
  let(:snakes4) { [] }

  let(:ladders5) { [[1, 55], [23, 99]] }
  let(:snakes5) { [[56, 22]] }

  describe '#quickest_way_up' do
    it 'solves example 1' do
      expect(quickest_way_up(ladders1, snakes1)).to eq(3)
    end

    it 'solves example 2' do
      expect(quickest_way_up(ladders2, snakes2)).to eq(5)
    end

    it 'solves example 3' do
      expect(quickest_way_up(ladders3, snakes3)).to eq(17)
    end

    it 'solves example 4' do
      expect(quickest_way_up(ladders4, snakes4)).to eq(2)
    end

    it 'solves example 5' do
      expect(quickest_way_up(ladders5, snakes5)).to eq(3)
    end
  end
end
