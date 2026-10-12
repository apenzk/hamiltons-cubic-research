# REVIEW r1897: H on a simple subalgebra asks only for a trace lower bound

Log: [agent_logs/r1897-trace-threshold.log](../agent_logs/r1897-trace-threshold.log)

Section under review: "H on a simple subalgebra asks only for a lower bound on the trace" in [the g2 torus note](2026-09-28l-I117-g2-torus.md), with [TraceThreshold.lean](../lean/HamiltonsCubic/Results/TraceThreshold.lean). Analysis only. The arithmetic checks below are screens on objects built for the purpose (hand arithmetic), and none is offered as evidence for a positive claim beyond the derivation it accompanies.

| # | claim | verdict |
|---|---|---|
| 1 | general statement and proof | CONFIRMED, with one scope note (sign of γ*) |
| 2 | classification sentence (L259 (3), L260 Lemma C) | PLAUSIBLE, two corrections |
| 3 | g2 scalars, bound, equality, threshold 12/7, n=9 binds | CONFIRMED |
| 4 | g2 known points | CONFIRMED |
| 5 | sp(k) decomposition, scalars, bound, tau_- values | CONFIRMED, one unstated step supplied |
| 6 | torus-family bullet | CONFIRMED, two wording corrections |
| 7 | Lean declarations, axioms | CONFIRMED |

## 1. The general statement

- **Pairing identity.** $\langle C^\#C,I\rangle=F(C,C,I)=F(C,I,C)=\langle C^\#I,C\rangle=\langle I^\#C,C\rangle$ by symmetry of $F$ and commutativity of $\#$. Correct.
- **Trivial component.** On a compact simple $\mathfrak h$ the invariant symmetric forms are one-dimensional, so the trivial isotypic part of $\operatorname{Sym}^2\mathfrak h$ is $\mathbb RI$ and $C$'s projection there is $(\tau/d)I$. Its contribution is $c(\tau/d)^2\lVert I\rVert^2=c\tau^2/d$. Correct. $I^\#$ is self-adjoint and preserves each isotypic component (a repeated irreducible type still has one Casimir value), so there are no cross terms.
- **Inequality step.** $\sum_V\gamma_V\lVert C_V\rVert^2\le\gamma^*\sum_V\lVert C_V\rVert^2$ needs only $\gamma_V\le\gamma^*$ and $\lVert C_V\rVert^2\ge0$. **The displayed inequality $\gamma^*\lVert C\rVert^2\ge\tau-(c-\gamma^*)\tau^2/d$ holds for every sign of $\gamma^*$.**
- **Scope note.** Reading it as a lower bound on $\lVert C\rVert^2$, which the section title and both bullets do, divides by $\gamma^*$ and needs $\gamma^*>0$. That holds on $\mathfrak g_2$ ($\tfrac53$), $\mathfrak{sp}(k)$ ($\tfrac{k+2}2$) and $\mathfrak{so}(n)$, $n\ge8$ ($\tfrac{n-4}2$). **It fails on $\mathfrak{su}(2)$**: $\operatorname{Sym}^2\mathfrak{su}(2)=\mathbf1\oplus\mathbf5$ and L265's ratio $3$ gives $\gamma^*=c-\tfrac32c=-\tfrac c2<0$. There the same pairing gives an upper bound on the norm and instead forces $\tau\ge d/c$ (for $\tau>0$), since $\tau(1-c\tau/d)=\gamma^*\lVert C_{\mathbf5}\rVert^2\le0$. Recommend adding "$\gamma^*>0$" to the statement's reading as a norm bound.
- **Cauchy–Schwarz** $\tau^2=\langle C,I\rangle^2\le d\lVert C\rVert^2$. Correct.

## 2. The classification sentence

