// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessageViewModelHash() =>
    r'8c3e3a4e491289a484b98edfcf8b5f63c698b8dd';

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

abstract class _$ChatMessageViewModel
    extends BuildlessAutoDisposeNotifier<List<types.Message>> {
  late final int chatRoomId;

  List<types.Message> build(
    int chatRoomId,
  );
}

/// See also [ChatMessageViewModel].
@ProviderFor(ChatMessageViewModel)
const chatMessageViewModelProvider = ChatMessageViewModelFamily();

/// See also [ChatMessageViewModel].
class ChatMessageViewModelFamily extends Family<List<types.Message>> {
  /// See also [ChatMessageViewModel].
  const ChatMessageViewModelFamily();

  /// See also [ChatMessageViewModel].
  ChatMessageViewModelProvider call(
    int chatRoomId,
  ) {
    return ChatMessageViewModelProvider(
      chatRoomId,
    );
  }

  @override
  ChatMessageViewModelProvider getProviderOverride(
    covariant ChatMessageViewModelProvider provider,
  ) {
    return call(
      provider.chatRoomId,
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
  String? get name => r'chatMessageViewModelProvider';
}

/// See also [ChatMessageViewModel].
class ChatMessageViewModelProvider extends AutoDisposeNotifierProviderImpl<
    ChatMessageViewModel, List<types.Message>> {
  /// See also [ChatMessageViewModel].
  ChatMessageViewModelProvider(
    int chatRoomId,
  ) : this._internal(
          () => ChatMessageViewModel()..chatRoomId = chatRoomId,
          from: chatMessageViewModelProvider,
          name: r'chatMessageViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatMessageViewModelHash,
          dependencies: ChatMessageViewModelFamily._dependencies,
          allTransitiveDependencies:
              ChatMessageViewModelFamily._allTransitiveDependencies,
          chatRoomId: chatRoomId,
        );

  ChatMessageViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatRoomId,
  }) : super.internal();

  final int chatRoomId;

  @override
  List<types.Message> runNotifierBuild(
    covariant ChatMessageViewModel notifier,
  ) {
    return notifier.build(
      chatRoomId,
    );
  }

  @override
  Override overrideWith(ChatMessageViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatMessageViewModelProvider._internal(
        () => create()..chatRoomId = chatRoomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatRoomId: chatRoomId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChatMessageViewModel, List<types.Message>>
      createElement() {
    return _ChatMessageViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessageViewModelProvider &&
        other.chatRoomId == chatRoomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatRoomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatMessageViewModelRef
    on AutoDisposeNotifierProviderRef<List<types.Message>> {
  /// The parameter `chatRoomId` of this provider.
  int get chatRoomId;
}

class _ChatMessageViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<ChatMessageViewModel,
        List<types.Message>> with ChatMessageViewModelRef {
  _ChatMessageViewModelProviderElement(super.provider);

  @override
  int get chatRoomId => (origin as ChatMessageViewModelProvider).chatRoomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
