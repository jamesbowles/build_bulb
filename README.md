build_bulb
==========

Rspec formatter for an Arduino powered build bulb

Requirements
------------

1. Serial-USB build bulb
1. serialport gem
1. rvm

Setup
-----
1. rvm gemset use global
1. gem install serialport
1. add the contents of the .rspec file to your global or project .rspec file (edit paths if needed)

Build bulb
----------

I used a teensy in Arduino mode http://www.pjrc.com/store/teensy.html 
with a circuit very similar to the one in the tutorial http://www.pjrc.com/teensy/tutorial2.html