- **The pairing is L259 (3)'s**, confirmed: L259's proof of (3) is "Pair $C\#C=C$ with $I$, use $I\#$'s scalars".
- **Correction 1: the inequality taken is the opposite one.** L259 (3) eliminates the most negative scalar (the Weyl part, $-1$) through the norm identity and drops the nonnegative remainders, giving $\lVert C\rVert^2\ge\tfrac{2s^2}n-s$, a bound strong at large trace. This section bounds every scalar by the largest, $\gamma^*$, giving a bound strong at small and moderate trace. On $\mathfrak g_2$ L259's route gives $\lVert C\rVert^2\ge\tfrac5{14}\tau^2-\tau$, which reaches $\tfrac{36}{49}$ only from $\tau\approx3.40$, already inside Cauchy–Schwarz's range ($\tau\ge6\sqrt{14}/7\approx3.21$), so the new direction is what does the work. Suggest: "L259 (3)'s pairing with $\mathfrak h$'s scalars, bounded by the largest scalar where L259 eliminates the smallest".
- **Correction 2: the citation.** "Lemma C" is the name in [the D6 working note](2026-09-26-I73-class-ceiling.md), batch 33, and the quoted phrase "the norm from below only relative to the trace" is that note's obstacle paragraph, which Gate 2 ([r1222](REVIEW_r1222.md), [r1223](REVIEW_r1223.md)) marked "REFUTED as worded and restated". L260 in [second-order.md](../findings/second-order.md) has parts (1) to (4) and no Lemma C, and its "What it gives" states the relation without "only" and without calling it an obstacle: "Pairings of $C\#C=C$ bound the trace from above and the norm from below relative to the trace ($\operatorname{tr}C\le c\lVert C\rVert^2$)". The link should go to the working note's batch 33, or the quote should be L260's sentence.
- **Substance confirmed**: the new bound at $\gamma^*=c$ returns exactly $\tau\le c\lVert C\rVert^2$, so it sharpens that relation.

## 3. g2

- **Scalars.** $\mathrm{Cas}_{\mathfrak h}(\mathfrak h)=2c=8$. On $\mathbf{27}$: $\mathrm{Cas}=\tfrac76\cdot8=\tfrac{28}3$, $\gamma=4-\tfrac73=\tfrac53$. On $\mathbf{77}$: $\mathrm{Cas}=20$, $\gamma=4-5=-1$. Screen: the trace of $I^\#$ on $\operatorname{Sym}^2\mathfrak g_2$ is $\tfrac14\sum_k\operatorname{tr}\mathrm{ad}_{e_k}^2=-\tfrac14\cdot2cd=-28$, and $4+27\cdot\tfrac53-77=-28$. Both agree with L265's $\tfrac5{12},-\tfrac14$ at $I/4$.
- **Bound.** $\tfrac53q\ge\tau-\tfrac73\tau^2/14=\tau-\tau^2/6$, so $q\ge\tfrac35\tau-\tfrac1{10}\tau^2$. Correct.
- **Equality iff $C_{\mathbf{77}}=0$.** The only loss is $(\gamma^*-\gamma_{\mathbf{77}})\lVert C_{\mathbf{77}}\rVert^2=\tfrac83\lVert C_{\mathbf{77}}\rVert^2$, and the pairing is an identity at every idempotent. Correct.
- **Threshold.** $\tfrac35\tau-\tfrac{\tau^2}{10}=\tfrac{36}{49}$ is $\tau^2-6\tau+\tfrac{360}{49}=0$, roots $3\pm\tfrac97=\tfrac{12}7,\tfrac{30}7$. Cauchy–Schwarz gives $\tfrac{36}{49}$ from $\tau\ge6\sqrt{14}/7\approx3.207<\tfrac{30}7$. The covering is correct and uses no positivity.
- **n = 9 binds.** $N/(n-2)^2=\tfrac{n(n-1)}{2(n-2)^2}$ decreases in $n>2$ ($0.735,0.703,\dots$ from $n=9$). The block embedding $\mathfrak{so}(7)\subset\mathfrak{so}(n)$ keeps $-\tfrac12\operatorname{tr}$, and a subalgebra's $\#$ is the restriction because $(vv^{\mathsf T})\#(ww^{\mathsf T})=\tfrac12[v,w][v,w]^{\mathsf T}$ uses only the bracket.
- **Index scaling, checked direction by direction.** Induced metric $g'=jg$. Orthonormal $e'_k=e_k/\sqrt j$ gives structure constants $f/\sqrt j$, so $\#'=\#/j$ and $C'=jC$ solves $C'\#'C'=C'$. Then $\lVert C'\rVert^2=j^2\lVert C\rVert^2$, and H at $n$ asks $\lVert C\rVert^2\ge N/((n-2)^2j^2)$. Correct: a larger index asks less. The index-1 orthogonal representations of $\mathfrak g_2$ are $\mathbf7$ plus trivial summands (the next, $\mathbf{14}$, has index $4$), so $j=1$, $n=9$ is the binding case.

## 4. g2's known points

