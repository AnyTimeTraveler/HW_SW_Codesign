1. Wie erklären Sie sich die Geschwindigkeitsunterschiede der drei vorgstellten SMUAD-Implementierungen?

CPU: Langsamste, da Software-Multiplikation langsam ist
CI : Schnellste, da Harware-Multiplikation schnell ist
CP : Nur ein Wenig langsamer als CI, da letztendlich auch Hardware-Multiplikation ausgefuehrt wird, aber die Parameter ueber den System-Bus muessen

2. Warum ist die Taktrate des SoPC in dem vorliegenden System auf maximal50 MHz begrenzt?

?

3. Wie viele Embedded Multiplierdes FPGA werden für die Custom Instruction SMUAD verwendet?

4

4. Welche Standard-CI-Typen können durch das Steuerwerk des Nios verwaltetwerden? Um welchen Typ handelt es sich in unserer Übung?

 - Combinatorial
 - Variable Multi-Cycle
 - Fixed Multi-Cycle
 - Extended
 - Internal Register File

5. Wie erfolgen Geschwindigkeitsmessungen mittels Performance Counter?

Er zaehlt die Clock Cycles nach dem Start und die Anzahl an Events, die in dieser Sektion passieren.

6. Wie lässt sich die Verarbeitung größerer Datenmengen mittels Custom Peri-pheral weiter beschleunigen?

 - Custom Peripheral zum Master machen, damit er sich die Daten selber holen kann

7. Welchen Einfluss haben unterschiedliche Optimierungsstufen des C-Compilersauf die Performanz der vorgestellten SMUAD-Implementierungen?



