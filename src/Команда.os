﻿//////////////////////////////////////////////////////////////////////////
// Работа с командными файлами

#Использовать logos
#Использовать asserts


Перем Приложение;
Перем ИспользуетсяЕдинаяСтрокаЗапуска;
Перем Параметры;
Перем РабочийКаталог;
Перем ВыводКоманды;
Перем КодировкаВывода;
Перем КодВозврата;
Перем ИспользуемКомандныйПроцессор;
Перем ПроверяемКодВозврата;
Перем МинимальныйОжидаемыйКодВозврата;
Перем МаксимальныйОжидаемыйКодВозврата;
Перем ПериодОпросаВМиллисекундах;
Перем НемедленныйВывод;
Перем ПодключенныеЛоги;
Перем ОбработчикОжиданияПроцесса;
Перем ДополнительныеПараметрыОбработчика;
Перем ПерехватыватьПотоки;

Перем ВерсияБольшеИлиРавна21;
Перем ЭтоWindows;
Перем Лог;

Перем ПеременныеСредыПроцесса;

// Выполнение произвольной команды
//
//  Возвращаемое значение:
//   Число - код возврата команды
//
Функция Исполнить() Экспорт

    ПроверитьВозможностьВыполненияКоманды();

	КодВозврата = ЗапуститьИПодождать();

	Лог.Отладка("Код возврата равен %1", КодВозврата);
    Возврат КодВозврата;

КонецФункции

// Запуск на выполнение процесса
//
//  Возвращаемое значение:
//   Процесс - объект класса Процесс
//
Функция ЗапуститьПроцесс() Экспорт

    ПроверитьВозможностьВыполненияКоманды();

	Процесс = ЗапуститьПроцессКоманды();

	Лог.Отладка("Запущен процесс с идентификатором <%1>", Процесс.Идентификатор);

	Возврат Процесс;

КонецФункции

// Получить имя лога продукта
//
// Возвращаемое значение:
//  Строка   - имя лога продукта
//
Функция ИмяЛога() Экспорт
	Возврат "oscript.lib.commands";
КонецФункции

// Установить путь команды.
//	Если в пути команды есть пробелы, они обрамляются кавычками
// ВАЖНО: метод принимает именно путь к приложению,
//		параметры приложения здесь передавать не следует!!
// Для передачи параметров нужно использовать метод "УстановитьСтрокуЗапуска"
//
//
//  Параметры:
//   ПутьКоманды - Путь команды (Строка)
//
Процедура УстановитьКоманду(Знач ПутьКоманды) Экспорт
	Приложение = ПутьКоманды;
	ИспользуетсяЕдинаяСтрокаЗапуска = Ложь;
КонецПроцедуры

// Установить строку запуска команды.
// В этом случае обрамления кавычками не выполняется.
//
//  Параметры:
//   СтрокаЗапуска - строка запуска команды (Строка)
//
Процедура УстановитьСтрокуЗапуска(Знач СтрокаЗапуска) Экспорт
	Приложение = СтрокаЗапуска;
	ИспользуетсяЕдинаяСтрокаЗапуска = Истина;
КонецПроцедуры

// Получить путь команды.
//
//  Возвращаемое значение:
//   Строка - Путь команды
//
Функция ПолучитьКоманду() Экспорт
    Возврат Приложение;
КонецФункции

// Полная строка запуска команды, со всеми параметрами
//
//  Возвращаемое значение:
//   Строка - строка запуска
//
Функция СтрокаЗапуска() Экспорт
	Возврат СформироватьСтрокуЗапускаПроцесса();	
КонецФункции
// Устанавливает переменные среды для процесса
//
// Параметры:
//   ППеременныеСредыПроцесса - Соответствие - где ключ имя переменной, а значение - значение переменной
//
Процедура УстановитьПеременныеСреды(ППеременныеСредыПроцесса) Экспорт
	ПеременныеСредыПроцесса = ППеременныеСредыПроцесса;
КонецПроцедуры

