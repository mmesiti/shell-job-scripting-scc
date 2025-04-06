# Shell and Job Scripting course notes

This course is intended to teach 
how to use the bash shell efficiently
to researchers using a HPC cluster,
with a goal-oriented approach
(backward lesson design,
popularized by Greg Wilson's 
[Teaching Tech Together](https://teachtogether.tech/en/)
and references therein).

Teaching 
(and more in general, communication)
objectives
are

1. Ease the use of the shell and the terminal in general
2. Stimulate discussion with the audience to collect use cases
3. Show useful patterns to carry out common tasks in (slurm) job scripts


Everything covered here
is also covered at length 
in countless other places on the internet
and can also be retrieved on a whim with a LLM,
so why repeat it here?
1. As with a lot of things in teaching,
the goal is to first of all cover 
the *unknown unknowns* of the student, 
2. To guide the students
through those important ideas
that are also too hard to approach alone,
and that would not be learned 
without guidance.

Suggestions/criticism are welcome,
so feel free to open issues 
and pull requests 
to this repository.

It is based on/inspired by the following sources:

- The already existing slides and the exercises of the HPC-DIC courses by SCC/SCS at KIT
- The "Shell scripts and tips" course [by NRIS](https://training.pages.sigma2.no/tutorials/shell-scripts-and-tips/)
- The [linux shell tutorial](https://aaltoscicomp.github.io/linux-shell/) by Aalto Science IT department (very detailed course, goes deeper than what we are trying to do here).
- The software carpentry [Shell Novice Lesson](https://swcarpentry.github.io/shell-novice/).
- The Bash manual.


The split between "Intermediate" and "Advanced" 
is somewhat arbitrary, 
and only due to lesson time limits
(which themselves are a result of assessed importance of the topics).
The guiding principle here is 
to talk about the most useful things first,
and assume that the more obscure a feature is, 
the less the return on investment is going to be.

## Known issues

Problems can and will be discussed 
using the issue feature on the service where this documentation is hosted.


## Table of Content

```{toctree}
:caption: Motivation
motivation.md
```
```{toctree}
:caption: Intermediate 
bash/dealing_with_repetition.md
bash/quality_of_life.md
bash/composability.md
ssh/tips-and-tricks.md
unix_tools.md
workflow-discussion_intermediate.md
general_best_practices.md
defensive_programming.md
bash/foreground_background.md
embarrassingly_parallel.md
```
```{toctree}
:caption: Advanced 
bash/the_manual.md
bash/making_choices.md
bash/composability2.md
bash/multitasking.md
workflow-discussion_intermediate.md
embarrassingly_parallel_advanced.md
job_chaining.md
```



