---
layout: default
title: 'GS541 home'
---

<!--
https://docs.google.com/document/d/1bDTYk5WPVvvuVzD3DEVma-03TxJL5bjbYpwMvIwHRNE/edit
-->

_Welcome to the phylogenetics module of Genome Sciences 541._

After this course, I hope you will be able to

* recognize situations when evolutionary thinking is important
* understand basic features of evolutionary trees
* be familiar with the various types of tree inference, and when they are useful
* be able to apply codon-based tests for natural selection.


## Prerequisites

### Software prerequisite

Please download and make sure you can run [seaview](http://doua.prabi.fr/software/seaview) as soon as possible.

## Day 1: Phylogenetics motivation and intro

* Lecture: [Phylogenetics motivation]({{ "/slides/phylogenetics-motivation.html" | relative_url }})
* Perform sequence alignment on [sample data]({{ "/data/sample.fasta" | relative_url }}) using seaview
* Lecture: [Phylogenetics methods intro]({{ "/slides/phylogenetics-methods-intro.html" | relative_url }}) to parsimony
* Try using various algorithms to build trees with seaview; then try clicking "Full, Swap, Re-root, and Subtree"

### Homework 1a

* Watch [introduction to likelihood-based phylogenetics video](https://www.youtube.com/watch?v=1r4z0YJq580) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/76lewis/phyloseminar-lewis-part1.pdf))
* Play around with building trees.


## Day 2: Phylogenetics methods

* Quiz on and discussion of video material
* Lecture: [Phylogenetics methods intro]({{ "/slides/phylogenetics-methods-intro.html" | relative_url }}) through the end
* Lecture: [Phylogenetic confidence measures]({{ "/slides/phylogenetics-confidence.html" | relative_url }})
* Investigate a [mysterious data set]({{ "/data/mystery.fasta" | relative_url }}) using aLRT and bootstrapping
* Lecture: [Sequence alignment]({{ "/slides/sequence-alignment.html" | relative_url }})
* Perform sequence alignment of [some HIV gag sequences]({{ "/data/hiv-gag.fasta" | relative_url }})
* Sequence alignment using PRANK in [Wasabi](http://wasabiapp.org)

### Homework 1b

* Watch [introduction to phylogenetic models video](https://www.youtube.com/watch?v=UsLeY0wZr4Y) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/77lewis/phyloseminar-lewis-part2.pdf))

## Day 3: Theory and codon models

* Quiz on and discussion of video material, with [notes about matrix exponential]({{ "/slides/matrix-exp.html" | relative_url }})
* Lecture: [Trees and recombination]({{ "/slides/phylogenetics-recombination.html" | relative_url }})
* Testing for recombination using [GARD](http://datamonkey.org/gard)
* Lecture: [codon models and tests for selection]({{ "/slides/kosakovsky-pond-selection.pdf" | relative_url }})

### Homework 2

Analyze sequence data from [Elde et al., 2009](https://www.nature.com/articles/nature07529).
I have put some of their data [here]({{ "/data/elde/elde.fasta" | relative_url }}) (it's not all the sequences from the paper, but it's enough for this exercise).

The homework is simply to apply what you have learned in the class to this data:

* perform appropriate sequence alignment
* investigate the phylogenetic relationships between the sequences
* test for per-branch natural selection

and write a short report (however suits you, but exported to PDF) on your findings.


## Day 4: Further topics

* Lecture: [codon models and tests for selection]({{ "/slides/kosakovsky-pond-selection.pdf" | relative_url }}), continued
* Lecture: [Bayesian methods]({{ "/slides/phylogenetics-bayesian.html" | relative_url }})
* Play with [MCMC Robot](https://phylogeny.uconn.edu/mcmc-robot/)


<hr>


## Books
* [*Inferring Phylogenies*](http://www.sinauer.com/detail.php?id=1775) by Felsenstein
* [*The Phylogenetic Handbook*](http://www.cambridge.org/gb/knowledge/isbn/item2327447/?site_locale=en_GB) edited by Lemey, Salemi, and Vandamme, chapters by the stars


## Software

* [FastTree](http://www.microbesonline.org/fasttree/) -- approximate ML
* [RAxML](http://wwwkramer.in.tum.de/exelixis/software.html), [PhyML](http://www.atgc-montpellier.fr/phyml/), and [IQ-TREE](http://www.iqtree.org/) -- somewhat less approximate ML
* [BEAST](http://beast.bio.ed.ac.uk/) -- Bayesian, inferring event times and rooted trees
* [MrBayes](http://mrbayes.csit.fsu.edu/) and [RevBayes](http://revbayes.github.io/) -- Bayesian, inferring unrooted trees
* [DataMonkey](http://datamonkey.org), your one-stop online shop for selection and recombination analysis