// Устанавливает признак необходимости перехватывать потоки
// по умолчанию потоки всегда перехватываются
//
// Параметры:
//   ППерехватыватьПотоки - Булево - признак необходимости перехвата потоков процесса
//
Процедура ПерехватыватьПотоки(ППерехватыватьПотоки) Экспорт
	ПерехватыватьПотоки = ППерехватыватьПотоки;
КонецПроцедуры

// Добавить параметр команды.
//
//  Параметры:
//   Строка - новый единичный параметр или все параметры в одной строке
//
Процедура ДобавитьПараметр(Знач Параметр) Экспорт
	Параметры.Добавить(Параметр);
КонецПроцедуры

// Добавить параметры команды.
//
//  Параметры:
//   Массив - массив параметров
//
Процедура ДобавитьПараметры(Знач МассивПараметров) Экспорт
	Для каждого Параметр Из МассивПараметров Цикл
		Параметры.Добавить(Параметр);
	КонецЦикла;
КонецПроцедуры

// Установить новые параметры команды.
// Может использовать для очистки параметров. Для этого нужно передать пустую строку
//
//  Параметры:
//   Строка - параметры в одной строке
//
Процедура УстановитьПараметры(Знач СтрокаПараметров) Экспорт
	Параметры = Новый Массив;
	Параметры.Добавить(СтрокаПараметров);
КонецПроцедуры

// Получить параметры команды.
//
//  Возвращаемое значение:
//   Массив - Параметры команды
//
Функция ПолучитьПараметры() Экспорт
    Возврат Параметры;
КонецФункции

// Получить вывод выполненной команды.
//
//  Возвращаемое значение:
//   Строка - Вывод команды
//
Функция ПолучитьВывод() Экспорт
    Возврат ВыводКоманды;
КонецФункции

// Получить код возврата выполненной команды.
//
//  Возвращаемое значение:
//   Число - код возврата команды
//
Функция ПолучитьКодВозврата() Экспорт
    Возврат КодВозврата;
КонецФункции

// Управляет мгновенным выводом лога команды
//
// Параметры:
//   НемедленныйПоказ - Булево
//		Ложь: показывает вывод только после завершения выполнения команды
//		Истина: показ вывода выполняется почти сразу, после появления очередной порции сообщений от команды
//
Процедура ПоказыватьВыводНемедленно(Знач НемедленныйПоказ) Экспорт
	НемедленныйВывод = НемедленныйПоказ;
КонецПроцедуры

// Устанавливает передачу вывода команды в дополнительный лог
//
// Параметры:
//   ИмяЛогаИлиЛог - <Строка, Лог> - имя лога или объект лога
//
Процедура ДобавитьЛогВыводаКоманды(Знач ИмяЛогаИлиЛог) Экспорт

	НовыйЛог = ИмяЛогаИлиЛог;
	Если ТипЗнч(ИмяЛогаИлиЛог) = Тип("Строка") Тогда
		НовыйЛог = Логирование.ПолучитьЛог(ИмяЛогаИлиЛог);
	КонецЕсли;

	ПодключенныеЛоги.Добавить(НовыйЛог);

КонецПроцедуры

// Устанавливает обработчик ожидания для процесса
//
// Параметры:
//   Обработчик - Произвольный - класс реализующих метод <ОбработкаОжиданияПроцесса>
//   ППериодОпросаВМиллисекундах - Число - период вызова обработчика ожидания, мс (по умолчанию 5000)
//   ДополнительныеПараметры - Структура - дополнительные параметры передаваемые в обработчик ожидания
//
Процедура УстановитьОбработчикОжидания(Обработчик, Знач ППериодОпросаВМиллисекундах = 5000,
	ДополнительныеПараметры = Неопределено) Экспорт

	ОбработчикОжиданияПроцесса = Обработчик;
	ПериодОпросаВМиллисекундах = ППериодОпросаВМиллисекундах;
	ДополнительныеПараметрыОбработчика = ДополнительныеПараметры;
КонецПроцедуры

// Установить ожидаемый код возврата
// После исполнения команды будет выброшено исключение, если полученный код возврата не совпадает с ожидаемым
//
// Параметры:
//   ОжидаемыйКодВозврата - Число
//
Процедура УстановитьПравильныйКодВозврата(Знач ПарамОжидаемыйКодВозврата) Экспорт
	УстановитьДиапазонПравильныхКодовВозврата(ПарамОжидаемыйКодВозврата, ПарамОжидаемыйКодВозврата);
