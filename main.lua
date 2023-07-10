-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

tailleCase = 70

local tableColonne = {}
tableColonne[1] = "A"
tableColonne[2] = "B"
tableColonne[3] = "C"
tableColonne[4] = "D"
tableColonne[5] = "E"
tableColonne[6] = "F"
tableColonne[7] = "G"
tableColonne[8] = "H"

local listePieces = {}

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

function CreatePiece(paramImg, paramLigne, paramColonne)
    local piece = {}
    piece.image = paramImg
    piece.ligne = paramLigne
    piece.colonne = paramColonne
    table.insert(listePieces, piece)
end

function love.load()
    CreatePiece(love.graphics.newImage("img/tour_blanc.png"), 1, 1)
    CreatePiece(love.graphics.newImage("img/cavalier_blanc.png"), 1, 2)

    CreatePiece(love.graphics.newImage("img/tour_noir.png"), 8, 1)
    CreatePiece(love.graphics.newImage("img/cavalier_noir.png"), 8, 2)
end

function love.update(dt)
end

function love.draw()
    local margeX = (love.graphics.getWidth() - tailleCase * 8) / 2
    local margeY = (love.graphics.getHeight() - tailleCase * 8) / 2

    local Blanc = true
    for ligne = 1, 8 do
        Blanc = not Blanc
        for colonne = 1, 8 do
            if ligne == 1 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.print(tableColonne[colonne], margeX + ((colonne - 1) * tailleCase))
            end
            if colonne == 1 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.print(9 - ligne, margeX - 20, margeY + ((ligne - 1) * tailleCase))
            end

            Blanc = not Blanc
            if Blanc then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(0.5, 0.5, 0.5)
            end
            love.graphics.rectangle(
                "fill",
                margeX + ((colonne - 1) * tailleCase),
                margeY + ((ligne - 1) * tailleCase),
                tailleCase,
                tailleCase
            )
        end
    end
    for n = 1, #listePieces do
        local piece = listePieces[n]
        local x = margeX + (piece.colonne - 1) * tailleCase
        local y = margeY + (piece.ligne - 1) * tailleCase
        love.graphics.draw(piece.image, x, y)
    end
end

function love.keypressed(key)
end

function love.mousepressed(x, y, b)
    local margeX = (love.graphics.getWidth() - tailleCase * 8) / 2
    local margeY = (love.graphics.getHeight() - tailleCase * 8) / 2

    local colonne = math.floor(((x - margeX) / tailleCase) + 1)
    local ligne = math.floor(((y - margeY) / tailleCase) + 1)

    ligne = 9 - ligne

    print(colonne .. ", " .. ligne)
end
