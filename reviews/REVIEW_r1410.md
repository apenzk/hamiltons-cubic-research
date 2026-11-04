# REVIEW r1410: L54's basis identifications in Lean, `phi_block_diag`, `diag_block`, `psi_block`, `K_row_sum`

Log [agent_logs/r1410.log](../agent_logs/r1410.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: one scratch file elaborated for `#print axioms` and four short screening lemmas on objects constructed for the purpose, finishing in seconds, no numerics. Record: [findings/bispectral.md](../findings/bispectral.md), Lemma L54 ("the two diagonals, and rigidity at $t=2$"), statement item 1 and proof steps (0) and (1), and [findings/conventions.md](../findings/conventions.md), sections "The second-kind operator, and the index order, SETTLED on Li's $iklj$", "Structure constants, brackets and padding" (the Frobenius norm on $S^2$) and "The vertex matrix". Lean: commit 296d7dbf, [L54Basis.lean](../lean/HamiltonsCubic/Results/L54Basis.lean), with `ringW`, `frob`, `symB`, `ringW_symB` and `ringW_id` from [SecondKind.lean](../lean/HamiltonsCubic/Results/SecondKind.lean), `R4` from [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean), `phi`, `inner2` and `Ric` from [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), and the L54 rows of [lean/INDEX.md](../lean/INDEX.md). Prior review: [r1401](REVIEW_r1401.md), which fixed `R4` as the record's $W_{ijkl}$ and `ringW` as Li's order.

**Standfirst.** The five statements are Lemma L54's item 1 and step (0) in the record's conventions, sign included. `Kmat R a b = R4 R a b a b` is $\langle W\varphi_{ab},\varphi_{ab}\rangle$ under the half-trace pairing, which is the record's $W_{abab}$, and at $R=\mathrm{Id}$ it is $+1$ off the diagonal (screened), the round sphere's positive sectional curvature. `frob` is plain Frobenius, the record's norm on $S^2$, and $\sqrt2\cdot$`symB a b` is $(e_a\odot e_b)/\sqrt2$ with $u\odot v=u\otimes v+v\otimes u$, a unit tensor at $a\ne b$ (screened). At $a=b$ both sides of `phi_block_diag` vanish, because `Kmat` is hollow for every `R` with no hypothesis (screened). `diag_block` holds for all $u,v$, which is stronger than the record's polarisation on $\mathbf1^\perp$, and $\lVert\mathop{\mathrm{diag}}(v)\rVert_F=\lVert v\rVert$ (screened), so the record's orthonormal $\psi_k$ are exactly `diagonal (w k)` for an orthonormal family `w`. `K_row_sum` reads $\sum_bK_{ab}=\mathrm{Ric}_{aa}$ term for term. The axioms are the standard three. **The gap is the L54 row of the index**: its Owed list names the rigidity as owed although [L54Statement.lean](../lean/HamiltonsCubic/Results/L54Statement.lean) proves the rigidity lemma, it omits that $\{\varphi_{ab}\}\cup\{\psi_k\}$ is an orthonormal basis of $S^2_0$ and that step (3) rides on L94's `sorry`, its closing tag "statement: not typed" contradicts the L54 (statement) row one line below, and it still reads "pending" for this review.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1. `Kmat` is the record's $K_{ab}=W_{abab}$, sign included | CONFIRMED | `R4 R i j k l = inner2 (R (phi i j)) (phi k l)`, the record's $W_{ijkl}=\langle W\varphi_{ij},\varphi_{kl}\rangle$ under $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ (r1401). Screened: `Kmat (fun X => X) a b = 1` at $a\ne b$, matching the record's anchor $R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}$ with $R_{ijij}$ the sectional curvature. The orientation of `phi` cancels in the diagonal entry. |
| 2a. `frob` is the pairing making $\{\varphi_{ab}\}\cup\{\psi_k\}$ orthonormal | CONFIRMED | `frob A B = ∑ i j, A i j * B i j`, the record's Frobenius norm on $S^2$. Screened: `frob (√2 • symB a b) (√2 • symB a b) = 1` at $a\ne b$. |
| 2b. `phi_block_diag` is $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=K_{ab}$ | CONFIRMED | $\sqrt2\cdot\tfrac12(E_{ab}+E_{ba})=(e_a\odot e_b)/\sqrt2$, and `ringW` is Li's $iklj$ order (`ringW_id`). `M_diag` is $M_{(ab),(ab)}=K_{ab}$ by definition. |
| 2c. The dropped $a\ne b$ | CONFIRMED | At $a=b$, `symB a a` is $E_{aa}$ and `symB_block_diag` gives $K_{aa}/2=0$. Screened: `Kmat R a a = 0` for every `R`, since `phi a a = 0` and `inner2 X 0 = 0`. The statement is then true and says nothing, and the record's basis uses only $a<b$. |
| 3a. `diag_block` | CONFIRMED | $(\mathring W\mathop{\mathrm{diag}}u)_{ii}=\sum_kW_{ikki}u_k=-\sum_kK_{ik}u_k$ by the two antisymmetries. It holds for all $u,v$, the record's claim on $\mathbf1^\perp$ being a restriction of it. |
| 3b. `psi_block` and the normalisation of $\psi_k$ | CONFIRMED | Screened: `frob (diagonal u) (diagonal v) = u ⬝ᵥ v`, so the record's orthonormal $\psi_k=\mathop{\mathrm{diag}}(v_k)$ are `diagonal (w k)` with `horth`. The conclusion is the $\psi$-block as $\mathop{\mathrm{diag}}(-\kappa_k)$. The family is not required to lie in $\mathbf1^\perp$ or to span it: the identity is stated for any orthonormal eigenfamily, and existence of the eigenbasis on $\mathbf1^\perp$ is untyped and listed. |
| 4. `K_row_sum` | CONFIRMED | `Ric R a a = ∑ c, inner2 (R (phi a c)) (phi a c) = ∑ c, Kmat R a c`, unfolded by `exact`. The hypothesis asks all entries of `Ric` to vanish where the diagonal would do, which is what Weyl gives. |
| 5a. The L54 row, content | CONFIRMED | The five theorem descriptions are accurate, including "for all $u,v$" and "orthonormal eigenfamily". |
| 5b. The L54 row, Owed list and tags | CONFIRMED WITH GAP | "The rigidity at $t_F=2$" is proved in L54Statement.lean (`sameSorted_of_majorizes_of_normSq_eq`), so what is owed is its assembly with the identifications. Missing: that $\{\varphi_{ab}\}_{a<b}\cup\{\psi_k\}$ is an orthonormal basis of $S^2_0$, and that step (3), $t_F\le2$, enters through L94, whose statement file carries a `sorry`. "Statement: not typed" contradicts the L54 (statement) row, which reads typed. "Gate 2: r1410, pending" needs this verdict. |
| 6. Axioms | CONFIRMED | `phi_block_diag`, `diag_block`, `psi_block`, `K_row_sum` and `M_diag`: `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** The five statements are Lemma L54's item 1 and step (0) in the record's order, sign and Frobenius normalisation, and the gap is the index row's Owed list and tags.

## 1. The sectional matrix and its sign

The record's $K$ is the hollow symmetric matrix $K_{ab}=W_{abab}$ ([conventions.md](../findings/conventions.md), "The vertex matrix"), and the round sphere $R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}$ is the record's sign anchor, with $R_{ijij}$ the sectional curvature (L67's statement says so explicitly). `R4` at the identity operator is $\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ (`inner2_phi_phi`), and the screen `Kmat (fun X => X) a b = 1` at $a\ne b$ confirms the sign. Both copies of `phi a b` enter bilinearly, so the orientation of `phi` (entry $-1$ at $(a,b)$) is irrelevant to $K$.

## 2. The φ-block

The record's basis vector is $\varphi_{ab}=(e_a\odot e_b)/\sqrt2$ with $e_a\odot e_b=E_{ab}+E_{ba}$, orthonormal under Frobenius. `√2 • symB a b` is that tensor, and the screen gives it unit Frobenius norm at $a\ne b$. `phi_block_diag` then reads $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=K_{ab}$, with $\mathring W$ in Li's order because `ringW R h i j = ∑ k l, R4 R i k l j * h k l` and `ringW_id_S20` gives $+\mathrm{Id}$ on $S^2_0$ at the sphere.

At $a=b$ the tensor is $\sqrt2E_{aa}$, of norm $2$ and not traceless, so it is outside the record's basis. The statement still holds, both sides being $0$: `Kmat R a a` vanishes for every operator because `phi a a = 0` and `inner2 X 0 = 0`, which the screen checks with no hypothesis on `R`. Dropping $a\ne b$ therefore adds a true, empty case.

## 3. The diagonal block

`diag_block` is the polarised identity for all $u,v\in\mathbb R^n$. The record derives the quadratic form for traceless diagonal $h$ and polarises on $\mathbf1^\perp$. The Lean identity is the unrestricted bilinear form, which contains the record's. The normalisation matches: `frob (diagonal u) (diagonal v) = u ⬝ᵥ v` (screened), so an orthonormal family of vectors gives an orthonormal family of diagonal tensors under the record's norm, and `psi_block` is the record's "$\psi$-block is $\mathop{\mathrm{diag}}(-\kappa_k)$".

`psi_block` asks for an orthonormal family of eigenvectors of `Kmat R` and nothing else. The record's family lies in $\mathbf1^\perp$ and spans it, and that it exists is step (0) plus the spectral theorem on the invariant subspace. The Lean statement is true for every such family and silent on existence, and the row lists existence as owed.

## 4. Step (0)

`Ric R a b = ∑ c, inner2 (R (phi a c)) (phi b c)`, so `Ric R a a = ∑ c, R4 R a c a c = ∑ c, Kmat R a c`, and the proof is `exact h` after unfolding. This is the record's $\sum_bK_{ab}=\mathrm{Ric}(W)_{aa}=0$. The Ricci sign agrees with the sphere anchor, where it gives $n-1$.

## 5. The index row

The row's descriptions of the five theorems are accurate. Its Owed list reads "the majorisations $\mu\succ d_\varphi$ and $\omega\succ d$ (Schur), the rigidity at $t_F=2$, and the existence of the eigenbasis of $K$ on $\mathbf1^\perp$". Against the record's proof:

- The rigidity lemma is proved in L54Statement.lean. What remains is its assembly with the identifications of this file, which is how the item should read.
- That $\{\varphi_{ab}\}_{a<b}\cup\{\psi_k\}$ is an orthonormal basis of $S^2_0$ is untyped and unlisted. Item 2's count $N+n-1=\dim S^2_0$ rests on it.
- Step (3), $t_F\le2$ with its equality case, enters L54Statement.lean as L94, whose statement file carries a `sorry`. The row does not say so.
- The closing tag "statement: not typed" contradicts the L54 (statement) row directly below, which reads "statement: typed".
- "Gate 2: r1410, pending" should read CONFIRMED WITH GAP.

The row carries no em dash. Its semicolons separate list items that carry commas, which is their permitted use.

## 6. Axioms

All five theorems print `[propext, Classical.choice, Quot.sound]`.
