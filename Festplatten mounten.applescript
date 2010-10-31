set v to "afp://192.168.0.2/Hard Drive 2"
--set v to "afp://host-name.local/Hard Drive 2"
tell application "Finder"
	mount volume v ¬
		as user name ¬
		"daniel" with password ¬
		"diddlmaus"
end tell