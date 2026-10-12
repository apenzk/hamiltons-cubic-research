# Review r1724: R48 batch 14, every so(k) torus slice with k at most 2M obeys so(2M)'s bound

Log: [agent_logs/r1724.log](../agent_logs/r1724.log). Block under audit: [R48 working note](2026-09-27-R48-torus-families.md), batch 14. Lean: [TorusEmbed.lean](../lean/HamiltonsCubic/Results/TorusEmbed.lean). Analysis only, no numerical screen was needed (the bordering identities are kernel-checked and were rederived by hand).

**Verdict: the theorem (1), (2) and its proof are CONFIRMED. Two sentences of *What it gives* need repair: the $n=12$ sentence cites the wrong lemma for $m=6$, and $n=13$ is silently skipped.**

| # | claim | verdict |
|---|---|---|
| 1 | bordering formulas | CONFIRMED |
| 2 | (1) | CONFIRMED |
| 3 | (2) | CONFIRMED |
| 4 | what it gives | CONFIRMED, scope as noted |
| 5 | $n=12$ | PLAUSIBLE: reduction right, attribution wrong |
| 6 | exclusions | PLAUSIBLE: $n=13$ unaddressed |
| 7 | Lean statement fidelity | CONFIRMED, one dangling label |

## 1. Bordering formulas

Rederived from definitions. With $U'=\operatorname{bord}(U,z)$, $V'=\operatorname{bord}(V,z)$ and zero corners, $P'_{i,m+1}=2z_i$ and $Q'_{i,m+1}=0$, so $P'=\operatorname{bord}(P,2z)$ and $Q'=\operatorname{bord}(Q,0)$. The new row adds $U_{i,m+1}^2+V_{i,m+1}^2=2z_i^2$ to $d_i$, and $d'_{m+1}=2\lVert z\rVert^2$. The proof does not write $d'_{m+1}$ down, but it enters $F_E$ only as $3A'_{m+1,m+1}d'_{m+1}=0$, and "$A'$ vanishes on the new index" covers it. The trace identity needs the zero corner, which the text states: in $\sum_{a,b,c}X'_{ab}X'_{bc}X'_{ca}$ two new indices among three cyclic slots are always adjacent, so only terms with one new index survive. Those give $3y^{\mathsf T}Xy$, and with $y=2z$ that is $12z^{\mathsf T}Pz$, halved to $6z^{\mathsf T}Pz$. The off-diagonal Cartan term gains nothing because $A'$ and $Q'$ vanish on new pairs. Norm: $\tfrac12\lVert P'\rVert^2=\tfrac12\lVert P\rVert^2+\tfrac12\cdot2\cdot4\lVert z\rVert^2$, so $N_E'=N_E+4\lVert z\rVert^2$. All as stated.

## 2. Statement (1)

The zero-bordered triple is a legitimate point of $\mathfrak{so}(2m+2)$'s slice: $A'$ is symmetric and $U',V'$ are symmetric with zero diagonal, and L271's parametrisation puts no sign or positivity condition on $A,U,V$. At $z=0$, $F_E$ and $N_E$ are unchanged. By induction on $M-m$ one reaches size $M$, where L277 at $m=M\ge7$ gives exactly $\kappa_{2M}=2(M-1)/\sqrt{M(2M-1)}$. The case $m=M$ is L277 itself with zero steps. Small $m$ (down to $m=1$) is covered because L271's formula (Lean `Ftri_torus`) carries no size hypothesis.

## 3. Statement (2)

At $z=w/\sqrt2$: $3A_{ii}(d_i+2z_i^2)=3A_{ii}(d_i+w_i^2)$, $6z^{\mathsf T}Pz=3w^{\mathsf T}Pw$, and $N_E+4\lVert z\rVert^2=\lVert A\rVert^2+\lVert U\rVert^2+\lVert V\rVert^2+2\lVert w\rVert^2$ because $\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=\lVert U\rVert^2+\lVert V\rVert^2$. These are L280's $F$ and $\lVert C\rVert^2$ exactly. The bordered point lives on size $m+1$, so (1) needs $m+1\le M$, which is the stated condition.

## 4. What it gives

