﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd
#Использовать gitrunner
#Использовать asserts
#Использовать tempfiles

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯУстанавливаюПутьВыполненияКомандыКТекущейБиблиотеке");
	ВсеШаги.Добавить("ЯСкопировалКаталогТестовогоХранилищаКонфигурацииВоВременныйКаталог");
	ВсеШаги.Добавить("ЯСохраняюЗначениеВременногоКаталогаВПеременной");
	ВсеШаги.Добавить("ЯСоздаюТестовойФайлAuthors");
	ВсеШаги.Добавить("ЯЗаписываюВФайлVersion");
	ВсеШаги.Добавить("ЯИнициализируюBareРепозиторийВоВременномКаталоге");
	ВсеШаги.Добавить("ЯИнициализируюСвязьСВнешнимРепозиторием");
	ВсеШаги.Добавить("ЯДобавляюПозиционныйПараметрДляКомандыИзПеременной");
	ВсеШаги.Добавить("ЯДобавляюПараметрДляКомандыИзПеременной");
	ВсеШаги.Добавить("ЯДобавляюПараметрыДляКоманды");
	ВсеШаги.Добавить("ЯСоздаюНеполныйТестовойФайлAuthors");

	Возврат ВсеШаги;
КонецФункции

Функция ИмяЛога() Экспорт
	Возврат "bdd.gitsync.feature";
КонецФункции


// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	ЯСоздаюНовыйОбъектГитрепозиторий()
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
	ВременныеФайлы.Удалить();
КонецПроцедуры

//Я инициализирую bare репозиторий во временном каталоге
Процедура ЯИнициализируюBareРепозиторийВоВременномКаталоге() Экспорт
	ГитРепозиторий = БДД.ПолучитьИзКонтекста("ГитРепозиторий");
	ВременныйКаталог = БДД.ПолучитьИзКонтекста("ВременныйКаталог");
	ГитРепозиторий.УстановитьРабочийКаталог(ВременныйКаталог);
	ПараметрыКоманды = Новый Массив;
	ПараметрыКоманды.Добавить("init");
	ПараметрыКоманды.Добавить("--bare");
	ГитРепозиторий.ВыполнитьКоманду(ПараметрыКоманды);

КонецПроцедуры

//Я создаю новый объект ГитРепозиторий
Процедура ЯСоздаюНовыйОбъектГитрепозиторий() Экспорт
	ГитРепозиторий = Новый ГитРепозиторий;
	БДД.СохранитьВКонтекст("ГитРепозиторий", ГитРепозиторий);
КонецПроцедуры

//Я сохраняю значение временного каталога в переменной "URLРепозитория"
Процедура ЯСохраняюЗначениеВременногоКаталогаВПеременной(Знач ИмяПеременной) Экспорт
	ВременныйКаталог = БДД.ПолучитьИзКонтекста("ВременныйКаталог");
	БДД.СохранитьВКонтекст(ИмяПеременной, ВременныйКаталог);
КонецПроцедуры

//я инициализирую каталог исходников
Процедура ЯИнициализируюКаталогИсходников() Экспорт
	
	ВременныйКаталог = БДД.ПолучитьИзКонтекста("ВременныйКаталог");
	
	ПутьКаталогаИсходников = ВременныйКаталог;

	СоздатьКаталог(ПутьКаталогаИсходников);

	БДД.СохранитьВКонтекст("ПутьКаталогаИсходников",Новый Файл(ПутьКаталогаИсходников));

КонецПроцедуры

//Я создаю тестовой файл AUTHORS
Процедура ЯСоздаюТестовойФайлAuthors() Экспорт
	
	ПутьКаталогаИсходников = БДД.ПолучитьИзКонтекста("ПутьКаталогаИсходников");
	ФайлАвторов = Новый ЗаписьТекста;
	ФайлАвторов.Открыть(ОбъединитьПути(ПутьКаталогаИсходников, "AUTHORS"), "utf-8");
	ФайлАвторов.ЗаписатьСтроку("Администратор=Администратор <admin@localhost>");
	ФайлАвторов.ЗаписатьСтроку("Отладка=Отладка <debug@localhost>");
	ФайлАвторов.Закрыть();

КонецПроцедуры

//Я записываю "0" в файл VERSION
Процедура ЯЗаписываюВФайлVersion(Знач НомерВерсии) Экспорт
	
	ПутьКаталогаИсходников = БДД.ПолучитьИзКонтекста("ПутьКаталогаИсходников");
	
	ПутьКФайлуВерсий = ОбъединитьПути(ПутьКаталогаИсходников,"VERSION");
	Попытка
		Запись = Новый ЗаписьТекста(ПутьКФайлуВерсий, "utf-8");
		Запись.ЗаписатьСтроку("<?xml version=""1.0"" encoding=""UTF-8""?>");
		Запись.ЗаписатьСтроку("<VERSION>" + НомерВерсии + "</VERSION>");
		Запись.Закрыть();
	Исключение
		Если Запись <> Неопределено Тогда
			ОсвободитьОбъект(Запись);
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;

КонецПроцедуры

