--! file: timemanager.lua
_G.TimeManager = Object.extend(Object)

-- TODO: para gestionar el tiempo en el juego, timestamp, etc.
-- podemos pausar el paso del tiempo, acelerarlo, ralentizarlo, etc


function TimeManager.new(self, timeSpeed)
    if timeSpeed then self.timeSpeed = timeSpeed else self.timeSpeed = 1 end    -- determina cuanto se incementa el tiempo de juego por cada segundo (se multiplica por dt en update)
    self.currentTime = 0    -- si timeSpeed es 1, devuelve el número de segundos que el timer actual ha pasado activo
    self.isActive = false   -- el tiempo transcurre sólo mientras se encuentre activo
end

function TimeManager.incTimeSpeed(self, inc)
    self.timeSpeed = self.tiemSpeed + inc
end

function TimeManager.setTmeSpeed(self, value)
    self.timeSpeed = value
end

function TimeManager.start(self)
    self.isActive = true
end

function TimeManager.pause(self)
    self.isActive = false
end

function TimeManager.togglePause(self)
    self.isActive = not self.isActive
end

function TimeManager.stop(self)
    -- TODO
end

function TimeManager.update(self, dt)
    if not self.isActive then return end
    -- TODO
    self:incTime(self.timeSpeed * dt)
end

function TimeManager.incTime(self, inc)
    self.currentTime = self.currentTime + inc
end

