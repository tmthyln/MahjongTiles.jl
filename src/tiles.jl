
#=================================== SUITS ===================================#

"""
The root abstract type for suit types. 
This is also used to represent "pseudo-suit" types, like the winds, dragons, flowers, etc.
"""
abstract type Suit end

abstract type Character <: Suit end
abstract type Bamboo <: Suit end
abstract type Circle <: Suit end
abstract type Wind <: Suit end
abstract type Dragon <: Suit end
abstract type Flower <: Suit end
abstract type Season <: Suit end

@doc """
    is_sequential(suit_type)

Check whether this suit type (or pseudo-suit) is a sequential one (for the purposes of hands).
For example, typically the characters suit is sequential, but the winds suit is not.
"""
is_sequential(::Type{<:Suit}) = false
is_sequential(s::Suit) = is_sequential(typeof(s))

is_sequential(::Type{Character}) = true
is_sequential(::Type{Bamboo}) = true
is_sequential(::Type{Circle}) = true

@doc """
    max_number(suit_type)

The maximum ("index") number for this suit type (or pseudo-suit).
For example, the traditional suited tiles (characters, bamboo, circle)
have a max of 9 (starting at 1), 
whereas the winds pseudo-suit has a max of 4.
"""
max_number(::Type{<:Suit}) = 1
max_number(s::Suit) = max_number(typeof(s))

max_number(::Type{Character}) = 9
max_number(::Type{Bamboo}) = 9
max_number(::Type{Circle}) = 9
max_number(::Type{Wind}) = 4
max_number(::Type{Dragon}) = 3
max_number(::Type{Flower}) = 4
max_number(::Type{Season}) = 4

@doc """
    first_char(suit_type)

The character for the first tile in this suit (in Unicode).

## Examples
```julia-repl
julia> first_char(Character)
🀇

```
"""
first_char(::Type{<:Suit}) = throw("not implemented")
first_char(::Type{Character}) = '🀇'
first_char(::Type{Bamboo}) = '🀐'
first_char(::Type{Circle}) = '🀙'
first_char(::Type{Wind}) = '🀀'
first_char(::Type{Dragon}) = '🀄'
first_char(::Type{Flower}) = '🀢'
first_char(::Type{Season}) = '🀦'

@doc """
    typical_duplication(suit_type)

The number of duplicate tiles usually used for this suit type
(this is usually 1 or 4).
"""
typical_duplication(::Type{<:Suit}) = 1
typical_duplication(::Type{Character}) = 4
typical_duplication(::Type{Bamboo}) = 4
typical_duplication(::Type{Circle}) = 4
typical_duplication(::Type{Wind}) = 4
typical_duplication(::Type{Dragon}) = 4

Base.isless(x::Type{<:Suit}, y::Type{<:Suit}) = first_char(x) < first_char(y)

#=================================== TILES ===================================#

"""
The root tile type for Mahjong tiles. 
However, the contract for what the Tile interface entails is not well-defined,
so most functions dispatch on the `SuitedTile` and not on `Tile`.
"""
abstract type Tile end

"""
A tile with a suit (or pseudo-suit).
"""
struct SuitedTile{SuitType <: Suit} <: Tile
    number::Int8

    """
        SuitedTile(suit_type, number=1)
    
    Create a tile of a particular suit `suit_type` and `number`
    (use the default `1` for a "suit" that has only 1 tile).
    """
    function SuitedTile(SuitType::Type{<:Suit}, number::Integer = 1)
        number < 1 && throw("number must be positive")
        number > max_number(SuitType) && throw("number is greater than the max allowed for this suit")

        return new{SuitType}(number)
    end
end

suit(::SuitedTile{T}) where T = T
number(tile::SuitedTile) = tile.number
is_suit(::SuitedTile{T}, suit_type::Type{<:Suit}) where T = T == suit_type
is_number(tile::SuitedTile, num::Integer) = tile.number == num

function Base.:(==)(x::SuitedTile{T}, y::SuitedTile{S}) where {T, S}
    return T == S && x.number == y.number
end
Base.hash(tile::SuitedTile{SuitType}, h::UInt) where SuitType = hash(SuitType, hash(tile.number, h))

