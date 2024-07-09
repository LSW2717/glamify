// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatDetailViewModelHash() =>
    r'8ddedada3f58de8f842c6cac6fc7b40eb17c60f9';

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

abstract class _$ChatDetailViewModel
    extends BuildlessAutoDisposeNotifier<ChattingState> {
  late final int id;

  ChattingState build(
    int id,
  );
}

/// See also [ChatDetailViewModel].
@ProviderFor(ChatDetailViewModel)
const chatDetailViewModelProvider = ChatDetailViewModelFamily();

/// See also [ChatDetailViewModel].
class ChatDetailViewModelFamily extends Family<ChattingState> {
  /// See also [ChatDetailViewModel].
  const ChatDetailViewModelFamily();

  /// See also [ChatDetailViewModel].
  ChatDetailViewModelProvider call(
    int id,
  ) {
    return ChatDetailViewModelProvider(
      id,
    );
  }

  @override
  ChatDetailViewModelProvider getProviderOverride(
    covariant ChatDetailViewModelProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'chatDetailViewModelProvider';
}

/// See also [ChatDetailViewModel].
class ChatDetailViewModelProvider extends AutoDisposeNotifierProviderImpl<
    ChatDetailViewModel, ChattingState> {
  /// See also [ChatDetailViewModel].
  ChatDetailViewModelProvider(
    int id,
  ) : this._internal(
          () => ChatDetailViewModel()..id = id,
          from: chatDetailViewModelProvider,
          name: r'chatDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatDetailViewModelHash,
          dependencies: ChatDetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              ChatDetailViewModelFamily._allTransitiveDependencies,
          id: id,
        );

  ChatDetailViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  ChattingState runNotifierBuild(
    covariant ChatDetailViewModel notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ChatDetailViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatDetailViewModelProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChatDetailViewModel, ChattingState>
      createElement() {
    return _ChatDetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatDetailViewModelProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatDetailViewModelRef on AutoDisposeNotifierProviderRef<ChattingState> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ChatDetailViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<ChatDetailViewModel,
        ChattingState> with ChatDetailViewModelRef {
  _ChatDetailViewModelProviderElement(super.provider);

  @override
  int get id => (origin as ChatDetailViewModelProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
