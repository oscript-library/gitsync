﻿////////////////////////////////////////////////////////////////////
// Стартовый модуль синхронизатора

#Использовать tempfiles
#Использовать cmdline
#Использовать logos
#Использовать json

#Использовать "core"

Перем Лог;
Перем УдалятьВременныеФайлы;

///////////////////////////////////////////////////////////////////
// Прикладные процедуры и функции

Функция РазобратьАргументыКоманднойСтроки()

	Если АргументыКоманднойСтроки.Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;

	Парсер = ИнициализироватьПарсерАргументов();

	Параметры = Парсер.Разобрать(АргументыКоманднойСтроки);

	Возврат Параметры;

КонецФункции

Функция ИнициализироватьПарсерАргументов()

	Парсер = Новый ПарсерАргументовКоманднойСтроки();

	ДобавитьКомандуClone(Парсер);
	ДобавитьКомандуInit(Парсер);
	ДобавитьКомандуAll(Парсер);
	ДобавитьКомандуSetVersion(Парсер);
	ДобавитьКомандуHelp(Парсер);
	ДобавитьКомандуExport(Парсер);
	ДобавитьАргументыПоУмолчанию(Парсер);

	Возврат Парсер;

КонецФункции

Процедура ДобавитьКомандуClone(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("clone", "Клонирует существующий репозиторий и создает служебные файлы");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ПутьКХранилищу", "Файловый путь к каталогу хранилища конфигурации 1С.");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "URLРепозитория", "Адрес удаленного репозитория GIT.");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ЛокальныйКаталогГит", "Каталог исходников внутри локальной копии git-репозитария.");

	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-email", "<домен почты для пользователей git>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-debug", "<on|off>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-verbose", "<on|off>");
	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьКомандуInit(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("init", "Создает новый репозиторий и создает служебные файлы");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ПутьКХранилищу", "Файловый путь к каталогу хранилища конфигурации 1С.");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ЛокальныйКаталогГит", "Адрес локального репозитория GIT или каталог исходников внутри локальной копии git-репозитария.");

	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-email", "<домен почты для пользователей git>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-debug", "<on|off>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-verbose", "<on|off>");
	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьКомандуSetVersion(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("set-version", "Устанавливает необходимую версию в файл VERSION");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "КаталогФайлаВерсии", "Каталог, в котором находится файл VERSION.");
    Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "НомерВерсии", "Номер версии для записи в файл");

	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-debug", "<on|off>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-verbose", "<on|off>");
	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьКомандуAll(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("all", "Запускает синхронизацию по нескольким репозиториям");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ПутьКНастройкам", "Путь к файлу настроек синхронизатора");

	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-log", "Путь к файлу лога");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-timer", "Интервал срабатывания");

	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-force", "<on|off> принудительная синхронизация");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-debug", "<on|off>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-verbose", "<on|off>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-tempcatalog", "Путь к каталогу временных файлов");

	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьКомандуHelp(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("help", "Вывести справку по параметрам команды");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "КомандаДляСправки");
	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьКомандуExport(Знач Парсер)

	Команда = Парсер.ОписаниеКоманды("export", "Выполнить локальную синхронизацию, без pull/push");

	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ПутьКХранилищу", "Файловый путь к каталогу хранилища конфигурации 1С.");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ЛокальныйКаталогГит", "Каталог исходников внутри локальной копии git-репозитария.");

	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-email", "<домен почты для пользователей git>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-v8version", "Маска версии платформы (8.3, 8.3.5, 8.3.6.2299 и т.п.)");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-debug", "<on|off>");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-verbose", "<on|off>");
    Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-format", "<hierarchical|plain>");

	Парсер.ДобавитьКоманду(Команда);

КонецПроцедуры

Процедура ДобавитьАргументыПоУмолчанию(Знач Парсер)

	Парсер.ДобавитьПараметр("ПутьКХранилищу", "Файловый путь к каталогу хранилища конфигурации 1С.");
	Парсер.ДобавитьПараметр("URLРепозитория", "Адрес удаленного репозитория GIT.");
	Парсер.ДобавитьПараметр("ЛокальныйКаталогГит", "Каталог исходников внутри локальной копии git-репозитария.");

	Парсер.ДобавитьИменованныйПараметр("-email", "<домен почты для пользователей git>");
	Парсер.ДобавитьИменованныйПараметр("-v8version", "Маска версии платформы (8.3, 8.3.5, 8.3.6.2299 и т.п.)");
	Парсер.ДобавитьИменованныйПараметр("-debug", "<on|off>");
	Парсер.ДобавитьИменованныйПараметр("-verbose", "<on|off>");
	Парсер.ДобавитьИменованныйПараметр("-branch", "<имя ветки git>");
    Парсер.ДобавитьИменованныйПараметр("-format", "<hierarchical|plain>");
	Парсер.ДобавитьИменованныйПараметр("-tempcatalog", "Путь к каталогу временных файлов");

