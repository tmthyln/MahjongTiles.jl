push!(LOAD_PATH, "../src/")

using Documenter, MahjongTiles

makedocs(
    sitename="MahjongTiles.jl Documentation",
    format=Documenter.HTML(
        prettyurls=get(ENV, "CI", nothing) == "true"
    ),
    modules=[MahjongTiles],
    pages=[
        "Home" => "index.md"
    ]
)

deploydocs(
    repo = "github.com/tmthyln/MahjongTiles.jl.git",
    devbranch = "main",
    devurl="latest"
    )
