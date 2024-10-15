#!/usr/bin/env ruby
# frozen_string_literal: true

# Task Types
#
# Inputs
#   deadlines: an array of integers representing a day of the year
#   day: an integer representing the current 15/10/2024
#
# Output
#   Return an array of [today, upcoming, later] where
#     today is the count of tasks due today or earlier
#     upcoming is the count of tasks due in the next seven days
#     later is the count of tasks due later than seven days from now

def task_types(deadlines, day)
  deadlines.sort!

  # ---------------------------------------------------------------------------
  # groups = deadlines.group_by do |d|
  #   case
  #     when d <= day then :today
  #     when (d - day) <= 7 then :upcoming
  #     else :later
  #   end
  # end
  #
  # defaults = {today: [], upcoming: [], later: []}
  # g = groups.merge(defaults) { |key, old_value, default| old_value || default }
  # [ g[:today].count, g[:upcoming].count, g[:later].count ]

  # ---------------------------------------------------------------------------
  # today = deadlines.filter {|d| d <= day }.count
  # upcoming = deadlines.filter {|d| d > day && (d - day) <= 7 }.count
  # later = deadlines.filter {|d| d > day && (d - day) > 7 }.count
  # [today, upcoming, later]
  
  # ---------------------------------------------------------------------------
  today, upcoming, later = 0, 0, 0
  deadlines.each do |d|
    case
    when d <= day then today += 1
    when (d - day) <= 7 then upcoming += 1
    else later += 1
    end
  end

  [today, upcoming, later]
end

require 'rspec/autorun'

RSpec.describe '#task_types' do
  let(:tasks) { [ 2, 3, 5, 8, 37, 48, 100, 256, 257 ] }

  it 'works for example 1' do
    expect(task_types(tasks, 1)).to eq [ 0, 4, 5 ]
  end

  it 'works for example 2' do
    expect(task_types(tasks, 252)).to eq [ 7, 2, 0 ]
  end
end
