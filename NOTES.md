# Sources 

- The [slides and the exercises](./SCC-existing-material) of the HPC-DIC courses by SCC/SCS
- The "Shell scripts and tips" course [by NRIS](https://training.pages.sigma2.no/tutorials/shell-scripts-and-tips/)
- The [linux shell tutorial](https://aaltoscicomp.github.io/linux-shell/) by Aalto Science IT department 
- Also, the software carpentry Shell Novice Lesson.
- And the Bash manual.

# Planned content
## Introductory
This is taken up by Fabian, I will not touch it. 
Seen as prerequisite

- prompt, basic command syntax
- echo
- appetizer of '' vs ""
- appetizer of history: up arrow
- CTRL+C to stop things
- variables
- navigating the man pages (up down search)
- touch, > , >>, cat
- tab completion
- middle mouse button
- CTRL+R
- mv, cp, rm
  - -r 
- nano, vim
- pwd
- mkdir
- globbing + tab
- cd 
  - absolute/relative paths (should be clarified better imho)
  - tricks
- permissions and access rights
- find and grep (quickly)

## Intermediate
- Bash and shell features and utilities:
  - for loops: iterating on files
  - best practices with file names
  - '' vs "": expansion
  - using the terminal efficiently 
    - history 
  - exercises
  - STDIN vs command arguments
  - redirections (> , >>, &>, 2>&1, <), pipes and filters: intro
  - basic unix tools:
    - less (review)
    - grep (review)
    - head
    - diff
    - tail
    - wc 
    - du
    - find (review)
    - dirname/basename
  - command and process substitution
  - composing: pipes and filters, revisited: exercises
  - defensive programming: set -euo pipefail

- ssh and connections tips and tricks
  # Note: Peter talks about this, but nowhere it is mentioned how to generate a key,
  # or how to tweak the ssh configuration
  - keys
  - config
  - rsync

- Discussion about workflows 
- Bash/Job Scripting and HPC workflows:
  - best practices for data/metadata organization and wokflows
  - taking shortcuts with (symbolic) links
  - arguments
  - Job Arrays
  - Coalescing work together: parbatch


## Advanced

- Bash and shell features and utilities:
  - reading the bash manual
  - conditionals and looping beyond for loops
  - functions
  - arrays
  - using the terminal even more efficiently
    - inputrc, editor for shell commands (demo) (EDITOR env variable)
  - more advanced shell tools and their composability

- tmux (gotcha with login nodes)
- Discussion about workflows 
- Bash/Job scripting:
  - foreground and background processes
  - signal handlers: trap
  - composability of bash 
  - Special filesystems: 
  - Job Chaining and job dependencies
  - Coalescing work together: gnu parallel

- Discussion of alternatives



## Discussion of unix tools

### "Vertical"
- head
- tail
- cat 
- grep
- sort

### "Horizontal"
- cut
- paste

### Other
- wc 
- du
- find
- dirname and basename
- xargs
- tar
- rsync
- sed
- curl
- which/type
