// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "button_create": MessageLookupByLibrary.simpleMessage("만들기"),
        "button_login": MessageLookupByLibrary.simpleMessage("로그인"),
        "button_signup": MessageLookupByLibrary.simpleMessage("회원가입"),
        "button_update": MessageLookupByLibrary.simpleMessage("작업 업데이트"),
        "code": MessageLookupByLibrary.simpleMessage("ko"),
        "error_connection":
            MessageLookupByLibrary.simpleMessage("연결 오류가 발생했습니다"),
        "error_tryAgain": MessageLookupByLibrary.simpleMessage("다시 시도하십시오"),
        "error_usernameTaken":
            MessageLookupByLibrary.simpleMessage("사용자 이름이 이미 사용중입니다"),
        "hint_confirmPassword": MessageLookupByLibrary.simpleMessage("비밀번호 확인"),
        "hint_password": MessageLookupByLibrary.simpleMessage("비밀번호"),
        "hint_taskName": MessageLookupByLibrary.simpleMessage("작업 이름"),
        "hint_username": MessageLookupByLibrary.simpleMessage("사용자 이름"),
        "task_deadline": MessageLookupByLibrary.simpleMessage("마감 기한: "),
        "task_name": MessageLookupByLibrary.simpleMessage("작업 이름 : "),
        "task_progress": MessageLookupByLibrary.simpleMessage("작업 진행 상황: "),
        "task_timeProgression":
            MessageLookupByLibrary.simpleMessage("시간 진행 상황: "),
        "title_create": MessageLookupByLibrary.simpleMessage("새로운 작업"),
        "title_details": MessageLookupByLibrary.simpleMessage("상세 정보"),
        "title_home": MessageLookupByLibrary.simpleMessage("홈"),
        "title_login": MessageLookupByLibrary.simpleMessage("로그인"),
        "title_signout": MessageLookupByLibrary.simpleMessage("로그아웃"),
        "title_signup": MessageLookupByLibrary.simpleMessage("회원가입"),
        "validation_differentPasswords":
            MessageLookupByLibrary.simpleMessage("비밀번호가 일치하지 않습니다"),
        "validation_empty":
            MessageLookupByLibrary.simpleMessage("필드를 비워둘 수 없습니다")
      };
}
