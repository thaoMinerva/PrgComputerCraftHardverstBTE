-- Paramètres du champ (modifiable)
local largeur = 5  -- Nombre de colonnes
local longueur = 5 -- Nombre de lignes

-- Vérifie si la plante est mature (âge = 7)
local function estMature()
    local _, data = turtle.inspectDown()
    if data and data.state and data.state.age == 7 then
        return true
    end
    return false
end

-- Récolte et replante
local function recolterEtReplanter()
    if estMature() then
        turtle.digDown()
        turtle.suckDown()
        for i = 1, 16 do
            local detail = turtle.getItemDetail(i)
            if detail and detail.name:match("seeds") then
                turtle.select(i)
                turtle.placeDown()
                break
            end
        end
    end
end

-- Dépose les objets dans un coffre (devant)
local function viderInventaire()
    turtle.turnRight()
    turtle.turnRight()
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop()
    end
    turtle.turnRight()
    turtle.turnRight()
end

-- Vérifie si l'inventaire est plein
local function inventairePlein()
    for i = 1, 16 do
        if turtle.getItemCount(i) == 0 then
            return false
        end
    end
    return true
end

-- Récolte le champ
local function recolterChamp()
    for ligne = 1, longueur do
        for col = 1, largeur - 1 do
            recolterEtReplanter()
            turtle.forward()
        end
        if ligne ~= longueur then
            if ligne % 2 == 1 then
                turtle.turnRight()
                turtle.forward()
                turtle.turnRight()
            else
                turtle.turnLeft()
                turtle.forward()
                turtle.turnLeft()
            end
        end
        if inventairePlein() then
            viderInventaire()
        end
    end
end

-- Lancer le programme
recolterChamp()
print("Récolte terminée !")
