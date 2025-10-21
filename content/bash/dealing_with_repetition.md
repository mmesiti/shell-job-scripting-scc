# Dealing with repetition

```{objectives} 
1. Repeat actions on multiple files using for loops and pathname expansion (AKA globbing)
2. Iterate on values using `seq`
```

```{admonition} To follow along
Please navigate to the `examples/dealing_with_repetition` directory
```

## Iterating on multiple files/directories with `for` loops

Example: 

```bash
for filename in data/*.dat 
do
   ./process.sh "$filename"
done
```

What is happening here?
1. `data/*.dat` is expanded to a list of file names
    via *globbing* or *pathname expansion*.  
    See it with `echo`:
    ```bash
    echo data/*.dat
    ```
2. The *variable* `filename` is assigned 
   one value from the list,
   for each time the loop body is executed

## Non integer parameter scans with `seq` 

The `for` loop has also another possible syntax,
```bash
for ((i=0;i<5;i++))
do
   echo $i
done
```
Bash can do some arithmetic, but only with integers:
```bash
echo $((5+4))
```

`seq` can be used to generate a sequence of floating point values:

```bash
for x in `seq 0.3 0.1 1.1`
do 
    ./simulate "$x"
done

```




