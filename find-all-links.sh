#!/bin/bash
set -eu -o pipefail
find schemers.org -type f -iname '*.htm*' | xargs cat | pup 'a json{}' |
    gosh find-all-links.scm
