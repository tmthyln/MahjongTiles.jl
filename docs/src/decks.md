# Decks (TilePiles)

Tiles can also be collected into an abstract idea of a "pile of tiles."
For example, this is intended to be used to represent the four walls of tiles in the game.
Decks (called `TilePile`s in code) have several properties:

- Ordered
- Size strictly decreases
- Removal occurs strictly at the two ends of the pile

In this way, a `TilePile` is like a deque that can only be removed from once it's been created.

```@docs
MahjongTiles.TilePile
MahjongTiles.TilePile(::Symbol)
```

`TilePile`s support a limited set of operations that reflect allowable actions in the game,
e.g. shuffling tiles, `circshift` for determining where the ends of the pile are.

## Removing from a `TilePile`

```@docs
Base.pop!(::MahjongTiles.TilePile)
Base.pop!(::MahjongTiles.TilePile, ::Integer)
Base.popfirst!(::MahjongTiles.TilePile)
Base.popfirst!(::MahjongTiles.TilePile, ::Integer)
```

## Other Operations

These are other functions supported for the `TilePile` type,
which behave similar to the way they do in Julia Base.

- `length`
- `first`
- `last`
- `circshift`
- `circshift!` (this has a slightly different signature than in Base)
- `shuffle!`
