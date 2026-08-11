; Installer Windows di ThermPy.
;
; Compilazione:
;   & "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe" installer\ThermPy.iss
;
; Prerequisito: la distribuzione PyInstaller deve esistere in SourceRoot, cioe'
; aver gia' eseguito  py -3.14 -m PyInstaller packaging/thermpy.spec --noconfirm
; nel repository del codice sorgente.

#define AppName "ThermPy"
#define AppVersion "1.1.0"
#define AppPublisher "ThermPy"
#define AppExe "ThermPy.exe"
#define SourceRoot "..\..\pytemp\dist\ThermPy"
#define IconFile "..\..\pytemp\thermpy\assets\thermpy.ico"

[Setup]
; AppId identifica il prodotto negli aggiornamenti e nella disinstallazione:
; cambiarlo farebbe apparire una seconda voce in "App installate" invece di
; aggiornare quella esistente.
AppId={{8E4C1F92-6A3D-4B57-9E21-7C0D5A8F3B64}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
VersionInfoVersion={#AppVersion}

DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\{#AppExe}
UninstallDisplayName={#AppName} {#AppVersion}

; ThermPy legge gli MSR della CPU tramite un driver kernel: gira solo a 64 bit e
; solo con privilegi di amministratore, quindi anche l'installazione e' di macchina.
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
MinVersion=10.0

LicenseFile=..\LICENSE
InfoAfterFile=..\THIRD-PARTY.md
SetupIconFile={#IconFile}
WizardStyle=modern
Compression=lzma2/max
SolidCompression=yes

OutputDir=..\dist
OutputBaseFilename={#AppName}-Setup-{#AppVersion}

[Languages]
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#SourceRoot}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LICENSE"; DestDir: "{app}"; DestName: "LICENSE.txt"; Flags: ignoreversion
Source: "..\THIRD-PARTY.md"; DestDir: "{app}"; DestName: "THIRD-PARTY.md"; Flags: ignoreversion
; La LGPL richiede che i testi di licenza accompagnino il binario distribuito,
; non solo il repository da cui e' stato scaricato.
Source: "..\licenses\*"; DestDir: "{app}\licenses"; Flags: ignoreversion

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{group}\Disinstalla {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
; L'installer gira gia' elevato, quindi l'applicazione parte senza un secondo
; prompt UAC nonostante il suo manifest richieda i privilegi di amministratore.
Filename: "{app}\{#AppExe}"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent

; Nessun [UninstallDelete] su {localappdata}: la disinstallazione gira elevata, e
; li' {localappdata} e' quella dell'amministratore, non dell'utente che ha usato
; l'applicazione. Si cancellerebbe una cartella sbagliata lasciando intatta quella
; giusta. Il log e le preferenze restano: occupano pochi kilobyte e permettono di
; ritrovare la configurazione dopo una reinstallazione.

[Code]
function InitializeSetup(): Boolean;
var
  ExistingVersion: String;
begin
  Result := True;
  // Se una versione precedente e' gia' installata, avvisa invece di sovrascriverla
  // in silenzio: l'applicazione potrebbe essere in esecuzione e tenere il driver
  // kernel agganciato, facendo fallire la copia dei file.
  if RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{8E4C1F92-6A3D-4B57-9E21-7C0D5A8F3B64}_is1',
     'DisplayVersion', ExistingVersion) then
  begin
    if MsgBox('E'' gia'' installata la versione ' + ExistingVersion + ' di {#AppName}.'
      + #13#10#13#10 + 'Chiudi {#AppName} se e'' in esecuzione, poi continua per aggiornarla.'
      + #13#10#13#10 + 'Vuoi procedere?', mbConfirmation, MB_YESNO) = IDNO then
      Result := False;
  end;
end;
