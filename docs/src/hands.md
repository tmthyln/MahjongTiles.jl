# Hands

A `Hand` represents the set of tiles that a particular player has
(varies in number, depending on the variety of Mahjong being played).

```@docs
MahjongTiles.Hand
```

`Hand`s support the following operations that behave similarly to how they do in Julia Base:

- iteration
- `push!`

## Scoring Functions

`Hand`s can be checked for whether they have certain configurations/arrangements of tiles
(e.g. contain no winds, contain only tiles that are completely green, contain all threes-of-a-kind).
There are roughly 2 kinds:
- those that describe a property of the entire hand (e.g. all sets must include the number 5), and
- those that describe a smaller arrangement of tiles that must be present somewhere in the hand (e.g. two threes-in-a-row of different suits, the other tiles are not considered).
The former are generally prefixed with `is_` and the latter with `has_`.

In a way, these are not "scoring" functions, 
as they don't assign a score for each configuration,
but only whether the configuration applies.

```@docs
MahjongTiles.is_pure
```
