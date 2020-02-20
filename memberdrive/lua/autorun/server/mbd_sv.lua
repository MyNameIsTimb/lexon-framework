util.AddNetworkString( "memberdrive_printad" )
util.AddNetworkString( "memberdrive_opengrouplink" )
util.AddNetworkString( "memberdrive_printconfirmed" )
util.AddNetworkString( "memberdrive_thanks" )
util.AddNetworkString( "memberdrive_playerjoined" )

memberdrive = memberdrive or {}

memberdrive.ismember = function( ply )

	if IsValid( ply ) then

		return not ( ply:GetUserGroup() == "default" )
	
	end
	
	return true

end

memberdrive.promote = function( ply )

	if IsValid( ply ) then
		
		local sid = ply:SteamID()
		
		local found = false
		
		for k,v in next, player.GetAll(), nil do
		
			local nick = v:Nick()
			
			if string.find( nick, sid, 1, true ) then
			
				found = true
				break
			
			end
		
		end
		
		if not found then
		
			RunConsoleCommand( "hgs", "setrank", sid, "member" )
		
		end
	
	end

end

memberdrive.checkmembership = function( sid64 )
	
	local ply = player.GetBySteamID64( sid64 )
	
	http.Fetch( "https://www.steamcommunity.com/profiles/" .. sid64 .. "/groups/", function( body, len, headers, code )
	
		if string.find( body, "<a class=\"linkTitle\" href=\"https://steamcommunity.com/groups/lexonservers\">Lexon Servers</a><span class=\"pubGroup\">", 1, true ) then
			
			if IsValid( ply ) then
			
				memberdrive.promote( ply )
				
				net.Start( "memberdrive_thanks" )
				net.Send( ply )
				
				for k,v in next, player.GetAll(), nil do
					
					if IsValid( v ) then
					
						if not ( v:SteamID() == ply:SteamID() ) then
							
							if not memberdrive.ismember( v ) then
							
								net.Start( "memberdrive_playerjoined" )
									net.WriteString( ply:Nick() )
								net.Send( v )
							
							end
						
						end
					
					end
				
				end
			
			end
		
		else
			
			if IsValid( ply ) then
			
				net.Start( "memberdrive_printconfirmed" )
				net.Send( ply )
			
			end
		
		end
	
	end )

end

hook.Add( "PlayerSay", "memberdrive_sayhook", function( ply, text, isteam )

	if IsValid( ply ) then
	
		if ( text == "!group" ) or ( text == "!join" ) or ( text == "!rank" ) or ( text == "!promote" ) then
		
			net.Start( "memberdrive_opengrouplink" )
			net.Send( ply )
			return ""
		
		elseif text == "!confirm" then
		
			if not memberdrive.ismember( ply ) then
			
				memberdrive.checkmembership( ply:SteamID64() )
			
			end
			
			return ""
		
		end
	
	end

end )

hook.Add( "PlayerInitialSpawn", "memberdrive_sendad", function( ply )

	timer.Simple( 5, function()
		
		if IsValid( ply ) then
		
			if not memberdrive.ismember( ply ) then
			
				net.Start( "memberdrive_printad" )
				net.Send( ply )
			
			end
		
		end
	
	end )

end )
