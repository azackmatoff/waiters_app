import 'package:json_annotation/json_annotation.dart';

part 'waiter_model.g.dart';

@JsonSerializable()
class WaiterModel {
  final int id;
  final String? name;

  WaiterModel({required this.id, this.name});

  factory WaiterModel.fromJson(Map<String, dynamic> json) => _$WaiterModelFromJson(json);

  Map<String, dynamic> toJson() => _$WaiterModelToJson(this);
}
