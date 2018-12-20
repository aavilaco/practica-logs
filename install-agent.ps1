$WORKSPACE_ID="c83d5859-dc37-46a5-8def-5d303ac45992"
$WORKSPACE_KEY="utKkwR+PyNB8U1lwwcxIV0JCSSdrXQbQ7/Om9P4jz+VwM315lXJq/y9HZcDCtJ1mB+KlS2VGBcmsuxsfPvxIZA=="

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

cd ~
mkdir practica-logs
cd practica-logs

wget http://download.microsoft.com/download/C/6/D/C6D9900F-D149-457E-973E-63DB8F337ACA/MMASetup-i386.exe -OutFile agent-installer.exe
.\agent-installer.exe /c /t:"$pwd"

.\Setup.exe /qn AcceptEndUserLicenseAgreement=1 ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_ID=$WORKSPACE_ID OPINSIGHTS_WORKSPACE_KEY=$WORKSPACE_KEY OPINSIGHTS_WORKSPACE_AZURE_CLOUD_TYPE=0 

wget https://download.sysinternals.com/files/Sysmon.zip -OutFile Sysmon.zip
Unzip "$pwd\Sysmon.zip" "$pwd\sysmon"
cd sysmon

wget SYSMON_CONFIG -OutFile sysmon-config.xml

.\sysmon.exe -accepteula -i sysmon-config.xml
