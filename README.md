# Grouply

Mit der Grouply App soll es Freunden, mittleren bis großen Reisegruppen oder einfach zerstreuten Menschen einfach gemacht werden, größere Reiseplanungen zu organisieren und die Kosten im Auge zu behalten.  

## Installationsanleitung für die Entwicklung

Diese App wird mit [Dart](https://dart.dev/) und dem [Flutter Framework](https://flutter.dev/) geschrieben. Um an der Entwicklung teilnehmen zu können, ist es ratsam den ["Get Started"](https://flutter.dev/docs/get-started/install) Abschnitt der Flutter Dokumentation zu folgen. Es ist nicht zwingend notwendig Android Studio für die Entwicklung installiert zu haben, jedoch verringert das Programm doch um einiges den Aufwand (beispielsweise bei der Erstellung eines [AVD](# "Android Virtual Device").

## Projektstruktur

Der gesamte relevante Code liegt im Order `lib/`. Andere relevante Dateien/Ordner lauten:

- `assets/` - Hier werden unter `fonts/` speziell verwendete Schriften gespeichert. Außerdem werden unter `assets/images/` Bilder hinterlegt.
- `pubspec.yaml` - Verlgeichbar mit der `package.json` / `build.gradle`; enthält Dependencies und die Projektkonfiguration.
- `analysis_options.yaml` - Hier lassen sich für den Linter spezielle Regeln eintragen.

Der `lib/` Ordner unterteilt sich in `lib/views/` und `lib/components/`. Unter `views/` befinden sich die einzelnen "Screens", wohingegen in `components/` einzelne Bausteine zur Wiederverwendung liegen.

## Weitere Informationen

Weitere Informationen findet man im  [Wiki](https://github.com/bertaframion/Grouply/wiki). Fügt gerne auch selbst Dokumente hinzu oder bearbeitet Bestehendes.