КонецПроцедуры

// Установить диапазон ожидаемых кодов возврата
// После исполнения команды будет выброшено исключение, если полученный код возврата не попадает в указанный диапазон
//
// Параметры:
//   МинимальныйОжидаемыйКодВозврата - Число
//   МаксимальныйОжидаемыйКодВозврата - Число
//
Процедура УстановитьДиапазонПравильныхКодовВозврата( Знач ПарамМинимальныйОжидаемыйКодВозврата,
		Знач ПарамМаксимальныйОжидаемыйКодВозврата) Экспорт

	ПроверяемКодВозврата = Истина;
	МинимальныйОжидаемыйКодВозврата = ПарамМинимальныйОжидаемыйКодВозврата;
	МаксимальныйОжидаемыйКодВозврата = ПарамМаксимальныйОжидаемыйКодВозврата;

КонецПроцедуры

// Установить кодировку вывода для выполнения команды.
//
//  Параметры:
//   Строка, Неопределено - кодировка вывода
//		Если Неопределено, кодировка сбрасывается и используется значение по умолчанию от операционной системы
//
Процедура УстановитьКодировкуВывода(Знач НоваяКодировкаВывода) Экспорт
    КодировкаВывода = НоваяКодировкаВывода;
КонецПроцедуры

// Получить кодировка вывода выполняемой команды.
//
//  Возвращаемое значение:
//   Строка - кодировка вывода команды
//
Функция ПолучитьКодировкуВывода() Экспорт
    Возврат КодировкаВывода;
КонецФункции

// Установить период опроса завершения.
//
//  Параметры:
//   ПериодОпросаВМиллисекундах - период опроса, в миллисекундах
//
Процедура УстановитьПериодОпросаЗавершения(Знач ПарамПериодОпросаВМиллисекундах) Экспорт
    ПериодОпросаВМиллисекундах = ПарамПериодОпросаВМиллисекундах;
КонецПроцедуры

// Установить новый рабочий каталог.
//
//  Параметры:
//   Строка - Путь к новому рабочему каталогу
//
Процедура УстановитьРабочийКаталог(Знач НовыйРабочийКаталог) Экспорт
    РабочийКаталог = НовыйРабочийКаталог;
КонецПроцедуры

// Получить текущий рабочий каталог.
//
//  Возвращаемое значение:
//   Строка - Путь к рабочему каталогу
//
Функция ПолучитьРабочийКаталог() Экспорт
    Возврат РабочийКаталог;
КонецФункции

// Установить признак исполнения через командный процессор системы.
// 	По умолчанию он включен.
//
// Параметры:
//   ИспользуемКомандныйПроцессор - Булево - Включить/Выключить использование командного процессора системы.
//
Процедура УстановитьИсполнениеЧерезКомандыСистемы(Знач ПарамИспользуемКомандныйПроцессор) Экспорт
	ИспользуемКомандныйПроцессор = ПарамИспользуемКомандныйПроцессор;
КонецПроцедуры

// Оборачивает переданную строку в кавычки, если она еще не обернута.
//
// Параметры:
//   Строка - Строка - Входящая строка
//
//  Возвращаемое значение:
//   Строка - Строка, обернутая в кавычки
//
Функция ОбернутьВКавычки(Знач Строка) Экспорт

    Если Лев(Строка, 1) = """" и Прав(Строка, 1) = """" Тогда
        Возврат Строка;
    Иначе
        Возврат """" + Строка + """";
    КонецЕсли;

КонецФункции

//////////////////////////////////////////////////////////////////////////
// Служебные процедуры и функции

// Установить вывод последней выполненной команды.
//
// Параметры:
//   Сообщение - Строка - Вывод команды
//
Процедура УстановитьВывод(Знач Сообщение)
    ВыводКоманды = Сообщение;
КонецПроцедуры

