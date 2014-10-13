bencoder
========

Bittorrent encoding in ruby

BEncoder will encode the 4 data types in the specification:

 - Strings
 - Integers
 - Arrays
 - Hashes

Additionally, it will pass symbols as strings, to allow for easier hash convertion.

install with

    gem install bencoder
    
Usage is easy:

```ruby
BEncoder.encode "herp"
=> "4:herp"

BEncoder.encode ['what', 'strange', { data: 'I', have: 'here' }, 666]
=> "l4:what7:stranged4:data1:I4:have4:hereei666ee"
```
Intentionally minimalistic.
