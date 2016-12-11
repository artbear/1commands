# 1commands

Обсудить [![Join the chat at https://gitter.im/EvilBeaver/oscript-library](https://badges.gitter.im/EvilBeaver/oscript-library.svg)](https://gitter.im/EvilBeaver/oscript-library?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![GitHub release](https://img.shields.io/github/release/artbear/1commands.svg)](https://github.com/artbear/1commands/releases)

## Библиотека для упрощения работы c запуском различных приложений и командных файлов (cmd, bat, bash) из oscript.

Позволяет выполнять рутинные операции по запуску приложений и командных файлов системы.

Пример работы:
```bsl
Команда = Новый Команда;
Команда.УстановитьКоманду("oscript");

Команда.ДобавитьПараметр("-version");	

КодВозврата = Команда.Выполнить();
Сообщить(КодВозврата);

Сообщить(Команда.ПолучитьВывод());
```

или запуск командного файла
```bsl
КомандныйФайл = Новый КомандныйФайл;
КомандныйФайл.Создать();

КомандныйФайл.ДобавитьКоманду("@echo off");	
КомандныйФайл.ДобавитьКоманду("oscript -version");	

Сообщить(КомандныйФайл.ПолучитьСодержимоеФайла());

КодВозврата = КомандныйФайл.Выполнить();
Сообщить(КодВозврата);

Сообщить(КомандныйФайл.ПолучитьВывод());
```

Так же описание функциональности содержится в папке `features`. В прилагающихся `step_definitions` можно подсмотреть больше примеров.
