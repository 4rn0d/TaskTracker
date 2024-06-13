// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "button_create": MessageLookupByLibrary.simpleMessage("作成"),
        "button_login": MessageLookupByLibrary.simpleMessage("ログイン"),
        "button_signup": MessageLookupByLibrary.simpleMessage("サインアップ"),
        "button_update": MessageLookupByLibrary.simpleMessage("タスクを更新"),
        "error_connection":
            MessageLookupByLibrary.simpleMessage("接続エラーが発生しました"),
        "error_tryAgain": MessageLookupByLibrary.simpleMessage("もう一度やり直してください"),
        "error_usernameTaken":
            MessageLookupByLibrary.simpleMessage("ユーザー名は既に使用されています"),
        "hint_confirmPassword":
            MessageLookupByLibrary.simpleMessage("パスワードを確認"),
        "hint_password": MessageLookupByLibrary.simpleMessage("パスワード"),
        "hint_taskName": MessageLookupByLibrary.simpleMessage("タスク名"),
        "hint_username": MessageLookupByLibrary.simpleMessage("ユーザー名"),
        "task_deadline": MessageLookupByLibrary.simpleMessage("締め切り: "),
        "task_progress": MessageLookupByLibrary.simpleMessage("タスクの進行状況: "),
        "task_timeProgression": MessageLookupByLibrary.simpleMessage("時間の経過: "),
        "title_create": MessageLookupByLibrary.simpleMessage("新規タスク"),
        "title_details": MessageLookupByLibrary.simpleMessage("詳細"),
        "title_home": MessageLookupByLibrary.simpleMessage("ホーム"),
        "title_login": MessageLookupByLibrary.simpleMessage("ログイン"),
        "title_signout": MessageLookupByLibrary.simpleMessage("ログアウト"),
        "title_signup": MessageLookupByLibrary.simpleMessage("サインアップ"),
        "validation_differentPasswords":
            MessageLookupByLibrary.simpleMessage("パスワードが一致しません"),
        "validation_empty":
            MessageLookupByLibrary.simpleMessage("フィールドは空にできません")
      };
}
