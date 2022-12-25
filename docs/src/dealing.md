# Dealing the Hands

Having [built the wall](building_wall.md), 
next we need to deal tiles to each player.

## Distributing tiles to player hands

Starting from the **east** seat, 
sets of 4 tiles are distributed to each seat,
and then single tiles are distributed.
The **east** seat gets one extra tile to start
(effectively, they're just starting their turn early).

Depending on the style of Mahjong, 
there are different numbers of sets of tiles distributed.
For example, in 13-tile variants,
all seats get 3 sets of 4 tiles and then 1 set of 1 tile.

```@example deal
using MahjongTiles: TilePile, deal_tiles
using Random

deck = TilePile(:standard)
shuffle!(deck)

hands = deal_tiles(deck, quadruple_rounds=3, single_rounds=1)  # default
```

In 16-tile variants,
all seats get 4 sets of 4 tiles and no sets of 1 tile.

```@example deal
deck = TilePile(:standard)
shuffle!(deck)

hands16 = deal_tiles(deck, quadruple_rounds=4, single_rounds=0)
```

Note how the first hand (the one for the **east** hand) has an extra tile to start.

## Replacing flowers

When playing with flowers, 
flowers for all players are replaced at the beginning of each game
before the first tile is thrown out.
