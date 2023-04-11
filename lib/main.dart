import 'dart:isolate';

@pragma('vm:entry-point')
void spawnIsolate(SendPort port) {
  port.send("Hello!");
}

void main() {
  var port = ReceivePort();
  port.listen((msg) {
    print("Received message from isolate $msg");
  });
  var isolate = Isolate.spawn(spawnIsolate);
}

// import 'dart:isolate';

// void main() async {
//   // 첫 번째 isolate 실행
//   print('Main Isolate 시작');
//   await firstIsolate();

//   // 두 번째 isolate 실행
//   print('Main Isolate 시작');
//   await secondIsolate();
// }

// Future<void> firstIsolate() async {
//   final receivePort = ReceivePort();
//   final isolate = await Isolate.spawn(runInIsolate, receivePort.sendPort);
//   final message = await receivePort.first;
//   print('첫 번째 Isolate에서 받은 메시지: $message');
//   isolate.kill(priority: Isolate.immediate);
// }

// Future<void> secondIsolate() async {
//   final receivePort = ReceivePort();
//   final isolate = await Isolate.spawn(runInIsolate, receivePort.sendPort);
//   final message = await receivePort.first;
//   print('두 번째 Isolate에서 받은 메시지: $message');
//   isolate.kill(priority: Isolate.immediate);
// }

// void runInIsolate(SendPort sendPort) {
//   print('Isolate 시작');
//   sendPort.send('Isolate에서 보낸 메시지');
// }
