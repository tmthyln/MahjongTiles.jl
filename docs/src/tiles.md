# Tile API

Tiles are sorted in "suits" or "pseudo-suits." 
Generally speaking, the usual "suited tiles" belong to the character, bamboo, or circle suits.
The other tiles are not really in suits, 
but they can be treated programmatically as if they were.
The normal suits are considered *sequential* suits; 
the other suits are considered *non-sequential* suits.

```@setup mahjong
using MahjongTiles
```

## Suits

!!! info

    This is a more internal implementation detail and is subject to change in future versions.

This is the current way that suits are implemented. All suit types inherit from a single abstract type
```@docs
MahjongTiles.Suit
```
which has the following interface:

| Function                         | Default | Description                                                                |
| -------------------------------: | :-----: | :------------------------------------------------------------------------- |
| `is_sequential(suit_type)`       | `false` | Whether this suit can be scored sequentially                               |
| `max_number(suit_type)`          | `1`     | The max number that this suit has                                          |
| `first_char(suit_type)`          | -       | The Unicode character associated with the number 1 (required)              |
| `typical_duplication(suit_type)` | `1`     | The typical number of tiles included in a deck with each tile in this suit |

Note that the `first_char` method is required for printing, 
and if a new suit has `max_number(suit_type) > 1`, 
it is assumed that they are consecutive in Unicode.

The way that these are currently implemented, 
each suit type is another `abstract type` that inherits from `Suit`.
The required methods operate on the *type* and not instances of the type.

```@docs
MahjongTiles.is_sequential
MahjongTiles.max_number
MahjongTiles.first_char
MahjongTiles.typical_duplication
```

There are also 2 additional constants that list all of the implemented suits.
```@docs
MahjongTiles.suits
MahjongTiles.all_suits
```

## Tiles

```@docs
MahjongTiles.Tile
MahjongTiles.SuitedTile
```

### Accessing Specific Tiles

All of the standard tiles are exported as constants from the MahjongTiles module,
so they can be directly accessed (e.g. for comparisons).

```@repl mahjong
🀘
🀛 < 🀞
```

However, this means that it is difficult to type these without already knowing how to type them.
To mitigate this, there are helper functions to create tiles of each suit.

```@docs
MahjongTiles.character
MahjongTiles.bamboo
MahjongTiles.circle
MahjongTiles.wind
MahjongTiles.dragon
MahjongTiles.flower
MahjongTiles.season
```