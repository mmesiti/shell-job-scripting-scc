# Tips and Tricks for interactive use

Ergonomics is important.

- Use `TAB` completion whenever possible:

    - it **saves** keystrokes
    - it **validates** what you are trying to type (if autocompletion does not work, probably you've made a typo or a file you are trying to )

- Arrow up/down: go backwards/forwards in history

    - Use `&&` to chain commands and create groups of commands
      that can be reused

- History expansion: do not repeat yourself

    - Use `CTRL-R/S` to incrementally search backwards/forwards in history
    - `!!` is the last command
    - Use `history | grep <command-fragment>` to search for a command and get its number
    - `!<n>` is the `n`-th command in the history, 
    - `shopt -s histverify`: show the command before executing it
    - You can do other crazy things. Search for `HISTORY EXPANSION` in `man bash`.
  
```{discussion} Suggestions?

Are you willing to discuss and share your own ergonomic tricks?

Feel free to edit this page!
```
