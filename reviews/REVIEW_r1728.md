# Review r1728: R48 batch 15, the su(k) torus family inside so(2k)'s slice

Log: agent_logs/r1728.log. Footing: analysis only, no numerics run (the chain is short enough to check by hand). Lean read, not compiled: another lake process (pid 69895) held the machine.

**Verdict: the proof of the Statement is CONFIRMED. "What it gives" is PLAUSIBLE with one omitted step (odd n) and one scope sentence to tighten. The Lean is a faithful special case of L282, and it leaves (a) and the characterisation to the prose.**

| # | claim | verdict |
|---|---|---|
| 1 | (a) restriction | CONFIRMED |
| 2 | (b) torus invariance | CONFIRMED |
| 3 | (c) | CONFIRMED |
| 4 | coordinates | CONFIRMED |
| 5 | what it gives | PLAUSIBLE (gap: odd n needs kappa monotone, unstated) |
| 6 | exclusions | CONFIRMED (listed below, none hidden that changes the claim) |
| 7 | Lean statement fidelity | PLAUSIBLE (faithful but thin: `_hA1` unused, (a) and the converse are prose) |

## 1. (a) The cubic form restricts

- From the definition, with $c_\alpha^{\gamma\delta}=\langle[e_\gamma,e_\delta],e_\alpha\rangle$ and $C$ symmetric, $F(C)=\tfrac12\sum_{\gamma,\delta,\varepsilon,\zeta}C_{\gamma\varepsilon}C_{\delta\zeta}\langle[e_\gamma,e_\delta],C[e_\varepsilon,e_\zeta]\rangle=\tfrac12\sum_{\beta,\gamma}\langle C[Ce_\beta,Ce_\gamma],[e_\beta,e_\gamma]\rangle$. This is the batch's formula.
- In a basis adapted to $\mathfrak{su}(k)\oplus\mathfrak{su}(k)^\perp$, $\hat Ce_\beta=0$ off $\mathfrak{su}(k)$, and for $e_\beta,e_\gamma\in\mathfrak{su}(k)$ every bracket stays in $\mathfrak{su}(k)$ (closure) and every inner product is the restricted one. So $F(\hat C)=F_{\mathfrak{su}(k)}(C)$ for $\mathfrak{su}(k)$'s cubic form built in an orthonormal basis of the restricted inner product. Hypotheses used: subalgebra closure, orthogonal splitting, the restricted inner product. Nothing else.
- Normalisation check (consistency with batch 1): for skew-Hermitian $X,Y$ realised on $\mathbb R^{2k}$, $\tfrac12\operatorname{tr}_{\mathbb R}(X^{\mathsf T}Y)=\operatorname{Re}\operatorname{tr}_{\mathbb C}(X^*Y)=-\operatorname{tr}XY$, so the restricted inner product is batch 1's $-\operatorname{tr}XY$.

## 2. (b) Torus invariance

- $T$ (diagonal unitaries) $=T'\cdot Z$: $\operatorname{diag}(e^{i\theta_j})=e^{i\bar\theta}\operatorname{diag}(e^{i(\theta_j-\bar\theta)})$ with $\bar\theta$ the mean. Correct (the product map has finite kernel, which is irrelevant here).
- $T=U(1)^k=SO(2)^k$ acting on the $k$ coordinate planes is the standard maximal torus of $SO(2k)$ (rank $k$).
- $Z=\exp(\theta J)$ commutes with $\mathfrak u(k)$, so $\mathrm{Ad}(Z)=\mathrm{id}$ there. It is orthogonal and preserves $\mathfrak{su}(k)$, hence preserves $\mathfrak{su}(k)^\perp$ (it rotates the $J$-anticommuting part by $2\theta$ and fixes $\mathbb RJ$). With $x=x_1+x_2$: $\hat C\,\mathrm{Ad}(z)x=Cx_1=\mathrm{Ad}(z)\hat Cx$. For $T'$ the same splitting argument uses that $\mathrm{Ad}(T')$ preserves $\mathfrak{su}(k)$ and its complement. So $\hat C$ commutes with $\mathrm{Ad}(T)$.

## 3. (c)

- L282 (1) with $m=k\le M$, $M\ge7$ applies to every torus-invariant symmetric operator on $\mathfrak{so}(2k)$. A $T$-invariant symmetric operator is of L268's form $A\oplus\bigoplus\mu_\alpha I_{R_\alpha}$ because the positive roots of $D_k$ give pairwise distinct characters (no $\alpha=\pm\beta$) and a symmetric map commuting with a nontrivial plane rotation is scalar. $F$ and the norm are $\mathrm{Ad}(SO(2k))$-invariant, so the choice of maximal torus is immaterial.

## 4. Coordinates

