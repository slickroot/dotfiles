local butler = {}
function butler.colorize_text(text, color) 
    return '<span foreground="'..color..'">'..text..'</span>'
end

return butler
