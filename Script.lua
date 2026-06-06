local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Evita acumular menus na tela
if CoreGui:FindFirstChild("FluentBloxMenu") then
    CoreGui:FindFirstChild("FluentBloxMenu"):Destroy()
end

-- ANTI-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- SCREEN GUI PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FluentBloxMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- BOTÃO FLUTUANTE
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "F"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 120, 212)
ToggleBtn.TextSize = 18
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(45, 45, 45)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = ToggleBtn

-- JANELA PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -140)
MainFrame.Size = UDim2.new(0, 420, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 45, 45)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

ToggleBtn.MouseButton1Click:Connect(function()
    local targetVisible = not MainFrame.Visible
    if targetVisible then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.wait(0.2)
        MainFrame.Visible = false
    end
end)

-- BARRA DE TÍTULO
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundTransparency = 1
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.Size = UDim2.new(1, -32, 1, 0)
TitleLabel.Font = Enum.Font.GothamMedium
TitleLabel.Text = "Fluent Hub Premium  |  Blox Fruits"
TitleLabel.TextColor3 = Color3.fromRGB(243, 243, 243)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local Line = Instance.new("Frame")
Line.Parent = MainFrame
Line.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 0, 0, 40)
Line.Size = UDim2.new(1, 0, 0, 1)

-- SIDEBAR
local SidebarContainer = Instance.new("ScrollingFrame")
SidebarContainer.Parent = MainFrame
SidebarContainer.BackgroundTransparency = 1
SidebarContainer.Position = UDim2.new(0, 10, 0, 50)
SidebarContainer.Size = UDim2.new(0, 115, 1, -60)
SidebarContainer.BorderSizePixel = 0
SidebarContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
SidebarContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
SidebarContainer.ScrollBarThickness = 0

local SidebarList = Instance.new("UIListLayout")
SidebarList.Parent = SidebarContainer
SidebarList.Padding = UDim.new(0, 4)

-- CONTAINER DE PÁGINAS
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 135, 0, 50)
Content.Size = UDim2.new(1, -145, 1, -60)

local pages = {}
local tabs = {}

local function CreatePage(id)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = id .. "Page"
    Page.Parent = Content
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BorderSizePixel = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    Page.Visible = false
    
    local List = Instance.new("UIListLayout")
    List.Parent = Page
    List.Padding = UDim.new(0, 6)
    
    pages[id] = Page
    return Page
end

local StatusPage = CreatePage("Status")
local FarmPage = CreatePage("Farm")
local CombatPage = CreatePage("Combat")
local TeleportPage = CreatePage("Teleport")
local SettingsPage = CreatePage("Settings")

StatusPage.Visible = true

local function CreateTab(id, text, isFirst)
    local Tab = Instance.new("TextButton")
    Tab.Parent = SidebarContainer
    Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Tab.BackgroundTransparency = isFirst and 0 or 1
    Tab.Size = UDim2.new(1, -5, 0, 32)
    Tab.Font = Enum.Font.GothamMedium
    Tab.Text = text
    Tab.TextColor3 = isFirst and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    Tab.TextSize = 11
    Tab.TextXAlignment = Enum.TextXAlignment.Left
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 8)
    Padding.Parent = Tab

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Tab
    
    local Indicator = Instance.new("Frame")
    Indicator.Parent = Tab
    Indicator.BackgroundColor3 = Color3.fromRGB(0, 120, 212)
    Indicator.BorderSizePixel = 0
    Indicator.Position = UDim2.new(0, -8, 0.25, 0)
    Indicator.Size = UDim2.new(0, 3, 0.5, 0)
    Indicator.Visible = isFirst
    
    tabs[id] = {Button = Tab, Indicator = Indicator}

    Tab.MouseButton1Click:Connect(function()
        for pageId, page in pairs(pages) do
            page.Visible = false
            tabs[pageId].Button.BackgroundTransparency = 1
            tabs[pageId].Button.TextColor3 = Color3.fromRGB(150, 150, 150)
            tabs[pageId].Indicator.Visible = false
        end
        pages[id].Visible = true
        Tab.BackgroundTransparency = 0
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Indicator.Visible = true
    end)
