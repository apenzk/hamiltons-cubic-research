# REVIEW r1727: R48 batch 15, su(k)'s torus family inside so(2k)'s slice

Log: agent_logs/r1727.log

**Verdict: the batch's Statement and Proof are CONFIRMED. Two minor gaps sit in *What it gives*, and the Lean covers only the so(2k)-side specialisation of L282.**

| # | claim | verdict |
|---|---|---|
| 1 | (a) restriction | CONFIRMED |
| 2 | (b) torus invariance | CONFIRMED |
| 3 | (c) | CONFIRMED |
| 4 | coordinates | CONFIRMED |
| 5 | what it gives | PLAUSIBLE (two wording gaps, conclusion true) |
| 6 | exclusions | CONFIRMED as scoped, with the list below |
| 7 | Lean statement fidelity | PLAUSIBLE: faithful where it speaks, silent on (a) and on completeness of the family |

## 1. (a) The cubic form restricts

- In an orthonormal basis adapted to su(k) + su(k)^perp, $F(\hat C)=\tfrac12\sum C_{\alpha\beta}c_\alpha^{\gamma\delta}c_\beta^{\varepsilon\zeta}C_{\gamma\varepsilon}C_{\delta\zeta}$ is non-zero only when all six indices lie in su(k), since each is a row or column index of $\hat C$.
- For $\alpha,\gamma,\delta$ in su(k), $c_\alpha^{\gamma\delta}=\langle[e_\gamma,e_\delta],e_\alpha\rangle$ is su(k)'s own structure constant because su(k) is closed under the bracket and carries the restricted inner product. So $F(\hat C)=F_{\mathfrak{su}(k)}(C)$ and $\lVert\hat C\rVert=\lVert C\rVert$.
- Hypotheses used: orthonormality of the adapted basis and closure of the subalgebra. Nothing else.
- Normalisation check: $\tfrac12\operatorname{tr}_{\mathbb R}(X^{\mathsf T}Y)=-\operatorname{Re}\operatorname{tr}_{\mathbb C}(XY)$ on u(k), which is batch 1's $-\operatorname{tr}XY$, so batch 1's slice and this one agree.

## 2. (b) Torus invariance

