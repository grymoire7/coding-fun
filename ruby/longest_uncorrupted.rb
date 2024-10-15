#!/usr/bin/env ruby
# frozen_string_literal: true

# longest uncorrupted segment
#
# Inputs
#   stream: array of integers representing the input stream
#   reference: array of integers representing the correct data
#
# Output
#   integer: longest run of uncorrupted data

def longest_uncorrupted(stream, reference)
  # error checking
  
  current_run = 0
  longest_run = 0

  stream.zip(reference).each do |s, r|
    if s == r
      current_run += 1
    else
      longest_run = current_run if current_run > longest_run
      current_run = 0
    end
  end

  [longest_run, current_run].max
end

require 'rspec/autorun'

RSpec.describe '#longest_uncorrupted' do
  let(:reference) { [ 2, 3, 5, 8, 37, 48, 100, 256, 257 ] }

  it 'works for example 1' do
    stream = [ 2, 0, 5, 8, 37, 0, 100, 256, 0 ]
    expect(longest_uncorrupted(stream, reference)).to eq 3
  end

  it 'works for example 2' do
    stream = [ 2, 3, 5, 8, 37, 48, 100, 256, 257 ]
    expect(longest_uncorrupted(stream, reference)).to eq 9
  end
end
