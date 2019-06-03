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

### Software prerequisites

* [seaview](http://doua.prabi.fr/software/seaview)
* Anaconda. If you have an existing installation, excellent. Otherwise I recommend [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
* Install ETE and friends with `conda install -c etetoolkit ete3 ete_toolchain`


## Day 1: Phylogenetics motivation and intro

* Lecture: [Phylogenetics motivation]({{ "/slides/phylogenetics-motivation.html" | relative_url }})
* Perform sequence alignment on [sample data]({{ "/data/sample.fasta" | relative_url }}) using seaview
* Lecture: [Phylogenetics methods intro]({{ "/slides/phylogenetics-methods-intro.html" | relative_url }}) to parsimony
* Try using various algorithms to build trees with seaview; then try clicking "Full, Swap, Re-root, and Subtree"

### Homework 1a

* Watch [introduction to likelihood-based phylogenetics video](https://www.youtube.com/watch?v=1r4z0YJq580) (with [slides](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/76lewis/phyloseminar-lewis-part1.pdf))
* Do quiz questions (sent by email).


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
* Do quiz questions (sent by email).
* Install a tree manipulation package, preferably the Python package [ETE](http://etetoolkit.org). If you only use R, use [ape](https://cran.r-project.org/web/packages/ape/index.html), and perhaps [ggtree](https://github.com/GuangchuangYu/ggtree). (Note that tree traversal in R is significantly more difficult, though you can [see an example here](http://rpubs.com/ematsen/ape-traversal-sample)).
* Infer a phylogenetic tree from [measles data]({{ "/data/measles.fasta" | relative_url }}). Write a little Python script to find the longest branch (a.k.a. edge) in the tree, and draw a version of that tree such that the longest branch is colored red. (ETE hints: [Node style](http://etetoolkit.org/docs/latest/tutorial/tutorial_drawing.html#node-style), [tree traversal](http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html#traversing-browsing-trees), and [inline tree rendering](http://etetoolkit.org/ipython_notebook/) if you are using a Jupyter notebook.) Submit both the script and the output, or a Jupyter notebook that has been run from scratch ("Restart & Run All") and exported to PDF.


## Day 3: Recombination and trees as data structures

* Quiz on and discussion of video material, with [notes about matrix exponential]({{ "/slides/matrix-exp.html" | relative_url }}) and [discussion of phylogenetic model assumptions]({{ "/slides/phylogenetic-model-assumptions.html" | relative_url }})
* Lecture: [Trees and recombination]({{ "/slides/phylogenetics-recombination.html" | relative_url }})
* Testing for recombination using [GARD](http://datamonkey.org/gard)
* Working with trees as data structures: preorder and postorder traversal
* In-class period for working on tree traversal

### Homework 2

Do the following in a script, either submitting both the script and the output, or a Jupyter notebook that has been run from scratch ("Restart & Run All") and exported to PDF.

* Use the same measles tree built in the previous homework, and make a scatter plot for each branch of the tree, with the x axis being the length of the branch and the y axis being the number of descendants of that branch (`len(n)` gives the number of descendants of a node in ETE).
* Use matrix exponentiation ([expm](https://docs.scipy.org/doc/scipy/reference/generated/scipy.linalg.expm.html) in SciPy) on the matrix `[[-1, 1],[1, -1]]` to get a transition matrix for the binary symmetric model in terms of branch length. Check that it's the same as Paul Lewis' formula in his second lecture, slide 40 (note that his mu and beta are the same).
* Write a likelihood function for the binary symmetric model given two sequences that have 20 identical sites and 4 differing ones. Plot the logarithm of the likelihood function for a range of branch length values containing the maximum likelihood branch length. (Note that this part of the assignment does not involve a proper tree, just two sequences evolving from one to the other.)
* Simulate sequence evolution down the measles tree using the binary symmetric model, returning one "column" of sequence data at a time (i.e. a single 0/1 value for each tip). (Python hints: I used numpy's [binomial](https://docs.scipy.org/doc/numpy/reference/generated/numpy.random.binomial.html) with n=1 and stored values on the tree using [add_feature](http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html#node-annotation)).
* Implement the [Fitch algorithm](http://www.cs.ubc.ca/labs/beta/Courses/CPSC536A-01/Class10/class10-notes.html) to calculate parsimony scores on your simulated data. I found it useful while debugging my version to annotate the inferences on my tree with `n.add_face(TextFace(str(fitch_cost)), column=0, position = "branch-top")` with another annotation for `fitch_state`.
* Make a plot such that each simulated data set is a single point, with the x axis representing the number of simulated mutations, and the y axis representing the parsimony score. What do you notice?


## Day 4: Further topics

* Lecture: [Bayesian methods]({{ "/slides/phylogenetics-bayesian.html" | relative_url }})
* Play with [MCMC Robot](https://phylogeny.uconn.edu/mcmc-robot/)
* Work on homework


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
