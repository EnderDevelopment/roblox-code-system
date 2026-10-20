-- CodeRedemptionServer.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CodeRedemptionEvent = Instance.new("RemoteEvent")
CodeRedemptionEvent.Name = "CodeRedemptionEvent"
CodeRedemptionEvent.Parent = ReplicatedStorage

local CodeRedemptionResponseEvent = Instance.new("RemoteEvent")
CodeRedemptionResponseEvent.Name = "CodeRedemptionResponseEvent"
CodeRedemptionResponseEvent.Parent = ReplicatedStorage

local Codes = {
    ["WEAPON123"] = {
        type = "weapon",
        reward = "Sword",
        usageLimit = 1,
        expirationTime = os.time() + 86400,
        uses = 0
    },
    ["CURRENCY456"] = {
        type = "currency",
        reward = 1000,
        usageLimit = 5,
        expirationTime = os.time() + 604800,
        uses = 0
    }
}

local function redeemCode(player, code)
    local codeData = Codes[code]
    
    if not codeData then
        return "Invalid code."
    end
    
    if codeData.uses >= codeData.usageLimit then
        return "Code usage limit reached."
    end
    
    if os.time() > codeData.expirationTime then
        return "Code has expired."
    end
    
    if codeData.type == "weapon" then
        local tool = Instance.new("Tool")
        tool.Name = codeData.reward
        tool.Parent = player.Backpack
        codeData.uses = codeData.uses + 1
        return "Weapon " .. codeData.reward .. " redeemed successfully."
    elseif codeData.type == "currency" then
        local leaderstats = player:FindFirstChild("leaderstats")
        if not leaderstats then
            leaderstats = Instance.new("Folder")
            leaderstats.Name = "leaderstats"
            leaderstats.Parent = player
            
            local currency = Instance.new("IntValue")
            currency.Name = "Currency"
            currency.Value = 0
            currency.Parent = leaderstats
        end
        
        local currency = leaderstats:FindFirstChild("Currency")
        if currency then
            currency.Value = currency.Value + codeData.reward
            codeData.uses = codeData.uses + 1
            return "Currency " .. codeData.reward .. " redeemed successfully."
        else
            return "Failed to redeem currency."
        end
    else
        return "Invalid code type."
    end
end

CodeRedemptionEvent.OnServerEvent:Connect(function(player, code)
    local response = redeemCode(player, code)
    CodeRedemptionResponseEvent:FireClient(player, response)
end)

-- CodeRedemptionServer.lua