КонецПроцедуры

Процедура ВыполнитьОбработку(Знач Параметры)

	Если ТипЗнч(Параметры) = Тип("Структура") Тогда
		УстановитьРежимОтладкиПриНеобходимости(Параметры.ЗначенияПараметров);
		УстановитьРежимУдаленияВременныхФайлов(Параметры.ЗначенияПараметров);
		УстановитьБазовыйКаталогВременныхФайлов(Параметры.ЗначенияПараметров);

		ВыполнитьКоманду(Параметры);
	Иначе

		УстановитьРежимОтладкиПриНеобходимости(Параметры);
		УстановитьРежимУдаленияВременныхФайлов(Параметры);
		УстановитьБазовыйКаталогВременныхФайлов(Параметры);

		Синхронизировать(
			Параметры["ПутьКХранилищу"],
			Параметры["URLРепозитория"],
			Параметры["ЛокальныйКаталогГит"],
			Параметры["-email"],
			Параметры["-v8version"],
			,
			,
			Параметры["-format"],
			Параметры["-branch"]);

	КонецЕсли;

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач ОписаниеКоманды)

	Параметры = ОписаниеКоманды.ЗначенияПараметров;

	Если ОписаниеКоманды.Команда = "init" Тогда
		ПодготовитьНовыйРепозитарий(Параметры, Истина);
	ИначеЕсли ОписаниеКоманды.Команда = "clone" Тогда
		КлонироватьРепозитарий(Параметры);
	ИначеЕсли ОписаниеКоманды.Команда = "all" Тогда
		СинхронизироватьПоСпискуРепозитариев(Параметры);
	ИначеЕсли ОписаниеКоманды.Команда = "help" Тогда
		ВывестиСправкуПоКомандам(Параметры["КомандаДляСправки"]);
	ИначеЕсли ОписаниеКоманды.Команда = "set-version" Тогда
		УстановитьНовуюВерсию(Параметры);
	ИначеЕсли ОписаниеКоманды.Команда = "export" Тогда
		ВыполнитьКомандуЭкспортИсходников(Параметры);
	Иначе
		ВызватьИсключение "Неизвестная команда: " + ОписаниеКоманды.Команда;
	КонецЕсли;

КонецПроцедуры

Процедура ПодготовитьНовыйРепозитарий(Знач Параметры, Знач РежимИнициализации)

	Распаковщик = ПолучитьИНастроитьРаспаковщик(Параметры);
	КаталогРабочейКопии = ПодготовитьКаталогНовойРабочейКопии(Параметры["ЛокальныйКаталогГит"]);

	// инициализировать с нуля
	СоздатьКаталог(КаталогРабочейКопии);
	ЭтоКаталогГит = Распаковщик.ПроверитьНаличиеРепозитарияГит(КаталогРабочейКопии);
	Если Не ЭтоКаталогГит Тогда
		Результат = Распаковщик.ИнициализироватьРепозитарий(КаталогРабочейКопии);
		Если Результат <> 0 Тогда
			ВызватьИсключение "git init вернул код <"+Результат+">";
		КонецЕсли;
	КонецЕсли;

	НаполнитьКаталогРабочейКопииСлужебнымиДанными(КаталогРабочейКопии, Распаковщик, Параметры["ПутьКХранилищу"]);

КонецПроцедуры

Процедура УстановитьНовуюВерсию(Знач Параметры)

	Распаковщик = ПолучитьИНастроитьРаспаковщик(Параметры);
	ФайлВерсий = Новый Файл(ОбъединитьПути(Параметры["ЛокальныйКаталогГит"], "VERSION"));
	Распаковщик.ЗаписатьФайлВерсийГит(ФайлВерсий.Путь, Параметры["НомерВерсии"]);

КонецПроцедуры


