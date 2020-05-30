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
* understand likelihood-based tree inference
* understand the choices one makes when performing likelihood-based tree inference
* understand potential pitfalls of tree inference methods


## Prerequisites

### Software prerequisites

* [seaview](http://doua.prabi.fr/software/seaview)
* Anaconda. If you have an existing installation, excellent. Otherwise I recommend [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
* I suggest that you use Python 3.7. With conda this looks like `conda create --name 541 python=3.7; conda activate 541`
* Install ETE and friends with `conda install -c etetoolkit ete3`


## Day 1: Phylogenetics motivation and intro

* Lecture: [Phylogenetics motivation]({{ "/slides/phylogenetics-motivation.html" | relative_url }})
* Perform sequence alignment on [sample data]({{ "/data/sample.fasta" | relative_url }}) using seaview
* Lecture: [Phylogenetics methods intro]({{ "/slides/phylogenetics-methods-intro.html" | relative_url }})
* Try using various algorithms to build trees with seaview; then try clicking "Full, Swap, Re-root, and Subtree"


## Day 2: Phylogenetics methods

* Lecture: [introduction to likelihood-based phylogenetics](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/76lewis/phyloseminar-lewis-part1.pdf) ([video](https://www.youtube.com/watch?v=1r4z0YJq580))
* Lecture: [Phylogenetic confidence measures]({{ "/slides/phylogenetics-confidence.html" | relative_url }})
* Investigate a [mysterious data set]({{ "/data/mystery.fasta" | relative_url }}) using aLRT and bootstrapping

### Homework 1

* Infer a phylogenetic tree from [measles data]({{ "/data/measles.fasta" | relative_url }}) using seaview. Write a little Python script to find the longest branch (a.k.a. edge) in the tree, and draw a version of that tree such that the longest branch is colored red. (ETE hints: [Node style](http://etetoolkit.org/docs/latest/tutorial/tutorial_drawing.html#node-style), [tree traversal](http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html#traversing-browsing-trees), and [inline tree rendering](http://etetoolkit.org/ipython_notebook/) if you are using a Jupyter notebook.)
* Make a scatter plot of this measles tree with one point for each branch of the tree: make the x axis the length of the branch and the y axis the number of descendants of that branch (`len(n)` gives the number of descendants of a node in ETE).
* Imagine that instead of 4 DNA bases, we have just two bases, named 0 and 1. Follow through the development of the transition probabilities starting on Lewis' slide 59 to obtain a likelihood function for the corresponding model in terms of branch length nu (written ν in the slides) given two sequences that have 20 identical sites and 4 differing ones. Plot the logarithm of the likelihood function for a range of branch length values containing the maximum likelihood branch length. (Note that this part of the assignment does not involve a proper tree, just two sequences evolving from one to the other.)
* Submit both the script and the output, or a Jupyter notebook that has been run from scratch ("Restart & Run All") and exported to PDF.


## Day 3: Sequence alignment, recombination and trees as data structures

* Lecture: [Tree exploration]({{ "/slides/phylogenetics-tree-exploration.html" | relative_url }})
* Lecture: [Overview of sequence substitution models](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/77lewis/phyloseminar-lewis-part2.pdf) ([video](https://www.youtube.com/watch?v=UsLeY0wZr4Y))
* Lecture: [Sequence alignment]({{ "/slides/sequence-alignment.html" | relative_url }})
* Perform sequence alignment of [some HIV gag sequences]({{ "/data/hiv-gag.fasta" | relative_url }})
<!-- * Sequence alignment using PRANK in [Wasabi](http://wasabiapp.org) -->
* Lecture: [Trees and recombination]({{ "/slides/phylogenetics-recombination.html" | relative_url }})
* Testing for recombination using [GARD](http://datamonkey.org/gard)


## Day 4: Further topics

* Lecture: [Bayesian methods]({{ "/slides/phylogenetics-bayesian.html" | relative_url }})
* Interleaved with: [Lewis slides on Bayesian inference](https://github.com/phyloseminar/phyloseminar.org/blob/master/material/78lewis/phyloseminar-lewis-part3a.pdf) ([video](https://www.youtube.com/watch?v=4PWlnNsfz90))
* Play with [MCMC Robot](https://phylogeny.uconn.edu/mcmc-robot/)


### Homework 2

Do the following in a script, either submitting both the script and the output, or a Jupyter notebook that has been run from scratch ("Restart & Run All") and exported to PDF. PDF is best, but if you encounter problems with the PDF export you may submit (in order of preference) HTML or the `.ipynb` file.

* Simulate sequence evolution down the measles tree using the 0/1 model from homework 1 starting with a uniform draw for the root state, returning one "column" of sequence data at a time (i.e. a single 0/1 value for each tip). (Python hints: I used numpy's [binomial](https://docs.scipy.org/doc/numpy/reference/generated/numpy.random.binomial.html) with n=1 and stored values on the tree using [add_feature](http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html#node-annotation)). Display the tree with an example set of simulated tip states from running your simulator.
* Implement the [Fitch algorithm](http://www.cs.ubc.ca/labs/beta/Courses/CPSC536A-01/Class10/class10-notes.html) to calculate parsimony scores on your simulated data. I found it useful while debugging my version to annotate the inferences on my tree with `n.add_face(TextFace(str(fitch_cost)), column=0, position = "branch-top")` with another annotation for `fitch_state`.
* Simulate 1000 times on the Measles tree and run the Fitch algorithm on each of these. Make a plot such that each simulated data set is a single point, with the x axis representing the number of simulated mutations, and the y axis representing the parsimony score. What do you notice?


<hr>


## Books
* [*Inferring Phylogenies*](http://www.sinauer.com/detail.php?id=1775) by Felsenstein
* [*The Phylogenetic Handbook*](http://www.cambridge.org/gb/knowledge/isbn/item2327447/?site_locale=en_GB) edited by Lemey, Salemi, and Vandamme, chapters by the stars


## Introductory lecture series
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
