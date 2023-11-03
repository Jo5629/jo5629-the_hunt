hunt_teams = {}

function hunt_teams.get(name)
    local team
    for lobby, team in pairs(hunt_lobbies) do
        if lobby == "main_lobby" then return end
        
    end
    return team
end