# Understanding the Bash manual


The Bash manual is well written 
and with a little help 
it can be a very good source 
where to look up for *clarifications*.

```{objectives}
- Retrieve information efficiently from the Bash manual
```

```{exercise} What is ${...}? What can be done with it?

The syntax `${parameter}` is a Bash feature 
that has a lot of interesting variants.

What are the use cases? 
How can you search for that information in the Bash manual?

```{solution}
Searching in the Bash manual using the string `\$\{`, 
(with all the escape characters)
one finds that the feature is called **Parameter Expansion**,
and a number of examples.
```


```{exercise} Expansions and their names

Expansions are named:
1. Brace Expansion
2. Tilde Expansion
3. Parameter Expansion
4. Command Substitution
5. Arithmetic Expansion
6. Process Substitution
7. Word Splitting
8. Pathname Expansion

Which one of the mentioned expansions happen in these bash commands?

a. `A="a long sentence"; ARR=($A)`  
b. `MYPATH=$(find . -name "*file*" | tail -n 1)`  
c. `diff <(sort file1.txt) <(sort file2.txt)`  
d. `A=52; B=53; echo $((A+B))`  
e. `mkdir {a,b,c}{1,2,3}`  
f. `ls a/b*/c`  
g. `for x in \`seq 0.3 0.1 0.7\` ; do echo $x; done`

```{solution}
a. `A="a long sentence"; ARR=($A)`: Word Splitting
b. `MYPATH=$(find . -name "*file*" | tail -n 1)`: Command substitution
c. `diff <(sort file1.txt) <(sort file2.txt)`: Process substitution
d. `A=52; B=53; echo $((A+B))`: Arithmetic Expansion
e. `mkdir {a,b,c}{1,2,3}`: Brace Expansion
f. `ls a/b*/c`: Pathname Expansion
g. `for x in \`seq 0.3 0.1 0.7\` ; do echo $x; done`: Command substitution (old style)

```



```{keypoints}
- Use `/` to search the manual. Escape with `\` special characters in the search string.
- Use proper names for bash features, 
  so that you can search for them in the bash manual.
- For Bash builtins (`set`,`export`,`shopt` etc.), you can use `help`.
```


