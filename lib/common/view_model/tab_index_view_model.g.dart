// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_index_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tabIndexViewModelHash() => r'26ef89efdaa6934605e3a8f6e06f040d3960aee2';

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

abstract class _$TabIndexViewModel extends BuildlessNotifier<int> {
  late final ScrollController controller;

  int build(
    ScrollController controller,
  );
}

/// See also [TabIndexViewModel].
@ProviderFor(TabIndexViewModel)
const tabIndexViewModelProvider = TabIndexViewModelFamily();

/// See also [TabIndexViewModel].
class TabIndexViewModelFamily extends Family<int> {
  /// See also [TabIndexViewModel].
  const TabIndexViewModelFamily();

  /// See also [TabIndexViewModel].
  TabIndexViewModelProvider call(
    ScrollController controller,
  ) {
    return TabIndexViewModelProvider(
      controller,
    );
  }

  @override
  TabIndexViewModelProvider getProviderOverride(
    covariant TabIndexViewModelProvider provider,
  ) {
    return call(
      provider.controller,
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
  String? get name => r'tabIndexViewModelProvider';
}

/// See also [TabIndexViewModel].
class TabIndexViewModelProvider
    extends NotifierProviderImpl<TabIndexViewModel, int> {
  /// See also [TabIndexViewModel].
  TabIndexViewModelProvider(
    ScrollController controller,
  ) : this._internal(
          () => TabIndexViewModel()..controller = controller,
          from: tabIndexViewModelProvider,
          name: r'tabIndexViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tabIndexViewModelHash,
          dependencies: TabIndexViewModelFamily._dependencies,
          allTransitiveDependencies:
              TabIndexViewModelFamily._allTransitiveDependencies,
          controller: controller,
        );

  TabIndexViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.controller,
  }) : super.internal();

  final ScrollController controller;

  @override
  int runNotifierBuild(
    covariant TabIndexViewModel notifier,
  ) {
    return notifier.build(
      controller,
    );
  }

  @override
  Override overrideWith(TabIndexViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TabIndexViewModelProvider._internal(
        () => create()..controller = controller,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        controller: controller,
      ),
    );
  }

  @override
  NotifierProviderElement<TabIndexViewModel, int> createElement() {
    return _TabIndexViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TabIndexViewModelProvider && other.controller == controller;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, controller.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TabIndexViewModelRef on NotifierProviderRef<int> {
  /// The parameter `controller` of this provider.
  ScrollController get controller;
}

class _TabIndexViewModelProviderElement
    extends NotifierProviderElement<TabIndexViewModel, int>
    with TabIndexViewModelRef {
  _TabIndexViewModelProviderElement(super.provider);

  @override
  ScrollController get controller =>
      (origin as TabIndexViewModelProvider).controller;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
