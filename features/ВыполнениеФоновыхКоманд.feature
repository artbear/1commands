# language: ru

Функциональность: Выполнение фоновых команд

Как разработчик
Я хочу иметь возможность выполнять несколько команд в фоне и ожидать их завершение
Чтобы я мог проще автоматизировать больше действий на OneScript

Контекст:
    Допустим Я выключаю отладку лога с именем "oscript.lib.commands"
    И Я очищаю параметры команды "git" в контексте
    И Я очищаю параметры команды "oscript" в контексте
    И Я очищаю параметры фоновых команд в контексте

Сценарий: Выполнение 2х фоновых команд

    Когда Я добавляю параметры для команды "oscript"
    | features/step_definitions/fixtures/ДолгоеВыполнение.os |
    | 1 |
    И Я добавляю фоновую команду "oscript"

    И Я добавляю параметры для команды "oscript"
    | features/step_definitions/fixtures/ДолгоеВыполнение.os |
    | 1 |
    И Я добавляю фоновую команду "oscript"

    # И Я устанавливаю период опроса завершения фоновых команд в 1 миллисекунду
    И я выполняю фоновые команды с таймаутом завершения в 2000 миллисекунд
    И Код возврата фоновых команд равен 0

Сценарий: Завершение команд по таймауту

    Когда Я добавляю параметры для команды "oscript"
    | features/step_definitions/fixtures/ДолгоеВыполнение.os |
    | 1 |
    И Я добавляю фоновую команду "oscript"

    И Я добавляю параметры для команды "oscript"
    | features/step_definitions/fixtures/ДолгоеВыполнение.os |
    | 1 |
    И Я добавляю фоновую команду "oscript"

    И я выполняю фоновые команды с таймаутом завершения в 5 миллисекунд
    И есть ошибки выполнения фоновых команд
    | Не завершена команда - |
