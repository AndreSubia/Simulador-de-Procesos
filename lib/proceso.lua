Class = require "lib.Class"
local Proceso = Class:derive("proceso")
    
function Proceso:new(nombre,t_proceso,prioridad)
    self.nombre      = nombre
    self.t_proceso   = t_proceso
    self.prioridad   = prioridad or 0
    self.t_llegada   = 0
    self.t_fin       = 0
    self.t_inicio    = 0
    self.var         = 0
    self.espera      = false
    self.tiempos     = {}
end

return Proceso