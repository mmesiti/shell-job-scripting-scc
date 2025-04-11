# Shell and Job Scripting course notes

This course is intended to teach 
how to use the bash shell efficiently
to researchers using a HPC cluster,
with a goal-oriented approach
(backward lesson design,
popularized by Greg Wilson's 
[Teaching Tech Together](https://teachtogether.tech/en/)
and references therein).


```{admonition} Teaching style: Type along
Some of the content in this lesson 
is a collection of notions,
but the main style of this lesson
is practical and following along,
trying to type the commands 
while the instructor does it.

The instructor will follow these notes,
so that if you get lost 
you can get back to it.
```


```{objectives}
1. Ease the use of the shell and the terminal in general
2. Stimulate discussion with the audience to collect use cases
3. Show useful patterns to carry out common tasks in (slurm) job scripts
```

```{admonition} Suggestions welcome!
Suggestions/criticism are welcome,
so feel free to open issues 
and pull requests 
to this repository
(see "Edit on GitHub" icon
in the upper right corner).
```

## Setup to follow along and for the exercises

You can clone this repository
```bash
git clone https://github.com/mmesiti/shell-job-scripting-scc.git 
```
and use the [examples](https://github.com/mmesiti/shell-job-scripting-scc/tree/main/examples) directory to follow along.

The **job scripting exercises** and their solutions are in the [exercises](https://github.com/mmesiti/shell-job-scripting-scc/tree/main/exercises) directory.


## Sources and Inspiration

- The already existing slides and the exercises of the HPC-DIC courses by SCC/SCS at KIT;
- The "Shell scripts and tips" course [by NRIS](https://training.pages.sigma2.no/tutorials/shell-scripts-and-tips/);
- The [linux shell tutorial](https://aaltoscicomp.github.io/linux-shell/) by Aalto Science IT department (very detailed course, goes deeper than what we are trying to do here);
- The software carpentry [Shell Novice Lesson](https://swcarpentry.github.io/shell-novice/);
- The [Extra Unix Shell Material](https://carpentries-incubator.github.io/shell-extras/);
  from [the Carpentries Incubator](https://github.com/carpentries-incubator/proposals/#the-carpentries-incubator);
- The Bash manual.



## Table of Content

```{toctree}
:caption: Motivation
motivation.md
```
```{toctree}
:caption: Intermediate 
general_best_practices.md
bash/dealing_with_repetition.md
bash/composability.md
ssh/tips-and-tricks.md
bash/interactive_tips_and_tricks.md
workflow-discussion_intermediate.md
```
```{toctree}
:caption: Advanced 
bash/the_manual.md
jupyter/control_flow
bash/composability2.md
bash/interactive_tips_and_tricks2.md
defensive_programming.md
jupyter/text_manipulation
job_chaining.md
embarrassingly_parallel.md
```
```{toctree}
:caption: Extra 
job_templates.md
instructor_notes.md
```



