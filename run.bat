@echo off
:: Active l'environnement virtuel du projet
call venv\Scripts\activate.bat

echo.
echo 		    Bonjour Lovatahiana !
echo Tonga soa eto amin'ny tontolon'ny PowerBI AI Journey..
echo.
echo =====================================================
echo   Tontolon'ny "PowerBI AI Journey" misokatra hoanao!
echo =====================================================
echo.
echo Ireto misy safidy vitsivitsy:
echo.
echo   [1] Lancer Jupyter Notebook (dans le dossier notebooks)
echo   [2] Ouvrir un terminal Python interactif
echo   [3] Executer un script du dossier "scripts" (ex: script.py)
echo   [4] Quitter
echo.
set /p choice="Ataovy ary ny safidinao (1, 2, 3 ou 4) : "

if "%choice%"=="1" (
    echo Eo am-pandefasana ny Jupyter nosafidinao...
    jupyter notebook "notebooks"
) else if "%choice%"=="2" (
    echo Eo am-panokafana ny terminal Python nosafidinao...
    python
) else if "%choice%"=="3" (
    set /p script_name="Ampidiro ary ny script (ex: connect_powerbi.py) : "
    python "scripts\%script_name%"
) else (
    echo Fermeture du script.
    pause
)