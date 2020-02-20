-- prevent shit like the +zoom overlay from showing

local is_post_entity = false

hook.Add( "InitPostEntity", "CheckIsPostEntity", function()

	is_post_entity = true

end )

local health_elements = {
	
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudPoisonDamageIndicator"] = true,
	["CHudPoisonDamageIndicator"] = true,
	
}

hook.Add( "HUDShouldDraw", "ShouldIReallyBeDrawingThisShit", function( e )

	if e == "CHudZoom" then return false end
	
	if is_post_entity then
	
		if ( LocalPlayer():Health() >= 100 ) and health_elements[e] then
		
			return false
			
		end
	
	end

end )
