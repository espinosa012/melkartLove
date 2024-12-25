--! file: collision_box.lua
CollisionBox = Object.extend(BaseEntity)

function CollisionBox.new(self)
    self.x = 0
    self.y = 0
    self.width = 0
    self.height = 0
end

function CollisionBox.checkCollision(self, collBox)
    return self.x + self.width > collBox.x
    and self.x < collBox.x + collBox.width
    and self.y + self.height > collBox.y
    and self.y < collBox.y + collBox.height
end