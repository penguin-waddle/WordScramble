# WordScramble - An Interactive Word Game

## Overview
WordScramble is a fun and educational game where players are challenged to form as many words as possible from a given root word. The game combines vocabulary skills with strategic thinking, providing an engaging way for players to enhance their word formation abilities.

## Features
- **Word Formation**: Players create new words using letters from a root word displayed at the top.
- **Score Tracking**: Points are awarded based on word length and the number of words formed, encouraging players to stretch their vocabulary.
- **Dynamic Word Lists**: The game sources from an extensive list of words, ensuring a fresh experience in each round.
- **Interactive Interface**: The app utilizes a clean and intuitive interface with easy navigation and input methods.

## Technical Highlights
- **SwiftUI Implementation**: Leveraged SwiftUI for building the user interface, including Lists, TextFields, and Buttons.
- **State Management**: Used `@State` properties for tracking game state, including user's score, entered words, and the root word.
- **Input Validation**: Incorporated logic to validate user input for originality, possibility, and reality using `UITextChecker`.
- **Custom Error Handling**: Implemented custom error alerts to guide the user for valid word entries.

## Learning Notes
- **SwiftUI's List and NavigationView**: Explored the use of List for dynamic content display and NavigationView for enhanced user navigation.
- **UITextChecker for Spelling Check**: Applied UITextChecker to identify misspelled words, ensuring valid word entries by players.
- **String Manipulation**: Gained proficiency in string manipulation in Swift, essential for checking word possibilities and originality.
- **UI Modifiers**: Experimented with various SwiftUI modifiers for customizing the look and feel of the UI components.

---

Note: This project is a part of the "100 Days of SwiftUI" course, designed and implemented by me as part of my iOS development learning journey.

---
