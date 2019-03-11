﻿#Использовать fs

// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd

Перем БДД; //контекст фреймворка 1bdd
Перем ЛокальныеВременныеФайлы;

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯСкопировалКаталогТестовогоХранилищаКонфигурацииРасширенияВКаталогИзПеременной");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт

	ЛокальныеВременныеФайлы = Новый МенеджерВременныхФайлов;

КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
	ЛокальныеВременныеФайлы.Удалить();

КонецПроцедуры


//я скопировал каталог тестового хранилища конфигурации расширения в каталог из переменной "КаталогХранилища1С"
Процедура ЯСкопировалКаталогТестовогоХранилищаКонфигурацииРасширенияВКаталогИзПеременной(Знач ИмяПеременной) Экспорт
	КаталогХранилища1С = БДД.ПолучитьИзКонтекста(ИмяПеременной);
	ФС.КопироватьСодержимоеКаталога(ПутьКВременномуФайлуХранилища1С(), КаталогХранилища1С);
	// КопироватьФайл(ПутьКВременномуФайлуХранилища1С(), ОбъединитьПути(КаталогХранилища1С, "1cv8ddb.1CD"));
КонецПроцедуры

Функция ПутьКВременномуФайлуХранилища1С()
	
	Возврат ОбъединитьПути(КаталогFixtures(), "extension_storage");
	
КонецФункции

Функция КаталогFixtures()
	Возврат ОбъединитьПути(КаталогГитсинк(), "tests", "fixtures");
КонецФункции

Функция КаталогГитсинк()
	Возврат ОбъединитьПути(ТекущийСценарий().Каталог, "..", "..", "..");
КонецФункции
