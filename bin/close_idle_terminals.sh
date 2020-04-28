#!/bin/bash
kill -9 `pstree -p | \
            grep -oE "$(basename $SHELL)\([0-9]+\)$"  | \
            sed 's/[^0-9+]//g'`

