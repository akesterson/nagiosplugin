require 'nagiosplugin'

x = NagiosPlugin::Range.new()

puts "10:20 vs [5, 25, 15]"

x.parse('10:20')
puts x.match(5)
puts x.match(25)
puts x.match(15)

puts "@10:20 vs [5, 25, 15]"

x.parse('@10:20')
puts x.match(5)
puts x.match(25)
puts x.match(15)

puts "~:20 vs [-5, 25, 15]"

x.parse('~:20')
puts x.match(-5)
puts x.match(25)
puts x.match(15)

puts "10: vs [-5, 5, 15]"
x.parse("10:")
puts x.match(-5)
puts x.match(5)
puts x.match(15)
