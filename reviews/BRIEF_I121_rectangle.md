# Gate 2 brief, the rectangle identity for I121's small-mass node

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions, reading the written chain link by link; compute only to refute or to check a value, the smallest computation that does it (numpy under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps or open-ended searches. **Screens are screens, not evidence for a positive claim.**

## Definitions

- $\mathcal W_n$: algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$ in the orthonormal basis $e_{ab}=e_a\wedge e_b$, $a<b$, Hilbert–Schmidt norm, $Q(R)=R^2+R^\#$ with Hamilton's $\#$ normalised by $I^\#=(n-2)I$, $Q(X,Y)$ its polarisation, $X\circ Y=Q(X,Y)$, $P(W)=\langle Q(W),W\rangle$, $T(X,Y,Z)=\langle Q(X,Y),Z\rangle$ totally symmetric.
- In a frame, $W=A+B_p+B_f$: the diagonal part (entries $W_{ab,ab}=K_{ab}$), the pair part (entries $W_{ab,ac}$) and the four-set part (entries $W_{ab,cd}$ with $a,b,c,d$ distinct). $B_f=\sum_Q\nu_Q$ over four-sets $Q$, $\nu_Q\in V_Q$, the $2$-dimensional block of four-set tensors supported on $Q$.
- The sign group $\{\pm1\}^n$ acts by flipping basis vectors; $V_Q$ carries the character $\chi_Q=\prod_{a\in Q}\varepsilon_a$.

## Givens

- **P on a diagonal tensor** ([L220](../findings/second-order.md) step 7, typed as `P_PiQ` in [FourStep67.lean](../lean/HamiltonsCubic/Results/FourStep67.lean)): $P(D)=\sum_{a<b}K_{ab}^3+3\sum_{\text{triangles}}K_{ab}K_{bc}K_{ca}$.
- **The matching inequality** (Gate 2, [r1836](REVIEW_r1836.md), [r1837](REVIEW_r1837.md)): in a globally maximal frame every perfect matching $M$ satisfies $E(M)+\sum(x^e_k+x^e_l)^2+\tfrac14\sum s_{ef}^2\le t^2-\sum_{e\in M}a_e^2$, with $E(M)=\sum_{e<f\in M}(W_{ik,jl}+W_{il,jk})^2$.
- **The record's bilinear formula** ([2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md)): for $Q_1=\{i,j,k,l\}$, $Q_2=\{i,j,m,p\}$ and coordinates $(a_1,b_1,c_1)$, $(a_2,b_2,c_2)$ on their pairings, $\nu_1\circ\nu_2\in V_{Q_3}$ has pairing coefficients $\tfrac12a_1a_2$ on $(kl,mp)$, $\tfrac12(b_1b_2+c_1c_2)$ on $(km,lp)$, $\tfrac12(b_1c_2+c_1b_2)$ on $(kp,lm)$, read off numerically at $n=8$, with its coordinate convention (raw or signed) left unsettled by [r1077](REVIEW_r1077.md).
- **Post F81** as filed in [findings/fence-posts.md](../findings/fence-posts.md).

## The claims

## Coordinates on a four-set block, relative to a pairing

For a four-set $Q=\{i,j,k,l\}$ and its pairing $\pi=(e|f)$, $e=\{i,j\}$, $f=\{k,l\}$, write the raw entries $a=W_{ij,kl}$, $b=W_{ik,jl}$, $c=W_{il,jk}$, with Bianchi $a=b-c$, and set
$$J_\pi=a=W_{e,f},\qquad X_\pi=\tfrac12(b+c).$$
**$J_\pi$ is the entry of $W$ between the matched bivectors $e_{ij}$ and $e_{kl}$**, so for a perfect matching $M\ni e,f$ it is an entry of the compression of $W$ to $U_M=\mathop{\mathrm{span}}\{e_g:g\in M\}$, which every rotation in $M$'s planes fixes. **$X_\pi$ is the combination $M$ sees**: $E(M)=\sum_{e<f\in M}4X_{ef}^2$ in the [matching inequality](2026-09-28b-LIT-step8-sweep.md). With $b=X+\tfrac J2$, $c=X-\tfrac J2$,
$$\lVert\nu_Q\rVert^2=2(a^2+b^2+c^2)=4X_\pi^2+3J_\pi^2\qquad\text{for each of }Q\text{'s three pairings}\quad(\texttt{rect\_norm}).$$

## The rectangle identity

**Claim.** *Let $e_1,e_2,e_3$ be disjoint edges, $Q_{ab}=e_a\cup e_b$, and $\nu_{ab}\in V_{Q_{ab}}$ with coordinates $(J_{ab},X_{ab})$ relative to the pairing $(e_a|e_b)$. Then*
$$\tau:=\langle\nu_{12}\circ\nu_{13},\nu_{23}\rangle=\tfrac32J_{12}J_{13}J_{23}+4X_{12}X_{13}X_{23},$$
*independent of $n$, and for every four-set part $B_f=\sum_Q\nu_Q$,*
$$P(B_f)=\sum_{\text{rectangles }R}\big(9J_{12}J_{13}J_{23}+24X_{12}X_{13}X_{23}\big)_R.$$
*Here a rectangle is three disjoint edges, and $X_{12}X_{13}X_{23}$ is independent of the planes' orientations, since reversing $e_1$ negates $X_{12}$ and $X_{13}$.*

**Proof.**

1. **Only rectangles couple.** $T$ is multilinear and invariant under the sign group, and $\nu_Q$ carries the character $\chi_Q$, so $T(\nu_{Q_1},\nu_{Q_2},\nu_{Q_3})=0$ unless $\chi_{Q_1\triangle Q_2\triangle Q_3}=1$, that is $Q_3=Q_1\triangle Q_2$ with $\lvert Q_1\cap Q_2\rvert=2$ ([L120](../findings/second-order.md)'s characters). A single block has $\chi_Q^3=\chi_Q\ne1$. So $P(B_f)=6\sum_R\tau_R$, the $6$ counting the orders of three distinct blocks, and the three pairwise intersections of a rectangle's blocks are its edges.
2. **The $R^2$ part.** $\langle\nu^2,\nu\rangle=\mathop{\mathrm{tr}}\nu^3$ over the bivector basis, and the mixed terms of $\mathop{\mathrm{tr}}(\nu_{12}+\nu_{13}+\nu_{23})^3$ are $6\mathop{\mathrm{tr}}(\nu_{12}\nu_{13}\nu_{23})$. A term $\nu_{12}(x,y)\nu_{13}(y,z)\nu_{23}(z,x)$ needs $x$ inside $Q_{12}\cap Q_{23}=e_2$, so $x=e_2$, then $y=e_1$ and $z=e_3$, the complements within each block. **So the $R^2$ part is $6J_{12}J_{13}J_{23}$ and sees no crossing entry.**
3. **The $\#$ part.** In index form $\langle R^\#,R\rangle=\kappa\,I_3$ with $I_3=\sum R_{ijkl}R_{ipkq}R_{jplq}$. On a diagonal tensor $I_3=6\sum_{\text{triangles}}K_{ab}K_{bc}K_{ca}$, and $\langle D^\#,D\rangle=3\sum_{\text{triangles}}$ ([L220](../findings/second-order.md) step 7, `P_PiQ`), so $\kappa=\tfrac12$.
4. **$I_3$ on a rectangle.** Consecutive factors share two indices, so the three factors lie in three blocks pairwise meeting in an edge, and in $R_{ijkl}$ the indices $i,k$ lie in one edge and $j,l$ in another. **So every factor is a crossing entry**, $b$ or $c$, and it is $b=X+\tfrac J2$ when the two edges are traversed in the same orientation and $c=X-\tfrac J2$ otherwise. Fixing which edge carries which index pair ($6$ ways) and summing over the $2^3$ orientation bits, the three signs multiply to $1$, so the sum is $8XXX+JJJ$ (`rect_bits`). Hence $I_3=48XXX+6JJJ$ and $\langle R^\#,R\rangle=24XXX+3JJJ$.
5. **Sum.** $P=6JJJ+3JJJ+24XXX$, and $\tau=\tfrac16P$. $\square$

**Restated through step 2**: $\mathop{\mathrm{tr}}B_f^3=6\sum_RJ_{12}J_{13}J_{23}$, so $P(B_f)=\tfrac32\mathop{\mathrm{tr}}B_f^3+24\sum_RX_{12}X_{13}X_{23}$, **the invisible part entering only through the spectrum of $B_f$ as an operator on $\Lambda^2$.** *Every raw entry of $\nu_Q$ is the $J$ of one of $Q$'s pairings, so the $J$'s over all disjoint pairs of edges are exactly $B_f$'s entries, with $\sum_\pi J_\pi^2=\tfrac12\lVert\nu_Q\rVert^2$ and $\sum_\pi4X_\pi^2=\tfrac32\lVert\nu_Q\rVert^2$ on each block.*

**Check** (Gate 1 (b), a second route sharing no algebra with the proof): [check_I121_rectangle_cubic.py](../scripts/misc/check_I121_rectangle_cubic.py) evaluates $\tau$ on the eight basis triples with the record's $Q$ ($\tfrac32$ at $JJJ$, $4$ at $XXX$, $0$ at the six mixed triples, at $n=6$ and $n=8$), and $P(B_f)$ against the rectangle sum on a random four-set tensor: $20.4282301675$ both at $n=6$ ($15$ rectangles), $-207.2176848878$ both at $n=8$ ($420$).

## What it settles on the record

- **The bilinear formula's convention.** The [I104 note](2026-09-14-I104-tau-positive.md)'s formula for $\nu_1\circ\nu_2$, read off at $n=8$, was left with its coordinate convention unsettled ([r1077](REVIEW_r1077.md)): the raw and signed readings give different $\tau$. In raw coordinates, $a_1a_2a_3+(b_1b_2+c_1c_2)b_3+(b_1c_2+c_1b_2)c_3$ with $a=J$, $b=X+\tfrac J2$, $c=X-\tfrac J2$ is exactly $\tfrac32JJJ+4XXX$ (`rect_raw`). **So the raw reading is the right one, settled against a derived identity.**
- **L221's product constant with its equality case.** In unit coordinates $x=2X/\sqrt N$, $j=\sqrt3J/\sqrt N$ on each block, $\tau=\sqrt{N_1N_2N_3}\,\big(\tfrac1{2\sqrt3}j_1j_2j_3+\tfrac12x_1x_2x_3\big)$, so $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$ (`rect_unit` at $c=1/\sqrt3$), **with equality exactly when all three blocks are purely visible**, $x_i=\pm1$. The purely invisible rectangle reaches only $\tfrac1{2\sqrt3}$ of it.

## The whole of $P$ at pair-free $W$ in these coordinates

**Claim.** *For pair-free $W=A+B_f$,*
$$P(W)=P(A)+3\sum_{(e,f)}\big(\tfrac32J_{ef}^2-2X_{ef}^2\big)(a_e+a_f)+\sum_R\big(9JJJ+24XXX\big)_R,$$
*the middle sum over unordered pairs of disjoint edges, $a_e$ the diagonal entry on the edge $e$.* **Proof.** $P(A+B_f)=P(A)+3T(A,A,B_f)+3T(A,B_f,B_f)+P(B_f)$. The second term vanishes by characters, and $T(A,B_f,B_f)=\langle A,Q(B_f)\rangle=\sum_Q\langle A,\nu_Q\circ\nu_Q\rangle$, cross terms having a nontrivial character. By `nu_sq` ([FourProd.lean](../lean/HamiltonsCubic/Results/FourProd.lean)) $\nu_Q\circ\nu_Q=\Pi_Q(2a^2-b^2-c^2,\dots)$, squares being the same in raw and signed coordinates, and $2a^2-b^2-c^2=2J^2-(2X^2+\tfrac12J^2)=\tfrac32J^2-2X^2$ on the pairing $(e|f)$. By `inner_PiQ` ([FourStep5.lean](../lean/HamiltonsCubic/Results/FourStep5.lean)) the pairing with $A$ is $\sum_\pi x_\pi(a_e+a_f)$. $\square$ *So the diagonal couples to the invisible part with weight $+\tfrac92$ and to the visible part with weight $-6$, each against the two matched edges' entries.* **Check**: the same script, on a random Weyl diagonal plus a random four-set part, gives $7.0944991067$ both ways at $n=6$ and $-527.1291880232$ at $n=8$.

## The matching form, and what it does for the node

Each rectangle lies in $(n-7)!!$ perfect matchings, so with $J_M$ and $X_M$ the hollow symmetric $\tfrac n2\times\tfrac n2$ matrices of $J_{ef}$ and $X_{ef}$ over $e,f\in M$,
$$P(B_f)=\frac1{(n-7)!!}\sum_M\Big(\tfrac32\mathop{\mathrm{tr}}J_M^3+4\mathop{\mathrm{tr}}X_M^3\Big),\qquad E(M)=2\lVert X_M\rVert_F^2.$$

- **$J_M$ is invisible to $M$ and $X_M$ is what $M$ sees.** At [post F81](../findings/fence-posts.md)'s witness, $J_{M_0}=0$ for the factor matching (the torus of $M_0$ fixes $J_{M_0}$, and the product has none), so the whole four-set value sits in $X_{M_0}$, which is why the matching inequality excludes it.
- **Every $J$ is visible elsewhere.** On one block, $J_{\pi_1}=\tfrac23(\pm X_{\pi_2}\pm X_{\pi_3})$, the $X$'s of the two crossing pairings, which crossing matchings see.
- **The estimate is still averaging.** The matching inequality gives $\lVert X_M\rVert_F^2\le\tfrac{t^2}2$ for every $M$, and summing $\lVert X_M\rVert_F^2$ over matchings gives $\tfrac34(n-5)!!\lVert B_f\rVert^2$, so the visible part of $P(B_f)$ is at most $\tfrac3{\sqrt2}(n-5)\,t\,\lVert B_f\rVert^2$. That is order $nt$, the scale averaging already reached. **The obstacle is the same one**: a bound that sums over all matchings loses the factor by which a high-value tensor's visible mass concentrates on few of them, and nothing here shows it does.

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| $\lVert\nu_Q\rVert^2=4X_\pi^2+3J_\pi^2$ | `rect_norm` in RectCubic.lean | the scalar identity under $a=b-c$ |
| step 4's orientation-bit sum | `rect_bits` | the eight-term sum $8XXX+JJJ$, given the factors' form |
| the raw reading of the bilinear formula | `rect_raw` | the scalar identity |
| $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$ | `rect_unit` | the unit-circle bound |
| the rectangle identity on the operators (steps 1 to 4) | none: the layer has four-set sandwiches (`sigA_mat`, `four_eq_sig`, `nu_sq`) but no rectangle product; requested from the Lean session | check the prose |
| the whole of $P$ at pair-free $W$ | none on the operators: its inputs `nu_sq` and `inner_PiQ` are typed, the character step is prose | check the assembly |
| the matching form and the order-$nt$ estimate | none: sums over matchings are prose | check the counting |

## What to attack

1. Step 1: does the character argument give exactly the rectangle triples, each unordered rectangle counted six times?
2. Step 2: is the $R^2$ part exactly $6J_{12}J_{13}J_{23}$, with no crossing entry?
3. Steps 3 and 4: is $\langle R^\#,R\rangle=\tfrac12I_3$ on Weyl tensors in this normalisation, is every factor of $I_3$ on a rectangle a crossing entry of the stated sign, and does the bit sum give $48XXX+6JJJ$?
4. The whole-$P$ formula at pair-free $W$: the vanishing of $T(A,A,B_f)$ and of the cross terms, and $2a^2-b^2-c^2=\tfrac32J^2-2X^2$.
5. The consequences: the raw reading, the product constant and its equality case, the matching form's counting ($(n-7)!!$, $\tfrac34(n-5)!!$) and the visible-part estimate.
6. Whether the note claims more than it shows about the node.
