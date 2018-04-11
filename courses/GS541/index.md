---
layout: default
title: 'GS541 home'
---

Welcome to the phylogenetics module of Genome Sciences 541.

After this course, I hope you will be able to

* recognize situations when evolutionary thinking is important
* understand basic features of evolutionary trees
* be familiar with the various types of tree inference, and when they are useful
* be able to apply codon-based tests for natural selection


## Prerequisites

### Conceptual prerequisites

* Basic probability, including conditional probability. [A refresher](https://www.khanacademy.org/math/statistics-probability/probability-library#conditional-probability-independence).

### Software prerequisites

Please download and make sure you can run [seaview](http://doua.prabi.fr/software/seaview) as soon as possible.

<!--
https://molevol.mbl.edu/index.php/Paul_Lewis
http://hydrodictyon.eeb.uconn.edu/people/plewis/downloads/wh2017/Likelihood_Lewis_22July2017.pdf
https://lukejharmon.github.io/ilhabela/instruction/2015/07/02/phylogenetic-independent-contrasts/

This has some great homeworks:
https://phylogeny.uconn.edu/courses/


l = [''.join([random.choice('AGCT') for i in xrange(200)]) for j in xrange(6)]

with open('data.fasta', 'w') as f:
    for s in l:
        f.write('>x\n')
        f.write(s+'\n')
-->

## Day 1: Phylogenetics motivation and intro

* Lecture: [Phylogenetics motivation]({{ "/slides/phylogenetics-motivation.html" | relative_url }})
* Perform sequence alignment on [sample data]({{ "/data/sample.fasta" | relative_url }}) using seaview
* [Phylogenetics methods intro]({{ "/slides/phylogenetics-methods-intro.html" | relative_url }})


<!--
Have some in-class exercise about the independent contrasts method? How about a parameter count of how much signal there is in the data?
Have some sort of strange distance-based phylogenetics thing?
-->

### Homework

* Watch introduction to phylogenetics video
* Review conditional probability


## Day 2: Phylogenetics methods

* Quiz on video material
* Lecture: [Sequence alignment]({{ "/slides/sequence-alignment.html" | relative_url }})
* Practical: inferring trees
* Lecture: branch support

### Homework

* Watch introduction to phylogenetic likelihood video
* Get programs working if they aren't already


## Day 3: Theory and codon models

* Quiz on video material
* Conditional probability exercises
* Practical: a mysterious data set
* Lecture: codon models
* Exercise: the Q matrix and stationarity; pulley principle

### Homework

* Video: [phylogenetic models of gene expression evolution](https://www.youtube.com/watch?v=3lxqv_iJeLY)
* Datamonkey
* Start quantifying evolution project


## Day 4: Further topics

* Quiz on video material
* Independent contrasts?
* Lecture: Phylogenetic sequence alignment
* Lecture: Bayesian methods
* Lecture: [coalescent and population size](http://bedford.io/projects/mitii/coalescent-and-selection/coalescent.html#/)

### Homework

* Complete quantifying evolution project