- **$I/4$**: $\tau=\tfrac{14}4=\tfrac72$ and $q=\tfrac78$, and $\tfrac35\cdot\tfrac72-\tfrac{49}{40}=\tfrac78$: equality, as it must be.
- **L263's $SU(3)$ point**: $\tau=8\cdot\tfrac9{28}+6\cdot\tfrac3{28}=\tfrac{45}{14}$, $q=\tfrac{351}{392}$, and $\tfrac35\cdot\tfrac{45}{14}-\tfrac1{10}\big(\tfrac{45}{14}\big)^2=\tfrac{1755}{1960}=\tfrac{351}{392}$. **Equality holds.** It also follows structurally: the $SU(3)$-invariants of $\operatorname{Sym}^2(\mathbf8\oplus\mathbf3\oplus\bar{\mathbf3})$ are two-dimensional, one in $\operatorname{Sym}^2\mathbf8$ and one in $\mathbf3\otimes\bar{\mathbf3}$. The $\mathbf1$ and the $\mathbf{27}$ ($\supset\mathbf1$ under $SU(3)$) already account for both, so $\mathbf{77}$ has no $SU(3)$-invariant and $C_{\mathbf{77}}=0$ at every $SU(3)$-invariant $C$.
- **The other traces**, from $\tau=\sum w_\alpha^2\lvert\alpha\rvert^2+2\sum w_\alpha$ (validated at $I/4$ and at $SU(3)$): the $SO(4)$ point has $\tfrac{48}{29}+8\sqrt{77/1682}\approx3.367$, and the reflection solve's degree-6 point $\approx3.2147$ (bound $0.89539<0.89544$, strict, so its $C_{\mathbf{77}}\ne0$). "3.21 to 3.37" is correct.

## 5. sp(k)

- **Decomposition.** $\mathfrak{sp}(k)=\operatorname{Sym}^2V$ and $\operatorname{Sym}^2(\operatorname{Sym}^2V)=\operatorname{Sym}^4V\oplus S_{(2,2)}V$, with $\operatorname{Sym}^4V=[4\omega_1]$ and $S_{(2,2)}V=[2\omega_2]\oplus[\omega_2]\oplus[0]$ under $Sp$. Screen at $k=2$: $35+14+5+1=55=\dim\operatorname{Sym}^2\mathfrak{sp}(2)$. Correct.
- **Casimirs**, $\langle\lambda,\lambda+2\rho\rangle$ with $\rho=(k,\dots,1)$: adjoint $4(k+1)$, $[\omega_2]$ $4k$, $[2\omega_2]$ $8k+4$, $[4\omega_1]$ $8k+16$. With $\gamma=c(1-\text{ratio}/2)$ and $c=k+1$ this gives $\tfrac{k+2}2$, $\tfrac12$, $-1$, and L265's ratio $\tfrac k{k+1}$ is reproduced. Trace screen at $k=2$: $3+5\cdot2+14\cdot\tfrac12-35=-15=-cd/2$. Correct.
- **Bound.** $c-\gamma^*=\tfrac k2$ and $d=k(2k+1)$ give $q\ge\tfrac2{k+2}\big(\tau-\tfrac{\tau^2}{2(2k+1)}\big)$. Correct.
- **$\tau_-=(2k+1)\big(1-\sqrt{1-(k+2)t/(2k+1)}\big)$** with $t=N/(n-2)^2$ at $n=9,12,16,20,24$ gives $1.790,1.911,2.076,2.291,2.526$. $d/c$ and the fractions $0.537$ and $0.227$ agree with the listed values.
- **Unstated step.** "The trace H needs is the smaller root" also needs the range above the larger root covered. It is covered, as on $\mathfrak g_2$, by Cauchy–Schwarz: $\tau_+\ge2k+1>\sqrt{k(2k+1)t}$ since $t<1$. One clause should say so.

## 6. The torus-family bullet

