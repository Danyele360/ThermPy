# ThermPy 1.1.1

Quando la macchina scotta, ThermPy adesso ti dice **quale processo la sta
scaldando** — e ti offre di chiuderlo dalla notifica.

## Novità

### Il processo responsabile

Un pomeriggio reale sul portatile di sviluppo: 90 °C per ore, ventole al massimo,
tutto lento. Il colpevole era un processo `renderer` di Discord impazzito che da
solo teneva il 79% della CPU — quindici core su venti — mentre tutto il resto del
sistema stava sotto lo 0,5%. Chiuso quello, la temperatura è scesa a 61 °C in due
minuti. ThermPy aveva già i dati per accorgersene, e non diceva niente.

Adesso lo dice:

- Quando scatta un alert termico parte la ricerca del responsabile. Se un processo
  supera una **quota della capacità totale** — 25% di default, regolabile — per due
  campioni consecutivi, viene nominato
- Arriva una **notifica nativa di Windows** con la sparkline della salita termica
  che ha portato all'allarme, il nome del processo, la sua quota e il PID
- Un pulsante lo termina, dalla notifica o dal banner nell'applicazione
- Se nessun processo domina la notifica lo dice — *il carico è distribuito* —
  invece di accusare il primo della classifica

**A macchina fredda non costa niente**: senza un alert in corso il campionamento
dei processi non gira affatto. Enumerare i processi di Windows costa 825 ms, e
pagarli per sempre significherebbe scaldare la macchina per sorvegliarla.

### La terminazione, presa sul serio

ThermPy gira elevato, quindi quel pulsante può davvero uccidere qualunque cosa.
Prima di toccare un processo passano tre controlli: che il nome **corrisponda
ancora** a quel PID — fra il campionamento e il click Windows può averlo
riassegnato a tutt'altro programma — che non sia un processo di sistema, e che non
sia ThermPy stesso. E comunque serve una conferma esplicita, con *Annulla* come
pulsante predefinito.

### Impostazioni

Nuova sezione **Processi**: si regola la quota minima per accusare, e si possono
spegnere sia il rilevamento sia il pulsante di terminazione.

## Installazione

Scarica ed esegui `ThermPy-Setup-1.1.1.exe`. Richiede Windows 10 o 11 a 64 bit.
Non serve installare Python, Qt o il runtime .NET: sono già inclusi.

Se hai già la 1.1.0, l'installer la aggiorna mantenendo le preferenze.

**ThermPy chiede i privilegi di amministratore.** Non è una comodità: su Windows
le temperature per-core della CPU si leggono dagli MSR del processore e gli RPM
delle ventole dall'Embedded Controller, e a entrambi si accede solo tramite un
driver in modalità kernel.

## Note

- Il primo avvio impiega qualche secondo: la libreria di lettura sensori deve
  enumerare l'hardware e caricare il proprio driver.
- Le notifiche sono quelle native di Windows, quindi rispettano Assistente
  notifiche e Non disturbare. Se le hai silenziate per ThermPy nelle impostazioni
  di sistema, l'avviso resta comunque visibile nel banner dell'applicazione.
- Il colpevole viene annunciato una decina di secondi dopo l'inizio dell'episodio:
  è il tempo dei due campioni consecutivi che servono a distinguere un problema
  vero dal picco di una compilazione che parte.
- Su alcuni portatili la velocità delle ventole non è esposta dal firmware. In quel
  caso la pagina Ventole lo dice esplicitamente, distinguendo questa situazione
  dalla mancanza di privilegi.

## Licenza

ThermPy è gratuito, per uso personale e commerciale. Incorpora Qt sotto LGPL-3.0:
i dettagli e i testi delle licenze sono nel repository e nella cartella di
installazione.

## Verifica del file

```
ThermPy-Setup-1.1.1.exe
SHA256: 52617e8f5dd90b1fc110ef65a4a31c8c159c30e4092b6d72b4672eca4cdad062
```