// Проверяет возможность выполнить команду.
//
Процедура ПроверитьВозможностьВыполненияКоманды()

    Ожидаем.Что(ПолучитьРабочийКаталог(), "Рабочий каталог не установлен.").Заполнено();

    Лог.Отладка("РабочийКаталог: " + ПолучитьРабочийКаталог());

КонецПроцедуры

// Запустить команду в операционной системе с ожиданием ее выполнения
//
// Параметры:
//   Параметры - Массив - Массив строковых аргументов, передаваемых в командную
//		строку. Добавляются после исполняемого файла.
//
//  Возвращаемое значение:
//   Число - Код возврата приложения
//
Функция ЗапуститьИПодождать()

	СтрокаЗапуска = СформироватьСтрокуЗапускаПроцесса();

	ПерехватыватьПотоки = Истина;

	Процесс = ЗапуститьПроцессКоманды(ПерехватыватьПотоки);

	ПолучитьВыводПокаПроцессИсполняется(Процесс);

	КодВозврата = Процесс.КодВозврата;
	ПроверитьКодВозврата(КодВозврата);

    Возврат КодВозврата;

КонецФункции


// Запустить команду в операционной системе с ожиданием ее выполнения
//
// Параметры:
//   Параметры - Массив - Массив строковых аргументов, передаваемых в командную
//		строку. Добавляются после исполняемого файла.
//
// Возвращаемое значение:
//   Процесс - запущенный процесс
//
Функция ЗапуститьПроцессКоманды(ПерехватыватьПотоки = Ложь)

	СтрокаЗапуска = СформироватьСтрокуЗапускаПроцесса();

	Попытка

		Если КодировкаВывода = Неопределено Тогда
			Процесс = СоздатьПроцесс(СтрокаЗапуска, РабочийКаталог, ПерехватыватьПотоки, ПерехватыватьПотоки, ,
				ПеременныеСредыПроцесса);
		Иначе
			Процесс = СоздатьПроцесс(СтрокаЗапуска, РабочийКаталог, ПерехватыватьПотоки, ПерехватыватьПотоки,
				КодировкаВывода, ПеременныеСредыПроцесса);
		КонецЕсли;

    Исключение

        Инфо = ИнформацияОбОшибке();

        // TODO код проверки на регулярку (ниже) убрать после исправления в движке OneScript
        РегуляркаОшибкиПеременныхСреды = Новый РегулярноеВыражение(
			"\(System\.ArgumentException\):[^:]+:.*HOME[^:]+:.*home");
        Если РегуляркаОшибкиПеременныхСреды.Совпадает(Инфо.Описание) Тогда
            Лог.Предупреждение("Возникла ошибка, связанная с переменными среды при старте нового процесса
                |%1
                |
                |Выполняю старт процесса без указания переменных среды.", Инфо.Описание);

            Лог.Отладка("Полное описание ошибки:
                |%1", Инфо.ПодробноеОписаниеОшибки());

            Если КодировкаВывода = Неопределено Тогда
                Процесс = СоздатьПроцесс(СтрокаЗапуска, РабочийКаталог, ПерехватыватьПотоки, ПерехватыватьПотоки);
            Иначе
				Процесс = СоздатьПроцесс(СтрокаЗапуска, РабочийКаталог, ПерехватыватьПотоки, ПерехватыватьПотоки,
				КодировкаВывода);
            КонецЕсли;
        Иначе
            ВызватьИсключение Инфо.ПодробноеОписаниеОшибки();
        КонецЕсли;

	КонецПопытки;

	Процесс.Запустить();

	Возврат Процесс;

КонецФункции

Функция СформироватьСтрокуЗапускаПроцесса()
    Перем ПутьПриложения;

	ПутьПриложения = Приложение;

    СтрокаЗапуска = "";
    СтрокаДляЛога = "";
    Для Каждого Параметр Из Параметры Цикл

        СтрокаЗапуска = СтрокаЗапуска + " " + Параметр;

        Если Лев(Параметр, 2) <> "/P" и Лев(Параметр, 25) <> "/ConfigurationRepositoryP" Тогда
            СтрокаДляЛога = СтрокаДляЛога + " " + Параметр;
        КонецЕсли;

    КонецЦикла;

    Если НЕ ИспользуетсяЕдинаяСтрокаЗапуска И Найти(ПутьПриложения, " ") > 0 Тогда
    	ПутьПриложения = ОбернутьВКавычки(ПутьПриложения);
    КонецЕсли;
    Лог.Отладка("Строка запуска <%1>", ПутьПриложения + СтрокаДляЛога);

    СтрокаЗапуска = ПутьПриложения + СтрокаЗапуска;

	Если ИспользуемКомандныйПроцессор Тогда
		Если ЭтоWindows Тогда
			ШаблонЗапуска = "cmd /c ""%1""";
		Иначе
			ШаблонЗапуска = "sh -c '%1'";
		КонецЕсли;

		СтрокаЗапуска = СтрШаблон(ШаблонЗапуска, СтрокаЗапуска);
	КонецЕсли;
	Лог.Отладка("Полная строка запуска <%1>", СтрокаЗапуска);

	Возврат СтрокаЗапуска;
КонецФункции // СформироватьСтрокуЗапускаПроцесса()

Процедура ОбработкаОжиданияПроцесса(Процесс, ЗаписьXML)

	ПрерываниеПроцесса = Ложь;
	СтандартнаяОбработка = Истина;
	УстановленОбработчикОжиданияПроцесса = НЕ ОбработчикОжиданияПроцесса = Неопределено;

	Если ДополнительныеПараметрыОбработчика = Неопределено Тогда
		ДополнительныеПараметры = Новый Структура();
	Иначе
		ДополнительныеПараметры = ДополнительныеПараметрыОбработчика;
	КонецЕсли;

	Если УстановленОбработчикОжиданияПроцесса Тогда

		Обработчик = ОбработчикОжиданияПроцесса;

		Лог.Отладка("Вызов обработчика ожидания");
		Попытка
			Обработчик.ОбработкаОжиданияПроцесса(Процесс,
												ПрерываниеПроцесса,
												ПериодОпросаВМиллисекундах,
												ДополнительныеПараметры,
												СтандартнаяОбработка);
		Исключение
			Лог.Отладка(ОписаниеОшибки());
			ВызватьИсключение КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		КонецПопытки;

	КонецЕсли;

	Если СтандартнаяОбработка Тогда

		Если ПерехватыватьПотоки
			И Процесс.ПотокВывода.ЕстьДанные
			ИЛИ Процесс.ПотокОшибок.ЕстьДанные Тогда

			ОбработатьОчереднуюСтрокуВывода(Процесс.ПотокВывода, ЗаписьXML);
			ОбработатьОчереднуюСтрокуВывода(Процесс.ПотокОшибок, ЗаписьXML, Истина);

		КонецЕсли;

	КонецЕсли;

	Если ПрерываниеПроцесса Тогда

		Процесс.Завершить();

	КонецЕсли;

КонецПроцедуры

Процедура ПолучитьВыводПокаПроцессИсполняется(Процесс)

	ЗаписьXML = Новый ЗаписьXML();
	ЗаписьXML.УстановитьСтроку();

	Если ПериодОпросаВМиллисекундах <> 0 Тогда
		Приостановить(ПериодОпросаВМиллисекундах);
		ОбработкаОжиданияПроцесса(Процесс, ЗаписьXML);
	КонецЕсли;

	Пока НЕ Процесс.Завершен Цикл

		Если ПериодОпросаВМиллисекундах <> 0 Тогда
			Приостановить(ПериодОпросаВМиллисекундах);
		КонецЕсли;

		ОбработкаОжиданияПроцесса(Процесс, ЗаписьXML);

	КонецЦикла;

	// Дочитывает данные после завершения ?? Хотя процесс не может завершиться пока есть данные в потоке чтения
	Если ПерехватыватьПотоки
		И Процесс.ПотокВывода.ЕстьДанные
		ИЛИ Процесс.ПотокОшибок.ЕстьДанные Тогда

		ОбработатьОчереднуюСтрокуВывода(Процесс.ПотокВывода, ЗаписьXML);
		ОбработатьОчереднуюСтрокуВывода(Процесс.ПотокОшибок, ЗаписьXML, Истина);

	КонецЕсли;

	РезультатРаботыПроцесса = ЗаписьXML.Закрыть();

	Лог.Отладка("Длина вывода %1, количество строк %2", СтрДлина(РезультатРаботыПроцесса),
					СтрЧислоСтрок(РезультатРаботыПроцесса));

	УстановитьВывод(РезультатРаботыПроцесса);

КонецПроцедуры

Функция ОбработатьОчереднуюСтрокуВывода(ПотокПроцесса, ЗаписьXML, Знач ЭтоВыводОшибки = Ложь)
	Рез = "";
	Если ПотокПроцесса.ЕстьДанные Тогда
		Рез = ПотокПроцесса.Прочитать();
	КонецЕсли;

	Если Рез <> "" Тогда
		Если ЗначениеЗаполнено(ПодключенныеЛоги) Тогда
			Для каждого ПодключенныйЛог Из ПодключенныеЛоги Цикл
				Если ЭтоВыводОшибки Тогда
					ПодключенныйЛог.Ошибка(Рез);
				Иначе
					ПодключенныйЛог.Информация(Рез);
				КонецЕсли;
			КонецЦикла;
		Иначе
			ЗаписьXML.ЗаписатьБезОбработки(Рез + Символы.ПС);

			Если НемедленныйВывод Тогда
				Сообщить(Рез);
			КонецЕсли;
		КонецЕсли;

	КонецЕсли;

	Возврат Рез;
КонецФункции

Процедура ПроверитьКодВозврата(Знач КодВозврата)
	Если ПроверяемКодВозврата Тогда
		Если КодВозврата < МинимальныйОжидаемыйКодВозврата или КодВозврата > МаксимальныйОжидаемыйКодВозврата Тогда
			Если МинимальныйОжидаемыйКодВозврата <> МаксимальныйОжидаемыйКодВозврата Тогда
				ТекстОшибки = СтрШаблон(
					"Ожидали, что код возврата <%1> команды <%2> совпадет с ожидаемым диапазоном <%3>-<%4>, а это не так!
					|Лог команды:
					|%5",
					КодВозврата, Приложение, МинимальныйОжидаемыйКодВозврата, МаксимальныйОжидаемыйКодВозврата,
					ПолучитьВывод());
			Иначе
				ТекстОшибки = СтрШаблон("Ожидали, что код возврата <%1> команды <%2> совпадет с ожидаемым <%3>, а это не так!
					|Лог команды:
					|%4",
					КодВозврата, Приложение, МинимальныйОжидаемыйКодВозврата, ПолучитьВывод());
			КонецЕсли;
			Ожидаем.Что(КодВозврата, СтрШаблон("%1, вывод %2", ТекстОшибки, ВыводКоманды)).
				БольшеИлиРавно(МинимальныйОжидаемыйКодВозврата).
				МеньшеИлиРавно(МаксимальныйОжидаемыйКодВозврата);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

// Инициализация работы библиотеки.
// Задает минимальные настройки.
//
Процедура Инициализация()

    Лог = Логирование.ПолучитьЛог(ИмяЛога());

	СистемнаяИнформация = Новый СистемнаяИнформация;
	ЭтоWindows = Найти(НРег(СистемнаяИнформация.ВерсияОС), "windows") > 0;

	РабочийКаталог = ".";
	ВыводКоманды = "";
    КодировкаВывода = Неопределено;//КодировкаТекста.UTF8;
	Параметры = Новый Массив;

	ИспользуетсяЕдинаяСтрокаЗапуска = Ложь;
	ИспользуемКомандныйПроцессор = Истина;

	ПроверяемКодВозврата = Ложь;
	ОжидаемыйКодВозврата = 0;
	ПерехватыватьПотоки = Истина;

	ПериодОпросаВМиллисекундах = 100;
	НемедленныйВывод = Ложь;

	ПеременныеСредыПроцесса = ПеременныеСреды();

	ПодключенныеЛоги = Новый Массив;
	ОбработчикОжиданияПроцесса = Неопределено;

КонецПроцедуры

Инициализация();
