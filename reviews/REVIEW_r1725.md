# Review r1725: R48 working note batch 14 (torus slices of so(k), k at most 2M)

Log: [agent_logs/r1725.log](../agent_logs/r1725.log). Subject: [the R48 working note](2026-09-27-R48-torus-families.md), batch 14, and [TorusEmbed.lean](../lean/HamiltonsCubic/Results/TorusEmbed.lean). Footing: analysis only, every step derived by hand, no numerical run.

**Verdict: the theorem (1)–(2) and its Lean are CONFIRMED. The $n=12$ sentence cites the wrong lemma and is REFUTED AS STATED. The bold conclusion drops the "standardly embedded" qualifier its own paragraph opens with.**

| # | claim | verdict |
|---|---|---|
| 1 | bordering formulas | CONFIRMED |
| 2 | (1) | CONFIRMED |
| 3 | (2) | CONFIRMED |
| 4 | what it gives | CONFIRMED, one scope repair (standard embeddings in the bold sentence) |
| 5 | $n=12$ | REFUTED AS STATED: L276 is MW' for $m\ge7$ and fails at $m=6$ |
| 6 | exclusions | recorded below, $n=13$ omitted |
| 7 | Lean statement fidelity | CONFIRMED |

## 1. Bordering formulas

- $U'=\mathop{\mathrm{bord}}(U,z)$, $V'=\mathop{\mathrm{bord}}(V,z)$ with zero corner give $P'=\mathop{\mathrm{bord}}(P,2z)$ and $Q'=\mathop{\mathrm{bord}}(Q,0)$.
- $d'_i=d_i+z_i^2+z_i^2=d_i+2z_i^2$ for $i\le m$. $d'_{m+1}=2\lVert z\rVert^2$ enters $F_E$ only through $A'_{m+1,m+1}=0$, so it drops out. The note leaves $d'_{m+1}$ unstated, which is harmless for this reason.
- Trace identity: in $\sum_{a,b,c}X'_{ab}X'_{bc}X'_{ca}$ with $X'=\mathop{\mathrm{bord}}(X,y)$, a term with exactly one new index is $y_bX_{bc}y_c$ in three positions, and any term with two or three new indices contains the zero corner. So $\mathop{\mathrm{tr}}X'^3=\mathop{\mathrm{tr}}X^3+3y^{\mathsf T}Xy$. With $y=2z$ and the factor $\tfrac12$ this is $+6z^{\mathsf T}Pz$, and $Q'$ contributes nothing.
- Cartan pairing: $A'$ vanishes on the new row and column, so the new index adds nothing to $\sum A_{ii}d_i$ or to the off-diagonal sum.
- Norm: $\tfrac12\lVert P'\rVert^2=\tfrac12\lVert P\rVert^2+\tfrac12\cdot2\cdot4\lVert z\rVert^2$, so $N_E'=N_E+4\lVert z\rVert^2$.
- Kernel-checked as `FE_bord` and `NE_bord`.

## 2. Part (1)

- $\mathop{\mathrm{bord}}(A,0)$ is symmetric (`bord_symm`), and $\mathop{\mathrm{bord}}(U,0)$, $\mathop{\mathrm{bord}}(V,0)$ are symmetric with zero diagonal (`pairw_bord`). The bordered triple is therefore a legitimate point of $\mathfrak{so}(2m+2)$'s slice. Geometrically it is $C\oplus0$.
- L277 applies at size $M\ge7$ with $\kappa=2(M-1)/\sqrt{M(2M-1)}=\kappa_{2M}$. It is stated for every torus-invariant $C$, so positivity plays no part.
- The iteration applies L277 once, at size $M$, and only bordering below it, so $m<7$ is covered. At $m=M$ it is L277 itself (`FE_le`, case `d = 0`).

## 3. Part (2)

- At $z=w/\sqrt2$: $2z_i^2=w_i^2$ and $6z^{\mathsf T}Pz=3w^{\mathsf T}Pw$, which reproduce L280's $F$ term by term.
- Norm: $\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=\lVert U\rVert^2+\lVert V\rVert^2$ (parallelogram law), and $4\lVert z\rVert^2=2\lVert w\rVert^2$. This is L280's $\lVert C\rVert^2$.
- The bordered triple has size $m+1$, so (1) needs $m+1\le M$, as stated.
- The argument matches coordinates: the bordered point of $\mathfrak{so}(2m+2)$ has the same $F$ and norm as $C$. It is a different element from $C\oplus0$, which is not invariant under $\mathfrak{so}(2m+2)$'s torus. The Lean docstring's "so $\mathfrak{so}(2m+1)$'s slice sits in $\mathfrak{so}(2m+2)$'s" should read as a norm- and $F$-preserving map of coordinates. The note's own wording is exact.

## 4. What it gives

