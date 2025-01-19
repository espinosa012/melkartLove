EventHandler = Object.extend(Object)

-- Para la gestión de eventos
-- Ejemplo
--  eventHandler:addEvent("on_space_pressed")           -> registramos el evento en este handler añadimos el evento 
--  eventHandler:hook("on_space_pressed", spaceEvent)   -> asociamos dicho evento con una función (puede recibir los argumentos que quiera)
--  eventHandler:invoke("on_space_pressed", ...)        -> llamamos a invoke, pasándole el evento, que debe estar registrado, 
                                                        -- y todos los argumentos que reciba la funicón con que lo hemos asociado

function EventHandler.new(self)
    self.handlers = {}
end

function EventHandler.indexOf(self, eventTable, callback)
    if (eventTable == nil or callback == nil) then return nil end
    for i=1, #eventTable do
        if eventTable[i] == callback then return i end
    end
    return nil
end

-- add new event type
function EventHandler.addEvent(self, eventType)
    assert(self.handlers[eventType] == nil, "Event type "..eventType.." already defined.")
    self.handlers[eventType] = {}
end

-- remove event type
function EventHandler.removeEvent(self, eventType)
    assert(self.handlers[eventType] ~= nil, "Event type "..eventType.." is not defined.")
    self.handlers[eventType] = nil
end

-- subscribe to an event
function EventHandler.hook(self, eventType, callback)
    assert(type(callback) == "function", "Parameter 'callback' must be a function.")
    assert(self.handlers[eventType] ~= nil, "Event type "..eventType.." is not defined.")
    assert(self:indexOf(self.handlers[eventType], callback) == nil, "Callback function "..tostring(callback).." is already registered")
    local tbl = self.handlers[eventType]
    tbl[#tbl + 1] = callback
end

function EventHandler.unhook(self, eventType, callback)
    assert(type(callback) == "function", "Parameter 'callback' must be a function.")
    if self.handlers[eventType] == nil then return end
    local index = self:indexOf(self.handlers[eventType], callback)

    if index ~= nil then
        table.remove(self.handlers[eventType], index)
    end
end

function EventHandler.invoke(self, eventType, ...)
    assert(self.handlers[eventType] ~= nil, "Could no invoke event of type "..eventType.." because is not defined")
    local tbl = self.handlers[eventType]
    for i = 1, #tbl do
        tbl[i](...)
    end
end