end

CreateTab("Status", "Perfil / Status", true)
CreateTab("Farm", "Automação (Farm)", false)
CreateTab("Combat", "Combate / Player", false)
CreateTab("Teleport", "Teleportes (Tween)", false)
CreateTab("Settings", "Configurações", false)

-- COMPONENTES FLUENT
local function CreateFluentButton(parent, text, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Parent = parent
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    ButtonFrame.Size = UDim2.new(1, -8, 0, 36)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = ButtonFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(45, 45, 45)
    Stroke.Thickness = 1
    Stroke.Parent = ButtonFrame

    local Btn = Instance.new("TextButton")
    Btn.Parent = ButtonFrame
    Btn.BackgroundTransparency = 1
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.Font = Enum.Font.GothamMedium
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    Btn.TextSize = 11

    Btn.MouseButton1Click:Connect(callback)
end

local function CreateFluentHeader(parent, text)
    local Header = Instance.new("TextLabel")
    Header.Parent = parent
    Header.BackgroundTransparency = 1
    Header.Size = UDim2.new(1, 0, 0, 20)
    Header.Font = Enum.Font.GothamBold
    Header.Text = text:upper()
    Header.TextColor3 = Color3.fromRGB(100, 100, 100)
    Header.TextSize = 9
    Header.TextXAlignment = Enum.TextXAlignment.Left
end

local function CreateStatDisplay(parent, text, getValueCallback)
    local FrameBox = Instance.new("Frame")
    FrameBox.Parent = parent
    FrameBox.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    FrameBox.Size = UDim2.new(1, -8, 0, 28)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = FrameBox

    local Label = Instance.new("TextLabel")
    Label.Parent = FrameBox
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, -10, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = text .. ": Carregando..."
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left

    task.spawn(function()
        while task.wait(1) do
            if not Label.Parent then break end
            pcall(function()
                Label.Text = text .. ": " .. tostring(getValueCallback())
            end)
        end
    end)
end

-- TWEEN SEGURO
local function TweenTo(targetCFrame)
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local speed = 300
    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
    local duration = distance / speed

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = rootPart

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()

    tween.Completed:Connect(function()
        if bv then bv:Destroy() end
    end)
end

-- ENGINE DE AUTO FARM REAL
local function IniciarAutoFarmReal()
    local status, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/X29A-Equinox/Equinox/main/OldFiend"))()
    end)
    if not status then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/allanyb/YuriHub/main/YuriHubBloxFruits.lua"))()
    end
end

-- ==========================================
-- 1. CONTEÚDO DA ABA: STATUS
-- ==========================================
CreateFluentHeader(StatusPage, "Informações do Jogador")
CreateStatDisplay(StatusPage, "Nome", function() return LocalPlayer.Name end)
CreateStatDisplay(StatusPage, "Nível atual", function() return LocalPlayer.Data.Level.Value end)
CreateStatDisplay(StatusPage, "Dinheiro (Beli)", function() 
    return "$" .. tostring(LocalPlayer.Data.Beli.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "") 
end)
CreateStatDisplay(StatusPage, "Fragmentos", function() return tostring(LocalPlayer.Data.Fragments.Value) end)

-- ==========================================
-- 2. CONTEÚDO DA ABA: FARM
-- ==========================================
CreateFluentHeader(FarmPage, "Fazendas Automáticas Legítimas")

CreateFluentButton(FarmPage, "🚀 Lançar AUTO FARM REAL (Auto Level)", function()
    IniciarAutoFarmReal()
end)

