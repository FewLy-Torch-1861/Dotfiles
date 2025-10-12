#!/usr/bin/env bash

qs kill -c noctalia-shell || true && qs -c noctalia-shell & disown
