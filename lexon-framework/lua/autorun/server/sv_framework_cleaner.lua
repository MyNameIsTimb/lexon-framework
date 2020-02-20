--[[
	
	Ice_RemoveRandomThrusters timer:
	This will run every 30 seconds and clean up gmod_thruster entities with no prop protection.

]]

timer.Create( "Ice_RemoveRandomThrusters", 30, 0, function()

    local thruster_owner
    
    for k,v in next, ents.GetAll(), nil do
        
        if IsValid( v ) then
        
            if v:GetClass() == "gmod_thruster" then
                
                thruster_owner = nil
                
                if v.CPPIGetOwner then
                
                    thruster_owner = v:CPPIGetOwner()
                
                end
                
                if not IsValid( thruster_owner ) then
                
                    SafeRemoveEntity( v )
                
                end
            
            end
        
        end
    
    end

end )


