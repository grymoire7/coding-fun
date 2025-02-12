# frozen_string_literal: true

j You are given an array of desired filenames in the order of their
# creation. Since two files cannot have equal names, the one which
# comes later will have an addition to its name in a form of (k),
# where k is the smallest positive integer such that the obtained
# name is not used yet.
#
# Return an array of names that will be given to the files.
#
# Example
# For names = ["doc", "doc", "image", "doc(1)", "doc"], the output should be
# fileNaming(names) = ["doc", "doc(1)", "image", "doc(1)(1)", "doc(2)"].

def file_naming(names)
  names.each_with_object([]) do |name, arr|
    if arr.include?(name)
      i = 1
      i += 1 while arr.include?("#{name}(#{i})")
      arr << "#{name}(#{i})"
    else
      arr << name
    end
  end
end

# Test cases
p file_naming(["doc", "doc", "image", "doc(1)", "doc"]) == ["doc", "doc(1)", "image", "doc(1)(1)", "doc(2)"]
p file_naming(["a(1)", "a(6)", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]) == ["a(1)", "a(6)", "a", "a(2)", "a(3)", "a(4)", "a(5)", "a(7)", "a(8)", "a(9)", "a(10)", "a(11)"]
p file_naming(["dd", "dd(1)", "dd(2)", "dd"]) == ["dd", "dd(1)", "dd(2)", "dd(3)"]
