#!/bin/bash
set -eu -o pipefail
find schemers.org -type f -iname '*.htm*' | xargs cat |
    pup 'a attr{href}' | sed 's@[#?].*@@' | sort | uniq
