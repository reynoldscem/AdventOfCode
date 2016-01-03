#!/bin/sh

find . -type f \( -name "*.rb" -or -name "*.cpp" \) -print0 \
  | xargs -0 cat \
  | wc -l \
  | sed -e 's/^[ \t]*//'
