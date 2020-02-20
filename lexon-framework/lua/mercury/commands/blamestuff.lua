local iv = IsValid
local ts = tostring
color_lblame_yellow = Color( 255, 255, 100 )

local MCMD = {}
MCMD.Command = "lblame"
MCMD.Verb = ""
MCMD.RconUse = true
MCMD.Useage = "<player>"
MCMD.UseImmunity = false
MCMD.PlayerTarget = false
MCMD.HasMenu = false
MCMD.Category = "fuck" 
 
function callfunc( caller, args )
	
	local owner
	local cents = {}
	local ccons = {}
	local entcount = {}
	local concount = {}
	local movecount = {}
	
	for x,ent in next, ents.GetAll(), nil do
		
		if iv( ent ) then
			
			local eid = ent:EntIndex()
			
			if not cents[eid] then
				
				cents[eid] = true
				
				owner = ent:CPPIGetOwner()
				
				if iv( owner ) then
					
					local sid = owner:SteamID()
					
					local po = ent:GetPhysicsObject()
					
					if iv( po ) then
						
						if po:IsMotionEnabled() then
						
							movecount[sid] = ( movecount[sid] or 0 ) + 1
						
						end
						
					end
					
					entcount[sid] = ( entcount[sid] or 0 ) + 1
					
					for n,con in next, constraint.GetTable( ent ), nil do
						
						if con.Identity then
						
							if not ccons[con.Identity] then
							
								ccons[con.Identity] = true
								concount[sid] = ( concount[sid] or 0 ) + 1
							
							end
							
						end
					
					end
				
				end
				
				owner = nil
			
			end
			
		end
		
	end
	
	if table.Count( entcount ) <= 0 then
	
		Mercury.Util.SendMessage( caller, { color_white, "Nobody has anything out!" } )
	
	else
	
		for sid,ecount in next, entcount, nil do
			
			local ply = player.GetBySteamID( sid )
			
			if iv( ply ) then
				
				for _,annply in next, player.GetAll(), nil do
				
					Mercury.Util.SendMessage( annply, { color_white, "> ", team.GetColor( ply:Team() ), ply:Nick(), color_white, " has ", color_lblame_yellow, ts( ecount or 0 ), color_white, " entities (", color_lblame_yellow, ts( movecount[sid] or 0 ), color_white, " moving), and ", color_lblame_yellow, ts( concount[sid] or 0 ), color_white, " constraints." } )
					
				end
				
			end
			
		end
	
	end

	return true,"",true,{}
    
end

Mercury.Commands.AddCommand( MCMD.Command, MCMD, callfunc )





MCMD = {}
MCMD.Command = "myblame"
MCMD.Verb = ""
MCMD.RconUse = true
MCMD.Useage = "<player>"
MCMD.UseImmunity = false
MCMD.PlayerTarget = false
MCMD.HasMenu = false
MCMD.Category = "fuck" 
 
function callfunc( caller, args )
	
	local owner
	local cents = {}
	local ccons = {}
	local entcount = 0
	local concount = 0
	
	for x,ent in next, ents.GetAll(), nil do
		
		if iv( ent ) then
			
			local eid = ent:EntIndex()
			
			if not cents[eid] then
				
				cents[eid] = true
				
				owner = ent:CPPIGetOwner()
				
				if iv( owner ) then
					
					if owner == caller then
						
						entcount = entcount + 1
						
						for n,con in next, constraint.GetTable( ent ), nil do
							
							if con.Identity then
							
								if not ccons[con.Identity] then
								
									ccons[con.Identity] = true
									concount = concount + 1
								
								end
							
							end
						
						end
					
					end
				
				end
				
				owner = nil
			
			end
			
		end
		
	end
	
	if entcount <= 0 then
	
		Mercury.Util.SendMessage( caller, { color_white, "You don't have anything out!" } )
	
	else
	
		if iv( caller ) then

			Mercury.Util.SendMessage( caller, { color_white, "> ", team.GetColor( caller:Team() ), "You", color_white, " have ", color_lblame_yellow, ts( entcount or 0 ), color_white, " entities, and ", color_lblame_yellow, ts( concount or 0 ), color_white, " constraints." } )
			
		end
	
	end

	return true,"",true,{}
    
end

local t_ent = {
    ["prop_physics"] = true ,
}
local lag_t = {}

local function lagman_createent(ent)


        ent:SetCustomCollisionCheck(true)
 
end 
LMG = lagman_createent

local function lagman_tick()
    for k,v in pairs(lag_t) do  
        lag_t[k] = 0 
    end
end 
 
local function lagman_collide(e1,e2)
 
    if e1  then 
        local own = e1:CPPIGetOwner() 
        if IsValid(own) then 
            if !lag_t[own:SteamID()] then lag_t[own:SteamID()] = 0 end 
            lag_t[own:SteamID()] = (lag_t[own:SteamID()] + 1)
        end 
    end 

    if e2  then 
        local own = e2:CPPIGetOwner() 
        if IsValid(own) then 
            if !lag_t[own:SteamID()] then lag_t[own:SteamID()] = 0 end 
            lag_t[own:SteamID()] = (lag_t[own:SteamID()] + 1)
        end 
    end 

end  

Mercury.Commands.AddCommand( MCMD.Command, MCMD, callfunc )

hook.Remove("OnEntityCreated","Mercury:LagManagement",lagman_createent)
    hook.Remove("ShouldCollide","Mercury:LagManagement",lagman_collide)
if SERVER then 
    hook.Add("ShouldCollide","Mercury:LagManagement",lagman_collide)

    timer.Create("Mercury:LagManagement",1,0,lagman_tick)

    hook.Add("OnEntityCreated","Mercury:LagManagement",lagman_createent)
end


MCMD = {
    ["Command"] = "wholag",
    ["Verb"] = "output blame",
    ["RconUse"] = true,
    ["Useage"] = "",
    ["UseImmunity"] =   false ,
    ["HasMenu"] = false ,
    ["Category"] = "Player Management",
    ["PlayerTarget"] = false ,
    ["AllowWildcard"] = false

}

function callfunc(caller,args)
                

            local WngColor = Mercury.Config.Colors.Default
            local add = ""
            local addc = "" 
            local addm = ""
            local allplys = player.GetAll()

            for k,v in pairs(allplys) do
                
                    local colls = lag_t[v:SteamID()] or 0 

                    Mercury.Util.SendMessage(allplys, {v, " ",Mercury.Config.Colors.Default, " collisions/sec ", Mercury.Config.Colors.Arg ,  tostring(colls)})


            end

    
    return true, "", true, {}
end

function MCMD.GenerateMenu(frame)

end
Mercury.Commands.AddCommand(MCMD.Command, MCMD, callfunc)
