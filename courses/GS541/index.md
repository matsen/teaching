---
layout: default
title: 'GS541 home'
---

<!--
https://docs.google.com/document/d/1bDTYk5WPVvvuVzD3DEVma-03TxJL5bjbYpwMvIwHRNE/edit
-->

_Welcome to the phylogenetics module of Genome Sciences 541._

After this course, I hope you will be able to

* understand basic features of evolutionary trees
* recognize situations when evolutionary thinking is important
* be able to interpret what trees do and do not tell us
* be familiar with the various types of tree inference, and when they are useful
* understand likelihood-based phylogenetic inference as a statistical estimation problem, including what a substitution model is
* understand the choices one makes when performing likelihood-based tree inference
* understand potential pitfalls of tree inference methods
* understand the tools one has to assess confidence in a phylogenetic tree
* understand the impact of recombination on phylogenetic inference
* understand the basics of tree search


## Prerequisites

### Software prerequisites

* The [seaview](http://doua.prabi.fr/software/seaview) sequence alignment and phylogenetic analysis tool.
* Anaconda with some core packages. If you don't already have this set up here are some steps for you:
    * Install [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
    * Historically my recommendation has been (running linux):

```
conda create --name 541 python=3.11; conda activate 541
conda install jupyter matplotlib pandas scipy
conda install -c bioconda iqtree
```

* I recently got a M2 mac and so my install process has been:
    * [Install iqtree](http://www.iqtree.org/). Note that you'll have to do [this](https://support.apple.com/guide/mac-help/apple-cant-check-app-for-malicious-software-mchleab3a043/14.0/mac/14.4.1) to avoid the "malicious software" block
    * Install [Mamba](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html) and:

```
mamba create --name 541 python=3.11; conda activate 541
mamba install jupyter matplotlib pandas scipy
```


## Day 1: Phylogenetics motivation and intro

* Discussion: getting an intuitive grasp of how phylogenetic methods work via interactive doodling
* Discussion: [Understanding trees]({{ "/slides/understanding-trees.html" | relative_url }})


## Day 2: Phylogenetics methods

* Discussion: [Phylogenetics motivation]({{ "/slides/phylogenetics-motivation.html" | relative_url }})
* Perform sequence alignment on [sample data]({{ "/data/sample.fasta" | relative_url }}) using seaview
* Lecture: [Phylogenetics methods intro]({{ "/slides/phylogenetics-methods-intro.html" | relative_url }})
* Try using various algorithms to build trees with seaview; then try clicking "Full, Swap, Re-root, and Subtree"


### Homework 1

* Fill in the blanks in the [Homework 1 Jupyter notebook](https://github.com/matsen/teaching/blob/main/notebooks/homework_1.ipynb).
* Submit the Jupyter notebook run from scratch ("Restart & Run All") and exported to PDF. If you have problems exporting to PDF, that's fine, HTML and `.ipynb` are also fine formats (with my preference in that order).


## Day 3: Sequence alignment, recombination and trees as data structures

* Lecture: [introduction to likelihood-based phylogenetics](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/76lewis/phyloseminar-lewis-part1.pdf) ([video](https://www.youtube.com/watch?v=1r4z0YJq580))
* Lecture: [Phylogenetic confidence measures]({{ "/slides/phylogenetics-confidence.html" | relative_url }})
* Investigate a [mysterious data set]({{ "/data/mystery.fasta" | relative_url }}) using aLRT and bootstrapping
* Lecture: [Tree exploration]({{ "/slides/phylogenetics-tree-exploration.html" | relative_url }})


## Day 4: Further topics

* Lecture: [Overview of sequence substitution models](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/77lewis/phyloseminar-lewis-part2.pdf) ([video](https://www.youtube.com/watch?v=UsLeY0wZr4Y))
* Lecture: [Sequence alignment]({{ "/slides/sequence-alignment.html" | relative_url }})
* Perform sequence alignment of [some HIV gag sequences]({{ "/data/hiv-gag.fasta" | relative_url }})
<!-- * Sequence alignment using PRANK in [Wasabi](http://wasabiapp.org) -->
* Lecture: [Trees and recombination]({{ "/slides/phylogenetics-recombination.html" | relative_url }})
* Testing for recombination using [GARD](http://datamonkey.org/gard)



### Homework 2

* Fill in the blanks in the [Homework 2 Jupyter notebook](https://github.com/matsen/teaching/blob/main/notebooks/homework_2.ipynb).
* Submit the Jupyter notebook run from scratch ("Restart & Run All") and exported to PDF. If you have problems exporting to PDF, that's fine, HTML and `.ipynb` are also fine formats (with my preference in that order).



## Books
* [*Inferring Phylogenies*](http://www.sinauer.com/detail.php?id=1775) by Felsenstein
* [*The Phylogenetic Handbook*](http://www.cambridge.org/gb/knowledge/isbn/item2327447/?site_locale=en_GB) edited by Lemey, Salemi, and Vandamme, chapters by the stars


## Introductory lecture series (this is really good!)
* [Introduction to likelihood-based phylogenetics video](https://www.youtube.com/watch?v=1r4z0YJq580) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/76lewis/phyloseminar-lewis-part1.pdf))
* [Introduction to phylogenetic models video](https://www.youtube.com/watch?v=UsLeY0wZr4Y) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/77lewis/phyloseminar-lewis-part2.pdf))
* [Introduction to Bayesian statistics and how it is used in phylogenetics](https://www.youtube.com/watch?v=4PWlnNsfz90) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/78lewis/phyloseminar-lewis-part3a.pdf))
* [More Bayesian phylogenetics: proposals, prior distributions, hierarchical models, and Bayes factors](https://www.youtube.com/watch?v=TLtOS--YwkU) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/78lewis/phyloseminar-lewis-part3b.pdf))


## Software

* [FastTree](http://www.microbesonline.org/fasttree/) -- approximate ML
* [RAxML](http://wwwkramer.in.tum.de/exelixis/software.html), [PhyML](http://www.atgc-montpellier.fr/phyml/), and [IQ-TREE](http://www.iqtree.org/) -- somewhat less approximate ML
* [BEAST](http://beast.bio.ed.ac.uk/) -- Bayesian, inferring event times and rooted trees
* [MrBayes](http://mrbayes.csit.fsu.edu/) and [RevBayes](http://revbayes.github.io/) -- Bayesian, inferring unrooted trees
* [DataMonkey](http://datamonkey.org), your one-stop online shop for selection and recombination analysis
