import os

fn max_joltage(s string, k int) i64 {
	if s.len < k { return s.i64() }
	mut stack := []u8{cap: k}
	n := s.len

	for i in 0 .. n {
		a := s[i]
		for (stack.len > 0) && (a > stack.last()) && (stack.len - 1 + n - i >= k) {
			stack.delete_last()
		}

		if stack.len < k {
			stack << a
		}
	}

	return stack.bytestr().i64()
}

fn main() {
	content := os.read_lines('input.txt') or {
		eprintln('Failed to read file: $err')
		return
	}
	mut output := i64(0)
	for _, s in content {
		if s.trim_space() == '' { continue }
		output += max_joltage(s, 12)		
	}

	println(output)
}