#!/bin/bash

pkill rofi || true

rofi -show calc -modi calc -no-show-match -no-sort
