push!(LOAD_PATH, "../src/")

using Documenter, MahjongTiles

makedocs(
    sitename="MahjongTiles.jl Documentation",
    format=Documenter.HTML(
        prettyurls=get(ENV, "CI", nothing) == "true"
    ),
    modules=[MahjongTiles],
    pages=[
        "Home" => "index.md",
        "Anatomy of a Game" => [
            "Building the Wall" => "building_wall.md",
            "Dealing the Hands" => "dealing.md",
            "Rounds of Gameplay" => "gameplay.md",
            "Scoring Hands" => "scoring.md",
        ],
        "API Reference" => [
            "Tiles" => "tiles.md",
            "Decks/TilePiles" => "decks.md",
            "Hands" => "hands.md",
        ],
    ],
)

deploydocs(
    repo = "github.com/tmthyln/MahjongTiles.jl.git",
    devbranch = "main",
    devurl="latest",
)
