# Notes, Holland–Ion, arXiv:1211.4159 (Chapter 8 read in full; Chapters 1–7 skimmed for the setting only)

Stored 2026-09-07. [holland-ion-1211.4159.pdf](https://arxiv.org/abs/1211.4159), [holland-ion-1211.4159.txt](https://arxiv.org/abs/1211.4159) (`pdftotext -layout`, 109 pages). The extraction is clean: the Dynkin diagrams come out as scattered `◦` glyphs, but every statement paragraph and every summary table survives legibly.

## What the source is

Lecture notes on symmetric spaces from a graduate course. The preface names its debts (Borel, Kobayashi–Nomizu, Helgason, and Knapp for the Vogan-diagram treatment of Chapter 8) so this is a secondary exposition of the standard classification, not a new derivation of it. That is what the record needs: a fetchable text in which a reader can check the list.

## The classification of $\mathfrak{so}(n)$'s symmetric pairs, verbatim

Chapter 8 §2 classifies the irreducible orthogonal symmetric Lie algebras by Vogan diagram. §2.1 handles diagrams whose involution acts trivially on the Dynkin diagram; §2.3 handles those where it does not. The four $\mathfrak{so}(n)$ cases are split across both.

**Odd $n$, type $B_n$, p. 96, §2.1** (table on p. 97, Cartan type BI)**:**

> "The noncompact form has $\mathfrak g_o=\mathfrak{so}(p,q)$, $p+q=2n+1$, $p,q>0$, and $\mathfrak k_o=\mathfrak{so}(p)+\mathfrak{so}(q)$. The compact form has $\mathfrak g_o=\mathfrak{so}(n+1)$ and $\mathfrak k_o=\mathfrak{so}(p)+\mathfrak{so}(q)$."

*The "$\mathfrak{so}(n+1)$" in the second sentence is a typographical slip for $\mathfrak{so}(2n+1)$*; the accompanying table on the same page prints the space as $\mathrm{SO}(2n+1)/(\mathrm{SO}(p)\times\mathrm{SO}(q))$, Cartan type BI, so the intended reading is unambiguous. Recorded here because a reader quoting the sentence rather than the table would carry the slip.

**Even $n$, $p$ and $q$ even, type $D_n$, p. 98, §2.1** (tables on p. 99, Cartan types DI and DIII)**:**

> "The noncompact forms are $\mathfrak g_o=\mathfrak{so}(p,q)$, $p+q=2n$, $p\ge2$, $q\ge4$ (even) with $\mathfrak k_o=\mathfrak{so}(p)+\mathfrak{so}(q)$ with rank $\min(p,q)$, and $\mathfrak g_o=\mathfrak{so}^*(2n)$ and $\mathfrak k_o=\mathfrak u(n)$ with rank $\lfloor n/2\rfloor$. … The corresponding compact forms are $\mathfrak g_o=\mathfrak{so}(2n)$ and $\mathfrak k_o=\mathfrak{so}(p)+\mathfrak{so}(q)$ for $p+q=2n$, $p\ge2,q\ge4$, and $\mathfrak k_o=\mathfrak u(n)$."

**Even $n$, $p$ and $q$ odd, type $D_n$, p. 103, §2.3** (the diagram involution is the node swap at the fork; table on p. 104):

> "We have $\mathfrak g_o=\mathfrak{so}(p,q)$ in the noncompact case and $\mathfrak g_o=\mathfrak{so}(2n)$ in the compact case, and $\mathfrak k_o=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$. Here $p,q\ge1$ are both odd, $p+q=2n$."

**So the record's fact 1 is printed in full**: the compact $\mathfrak{so}(N)$ carries exactly the symmetric pairs $\mathfrak k=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=N$ (any parity split, the even/odd cases arriving from the two halves of §2), together with $\mathfrak k=\mathfrak u(N/2)$ when $N$ is even. The parity split across §2.1 and §2.3 is worth holding: a reader who stops at §2.1 sees only even $p,q$ and would wrongly conclude that $\mathfrak{so}(3)\oplus\mathfrak{so}(9)\subset\mathfrak{so}(12)$ is absent from the list.

## The exceptional pairs, all twelve, pp. 100–105

| Cartan type | compact pair $(\mathfrak g,\mathfrak k)$ | page |
| --- | --- | --- |
| G | $\mathfrak g_2$, $\mathfrak{su}(2)+\mathfrak{su}(2)$ | 102 |
| FI | $\mathfrak f_4$, $\mathfrak{sp}(3)\oplus\mathfrak{su}(2)$ | 102 |
| FII | $\mathfrak f_4$, $\mathfrak{so}(9)$ | 102 |
| EI | $\mathfrak e_6$, $\mathfrak{sp}(4)$ | 104 (§2.3) |
| EII | $\mathfrak e_6$, $\mathfrak{su}(6)\oplus\mathfrak{su}(2)$ | 100 |
| EIII | $\mathfrak e_6$, $\mathfrak{so}(10)\oplus\mathfrak u(1)$ | 100 |
| EIV | $\mathfrak e_6$, $\mathfrak f_4$ | 104 (§2.3) |
| EV | $\mathfrak e_7$, $\mathfrak{su}(8)$ | 101 |
| EVI | $\mathfrak e_7$, $\mathfrak{so}(12)\oplus\mathfrak{su}(2)$ | 101 |
| EVII | $\mathfrak e_7$, $\mathfrak e_6\oplus\mathfrak u(1)$ | 101 |
| EVIII | $\mathfrak e_8$, $\mathfrak{so}(16)$ | 101 |
| EIX | $\mathfrak e_8$, $\mathfrak e_7\oplus\mathfrak{su}(2)$ | 101 |

*The G row carries a second typographical slip: the Type I space on p. 102 is printed "$G_2(2)/SU(2)\times SU(2)$", repeating the noncompact label where the compact $G_2/SU(2)\times SU(2)$ is meant.*

This is the list [graded-half.md](../../findings/graded-half.md) calls "the twelve exceptional spaces", and the record can now cite it rather than assert it. The source prints $(\mathfrak g,\mathfrak k)$ and the rank; it prints **no dimensions and no Casimir eigenvalues**, so the arithmetic the Dimension Lemma runs on those twelve still has to be done from $\dim\mathfrak g$ and $\dim\mathfrak k$ supplied elsewhere.

## What the source does not cover

- **The equivalence relation is never named.** Chapter 8 classifies pairs $(\mathfrak g_o,\mathfrak s_o)$ by Vogan diagram and closes §2 with the Borel–de Siebenthal theorem (Proposition 28), which is a normalisation statement about the *diagram*, not about conjugacy of subalgebras inside $\mathfrak{so}(n)$. Nothing here licenses the step from "$\mathfrak h$ is one of these pairs" to "$\mathfrak h$ is $SO(n)$-conjugate to the standard embedding."
- **$n=8$ is not distinguished.** The words "triality" and "$D_4$" do not appear in Chapter 8; the $D_n$ discussion is uniform in $n$. A reader consuming only this source would not learn that the exceptional dimension exists.
- **Completeness is asserted rather than proved.** §2 opens: *"We shall not prove here that every possible Vogan diagram gives a simple real Lie algebra, although this is true. Rather we content ourselves with the fact that once we have listed all of those that are admissible, we shall have obtained the complete classification."*
