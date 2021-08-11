#!/bin/bash
source /usr/local/share/chruby/chruby.sh && \
chruby ruby-3.0.2 && \
exec ruby /home/pi/keypad/keypad-read.rb
