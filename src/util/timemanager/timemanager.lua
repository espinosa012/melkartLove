--! file: timemanager.lua
_G.TimeManager = Object.extend(Object)

-- TODO: para gestionar el tiempo en el juego, timestamp, etc.
-- podemos pausar el paso del tiempo, acelerarlo, ralentizarlo, etc


function TimeManager.new(self, timeSpeed, startingTime, unitTime, hourDuration)
    if timeSpeed then self.timeSpeed = timeSpeed else self.timeSpeed = 1 end    -- determina cuanto se incementa el tiempo de juego por cada segundo (se multiplica por dt en update)
    if unitTime then self.unitTime = unitTime else self.unitTime = 60 end  -- nuimero flotante. determina cuánto tiene que incrementarse currentTime para consederar que ha transcurrido una unida de tiempo del juego (equivaldría a minuto)
    if hourDuration then self.hourDuration = hourDuration else self.hourDuration = 60 end  -- determina el número de unidades de tiempo de duración de una hora, es decir, cuantas unidades de tiempo tienen que trasncurrir para considerar que ha pasado una hora    
    if startingTime then self.currentTime = startingTime else self.currentTime = 0 end  -- si timeSpeed es 1, currentTime devuelve el número de segundos que el timer actual ha pasado activo

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

-- Getting time
function TimeManager.getCurrentUnitsTime(self)
    return self.currentTime / self.unitTime
end

function TimeManager.getHours(self)
    return self:getCurrentUnitsTime() / self.hourDuration
end

function TimeManager.getDays(self)
    local hoursPerDay = 24
    return self:getHours() / hoursPerDay
end