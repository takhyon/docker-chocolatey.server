FROM microsoft/iis

MAINTAINER Salvatore Realmuto <srealmuto@ise.com>

RUN powershell -NoProfile -Command Set-ExecutionPolicy Unrestricted

RUN powershell -NoProfile -Command Add-WindowsFeature NET-Framework-45-ASPNET; \
    Add-WindowsFeature Web-Net-Ext45; \
    Add-WindowsFeature Web-Asp-Net45; \
    Add-WindowsFeature  Web-ISAPI-Ext; \
    Add-WindowsFeature  Web-ISAPI-Filter

RUN powershell -NoProfile -Command \
    $env:chocolateyUseWindowsCompression = 'false'; \
    "iwr https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression"

RUN powershell -NoProfile -Command choco install chocolatey.server -y

RUN powershell -NoProfile -Command \
    New-WebAppPool -Name chocolatey.server; \
    Set-ItemProperty "IIS:\AppPools\chocolatey.server" -Name "processModel.loadUserProfile" -Value "True"

RUN powershell -NoProfile -Command \
    Import-Module IISAdministration; \
    Import-Module WebAdministration; \
    New-IISSite -Name "Chocolatey" -PhysicalPath C:\tools\chocolatey.server -BindingInformation "*:8000:"; \
    Set-ItemProperty "IIS:\Sites\Chocolatey" ApplicationPool chocolatey.server

EXPOSE 8000
