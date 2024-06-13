// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "button_create": MessageLookupByLibrary.simpleMessage("Créer"),
        "button_login": MessageLookupByLibrary.simpleMessage("Connexion"),
        "button_signup": MessageLookupByLibrary.simpleMessage("Inscription"),
        "button_update":
            MessageLookupByLibrary.simpleMessage("Mettre à jour de la tâche"),
        "error_connection": MessageLookupByLibrary.simpleMessage(
            "Une erreur de connexion s\'est produite"),
        "error_tryAgain": MessageLookupByLibrary.simpleMessage("Réessayer"),
        "error_usernameTaken": MessageLookupByLibrary.simpleMessage(
            "Le nom d\'utilisateur est déjà pris"),
        "hint_confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirmer le mot de passe"),
        "hint_password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "hint_taskName":
            MessageLookupByLibrary.simpleMessage("Nom de la tâche"),
        "hint_username":
            MessageLookupByLibrary.simpleMessage("Nom d\'utilisateur"),
        "task_deadline": MessageLookupByLibrary.simpleMessage("Échéance : "),
        "task_progress":
            MessageLookupByLibrary.simpleMessage("Progression de la tâche : "),
        "task_timeProgression":
            MessageLookupByLibrary.simpleMessage("Progression du temps : "),
        "title_create": MessageLookupByLibrary.simpleMessage("Nouvelle tâche"),
        "title_details": MessageLookupByLibrary.simpleMessage("Détails"),
        "title_home": MessageLookupByLibrary.simpleMessage("Accueil"),
        "title_login": MessageLookupByLibrary.simpleMessage("Connexion"),
        "title_signout": MessageLookupByLibrary.simpleMessage("Déconnexion"),
        "title_signup": MessageLookupByLibrary.simpleMessage("Inscription"),
        "validation_differentPasswords": MessageLookupByLibrary.simpleMessage(
            "Les mots de passe ne correspondent pas"),
        "validation_empty": MessageLookupByLibrary.simpleMessage(
            "Le champ ne peut pas être vide")
      };
}
