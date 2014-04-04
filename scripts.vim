if did_filetype()
  finish
endif

let line1 = getline(1)

if line1 =~ '^#!/usr/bin/env python$'
    set ft=python
endif
