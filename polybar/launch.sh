#!/bin/bash


polybar-msg cmd quit

echo "---" | tee -a /tmp/bar.log
polybar bar 2>&1 | tee -a /tmp/bar.log & disown
