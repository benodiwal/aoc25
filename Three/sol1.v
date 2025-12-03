import os

fn max_joltage(s string) int {
    mut max_j := 0
    
    for i in 0 .. s.len {
        for j in i + 1 .. s.len {
			digit_1 := int(s[i] - 48)
            digit_2 := int(s[j] - 48)
            
            current_val := (digit_1 * 10) + digit_2
            
            if current_val > max_j {
                max_j = current_val
            }
        }
    }
    return max_j
}

fn main() {
	content := os.read_lines('input.txt') or {
		eprintln('Failed to read file: $err')
		return
	}
	mut output := 0
	for _, s in content {
		if s.trim_space() == '' { continue }
		output += max_joltage(s)		
	}

	println(output)
}