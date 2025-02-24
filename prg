local function isMatureCrop()
    local success, data = turtle.inspectDown()
    if success and data.name:match("mysticalagriculture") then
        return data.state.age == 7 -- Vérifie si la culture est mature
    end
    return false
end

local function plantSeed()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and item.name:match("mysticalagriculture:seeds") then
            turtle.select(slot)
            return turtle.placeDown()
        end
    end
    return false
end

local function harvestAndReplant()
    if isMatureCrop() then
        turtle.digDown()
        plantSeed()
    end
end

local function moveForward()
    while not turtle.forward() do
        turtle.dig()
        sleep(0.5)
    end
end

local function turnAround()
    turtle.turnRight()
    moveForward()
    turtle.turnRight()
end

local function farmField(width, height)
    for row = 1, height do
        for col = 1, width - 1 do
            harvestAndReplant()
            moveForward()
        end
        harvestAndReplant()
        if row < height then
            if row % 2 == 1 then
                turtle.turnRight()
                moveForward()
                turtle.turnRight()
            else
                turtle.turnLeft()
                moveForward()
                turtle.turnLeft()
            end
        end
    end
end

print("Entrez la largeur du champ:")
local width = tonumber(read())
print("Entrez la hauteur du champ:")
local height = tonumber(read())
print("Début de l'automatisation de la ferme Mystical Agriculture...")
farmField(width, height)
print("Ferme terminée !")
