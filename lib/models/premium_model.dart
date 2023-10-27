// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive_flutter/adapters.dart';

part 'premium_model.g.dart';

@HiveType(typeId: 0)
class PremiumModel {
  @HiveField(0)
  int secilenValue = 0;
  PremiumModel(
     this.secilenValue,
  );

}
