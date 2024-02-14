import '../../state_machines/trans.dart';
import '../../state_machines/transaction.dart';
import '../events/event.dart';

class State {
  final Map<Type, Transaction> _transactions = <Type, Transaction>{};
//  Constructor
  State (List<Trans> pairs) {
    for (int i = 0; i < pairs.length; i++) {
      Trans pair = pairs[i];
      _transactions[pair.event().runtimeType] = Transaction(pair.state(), pair.method());
    }
  }

  Map<Type, Transaction> transactions() {
    return _transactions;
  }

  Transaction? transaction(Event event) {
    return _transactions[event.runtimeType];
  }

  int size() {
    return _transactions.length;
  }

}