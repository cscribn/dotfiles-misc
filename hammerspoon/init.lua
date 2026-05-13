local BUSYLIGHT = "~/.local/bin/busylight" -- MUST match `which busylight`

local pollSeconds = 1
local last = nil

local function anyCameraInUse()
    for _, c in pairs(hs.camera.allCameras()) do
        local ok, on = pcall(function() return c:isInUse() end)
        if ok and on then return true end
    end
    return false
end

local function push(on)
    if last == on then return end
    last = on
    local args = on and { "on", "red" } or { "on", "green" }
    local t = hs.task.new(BUSYLIGHT, function(code, out, err)
        if code ~= 0 then
            print("[busylight] failed exit=", code, "stderr=", err or "", "stdout=", out or "")
        end
    end, args)
    if not t:start() then
        print("[busylight] hs.task.new/start failed for", BUSYLIGHT)
    end
end

local function tick()
    push(anyCameraInUse())
end

-- fast path (optional): still nice when it works
local function watchCameras()
    if not hs.camera then return end
    for _, c in pairs(hs.camera.allCameras()) do
        c:setPropertyWatcherCallback(function()
            tick()
        end)
        pcall(function() c:startPropertyWatcher() end)
    end
end

if cameraPollTimer then cameraPollTimer:stop() end
cameraPollTimer = hs.timer.new(pollSeconds, tick)
cameraPollTimer:start()

watchCameras()
if hs.camera then
    hs.camera.setWatcherCallback(function()
        watchCameras()
        tick()
    end)
    hs.camera.startWatcher()
end

tick() -- initial paint