function Base.isless(left::SuitedTile{LeftSuit}, right::SuitedTile{RightSuit}) where {LeftSuit, RightSuit}
    if LeftSuit != RightSuit
        return isless(LeftSuit, RightSuit)
    else
        return left.number < right.number
    end
end

function Base.show(io::IO, ::MIME"text/plain", tile::SuitedTile{T}) where T
    print(io, first_char(T) + tile.number - 1)
end
function Base.show(io::IO, tile::SuitedTile{T}) where T
    show(io::IO, MIME"text/plain"(), tile)
end

#============================== TILE CONSTANTS ===============================#

"""
List of the "normal" suits: character, bamboo, circles.

```@repl
using MahjongTiles

MahjongTiles.suits
```
"""
const suits = [Character, Bamboo, Circle]

"""
List of all suits, including "pseudo-suits" like the winds and flowers.
"""
const all_suits = [suits..., Wind, Dragon, Flower, Season]

for suit in [Character, Bamboo, Circle, Wind, Dragon, Flower, Season], i in 1:max_number(suit)
    tile_name = Symbol(first_char(suit) + i - 1)
    @eval MahjongTiles, const $tile_name = SuitedTile($suit, $i)
    @eval MahjongTiles, export $tile_name
end

@doc """
    character(index)

Creates a tile of the character suit with the particular number.

## Example

```jldoctest
julia> character(5)
🀋
```

"""
character(index::Integer) = SuitedTile(Character, index)

@doc """
    bamboo(index)

Creates a tile of the bamboo suit with the particular number.

## Example

```jldoctest
julia> bamboo(2)
🀑
```
"""
bamboo(index::Integer) = SuitedTile(Bamboo, index)

@doc """
    circle(index)

Creates a tile of the circle suit with the particular number.

## Example

```jldoctest
julia> circle(9)
🀡
```
"""
circle(index::Integer) = SuitedTile(Circle, index)

@doc """
    wind(index)
    wind(direction)

Creates a wind tile. 
If an integer is used, 
the standard Chinese ordering of the cardinal directions is used
(i.e. `1` -> east, `2` -> south, `3` -> west, `4` -> north).
Otherwise, symbols can also be used for the names of the directions
(e.g. `:east`, `:north`).

## Example

```jldoctest
julia> wind(:north)
🀃

julia> wind(2)
🀁
```
"""
wind(index::Integer) = SuitedTile(Wind, index)
function wind(name::Symbol)
    if name === :east
        return SuitedTile(Wind, 1)
    elseif name === :south
        return SuitedTile(Wind, 2)
    elseif name === :west
        return SuitedTile(Wind, 3)
    elseif name === :north
        return SuitedTile(Wind, 4)
    else
        throw("unrecognized cardinal direction")
    end
end

@doc """
    dragon(index)
    dragon(name)

Creates a wind tile. 
If an integer is used, 
the standard ordering is used
(i.e. `1` -> red dragon, `2` -> green dragon, `3` -> white dragon).
Otherwise, symbols can also be used for their names/colors
(e.g. `:red`, `:green`).

## Example

```jldoctest
julia> dragon(:red)
🀄

julia> dragon(2)
🀅
```
"""
dragon(index::Integer) = SuitedTile(Dragon, index)
function dragon(name::Symbol)
    if name === :red
        return SuitedTile(Dragon, 1)
    elseif name === :green
        return SuitedTile(Dragon, 2)
    elseif name === :white
        return SuitedTile(Dragon, 3)
    else
        throw("unrecognized dragon color")
    end
end

@doc """
    flower(index)

Creates a flower tile with the particular number.

!!! note

    While this function (and the `season` function) don't allow using the flower (season) names,
    they may have this functionality in the future.

## Example

```jldoctest
julia> flower(2)
🀣
```
"""
flower(index::Integer) = SuitedTile(Flower, index)

@doc """
    season(index)

Creates a season (flower) tile with the particular number.

!!! note

    While this function (and the `flower` function) don't allow using the season (flower) names,
    they may have this functionality in the future.

## Example

```jldoctest
julia> season(4)
🀩
```
"""
season(index::Integer) = SuitedTile(Season, index)
