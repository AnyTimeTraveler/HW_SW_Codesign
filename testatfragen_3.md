1. Wie groß ist der für den LCD- und UART-Controller reservierter Adressbereichin der Memory Map? Wodurch wird diese Größe definiert?

Die Komponenten im QSYS haben eine feste Groesse.

LCD : 16 byte
UART:  8 byte

2. Die Position des Cursors in der LCD-Anzeige lässt sich mittels Controllerverschieben. Wie?

Durch ANSI Kontroll-Characters.

3. Identifizieren Sie auf dem DE2-115-Board jeweils den PHY für die Ethernet-und RS-232-Schnittstelle.

Oben rechts.

4. Wie groß ist der benötigte Platz Ihrer Anwendung für die Segmente TEXT,DATA und BSS? Studieren Sie hierzu die Verwendung und Ausgabe des Hilfs-programmsnios2-elf-size.

text: 73692 byte (71 kByte)
data:  7232 byte  (7 kByte)
bss:    352 byte

