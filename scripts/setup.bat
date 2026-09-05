@echo off
echo =====================================================
echo   Configuration de l'environnement PowerBI-AI-Journey
echo =====================================================
echo.

:: 1. Vérifier si Python est installé
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERREUR] Python n'est pas trouve dans le PATH.
    pause
    exit /b 1
)
echo [OK] Python est installe.

:: 2. Création de l'environnement virtuel (venv)
IF NOT EXIST "venv" (
    echo [INFO] Creation de l'environnement virtuel "venv"...
    python -m venv venv
) ELSE (
    echo [OK] L'environnement venv existe deja.
)

:: 3. Activation de l'environnement
echo [INFO] Activation de l'environnement...
call venv\Scripts\activate.bat

:: 4. Installation des dépendances
IF EXIST "requirements.txt" (
    echo [INFO] Mise a jour des bibliotheques Python a partir de requirements.txt...
    pip install --upgrade pip
    pip install -r requirements.txt
) ELSE (
    echo [ATTENTION] requirements.txt introuvable. Creation automatique...
    pip freeze > requirements.txt
)
echo [OK] Dependances installees.

:: 5. Création du fichier .env pour Power BI et l'IA
IF NOT EXIST ".env" (
    echo [INFO] Creation du fichier .env...
    (
        echo # =========================================
        echo # Configuration PowerBI-AI-Journey
        echo # =========================================
        echo.
        echo # Connexion Power BI (Phase 1, 2, 6)
        echo POWERBI_TENANT_ID=Votre_Tenant_ID_Azure
        echo POWERBI_CLIENT_ID=Votre_Client_ID
        echo POWERBI_CLIENT_SECRET=Votre_Secret
        echo.
        echo # Connexion Base de donnees (Pour Power Query / Dataflows)
        echo SQL_SERVER=localhost
        echo SQL_DATABASE=nom_de_votre_bdd
        echo SQL_USER=user
        echo SQL_PASSWORD=mot_de_passe
        echo.
        echo # Cles API pour l'IA (Phases 8, 9, 10)
        echo OPENAI_API_KEY=VOTRE_CLE_OPENAI
        echo ANTHROPIC_API_KEY=VOTRE_CLE_ANTHROPIC
    ) > .env
    echo [OK] Fichier .env cree. Pensez a remplir vos identifiants !
) ELSE (
    echo [OK] Le fichier .env existe deja.
)

:: 6. Vérification de Git (Ne touche pas à votre historique)
IF NOT EXIST ".git" (
    echo [INFO] Initialisation du depot Git...
    git init
) ELSE (
    echo [OK] Depot Git deja initialise. Historique conserve.
)

:: 7. Création des dossiers data
IF NOT EXIST "data\raw" mkdir data\raw
IF NOT EXIST "data\processed" mkdir data\processed
echo [OK] Structure de dossiers "data" verifiee.

:: 8. Création du Kernel Jupyter dédié à ce projet (Pour éviter les conflits avec vos autres projets)
python -m ipykernel install --user --name=powerbi_ai_env --display-name="PowerBI AI Journey" >nul 2>&1
echo [OK] Kernel Jupyter "PowerBI AI Journey" enregistre.

echo.
echo =====================================================
echo   Configuration terminee !
echo   Remplissez vos identifiants dans le fichier .env
echo   Lancez le projet avec le fichier run.bat
echo =====================================================
pause