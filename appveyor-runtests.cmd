@echo on
@chcp 65001

set OSCRIPT=%ProgramFiles(x86)%\OneScript

@echo .
@echo =======================  =======================  =======================  =======================  
@echo .
@echo .

@rem call 1bdd features -junit-out ./bdd-log.xml
@call opm test

@if %ERRORLEVEL%==2 GOTO good_exit_bdd
@if %ERRORLEVEL%==0 GOTO good_exit_bdd

dir .\tests\

exit /B 1

:good_exit_bdd

dir .\tests\

exit /B 0
