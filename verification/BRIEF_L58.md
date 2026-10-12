# Brief, round L58

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement and its witness table as the findings file carries them ([findings/ungraded-slack.md](../findings/ungraded-slack.md) lines 330-336 and 343, under the heading at line 326)

A Casimir $W_{\hh}=c\big(\Pi_{\hh}-\tfrac rN\Id\big)$ with $0<r<N$ has exactly *two* eigenvalues, $c(1-\tfrac rN)$ on $\hh$ and $-c\tfrac rN$ on its complement. Hence no graded critical point with three or more distinct eigenvalues lies in the family, and the following do not:
| witness | $n$ | $\theta$ | graded? | why it is not a Casimir |
|---|---|---|---|---|
| $\mathbb{CP}^3$ | $6$ | $\theta_0(6)=1.054092553$ | **yes**, in all three of the record's senses; $\ker W=0$ | three eigenvalues, at multiplicities $6,8,1$ |
| $S^5\times S^7$ | $12$ | $1.2282390$ | **yes**, pair-graded, a symmetric pair | three eigenvalues, $-\tfrac74$, $-\tfrac56$, $1$ at multiplicities $10,21,35$, trace $0$ |
| $W_{\mathbb{CP}^2}$ | $4$ | $\sqrt{3/2}$ | **yes** | the point that anchors the threshold sentence below, dropped from this table in the move |
| ~~$(\mathfrak{su}(3),\mathfrak{so}(3))$~~ | $6$ | $\sqrt{6/5}$ | **no** | *withdrawn as a witness*, see below |

Since $S^5\times S^7$ sits *above* $\thstar$, restricting the family by a value threshold does not recover it.

## Passage B, the argument ([findings/ungraded-slack.md](../findings/ungraded-slack.md) lines 152-165)

#### The graded critical set is strictly wider than the subalgebra family, at every threshold

**A Casimir $W_{\mathfrak h}=c\big(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\big)$ has exactly two eigenvalues** for $0<r<N$: $c(1-\tfrac rN)$ on $\mathfrak h$ and $-c\tfrac rN$ on $\mathfrak m$. **So any graded critical point whose Weyl operator has three or more distinct eigenvalues is not a Casimir**, an argument using no $\theta$, no slack and no convention.

**Three witnesses, and they run past every threshold the question can carry.**

| witness | $n$ | $\theta$ | graded | why not a Casimir |
|---|---|---|---|---|
| $\mathbb{CP}^3$ | $6$ | $\theta_0(6)=1.054092553$ | $S=2\times10^{-30}$ | three eigenvalues |
| $(\mathfrak{su}(3),\mathfrak{so}(3))$, Jensen's second Einstein metric on $S^3\times S^3$ | $6$ | $\sqrt{6/5}=1.095445115$ | $S=0$ **only**, see below | three eigenvalues $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$; equivalently a $7$-dimensional kernel |
| $S^5\times S^7$ | $12$ | $1.2282390$ | symmetric pair | its isotropy $\mathfrak{so}(5)+\mathfrak{so}(7)$ has $r=31$, and the family's $\theta$ at $r=31$ is $1.2742878$ |

**So the subalgebra family does not exhaust the graded critical set, and no threshold repairs it.** $S^5\times S^7$ sits **above** $\sqrt{3/2}=1.2247449$, so restricting the claim to $\theta>\sqrt{3/2}$ leaves it false; and $W_{\mathbb{CP}^2}$ sits exactly *at* the threshold, graded, critical, and likewise not a Casimir. **A proof of (H) cannot classify subalgebras alone at any threshold.**


## Passage C, the canonical statement, landscape form ([results.md](../results.md) line 192)

- **Lemma L58 (landscape). The graded set is strictly wider than the subalgebra family.** A Casimir point $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has exactly two eigenvalues, so no graded critical point with three or more distinct eigenvalues lies in the subalgebra family. $\mathbb{CP}^3$ at $n=6$, $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$ and $S^5\times S^7$ at $n=12$ are graded and outside it.

## Passage D, the canonical statement, detail form ([results.md](../results.md) line 669, under the heading at line 667)

A Casimir operator $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $0<r<N$ has exactly two eigenvalues, $c(1-\tfrac rN)$ on $\mathfrak h$ and $-c\tfrac rN$ on $\mathfrak h^\perp$. Hence a graded critical point with three or more distinct eigenvalues lies outside the subalgebra family of Lemma L23, and the following are graded and outside it: $\mathbb{CP}^3$ at $n=6$ with $\theta=\theta_0(6)$ and three eigenvalues; $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$ with $\theta=\sqrt{6/5}$ and three eigenvalues; $S^5\times S^7$ at $n=12$ with $\theta=1.228239$, whose isotropy $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ has $r=31$ and whose family value there is $1.2742878$. Consequently Lemma L23's cap at $\theta_0(n)$ is a statement about the family and the graded case needs Lemma L69's classification instead.

