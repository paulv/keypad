#!/bin/bash
source /usr/local/share/chruby/chruby.sh && \
    chruby ruby-3.0.2 && \
    cd /home/pi/keypad && \
    exec ruby /home/pi/keypad/keypad-read.rb