Процедура КлонироватьРепозитарий(Знач Параметры)

	Распаковщик = ПолучитьИНастроитьРаспаковщик(Параметры);
	КаталогРабочейКопии = ПодготовитьКаталогНовойРабочейКопии(Параметры["ЛокальныйКаталогГит"]);

	URL = Параметры["URLРепозитория"];
	Если ПустаяСтрока(URL) Тогда
		ВызватьИсключение "Не указан URL репозитария";
	КонецЕсли;

	СоздатьКаталог(КаталогРабочейКопии);
	Результат = Распаковщик.КлонироватьРепозитарий(КаталогРабочейКопии, URL);
	Если Результат <> 0 Тогда
		ВызватьИсключение "git clone вернул код <"+Результат+">";
	КонецЕсли;

	НаполнитьКаталогРабочейКопииСлужебнымиДанными(КаталогРабочейКопии, Распаковщик, Параметры["ПутьКХранилищу"]);

КонецПроцедуры

Функция ПолучитьИНастроитьРаспаковщик(Знач Параметры)
	Распаковщик = ПолучитьРаспаковщик();
	Распаковщик.ДоменПочтыДляGitПоУмолчанию = Параметры["-email"];
	Возврат Распаковщик;
КонецФункции

Функция ПолучитьРаспаковщик()
	Распаковщик = Новый МенеджерСинхронизации();
	Распаковщик.УстановитьРежимУдаленияВременныхФайлов(УдалятьВременныеФайлы);
	Возврат Распаковщик;
КонецФункции

Функция ПодготовитьКаталогНовойРабочейКопии(Знач КаталогРабочейКопииГит)

	Если КаталогРабочейКопииГит = Неопределено Тогда
		КаталогРабочейКопииГит = ТекущийКаталог();
	Иначе
		ФайлРК = Новый Файл(КаталогРабочейКопииГит);
		КаталогРабочейКопииГит = ФайлРК.ПолноеИмя;
	КонецЕсли;

	Возврат КаталогРабочейКопииГит;

КонецФункции

Процедура НаполнитьКаталогРабочейКопииСлужебнымиДанными(Знач КаталогРабочейКопии, Знач Распаковщик, Знач ПутьКХранилищу)

	КаталогИсходников = Новый Файл(КаталогРабочейКопии);
	Если Не КаталогИсходников.Существует() Тогда
		СоздатьКаталог(КаталогИсходников.ПолноеИмя);
	ИначеЕсли Не КаталогИсходников.ЭтоКаталог() Тогда
		ВызватьИсключение "Невозможно создать каталог " + КаталогИсходников.ПолноеИмя;
	КонецЕсли;

	СгенерироватьФайлAUTHORS(ПолучитьПутьКБазеДанныхХранилища(ПутьКХранилищу), КаталогИсходников.ПолноеИмя, Распаковщик);
	СгенерироватьФайлVERSION(КаталогИсходников.ПолноеИмя, Распаковщик);

КонецПроцедуры

Процедура Синхронизировать(Знач ПутьКХранилищу,
			Знач URLРепозитория,
			Знач ЛокальныйКаталогГит = Неопределено,
			Знач ДоменПочты = Неопределено,
			Знач ВерсияПлатформы = Неопределено,
			Знач НачальнаяВерсия = 0,
			Знач КонечнаяВерсия = 0,
			Знач Формат = Неопределено,
			Знач ИмяВетки = Неопределено,
			Знач КоличествоКоммитовДоPush = 0) Экспорт

	Лог.Информация("Начинаю синхронизацию хранилища 1С и репозитария GIT");

	Если ЛокальныйКаталогГит = Неопределено Тогда
		ЛокальныйКаталогГит = ТекущийКаталог();
	КонецЕсли;

	Если Формат = Неопределено Тогда
		Формат = РежимВыгрузкиФайлов.Авто;
	КонецЕсли;

	Если ИмяВетки = Неопределено Тогда
		ИмяВетки = "master";
	КонецЕсли;

	Если ТипЗнч(КоличествоКоммитовДоPush) = Тип("Строка") Тогда
		КоличествоКоммитовДоPush = Число(КоличествоКоммитовДоPush);
	КонецЕсли;

	Лог.Отладка("ПутьКХранилищу = " + ПутьКХранилищу);
	Лог.Отладка("URLРепозитория = " + URLРепозитория);
	Лог.Отладка("ЛокальныйКаталогГит = " + ЛокальныйКаталогГит);
	Лог.Отладка("ДоменПочты = " + ДоменПочты);
	Лог.Отладка("ВерсияПлатформы = " + ВерсияПлатформы);
	Лог.Отладка("Формат = " + Формат);
	Лог.Отладка("ИмяВетки = " + ИмяВетки);


	Распаковщик = ПолучитьРаспаковщик();
	Распаковщик.ВерсияПлатформы = ВерсияПлатформы;
	Распаковщик.ДоменПочтыДляGitПоУмолчанию = ДоменПочты;

	Лог.Информация("Получение изменений с удаленного узла (pull)");
	КодВозврата = Распаковщик.ВыполнитьGitPull(ЛокальныйКаталогГит, URLРепозитория, ИмяВетки);
	Если КодВозврата <> 0 Тогда
		ВызватьИсключение "Не удалось получить изменения с удаленного узла (код: " + КодВозврата + ")";
	КонецЕсли;

	Лог.Информация("Синхронизация изменений с хранилищем");
	ВыполнитьЭкспортИсходников(Распаковщик, ПутьКХранилищу, ЛокальныйКаталогГит, НачальнаяВерсия, КонечнаяВерсия, Формат, КоличествоКоммитовДоPush, URLРепозитория, ИмяВетки);

	Лог.Информация("Отправка изменений на удаленный узел");
	КодВозврата = Распаковщик.ВыполнитьGitPush(ЛокальныйКаталогГит, URLРепозитория, ИмяВетки);
	Если КодВозврата <> 0 Тогда
		ВызватьИсключение "Не удалось отправить изменения на удаленный узел (код: " + КодВозврата + ")";
	КонецЕсли;

	Лог.Информация("Синхронизация завершена");

