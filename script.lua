--// =========================================================
--// SIRIUS • AESTHETIC
--// UI VERSION 1.01
--// =========================================================

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

--=========================================================
-- SUPPORTED GAMES
--=========================================================

local SupportedGames = {
    -- Add supported games here:
    -- ["Arsenal"] = true,
    -- ["Phantom Forces"] = true,
}

local GameName = game.Name
local IsSupported = SupportedGames[GameName] == true

--=========================================================
-- WINDOW
--=========================================================

local Window = Rayfield:CreateWindow({
    Name = "Sirius • Aesthetic",
    LoadingTitle = "Sirius Aesthetic",
    LoadingSubtitle = "Version 1.01",

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SiriusAesthetic",
        FileName = "Settings"
    },

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
})

--=========================================================
-- HOME
--=========================================================

local Home = Window:CreateTab({
    Name = "Home",
    Icon = 93364949241311
})

Home:CreateSection({
    Name = "Game"
})

Home:CreateButton({
    Name = "GAME  :  " .. GameName,

    Callback = function()
        print("[Sirius] Game: " .. GameName)
    end
})

Home:CreateSection({
    Name = "Support"
})

Home:CreateButton({
    Name = IsSupported
        and "🟢  SUPPORT"
        or "🔴  SUPPORT",

    Callback = function()
        print(
            "[Sirius] Support: "
            .. (IsSupported and "SUPPORTED" or "NOT SUPPORTED")
        )
    end
})

--=========================================================
-- FEATURES
--=========================================================

local Features = Window:CreateTab({
    Name = "Features",
    Icon = 6031280882
})

Features:CreateSection({
    Name = "Server Hop"
})

Features:CreateButton({
    Name = "🌐  Server Hop",

    Callback = function()

        local Success, Result = pcall(function()

            local URL =
                "https://games.roblox.com/v1/games/"
                .. tostring(game.PlaceId)
                .. "/servers/Public?sortOrder=Asc&limit=100"

            local Response = game:HttpGet(URL)
            local Data = HttpService:JSONDecode(Response)

            local AvailableServers = {}

            for _, Server in ipairs(Data.data or {}) do

                if Server.id
                    and Server.id ~= game.JobId
                    and Server.playing
                    and Server.maxPlayers
                    and Server.playing < Server.maxPlayers then

                    table.insert(
                        AvailableServers,
                        Server
                    )
                end
            end

            if #AvailableServers == 0 then
                error("No available servers found.")
            end

            local SelectedServer =
                AvailableServers[
                    math.random(
                        1,
                        #AvailableServers
                    )
                ]

            TeleportService:TeleportToPlaceInstance(
                game.PlaceId,
                SelectedServer.id,
                LocalPlayer
            )
        end)

        if not Success then
            warn(
                "[Sirius] Server Hop failed: "
                .. tostring(Result)
            )
        end
    end
})

--=========================================================
-- THEMES
--=========================================================

local Themes = Window:CreateTab({
    Name = "Themes",
    Icon = 93309382656514
})

Themes:CreateSection({
    Name = "Theme Gallery"
})

Themes:CreateButton({
    Name = "🔵  Cobalt",

    Callback = function()
        Window:ChangeTheme("cobalt")
    end
})

Themes:CreateButton({
    Name = "❄️  Frost",

    Callback = function()
        Window:ChangeTheme("frost")
    end
})

Themes:CreateButton({
    Name = "🌹  Rose",

    Callback = function()
        Window:ChangeTheme("rose")
    end
})

Themes:CreateButton({
    Name = "⚪  Default",

    Callback = function()
        Window:ChangeTheme("default")
    end
})

Themes:CreateSection({
    Name = "Theme Selector"
})

Themes:CreateDropdown({
    Name = "Choose Theme",

    Options = {
        "cobalt",
        "frost",
        "rose",
        "default"
    },

    Current = "cobalt",

    Callback = function(Value)
        Window:ChangeTheme(Value)
    end
})

--=========================================================
-- ABOUT
--=========================================================

local About = Window:CreateTab({
    Name = "About",
    Icon = 6031075938
})

About:CreateSection({
    Name = "Sirius Aesthetic"
})

About:CreateButton({
    Name = "Sirius Aesthetic",

    Callback = function()
        print("[Sirius] Sirius Aesthetic")
    end
})

About:CreateButton({
    Name = "UI Version  •  1.01",

    Callback = function()
        print("[Sirius] UI Version: 1.01")
    end
})

About:CreateButton({
    Name = "🟢  Status  •  Online",

    Callback = function()
        print("[Sirius] Status: Online")
    end
})

About:CreateSection({
    Name = "Information"
})

About:CreateButton({
    Name = "Interface  •  Sirius Aesthetic",

    Callback = function()
        print("[Sirius] Interface: Sirius Aesthetic")
    end
})

About:CreateButton({
    Name = "Design  •  Aesthetic",

    Callback = function()
        print("[Sirius] Design: Aesthetic")
    end
})

About:CreateSection({
    Name = "Credits"
})

About:CreateButton({
    Name = "Powered by Sirius Gen2",

    Callback = function()
        print("[Sirius] Powered by Sirius Gen2")
    end
})

--=========================================================
-- DEFAULT THEME
--=========================================================

Window:ChangeTheme("cobalt")

print("================================")
print("Sirius Aesthetic • Version 1.01")
print("Loaded successfully.")
print("================================")