- $T$ (diagonal unitaries) is a $k$-torus in $SO(2k)$, whose rank is $k$, so it is maximal. It is the standard torus of rotations in the coordinate planes.
- $\operatorname{diag}(e^{i\theta_j})=e^{i\varphi}\operatorname{diag}(e^{i(\theta_j-\varphi)})$ with $k\varphi=\sum\theta_j$, so $T=T'Z$.
- $Z$ is central in $U(k)$, so $\mathrm{Ad}(Z)$ is the identity on u(k), hence on su(k). Being orthogonal, it preserves su(k)^perp. $\mathrm{Ad}(T')$ preserves su(k) and su(k)^perp for the same reason. $\hat C$ is zero on su(k)^perp and commutes with both on su(k), so it is $T$-invariant.

## 3. (c)

- L282 (1) at $m=k\le M$, $M\ge7$, applies directly to the point $\hat C$ of so(2k)'s torus slice. Any maximal torus is conjugate to the standard one, and conjugation preserves $F$ and the norm.

## 4. Coordinates

- A $2\times2$ off-diagonal block transforms as $B\mapsto R(\theta_i)BR(-\theta_j)$. Its $J$-commuting part $aI+bJ$ picks up $R(\theta_i-\theta_j)$ (weight $\varepsilon_i-\varepsilon_j$). Its anticommuting part picks up $R(-(\theta_i+\theta_j))$ (weight $\varepsilon_i+\varepsilon_j$).
- The Lean agrees: `cPart B = ½(B − J2 B J2)` is the $J$-commuting projection and carries `U` (I117Statements.lean, `torusMat`).
- The Cartan coefficient of $X$ on plane $p$ is its $h_p$ coordinate, and $J=\sum_ph_p$ corresponds to $\mathbf 1$. So su(k) is the Cartan part orthogonal to $\mathbf 1$ plus the $U$-planes, and $\hat C$ is `torusOp A U 0` with $A\mathbf1=0$.
- Completeness: a $T'$-invariant symmetric $C$ on su(k) preserves the zero-weight space $\mathfrak t'$ (dimension $k-1$). On each real root plane it commutes with a rotation and is symmetric, so it is a scalar. The roots $\varepsilon_i-\varepsilon_j$ restrict to distinct non-zero characters of $T'$ up to sign, so no two planes mix. Every such $C$ is therefore of the stated form.

## 5. What it gives

- The chain is correct. At an su(k) idempotent in the family, $F(C)=\lVert C\rVert^2\le\kappa\lVert C\rVert^3$ gives $\lVert C\rVert^2\ge1/\kappa^2$.
- **Gap 1 (odd $n$).** The Proof gives $\kappa_{2M}$. For $n=2M+1$ the sentence states $\kappa_n$, which needs $\kappa_{2M}\le\kappa_{2M+1}$. That holds because $\kappa_n^2=2(n-2)^2/(n(n-1))$ increases in $n$, as L282's own *What it gives* says, but batch 15 omits the step. It is a one-clause fix.
- **Gap 2 (scope of "what H at n asks of it").** Batch 2 and L270 (3) ask for the bound at the (stable, positive-definite) idempotents of su(k). Batch 15 delivers it for the $T'$-invariant ones only. The Statement is correctly scoped. The sentence should say "of its torus family", as L282's parallel sentence does.
- Consistency with batch 1 holds: batch 1's slice supremum $2/\sqrt3\approx1.155$ is below $\kappa_{14}=12/\sqrt{91}\approx1.258$. It exceeds su(k)'s own $k/\sqrt{k^2-1}$ and also $\kappa_6\approx1.033$, which is why $M\ge7$ is load-bearing.
- **Scope sentence.** The rank counts are right. For sp(k) in so(4k), $k+1<2k$ at $k\ge2$ (centraliser sp(1)). For g2 in so(7), $2<3$ (trivial centraliser). But "non-standard embeddings they do not" is too broad as a universal statement. su(4) acting on $\Lambda^2\mathbb C^4=\mathbb R^6$ is a non-standard embedding of su(4) whose torus fills so(6)'s. Such cases are isomorphic to standard so(k) embeddings, which L282 already covers, so nothing is lost. The sentence should read "for most non-standard embeddings", or name the criterion (rank of $\mathfrak h$ plus rank of its centraliser equal to $\lfloor n/2\rfloor$).

## 6. What the statement quietly excludes

- It covers the $T'$-invariant operators only, not general or merely $SU(k)$-stable idempotents of su(k).
- It covers the standard embedding with the restricted inner product only. $F$ is not scale-invariant, so the normalisation matters.
- It gives the ambient target $N/(n-2)^2$, not su(k)'s own U$_{\mathrm s}'$ target $(k^2-1)/k^2$. The batch says so.
- It needs $n\ge14$. At $n=12,13$ it inherits L282's gap through so(12)'s slice.
- It uses no positive definiteness. The bound holds on the whole symmetric family, which is harmless.

## 7. Lean statement fidelity

- `H_su_slice` is `H_small_even` at `V = 0`. Its hypothesis `_hA1` is unused, so the theorem is a strict specialisation of L282 (1). It is the batch's step (c), read in so(2k).
- `torusOp_kills_anti`, `torusOp_commutes_J` and `torusOp_kills_J` are true as stated, and I checked them against `torusMat`. They are the support half of step 4. They are `sorry`.
- **What the Lean does not state:**
  - (a), the identity $F_{\mathfrak{su}(k)}(C)=F(\hat C)$. The brief acknowledges this.
  - That every $T'$-invariant operator on su(k) arises as `torusOp A U 0` with $A\mathbf1=0$. The docstring of `H_su_slice` asserts it ("which are the torus-invariant operators supported on su(k)"), but no declaration states it.
  - That the image is orthogonal to $J$. That needs `hA` together with `torusOp_kills_J`, and no lemma combines them.
  - (b) at the group level. The Lean works with the parametrised family directly.

## Screen (seconds, a screen, not evidence)

A numpy build of su(3) in so(6) and su(4) in so(8), with $C$ built as a Cartan block plus a scalar on each root plane:
- $T'$-invariance, and invariance of $\hat C$ under a generic $U(k)$ torus element, both hold to $10^{-15}$.
- $F_{\mathfrak{su}(k)}(C)=F(\hat C)$ holds to $10^{-15}$.
- $F(I)=k(k^2-1)$ holds (24 and 60).
