local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local event = ReplicatedStorage:WaitForChild("SpawnGalaxyBlock")

local Window = Rayfield:CreateWindow({
    Name = "럭키블록 생성기",
    LoadingTitle = "로딩 중..."
})

local player = game.Players.LocalPlayer
local Tab = Window:CreateTab("생성기", 4483362458)

---------------------------------------------------------
-- 기능 함수
---------------------------------------------------------
local function spawnBlock() event:FireServer() end

local function teleportToSpawn()
    local character = player.Character or player.CharacterAdded:Wait()
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame =
            CFrame.new(-1158.37085, 193.799988, -183.827057, -0.948844314,
                       -2.0495694e-08, 0.315744251, -2.37873898e-09, 1,
                       5.77639661e-08, -0.315744251, 5.40579386e-08,
                       -0.948844314)
    end
end

---------------------------------------------------------
-- Q, E 키 단축키 감지
---------------------------------------------------------
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- 채팅 중일 때는 입력 무시

    if input.KeyCode == Enum.KeyCode.Q then
        spawnBlock()
    elseif input.KeyCode == Enum.KeyCode.E then
        teleportToSpawn()
    end
end)

---------------------------------------------------------
-- 기존 버튼 구성
---------------------------------------------------------

-- 럭키블록 생성
Tab:CreateButton({
    Name = "럭키블록 생성 [Q]",
    Callback = function()
        for i = 1, 10 do
            spawnBlock()
            task.wait(0.1) -- 0.1초 간격으로 생성
        end
    end
})

-- 속도 증가 (루프 중복 방지 변수)
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

-- 무적 모드 (0.05초마다 체력 100 회복 루프)
local isHealthLooping = false

Tab:CreateButton({
    Name = "무적 모드",
    Callback = function()
        local character = player.Character or player.CharacterAdded:Wait()
        while true do
            task.wait(0.0001)
            character.Humanoid.Health = character.Humanoid.Health + 100
        end
    end
})

-- 스폰으로 텔레포트
Tab:CreateButton({
    Name = "스폰으로 텔레포트 [E]",
    Callback = function()
        player.CharacterAdded:Connect(function(character)
            character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(
                                                                    -1158.37085,
                                                                    193.799988,
                                                                    -183.827057,
                                                                    -0.948844314,
                                                                    -2.0495694e-08,
                                                                    0.315744251,
                                                                    -2.37873898e-09,
                                                                    1,
                                                                    5.77639661e-08,
                                                                    -0.315744251,
                                                                    5.40579386e-08,
                                                                    -0.948844314)
        end)
    end
})
