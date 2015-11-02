## Declarative

I'd like to explore whether it's possible to write a high-level programming
language for solving problems in a declarative way. This programming language
should be rich in abstractions that programmers take for granted; such as
integers, strings, data structures, control flow and functions.

The current landscape is vastly imperative and I believe that this is due to the
lack of intuitive, easy-to-use declarative languages. This project is a lens
through which this idea will be explored by attempting to build a language of
this kind.

## What am I talking about?

I want to write a program that looks something like this:

```
function main (int x, int y) {
  return square(x) + square(y) == 90;
}

function square (int x) {
  return x * x;
}
```

I then want to run this program without supplying any arguments.

The language then suggests inputs that result in `true` being returned.

e.g. `(x = 9, y = 3)` or `(x = -3, y = 9)`

## Connection to NP-Completeness

In complexity theory, problems are classified by how "difficult" they are
relative to the size of the input. One of these classes of problems is
NP-complete.  These problems are difficult to solve, but easy to check. For
example, Sudoku is difficult to solve, but a solution can be checked for
correctness relatively quickly.

Currently, we tend to solve NP-complete problems by coming up with some novel
imperative algorithm. For example, we write sudoku solvers that might try
putting random numbers in the cells and then backtracking if it turns out they
were incorrect.

**I think there's a better way.**

One property of NP-complete problems is that they are all reducible to each
other. This means that you can transform an instance of solving a Sudoku puzzle
into satisfying a boolean equation or colouring in a graph with different
colours. This means that you could solve a Sudoku puzzle, by first reducing it
to a boolean equation and then solving that boolean equation.

This project aims to provide the tools to do this. Rather than compiling a
program down to imperative code that pushes electrons around a computer,
instead, it aims to produce a boolean equation that can be fed to a solver that
is an expert and solving these types of equations.

By using boolean satisfiability as the "foundation" or the "assembly" of a
language hierarchy, I think we will create languages that are inherently
different, unique and more capable.
