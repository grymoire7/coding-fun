# !/usr/bin/env ruby

# frozen_string_literal: true

# Ruby code file to consume hackerrank countries REST api
#
# Example url: https://jsonmock.hackerrank.com/api/countries?name=Afghanistan
#
# Example response:
#
# {
#   "page": 1,
#   "per_page": 10,
#   "total": 1,
#   "total_pages": 1,
#   "data": [
#     {
#       "name": "Afghanistan",
#       "nativeName": "افغانستان",
#       "topLevelDomain": [
#         ".af"
#       ],
#       "alpha2Code": "AF",
#       "numericCode": "004",
#       "alpha3Code": "AFG",
#       "currencies": [
#         "AFN"
#       ],
#       "callingCodes": [
#         "93"
#       ],
#       "capital": "Kabul",
#       "altSpellings": [
#         "AF",
#         "Afġānistān"
#       ],
#       "relevance": "0",
#       "region": "Asia",
#       "subregion": "Southern Asia",
#       "language": [
#         "Pashto",
#         "Dari"
#       ],
#       "languages": [
#         "ps",
#         "uz",
#         "tk"
#       ],
#       "translations": {
#         "de": "Afghanistan",
#         "es": "Afganistán",
#         "fr": "Afghanistan",
#         "it": "Afghanistan",
#         "ja": "アフガニスタン",
#         "nl": "Afghanistan",
#         "hr": "Afganistan"
#       },
#       "population": 26023100,
#       "latlng": [33, 65],
#       "demonym": "Afghan",
#       "borders": [
#         "IRN",
#         "PAK",
#         "TKM",
#         "UZB",
#         "TJK",
#         "CHN"
#       ],
#       "area": 652230,
#       "gini": 27.8,
#       "timezones": [
#         "UTC+04:30"
#       ]
#     }
#   ]
# }

require 'net/http'
require 'json'

# Method to get phone number from country and phone number
# This method consumes the hackerrank countries REST api
# and returns the phone number with calling code
# in the format "+#{calling_code} #{phone_number}"
#
# If the data array is empty, it returns "-1".
# If there is any other error it returns "-1".
#
# @param country [String] country name
# @param phone_number [String] phone number
# @return [String] phone number with calling cocde
def get_phone_number(country, phone_number)
  uri = URI("https://jsonmock.hackerrank.com/api/countries?name=#{country}")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)['data']

  return '-1' if data&.empty?

  calling_code = data[0]['callingCodes'][0]
  "+#{calling_code} #{phone_number}"
rescue StandardError
  '-1'
end

phone_number = get_phone_number('Afghanistan', '1234567890')
puts "Phone number: #{phone_number}"

phone_number = get_phone_number('Bolivia', '1234567890')
puts "Phone number: #{phone_number}"

phone_number = get_phone_number('bob', '1234567890')
puts "Phone number: #{phone_number}"
