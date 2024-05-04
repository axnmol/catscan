import 'package:uuid/uuid.dart';

String getUniqueId() {
  const uuid = Uuid();
  return uuid.v1();
}
