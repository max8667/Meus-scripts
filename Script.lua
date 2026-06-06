--[==[
    Bora criar uma interface de verdade!
    Este código é mais avançado, mas eu comentei tudo para você entender.
--]==]

-- 1. CONFIGURAÇÃO DA BIBLIOTECA DE UI (Vamos fazer "na mão" para você ver como é)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService") -- Para animações suaves

-- Remove GUIs antigas para não acumular se você rodar o script várias vezes
if CoreGui:FindFirstChild("MenuBloxFruitsV2") then
    CoreGui:FindFirstChild("MenuBloxFruitsV2"):Destroy()
end

-- 2. CRIAÇÃO DOS ELEMENTOS PRINCIPAIS
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MenuBloxFruitsV2"
ScreenGui.Parent = CoreGui -- Isso faz o menu não sumir quando você morre
ScreenGui.ResetOnSpawn = false

-- Janela Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20) -- Fundo quase preto
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175) -- Centralizado
MainFrame.Size = UDim2.new(0, 500, 0, 350) -- Tamanho bom
MainFrame.Active = true
MainFrame.Draggable = true -- Deixa arrastar

-- Arredondar os cantos da janela
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Barra de Título
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30) -- Um pouco mais clara
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(1, -30, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Blox Fruits Helper V1 | By max8667"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 3. SISTEMA DE ABAS (SIDEBAR)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 130, 1, -40)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Parent = Sidebar
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 5)

-- Container de Conteúdo (Onde as funções aparecem)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 140, 0, 50)
ContentContainer.Size = UDim2.new(1, -150, 1, -60)

-- Função auxiliar para criar páginas de conteúdo
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Parent = ContentContainer
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0) -- Ajusta automaticamente
    Page.ScrollBarThickness = 2
    Page.Visible = false -- Começa escondida

    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 10)

    return Page
end

-- Criar as páginas
local MainPage = CreatePage("Main")
local TeleportPage = CreatePage("Teleport")
MainPage.Visible = true -- Página inicial

-- Função auxiliar para criar botões na sidebar
local function CreateSidebarButton(name, text, pageToOpen)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Tab"
    Button.Parent = Sidebar
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, -10, 0, 35)
    Button.Position = UDim2.new(0, 5, 0, 0) -- Pequeno padding
    Button.Font = Enum.Font.Gotham
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Button.TextSize = 14
    Button.AutoButtonColor = false -- Vamos animar nós mesmos

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 5)
    ButtonCorner.Parent = Button

    -- Efeito de Hover (passar o mouse) e Clique
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35), TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        -- Esconde todas as páginas
        for _, page in pairs(ContentContainer:GetChildren()) do
            if page:IsA("ScrollingFrame") then
                page.Visible = false
            end
        end
        -- Mostra a página correta
        pageToOpen.Visible = true
    end)

    return Button
end

-- Adicionar os botões na sidebar
CreateSidebarButton("Main", "Início", MainPage)
CreateSidebarButton("Teleport", "Teleportes", TeleportPage)


-- 4. ADICIONANDO FUNÇÕES E OBJETOS ÀS PÁGINAS

-- Função auxiliar para criar uma seção (título de grupo)
local function CreateSection(parent, text)
    local Label = Instance.new("TextLabel")
    Label.Parent = parent
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 25)
    Label.Font = Enum.Font.GothamBold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(150, 150, 200) -- Cor azulada
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Position = UDim2.new(0, 5, 0, 0)
end

-- Função auxiliar para criar botões de ação nas páginas
local function CreateActionButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = parent
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, -10, 0, 40)
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button

    -- Efeito de Clique
    Button.MouseButton1Click:Connect(function()
        -- Animação rápida de clique
        local oldColor = Button.BackgroundColor3
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        task.wait(0.1)
        Button.BackgroundColor3 = oldColor
        
        -- Executa a função
        callback()
    end)
end

-- Função auxiliar para criar uma exibição de estatística
local function CreateStatDisplay(parent, prefix, getValueCallback)
    local Label = Instance.new("TextLabel")
    Label.Parent = parent
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Font = Enum.Font.Gotham
    Label.Text = prefix .. ": Carregando..."
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    -- Atualiza a estatística a cada 1 segundo
    task.spawn(function()
        while task.wait(1) do
            if not Label.Parent then break end -- Para se a GUI sumir
            Label.Text = prefix .. ": " .. tostring(getValueCallback())
        end
    end)
end

-- -- -- PÁGINA INICIAL -- -- --
CreateSection(MainPage, "Suas Estatísticas")

CreateStatDisplay(MainPage, "Nível", function()
    return LocalPlayer.Data.Level.Value
end)
CreateStatDisplay(MainPage, "Beli", function()
    -- Formata o número com vírgulas
    return tostring(LocalPlayer.Data.Beli.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end)
CreateStatDisplay(MainPage, "Fruta Atual", function()
    return LocalPlayer.Data.Fruit.Value ~= "" and LocalPlayer.Data.Fruit.Value or "Nenhuma"
end)

CreateSection(MainPage, "Automação (Básico)")

-- Variável para controlar o estado do Auto Farm
local _G.AutoFarm_Enabled = false

CreateActionButton(MainPage, "Ativar/Desativar Auto Farm (Exemplo)", function()
    _G.AutoFarm_Enabled = not _G.AutoFarm_Enabled
    print("Auto Farm: " .. tostring(_G.AutoFarm_Enabled))
    
    -- Aqui você colocaria a lógica real do seu farm,
    -- provavelmente dentro de um loop task.spawn(function() while _G.AutoFarm_Enabled do ... end end)
    -- Por enquanto, vamos apenas avisar.
    
    -- Exemplo simples de como a lógica começaria:
    --[[
    if _G.AutoFarm_Enabled then
        task.spawn(function()
            while _G.AutoFarm_Enabled do
                -- Lógica de farm aqui (atacar NPCs, coletar quests, etc.)
                print("Farmando...")
                task.wait(1) -- Espera 1 segundo
            end
        end)
    end
    --]]
end)


-- -- -- PÁGINA DE TELEPORTE -- -- --
CreateSection(TeleportPage, "Locais Importantes (Primeiro Mar)")

CreateActionButton(TeleportPage, "Teleportar para Selva (Jungle)", function()
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        Character.HumanoidRootPart.CFrame = CFrame.new(-1611, 37, 150) -- Coordenadas de exemplo
        print("Teleportado para a Selva!")
    end
end)

CreateActionButton(TeleportPage, "Teleportar para Deserto (Desert)", function()
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        Character.HumanoidRootPart.CFrame = CFrame.new(1095, 17, 1424) -- Coordenadas de exemplo
        print("Teleportado para o Deserto!")
    end
end)

CreateSection(TeleportPage, "Locais Importantes (Segundo Mar)")
-- Adicionar botões semelhantes aqui para o Segundo Mar, mudando as coordenadas

print("Interface Avançada Carregada com Sucesso!")
