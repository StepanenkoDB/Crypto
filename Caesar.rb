!#/usr/bin/env ruby

data = File.open("input.txt","r").readlines

array = { "a" => 0.0, "b" => 0.0, "c" => 0.0, "d" => 0.0, "e" => 0.0, "f" => 0.0, "g" => 0.0, "h" => 0.0, "i" => 0.0, "j" => 0.0, "k" => 0.0, "l" => 0.0, "m" => 0.0, "n" => 0.0, "o" => 0.0, "p" => 0.0, "q" => 0.0, "r" => 0.0, "s" => 0.0, "t" => 0.0, "u" => 0.0, "v" => 0.0, "w" => 0.0, "x" => 0.0, "y" => 0.0, "z" => 0.0 }
alphabet = { "a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "f" => 6, "g" => 7, "h" => 8, "i" => 9, "j" => 10, "k" => 11, "l" => 12, "m" => 13, "n" => 14, "o" => 15, "p" => 16, "q" => 17, "r" => 18, "s" => 19, "t" => 20, "u" => 21, "v" => 22, "w" => 23, "x" => 24, "y" => 25, "z" => 26 }
counter = 0.0

data.each do |x| # For every string in Array
  counter+=x.size
  x.downcase!
  for i in 0...x.size do
    for j in "a".."z" do
      array[j] += 1 if j == x[i]
    end
  end
end # We've counted amount of every symbol in text

#now we have to count percentage of any symbol in the text
for i in "a".."z" do
  array[i] /= counter
  array[i] *= 100
end # Now we know percentage of any symbol we've met in the text

main_symbol = array.max_by{ |elem| elem[1] }[0] # It's a symbol that has appeared most of all

main_symbol_index = 1
i = "a"
while i!=main_symbol do
  main_symbol_index+=1
  i.next!
end # we have found an index in encrypted text

#puts main_symbol
#puts main_symbol_index

=begin
LETS KNOW DECRYPT!
=end

shift = main_symbol_index - 5
left = true

if shift < 0
  shift = shift.abs
  left = false # We need to add
end

=begin
if left
  puts "+ on #{shift}"
else
  puts "- on #{shift}"
end
=end

def is_in(char)
  for j in "a".."z" do
    return true if j == char
  end
  return false
end

#puts "New letter should be y->#{alphabet.find{ |elem| elem[1]==25}[0]}"

data.each do |x| # For every string in Array
  for i in 0...x.size do #
    if is_in(x[i])
      if left
        new_index = (alphabet[x[i]] - shift) % 26
        #puts "old_index is-> #{alphabet[x[i]]}, shift is -> #{shift}, New_index, shifting right: #{new_index}"
      else
        new_index = (alphabet[x[i]] + shift) % 26
        #puts "old_index is-> #{alphabet[x[i]]}, shift is -> #{shift}, New_index, shifting left: #{new_index}"
      end
      #puts "x[i] was -> #{x[i]}, x[i] new -> #{alphabet.find{ |elem| elem[1]==new_index }[0]}, where new_index is -> #{new_index}"
      x[i] = alphabet.find{ |elem| elem[1]==new_index }[0]
    end
  end
end # We've counted amount of every symbol in text

File.open('output.txt','w'){ |file|
data.each do |x|
  file.write x
end
}
