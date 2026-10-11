@echo off
title Desplegando Conexion_NOVA_java_BD

echo ==========================================
echo        DESPLEGANDO NOVAMARKET
echo ==========================================

echo.
echo [1/5] Compilando proyecto...
call mvn clean package

if errorlevel 1 (
    echo.
    echo ERROR: La compilacion fallo.
    pause
    exit /b
)

echo.
echo [2/5] Deteniendo Tomcat...
call "C:\Users\USUARIO\OneDrive\Documentos\apache-tomcat-9.0.120\apache-tomcat-9.0.120\bin\shutdown.bat"

timeout /t 3 >nul

echo.
echo [3/5] Eliminando despliegue anterior...
rmdir /S /Q "C:\Users\USUARIO\OneDrive\Documentos\apache-tomcat-9.0.120\apache-tomcat-9.0.120\webapps\Conexion_NOVA_java_BD" 2>nul
del /Q "C:\Users\USUARIO\OneDrive\Documentos\apache-tomcat-9.0.120\apache-tomcat-9.0.120\webapps\Conexion_NOVA_java_BD.war" 2>nul

echo.
echo [4/5] Copiando nuevo WAR...
copy /Y "C:\Users\USUARIO\OneDrive\Documentos\mi preyectos programacion\Conexion_NOVA_java_BD\target\Conexion_NOVA_java_BD.war" "C:\Users\USUARIO\OneDrive\Documentos\apache-tomcat-9.0.120\apache-tomcat-9.0.120\webapps\"

echo.
echo [5/5] Iniciando Tomcat...
call "C:\Users\USUARIO\OneDrive\Documentos\apache-tomcat-9.0.120\apache-tomcat-9.0.120\bin\startup.bat"

echo.
echo ==========================================
echo   DESPLIEGUE FINALIZADO CORRECTAMENTE
echo ==========================================
echo.
pause