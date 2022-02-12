# MahjongTiles.jl Documentation

This is a library package for working with Mahjong games and its primitives,
such as tiles, decks, and hands.

## Getting Started

To install, you can use the Julia package manager:

```julia
(env) pkg> add MahjongTiles
```

The "Anatomy of a Game" walks through the phases of a typical Mahjong game
(using a particular set of rules)
and how it would be implemented using this package.

For specific structs and function calls available, 
see the "API" section of the docs.

!!! note

    When tiles are printed (to the console) or shown in the docs, 
    usually (although depending on your setup), 
    the tiles will be very small,
    which means they can sometimes be difficult to see.

    In addition, because of the weird position of the "red dragon" tile (🀄),
    it often appears more emoji-like in many fonts,
    making it stand out and messing up fixed-width spacing.


## Related

There's also a similar project [MahjongEnvironment.jl](https://github.com/coldinjection/MahjongEnvironment);
however, this package differs in
- more broad scope beyond just reinforcement learning
- registered
- supporting different variants of Mahjong in a more general way
- is not intended to provide a full Mahjong game environment
