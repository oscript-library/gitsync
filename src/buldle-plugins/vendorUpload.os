
#Использовать logos
#Использовать v8storage

Перем ВерсияПлагина;
Перем Лог;
Перем КомандыПлагина;
Перем МассивНомеровВерсий;
Перем мАвторизацияВХранилищеСредствами1С;
Перем Обработчик;
Перем ПолучитьТаблицуВерсийСредствами1С;
Перем ХранилищеКонфигурации;

Функция Информация() Экспорт

	Возврат Новый Структура("Версия, Лог, Имя", ВерсияПлагина, Лог, ИмяПлагина())

КонецФункции // Информация() Экспорт

Процедура ПриАктивизацииПлагина(СтандартныйОбработчик) Экспорт

	Обработчик = СтандартныйОбработчик;
	ХранилищеКонфигурации = Новый МенеджерХранилищаКонфигурации;

КонецПроцедуры

Процедура ПриРегистрацииКомандыПриложения(ИмяКоманды, КлассРеализации, Парсер) Экспорт

	Лог.Отладка("Ищю команду <%1> в списке поддерживаемых", ИмяКоманды);
	Если КомандыПлагина.Найти(ИмяКоманды) = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Лог.Отладка("Устанавливаю дополнительные параметры для команды %1", ИмяКоманды);

	ОписаниеКоманды = Парсер.ПолучитьКоманду(ИмяКоманды);

	Парсер.ДобавитьПараметрФлагКоманды			(ОписаниеКоманды,"--vendorHistory", СтрШаблон("[*%1] флаг получения истории версий используя отчет по версиям", ИмяПлагина()));
	Парсер.ДобавитьИменованныйПараметрКоманды	(ОписаниеКоманды,"--storage-user", СтрШаблон("[*%1] <пользователь хранилища конфигурации", ИмяПлагина()));
	Парсер.ДобавитьИменованныйПараметрКоманды	(ОписаниеКоманды,"--storage-pwd", СтрШаблон("[*%1] <пароль пользователя хранилища конфигурации>", ИмяПлагина()));

	Парсер.ДобавитьКоманду(ОписаниеКоманды);

КонецПроцедуры

Процедура ПередНачаломВыполнения(ПутьКХранилищу, КаталогРабочейКопии, URLРепозитория, ИмяВетки) Экспорт

	ХранилищеКонфигурации.УстановитьПараметрыАвторизации(мАвторизацияВХранилищеСредствами1С.ПользовательХранилища, мАвторизацияВХранилищеСредствами1С.ПарольХранилища);
	ХранилищеКонфигурации.УстановитьКаталогХранилища(ПутьКХранилищу);

КонецПроцедуры

Процедура ПриПолученииПараметров(ПараметрыКоманды, ДополнительныеПараметры) Экспорт

	УстановитьАвторизациюВХранилищеКонфигурации(ПараметрыКоманды["--storage-user"], ПараметрыКоманды["--storage-pwd"]);

	ПроверитьПараметрыДоступаКХранилищу();

	ПолучитьТаблицуВерсийСредствами1С = ПараметрыКоманды["--vendorHistory"];
	Если ПолучитьТаблицуВерсийСредствами1С = Неопределено Тогда
		ПолучитьТаблицуВерсийСредствами1С = ложь;
	КонецЕсли;
	Лог.Отладка("Установлен признак получение истории средствами 1С: %1" , ПолучитьТаблицуВерсийСредствами1С);

КонецПроцедуры

