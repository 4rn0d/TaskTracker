// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "button_create": MessageLookupByLibrary.simpleMessage("Create"),
        "button_login": MessageLookupByLibrary.simpleMessage("Login"),
        "button_signup": MessageLookupByLibrary.simpleMessage("Signup"),
        "button_update": MessageLookupByLibrary.simpleMessage("Update task"),
        "code": MessageLookupByLibrary.simpleMessage("en"),
        "error_connection": MessageLookupByLibrary.simpleMessage(
            "A connection error as occured"),
        "error_tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
        "error_usernameTaken": MessageLookupByLibrary.simpleMessage(
            "The username is already taken"),
        "hint_confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "hint_password": MessageLookupByLibrary.simpleMessage("Password"),
        "hint_taskName": MessageLookupByLibrary.simpleMessage("Task name"),
        "hint_username": MessageLookupByLibrary.simpleMessage("Username"),
        "task_deadline": MessageLookupByLibrary.simpleMessage("Deadline : "),
        "task_name": MessageLookupByLibrary.simpleMessage("Task\'s name :"),
        "task_progress":
            MessageLookupByLibrary.simpleMessage("Task progression : "),
        "task_timeProgression":
            MessageLookupByLibrary.simpleMessage("Time progression : "),
        "title_create": MessageLookupByLibrary.simpleMessage("New task"),
        "title_details": MessageLookupByLibrary.simpleMessage("Details"),
        "title_home": MessageLookupByLibrary.simpleMessage("Home"),
        "title_login": MessageLookupByLibrary.simpleMessage("Login"),
        "title_signout": MessageLookupByLibrary.simpleMessage("Signout"),
        "title_signup": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "validation_differentPasswords":
            MessageLookupByLibrary.simpleMessage("The passwords do not match"),
        "validation_empty":
            MessageLookupByLibrary.simpleMessage("The field cannot be empty")
      };
}