- **Trace formula** $\operatorname{tr}C=\operatorname{tr}A+2\sum_\alpha w_\alpha$ ($P_\alpha$ has rank 2). Correct.
- **$\hat W^2\ge\hat W$.** $\hat W\ge0$ (off-diagonal entries positive, diagonal $a_i\ge0$). The factors: long edges $1$, diagonal $2+a_i$, and short $2(1\pm A_{ij})\ge1$ because $\lvert A_{ij}\rvert\le\tfrac12\max(p^2,q^2)<\tfrac12$, from $p_{ij}^2+q_{ij}^2<1$, which follows from $a_i<\tfrac12$. Correct.
- **Perron root.** $\rho^2=\rho(\hat W^2)\ge\rho(\hat W)$ by monotonicity for nonnegative matrices, and $\rho>0$, so $\rho\ge1$. The row sum of $\pm\varepsilon_i$ is $a_i+2u_i+\sum_j(p_{ij}+q_{ij})$, the same for both signs, and summing over $i$ gives $\operatorname{tr}A+2\sum w=\operatorname{tr}C$. So $\operatorname{tr}C\ge\max$ row sum $\ge\rho\ge1$. Correct, and "short of $\tau_-$" is right.
- **Wording 1.** "H there needs it at least $\tau_-$": a trace of at least $\tau_-$ **suffices** for H. It is not needed. Also, on $\mathfrak g_2$ the threshold is $\tfrac{12}7$, which the bullet does not name.
- **The long-root $\mathfrak{su}(2)$ point on $\mathfrak g_2$.** $w_\gamma=\tfrac12$ gives row $\gamma$: $\tfrac12\big(1-\tfrac14\cdot2^2\big)=0$, and every right side is a product of two distinct weights, hence $0$. The other rows are $0=0$. It is $C=\tfrac12\Pi_{\mathfrak{su}(2)}$ ($A$ has eigenvalue $\tfrac14\lvert\gamma\rvert^2=\tfrac12$ on $\gamma$), with $\tau=\tfrac32<\tfrac{12}7$ and $q=\tfrac34\ge\tfrac{36}{49}$. All correct.
- **No kernel, derived.** Under $\mathfrak{su}(2)_L\times\mathfrak{su}(2)_S$, $\mathfrak g_2=(\mathbf3,\mathbf1)\oplus(\mathbf1,\mathbf3)\oplus(\mathbf2,\mathbf4)$. Take $C^\#X=\tfrac14\sum_{v}\mathrm{ad}_vX\mathrm{ad}_v^{\mathsf T}$ over $\mathfrak{su}(2)_L$, which acts on $U\otimes W$ by $-\tfrac14\big(J(J+1)-j_1(j_1+1)-j_2(j_2+1)\big)$, normalised so the adjoint gives $1$. The eigenvalues are: on $\operatorname{Sym}^2\mathfrak{su}(2)_L$, $1$ and $-\tfrac12$; on blocks touching $\mathfrak{su}(2)_S$, $0$; on $\operatorname{Sym}^2\mathfrak p$, $\tfrac38$ and $-\tfrac18$; on $\mathfrak{su}(2)_L\otimes\mathfrak p$, $-\tfrac14$ and $\tfrac12$ ($J=\tfrac12$). **So $\tfrac12$, the kernel of $H\mapsto2C^\#H-H$, lives only in $\mathfrak{su}(2)_L\otimes\mathfrak p$, which has no torus-invariant vector**: the weights $0,\pm\gamma$ of $\mathfrak{su}(2)_L$ are not negatives of weights of $\mathfrak p$. The torus family is all of the $T$-invariant symmetric operators, so the linearisation on the family has no kernel. Confirmed.
- **Wording 2.** In all of $\operatorname{Sym}^2\mathfrak g_2$ the kernel is 8-dimensional, the $J=\tfrac12$ part, matching $\dim G_2/(SU(2)\times SU(2))=8$: the orbit's tangent. "Isolated" should read "isolated in the torus family".
- **The $\mathfrak{sp}(1)$ remark.** $u_i=\tfrac12$ and all else $0$ gives $a_i=\tfrac12$, so the long row is $0=0$ and every other right side vanishes. The trace is $a_i+2u_i=\tfrac32<\tau_-(2)=1.79$. The same Casimir argument applies ($\mathfrak p$ is spin $\tfrac12$ under the long $\mathfrak{sp}(1)$, and the weights $\pm\varepsilon_i\pm\varepsilon_j$ never cancel $0,\pm2\varepsilon_i$). Correct.

## 7. Lean

- `norm_ge_of_pairing` states exactly the table's scalar core: the hypotheses `hn`, `hγ`, `hpair`, `hq` and the conclusion `τ - (c - gstar) * τ ^ 2 / d ≤ gstar * q`, with no sign on `gstar` (faithful to item 1's sign-free form).
- `g2_threshold` takes the core at $c=4$, $\gamma^*=\tfrac53$, $d=14$, $\tau^2\le14q$ and $\tau\ge\tfrac{12}7$, and concludes $q\ge\tfrac{36}{49}$, as the note says. The pairing identity enters as a hypothesis, as disclosed.
- A scratch copy with `#print axioms` compiled clean. Both declarations depend on `[propext, Classical.choice, Quot.sound]` only.
