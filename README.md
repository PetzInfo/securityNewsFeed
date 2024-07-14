```markdown
# probeAufgabe

Willkommen bei **probeAufgabe**, einer Nachrichten-App, die es Ihnen ermöglicht, aktuelle Sicherheitsnachrichten einfach und schnell zu durchsuchen. Diese App zeigt eine Liste von Nachrichtenartikeln mit Bildern, Videos und Details an und bietet eine einfache Möglichkeit, den Lesezustand der Artikel zu verfolgen.

## Features

- **Nachrichtenanzeige**: Zeigt eine Liste von Nachrichtenartikeln an, einschließlich Titel, Veröffentlichungsdatum, Untertitel und Medieninhalten (Bilder/Videos).
- **Bilder und Videos**: Zeigt die Bilder der Nachrichtenartikel an und kennzeichnet Artikel mit Videos. (Wip)
- **Lesezustand**: Markiert Artikel als gelesen, um den Überblick zu behalten.
- **Lokale Speicherung**: Speichert geladene Nachrichten lokal, um den Offline-Zugriff zu ermöglichen.
- **Aktualisierung**: Aktualisiert die Nachrichtenliste bei Bedarf und zeigt das letzte Aktualisierungsdatum an.

## Installation

Um die App zu installieren und auszuführen, benötigen Sie Xcode und ein Apple-Entwicklerkonto.

1. Klonen Sie das Repository:
   ```bash
   git clone https://github.com/PetzInfo/securityNewsFeed.git
   ```
2. Öffnen Sie das Projekt in Xcode:
   ```bash
   cd securityNewsFeed
   open probeAufgabe.xcodeproj
   ```
3. Führen Sie das Projekt auf einem Simulator oder einem angeschlossenen Gerät aus.

## Verwendung

- **Starten der App**: Beim Start der App werden die neuesten Nachrichten geladen und angezeigt.
- **Artikel anzeigen**: Tippen Sie auf einen Artikel, um ihn als gelesen zu markieren.
- **Aktualisieren**: Ziehen Sie die Nachrichtenliste nach unten, um sie zu aktualisieren und die neuesten Artikel zu laden.

## Struktur

- **NewsRowView**: Eine SwiftUI-Ansicht, die eine einzelne Nachrichtenzeile darstellt, einschließlich des Bildes, Titels, Veröffentlichungsdatums und Untertitels des Artikels.
- **NewsViewModel**: Ein ObservableObject, das die Nachrichtenartikel verwaltet und deren Zustand aktualisiert.
- **FetchDataService**: Ein Dienst, der die Nachrichten von einer externen API abruft.
- **NewsModel**: Ein Datenmodell, das die Struktur eines Nachrichtenartikels definiert.
- **NewsStorage**: Eine Klasse, die das Speichern und Laden von Nachrichtenartikeln in UserDefaults ermöglicht.

## Entwickler

Mit dieser App versuche ich SwiftUI und Xcode kennen zu lernen, um fortan bei solchen Projekten helfen zu können.

