local Planificacion_FCFS = require("FCFS")
local Planificacion_SJF  = require("SJF")
local Planificacion_SRT  = require("SRT")
local Planificacion_HPF  = require("HPF")
local Planificacion_RB   = require("R_ROBIN")


local Proceso    = require("lib.proceso")
local Caja       = require("lib.caja")

local FCFS = Planificacion_FCFS()
local SJF  = Planificacion_SJF()
local SRT  = Planificacion_SRT()
local HPF  = Planificacion_HPF()
local RB   = Planificacion_RB()


local P

pausa = true

PLANIFICADOR = io.read()

function love.update(dt) 

    if PLANIFICADOR == "FCFS" or "SJF" or "SRT" then

        if (PLANIFICADOR == "FCFS") then
            P = FCFS
        elseif (PLANIFICADOR == "SJF") then
            P = SJF
        elseif (PLANIFICADOR == "SRT") then
            P = SRT
        end
        

        local Nombre = Caja(220,10,100,20)
        local Duracion = Caja(420,10,100,20)

        function love.load()
            love.keyboard.setTextInput(true)
            love.keyboard.setKeyRepeat(true)
        end


        function love.update(dt)
            P:update(dt)
        end

        function love.keypressed( key )
            if key == "return" then
                local temp a = Nombre.text
                local temp b = tonumber(Duracion.text)
                if ( type(b) ~= nil and type(b) == "number" ) then
                    local temp = Proceso(a,b)
                    temp.t_llegada = tiempo_real
                    P:agregar_proceso(temp)
                else
                    Duracion.text = ''
                end
            end

            if key == "p" then
                pausa = not pausa
            end

            if key == "l" then
                P.procesos = {}
                P.procesos_graf = {}
                tiempo_real = 0
            end

            if key == "backspace" then
                Nombre.text = ''
                Duracion.text = '' 
            end
        end

        function love.draw()
            P:draw()
            Nombre:draw()
            Duracion:draw()
            love.graphics.print("Nombre: ",160,10)
            love.graphics.print("T.Ejecucion: ",340,10)
        end

        function love.textinput (text)
            Nombre:textinput(text)
            Duracion:textinput(text)
        end


        function love.mousepressed (x, y, l)
            Nombre:mousepressed(x,y,l)
            Duracion:mousepressed(x,y,l)
        end 
    end

    if PLANIFICADOR == "HPF" then
        local Nombre = Caja(220,10,60,20)
        local Duracion = Caja(380,10,60,20)
        local Prioridad = Caja(520,10,60,20)

        function love.load()
            love.keyboard.setTextInput(true)
            love.keyboard.setKeyRepeat(true)
        end


        function love.update(dt)
            HPF:update(dt)
        end

        function love.keypressed( key )
            if key == "return" then
                local temp a = Nombre.text
                local temp b = tonumber(Duracion.text)
                local temp c = tonumber(Prioridad.text)
                if ( type(b) ~= nil and type(b) == "number" and type(c) ~= nil and type(c) == "number" ) then
                    local temp = Proceso(a,b,c)
                    temp.t_llegada = tiempo_real
                    HPF:agregar_proceso(temp)
                else
                    Duracion.text = ''
                    Prioridad.text = ''
                end
            end

            if key == "p" then
                pausa = not pausa
            end

            if key == "l" then
                HPF.procesos = {}
                HPF.procesos_graf = {}
                tiempo_real = 0
            end

            if key == "backspace" then
                Nombre.text = ''
                Duracion.text = '' 
                Prioridad.text = '' 
            end
        end

        function love.draw()
            HPF:draw()
            Nombre:draw()
            Duracion:draw()
            Prioridad:draw()
            love.graphics.print("Nombre: ",160,10)
            love.graphics.print("T.Ejecucion: ",300,10)
            love.graphics.print("Prioridad: ",455,10)
        end

        function love.textinput (text)
            Nombre:textinput(text)
            Duracion:textinput(text)
            Prioridad:textinput(text)
        end


        function love.mousepressed (x, y, l)
            Nombre:mousepressed(x,y,l)
            Duracion:mousepressed(x,y,l)
            Prioridad:mousepressed(x,y,l)
        end 
    end

    if PLANIFICADOR == "RB" then
        
        qu_ = io.read()
        RB.quantum = tonumber(qu_) 

        local Nombre = Caja(220,10,100,20)
        local Duracion = Caja(420,10,100,20)

        function love.load()
            love.keyboard.setTextInput(true)
            love.keyboard.setKeyRepeat(true)
        end


        function love.update(dt)
            RB:update(dt)
        end

        function love.keypressed( key )
            if key == "return" then
                local temp a = Nombre.text
                local temp b = tonumber(Duracion.text)
                if ( type(b) ~= nil and type(b) == "number" ) then
                    local temp = Proceso(a,b)
                    temp.t_llegada = tiempo_real
                    RB:agregar_proceso(temp)
                else
                    Duracion.text = ''
                end
                
            end

            if key == "p" then
                pausa = not pausa
            end

            if key == "l" then
                RB.procesos = {}
                RB.procesos_graf = {}
                tiempo_real = 0
            end

            if key == "backspace" then
                Nombre.text = ''
                Duracion.text = '' 
            end
        end

        function love.draw()
            RB:draw()
            Nombre:draw()
            Duracion:draw()
            love.graphics.print("Nombre: ",160,10)
            love.graphics.print("T.Ejecucion: ",340,10)   
        end

        function love.textinput (text)
            Nombre:textinput(text)
            Duracion:textinput(text)
        end


        function love.mousepressed (x, y, l)
            Nombre:mousepressed(x,y,l)
            Duracion:mousepressed(x,y,l)
        end 
    end
end