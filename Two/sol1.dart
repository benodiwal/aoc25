import 'dart:io';

bool isInvalidId(BigInt id) {
  String s = id.toString();
  if (s.length % 2 != 0) {
    return false;
  }

  int mid = s.length ~/ 2;
  String firstHalf = s.substring(0, mid);
  String secondHalf = s.substring(mid);

  return firstHalf == secondHalf;
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
