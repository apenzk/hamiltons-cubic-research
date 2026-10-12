# I13, step 4, the $\mathbb Z_2\times\mathbb Z_2$ vertices, derived where the $\mathbb Z_3$ ones were not

**Where this comes from.** [r347](REVIEW_r347.md) handed back the positive half of the retraction: since a real orthogonal grading needs $2a\equiv0$, **the real orthogonal gradings of $\mathfrak{so}(n)$ are exactly the elementary-abelian-$2$ ones**, so $\mathbb Z_2\times\mathbb Z_2$ survives where $\mathbb Z_3$ did not. This note works it out. *The lesson from the retraction is applied throughout: the vanishing condition used is the symmetric one, $a+b+c=0$ in the group, and every claim is checked against a construction rather than read off a table.*

## The gradings, explicitly

A $\mathbb Z_2\times\mathbb Z_2$ grading of $\mathfrak{so}(n)$ is a pair of commuting involutions. **Not every such involution comes from a splitting** ([r350](REVIEW_r350.md)): an involution of $\mathfrak{so}(n)$ lifts to $g$ with $g^2=\pm I$, and $g^2=-I$ gives the $\mathfrak u(m)$-type involutions, which no splitting reproduces, at $n=6$ there is a grading with dimensions $(5,4,2,4)$ and no splitting of $\mathbb R^6$ has $\sum\binom{n_i}2=5$. Triality at $n=8$ is a second source. **So the splitting family below is a sub-family, and its counts are lower bounds, and the gap is real at $n=12$ itself: anticommuting quaternionic structures on $\mathbb R^{12}=\mathbb H^3$ give a genuine $\mathbb Z_2\times\mathbb Z_2$ grading with dimensions $(21,15,15,15)$ and $\mathfrak g_{00}=\mathfrak{sp}(3)$, realised by **none** of the $27$ genuine splittings of $12$; its merges $(36,15,15)$ and $(30,21,15)$ are **absent from the $74$-triple census below**, checked ([r349](REVIEW_r349.md)).** Each splitting is $\mathbb R^n=V_1\oplus V_2\oplus V_3\oplus V_4$ with $\sum n_i=n$, and
$$\mathfrak g_{00}=\bigoplus_i\mathfrak{so}(V_i),\quad \mathfrak g_{01}=\mathrm{Hom}(V_1,V_2)\oplus\mathrm{Hom}(V_3,V_4),\quad \mathfrak g_{10}=\mathrm{Hom}(V_1,V_3)\oplus\mathrm{Hom}(V_2,V_4),\quad \mathfrak g_{11}=\mathrm{Hom}(V_1,V_4)\oplus\mathrm{Hom}(V_2,V_3),$$
with dimensions $\sum_i\binom{n_i}2$, $n_1n_2+n_3n_4$, $n_1n_3+n_2n_4$, $n_1n_4+n_2n_3$, summing to $\binom n2$. *Screened at every splitting of $n=12$: the four dimensions sum to $66$ in each case.*

## Six zeros, uniformly, and that is a degenerate vertex

**Three eigenspaces means merging two of the four graded pieces.** There are six ways, and **every one gives six vanishing types**, screened over all six, using the condition that a type is nonzero **only if** some triple of graded pieces drawn from its three eigenspaces sums to $0$. *That condition is necessary and not sufficient ([r349](REVIEW_r349.md)), and "exactly six" additionally needs a multiplicity floor, so the count is an upper bound on the nonzero types:*

| which pieces merge | vanishing types |
|---|---|
| the merged eigenspace contains $\mathfrak g_{00}$ | $\{112,113,222,223,233,333\}$ |
| $\mathfrak g_{00}$ stands alone as $E_2$ | $\{111,122,123,133,223,333\}$ |

> **Six zeros against a feasible dimension of four, but "degenerate vertex" is REFUTED** ([r350](REVIEW_r350.md)). Six conditions on a four-dimensional affine set **generically cut the empty face**, so the count *over-determines* rather than certifying a vertex; passing a grading test is not an LP vertex certificate. **What is established is the count, and it is at least six**, [r350](REVIEW_r350.md) re-derived it from the group alone, so it covers every $\mathbb Z_2\times\mathbb Z_2$ grading and not only the splittings. *Whether the face is nonempty is a rank check, named and left unrun under the analysis-only rule.* *At $d=2$ the balanced product is degenerate by one and that surplus singles it out ([Lemma L105](../findings/bounds-relaxations.md)); the $d=3$ analogue is therefore **not** established by this count, and asserting it was the note's error.*

**The first pattern read structurally, corrected.** $\{112\},\{113\}$ vanishing says $E_1$ is a subalgebra; $\{222\},\{333\}$ say $E_2$ and $E_3$ are each bracket-orthogonal to themselves; $\{223\},\{233\}$ say $[E_2,E_2]\perp E_3$ and $[E_3,E_3]\perp E_2$.

> **THE CONCLUSION DRAWN FROM THEM WAS FALSE** ([r349](REVIEW_r349.md)). The note read this as "$E_1\oplus E_2$ and $E_1\oplus E_3$ are both subalgebras". They are not: **$\{123\}$ is absent from the zero set**, so $\langle[E_1,E_2],E_3\rangle\ne0$ and $E_1\oplus E_2$ is not closed. *What the six zeros do say is exactly the six statements listed above, The correct reading ([r349](REVIEW_r349.md)): $E_1$ is the isotropy algebra of a symmetric pair with $\mathfrak m=E_2\oplus E_3$.*

## What it does not do, stated plainly

**It does not shorten the list.** At $n=12$ the splittings give **74** distinct multiplicity triples with every multiplicity at least $3$, a long list, not a short one. *So $\mathbb Z_2\times\mathbb Z_2$ no more collapses $d=3$ than Jacobi did, and the pattern of this item is now consistent: the three-eigenvalue regime does not reduce to a handful of named algebras.*

> **AND IT REVERSES THE RETRACTED CLAIM IN THE OPPOSITE DIRECTION.** [DERIVE-t11](DERIVE-t11.md)'s witness multiplicities $(30,20,16)$ **are** realised by a $\mathbb Z_2\times\mathbb Z_2$ grading of $\mathfrak{so}(12)$, the eighteen splittings that do it are **twelve arrangements of $\{0,2,2,8\}$ and six of $\{2,2,4,4\}$**, and [r350](REVIEW_r350.md) notes the note named only the first, the attackable one, since it has an empty summand. **The clean witness is $\{2,2,4,4\}$**, grade dimensions $(14,20,16,16)$, merging $14+16$: no zero part anywhere, so the question of whether an empty $V_i$ still gives a genuine grading does not arise. *The retracted note claimed the witness was excluded because its multiplicities are distinct. Not only was that argument wrong, the conclusion is wrong too: the multiplicities are gradeable.* **This bears on multiplicities only. Whether any Weyl tensor has that spectrum, and whether it is critical, is untouched.**

**Gate 2 owed.**