КонецПроцедуры

Процедура ВыполнитьЭкспортИсходников(Знач Распаковщик, Знач ПутьКХранилищу, Знач ЛокальныйКаталогГит, Знач НачальнаяВерсия = 0, Знач КонечнаяВерсия = 0, Знач Формат = Неопределено, Знач КоличествоКоммитовДоPush = 0, Знач URLРепозитория= Неопределено, Знач ИмяВетки = Неопределено)

	ФайлБазыДанныхХранилища = ПолучитьПутьКБазеДанныхХранилища(ПутьКХранилищу);
	Распаковщик.СинхронизироватьХранилищеКонфигурацийСГит(ЛокальныйКаталогГит, ФайлБазыДанныхХранилища, НачальнаяВерсия, КонечнаяВерсия, Формат, КоличествоКоммитовДоPush, URLРепозитория, ИмяВетки);

КонецПроцедуры

Процедура ВыполнитьКомандуЭкспортИсходников(Знач Параметры)

	ЛокальныйКаталогГит = Параметры["ЛокальныйКаталогГит"];
	Формат = Параметры["-format"];

	Если ЛокальныйКаталогГит = Неопределено Тогда
		ЛокальныйКаталогГит = ТекущийКаталог();
	КонецЕсли;

	Если Формат = Неопределено Тогда
		Формат = РежимВыгрузкиФайлов.Авто;
	КонецЕсли;

	Распаковщик = ПолучитьИНастроитьРаспаковщик(Параметры);
	Распаковщик.ВерсияПлатформы             = Параметры["-v8version"];
	Распаковщик.ДоменПочтыДляGitПоУмолчанию = Параметры["-email"];
	Лог.Информация("Начинаю выгрузку исходников");
	ВыполнитьЭкспортИсходников(Распаковщик, Параметры["ПутьКХранилищу"], ЛокальныйКаталогГит,,,Формат);
	Лог.Информация("Выгрузка завершена");


КонецПроцедуры

Функция ТребуетсяСинхронизироватьХранилище(Знач ФайлХранилища, Знач ЛокальныйКаталогГит) Экспорт

	Распаковщик = ПолучитьРаспаковщик();
	Возврат Распаковщик.ТребуетсяСинхронизироватьХранилищеСГит(ФайлХранилища, ЛокальныйКаталогГит);

КонецФункции

Процедура УстановитьРежимОтладкиПриНеобходимости(Знач Параметры)
	Если Параметры["-verbose"] = "on" ИЛИ Параметры["-debug"] = "on" Тогда
		Лог.УстановитьУровень(УровниЛога.Отладка);
	КонецЕсли;
КонецПроцедуры

Процедура УстановитьРежимУдаленияВременныхФайлов(Знач Параметры)
	Если Параметры["-debug"] = "on" Тогда
		УдалятьВременныеФайлы = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура УстановитьБазовыйКаталогВременныхФайлов(Знач Параметры)
	Если ЗначениеЗаполнено(Параметры["-tempcatalog"]) Тогда
		БазовыйКаталог  = Параметры["-tempcatalog"];
		Если Не (Новый Файл(БазовыйКаталог).Существует()) Тогда
			СоздатьКаталог(БазовыйКаталог);
		КонецЕсли;
		
		ВременныеФайлы.БазовыйКаталог = БазовыйКаталог;
	КонецЕсли;
