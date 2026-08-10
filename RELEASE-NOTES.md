# ThermPy 1.0.0

Prima versione pubblica.

## Cosa fa

Monitor termico per Windows che mostra in tempo reale tutto ciò che l'hardware
espone: temperature CPU per-core e di package, temperature GPU comprese quelle di
hot spot, velocità delle ventole, frequenze, potenza assorbita, memoria video,
dischi e batteria.

- **Panoramica** con due gauge e le metriche chiave, ciascuna col proprio andamento
- **CPU** con heatmap per-core e carico per thread
- **GPU** con core, hot spot, clock, potenza e VRAM
- **Ventole** con RPM correnti e storico
- **Impostazioni** con intervallo di campionamento, soglie di allerta e diagnostica
  delle sorgenti dati
- Icona nella tray che mostra la temperatura corrente
- Alert con isteresi, così non lampeggiano quando la temperatura oscilla attorno
  alla soglia

## Installazione

Scarica ed esegui `ThermPy-Setup-1.0.0.exe`. Richiede Windows 10 o 11 a 64 bit.
Non serve installare Python, Qt o il runtime .NET: sono già inclusi.

**ThermPy chiede i privilegi di amministratore.** Non è una comodità: su Windows
le temperature per-core della CPU si leggono dagli MSR del processore e gli RPM
delle ventole dall'Embedded Controller, e a entrambi si accede solo tramite un
driver in modalità kernel.

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
ThermPy-Setup-1.0.0.exe
SHA256: bfccbb78d786701fbc57fdcbbfcaa019669c0ae183e0d1a34ce494a64abd51b2
```
