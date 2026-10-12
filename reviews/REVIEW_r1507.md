# Review r1507: L195 proved in Lean, a common square with two distinct eigenvalues forces ω₂ = ±ω₁

Gate 2 review of commit 186944f6: the new [Results/L195Proof.lean](../lean/HamiltonsCubic/Results/L195Proof.lean) (`bf`, `bf_eq`, `wedge_eval`, `Aop`, `dot_skew`, `eigen_preserve`, `Aop_symm`, `eigen_orth`, `dot_sq`, `bf_self`, `dot_self_pos`, `eigen_pos`, `eq_zero_of_eigenbasis`, `Aop_eq`, `mixed_eq`, `scale`, `L195`), and the record edits to [lean/INDEX.md](../lean/INDEX.md)'s L195 (statement) row (line 213) and I69 row, [diagonal-half.md](../findings/diagonal-half.md) Lemma L195 (line 1037) and the two docstrings of [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) (repair of r1506's C-1). One reviewer. Analysis-only rule inherited: the only compute was the module build ("Build completed successfully", 8717 jobs) and the axiom audit.

| item | claim | verdict |
| --- | --- | --- |
| A | `L195` states diagonal-half.md's Lemma L195, with positive definiteness of $A=-\omega_1^2$ as injectivity of $\omega_1$ | CONFIRMED |
| B | `wedge_eval`, the eigenspace lemmas, `mixed_eq`, `scale` and `L195` are sound, no hypothesis missing | CONFIRMED |
| C | r1506's C-1 is repaired, no edited sentence overstates, and **proved** on the L195 row is justified | CONFIRMED WITH GAP |
| D | all declarations rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: `L195` proves that skew $\omega_1,\omega_2$ with $\omega_1^2=\omega_2^2$, $\omega_1$ injective, equal `wedgeSelf` arrays and two eigenvectors of $A=-\omega_1^2$ with distinct eigenvalues satisfy $\omega_2=\pm\omega_1$, which is the record's lemma exactly. The rank-one step is `mixed_eq` (all four cross pairings of $E_\mu\times E_\nu$ vanish for both forms), `scale` gives $\omega_2=s\,\omega_1$ on each eigenspace with $s^2=1$, and pairing with a fixed eigenspace gives $st=1$, hence $t=s$. 15/15 declarations on the standard three axioms, and the L195 row's **proved** is justified. One gap: C-1, [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) line 27 now says the range fact $\operatorname{range}(A+B)=\operatorname{range}A+\operatorname{range}B$ is L186Rank.lean's `rank_le_of_pos`, which proves only the rank inequality. CONFIRMED WITH GAP.**

## A. Fidelity

