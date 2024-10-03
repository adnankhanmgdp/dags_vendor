import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_detail_notifier.g.dart';

@Riverpod(keepAlive: true)
class OrderDetailNotifier extends _$OrderDetailNotifier {

  @override
  int build() {
    return 0;
  }

  void changeState(int value)
  {
    state=value;
  }

}