- $\kappa_n^2=2(n-2)^2/(n(n-1))$ increases: the ratio of consecutive values exceeds 1 because $(n-1)^3-(n-2)^2(n+1)=3n-5>0$.
- $M=\lfloor n/2\rfloor\ge7$ for $n\ge14$. For $k<n$: $k$ even gives $m\le M$, $k$ odd gives $k\le2M-1$, so $m+1\le M$, whether $n$ is even or odd. Both cases checked.
- The link to batch 2 holds. In L270 (3) the idempotent lives on $\mathfrak h$ with $\mathfrak h$'s own $\#$. For $C$ supported on $\mathfrak h$ the ambient $\#$ uses only brackets inside $\mathfrak h$, and the standard embedding preserves $\tfrac12\operatorname{tr}$, so the $F$ bounded here is the one L270 needs, with $c_{\mathfrak h}=k-2$. $F(C)=\lVert C\rVert^2\le\kappa_n\lVert C\rVert^3$ with $C\ne0$ gives $\lVert C\rVert^2\ge N/(n-2)^2$.
- Scope. The bold sentence reads correctly only as: every torus-invariant idempotent of a standardly embedded $\mathfrak{so}(k)$ meets batch 2's norm floor. The idempotent L270 (3) produces is torus-invariant only if something like R49 holds, and the sentence does not claim otherwise. A reader could take "ask nothing more" as covering the $\mathfrak{so}(k)$ in full. Suggested wording: "the torus-invariant idempotents of the standardly embedded $\mathfrak{so}(k)$".
- The pairing "L277 ($k=n$ even) and L281 ($k=n$ odd)" is right from $n=14$ and $n=15$.

## 5. The $n=12$ sentence

The reduction is right: at $M=6$, (1) and (2) hold with the zero-bordering alone, which has no size hypothesis, so every $k\le11$ reduces to $\mathfrak{so}(12)$'s slice at $\kappa_{12}=\kappa_n$. The attribution is wrong. **"so(12)'s own slice, where L276 rests on one certificate" cites L276, which is stated for $m\ge7$ and whose own *What it gives* calls $m=6$ "the open case" (the row chord fails for $\pi>\tfrac{25}{96}$).** The certificate is MW' at $m=6$ in [the J1 working note](2026-09-27-I117-J1.md), batch 13 ([cert_mw6_case2.py](../scripts/misc/cert_mw6_case2.py)), as [plan.md](../plan.md) records. H on the $m=6$ slice then goes through L273 (3), which holds from $m\ge5$. The error is inherited from batch 13's identical phrase. Repair: "where H rests on MW' at $m=6$, one step of which is an exact certificate (J1 note batch 13), outside any Gate-2 lemma".

## 6. Exclusions

- **$n=13$ is not mentioned.** *What it gives* covers $n\ge14$ and $n=12$. At $n=13$ ($M=6$) the same embedding reduces every $k\le12$ to $\mathfrak{so}(12)$'s slice at the slacker constant $\kappa_{13}>\kappa_{12}$. $k=13$ itself is the odd $m=6$ slice, where batch 10 and L278 record that the chord fails. That line should be stated.
- $n\le11$: the reduction stops at $\mathfrak{so}(2\lfloor n/2\rfloor)$'s slice, which has no H bound yet. The $n\le11$ cases are excluded implicitly, and correctly.
- Non-torus-invariant idempotents of $\mathfrak{so}(k)$, and $\mathfrak{so}(k)$ under non-standard embeddings (index $\ell>2$). Both are outside the statement. The second changes the inner product on $\mathfrak h$, and batch 14 makes no claim about it.
- The statement quantifies over all $m\ge1$. $\mathfrak{so}(2)$, $\mathfrak{so}(3)$ and $\mathfrak{so}(4)$ are harmless inclusions. Batch 2 needs only simple $\mathfrak h$.

## 7. Lean statement fidelity

- `H_small_even M hM j hj`: $M\ge7$, $m=j+1\le M$, symmetric $A$, `IsPairWeights` $U,V$ (symmetric, zero diagonal), conclusion `Ftri (torusOp A U V) ... ≤ kapE M * normSq2(...)^(3/2)`. This is (1).
- `H_small_odd`: `j + 2 ≤ M`, so $m+1\le M$, over `torusOpOdd A U V w`. This is (2).
- `kapE M = 2(M-1)/√(M(2M-1))` is the stated $\kappa_{2M}$. `FE_base` matches it to `H_torus_slice`'s constant at $n+1=M$.
- `FE`/`NE` are L271's form and norm verbatim. `FE_bord`/`NE_bord` state the bordered identities with the $+3\sum(2z_i)P_{ij}z_j=6z^{\mathsf T}Pz$ term.
- Two notes. "Every torus-invariant $C$" is carried by the parametrisations `torusOp`/`torusOpOdd`, and the claim that these exhaust the torus-invariant operators is L271/L280's prose. The docstrings of `H_small_even` and `H_small_odd` call the result "L282 (1)" and "L282 (2)", a number [second-order.md](../findings/second-order.md) does not yet contain. That label dangles until promotion.
