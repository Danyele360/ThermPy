# Componenti di terze parti

ThermPy ridistribuisce i componenti elencati qui. Le rispettive licenze restano in
vigore e prevalgono, per quei componenti, sui termini di ThermPy. I testi
integrali sono nella cartella [`licenses/`](licenses/).

| Componente | Licenza | Ruolo |
|---|---|---|
| [Qt 6](https://www.qt.io/) tramite [PySide6](https://doc.qt.io/qtforpython/) | [LGPL-3.0](licenses/LGPL-3.0.txt) | Interfaccia grafica |
| [LibreHardwareMonitorLib](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor) | [MPL-2.0](licenses/MPL-2.0.txt) | Sensori CPU, ventole, dischi |
| [HidSharp](https://www.zer7.com/software/hidsharp) | [Apache-2.0](licenses/Apache-2.0.txt) | Dipendenza di LibreHardwareMonitor |
| [pythonnet](https://github.com/pythonnet/pythonnet) | MIT | Ponte fra Python e runtime .NET |
| [psutil](https://github.com/giampaolo/psutil) | BSD-3-Clause | Carichi, frequenze, memoria, batteria |
| [nvidia-ml-py](https://pypi.org/project/nvidia-ml-py/) | BSD | Accesso a NVML per le GPU NVIDIA |
| [Lucide](https://lucide.dev) | ISC | Icone della barra di navigazione |
| [CPython](https://www.python.org/) | PSF License | Interprete incorporato |

---

## Qt e LGPL-3.0: i tuoi diritti

ThermPy usa Qt attraverso PySide6, distribuito sotto **LGPL-3.0**. La LGPL
consente di incorporare la libreria in un'applicazione a sorgente chiuso, ma ti
riconosce alcuni diritti che qui vengono resi effettivi.

### Sostituire le librerie Qt

ThermPy è distribuito come **cartella**, non come eseguibile autoestraente
monolitico. Le librerie Qt sono file separati in:

```
C:\Program Files\ThermPy\_internal\PySide6\
```

Puoi sostituirle con una tua build di Qt e di PySide6, purché compatibile per
ABI: ThermPy le caricherà al posto di quelle fornite, senza bisogno di
ricompilare l'applicazione. È questa la ragione per cui la distribuzione non usa
il formato a file singolo, che renderebbe la sostituzione impraticabile.

### Ottenere il sorgente di Qt

Il codice sorgente di Qt e di PySide6 non è ridistribuito qui perché è pubblicato
e liberamente scaricabile dagli autori:

- Qt: <https://download.qt.io/official_releases/qt/>
- PySide6: <https://download.qt.io/official_releases/QtForPython/>
- Repository: <https://code.qt.io/cgit/pyside/pyside-setup.git/>

La versione incorporata è indicata nelle proprietà dei file `Qt6*.dll` nella
cartella sopra.

### Reverse engineering

La LGPL-3.0 ti riconosce il diritto di decompilare ThermPy nella misura
necessaria a correggere e verificare le modifiche apportate alle librerie Qt.
I termini di ThermPy non limitano questo diritto.

---

## LibreHardwareMonitor e MPL-2.0

La MPL-2.0 è una licenza copyleft **a livello di file**: obbliga a rendere
disponibile il sorgente dei file coperti, ma non si estende al codice che si
limita a usarli.

ThermPy non modifica LibreHardwareMonitorLib: carica la DLL esattamente come
distribuita nella release ufficiale, verificandone lo SHA256 in fase di build. Il
sorgente corrispondente è nel repository del progetto, alla release indicata:

- <https://github.com/LibreHardwareMonitor/LibreHardwareMonitor>
- Versione incorporata: **0.9.4**

---

## Perché non c'è PyQt6

Le prime versioni di ThermPy usavano PyQt6, che ha licenza **GPL-3.0-only**: una
licenza copyleft forte, che avrebbe obbligato a pubblicare il sorgente
dell'intera applicazione insieme al binario.

Il passaggio a PySide6, che è il binding ufficiale di Qt sotto LGPL-3.0, consente
di distribuire l'eseguibile mantenendo privato il codice dell'applicazione,
rispettando comunque per intero gli obblighi verso Qt descritti sopra.
