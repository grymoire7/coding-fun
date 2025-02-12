#!/usr/bin/env ruby
# frozen_string_literal: true

# Business Hours Formatter
# Given an array of business hours, return a formatted string
# that groups consecutive days with the same hours.
# Closed days should be represented as "Closed".
# Example:
#  hours = [
#  ["09:00", "17:00"], # Monday
#  ["09:00", "17:00"], # Tuesday
#  ["08:00", "17:00"], # Wednesday
#  ["09:00", "17:00"], # Thursday
#  ["09:00", "17:00"], # Friday
#  ["10:00", "18:00"], # Saturday
#  ["11:00", "17:00"]  # Sunday
#  ]
#  BusinessHoursFormatter.new(hours).format
#  => "Monday - Friday: 09:00 - 17:00\nSaturday: 10:00 - 18:00\nSunday: 11:00 - 17:00"
#  If all days are closed, return "Closed".
#  BusinessHoursFormatter.new(Array.new(7) { ["Closed", "Closed"] }).format
#  => "Closed"

require 'date'
require 'rspec/autorun'

class BusinessHoursFormatter
  DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].freeze

  def initialize(hours)
    @hours = hours || Array.new(7) { %w[Closed Closed] }
  end

  def format
    return 'Closed' if closed_all_week?

    result = []
    i = 0

    while i < @hours.size
      current_period = @hours[i]

      # Find consecutive days with same hours
      j = i + 1
      j += 1 while j < @hours.size && @hours[j] == current_period

      # Format the period and add to result
      days_str = format_days(i, j - 1)
      time_str = format_time(current_period.first, current_period.last)
      result << "#{days_str}: #{time_str}"

      i = j
    end

    result.join("\n")
  end

  private

  def closed_all_week?
    @hours.all? { |period| period == %w[Closed Closed] }
  end

  def format_days(start_day, end_day)
    return DAYS[start_day] if start_day == end_day

    if start_day + 1 == end_day
      "#{DAYS[start_day]} & #{DAYS[end_day]}"
    else
      "#{DAYS[start_day]} - #{DAYS[end_day]}"
    end
  end

  def format_time(open_time, close_time)
    "#{open_time} - #{close_time}"
  end
end

RSpec.describe 'BuesnessHoursFormatter' do
  let(:hours1) do
    [
      ['09:00', '17:00'], # Monday
      ['09:00', '17:00'], # Tuesday
      ['08:00', '17:00'], # Wednesday
      ['09:00', '17:00'], # Thursday
      ['09:00', '17:00'], # Friday
      ['10:00', '18:00'], # Saturday
      ['11:00', '17:00']  # Sunday
    ]
  end

  let(:hours2) do
    [
      ['10:00', '19:00'], # Monday
      ['10:00', '19:00'], # Tuesday
      ['10:00', '19:00'], # Wednesday
      ['10:00', '22:00'], # Thursday
      ['10:00', '22:00'], # Friday
      ['11:00', '20:00'], # Saturday
      ['12:00', '18:00']  # Sunday
    ]
  end

  it 'works for example 1' do
    formatter = BusinessHoursFormatter.new(hours1)
    expected = "Monday & Tuesday: 09:00 - 17:00\nWednesday: 08:00 - 17:00\nThursday & Friday: 09:00 - 17:00\nSaturday: 10:00 - 18:00\nSunday: 11:00 - 17:00"
    expect(formatter.format).to eq expected
  end

  it 'works for example 2' do
    formatter = BusinessHoursFormatter.new(hours2)
    expected = "Monday - Wednesday: 10:00 - 19:00\nThursday & Friday: 10:00 - 22:00\nSaturday: 11:00 - 20:00\nSunday: 12:00 - 18:00"
    expect(formatter.format).to eq expected
  end
end