//я инициализирую связь "ПутьКаталогаИсходников" с внешним репозиторием "URLРепозитория"
Процедура ЯИнициализируюСвязьСВнешнимРепозиторием(Знач ПеременнаяПутьКаталогаИсходников, Знач ПеременнаяURLРепозитория) Экспорт
	
	ГитРепозиторий = БДД.ПолучитьИзКонтекста("ГитРепозиторий");
	URLРепозитория = БДД.ПолучитьИзКонтекста(ПеременнаяURLРепозитория);
	ПутьКаталогаИсходников = БДД.ПолучитьИзКонтекста(ПеременнаяПутьКаталогаИсходников);
	
	ГитРепозиторий.УстановитьРабочийКаталог(ПутьКаталогаИсходников);
	ГитРепозиторий.Инициализировать();
	ПараметрыКоманды = Новый Массив;
	ПараметрыКоманды.Добавить("add");
	ПараметрыКоманды.Добавить("--all");
	ГитРепозиторий.ВыполнитьКоманду(ПараметрыКоманды);
	ГитРепозиторий.Закоммитить("тест");
	
	НастройкаОтправить = Новый НастройкаКомандыОтправить;
	НастройкаОтправить.УстановитьURLРепозиторияОтправки(URLРепозитория);
	НастройкаОтправить.ОтображатьПрогресс();
	НастройкаОтправить.ПерезаписатьИсторию();
	НастройкаОтправить.Отслеживать();
	НастройкаОтправить.ПолнаяОтправка();
	
	ГитРепозиторий.УстановитьНастройкуКомандыОтправить(НастройкаОтправить);
	
	ГитРепозиторий.Отправить();
	
КонецПроцедуры

//Я добавляю позиционный параметр для команды "gitsync" из переменной "URLРепозитория"
Процедура ЯДобавляюПозиционныйПараметрДляКомандыИзПеременной(Знач ИмяКоманды, Знач ИмяПеременной) Экспорт

	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	ЗначениеПеременной = БДД.ПолучитьИзКонтекста(ИмяПеременной);
	
	Команда.ДобавитьПараметр(ЗначениеПеременной);

КонецПроцедуры

//Я добавляю параметр "-tmpdir" для команды "gitsync" из переменной "ВременнаяДиректория"
Процедура ЯДобавляюПараметрДляКомандыИзПеременной(Знач Параметр, Знач ИмяКоманды, Знач ИмяПеременной) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	ЗначениеПеременной = БДД.ПолучитьИзКонтекста(ИмяПеременной);
	Команда.ДобавитьПараметр(СтрШаблон("%1 %2", Параметр, ЗначениеПеременной))
КонецПроцедуры

//Я устанавливаю путь выполнения команды "gitsync" к текущей библиотеке
Процедура ЯУстанавливаюПутьВыполненияКомандыКТекущейБиблиотеке(Знач ИмяКоманды) Экспорт
	
	ПутьГитсинк = ОбъединитьПути(КаталогГитсинк(), "src", "gitsync.os");
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	Команда.УстановитьКоманду("oscript");
	Команда.ДобавитьПараметр("-encoding=utf-8");
	Команда.ДобавитьПараметр(ОбернутьВКавычки(ПутьГитсинк));
	
КонецПроцедуры

//я скопировал каталог тестового хранилища конфигурации во временный каталог
Процедура ЯСкопировалКаталогТестовогоХранилищаКонфигурацииВоВременныйКаталог() Экспорт
	
	ВременныйКаталог = БДД.ПолучитьИзКонтекста("ВременныйКаталог");
	КопироватьФайл(ПутьКВременномуФайлуХранилища1С(),  ОбъединитьПути(ВременныйКаталог, "1cv8ddb.1CD"))

КонецПроцедуры

//Я создаю неполный тестовой файл AUTHORS
Процедура ЯСоздаюНеполныйТестовойФайлAuthors() Экспорт
	
	ПутьКаталогаИсходников = БДД.ПолучитьИзКонтекста("ПутьКаталогаИсходников");
	ФайлАвторов = Новый ЗаписьТекста;
	ФайлАвторов.Открыть(ОбъединитьПути(ПутьКаталогаИсходников, "AUTHORS"), "utf-8");
	ФайлАвторов.ЗаписатьСтроку("Отладка=Отладка <debug@localhost>");
	ФайлАвторов.Закрыть();

КонецПроцедуры

//Я добавляю параметры для команды "gitsync"
//|--storage-user Администратор|
//|-useVendorUnload|
Процедура ЯДобавляюПараметрыДляКоманды(Знач ИмяКоманды, Знач ТаблицаПараметров) Экспорт
	
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	Для Каждого Параметр из ТаблицаПараметров Цикл
		Команда.ДобавитьПараметр(Параметр[0])
	КонецЦикла

КонецПроцедуры


Функция ПутьКВременномуФайлуХранилища1С()
	
	Возврат ОбъединитьПути(КаталогFixtures(), "ТестовыйФайлХранилища1С.1CD");
	
КонецФункции

Функция КаталогFixtures()
	Возврат ОбъединитьПути(КаталогГитсинк(), "tests", "fixtures");
КонецФункции

Функция КаталогГитсинк()
	Возврат ОбъединитьПути(ТекущийСценарий().Каталог, "..", "..");
КонецФункции

Функция ОбернутьВКавычки(Знач Строка);
	Возврат """" + Строка + """";
КонецФункции

Функция КлючКоманды(Знач ИмяКоманды)
	Возврат "Команда-" + ИмяКоманды;
КонецФункции

Лог = Логирование.ПолучитьЛог(ИмяЛога());
//Лог.УстановитьУровень(Логирование.ПолучитьЛог("bdd").Уровень());
Лог.УстановитьУровень(УровниЛога.Отладка);
