#!/bin/bash
flameshot gui --raw | xclip -selection clipboard -t image/png -i
killall flameshot
sleep 1 && killall flameshot
