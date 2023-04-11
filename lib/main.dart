// import 'dart:async';
// import 'dart:isolate';

// void main() async {
//   final receivePort = ReceivePort();
//   await Isolate.spawn(sum, receivePort.sendPort);

//   final sendPort = await receivePort.first;
//   final result = await compute(sendPort, [1, 2, 3, 4]);
//   print('Result: $result');
// }

// void sum(SendPort sendPort) {
//   final receivePort = ReceivePort();
//   sendPort.send(receivePort.sendPort);

//   receivePort.listen((data) {
//     final numbers = data as List<int>;
//     final result = numbers.reduce((value, element) => value + element);
//     sendPort.send(result);
//   });
// }

// Future<int> compute(SendPort sendPort, List<int> numbers) {
//   final receivePort = ReceivePort();
//   sendPort.send([numbers, receivePort.sendPort]);

//   return receivePort.first.then((data) => data as int);
// }

// import 'dart:isolate';

// @pragma('vm:entry-point')
// void spawnIsolate(SendPort port) async{
//   await Future.delayed(Duration(seconds: 5));
//   port.send('5 second');
// }

// void main() async{
//   var port = ReceivePort();
//   port.listen((msg) {
//     print("Received message from isolate $msg");
//   });
//   await Isolate.spawn(spawnIsolate, port.sendPort);
//   print('ss');
// }

import 'dart:isolate';

void main() async {
  // 첫 번째 isolate 실행
  print('Main Isolate 시작');
  await firstIsolate();

  // 두 번째 isolate 실행
  print('Main Isolate 시작');
  await secondIsolate();
}

Future<void> firstIsolate() async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(runInIsolate, receivePort.sendPort);
  final message = await receivePort.first;
  print('첫 번째 Isolate에서 받은 메시지: $message');
  isolate.kill(priority: Isolate.immediate);
}

Future<void> secondIsolate() async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(runInIsolate, receivePort.sendPort);
  final message = await receivePort.first;
  print('두 번째 Isolate에서 받은 메시지: $message');
  isolate.kill(priority: Isolate.immediate);
}

void runInIsolate(SendPort sendPort) {
  print('Isolate 시작');
  sendPort.send('Isolate에서 보낸 메시지');
}
