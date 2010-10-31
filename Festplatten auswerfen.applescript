set errorcount to 0
try
	tell application "Finder"
		if exists "FreeAgent" then
			eject "FreeAgent"
		end if
	end tell
on error
	set errorcount to (errorcount + 1)
end try
 
try
	tell application "Finder"
		if exists "MiniMax" then
			eject "MiniMax"
		end if
	end tell
on error
	set errorcount to (errorcount + 1)
end try
 
if errorcount is greater than "0" then
	if errorcount is equal to 1 then
		display dialog ¬
			"Error: 1 Volume was not ejected" buttons {"OK"} ¬
			default button 1 with icon caution giving up after 10
	else
		display dialog ¬
			"Error: " & errorcount & ¬
			" Volumes were not ejected" buttons {"OK"} ¬
			default button 1 with icon caution giving up after 10
	end if
end if