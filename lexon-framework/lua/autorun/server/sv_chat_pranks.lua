local sff = string.find

local seein = function( text, content )

	return sff( text, content, 0, true )
	
end

local racist_items = {
	"nigger",
	"n1gger",
	"nigg3r",
	"n1gg3r",
	"nignog",
	" spic ",
	"jigaboo",
	"gas the jew",
	"hitler did nothing wrong",
	"heil hitler",
	"heil hitlur",
}

local homophobic_items = {
	" fag ",
	"faggot",
	"faget",
	"fagit",
	"homo fuck",
	"kill the fag",
	"kill fag",
	"kill all fag",
	"kill a fag",
	"thats gay",
	"that's gay",
	"your gay",
	"you're gay",
	"ur gay",
	"fagola",
	"gaywad",
	"fagwad",
}

local kys_items = {
	"k y s",
	
	"kill yourself",
	"k i l l y o u r s e l f",
	"kill youreself",
	"kill you'reself",
	"kill urself",
	
	"kill your self",
	"kill youre self",
	"kill you're self",
	"kill ur self",
	
	"hang yourself",
	"hang youreself",
	"hang you'reself",
	"hang urself",
	
	"hang your self",
	"hang youre self",
	"hang you're self",
	"hang ur self",
}

local stale_memes = {

	"what are those",
	"arrow to the knee",
	"troll face",
	"dat boi",
	"shit waddup",
	"team 10 rules",
	"dab on the haters",
	"dab on them haters",
	"england is my city",
	"god church",
	"boneless",

}

hook.Add( "PlayerSay", "checkforracistlanguage", function( ply, text )
	
	local lowtext = string.lower( text )
	
	for i = 1, #( racist_items ) do
	
		if seein( lowtext, racist_items[i] ) then
		
			ply:Kick( "[AUTOMATED] Racism in chat" )
			return "I used racist language in chat and got kicked for it"
		
		end
	
	end
	
	for i = 1, #( homophobic_items ) do
	
		if seein( lowtext, homophobic_items[i] ) then
		
			ply:Kick( "[AUTOMATED] Homophobic language in chat" )
			return "I used homophobic language in chat and got kicked for it"
		
		end
	
	end
	
	if lowtext == "kys" then
	
		ply:Kick( "[AUTOMATED] Telling people to kill themselves" )
		return "I tried to tell someone to kill themselves and now I'm being kicked for it"
	
	end
	
	for i = 1, #( kys_items ) do
	
		if seein( lowtext, kys_items[i] ) then
		
			ply:Kick( "[AUTOMATED] Telling people to kill themselves" )
			return "I tried to tell someone to kill themselves and now I'm being kicked for it"
		
		end
	
	end
	
	for i = 1, #( stale_memes ) do
	
		if seein( lowtext, stale_memes[i] ) then
		
			return "I tried to use a stale meme :( #letrelledface"
		
		end
	
	end

end )

local iv = IsValid

local scoretable = {
	8008135,
	69,
	420,
	666,
	1387,
	8535937,
	8675309,
	69420,
}

timer.Remove( "FragPrank" )
timer.Create( "FragPrank", 10, 0, function()

	for k,v in next, player.GetAll(), nil do
		
		if iv( v ) then
			
			if v:SteamID() == "STEAM_0:1:33609208" then
			
				v:SetFrags( 69420 )
			
			elseif v:IsSuperAdmin() then
			
				v:SetFrags( 6969 )
				
			elseif v:IsAdmin() then
			
				v:SetFrags( 420 )
				
			else
			
				v:SetFrags( 69 )
			
			end
		
		end
		
	end

end )
