Class            = require "lib.Class"
local Procesador = Class:derive("R_ROBIN")
local tiempo = 0
tiempo_real = 0

function Procesador:new()
    self.procesos = {}
    self.procesos_graf = {}
    self.quantum = 2
end

function Procesador:agregar_proceso(nuevo_proceso)
    table.insert( self.procesos,nuevo_proceso)
end

local primero = true

local i = 1
local q = 0

function Procesador:update(dt) 

    if pausa == false then

        if tiempo > 1 then
            
            if #self.procesos == 0 then

                q = 0 
                primero = true
            end

            if(  q == self.quantum and #self.procesos ~= 0 ) then 
                --table.insert( self.procesos[i].tiempos , tiempo_real + 1)
                --print("T1: "..tiempo_real+1)
                
                if( self.procesos[i+1] == nil ) then
                    --print("T2: "..tiempo_real)
                    i = 1
                    
                    
                else
                    i = i + 1
                    if( self.procesos[i].espera == false ) then
                        self.procesos[i].t_inicio = tiempo_real
                        self.procesos[i].espera = true
                    end
                end 
                q = 0
            end
            
            if self.procesos[i] ~= nil then
                if (#self.procesos ~= 0) then
                    if primero == true and self.procesos[i].espera == false then
                        (self.procesos[i]).t_inicio = (self.procesos[i]).t_llegada
                        primero = false
                    end

                    if ( (self.procesos[i]).t_proceso-1 == (self.procesos[i]).var ) then
                        self.procesos[i].t_fin = tiempo_real + 1
                        table.insert( self.procesos_graf,self.procesos[i])
                        table.remove(self.procesos,i)
                        if ( #self.procesos == 0 ) then
                            q = 0
                        else
                            q = q + 1
                        end
                    else
                        
                        if (q == 0) then
                            table.insert( self.procesos[i].tiempos , tiempo_real )
                        end
                        q = q + 1
                        self.procesos[i].var = self.procesos[i].var + 1
                    end
                else
                    q = 0
                end
            end
            tiempo = 0
            tiempo_real = tiempo_real + 1;
        end
        tiempo = tiempo + dt
    end

end



function Procesador:draw()
    cont_y2 = 580
    cont_x  = 10
    cont_y  = 60
    cont_x2 = 50
    cont_y3 = 570
    cont_x3 = 0

    if #self.procesos == 0 then
        love.graphics.print("NO HAY PROCESOS",love.graphics.getWidth()/2-60,cont_y)
    end
    
    if #self.procesos ~= 0 then
        love.graphics.print("NOMBRE        DURACION        T.LLEGADA        EJECUTANDO",10,40)
        for k,v in pairs(self.procesos) do
            love.graphics.print(v.nombre,cont_x,cont_y)
            love.graphics.print(v.t_proceso - v.var,cont_x+100,cont_y)
            love.graphics.print(v.t_llegada,cont_x+200,cont_y)
            cont_y = cont_y + 15
            --love.graphics.setColor(1,0.38,0.27)
            love.graphics.rectangle("line",cont_x+280,cont_y-15,v.t_proceso*5,5)
            love.graphics.rectangle("fill",cont_x+280,cont_y-15,v.var*5,5)
            --love.graphics.setColor(1, 1, 1)
        end
    end

    if #self.procesos_graf ~= 0 then
        for k,v in pairs(self.procesos_graf) do
            love.graphics.print(v.nombre,5,cont_y3-10)
            love.graphics.setColor(0.45, 1, 0.2)
            for k1,v1 in pairs (v.tiempos) do
                if  v.t_fin - v1 < self.quantum then
                    love.graphics.rectangle("fill",v1*10+20,cont_y3,( v.t_fin - v1)*10,5)
                else
                    love.graphics.rectangle("fill",v1*10+20,cont_y3,self.quantum*10,5)
                end
                love.graphics.print("|"..v.t_fin,v.t_fin*10+20,cont_y2)
                love.graphics.print("|"..v1,v1*10+20,cont_y2)
            end

            love.graphics.setColor(1,1,1)
            cont_y3 = cont_y3 - 20
        end
    end
    
    love.graphics.setColor(0.97,0.95,0.2)
    love.graphics.print("Segundo actual: "..tiempo_real,10,10)
end

return Procesador
