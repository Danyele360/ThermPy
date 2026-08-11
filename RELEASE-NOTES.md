# ThermPy 1.1.0

Arriva la **registrazione di sessione**: un tasto REC che raccoglie tutto quello
che succede mentre usi il computer e lo prepara per l'analisi, anche da parte di
un modello di linguaggio.

## Novità

### Registrazione

Avvii la registrazione, usi il tuo software esercitandone le funzioni, fermi e
ottieni un archivio da consegnare a un'AI per capire dove si inceppa.

- **`Ctrl+Shift+M` da qualunque applicazione** inserisce un marcatore, senza dover
  tornare su ThermPy — che ruberebbe il focus al programma che stai misurando
- Puoi indicare un **processo da sorvegliare**: viene seguito a ogni campione anche
  quando consuma poco, così non sparisce dalla classifica proprio mentre è bloccato
- L'archivio contiene un referto compatto (`report.md`), i campioni dei sensori e
  dei processi in CSV e i metadati in JSON

Il referto non è un elenco di numeri: ogni intervallo fra due marcatori diventa
una riga con le proprie statistiche, e accanto ci sono gli episodi di limitazione
con il motivo, il processo sorvegliato con handle e context switch involontari, e
una sezione che dichiara cosa non è stato misurabile.

### Interfaccia

- Icone di navigazione ridisegnate ([Lucide](https://lucide.dev))
- Tabelle uniformate: stesse altezze, intestazioni allineate al contenuto
- L'icona nella tray mostra **CPU e GPU insieme** sugli schermi con scalatura attiva
- La finestra non nasce più più alta dello schermo disponibile

## Correzioni

- I sensori che comparivano a metà registrazione avevano i valori disallineati nel
  tempo nell'esportazione CSV
- Il campionamento dei processi non stava al passo con l'intervallo richiesto:
  ora avviene in due fasi e produce dieci volte più campioni
- *System Idle Process* non compare più fra i processi attivi

## Installazione

Scarica ed esegui `ThermPy-Setup-1.1.0.exe`. Richiede Windows 10 o 11 a 64 bit.
Non serve installare Python, Qt o il runtime .NET: sono già inclusi.

**ThermPy chiede i privilegi di amministratore.** Non è una comodità: su Windows
le temperature per-core della CPU si leggono dagli MSR del processore e gli RPM
delle ventole dall'Embedded Controller, e a entrambi si accede solo tramite un
driver in modalità kernel.

Se hai già la 1.0.0, l'installer la aggiorna mantenendo le preferenze.

## Note

- Il primo avvio impiega qualche secondo: la libreria di lettura sensori deve
  enumerare l'hardware e caricare il proprio driver.
- Su alcuni portatili la velocità delle ventole non è esposta dal firmware. In quel
  caso la pagina Ventole lo dice esplicitamente, distinguendo questa situazione
  dalla mancanza di privilegi.
- Senza privilegi di amministratore l'applicazione parte comunque, mostrando GPU,
  carichi, frequenze, memoria e batteria, e spiega in un banner cosa manca.

## Licenza

ThermPy è gratuito, per uso personale e commerciale. Incorpora Qt sotto LGPL-3.0:
i dettagli e i testi delle licenze sono nel repository e nella cartella di
installazione.

## Verifica del file

```
ThermPy-Setup-1.1.0.exe
SHA256: 48b91aa2aca048b49b880d025e8a1ba71477db540db852c8ded85a87c4ac2b26
```
