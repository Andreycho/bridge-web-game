# Purpose: To seed the database with the cards
# suits = %w(hearts diamonds clubs spades)
# values = %w(A 2 3 4 5 6 7 8 9 10 J Q K)

# suits.each do |suit|
#   values.each do |value|
#     Card.create(suit: suit, value: value)
#   end
# end

# Purpose: To seed the database with the contracts
# levels = %w(1 2 3 4 5 6 7)
# suits = %w(no_trump spades hearts diamonds clubs)

# levels.each do |level|
#     suits.each do |suit|
#         Contract.create(level: level, suit: suit)
#     end
# end


Contract.create(id: 36, suit: "pass")
