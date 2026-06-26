# frozen_string_literal: true

require 'rspec/autorun'

# A celebrity is defined as someone who is known by everyone else, but who
# knows no one else. Given a list of people and a method which tells you
# whether or not one person knows another, find a celebrity in the group (if
# there is one). For example, if we have a group of four people A, B, C, and D,
# and A knows B, C, and D; B knows C and D; C knows D; and D knows no one, then
# D is the celebrity.

class CelebrityFinder
  # takes a hash of people, where the keys are people and the values are arrays of people they know
  def initialize(people)
    @people = people
  end

  # returns a celebrity if one exists, else nil
  def find_celebrity
    @people.each do |person, _|
      return person if @people.all? { |other, _| other == person || (knows?(other, person) && !knows?(person, other)) }
    end

    nil
  end

  private

  def knows?(person, other)
    @people[person].include? other
  end
end

RSpec.describe '#find_celebrity' do
  let(:people) do
    {
      'A' => ['B', 'C', 'D'],
      'B' => ['C', 'D'],
      'C' => ['D'],
      'D' => []
    }
  end

  it 'finds the celebrity' do
    finder = CelebrityFinder.new(people)
    expect(finder.find_celebrity).to eq('D')
  end

  it 'returns nil if there is no celebrity' do
    people['D'] = ['A'] # D knows A, so D is not a celebrity
    finder = CelebrityFinder.new(people)
    expect(finder.find_celebrity).to eq(nil)
  end

end
