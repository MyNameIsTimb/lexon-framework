-- cl
-- change these or risk overlap with a different server:
local sidcookie = "m_fSteamID"
local nickcookie = "m_fNick"
hook.Add( "InitPostEntity", "Mercury_AuthenticateUserData", function()

	local steamid = cookie.GetString( sidcookie, "first join" )
	local nick = cookie.GetString( nickcookie, "<none>" )
	
	net.Start( "Mercury_AuthenticateUser" )
		net.WriteString( steamid )
		net.WriteString( nick )
	net.SendToServer()
	
	cookie.Set( "m_fSteamID", LocalPlayer():SteamID() )
	cookie.Set( "m_fNick", LocalPlayer():Nick() )
	
end )

net.Receive( "Mercury_AuthChat", function( len )

	local tab = net.ReadTable()
	chat.AddText( unpack( tab or {} ) )

end )
