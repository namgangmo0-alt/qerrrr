local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local event = ReplicatedStorage:WaitForChild("SpawnGalaxyBlock")

local Window = Rayfield:CreateWindow({
    Name = "럭키블록 생성기",
    LoadingTitle = "로딩 중...",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local player = game.Players.LocalPlayer
local Tab = Window:CreateTab("생성기", 4483362458)

---------------------------------------------------------
-- 기능 함수
---------------------------------------------------------
local function spawnBlock()
    event:FireServer()
end

local function teleportToSpawn()
    local character = player.Character or player.CharacterAdded:Wait()
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(-1158.37085, 193.799988, -183.827057, -0.948844314, -2.0495694e-08, 0.315744251, -2.37873898e-09, 1, 5.77639661e-08, -0.315744251, 5.40579386e-08, -0.948844314)
    end
end

---------------------------------------------------------
-- R, F 키 단축키 감지
---------------------------------------------------------
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.R then
        spawnBlock()
    elseif input.KeyCode == Enum.KeyCode.F then
        teleportToSpawn()
    end
end)

---------------------------------------------------------
-- 버튼 구성
---------------------------------------------------------

-- 럭키블록 생성
Tab:CreateButton({
    Name = "럭키블록 생성 [R]",
    Callback = function() 
        for i = 1, 10 do
            spawnBlock()
            task.wait(0.1)
        end
    end
})

-- 속도 증가
local isSpeedLooping = false

Tab:CreateButton({
    Name = "속도증가",
    Callback = function()
        local character = player.Character or player.CharacterAdded:Wait()
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 64

            if not isSpeedLooping then
                isSpeedLooping = true
                task.spawn(function()
                    while isSpeedLooping do
                        task.wait(0.2)
                        local char = player.Character
                        if not char or not char:FindFirstChild("Humanoid") then
                            isSpeedLooping = false
                            break
                        end

                        if char.Humanoid.WalkSpeed < 64 then
                            char.Humanoid.WalkSpeed = 64
                        end
                    end
                end)
            end
        end
    end
})

-- 점프력 증가
Tab:CreateButton({
    Name = "점프력 증가",
    Callback = function()
        local character = player.Character or player.CharacterAdded:Wait()
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = 100
        end
    end
})

-- 무적 모드
local isHealthLooping = false

Tab:CreateButton({
    Name = "무적 모드",
    Callback = function()
        if not isHealthLooping then
            isHealthLooping = true
            task.spawn(function()
                while isHealthLooping do
                    task.wait(0.05)
                    local char = player.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.Health = char.Humanoid.MaxHealth
                    end
                end
            end)
        end
    end
})

-- 스폰으로 텔레포트
Tab:CreateButton({
    Name = "스폰으로 텔레포트 [F]",
    Callback = function()
        teleportToSpawn()
    end
})
