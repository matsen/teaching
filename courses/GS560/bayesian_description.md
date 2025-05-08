
Need laptops closed and phones down or in backpack: I'm only going to explain this once.

Today I have the absolute privilege of explaining Bayesian analysis to you.

* unified and beautiful
* directly gives you what you want: estimates of the focal parameters with uncertainty
* incorporation of prior knowledge
* intuitive interpretation
* graceful handling of small samples
* infinitely flexible: you can adapt it to any setting, including multilevel structures

There are also some weaknesses, and we'll have to consider those too.

Before we start, I'd love to hear from you all what you know about Bayesian analysis.
What would you like to hear about Bayesian analysis?

We will eventually get to a biological example, but first we are going to take a toy example.
This is a classic: what is the fraction of blue marbles to total marbles in a can that contains both red and blue marbles.
We get to draw marbles from the can.
Let's assume that it's a big can with lots of marbles and that they are well mixed.

Let's imagine that we are doing this from a frequentist perspective.
We can look at [this notebook](https://colab.research.google.com/drive/1sbesb7IcssN7daut64ZWvRmYgLV_6uey?usp=sharing).
This mixes effect size and sample size, which doesn't feel as informative as one would like.

Let's imagine, for a little while, what an ideal statistical inference procedure would look like. 
We'd be able to just take these measurements and get out exactly what the fraction of blue marbles in.

Bayesian analysis doesn't give this.
It's not magic.
But it does directly estimate the values you care about rather than focusing on significance tests.

Because it has limited information it is going to give you an estimate with uncertainty.
We simply don't have enough data when we are drawing marbles from a can to know the actual underlying ratio of marble colors.
There is necessarily some uncertainty when inferring that estimate.

This is a subtle concept.
This is called the posterior distribution.
It is the probability distribution of our _estimated value_.

Start playing with [this notebook](https://bit.ly/marbles-posterior).

Start with reasonable values.
As we increase the number of draws, what happens to our uncertainty?

So let's talk it over.
If we have one observation, how certain are we in our estimate.
Now if we have a lot, how certain are we?

Now, what if we have _no data_. 
What is our estimate then?

In this setup we have to have a prior, which is what happens when we have no data.

Play with the prior.


So let's say 
We know about the normal distribution, right?
Someone draw me the shape of the normal distribution in the air.

First let's focus on just gene A.
Let's imagine that we are going to model the actual gene expression value as a normal distribution.

Say we have just a 



Aleatory uncertainty (or aleatory variability): This is the inherent randomness in a system or process. It's the uncertainty that comes from the natural variability in the phenomenon being measured. Even with perfect measurement tools and infinite samples, this uncertainty would remain because it's an intrinsic property of the system. 
Epistemic uncertainty: This is uncertainty due to our limited knowledge or information. It arises from limitations in our sampling, measurement precision, or model completeness. Unlike aleatory uncertainty, epistemic uncertainty can theoretically be reduced with more data, better measurements, or improved models. 


