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

