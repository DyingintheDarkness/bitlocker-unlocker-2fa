@REM https://github.com/DyingintheDarkness/bitlocker-unlocker-2fa
@REM AUTHOR DyingintheDarkness@github

@echo off
setlocal enableextensions enabledelayedexpansion
@REM 2fa code
set "code=%2 %3"
@REM password
set "password=%5"
set "encryptedFile=enc.txt"
set counter=0
set path=%CD%
@REM Powershell Path - Correct it for your system if it's failing to run it using 'where powershell.exe'
set powershell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
@REM Powershell Path - Correct it for your system if it's failing to run it using 'where cscript.exe'
set cscript=C:\Windows\System32\cscript.exe

for /f "usebackq delims=" %%G in (`%path%\OpenSSL-1.1.1h_win32\openssl.exe enc -d -aes-256-cbc -salt -pbkdf2 -in "%encryptedFile%" -k "%password%"`) do (
    if !counter! equ 0 (
        set "key=%%G"
    )
     if !counter! equ 1 (
        if "%%G" neq "%password%" (
            shutdown /s /t 0
        )
     )
     if !counter! equ 2 (
           set "pass=%%G"
    )
    
    set /a counter+=1
)

%powershell% -Command "Import-Module %path%\GoogleAuthenticator.ps1; $pin = Get-GoogleAuthenticatorPin -Secret '%key%' | Select-Object -ExpandProperty 'PIN Code'; if ($pin -eq '%code%') { Write-Host 'Code is valid.' } else { shutdown /s /t 0 }"
if %errorlevel% neq 0 (
    shutdown /s /t 0
)

%cscript% unlock.vbs %pass%
