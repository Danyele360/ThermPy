# ThermPy 1.2.0

Sui portatili **Lenovo Legion e LOQ** ThermPy adesso legge gli RPM delle ventole —
e sa quale raffredda la CPU e quale la GPU.

## Novità

### Le ventole, dove prima c'era un vicolo cieco

Fino alla 1.1.1 su questa macchina la pagina Ventole diceva che il firmware non
espone la velocità, e sembrava una porta chiusa. Non lo era: Legion Space quei
numeri li mostra, quindi da qualche parte si leggono.

Si leggono dall'interfaccia WMI proprietaria del firmware, la stessa che usa Legion
Space. Non dal metodo che citano tutte le guide — `Fan_GetCurrentFanSpeed`, dei
Legion più vecchi — che su questi modelli **non esiste più**, ed è il motivo per cui
cercandolo non si trova niente. La via buona è `LENOVO_OTHER_METHOD.GetFeatureValue`
con l'ID di capability della ventola.

Sul portatile di riferimento, un LOQ 15IRX10, a riposo legge 1700 e 2000 RPM; sotto
carico sale a 2400 e 2700 in gradini da 100, gli stessi numeri che Legion Space
mostra nello stesso istante.

Niente è cablato nel codice: gli ID delle ventole vengono enumerati dalle tabelle di
capability del firmware, quindi una macchina con una ventola sola o con tre funziona
senza modifiche.

### Ogni ventola sa cosa raffredda

Non "Ventola 1" e "Ventola 2", ma **CPU Fan** e **GPU Fan**. Anche questo è dedotto
dal firmware: le sue tabelle dichiarano quale sensore governa quale ventola, e il
sensore che legge la stessa temperatura riportata per la CPU è quello della CPU. Sul
LOQ ne risulta ventola 1 → CPU e ventola 2 → GPU, con riscontro esterno su
`nvidia-smi` per il sensore della GPU.

Se la deduzione resta ambigua le ventole tornano numerate. Un nome sbagliato accanto
agli RPM è peggio di un nome generico.

### Le ventole nella Panoramica

I due gauge hanno un secondo anello, più sottile e interno a quello della
temperatura, con i giri della ventola che raffredda quel pezzo e la velocità scritta
sotto.

Serve a leggere una cosa sola, a colpo d'occhio: l'anello che si riempie mentre
quello esterno scalda dice che il sistema sta reagendo. Uno che resta fermo su una
temperatura che sale è il sintomo che conta davvero.

L'anello è azzurro e non usa i colori della scala termica, perché dice quanto sta
lavorando il raffreddamento, non quanto scotta il pezzo. Dove non c'è una ventola
associata sparisce del tutto invece di restare vuoto: un anello a zero si legge come
una ventola ferma, che è un'altra cosa.

## Correzioni

- **La tabella dei sensori si leggeva una riga per volta.** Nelle pagine CPU, GPU e
  Ventole la tabella "Tutti i sensori" veniva schiacciata all'altezza minima, con una
  barra di scorrimento annidata dentro quella della pagina. Ora si dimensiona sul
  proprio contenuto e a scorrere è solo la pagina.
- **La conferma prima di terminare un processo confrontava la risposta nel modo
  sbagliato** e poteva non riconoscere l'annullamento. La correzione è di pochi
  minuti successiva alla build della 1.1.1 e non era mai finita in un rilascio.

## Installazione

Scarica ed esegui `ThermPy-Setup-1.2.0.exe`. Richiede Windows 10 o 11 a 64 bit. Non
serve installare Python, Qt o il runtime .NET: sono già inclusi.

Se hai già una versione precedente, l'installer la aggiorna mantenendo le preferenze.

**ThermPy chiede i privilegi di amministratore.** Non è una comodità: su Windows le
temperature per-core della CPU si leggono dagli MSR del processore e gli RPM delle
ventole dall'Embedded Controller, e a entrambi si accede solo tramite un driver in
modalità kernel. Anche l'interfaccia WMI Lenovo, senza elevazione, non espone nulla.

## Note

- La lettura delle ventole Lenovo è verificata su un LOQ 15IRX10. Sugli altri Legion
  e LOQ dovrebbe funzionare, perché il codice enumera le capability del firmware
  invece di assumerle, ma non è stata provata su altro hardware.
- Su macchine non Lenovo le ventole restano affidate a LibreHardwareMonitor, che le
  mostra dove il firmware le espone: desktop con SuperIO e molti altri portatili.
  Dove non ci sono, la pagina Ventole continua a distinguere "mancano i privilegi"
  da "il firmware non le espone".
- Il primo avvio impiega qualche secondo: la libreria di lettura sensori deve
  enumerare l'hardware e caricare il proprio driver.
- Le notifiche sono quelle native di Windows, quindi rispettano Assistente notifiche
  e Non disturbare. Se le hai silenziate per ThermPy nelle impostazioni di sistema,
  l'avviso resta visibile nel banner dell'applicazione.

## Licenza

ThermPy è gratuito, per uso personale e commerciale. Incorpora Qt sotto LGPL-3.0:
i dettagli e i testi delle licenze sono nel repository e nella cartella di
installazione.

## Verifica del file

```
ThermPy-Setup-1.2.0.exe
SHA256: 835643a1984eebf91ce66662d7f9483aaa27bd8c77637541cdc5d6b092308667
```
