#!/bin/bash

res=$(tmutil status | grep "Running = 1")
if [ $? -eq 0 ]; then
  echo 1
else
  echo 0
fi