_G.AutoChest = false
CreateFluentButton(FarmPage, "Auto Coletar Baús (Usa Tween)", function()
    _G.AutoChest = not _G.AutoChest
    task.spawn(function()
        while _G.AutoChest do
            task.wait(0.5)
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Model") and (v.Name:find("Chest") or v.Name:find("Baú")) then
                        if v:FindFirstChild("TouchPart") and _G.AutoChest then
                            TweenTo(v.TouchPart.CFrame)
                            task.wait((LocalPlayer.Character.HumanoidRootPart.Position - v.TouchPart.Position).Magnitude / 300 + 0.3)
                        end
                    end
                end
            end)
        end
    end)
end)

-- ==========================================
-- 3. CONTEÚDO DA ABA: COMBATE
-- ==========================================
CreateFluentHeader(CombatPage, "Melhorias de Combate")

_G.FastAttack = false
CreateFluentButton(CombatPage, "⚡ FAST ATTACK MÁXIMO (Segure a Arma)", function()
    _G.FastAttack = not _G.FastAttack
    
    if _G.FastAttack then
        task.spawn(function()
            local combatFramework = require(LocalPlayer.PlayerScripts.CombatFramework)
            
            while _G.FastAttack do
                task.wait()
                pcall(function()
                    local character = LocalPlayer.Character
                    local currentTool = character and character:FindFirstChildOfClass("Tool")
                    
                    if currentTool then
                        ReplicatedStorage.Remotes.Validator:FireServer(math.random(-9999, 9999))
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("Attack", currentTool)
                        
                        local activeController = combatFramework.activeController
                        if activeController and activeController.equippedWeapon then
                            activeController:attack()
                        end
                    end
                end)
            end
        end)
    end
end)

_G.FlyMode = false
CreateFluentButton(CombatPage, "Ativar/Desativar Modo Voar (Fly)", function()
    _G.FlyMode = not _G.FlyMode
    pcall(function()
        local bodyVel = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlyVelocity")
        if _G.FlyMode then
            if not bodyVel then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "FlyVelocity"
                bv.MaxForce = Vector3.new(0, 100000, 0)
                bv.Velocity = Vector3.new(0, 30, 0)
                bv.Parent = LocalPlayer.Character.HumanoidRootPart
            end
        else
            if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlyVelocity") then
                LocalPlayer.Character.HumanoidRootPart.FlyVelocity:Destroy()
            end
        end
    end)
end)

-- ==========================================
-- 4. CONTEÚDO DA ABA: TELEPORTES (CORRIGIDO!)
-- ==========================================
CreateFluentHeader(TeleportPage, "Primeiro Mar (Sea 1) - Movimento Seguro")

CreateFluentButton(TeleportPage, "Voar até Ilha Inicial (Starter Island)", function()
    TweenTo(CFrame.new(979, 16, 1412))
end)

CreateFluentButton(TeleportPage, "Voar até Ilha dos Macacos (Jungle)", function()
    TweenTo(CFrame.new(-1611, 37, 150))
end)

CreateFluentButton(TeleportPage, "Voar até o Deserto (Desert)", function()
    -- CORREÇÃO: Coordenada real corrigida para o Deserto Verdadeiro!
    TweenTo(CFrame.new(910, 15, 4295))
end)

CreateFluentButton(TeleportPage, "Voar até Vila de Piratas (Pirate Village)", function()
    TweenTo(CFrame.new(-1120, 4, 3855))
end)

CreateFluentHeader(TeleportPage, "Mudar de Mundo")
CreateFluentButton(TeleportPage, "Viajar para o Segundo Mar", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
end)
CreateFluentButton(TeleportPage, "Viajar para o Terceiro Mar", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
end)

-- ==========================================
-- 5. CONTEÚDO DA ABA: CONFIGURAÇÕES
-- ==========================================
CreateFluentHeader(SettingsPage, "Gerenciar Script")

CreateFluentButton(SettingsPage, "Destruir Menu completamente", function()
    if CoreGui:FindFirstChild("FluentBloxMenu") then
        CoreGui:FindFirstChild("FluentBloxMenu"):Destroy()
    end
end)