КонецПроцедуры

Процедура УдалитьВременныеФайлыПриНеобходимости()

	Если УдалятьВременныеФайлы Тогда
		ВременныеФайлы.Удалить();
	КонецЕсли;

КонецПроцедуры

Функция ПолучитьПутьКБазеДанныхХранилища(Знач ПутьКХранилищу)
	ФайлПутиКХранилищу = Новый Файл(ПутьКХранилищу);
	Если ФайлПутиКХранилищу.Существует() и ФайлПутиКХранилищу.ЭтоКаталог() Тогда
		ФайлБазыДанныхХранилища = ОбъединитьПути(ФайлПутиКХранилищу.ПолноеИмя, "1cv8ddb.1CD");
	ИначеЕсли ФайлПутиКХранилищу.Существует() Тогда
		ФайлБазыДанныхХранилища = ФайлПутиКХранилищу.ПолноеИмя;
	Иначе
		ВызватьИсключение "Некорректный путь к хранилищу: " + ФайлПутиКХранилищу.ПолноеИмя;
	КонецЕсли;

	Возврат ФайлБазыДанныхХранилища;
КонецФункции

Процедура СгенерироватьФайлAUTHORS(Знач ФайлХранилища, Знач КаталогИсходников, Знач Распаковщик)

	ОбъектФайлХранилища = Новый Файл(ПолучитьПутьКБазеДанныхХранилища(ФайлХранилища));
	Если Не ОбъектФайлХранилища.Существует() Тогда
		ВызватьИсключение "Файл хранилища <" + ОбъектФайлХранилища.ПолноеИмя + "> не существует.";
	КонецЕсли;

	ФайлАвторов = Новый Файл(ОбъединитьПути(КаталогИсходников, "AUTHORS"));
	Если ФайлАвторов.Существует() Тогда
		Лог.Отладка("Файл " + ФайлАвторов.ПолноеИмя + " уже существует. Пропускаем генерацию файла AUTHORS");
		Возврат;
	КонецЕсли;

	Попытка

		Лог.Отладка("Формирую файл AUTHORS в каталоге " + КаталогИсходников);
		Распаковщик.СформироватьПервичныйФайлПользователейДляGit(ОбъектФайлХранилища.ПолноеИмя, ФайлАвторов.ПолноеИмя);
		Лог.Отладка("Файл сгенерирован");

	Исключение
		Лог.Ошибка("Не удалось сформировать файл авторов");
		ВызватьИсключение;
	КонецПопытки;

КонецПроцедуры

Процедура СгенерироватьФайлVERSION(Знач КаталогИсходников, Знач Распаковщик)

	ФайлВерсий = Новый Файл(ОбъединитьПути(КаталогИсходников, "VERSION"));
	Если ФайлВерсий.Существует() Тогда
		Лог.Информация("Файл " + ФайлВерсий.ПолноеИмя + " уже существует. Пропускаем генерацию файла VERSION");
		Возврат;
	КонецЕсли;

	Распаковщик.ЗаписатьФайлВерсийГит(ФайлВерсий.Путь);

КонецПроцедуры

Процедура СинхронизироватьПоСпискуРепозитариев(Знач Параметры)

	ИмяФайлаНастроек = Параметры["ПутьКНастройкам"];
	Если ИмяФайлаНастроек = Неопределено Тогда
		ВывестиСправкуПоКомандам("all");
		ЗавершитьСкрипт(1);
	КонецЕсли;

	Если Параметры["-log"] <> Неопределено Тогда
		Аппендер = Новый ВыводЛогаВФайл();
		Аппендер.ОткрытьФайл(Параметры["-log"]);
		Лог.ДобавитьСпособВывода(Аппендер);
		Раскладка = ЗагрузитьСценарий(ОбъединитьПути(ТекущийСценарий().Каталог, "log-layout.os"));
		Лог.УстановитьРаскладку(Раскладка);
	КонецЕсли;

	Интервал = 0;
	Если Параметры["-timer"] <> Неопределено Тогда
		Интервал = Число(Параметры["-timer"]);
	КонецЕсли;

	Контроллер = ЗагрузитьСценарий(ОбъединитьПути(ТекущийСценарий().Каталог, "multi-controller.os"));

	Пока Истина Цикл
		Контроллер.ВыполнитьСинхронизациюПоФайлуНастроек(ЭтотОбъект, ИмяФайлаНастроек, Параметры["-force"] = Истина);

		Если Интервал <= 0 Тогда
			Прервать;
		Иначе
			Лог.Информация("Ожидаем " + Интервал + " секунд перед новым циклом");
			Приостановить(Интервал * 1000);
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

