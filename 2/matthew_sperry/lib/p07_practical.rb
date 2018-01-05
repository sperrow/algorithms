require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  store = HashMap.new

  string.chars.each do |ch|
    val = 1
    val += store.get(ch) if store.include?(ch)
    store.set(ch, val)
  end

  count = 0

  store.each do |key, val|
    count += 1 if val.odd?
  end

  count < 2
end
