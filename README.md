bencoder
========

[![Build Status](https://travis-ci.org/kholbekj/bencoder.svg?branch=master)](https://travis-ci.org/kholbekj/bencoder)
[![Coverage Status](https://coveralls.io/repos/kholbekj/bencoder/badge.png?branch=master)](https://coveralls.io/r/kholbekj/bencoder?branch=master)

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

BEncoder.decode "4:herp"
=> "herp"

BEncoder.encode ['what', 'strange', { data: 'I', have: 'here' }, 666]
=> "l4:what7:stranged4:data1:I4:have4:hereei666ee"

BEncoder.decode 'l4:what7:stranged4:data1:I4:have4:hereei666ee'
=> ['what', 'strange', { 'data' => 'I', 'have' => 'here' }, 666]
```
Intentionally minimalistic.