Процедура ПриПолученииТаблицыВерсий(ТаблицаВерсий, ПутьКХранилищу, КаталогРабочейКопии, СтандартнаяОбработка) Экспорт

	Если НЕ ПолучитьТаблицуВерсийСредствами1С Тогда
		Возврат;
	КонецЕсли;

	Лог.Информация("Получение таблицы версий средствами 1С.Предприятие");

	СтандартнаяОбработка = Ложь;

	ХранилищеКонфигурации.ПрочитатьХранилище();

	ТаблицаВерсийХранилища = ХранилищеКонфигурации.ПолучитьТаблицуВерсий();
	МассивАвторовХранилища = ХранилищеКонфигурации.ПолучитьАвторов();

	Для Каждого СтрокаВерсииХранилища Из ТаблицаВерсийХранилища Цикл

		СтрокаВерсии = ТаблицаВерсий.Добавить();
		СтрокаВерсии.НомерВерсии	= Число(СтрокаВерсииХранилища.Номер);
		СтрокаВерсии.Автор 			= СтрокаВерсииХранилища.Автор;
		СтрокаВерсии.ГУИД_Автора 	= СтрокаВерсииХранилища.Автор;
		СтрокаВерсии.Дата 			= СтрокаВерсииХранилища.Дата;
		СтрокаВерсии.Комментарий 	= СтрокаВерсииХранилища.Комментарий;
		СтрокаВерсии.Тэг 			= ""; // теги в отчете не предоставляются

		СтрокаШаблонаЛога = "Добавили строку в таблицу версий:
		| Номер версии: %1
		| Автор:        %2
		| ГУИД_Автора:  %3
		| Дата:         %4
		| Комментарий:  %5
		|";
		Лог.Отладка(СтрокаШаблонаЛога, СтрокаВерсии.НомерВерсии,
									 СтрокаВерсии.Автор,
									 СтрокаВерсии.ГУИД_Автора,
									 СтрокаВерсии.Дата,
									 СтрокаВерсии.Комментарий);

	КонецЦикла;

	ТаблицаВерсий.Сортировать("НомерВерсии");

КонецПроцедуры


// Выполняет штатную выгрузку конфигурации в файлы (средствами платформы 8.3) без загрузки конфигурации, но с обновлением на версию хранилища
//
Процедура ПриЗагрузкеВерсииХранилищаВКонфигурацию(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, СтандартнаяОбработка) Экспорт

	СтандартнаяОбработка = Ложь;

	ХранилищеКонфигурации.УстановитьУправлениеКонфигуратором(Конфигуратор);
	ХранилищеКонфигурации.ОбновитьКонфигурациюНаВерсию(НомерВерсии);

КонецПроцедуры

// Устанавливает параметры авторизации в хранилище 1С, если выгрузка версии выполняется средствами платформы
//
Процедура УстановитьАвторизациюВХранилищеКонфигурации(Знач Логин, Знач Пароль)

	мАвторизацияВХранилищеСредствами1С = Новый Структура;
	мАвторизацияВХранилищеСредствами1С.Вставить("ПользовательХранилища" , Логин);
	мАвторизацияВХранилищеСредствами1С.Вставить("ПарольХранилища", Пароль);

КонецПроцедуры

Процедура ПроверитьПараметрыДоступаКХранилищу() Экспорт

	Если мАвторизацияВХранилищеСредствами1С.ПользовательХранилища = Неопределено Тогда

		ВызватьИсключение "Не задан пользователь хранилища конфигурации.";

	КонецЕсли;

	Если мАвторизацияВХранилищеСредствами1С.ПарольХранилища = Неопределено Тогда

		ПарольХранилища = "";

	КонецЕсли;

КонецПроцедуры // ПроверитьПараметрыДоступаКХранилищу


Функция ИмяПлагина()
	возврат "vendorUpload";
КонецФункции // ИмяПлагина()

Процедура Инициализация()

	ВерсияПлагина = "1.0.0";
	Лог = Логирование.ПолучитьЛог("oscript.app.gitsync_plugins_"+ СтрЗаменить(ИмяПлагина(),"-", "_"));
	КомандыПлагина = Новый Массив;
	КомандыПлагина.Добавить("sync");
	КомандыПлагина.Добавить("export");
	мАвторизацияВХранилищеСредствами1С = Новый Структура("ПользовательХранилища, ПарольХранилища");

КонецПроцедуры

Инициализация();


