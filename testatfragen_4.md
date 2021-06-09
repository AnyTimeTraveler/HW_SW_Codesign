1. Wie erklären Sie sich die Geschwindigkeitsunterschiede der drei vorgstellten SMUAD-Implementierungen?

	CPU: Langsamste, da Software-Multiplikation langsam ist
	CI : Schnellste, da Harware-Multiplikation schnell ist
	CP : Nur ein Wenig langsamer als CI, da letztendlich auch Hardware-Multiplikation ausgefuehrt wird, aber die Parameter ueber den System-Bus muessen

2. Warum ist die Taktrate des SoPC in dem vorliegenden System auf maximal50 MHz begrenzt?

	?

3. Wie viele Embedded Multiplierdes FPGA werden für die Custom Instruction SMUAD verwendet?

	 Es werden vier Embedded Multiplierdes verwendet 

4. Welche Standard-CI-Typen können durch das Steuerwerk des Nios verwaltetwerden? Um welchen Typ handelt es sich in unserer Übung?

 - Combinatorial			--> Kombinatorisch Instruktion (and/or/mult..)(ohne clock)
 - Variable Multi-Cycle		--> Mit Clock (setzt bit wenn fertig(readyflag)) (dauer kann varieren) bsp log
 - Fixed Multi-Cycle		--> Mit Clock (dauer der Instruktion bekannt/verändert sich nicht)
 - Extended					--> Mit Clock/ mehrere arten von Instruktionen 
 - Internal Register File	--> Komponente mit zugriff auf alle Register der CPU

	https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/ug/archives/ug-nios2-custom-instruction-15.1.pdf

5. Wie erfolgen Geschwindigkeitsmessungen mittels Performance Counter?

	Er zaehlt die Clock Cycles nach dem Start und die Anzahl an Events, die in dieser Sektion passieren.
	
	https://pages.mtu.edu/~saeid/multimedia/labs/Documentation/qts_qii55001_Performance_Counter_Core.pdf

6. Wie lässt sich die Verarbeitung größerer Datenmengen mittels Custom Peri-pheral weiter beschleunigen?

 - Custom Peripheral zum Master machen, damit er sich die Daten selber holen kann

7. Welchen Einfluss haben unterschiedliche Optimierungsstufen des C-Compilersauf die Performanz der vorgestellten SMUAD-Implementierungen?

	