## Passage E, the given the statement leans on, Lemma L23's canonical entry ([results.md](../results.md) lines 507-517)

##### Lemma L23, the conjecture on the subalgebra family, and gradedness as the cap

Let $\mathfrak h\subseteq\mathfrak{so}(n)=\Lambda^2\mathbb R^n$ be a subalgebra with $\mathfrak m=\mathfrak h^\perp$, $r=\dim\mathfrak h$, $N=\binom n2$ and $0<r<N$, and let $W_{\mathfrak h}$ be the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$. If $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, then

$$\theta=\frac2n\sqrt{\frac{rN}{N-r}},\qquad S_{\mathfrak{mmm}}:=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2=(N-r)\Big[2(n-2)-\frac{4(n-1)r}{N}\Big],$$

*the $2(n-2)$ being the Killing row marginal, **[Lemma L153](../findings/bounds.md)**, summed over the $N-r$ rows of $\mathfrak m$.*

hence $r\le n(n-2)/4$ and $\theta\le\theta_0(n)$, with equality in either place exactly when $S_{\mathfrak{mmm}}=0$, that is, when $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, when $W_{\mathfrak h}$ is $\mathbb Z_2$-graded, and when $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. For $n$ even the equality case is $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone, $n=8$ included, where triality's two extra $\mathbb Z_2$-gradings have dimensions $21$ and $13$ against the cap $12$, so the maximum over the family is attained exactly at the Weyl operator of $S^{n/2}\times S^{n/2}$; for $n$ odd the cap is not an integer and the inequality is strict.

**Proof:** [ungraded-slack.md](../findings/ungraded-slack.md)

## Passage F, what "graded" means on the record ([findings/conventions.md](../findings/conventions.md) line 150; [findings/INDEX-traps.md](../findings/INDEX-traps.md) line 21)

- **"Graded" carries three senses** ((C) pair, (A) sign, (B) slice) and **(C) and (A) are incomparable**, each implying (B). A claim proved in one does not transfer to another. See [W3](../findings/INDEX-traps.md) and [graded-half.md](../findings/graded-half.md).

| **W3** | **"GRADED" HAS THREE SENSES, AND TWO ARE INCOMPARABLE** | **(C) pair-graded** (Lemmas 8, 69) and **(A) sign-graded** (the defect screen) each imply **(B) slice-graded** (the C3 route), and **neither implies the other**: $\mathbb{CP}^2$ is (C) not (A), $\ker W=3$ of $6$; the $n=8$ witness is (A) not (C). A claim proved in one does not transfer to the other | [graded-half.md](../findings/graded-half.md) |

## Definitions

- $\mathcal W_n$ is the space of algebraic Weyl tensors, viewed as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=\binom n2$; $\Pi_{\mathfrak h}$ is orthogonal projection onto a subspace $\mathfrak h$ of dimension $r$; a critical point is a unit $W$ with $Q(W)=\theta W$.
- No Lean statement file exists for L58; [lean/HamiltonsCubic/Results/L58.lean](../lean/HamiltonsCubic/Results/L58.lean) may be read for what it checks.

## What to attack, beyond the standing list

1. **The Casimir step**: that $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has exactly two eigenvalues for $0<r<N$, the values, and whether "three or more distinct eigenvalues excludes every Casimir" needs anything about $\mathfrak h$.
2. **Each witness, row by row**: that it is a critical point, its $\theta$, **that it is graded and in which of the three senses of Passage F**, with the argument quoted or its absence named, and that it has three distinct eigenvalues, **with the stated values and multiplicities derived or their absence named**. Include $W_{\mathbb{CP}^2}$ at $n=4$.
3. **The withdrawn row**: whether $S=0$ with a $7$-dimensional kernel establishes gradedness in any sense, given Passage F's warning.
4. **The canon against the block**: Passages C and D against Passage A, including which witnesses each carries, and **Passage D's "whose family value there is $1.2742878$"** against Passage E's cap on $r$ at $n=12$.
5. **"Since $S^5\times S^7$ sits *above* $\thstar$"**: what $\thstar$ is, whether it is defined in any quoted passage, and whether the sentence holds.
6. **The consequence** in Passage D, that L23's cap "is a statement about the family and the graded case needs Lemma L69's classification instead".
7. **Numerical entries**: which values in Passages A, B and D are given in closed form and which only as decimals or as a numerical slack.
8. The boundary: $n=4$ and $6$, $\ker W\ne0$, and $r=0$ or $r=N$.

