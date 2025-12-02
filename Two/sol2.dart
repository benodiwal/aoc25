import 'dart:io';

bool isInvalidId(BigInt id) {
  String s = id.toString();
  OUTER:
  for (int i = 2; i <= s.length; i++) {
    if (s.length % i != 0) {
      continue;
    }
    int div = s.length ~/ i;
    String firstPart = s.substring(0, div);

    for (int j = div; j < s.length; j += div) {
      String nextPart = s.substring(j, j + div);
      if (nextPart != firstPart) {
        continue OUTER;
      }
    }
    return true;
  }

  return false;
}

void main() async {
  final filePath = 'input.txt';
  final file = File(filePath);

  if (!await file.exists()) {
    return;
  }

  String content = await file.readAsString();
  content = content.replaceAll('\n', '').trim();

  if (content.isEmpty) {
    return;
  }

  List<String> rangeStrings = content.split(',');
  BigInt totalSum = BigInt.zero;

  for (var range in rangeStrings) {
    List<String> parts = range.trim().split('-');
    if (parts.length != 2) continue;

    BigInt start = BigInt.parse(parts[0]);
    BigInt end = BigInt.parse(parts[1]);

    BigInt current = start;
    while (current <= end) {
      if (isInvalidId(current)) {
        totalSum += current;
      }
      current += BigInt.one;
    }
  }

  print(totalSum);
}
