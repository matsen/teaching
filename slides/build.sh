#!/bin/sh
set -e

theme="simple"

./insert.py < "$1" \
   | pandoc --mathjax='MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML' \
    --template=default.revealjs \
    -t revealjs \
    --standalone \
    --include-in-header src/simple-small.css \
    --variable theme=$theme \
    --variable transition="none" \
    --variable controls="false" \
    --variable history="true" \
    --smart \
    -o "$2"

sed -e "s_reveal.js/css/reveal.min.css_reveal.js/css/reveal.css_" \
    -e "s_reveal.js/js/reveal.min.js_reveal.js/js/reveal.js_" \
    -i "$2"
