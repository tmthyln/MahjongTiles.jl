# Scoring Hands

Now that someone has won (or claimed to have won),
we need to "score" two parts:

- determine whether they've actually won; this is just checking that their hand "works"
- if counting points, determine the number of points they have and whether they've reached the win threshold of points

It turns out, this is not *that* straightforward, 
because we need to search through all possible ways to arrange the tiles in a valid way.
In general, we also want to combine this with the scoring
so that we find the arrangement with the highest point score,
and rules can be complex.

