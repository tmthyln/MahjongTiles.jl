# MahjongTiles.jl

[![Documentation](https://github.com/tmthyln/MahjongTiles.jl/actions/workflows/docs.yml/badge.svg)](https://github.com/tmthyln/MahjongTiles.jl/actions/workflows/docs.yml)
[![Unit Tests](https://github.com/tmthyln/MahjongTiles.jl/actions/workflows/tests.yml/badge.svg)](https://github.com/tmthyln/MahjongTiles.jl/actions/workflows/tests.yml)
[![Nightly Tests](https://github.com/tmthyln/MahjongTiles.jl/actions/workflows/nightly.yml/badge.svg)](https://github.com/tmthyln/MahjongTiles.jl/actions/workflows/nightly.yml)

Basic utilities for representing and working with Mahjong tiles, hands, and decks
(works in a similar way to 
[PlayingCards.jl](https://juliahub.com/ui/Packages/PlayingCards/I6MLG/0.3.0)).

To get started, you can install from the Julia General repository in the usual way:

```julia
(env) pkg> add MahjongTiles
```

See the [full documentation](https://tmthyln.github.io/MahjongTiles.jl/latest/) for more details.

## Components

### Tiles

Each of the 42 unique standard tiles is represented as a object.
To access an individual tile, you can reference the "symbolic" constants
that are exported by the package:

```julia
julia> using MahjongTiles

julia> 🀛
🀛

julia> 🀥
🀥
```

However, it's hard to type these out without already knowing how to type them,
so there are a few convenience functions that can create specific tiles:

```julia
julia> using MahjongTiles: character, season, wind, dragon

julia> character(3)
🀉

julia> season(4)
🀩

julia> wind(2)
🀁

julia> dragon(1) == dragon(:red)
🀄
```


### Decks

Depending on the specific variety of Mahjong being played,
a deck is composed of 4 of each tile from the 3 standard "suits",
plus 4 of each of the winds, 4 of each of the dragons, and 
sometimes the 8 flowers/seasons.
In the code, these are called `TilePile`s. 
The easiest way to create one is to just use the standard constructor:

```julia
using MahjongTiles: TilePile

deck = TilePile(:standard)
```

### Hands

Again, depending on the specific variety being played, 
a hand is usually composed of 13+1 or 16+1 tiles from a game deck.

There are also functions to test if hands contain certain arrangements;
these are used to count points 
(for gambling, sure, but also for bragging rights).


## Related

There's also a similar project [MahjongEnvironment](https://github.com/coldinjection/MahjongEnvironment);
however, this package differs in
- more broad scope beyond just reinforcement learning
- registered
- support different variants of Mahjong in a more general way
