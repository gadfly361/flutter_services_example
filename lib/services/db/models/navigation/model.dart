import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class NavigationState {
  final int bottomNavigationBarIndex;

  NavigationState({
    @required this.bottomNavigationBarIndex,
  });

  NavigationState copyWith({int bottomNavigationBarIndex}) {
    return NavigationState(
        bottomNavigationBarIndex:
            bottomNavigationBarIndex ?? this.bottomNavigationBarIndex);
  }

  static NavigationState initialState() {
    return NavigationState(bottomNavigationBarIndex: 0);
  }

  // boilerplate

  factory NavigationState.fromJson(Map<String, dynamic> json) =>
      _$NavigationStateFromJson(json);

  Map<String, dynamic> toJson() => _$NavigationStateToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationState &&
          runtimeType == other.runtimeType &&
          bottomNavigationBarIndex == other.bottomNavigationBarIndex;

  @override
  int get hashCode => bottomNavigationBarIndex.hashCode;
}
