1. Welche Möglichkeiten bestehen zur Wahl des Ortes des Programmspeichers für den Nios? Wie und wo wird dieser Ort konfiguriert?
   - On-Chip RAM/ROM
   - Externer Flash
   - Externer RAM
   Konfiguriert ueber Qsys Tool.

2. Was sind die Vor- und Nachteile des On-chip-memory?
  Vorteile:
    - Einfach
    - Keine Timing Probleme bei Kommunikation mit externen Chips moeglich
  Nachteile:
    - Braucht Platz auf FPGA
    - Durch FPGA in Groesse beschraenkt

3. Wo und wann werden die Namen der Signale des Nios-Systems zur Instanzierung auf dem Top-Level festgelegt?
  In Qsys in der Export Spalte.

4. Wie erfolgt generell der Zugriff vom Nios auf einen MM-Slave am Avalon-Bus durch ein C-Programm?
  Ueber jeweils ein C-Macro zum Lesen und Schreiben, welche die Speicheraddresse uebersetzt und die built-in Instruktion aufruft.

  	__builtin_ldwio (((void *)(((alt_u8*)(0x5000)) + (((0)) * (32/8)))));


    _________________________________________________________________________________
Notizen die sich Markus noch Donnerstg Nacht gemacht hat

    Beim draufspielen
    - Byte order --> ISA
    - Data aligment --> Compiler

    MEmorimapped I/O
     - I/O Register werden in dem Hauptapeicher-Adressraum abgebildet

     .bss --> datensegment für statische werte die mit null werten gefüllt sind

     flashspeicher ist nicht so schnell wie sd-ram
     - ab 100 Mhz wird nicht mehr vom Flash gebootet

     FPGA und NIOS
     - booten und laufen von volatile memory

     board support package enthält infos über hardware und adressen
     - schnittstelle zwischen hard und software
     - z.B wo heap stack und .bss liegen
     - wenn die hardware verändert wurde muss ein neues geschrieben werden
     - namen die wir im quisis festlegen (für hardware) finden wir im boardsupport package wider
     - Wie der Bootloader auszusehen hat
     - usw ...
