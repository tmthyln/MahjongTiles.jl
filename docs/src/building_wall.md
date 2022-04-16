# Building the Wall

The first step before the game can be played is that the four "walls" need to be built.
Physically, this involves shuffling the deck and stacking the tiles into four rows of a certain length and 2 tiles tall.

In code, this is broken up into a few steps:

## Determine the size of the deck

Depending on the variation, some of the "suits" are excluded. 
In the standard variation, there are the following tile quantities:

|            Suit | Examples | Quantity of Each Tile |
| ---------------:|:-------- |:--------------------- |
|       Character | 🀉🀍🀏      | 4 per number          |
|          Bamboo | 🀐🀑🀗      | 4 per number          |
|          Circle | 🀙🀝🀟      | 4 per number          |
|           Winds | 🀀🀁🀂🀃     | 4 of each             |
|         Dragons | 🀄🀅🀆      | 4 of each             |
| Flowers/Seasons | 🀢🀤🀦🀩     | 1 of each             |

## Create and shuffle the deck

For the standard deck, there's a single argument constructor that automatically creates a deck with the correct number of tiles.

```@example deck
using MahjongTiles: TilePile

deck = TilePile(:standard)
```

Then, we shuffle the deck.

```@example deck
using Random

shuffle!(deck)
```

In a physical game of Mahjong, 
dice are rolled to determine where to start distributing tiles.
However, this is mostly an anti-cheat measure.
We could roll some dice and then use `circshift` to adjust the deck,
but that's mostly for show (or in a GUI implementation).