- Monotonicity: $\kappa_n^2=2(n-2)^2/(n(n-1))$, and $\kappa_{n+1}>\kappa_n$ reduces to $(n-1)^3>(n-2)^2(n+1)$, which is $3n-1>4$. It holds for every $n\ge2$.
- $M=\lfloor n/2\rfloor\ge7$ exactly when $n\ge14$, and $2M\le n$ gives $\kappa_{2M}\le\kappa_n$.
- Coverage: even $k=2m\le n-1$ gives $m\le M$. Odd $k=2m+1\le n-1$ gives $2m+2\le n$, hence $m+1\le M$. So every $k<n$ is covered.
- At an idempotent with $C\ne0$, $\lVert C\rVert^2=F(C)\le\kappa_n\lVert C\rVert^3$ gives $\lVert C\rVert^2\ge1/\kappa_n^2=N/(n-2)^2$. This is batch 2's requirement, read through L270 (3) and L256.
- For a standard $\mathfrak{so}(k)$ the restricted inner product is $\tfrac12\mathop{\mathrm{tr}}$, and $F$ restricted to $\mathop{\mathrm{Sym}}^2\mathfrak{so}(k)$ is $\mathfrak{so}(k)$'s own $F$ with $I\#I=(k-2)I$. So L271 and L280 are in the right normalisation.
- **Scope repair.** The paragraph opens with "standardly embedded", but the bold sentence reads "the torus families of the $\mathfrak{so}(k)$". A non-standard $\mathfrak{so}(k)\subset\mathfrak{so}(n)$ (for example through a spin representation) restricts the inner product with a Dynkin-index scale, and neither (1) nor (2) addresses it. The bold sentence should carry "standardly embedded". The torus-family scope is stated there correctly.

## 5. The $n=12$ sentence: REFUTED AS STATED

- The embedding half is right. With $M=6$, $k\le11$ reduces to $\mathfrak{so}(12)$'s slice by (1) and (2), whose proofs use $M\ge7$ only through L277.
- The citation is wrong. [L276](../findings/second-order.md#lemma-l276-mw-for-m-at-least-7-the-decoupled-walk-inequality-of-j1) is MW' for $m\ge7$, and its own *What it gives* says that at $m=6$ "the row chord fails, which is the open case".
- What rests on one certificate at $m=6$ is the unnumbered MW' at $m=6$ in [the J1 working note](2026-09-27-I117-J1.md), batch 13 ([cert_mw6_case2.py](../scripts/misc/cert_mw6_case2.py)). That note says it stays unnumbered and owes an analytic replacement or a Lean proof. L277's *What it gives* says the same.
- **Repair.** Replace "where L276 rests on one certificate" with "where H on the slice rests on the unnumbered MW' at $m=6$ (J1 working note, batch 13), one step of which is an exact certificate". The $n=12$ consequence is conditional on that unreviewed certificate and should say so.

## 6. What the statement quietly excludes

- Only torus-invariant $C$ are covered. U$_{\mathrm s}'$ on $\mathfrak{so}(k)$ for $k$ near $n$ still owes every idempotent outside the torus family, and that is where batch 2 locates the difficulty.
- Only standard embeddings are covered (see item 4).
- $n=13$ is absent. $M=6$, so the same reduction sends every $k\le12$ to $\mathfrak{so}(12)$'s slice under the same certificate, with $\kappa_{12}<\kappa_{13}$. The $k=13$ slice itself falls outside L281, which needs $m\ge7$. The note should record $n=13$ beside $n=12$.
- $\mathfrak{so}(4)$ and $\mathfrak{so}(2)$ are not simple, and batch 2 or L270 (3) speaks of simple $\mathfrak h$. Covering them does no harm, but "which is all H asks of a proper subalgebra" is literal only for the simple $\mathfrak{so}(k)$, $k=3$ and $k\ge5$.
- Note on the brief: its conventions write $\kappa_n=\tfrac{n-2}{\sqrt1725}$, a substitution slip for $\sqrt N$. I used $\sqrt N$.

## 7. Lean statement fidelity: CONFIRMED

- `kapE M` is $2(M-1)/\sqrt{M(2M-1)}$, which is $\kappa_{2M}$.
- `H_small_even`: $m=j+1$ and `hj : j + 1 ≤ M` give $m\le M$. It states `Ftri (torusOp A U V) ... ≤ kapE M * normSq2(...)^(3/2)`, which is (1). It omits $m=0$, where the statement is trivial.
- `H_small_odd`: $m=j+1$ and `hj : j + 2 ≤ M` give $m+1\le M$, over `torusOpOdd A U V w`, which is (2).
- `FE_base` rewrites L277's `H_torus_slice` through `Ftri_torus` and `L271_norm`, so `FE` and `NE` match L271's right-hand sides exactly.
- The file contains no `sorry` and no `native_decide`.
- As with L271 and L280, "every torus-invariant $C$ is $A\oplus\bigoplus\mu_\alpha I_{R_\alpha}$" is carried by the parametrisation `torusOp`/`torusOpOdd` rather than proved in this file.
