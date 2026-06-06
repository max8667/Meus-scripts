-- Cria uma janela simples na tela do jogo
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Configura o quadrado da janela
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- Você pode arrastar a janela

-- Configura o texto dentro da janela
TextLabel.Parent = MainFrame
TextLabel.Text = "Menu do Blox Fruits Carregado!"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.TextSize = 18