- $\alpha(J)$ with $J=\sum_ph_p$: $0$ on $\varepsilon_i-\varepsilon_j$, $2$ on $\varepsilon_i+\varepsilon_j$. So the $\varepsilon_i-\varepsilon_j$ planes lie in the centraliser of $J$ ($\mathfrak u(k)$) and the $\varepsilon_i+\varepsilon_j$ planes in the $J$-anticommuting part $\mathfrak u(k)^\perp$. Dimension check: $k+k(k-1)=k^2$. The layer's `cPart`/`aPart` docstrings (I117Statements.lean) carry the same identification.
- $\hat C$ vanishes on the anticommuting planes, so $V=0$. The $h_p$ are orthonormal ($\tfrac12\operatorname{tr}h_p^{\mathsf T}h_q=\delta_{pq}$), $J\leftrightarrow\mathbf 1$, and $\hat C J=0$ with $\hat C$ symmetric gives $A\mathbf1=0$.
- Converse: every $T'$-invariant symmetric $C$ on $\mathfrak{su}(k)$ is $A'\oplus\bigoplus_{i<j}\mu_{ij}I$ because the roots of $A_{k-1}$ are pairwise non-proportional and non-zero on $\mathfrak t'$, so it extends to `torusOp A U 0` with $A\mathbf1=0$ and $U_{ij}=\mu_{ij}$. This is batch 1's slice description. Correct.

## 5. What it gives

- $n\ge14$, $2k\le n$, $M=\lfloor n/2\rfloor\ge7$, $k\le M$: the Statement applies. For even $n$, $\kappa_{2M}=\kappa_n$.
- **Gap (conclusion true):** for odd $n=2M+1$ the batch passes from $\kappa_{2M}$ to $\kappa_n$ without saying why. It needs $\kappa_{2M}\le\kappa_{2M+1}$, which holds since $\kappa_n^2=2(n-2)^2/(n(n-1))$ has $\tfrac{d}{dn}\big[(n-2)^2/(n^2-n)\big]\propto(n-2)(3n-2)>0$. L282's own "What it gives" states this monotonicity, batch 15 omits it.
- From $F(C)=\lVert C\rVert^2$ at a non-zero idempotent, $\lVert C\rVert\ge1/\kappa_n$, i.e. $\lVert C\rVert^2\ge N/(n-2)^2$. Correct.
- **Scope to tighten:** "which is what H at n asks of it (batch 2)". Batch 2 asks the bound at the idempotents of $\mathfrak{su}(k)$; batch 15 delivers it at the $T'$-invariant ones. The wording matches L282's accepted framing ("on its torus family"), so this is a phrasing point: the sentence should say "on its torus family".
- Batch 1 consistency: the $\mathfrak{su}(2)$ point has ratio $2/\sqrt3\approx1.155<\kappa_{14}=12/\sqrt{91}\approx1.258$, while $\mathfrak{su}(k)$'s own $k/\sqrt{k^2-1}<2/\sqrt3$ for $k\ge3$. No contradiction.
- Centraliser sentence: correct. The centraliser of $\mathfrak{su}(k)$ in $\mathfrak{so}(2k)$ contains $\mathbb RJ$ (all of it for $k\ge3$, and $\mathfrak{sp}(1)\ni J$ for $k=2$). $\mathfrak{sp}(k)\subset\mathfrak{so}(4k)$ has rank $k$ plus a rank-1 centraliser $\mathfrak{sp}(1)$ against rank $2k$. $\mathfrak g_2\subset\mathfrak{so}(7)$ has rank 2 and trivial centraliser against rank 3. Both fail to fill, as stated.

## 6. What the statement excludes

- Operators on $\mathfrak{su}(k)$ that are not $T'$-invariant (the general U$_{\mathrm s}'$ question on $\mathfrak{su}(k)$ is untouched).
- Non-standard embeddings of $\mathfrak{su}(k)$, and $n\le13$.
- Positive definiteness plays no role (the bound is on the whole slice). This is why it sidesteps batch 1's obstruction: the ambient constant is weaker.
- The inner product is the restricted one, stated in the Statement. None of these exclusions is hidden in a way that changes the claim.

## 7. Lean statement fidelity (SuTorusDev.lean)

- `H_su_slice` states the Statement read in $\mathfrak{so}(2k)$ with $k=j+1$: `Ftri (torusOp A U 0) ≤ kapE M * normSq2^(3/2)` for $A$ symmetric, `A 1 = 0`, $U$ pair weights. Its proof is `H_small_even` at `V = 0`, and the hypothesis `_hA1` is **unused**. So the theorem is literally L282 (1) on the face $V=0$ and carries no $\mathfrak{su}(k)$ content by itself.
- `torusOp_kills_anti` and `torusOp_kills_J` together state that `torusOp A U 0` with `A 1 = 0` vanishes on $\mathfrak{su}(k)^\perp=\mathfrak u(k)^\perp\oplus\mathbb RJ$, which is one direction of the coordinate sentence (with self-adjointness of `torusOp`, the image then lies in $\mathfrak{su}(k)$). `torusOp_commutes_J` is then redundant. The file contains proof scripts for all three. I did not compile them.
- What the Lean does not state: (a), the identity $F(\hat C)=F_{\mathfrak{su}(k)}(C)$ (no intrinsic $\mathfrak{su}(k)$ in the layer, as the brief says). The converse, that every $T'$-invariant operator on $\mathfrak{su}(k)$ is such a `torusOp`. The $T=T'Z$ invariance. The docstring of `H_su_slice` ("which are the torus-invariant operators supported on su(k)") asserts the characterisation, which the file proves in neither direction inside that theorem.
