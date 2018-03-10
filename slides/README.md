# My talks

This is the source for my talks.


## Building

The talks are written in a little extension of Markdown.
This extension allows for easy instetion of phylogenetic trees and for images with a given width and height, and is processed by the silly `insert.py` script.
After processing, the Markdown gets converted to a [reveal.js](http://github.com/hakimel/reveal.js) presentation.
HTML by the brilliant [pandoc](http://johnmacfarlane.net/pandoc/).
Trees are rendered using the [archaeopteryx](http://www.phylosoft.org/archaeopteryx/) tree viewer.

### Converting text to paths

    ls figures/bcell/IGHV3-23_01_ns_alternative_norm.svg | parallel \
     'inkscape --export-text-to-path --export-pdf \
      {.}_ttp.pdf {} && \
      inkscape -l {.}_ttp.svg {.}_ttp.pdf && rm -f {.}_ttp.pdf'


### Running with `grunt`

    sudo apt-get install npm
    sudo ln -s "$(which nodejs)" /usr/bin/node

Then read the full setup docs:
This is in order to get the [full setup](https://github.com/hakimel/reveal.js/#full-setup), enabling speaker notes

    ln -s reveal.js/node_modules .
    ln -s reveal.js/Gruntfile.js .
    ln -s reveal.js/package.json .

Then `grunt serve`, or `grunt serve --port 8001`.


## License

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Talks</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://matsen.fhcrc.org" property="cc:attributionName" rel="cc:attributionURL">Frederick A. Matsen IV</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.
