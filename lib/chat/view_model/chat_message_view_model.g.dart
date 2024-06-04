// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageViewModelHash() => r'e81d593f6c8d8e8a6dafcd01e0b278c74e16d395';

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

abstract class _$MessageViewModel extends BuildlessNotifier<List<Message>> {
  late final User user;

  List<Message> build(
    User user,
  );
}

/// See also [MessageViewModel].
@ProviderFor(MessageViewModel)
const messageViewModelProvider = MessageViewModelFamily();

/// See also [MessageViewModel].
class MessageViewModelFamily extends Family<List<Message>> {
  /// See also [MessageViewModel].
  const MessageViewModelFamily();

  /// See also [MessageViewModel].
  MessageViewModelProvider call(
    User user,
  ) {
    return MessageViewModelProvider(
      user,
    );
  }

  @override
  MessageViewModelProvider getProviderOverride(
    covariant MessageViewModelProvider provider,
  ) {
    return call(
      provider.user,
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
  String? get name => r'messageViewModelProvider';
}

/// See also [MessageViewModel].
class MessageViewModelProvider
    extends NotifierProviderImpl<MessageViewModel, List<Message>> {
  /// See also [MessageViewModel].
  MessageViewModelProvider(
    User user,
  ) : this._internal(
          () => MessageViewModel()..user = user,
          from: messageViewModelProvider,
          name: r'messageViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageViewModelHash,
          dependencies: MessageViewModelFamily._dependencies,
          allTransitiveDependencies:
              MessageViewModelFamily._allTransitiveDependencies,
          user: user,
        );

  MessageViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.user,
  }) : super.internal();

  final User user;

  @override
  List<Message> runNotifierBuild(
    covariant MessageViewModel notifier,
  ) {
    return notifier.build(
      user,
    );
  }

  @override
  Override overrideWith(MessageViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessageViewModelProvider._internal(
        () => create()..user = user,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        user: user,
      ),
    );
  }

  @override
  NotifierProviderElement<MessageViewModel, List<Message>> createElement() {
    return _MessageViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageViewModelProvider && other.user == user;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, user.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MessageViewModelRef on NotifierProviderRef<List<Message>> {
  /// The parameter `user` of this provider.
  User get user;
}

class _MessageViewModelProviderElement
    extends NotifierProviderElement<MessageViewModel, List<Message>>
    with MessageViewModelRef {
  _MessageViewModelProviderElement(super.provider);

  @override
  User get user => (origin as MessageViewModelProvider).user;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
