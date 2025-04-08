# Tips and Tricks for interactive use

- History expansion: do not repeat yourself
    - `!<command or number>:$`: the last argument of that command
    - `!command` is the last command starting with `command` (a bit like `CTRL-R`)

- Readline and editing mode 
    - You can set up vi(m)/emacs keybindings to navigate the command line while editing a command 
    - If that is not enough, you can open an editor to edit the command you are typing (`v` if `set -o vi`, `CTRL-X CTRL-E` if `set -o emacs`)

## Multitasking *et similia*

Working on multiple directories:
- `cd -` to toggle between 2 directories
- `pushd` to switch between more than 2 directories

```bash
cd 
mkdir 1 2 3 4
cd 1
pushd ../2 
pushd ../3
pushd ../4
pushd -0 # rotate 
pushd +1 # rotate
pushd # exchange the 2 top dirs (similar use case to cd -)
```

### Using multiple applications at the same time

- *Suspend* a job with `CTRL+Z`
- Do something else
- Resume with `fg`

If you are curious:
- See with `jobs`
- `jobspec`: `%n`

Alternative: multiple terminals with ssh connections.

This has the disadvantage of requiring multiple log ins and can be tedious
(but it can be streamlined by having ssh keys correctly set up).


### Alternative: `tmux`

`tmux` stands for Terminal Multiplexer.
  Usage:
  - start with `tmux` 
  - detach with `CTRL+B D` 
  - reattach with `tmux a`
  - split with `CTRL+B %` or `CTRL+B "`
  - change pane with `CTRL+B o`
  - help: `CTRL+B ?`
  - exit help: `q`
  Gotchas:
  - killed when you log off the node (unless *lingering* is enabled)
  - When there are multiple login nodes, 
    you might land on a different node where your session(s) 
    are not available

