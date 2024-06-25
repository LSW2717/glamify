// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_matching_button_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeMatchingButtonViewModelHash() =>
    r'69ae031696e63a5bc168af5e596133a4a336136f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$HomeMatchingButtonViewModel extends BuildlessNotifier<bool> {
  late final List<AnimationController> controllers;
  late final List<Animation<double>> animations;

  bool build(
    List<AnimationController> controllers,
    List<Animation<double>> animations,
  );
}

/// See also [HomeMatchingButtonViewModel].
@ProviderFor(HomeMatchingButtonViewModel)
const homeMatchingButtonViewModelProvider = HomeMatchingButtonViewModelFamily();

/// See also [HomeMatchingButtonViewModel].
class HomeMatchingButtonViewModelFamily extends Family<bool> {
  /// See also [HomeMatchingButtonViewModel].
  const HomeMatchingButtonViewModelFamily();

  /// See also [HomeMatchingButtonViewModel].
  HomeMatchingButtonViewModelProvider call(
    List<AnimationController> controllers,
    List<Animation<double>> animations,
  ) {
    return HomeMatchingButtonViewModelProvider(
      controllers,
      animations,
    );
  }

  @override
  HomeMatchingButtonViewModelProvider getProviderOverride(
    covariant HomeMatchingButtonViewModelProvider provider,
  ) {
    return call(
      provider.controllers,
      provider.animations,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'homeMatchingButtonViewModelProvider';
}

/// See also [HomeMatchingButtonViewModel].
class HomeMatchingButtonViewModelProvider
    extends NotifierProviderImpl<HomeMatchingButtonViewModel, bool> {
  /// See also [HomeMatchingButtonViewModel].
  HomeMatchingButtonViewModelProvider(
    List<AnimationController> controllers,
    List<Animation<double>> animations,
  ) : this._internal(
          () => HomeMatchingButtonViewModel()
            ..controllers = controllers
            ..animations = animations,
          from: homeMatchingButtonViewModelProvider,
          name: r'homeMatchingButtonViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$homeMatchingButtonViewModelHash,
          dependencies: HomeMatchingButtonViewModelFamily._dependencies,
          allTransitiveDependencies:
              HomeMatchingButtonViewModelFamily._allTransitiveDependencies,
          controllers: controllers,
          animations: animations,
        );

  HomeMatchingButtonViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.controllers,
    required this.animations,
  }) : super.internal();

  final List<AnimationController> controllers;
  final List<Animation<double>> animations;

  @override
  bool runNotifierBuild(
    covariant HomeMatchingButtonViewModel notifier,
  ) {
    return notifier.build(
      controllers,
      animations,
    );
  }

  @override
  Override overrideWith(HomeMatchingButtonViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: HomeMatchingButtonViewModelProvider._internal(
        () => create()
          ..controllers = controllers
          ..animations = animations,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        controllers: controllers,
        animations: animations,
      ),
    );
  }

  @override
  NotifierProviderElement<HomeMatchingButtonViewModel, bool> createElement() {
    return _HomeMatchingButtonViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeMatchingButtonViewModelProvider &&
        other.controllers == controllers &&
        other.animations == animations;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, controllers.hashCode);
    hash = _SystemHash.combine(hash, animations.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HomeMatchingButtonViewModelRef on NotifierProviderRef<bool> {
  /// The parameter `controllers` of this provider.
  List<AnimationController> get controllers;

  /// The parameter `animations` of this provider.
  List<Animation<double>> get animations;
}

class _HomeMatchingButtonViewModelProviderElement
    extends NotifierProviderElement<HomeMatchingButtonViewModel, bool>
    with HomeMatchingButtonViewModelRef {
  _HomeMatchingButtonViewModelProviderElement(super.provider);

  @override
  List<AnimationController> get controllers =>
      (origin as HomeMatchingButtonViewModelProvider).controllers;
  @override
  List<Animation<double>> get animations =>
      (origin as HomeMatchingButtonViewModelProvider).animations;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
