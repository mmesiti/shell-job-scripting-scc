# Quality of Life with the shell

Ergonomics is important.

- Use `TAB` completion whenever possible:
    - it **saves** keystrokes
    - it **validates** what you are trying to type (if autocompletion does not work, probably you've made a typo or a file you are trying to )
- Arrow up/down: go backwards/forwards in history
- History expansion: do not repeat yourself
    - Use `CTRL-R/S` to incrementally search backwards/forwards in history
    - `!!` is the last command
    - Use `history | grep <command-fragment>` to search for a command and get its number
    - `!<n>` is the `n`-th command in the history, 
    - `!command` is the last command starting with `command` (a bit like `CTRL-R`)
    - `!<command or number>:$`: the last argument of that command
    - `shopt -s histverify`: show the command before executing it
    - You can do other crazy things. Search for `HISTORY EXPANSION` in `man bash`.
  
- Readline and editing mode 
    - You can set up vi(m)/emacs keybindings to navigate the command line while editing a command 
    - If that is not enough, you can open an editor to edit the command you are typing (`v` if `set -o vi`, `CTRL-X CTRL-E` if `set -o emacs`)


