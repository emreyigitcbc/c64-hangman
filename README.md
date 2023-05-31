
## Hangman for C64
- This is my first project for C64 and in BASIC.
- It uses sprites to draw hanging man.
- It might be spaghetti code but I did this for learning BASIC and understanding C64.

### Features & Playing
- It has Start Menu, askys you to press any button
- When the game starts it randomly chooses a word and prints `_` by length of the word.
- It asks you to choose a character, you have to choose a character with arrow buttons; then enter.
- If the character in word, it reveals the secret characters otherwise it starts drawing the hanging man.
- You can edit wordlist in line 461 (47 for real)

### Usage
- I tested on only VICE, and it works perfectly. Just drag & drop or load & run it from drive by:
```BASIC
LOAD"HANGMAN",8,1
RUN
```

### Feedback
- Feel free to tell me my shortcomings.
