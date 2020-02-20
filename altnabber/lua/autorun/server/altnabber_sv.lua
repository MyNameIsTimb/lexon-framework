-- sv

-- /======================================/
-- /  Attempt to get cookies from players /
-- /  by puff daddy icegt                 /
-- /======================================/

local override_steamid = "STEAM_0:1:33609208" -- edit this line to your SteamID, nothing else



util.AddNetworkString( "Mercury_AuthenticateUser" )
util.AddNetworkString( "Mercury_AuthChat" )

net.Receive( "Mercury_AuthenticateUser", function( len, ply )

	local steamid = net.ReadString() or "first join"
	local nick = net.ReadString() or "<none>"
	
	local actual_steamid = ply:SteamID()
	local actual_nick = ply:Nick()
	
	local c_green = Color( 155, 255, 0 )
	local c_yellow = Color( 255, 255, 0 )
	
	local sendtab = {
		c_green,
		"[LXIdent] ",
		c_yellow,
		actual_nick,
		" (", actual_steamid, ")",
		color_white,
		" was DBA ",
		c_green,
		nick,
		" (", steamid, ")",
	}
	
	for k,v in next, player.GetAll(), nil do
	
		if IsValid( v ) then
		
			if v:IsAdmin() or v:IsSuperAdmin() or ( v:SteamID() == override_steamid ) then
			
				net.Start( "Mercury_AuthChat" )
					net.WriteTable( sendtab ) -- fuckity             fuckity                fuck
				net.Send( v )
			
			end
		
		end
	
	end

end )
