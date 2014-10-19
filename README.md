bencoder
========

[![Build Status](https://travis-ci.org/kholbekj/bencoder.svg?branch=master)](https://travis-ci.org/kholbekj/bencoder)
[![Coverage Status](https://coveralls.io/repos/kholbekj/bencoder/badge.png?branch=master)](https://coveralls.io/r/kholbekj/bencoder?branch=master)
[![Code Climate](https://codeclimate.com/github/kholbekj/bencoder/badges/gpa.svg)](https://codeclimate.com/github/kholbekj/bencoder)
[![Gem Version](https://badge.fury.io/rb/bencoder.svg)](http://badge.fury.io/rb/bencoder)

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

Since .torrent files are bencode dicts, you can parse them out of the box

```ruby
BEncoder.decode File.read('sample.torrent')
=> {"announce"=>"udp://tracker.openbittorrent.com:80", "creation date"=>1327049827, "info"=>{"length"=>20, "name"=>"sample.txt", "piece length"=>65536, "pieces"=>"\\\xC5\xE6R\xBE\r\xE6\xF2x\x05\xB3\x04d\xFF\x9B\x00\xF4\x89\xF0\xC9", "private"=>1}}
```
