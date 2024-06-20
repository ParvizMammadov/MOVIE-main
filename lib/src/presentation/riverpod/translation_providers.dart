import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/translation_service.dart';
import '../providers/language_change_controller.dart';

final translationProvider = Provider<TranslationService>((ref) {
  return TranslationService();
});
final appLanguageProvider = ChangeNotifierProvider((_) => AppLanguage());
