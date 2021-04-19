---
layout: default
title: 'Boston University Computational Immunology Summer School'
---

# Phylogenetics module of the Boston University Computational Immunology Summer School

After this course, I hope you will be able to

* understand basic features of evolutionary trees
* be familiar with the various types of tree inference, when they are useful, and their assumptions
* understand the basis of codon-based tests for natural selection.


## Prerequisites

### Software prerequisite

Please download and make sure you can run [seaview](http://doua.prabi.fr/software/seaview) as soon as possible.


## Course outline

* Lecture: [Phylogenetics methods intro]({{ "/slides/phylogenetics-methods-intro.html" | relative_url }}) to parsimony
* Perform sequence alignment on [sample data]({{ "/data/sample.fasta" | relative_url }}) using seaview
* Try using various algorithms to build trees with seaview; then try clicking "Full, Swap, Re-root, and Subtree"
* Lecture: [Likelihood methods in phylogenetics]({{ "/slides/phylogenetics-likelihood.html" | relative_url }})
* Lecture: [Phylogenetic confidence measures]({{ "/slides/phylogenetics-confidence.html" | relative_url }})
* Investigate a [mysterious data set]({{ "/data/mystery.fasta" | relative_url }}) using aLRT and bootstrapping
* Lecture: [Codon models and tests for selection]({{ "/slides/kosakovsky-pond-selection.pdf" | relative_url }}) (part)
* Lecture: [Mutation and selection in B cells]({{ "/slides/molecular-evolution-bcells.html" | relative_url }})
* [Investigate tree balance](https://github.com/matsen/teaching/blob/main/notebooks/tree-shape.md) (see [Horns et al](http://dx.doi.org/10.1101/145052) for an application of tree shape to B cells)


## Extra material in case we have time
* Lecture: [Sequence alignment]({{ "/slides/sequence-alignment.html" | relative_url }})
* Perform sequence alignment of [some HIV gag sequences]({{ "/data/hiv-gag.fasta" | relative_url }})
* Sequence alignment using PRANK in [Wasabi](http://wasabiapp.org)
* Lecture: [Bayesian methods]({{ "/slides/phylogenetics-bayesian.html" | relative_url }})
* Play with [MCMC Robot](https://phylogeny.uconn.edu/mcmc-robot/)
* Lecture: [Trees and recombination]({{ "/slides/phylogenetics-recombination.html" | relative_url }})
* Testing for recombination using [GARD](http://datamonkey.org/gard)


## Books
* [*Inferring Phylogenies*](http://www.sinauer.com/detail.php?id=1775) by Felsenstein
* [*The Phylogenetic Handbook*](http://www.cambridge.org/gb/knowledge/isbn/item2327447/?site_locale=en_GB) edited by Lemey, Salemi, and Vandamme, chapters by the stars


## Videos
* [Introduction to likelihood-based phylogenetics video](https://www.youtube.com/watch?v=1r4z0YJq580) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/76lewis/phyloseminar-lewis-part1.pdf))
* [Introduction to phylogenetic models video](https://www.youtube.com/watch?v=UsLeY0wZr4Y) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/77lewis/phyloseminar-lewis-part2.pdf))


## Papers
* Hoehn et. al, [The Diversity and Molecular Evolution of B-Cell Receptors during Infection](https://doi.org/10.1093/molbev/msw015)
* Our paper on [Bayesian immune repertoire analysis](https://arxiv.org/pdf/1804.10964.pdf)


## Software

* [FastTree](http://www.microbesonline.org/fasttree/) -- approximate ML
* [RAxML](http://wwwkramer.in.tum.de/exelixis/software.html), [PhyML](http://www.atgc-montpellier.fr/phyml/), and [IQ-TREE](http://www.iqtree.org/) -- somewhat less approximate ML
* [BEAST](http://beast.bio.ed.ac.uk/) -- Bayesian, inferring event times and rooted trees
* [MrBayes](http://mrbayes.csit.fsu.edu/) and [RevBayes](http://revbayes.github.io/) -- Bayesian, inferring unrooted trees
* [DataMonkey](http://datamonkey.org), your one-stop online shop for selection and recombination analysis
