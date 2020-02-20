-- prevent ragdolled and gilded people from spawning shit

local CanSpawnThat = function( ply, ... )

	if IsValid( ply.RagREnt ) then
		
		ply:ChatPrint( "You're not allowed to spawn stuff right now." )
		return false
	
	end

end

local hookstoadd = {
	"PlayerSpawnEffect",
	"PlayerSpawnNPC",
	"PlayerSpawnObject",
	"PlayerSpawnProp",
	"PlayerSpawnRagdoll",
	"PlayerSpawnSENT",
	"PlayerSpawnSWEP",
	"PlayerSpawnVehicle",
}

for k,v in next, hookstoadd, nil do

	hook.Remove( v, "golder_" .. v )
	hook.Add( v, "golder_" .. v, CanSpawnThat )

end

local blacklistedprops = {
	["models/props_c17/oildrum001_explosive.mdl"] = true,
	["models/props_buildings/row_res_1_fullscale.mdl"] = true,
	["models/props_buildings/row_res_2_ascend_fullscale.mdl"] = true,
	["models/props_buildings/row_res_2_fullscale.mdl"] = true,
	["models/props_buildings/row_corner_1_fullscale.mdl"] = true,
	["models/props_buildings/building_002a.mdl"] = true,
	["models/props_phx/amraam.mdl"] = true,
	["models/props_phx/ww2bomb.mdl"] = true,
	["models/props_hightower_event/underworld_sky.mdl"] = true,
	["models/props_urban/urban_skybuildings.mdl"] = true,
	["models/props_hightower_event/underworld_lava.mdl"] = true,
	["models/props_gulch/lavacanal.mdl"] = true,
	["models/magnum/road1.mdl"] = true,
	["models/magnum/road2.mdl"] = true,
	["models/magnum/road3.mdl"] = true,
	["models/magnum/road4.mdl"] = true,
	["models/magnum/road5.mdl"] = true,
	["models/magnum/road6.mdl"] = true,
	["models/magnum/road7.mdl"] = true,
	["models/magnum/road8.mdl"] = true,
	["models/props_gulch/dirtroad.mdl"] = true,
	["models/props_gulch/gulchroad1.mdl"] = true,
	["models/props_gulch/gulchroad2.mdl"] = true,
	["models/props_gulch/gulchroad3.mdl"] = true,
	["models/props_gulch/roadtunnelcurve.mdl"] = true,
}

hook.Add( "PlayerSpawnProp", "blacklist_certain_props", function( ply, model )

	if blacklistedprops[model] then
	
		ply:ChatPrint( "That prop is blacklisted." )
		
		for k,v in next, player.GetAll(), nil do
		
			if v:IsAdmin() then
			
			--	v:ChatPrint( ply:Nick() .. " tried to spawn a blacklisted prop: " .. model )
			
			end
		
		end
		
		return false
	
	end
	
end )