Процедура ПоказатьИнформациюОПараметрахКоманднойСтроки()

	Парсер = ИнициализироватьПарсерАргументов();

	ВозможныеКоманды = Парсер.СправкаВозможныеКоманды();

	Сообщить("Синхронизация хранилища конфигураций 1С с репозитарием GIT.");
	Сообщить("Использование: ");
	Сообщить("	gitsync <storage-path> <git-url> [local-dir] [ключи]");
	Сообщить("	gitsync <команда> <параметры команды> [ключи]");
	ВывестиПараметры(Парсер.СправкаПоПараметрам());

	Сообщить(Символы.ПС + "Возможные команды:");

	МаксШирина = 0;
	Поле = "               ";
	Для Каждого Команда Из ВозможныеКоманды Цикл
		ТекШирина = СтрДлина(Команда.Команда);
		Если ТекШирина > МаксШирина Тогда
			МаксШирина = ТекШирина;
		КонецЕсли;
	КонецЦикла;

	Для Каждого Команда Из ВозможныеКоманды Цикл
		Сообщить(" " + Лев(Команда.Команда + Поле, МаксШирина + 2) + "- " + Команда.Пояснение);
	КонецЦикла;

	Сообщить("Для подсказки по конкретной команде наберите gitsync help <команда>");

КонецПроцедуры

Процедура ВывестиСправкуПоКомандам(Знач Команда) Экспорт

	Парсер = ИнициализироватьПарсерАргументов();

	ВозможныеКоманды = Парсер.СправкаВозможныеКоманды();
	ОписаниеКоманды = ВозможныеКоманды.Найти(Команда, "Команда");
	Если ОписаниеКоманды = Неопределено Тогда
		Сообщить("Команда отсуствует: " + Команда);
		Возврат;
	КонецЕсли;

	Сообщить("" + ОписаниеКоманды.Команда + " - " + ОписаниеКоманды.Пояснение);
	ВывестиПараметры(ОписаниеКоманды.Параметры);

КонецПроцедуры

Процедура ВывестиПараметры(Знач ОписаниеПараметров)

	Сообщить("Параметры:");
	Для Каждого СтрПараметр Из ОписаниеПараметров Цикл
		Если Не СтрПараметр.ЭтоИменованныйПараметр Тогда
			Сообщить(СтрШаблон(" <%1> - %2", СтрПараметр.Имя, СтрПараметр.Пояснение));
		Иначе
			Сообщить(СтрШаблон(" %1 - %2", СтрПараметр.Имя, СтрПараметр.Пояснение));
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

Процедура ЗавершитьСкрипт(Знач КодВозврата)
	ИмяСтартовогоСкрипта = Новый Файл(СтартовыйСценарий().Источник).Имя;
	ИмяТекущегоСкрипта = Новый Файл(ТекущийСценарий().Источник).Имя;
	Если ИмяСтартовогоСкрипта = ИмяТекущегоСкрипта Тогда
		ЗавершитьРаботу(КодВозврата);
	Иначе
		ВызватьИсключение Новый ИнформацияОбОшибке("Завершаем работу скрипта с кодом возврата " + КодВозврата, Новый Структура("КодВозврата", КодВозврата));
	КонецЕсли;
КонецПроцедуры
///////////////////////////////////////////////////////////////////
// Точка входа в приложение

Лог = Логирование.ПолучитьЛог("oscript.app.gitsync");
УдалятьВременныеФайлы = Ложь;

Попытка
	Параметры = РазобратьАргументыКоманднойСтроки();
	Если Параметры <> Неопределено Тогда
		ВыполнитьОбработку(Параметры);
	Иначе
		ПоказатьИнформациюОПараметрахКоманднойСтроки();
		Лог.Ошибка("Указаны некорректные аргументы командной строки");
		УдалитьВременныеФайлыПриНеобходимости();
		ЗавершитьСкрипт(1);
	КонецЕсли;
	УдалитьВременныеФайлыПриНеобходимости();
	Лог.Закрыть();
Исключение
	Лог.Ошибка(ОписаниеОшибки());
	УдалитьВременныеФайлыПриНеобходимости();
	Лог.Закрыть();
	ЗавершитьСкрипт(1);
КонецПопытки;
