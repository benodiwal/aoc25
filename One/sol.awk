#!/usr/bin/awk -f

function floor_div_100(x) {
    if (x >= 0) return int(x / 100)
    else return int((x - 99) / 100)
}

BEGIN {
    dial = 50
    password_1 = 0
    password_2 = 0
}

{
    text = $0
    dir = substr(text, 1, 1)
    val = substr(text, 2) + 0

    hits = 0
    start_pos = dial
    
    if (dir == "R") {
        end_pos = start_pos + val
        
        hits = floor_div_100(end_pos) - floor_div_100(start_pos)
        
        dial = end_pos
    } else if (dir == "L") {
        end_pos = start_pos - val
        
        hits = floor_div_100(start_pos - 1) - floor_div_100(end_pos - 1)
        
        dial = end_pos
    }

    password_2 += hits

    norm_dial = ((dial % 100) + 100) % 100

    if (norm_dial == 0) {
        password_1 += 1
    }
    
    dial = norm_dial
}

END {
    print password_1
    print password_2
}