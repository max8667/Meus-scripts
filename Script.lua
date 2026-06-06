local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Remove menus antigos para não acumular na tela
if CoreGui:FindFirstChild("MenuBloxFruitsV2") then
    CoreGui:FindFirstChild("MenuBloxFruitsV2"):Destroy()
end

-- JANELA PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MenuBloxFruitsV2"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
MainFrame.Size = UDim2.new(0, 360, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- BARRA DE TÍTULO
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TitleBar.Size = UDim2.new(1, 0, 0, 35)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Size = UDim2.new(1, -24, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Blox Fruits Helper v2"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- SIDEBAR (Abas Laterais)
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 100, 1, -35)

local SidebarList = Instance.new("UIListLayout")
SidebarList.Parent = Sidebar
SidebarList.Padding = UDim.new(0, 4)

-- CONTAINER DE CONTEÚDO
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 110, 0, 45)
Content.Size = UDim2.new(1, -120, 1, -55)

-- Função para Criar Páginas
local function CreatePage()
    local Page = Instance.new("Frame")
    Page.Parent = Content
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    
    local List = Instance.new("UIListLayout")
    List.Parent = Page
    List.Padding = UDim.new(0, 8)
    
    return Page
end

local FarmPage = CreatePage()
local TeleportPage = CreatePage()
FarmPage.Visible = true -- Página inicial

-- Função para Criar Botões na Sidebar
local function CreateTab(text, page)
    local Tab = Instance.new("TextButton")
    Tab.Parent = Sidebar
    Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Tab.Size = UDim2.new(1, -8, 0, 30)
    Tab.Font = Enum.Font.Gotham
    Tab.Text = text
    Tab.TextColor3 = Color3.fromRGB(200, 200, 200)
    Tab.TextSize = 12
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Tab
    
    Tab.MouseButton1Click:Connect(function()
        FarmPage.Visible = false
        TeleportPage.Visible = false
        page.Visible = true
    end)
end

CreateTab("Farm", FarmPage)
CreateTab("Teleportes", TeleportPage)

-- Função para Criar Botões de Ação
local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = parent
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 12
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(callback)
end

-- CONTEÚDO DA ABA FARM
local FarmTitle = Instance.new("TextLabel")
FarmTitle.Parent = FarmPage
FarmTitle.BackgroundTransparency = 1
FarmTitle.Size = UDim2.new(1, 0, 0, 18)
FarmTitle.Font = Enum.Font.GothamBold
FarmTitle.Text = "Opções de Farm"
FarmTitle.TextColor3 = Color3.fromRGB(150, 150, 250)
FarmTitle.TextSize = 12
FarmTitle.TextXAlignment = Enum.TextXAlignment.Left

_G.AutoFarm = false -- CORRIGIDO AQUI (Removido o 'local')
CreateButton(FarmPage, "Ativar Auto Farm (Teste)", function()
    _G.AutoFarm = not _G.AutoFarm
    print("Estado do AutoFarm alterado para: " .. tostring(_G.AutoFarm))
end)

-- CONTEÚDO DA ABA TELEPORTES
local TeleportTitle = Instance.new("TextLabel")
TeleportTitle.Parent = TeleportPage
TeleportTitle.BackgroundTransparency = 1
TeleportTitle.Size = UDim2.new(1, 0, 0, 18)
TeleportTitle.Font = Enum.Font.GothamBold
TeleportTitle.Text = "Teleportar (Primeiro Mar)"
TeleportTitle.TextColor3 = Color3.fromRGB(150, 150, 250)
TeleportTitle.TextSize = 12
TeleportTitle.TextXAlignment = Enum.TextXAlignment.Left

CreateButton(TeleportPage, "Ir para Selva (Jungle)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(-1611, 37, 150)
    end
end)

CreateButton(TeleportPage, "Ir para Deserto (Desert)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(1095, 17, 1424)
    end
end)
