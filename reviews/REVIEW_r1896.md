# REVIEW r1896: H on a simple subalgebra asks only for a trace lower bound

Log: [agent_logs/r1896-trace-threshold.log](../agent_logs/r1896-trace-threshold.log). Section under review: [2026-09-28l-I117-g2-torus.md](2026-09-28l-I117-g2-torus.md), "H on a simple subalgebra asks only for a lower bound on the trace". Analysis only; the arithmetic below is by hand, with one seconds-long screen of the five sp(k) roots (a screen, agreeing).

| # | claim | verdict |
|---|---|---|
| 1 | general statement and proof | CONFIRMED (one scope remark) |
| 2 | classification sentence (L259 (3), L260's Lemma C) | PLAUSIBLE: L259 (3) right, the Lemma C citation points to the wrong file |
| 3 | g2 scalars, bound, equality, threshold 12/7, n=9 binds | CONFIRMED |
| 4 | g2 known points | CONFIRMED |
| 5 | sp(k) decomposition, scalars, bound, tau_- values | CONFIRMED (one wording correction) |
| 6 | torus-family bullet | CONFIRMED |
| 7 | Lean | CONFIRMED |

## 1. The general statement

- Pairing: $\langle C^\#C,I\rangle=F(C,C,I)=F(C,I,C)=\langle C,I^\#C\rangle$ by symmetry of $F$, and $\langle C,I\rangle=\operatorname{tr}C=\tau$ in the Frobenius product. Correct.
- Trivial part: $C_0=(\tau/d)I$, $\lVert C_0\rVert^2=\tau^2/d$, and $\langle C_0,I^\#C_0\rangle=(\tau/d)^2\,c\,d=c\tau^2/d$. Correct.
- $I^\#$ is self-adjoint and scalar ($\gamma_V$) on each Casimir eigenspace of $\operatorname{Sym}^2\mathfrak h$, so the cross terms vanish and multiplicities do not matter. Independent check of the scalars: $\operatorname{tr}(I^\#)$ on $\operatorname{Sym}^2\mathfrak h$ is $\tfrac12\sum_k\tfrac12\operatorname{tr}(\mathrm{ad}_{e_k}^2)=-cd/2$; on $\mathfrak g_2$, $4+\tfrac53\cdot27-77=-28=-4\cdot14/2$, and on $\mathfrak{sp}(2)$, $3+2\cdot5+\tfrac12\cdot14-35=-15=-3\cdot10/2$.
- Inequality step: $\sum_V\gamma_V\lVert C_V\rVert^2\le\gamma^*\sum_V\lVert C_V\rVert^2$ uses only $\lVert C_V\rVert^2\ge0$ and $\gamma_V\le\gamma^*$, **with no sign condition on $\gamma^*$**. So the displayed inequality $\gamma^*\lVert C\rVert^2\ge\tau-(c-\gamma^*)\tau^2/d$ holds as stated for every $\gamma^*$ (the Lean core carries no sign hypothesis either).
- Scope remark: the inequality reads as a lower bound on $\lVert C\rVert^2$ only when $\gamma^*>0$. At $\gamma^*=0$ it bounds the trace alone, and at $\gamma^*<0$ it is an upper bound on the norm. By L265's ratios, $\gamma^*=c(1-r_{\min}/2)>0$ on every compact simple $\mathfrak h$ except $\mathfrak{su}(2)$, whose only nontrivial component (spin 2, ratio 3) gives $\gamma^*=-c/2$; there the pairing is an identity, $\lVert C\rVert^2=\tau^2-2\tau/c$. Worth one clause in the statement.
- Cauchy–Schwarz: $\tau^2=\langle C,I\rangle^2\le d\lVert C\rVert^2$. Correct.

## 2. The classification sentence

- "L259 (3)'s pairing with $\mathfrak h$'s own scalars": correct. L259 (3) pairs $C^\#C=C$ with $I$ using $\mathfrak{so}(n)$'s scalars $n-2,\tfrac{n-4}2,-1,2$; this section does the same with L265's scalars on $\mathfrak h$.
- "[L260](../findings/second-order.md)'s Lemma C": **the citation misses.** L260 in findings/second-order.md has parts (1)–(4) and no "Lemma C", and the quoted words "the norm from below only relative to the trace" appear nowhere in the finding. They are Lemma C's restated obstacle in [the class-ceiling note](2026-09-26-I73-class-ceiling.md) (batch 33, line 331), which the record carries as L260 (4), with the obstacle as the last sentence of L260's "What it gives" ("the norm from below relative to the trace ($\operatorname{tr}C\le c\lVert C\rVert^2$)"). Correction: cite "L260 (4) and its closing sentence (Lemma C of the class-ceiling note, batch 33)", or link the note. The substance of the comparison holds: the new bound refines $\tau\le c\lVert C\rVert^2$ by putting $\gamma^*<c$ in place of $I^\#$'s top eigenvalue $c$ off the trivial component.

## 3. g2

- Scalars: $\mathrm{Cas}_{\mathfrak h}(\mathfrak h)=8$, $\mathrm{Cas}_{\mathbf{27}}=\tfrac76\cdot8=\tfrac{28}3$, $\mathrm{Cas}_{\mathbf{77}}=20$, which gives $\gamma=4-\tfrac73=\tfrac53$ and $4-5=-1$. Correct.
- Bound: $\tfrac53q\ge\tau-\tfrac73\tau^2/14=\tau-\tau^2/6$, so $q\ge\tfrac35\tau-\tfrac1{10}\tau^2$. Correct.
- Equality exactly when $C_{\mathbf{77}}=0$: the only slack is $(\tfrac53+1)\lVert C_{\mathbf{77}}\rVert^2$. Correct.
- Threshold: $\tfrac35\tau-\tfrac{\tau^2}{10}\ge\tfrac{36}{49}$ is $\tau^2-6\tau+\tfrac{360}{49}\le0$, roots $3\pm\tfrac97=\tfrac{12}7,\tfrac{30}7$. $\tau^2/14\ge\tfrac{36}{49}$ for $\tau\ge\sqrt{72/7}=3.207<\tfrac{30}7$. So together they cover $[\tfrac{12}7,\infty)$. Correct.
- $n=9$ binds. $N/(n-2)^2\propto(n^2-n)/(n-2)^2$ has derivative sign $-3n+2<0$, so it falls with $n$. $\mathfrak{so}(7)\subset\mathfrak{so}(n)$ keeps the metric. Directions: under a rep of Dynkin index $j$ the induced metric is $j$ times $\mathfrak{so}(7)$'s, orthonormal structure constants scale by $j^{-1/2}$, and $\#$ (quadratic in them) scales by $1/j$. An idempotent $C'$ of $\#/j$ is $jC$ with $C$ an idempotent of $\#$, and the Frobenius norm of an endomorphism is unchanged by a uniform rescaling of the metric. So $\lVert C'\rVert^2=j^2\lVert C\rVert^2$, and H asks $\lVert C\rVert^2\ge N/((n-2)^2j^2)$. Every nontrivial real rep has $j\ge1$ (the $\mathbf7$ being index one), and larger $j$ also forces larger $n$. Correct in every direction.
- Wording: the section says "the trace H needs" and "asks only for". Trace $\ge\tfrac{12}7$ is **sufficient** for H on $\mathfrak g_2$, and it is not shown to be necessary, since a large $C_{\mathbf{77}}$ also raises the norm. The heading's "asks only" carries this meaning. The sp(k) bullet's "the trace H needs" should read "the trace that suffices for H".

## 4. g2's known points

- $I/4$: trace $\tfrac{14}4=\tfrac72$, norm $\tfrac78$, bound $\tfrac{21}{10}-\tfrac{49}{40}=\tfrac78$: equality. Correct.
- L263's $SU(3)$ point, $\tfrac9{28}P_{\mathfrak{su}(3)}+\tfrac3{28}P_{\mathfrak p}$ with dimensions $8,6$: $\tau=\tfrac{72+18}{28}=\tfrac{45}{14}$, $\lVert C\rVert^2=\tfrac{648+54}{784}=\tfrac{351}{392}$, bound $\tfrac{27}{14}-\tfrac{2025}{1960}=\tfrac{1755}{1960}=\tfrac{351}{392}$. **Equality holds exactly**, so by the pairing its $\mathbf{77}$ part vanishes. Correct.
- Other traces. $SO(4)$ point: $\tfrac{48}{29}+8\sqrt{77/1682}=3.367$. Reflection point ($x,z$ long, $u,y$ short, from the table): $\operatorname{tr}A=2(x^2+2z^2)+\tfrac23(y^2+2u^2)=0.6421$, $2\sum w=2.5726$, $\tau=3.2147$. The range $3.21$ to $3.37$ is correct. Both sit above the parabola by small margins (norms $0.8870$ vs bound $0.8866$, and $0.895440$ vs $0.895389$), consistent with $C_{\mathbf{77}}\ne0$ there.

## 5. sp(k)

- Metric: long roots $2\varepsilon_i$ of $\mathfrak{sp}(k)$ are roots $e_a-e_b$ of $\mathfrak{su}(2k)\subset\mathfrak{so}(4k)$, so $\lvert\alpha_{\rm long}\rvert^2=2$ and $\mathrm{Cas}(\lambda)=(\lambda,\lambda+2\rho)$ in that normalisation. Adjoint $2\varepsilon_1$ gives $2(k+1)=2c$. Correct.
- Decomposition: $\operatorname{Sym}^2(\operatorname{Sym}^2V)=\operatorname{Sym}^4V\oplus S_{(2,2)}V$ for $GL(V)$, and under $Sp(V)$ $\operatorname{Sym}^4V=[4\omega_1]$ and $S_{(2,2)}V=[2\omega_2]\oplus[\omega_2]\oplus[0]$. Dimension check at $k=2$: $35+14+5+1=55$. Correct for $k\ge2$.
- Scalars, using $\lvert\varepsilon\rvert^2=1$ and halving: $[\omega_2]$ has $\tfrac12(2+4k-2)=2k$, so $\gamma=\tfrac{k+2}2$ (L265's ratio $\tfrac k{k+1}$). $[2\omega_2]$ has $\tfrac12(8+8k-4)=4k+2$, so $\gamma=\tfrac12$. $[4\omega_1]$ has $\tfrac12(16+8k)=4k+8$, so $\gamma=-1$. The trace check in item 1 passes at $k=2$. Correct.
- Bound: $\gamma^*=\tfrac{k+2}2$, $c-\gamma^*=\tfrac k2$, $\tfrac k2\tau^2/(k(2k+1))=\tau^2/(2(2k+1))$. Correct.
- $\tau_-$ (by hand, and by a seconds-long screen that agrees): $1.7897, 1.9108, 2.0762, 2.2911, 2.5265$ at $n=9,12,16,20,24$. $d/c$ is as listed, and the fractions are $0.537,0.364,0.288,0.250,0.227$. The listed $1.79,1.91,2.08,2.29,2.53$ and "$0.54$ to $0.23$" are correct. The upper root far exceeds $\sqrt{d\,N/(n-2)^2}$ at every $k$, so the covering argument carries over.
- Unstated but true: $n=4k$ binds as on $\mathfrak g_2$ (the $4k$ real rep has the least index). At $k=2$, $\mathfrak{so}(5)$'s vector rep induces the same metric ($c=3$ both ways), so padding to $n=9$ is the case either way.

## 6. The torus-family bullet

- $\operatorname{tr}C=\operatorname{tr}A+2\sum w_\alpha$ since $\operatorname{tr}P_\alpha=2$. Correct.
- $\hat W\ge0$ entrywise at a positive solution ($a_i\ge0$, off-diagonal entries positive). $f\ge1$ holds on every entry, as follows:
  - Long edges: $(\hat W^2)_{x,-x}=2\sum_lp_{il}q_{il}+4a_iu_i=2u_i$ by the long row, so $f=1$.
  - Short edges: $a_i<\tfrac12$ gives $p_{ij}^2+q_{ij}^2<1$, hence $\lvert A_{ij}\rvert\le\tfrac12\max(p^2,q^2)<\tfrac12$ and $f=2(1\pm A_{ij})>1$.
  - Diagonal: $2+a_i>1$.
  So $\hat W^2\ge\hat W\ge0$ entrywise. Correct for $k\ge2$.
- $\hat W$ is symmetric, nonnegative and nonzero, so $\rho>0$; $\rho^2=\rho(\hat W^2)\ge\rho(\hat W)$ gives $\rho\ge1$. Rows $\pm\varepsilon_i$ have equal sums by the block form. The sum over $+\varepsilon_i$ is $\sum a_i+\sum_j p+\sum_j q+2\sum u$, which is $\operatorname{tr}C$, and it is at least the largest row sum, which is at least $\rho\ge1$. Correct, and correctly called short of $\tau_-$.
- g2 long-root point, $w=\tfrac12$ on one long root $\alpha_0$. $A=\tfrac14\alpha_0\alpha_0^{\mathsf T}$ and every pair term vanishes, so each $\gamma\ne\alpha_0$ row is $0=0$ and the $\alpha_0$ row is $\tfrac12(1-\tfrac14\cdot4)=0$. It solves every row. $\operatorname{tr}C=\tfrac12+1=\tfrac32<\tfrac{12}7$. It is $I_3/2$ on the long-root $\mathfrak{su}(2)$, whose $c=\tfrac12(\alpha,2\alpha)=2$, so $\lVert C\rVert^2=\tfrac34\ge\tfrac{36}{49}$. Correct.
- No kernel. Taking $\alpha_0=3\alpha_1+2\alpha_2$, the Jacobian is block diagonal:
  - $\alpha_0$ row: $-2$.
  - $\alpha_1\perp\alpha_0$: $1$.
  - The pairs $\{\alpha_2,3\alpha_1+\alpha_2\}$ (long) and $\{\alpha_1+\alpha_2,2\alpha_1+\alpha_2\}$ (short), coupled through $\gamma=\alpha_0-\delta$: blocks $\begin{pmatrix}3/4&\mp1/2\\\mp1/2&3/4\end{pmatrix}$ (diagonal $1-\tfrac14(\alpha_0\cdot\gamma)^2=\tfrac34$), eigenvalues $\tfrac54,\tfrac14$.
  All are nonzero, whatever the sign convention on the coefficients (even $\tfrac23$ in place of $\tfrac12$ gives $\tfrac34\pm\tfrac23\ne0$). Isolated in the family. Correct.
- sp(k) long-root $\mathfrak{sp}(1)$ ($u_i=\tfrac12$, the rest $0$): $a_i=\tfrac12$, the long row gives $\tfrac12(1-1)=0$, and the diagonal of $\hat W$ gives $\tfrac14+1=\tfrac54=(2+\tfrac12)\tfrac12$. It solves the rows, with $\operatorname{tr}C=\tfrac12+1=\tfrac32$. Correct.

## 7. Lean

- `norm_ge_of_pairing` states the scalar core exactly as the table says (hypotheses `hpair`, `hq`, `hn`, `hγ`, no sign on `gstar`, which matches item 1). `g2_threshold` takes the core instance at $c=4$, $d=14$, $\gamma^*=\tfrac53$, plus $\tau^2\le14q$ and $\tau\ge\tfrac{12}7$, and concludes $q\ge\tfrac{36}{49}$. It matches the note.
- A scratch copy compiled with `lake env lean`. `#print axioms` for both: `[propext, Classical.choice, Quot.sound]`. The pairing identity, the Casimirs and the decompositions stay prose, as the note says.

## Corrections to fold

1. Item 2: replace "L260's Lemma C" with "L260 (4) and its closing sentence (Lemma C of the class-ceiling note, batch 33)", or link that note. The quoted phrase is the note's, not the finding's.
2. Item 1: add to the statement that it gives a norm lower bound when $\gamma^*>0$, which is every compact simple $\mathfrak h$ except $\mathfrak{su}(2)$.
3. Items 3 and 5: "the trace H needs" should read "the trace that suffices for H" ($\tau\ge\tau_-$ is sufficient and has not been shown necessary).
