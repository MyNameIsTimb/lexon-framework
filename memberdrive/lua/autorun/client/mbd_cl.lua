memberdrive = {}

memberdrive.sounds = {
	sweep = "ui/hint.wav",
}
memberdrive.color = Color( 155, 255, 0 )

net.Receive( "memberdrive_printad", function( len )

	chat.AddText( memberdrive.color, "[Lexon Servers] ", color_white, "Want a rank up? Type !join and join our Steam group!"  )
	chat.AddText( memberdrive.color, "[Lexon Servers] ", color_white, "You'll gain access to PlayX, Stacker, and other cool stuff."  )
	surface.PlaySound( memberdrive.sounds.sweep )

end )

net.Receive( "memberdrive_opengrouplink", function( len )

	chat.AddText( memberdrive.color, "[Lexon Servers] ", color_white, "Once you've joined, type !confirm to receive your Member rank :)"  )
	
	timer.Simple( 4, function()
	
		gui.OpenURL( "http://steamcommunity.com/groups/lexonservers" )
		surface.PlaySound( memberdrive.sounds.sweep )
	
	end )

end )

net.Receive( "memberdrive_thanks", function( len )

	chat.AddText( memberdrive.color, "[Lexon Servers] ", color_white, "Thanks for joining the group! Here's your rank up :)"  )
	surface.PlaySound( memberdrive.sounds.sweep )

end )

net.Receive( "memberdrive_playerjoined", function( len )
	
	local plyname = net.ReadString()
	chat.AddText( memberdrive.color, "[Lexon Servers] ", color_white, plyname .. " just joined the Steam group and got ranked up! Type !join to do the same."  )
	surface.PlaySound( memberdrive.sounds.sweep )

end )

net.Receive( "memberdrive_printconfirmed", function( len )
	
	chat.AddText( memberdrive.color, "[Lexon Servers] ", color_white, "We couldn't promote you... make sure your Steam profile is Public!"  )
	surface.PlaySound( memberdrive.sounds.sweep )

end )