- **The record.** [diagonal-half.md](../findings/diagonal-half.md) line 1041: $\omega_1^2=\omega_2^2=-A$, $A$ positive definite, $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$, and $A$ with at least two distinct eigenvalues give $\omega_2=\pm\omega_1$, with no dimension, Weyl or orthogonality hypothesis. `L195` carries none of those three either, and works at every `n`.
- **2-forms.** `hs₁ : w₁ᵀ = -w₁` and `hs₂ : w₂ᵀ = -w₂` are section variables brought in by `include hs₁ hs₂ hsq` (line 129).
- **Common square.** `hsq : w₁ * w₁ = w₂ * w₂`, and `Aop w = -(w * w)` is $A$. `Aop_eq` gives `Aop w₂ = Aop w₁`, so one $A$ serves both forms, as in the record.
- **Positive definiteness as injectivity.** For skew $\omega_1$, $-x^{\mathsf T}\omega_1=(\omega_1x)^{\mathsf T}$, so $x^{\mathsf T}Ax=-x^{\mathsf T}\omega_1\omega_1x=\lVert\omega_1x\rVert^2$ (this is `dot_sq`), so $A$ is positive semidefinite always and positive definite exactly when $\omega_1x=0\Rightarrow x=0$. The two hypotheses are equivalent, as the module docstring (line 24) says.
- **Equal wedges.** `hwedge : ∀ a b c d, wedgeSelf w₁ a b c d = wedgeSelf w₂ a b c d`. `wedgeSelf` is [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 105, `wedge2 X X = halfw X X + halfw X X`, the coefficient array $2(X_{ab}X_{cd}-X_{ac}X_{bd}+X_{ad}X_{bc})$ of $X\wedge X$ in the record's convention. Equality of the full array is equality of the $4$-forms.
- **Two distinct eigenvalues.** `hdist` asks for $\mu\ne\nu$ and nonzero $x_0,z_0$ with $Ax_0=\mu x_0$ and $Az_0=\nu z_0$. That is "$A$ has at least two distinct eigenvalues" for a real symmetric $A$, whose eigenvalues all have real eigenvectors.
- **Conclusion.** `w₂ = w₁ ∨ w₂ = -w₁`, the record's $\omega_2=\pm\omega_1$.
- **Note, no gap: `hs₂` is idle.** The build's unused-section-variable linter flags `hs₁` and `hs₂` as unused in `Aop_eq` (line 131), and `hs₂` reaches every later theorem only through `Aop_eq`. So the Lean proves the lemma with $\omega_2$ an arbitrary real matrix. The strengthening is correct: `eigen_preserve` needs only that $\omega_2$ commutes with $\omega_2^2$, and `wedge_eval` is an identity for any matrix. Keeping `hs₂` matches the record's statement.
- **CONFIRMED.**

## B. Soundness

- **`wedge_eval`** (line 41). `hw` expands `wedgeSelf` to $2(w_{ab}w_{cd}-w_{ac}w_{bd}+w_{ad}w_{bc})$ by unfolding and `ring`. `t1` is the product of two double sums by `sum4_prod`. `t2` relabels $b\leftrightarrow c$ and `t3` relabels $c\leftrightarrow d$ then $b\leftrightarrow c$ before the same factorisation, which puts $w_{ac}w_{bd}$ into $B(x,z)B(y,v)$ and $w_{ad}w_{bc}$ into $B(x,v)B(y,z)$. The signs and the factor $2$ agree with the record's form. Sound.
- **Eigenspace lemmas.** `eigen_preserve`: $(-w^2)w=w(-w^2)$, so $w$ maps $E_\mu$ of $-w^2$ into itself, for any matrix $w$. `Aop_symm` and `eigen_orth`: $A$ is symmetric for skew $w$, so $(\mu-\nu)\,x\cdot y=0$. `bf_self`: $B(x,wx)=x\cdot w^2x=-\mu\lvert x\rvert^2$. `eigen_pos`: with `dot_sq`, $-\mu\lvert x\rvert^2=-\lvert wx\rvert^2<0$, so $\mu>0$. Sound.
- **`mixed_eq`** (line 134). `cross` shows $B(p,q)=0$ for $p\in E_\mu$, $q\in E_\nu$ and any $w$ with `Aop w = Aop w₁`: $wq\in E_\nu$ by `eigen_preserve`, and `eigen_orth` (on the symmetric `Aop w₁`, needing only `hs₁`) gives $p\cdot wq=0$. It is applied to all four cross pairings $(x,z),(y,v),(x,v),(y,z)$ for both $w_1$ (`rfl`) and $w_2$ (`hA`). `wedge_eval` for both forms with `hwedge` then leaves $2B_1(x,y)B_1(z,v)=2B_2(x,y)B_2(z,v)$. Sound.
- **`scale`** (line 151). With $z\in E_\nu$ and $w_1z\in E_\nu$, $c=B_1(z,w_1z)=-\nu\lvert z\rvert^2\ne0$ by `eigen_pos`. `key` is `mixed_eq` at the pair $(z,w_1z)$. $d=B_2(z,w_1z)\ne0$ because $d=0$ would give $B_1(x_0,w_1x_0)\,c=-\mu\lvert x_0\rvert^2c=0$. With $s=c/d$, $B_2=s\,B_1$ on $E_\mu\times E_\mu$. For $x\in E_\mu$, $u=w_2x-s\,w_1x\in E_\mu$ (`h2` uses `hA` to move `eigen_preserve w₂` to `Aop w₁`), and $u\cdot u=B_2(u,x)-s\,B_1(u,x)=0$, so $u=0$. Finally $w_2^2x_0=s^2w_1^2x_0$ by applying `hvec` at $x_0$ and at $w_1x_0\in E_\mu$, and $w_1^2=w_2^2$ with $w_1^2x_0=-\mu x_0\ne0$ gives $s^2=1$. Sound.
- **`L195`** (line 210). `hall` shows every eigenvector $v$ of $A$, at any eigenvalue $\lambda$, has $w_2v=s\,w_1v$ with the one $s$ from $E_\mu$. The zero vector is trivial. At $\lambda=\mu$ it is `hvec`. At $\lambda\ne\mu$, `scale` gives $t$ for $E_\lambda$ (with $x_0$ as the second-eigenvalue witness), and `mixed_eq` at $(x_0,w_1x_0)\times(v,w_1v)$ with `e1`, `e2` gives $b_1b_2=st\,b_1b_2$, where $b_1=-\mu\lvert x_0\rvert^2$ and $b_2=-\lambda\lvert v\rvert^2$ are nonzero. So $st=1$, and with $s^2=t^2=1$, $(t-s)^2=t^2-2st+s^2=0$ gives $t=s$ (the `nlinarith` step, which has $s^2=1$, $t^2=1$, $st=1$ in context). Spanning: `hsymm` is `IsHermitian` from `Aop_symm hs₁`, and `mulVec_eigenvectorBasis` makes each basis vector an eigenvector, so $D=w_2-s\,w_1$ kills an orthonormal basis and `eq_zero_of_eigenbasis` gives $D=0$. Then $s^2=1$ splits into $s=\pm1$. Sound.
- **`eq_zero_of_eigenbasis`** (line 120). A linear map vanishing on a basis is zero, and `toEuclideanLin` is injective. Sound. The build warns that `Matrix.ofLp_toEuclideanLin_apply` (line 125) is deprecated in favour of `Matrix.ofLp_toLpLin`, a maintenance note with no bearing on correctness.
- **Hypotheses.** `hinj` is used (positivity of every eigenvalue, hence $c$, $d$, $b_1$, $b_2$ nonzero). `hdist` is used. `hs₂` is idle, as in A. None is missing.
- **CONFIRMED.**

## C. Record accuracy

- **The L195 (statement) row** ([lean/INDEX.md](../lean/INDEX.md) line 213). The status moves to **proved** and the row adds "THE LEMMA IS PROVED in L195Proof.lean as `L195`: ... with $\omega_1$ injective ($A$ positive definite) ... give $\omega_2=\pm\omega_1$. The rank-one step is `mixed_eq`, the wedge evaluated on $E_\mu\times E_\nu$ (`wedge_eval`), with no $\Lambda^4$ ... standard three axioms." Accurate (A, B, D). **proved** is justified.
- *Note, no gap:* the row still opens "THE STEP THAT FINISHES L195" on ConstantSign.lean's `const_of_pairwise_mul_eq_one`. `L195` does not use it. It reaches $t=s$ directly from $st=1$ and $s^2=t^2=1$. The sentence stays true of the record's prose proof, but a reader could take ConstantSign.lean to be a dependency of `L195`.
- **diagonal-half.md line 1047.** "Kernel-checked as `L195` in L195Proof.lean, the rank-one step read off the wedge evaluated on $E_j\times E_k$ with no $\Lambda^4$." Accurate. The Lean takes a route different from the prose (the bilinear forms $B_i$ on $E_j\times E_k$ rather than the factorisation of $J_{1j}\wedge J_{1k}$), and the sentence describes the Lean's route.
- **The I69 row.** The asterisk before "The Lefschetz step itself is not typed" is removed, which closes the unmatched italic r1506 noted. Correct.
- **r1506's C-1, second docstring** ([L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) lines 98 to 100). "Stated as the rank inequality it is used through. L186Rank.lean's `rank_le_of_pos` proves it for Gram matrices." Accurate: `rank_le_of_pos` gives $\operatorname{rank}w_1\le\operatorname{rank}(l_1w_1w_1^{\mathsf T}+l_2w_2w_2^{\mathsf T})$ at $l_1,l_2>0$. Repaired.
- **r1506's C-1, module docstring, now GAP C-1.** Line 27 reads "The range fact for PSD sums and the passage from a non-decomposable `2`-form to `rank ≥ 4` are L186Rank.lean's `rank_le_of_pos` and `rank_ge_four`, which prove the count this file takes with its ranks as hypotheses." The same docstring defines "the range fact" at line 19 as $\operatorname{range}(A+B)=\operatorname{range}A+\operatorname{range}B$ for PSD $A,B$, used there to conclude that the support of $\omega_1$ IS $P_2+P_3$. `rank_le_of_pos` proves one kernel inclusion, $\ker(l_1A+l_2B)\subseteq\ker A$ for Gram $A$, hence only $\operatorname{range}A\subseteq\operatorname{range}(A+B)$ and the rank inequality. The equality of ranges, which is what the support conclusion at line 19 needs, is in no file of the layer. The half about `rank_ge_four` and the closing clause about the count are accurate. The repair is to say "the rank inequality for PSD sums" in place of "the range fact for PSD sums", and to keep the range identity listed as untyped.
- **The commit message** describes the edits as made. "15 declarations" matches the audit.
- **CONFIRMED WITH GAP.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only L195Proof`: "auditing 15 declarations across 1 files ... 15/15 clean -- resting on the standard three alone".
- No `sorry`, `native_decide` or `axiom` in the file (grep).
- **CONFIRMED.**

## E. Style

- No em dash in any added line of the commit (grep count 0).
- No backticks inside markdown link text in the added lines (grep for ``[` `` count 0).
- The edited INDEX rows and the diagonal-half.md paragraph are single lines. No hard wrap. The Lean docstrings wrap, as Lean source does throughout the layer.
- The semicolons in the L195 row ("with no $\Lambda^4$; `scale` gives ...", "fixes one sign; standard three axioms") follow the list pattern r1499 to r1506 passed on the sibling rows.
- **CONFIRMED.**

## Overall

**CONFIRMED WITH GAP.** `L195` kernel-checks diagonal-half.md's Lemma L195 at every dimension, with positive definiteness correctly read as injectivity of $\omega_1$ ($x^{\mathsf T}Ax=\lVert\omega_1x\rVert^2$) and the skewness of $\omega_2$ idle. The proof goes through `wedge_eval`, the vanishing of cross pairings between orthogonal eigenspaces for both forms (`mixed_eq`), `scale` ($u\cdot u=0$, $s^2=1$) and one sign across eigenspaces from $st=1$, then Mathlib's `eigenvectorBasis` for spanning. 15/15 declarations on the standard three axioms, and the L195 row's **proved** is justified. Gap C-1: [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) line 27 attributes the range identity $\operatorname{range}(A+B)=\operatorname{range}A+\operatorname{range}B$ to `rank_le_of_pos`, which proves only the rank inequality.
