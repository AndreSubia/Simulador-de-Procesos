Class = require "lib.Class"
local Caja = Class:derive("caja")
    
function Caja:new(x,y,w,h)
    self.x = x
    self.y =  y
    self.width = w
    self.height = h
    self.text = ''
    self.active = false
    self.colors = {
        background = { 0.5, 0.5, 0.5,0.5},
        text = { 1, 1, 1, 1 }
    }
end

function Caja:draw()
    love.graphics.setColor(unpack(self.colors.background))
    love.graphics.rectangle('fill',
        self.x, self.y,
        self.width, self.height)

    love.graphics.setColor(unpack(self.colors.text))
    love.graphics.printf(self.text,
        self.x, self.y,
        self.width)
    if( self.active ) then
        love.graphics.print("|",self.x,self.y)
    end
end

function Caja:textinput (text)
    if self.active then
        self.text = self.text .. text
    end
end

function Caja:mousepressed (x, y, l)
    if
        x >= self.x and
        x <= self.x + self.width and
        y >= self.y and 
        y <= self.y + self.height 
    then
        self.active = true
    elseif self.active then
        self.active = false
    end
  
end


return Caja