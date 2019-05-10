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
    -o "$2"

# The third line unwraps images from their paragraphs, which has the lovely effect of allowing reveal's stretch feature to work.
sed -e "s_reveal.js/css/reveal.min.css_reveal.js/css/reveal.css_" \
    -e "s_reveal.js/js/reveal.min.js_reveal.js/js/reveal.js_" \
    -e "s#<p>\(<img ..*\)</p>#\1#" \
    -i "$2"
