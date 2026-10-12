# Review r233 -- the blast radius of the sign fix (Gate 2)

Reviewer 233, cold brief. Commits under review: [054e1e2](../scripts/runs/run_bn_transfer_theorem.py), 5ba3fbd, 5bda16a. Reviewer 232 runs claim 1 concurrently; this report covers claims 2-5.

Everything below is rebuilt from the metric. The Weyl tensors of $S^p\times S^q$ and $\mathbb{CP}^m$ are constructed from their curvature tensors in the convention $R_{ijij}=+K$ (Hamilton's, the one in which the round sphere has positive curvature operator), Ricci-contracted and Kulkarni--Nomizu-corrected, then compared against the repository's builders. Scripts: [scripts/reviewers/r233/](../scripts/reviewers/r233/).

## Verdicts

| # | Claim | Verdict |
|---|-------|---------|
| 2 | Blast radius of 5ba3fbd -- what else in the record is wrong | **The fix is CONFIRMED and the blast radius is TWO FILES, not the programme.** Every other builder in the repository carries a compensating leading minus. No recorded number changes. But the commit's account of the error is wrong in two ways, and the record held two independent witnesses to the bug that nobody read |
| 3 | Is the theta = +theta_0 guard adequate | **FIRES on the error it was written for, and MISSES four others**, including one that manufactures a false counterexample to the conjecture and one that is the exact failure class of the dispute it was added to close. It also runs after the numbers are printed |
| 4 | The S^2_0 restriction: dropping the eigenvalue nearest zero | **The restriction is RIGHT at all fourteen catalogued points -- and the assert guarding it is VACUOUS.** `ring()` sandwiches with $P=I-\hat g\hat g^{\mathsf T}$ before returning, so the zero it looks for is structural and present for every input. Four non-Ricci-flat witnesses pass it |
| 5 | Does p_2 = 3/4 survive the sign fix, both index orders | **CONFIRMED, and the two-order check is one check written twice.** $W_{ikjl}=-W_{iklj}$ exactly, so the orders differ by an overall sign and no even quantity can tell them apart. Ricci-flatness is necessary *and* sufficient on $S^2_0$, with the deficit in closed form |

---

## Claim 2 -- the fix is right, and the blast radius is two files

### The fix itself, re-derived rather than checked

For the product of unit round spheres $S^p(1)\times S^q(1)$: $K=1$ inside each factor and $0$ across, so $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ on each block and zero on mixed index sets. Contracting and subtracting the Kulkarni--Nomizu Ricci and scalar parts gives a Weyl tensor with $\mathrm{Ric}(W)=0$ to $10^{-16}$ and **intra-block $W_{ijij}>0$, cross-block $W_{ipip}<0$** -- at $p=q=3$, $+0.6$ and $-0.4$.

| point | $\lVert \hat W_{\text{true}}-\hat W_{\text{new}}\rVert$ | $\lVert \hat W_{\text{true}}-\hat W_{\text{old}}\rVert$ |
|---|---|---|
| $S^3\times S^3$ | $1.4\times10^{-16}$ | $2.000$ |
| $S^4\times S^4$ | $0$ | $2.000$ |
| $S^5\times S^5$ | $0$ | $2.000$ |
| $S^6\times S^6$ | $2.3\times10^{-16}$ | $2.000$ |
| $S^5\times S^7$ | $6.4\times10^{-17}$ | $2.000$ |
| $S^4\times S^8$ | $3.3\times10^{-16}$ | $2.000$ |

$\lVert\hat A-\hat B\rVert=2$ between unit tensors is antipodality. **5ba3fbd is correct**, independently of reviewer 230's derivation ([r233_c2_signs.py](../scripts/reviewers/r233/r233_c2_signs.py)).

The same script rebuilds Fubini--Study with holomorphic sectional curvature $4$ ($K(e_0,e_1)=4.0000$, $K(e_0,e_2)=1.0000$ -- the standard $[1,4]$ pinching) and finds `cpm()` **already correct**: $\lVert\hat W_{\text{true}}-\hat W_{\text{cat}}\rVert\le2\times10^{-16}$ at $m=2,3,4$. So before the fix the catalogue's two builders disagreed with each other by a sign, and this is why $\mathbb{CP}^2$ read $+1.224745$ while $S^6\times S^6$ read $-1.236033$ in the same printout.

### The blast radius is two files

Eleven files in the repository build $\Lambda$ with `b = 1.0` and `a1 = -q*b/(p-1)`. Ten of them are in [scripts/runs/](../scripts/runs/) and **every one returns `-diag_weyl(Lam)`** -- the leading minus that [run_bispectral_catalogue.py](../scripts/runs/run_bispectral_catalogue.py) alone lacked. Verified by construction, not by reading ([r233_c2_siblings.py](../scripts/reviewers/r233/r233_c2_siblings.py)): at $S^4\times S^4$ each returns the true Weyl tensor to $\lVert\cdot\rVert=0.0\mathrm{e}{+}00$ exactly.

| file | builds |
|---|---|
| [run_omega_diagonal_blind.py](../scripts/runs/run_omega_diagonal_blind.py), [run_both_diagonals.py](../scripts/runs/run_both_diagonals.py), [run_schurhorn_rebuild.py](../scripts/runs/run_schurhorn_rebuild.py) | true $W$ |
| [run_bispectral_region.py](../scripts/runs/run_bispectral_region.py), [run_g_cap_refinement.py](../scripts/runs/run_g_cap_refinement.py), [run_diagonal_spread.py](../scripts/runs/run_diagonal_spread.py) | true $W$ |
| [run_k_bound_falsifier.py](../scripts/runs/run_k_bound_falsifier.py), [run_graded_spectral_gap.py](../scripts/runs/run_graded_spectral_gap.py), [run_graded_gap_at_fixed_n.py](../scripts/runs/run_graded_gap_at_fixed_n.py), [run_kappa_frame_invariant.py](../scripts/runs/run_kappa_frame_invariant.py) | true $W$ |
| [r228_claim1.py](../scripts/reviewers/r228/r228_claim1.py) | true $W$ |
| [run_bispectral_catalogue.py](../scripts/runs/run_bispectral_catalogue.py) | **was** $-W$; fixed |

The only consumer of the catalogue's `sphere_product` anywhere is [run_second_kind_moment.py](../scripts/runs/run_second_kind_moment.py) (plus two of reviewer 231's own scripts). **So the sign error reached exactly two files, and both are now consistent.**

### Nothing in the record changes -- and that is itself the finding

Every odd-degree quantity in the record was already recorded with the corrected sign, because it was measured by the sibling scripts or derived in closed form, never read off the catalogue's printout.

- [findings/bispectral.md](../findings/bispectral.md)'s closed-form $\omega$-spectrum $\{mA^{(m-1)(m+2)},\,-(m-1)A^{m^2},\,-2m(m-1)A^{1}\}$ reproduces the **fixed** tensor to $5.6\times10^{-16}$ at $m=3,4,5,6$, together with $p_3(\mu)=A$, $p_3(\omega)=-(4m^2-6m-1)A$ and $\theta=\theta_0(2m)$ ([r233_c2_omega.py](../scripts/reviewers/r233/r233_c2_omega.py)). Against the pre-fix catalogue every one of these is negated. **The closed form was a standing refutation of the constructor, sitting in the record since it was derived** -- it came from Li's Theorem 1.8 applied to true metrics, which is why it escaped.
- [response.md](../response.md) line 893 quotes $\max(-p_3(\omega))=2.405$ at $n=12$: the true value is $+2.404646$. Correct.
- [scripts/README.md](../scripts/README.md) fence post F23 quotes $-p_3(\omega)=2.4046$ and $-p_3(\text{diag})=-0.0028$ at $S^6\times S^6$: reproduced exactly by the unmodified script. Correct.
- [findings/INDEX.md](../findings/INDEX.md)'s $\theta$ table ($1.236033$, $1.200000$, $1.145644$, $1.054093$) is positive throughout. Correct.
- The $n=6$ isospectral family is built from `diag_weyl` directly and never touches `sphere_product`; the family is closed under $\Lambda\mapsto-\Lambda$, so its $P\in\{-24,0,+24\}$ is invariant either way.

**A third latent witness, in the record's oldest layer.** [ATTEMPTS.md](../ATTEMPTS.md) line 127 records the hand-derived Kulkarni--Nomizu formula $w^{(11)}=1-\tfrac{2(p-1)}{n-2}+\sigma$, $w^{(12)}=-1+\sigma$, $\sigma=\tfrac{p(p-1)+q(q-1)}{(n-1)(n-2)}$. At $p=q=3$: $\sigma=0.6$, $w^{(11)}=+0.6$, $w^{(12)}=-0.4$ -- the true signs, intra positive and cross negative, matching the rebuild above exactly. The convention of record has been right since that derivation; the catalogue never matched it.

The three negative $\theta$ values that do appear in the record -- $-1.2247$ in [findings/nondegeneracy.md](../findings/nondegeneracy.md) and [reviews/INDEX.md](INDEX.md), $-1.236033$ in [findings/target.md](../findings/target.md) -- are a deliberate $(-\mathrm{Fox})$ summand and a negation-closure argument about a critical-value census. Neither comes from the catalogue.

### Two corrections to 5ba3fbd's own account

**"theta is CUBIC ... only a CUBIC quantity sees it" is the wrong invariant.** What $W\mapsto-W$ preserves is *even* degree; what it flips is *odd*. Degree one flips too: the $\Lambda^2$ spectrum $\mu$, the $S^2_0$ spectrum $\omega$, the NPW diagonal $d$, $\min\omega$, the vertex matrix $K_{ab}$. `evaluate()` returns $\mu$ and $\omega$ to its callers and they were negated for the whole programme alongside $\theta$; the commit message and the in-file comment both name only $\theta$. The screens that are genuinely blind are the even ones -- $\lvert W\rvert$, $\operatorname{tr}(\mathring W^2)$ -- plus the linear ones (Ricci, Bianchi) which vanish identically and so cannot discriminate.

**"printed it for the whole programme" overstates the damage.** It printed it; the record never adopted it. The programme's odd-degree numbers came from the ten sibling builders and from closed forms, all of which had the right sign. The correct statement is that the catalogue's printout disagreed with the rest of the repository for the whole programme and nobody reconciled them -- which is a process failure rather than a mathematical one, and the fix for it is a cross-check, not a comment.

---

## Claim 3 -- the guard fires on one error and misses four

Each plant is a one-token edit of a **copy** of the file; the file under review is never modified ([r233_c3_guard.py](../scripts/reviewers/r233/r233_c3_guard.py)).

| plant | guard fires? | what the catalogue then prints |
|---|---|---|
| control | -- | $S^6{\times}S^6$ $\theta=+1.236033$, sum $=+1.236033$ |
| **P1** old constructor, `b=-1.0` $\to$ `b=+1.0` | **YES**, at $n=6$ | $\theta=-1.236033$ |
| **P2** `a1`/`a2` swapped (a no-op when $p=q$) | no | $S^5{\times}S^7$ $\theta=+1.268758$, **above $\theta_0(12)=1.236033$** |
| **P3** `cpm` returns $-W$ | no | $\mathbb{CP}^2$ $\theta=-1.224745$ |
| **P4** `ring` order `iklj` $\to$ `ikjl` | no | $\theta=+1.236033$ but sum $=-1.168613$ |
| **P5** isospectral family $\Lambda\to-\Lambda$ | no | unchanged (the family is negation-closed) |

**P1 confirms the guard.** It fires at the first guarded dimension with the message it was written to give.

**P2 is the serious miss.** Swapping the two intra-block coefficients is invisible at $p=q$ by construction, so no balanced-product guard can ever see it -- and it makes the *unbalanced* $S^5\times S^7$ read $\theta=1.268758$, which exceeds $\theta_0(12)$. A planted bug of this shape manufactures a counterexample to the conjecture the programme is trying to prove, and passes the guard silently. The catalogue evaluates $(5,7)$ and $(4,8)$; the guard covers only $(3,3),(4,4),(6,6)$.

**P4 is the miss that matters most, because it is the failure class the guard was added to close.** `evaluate()` computes $\theta$ from $M$ and $M^\#$ alone -- `ring` never enters it -- so the guard certifies only the $\Lambda^2$ side and the tensor's overall sign. A wrong index order in `ring` leaves $\theta$ untouched and moves only the printed `sum`, whose value $-1.168613$ is exactly the figure [REVIEW_r230.md](REVIEW_r230.md) identifies as the flipped-convention answer. The eight-figure dispute of the preceding cycles *was* a dispute about `ring`'s index order, and the guard added to settle it cannot see that order at all.

**P3 leaves $\mathbb{CP}^m$ entirely unguarded**, and $\sqrt{3/2}$ at padded $\mathbb{CP}^2$ is load-bearing: it is the witness in [plan.md](../plan.md) that fixes the crossover at $n=6+2\sqrt7$ and the anchor of fence post F2's stratum bound.

**The guard also runs too late.** It sits at line 82, after the eleven `evaluate` calls at lines 80-81 have already printed. "Nothing may be read off a catalogued maximiser before its theta is confirmed" is the stated intent, and the code prints first and asserts second. Under P1 every catalogued line is emitted with the wrong sign before the assertion stops the run.

**What would close the gaps, in one line each.** Assert $\lvert\theta-(\tfrac32 t_1-\tfrac12 t_2)\rvert<10^{-9}$ inside `evaluate`, which is the file's own bi-spectral identity and catches **P2 and P4** at every point including the unbalanced ones; assert $\theta(\mathbb{CP}^2)=+\sqrt{3/2}$, which catches **P3**; and move the block above the print loop.


---

## Claim 4 -- the restriction is right; the assert protecting it cannot fire

Script: [r233_c45_s20.py](../scripts/reviewers/r233/r233_c45_s20.py).

### It is right at every catalogued point

Fourteen points, the six sphere products the catalogue evaluates plus $\mathbb{CP}^{2,3,4}$, padded $\mathbb{CP}^2$ at $n=6$ and $n=12$, and the balanced products at $n=14,16,24$ that [run_second_kind_moment.py](../scripts/runs/run_second_kind_moment.py) actually uses. Dropping the eigenvalue nearest zero returns $p_2=0.750000$ at **all fourteen** -- which is the independent confirmation that the right eigenvalue came off, since $p_2(S^2_0)=\tfrac34\lvert W\rvert^2$ only after the correct restriction.

| point | $\lvert\text{dropped}\rvert$ | next smallest $\lvert\omega\rvert$ | count of $\lvert\omega\rvert<10^{-9}$ | $p_2(S^2_0)$ |
|---|---|---|---|---|
| $S^6\times S^6$ | $4.9\times10^{-17}$ | $0.056183$ | 1 | $0.750000$ |
| $S^5\times S^7$ | $1.4\times10^{-16}$ | $0.046524$ | 1 | $0.750000$ |
| $S^4\times S^8$ | $1.4\times10^{-17}$ | $0.031209$ | 1 | $0.750000$ |
| $\mathbb{CP}^2$ | $3.8\times10^{-17}$ | $0.204124$ | 1 | $0.750000$ |
| $\mathbb{CP}^2$ padded $n=6$ | $0$ | $0$ | **12** | $0.750000$ |
| $\mathbb{CP}^2$ padded $n=12$ | $1.5\times10^{-99}$ | $0$ | **69** | $0.750000$ |
| $S^{12}\times S^{12}$ | $1.7\times10^{-16}$ | $0.028815$ | 1 | $0.750000$ |

**On the tolerance.** At the unpadded points the gap is fourteen orders of magnitude either side of $10^{-9}$, so no near-zero can be silently deleted there. At the padded points the premise of the comment -- "the $g$-direction one is *the* ZERO" -- is simply false: $S^2_0$ itself carries $11$ and $68$ further exact zeros, and `argmin` picks among $12$ and $69$ indistinguishable candidates. That is **harmless**, because every candidate is zero and the surviving multiset is the same whichever comes off, and $p_2=0.750000$ at both padded points confirms it. But the justification as written does not describe what the code does.

### The assert is guaranteed by a projector, not by Ricci-flatness

[run_secondkind_sign.py:22-23](../scripts/runs/run_secondkind_sign.py#L22) ends `ring` with `P = np.eye(m) - np.outer(g,g); return P@Op@P`. **The $\hat g$ direction is annihilated before `eigvalsh` ever sees the operator**, so an exact zero eigenvalue is present for every input whatsoever. The assert added in 5bda16a therefore cannot fire, and its stated reason -- "`Wring(g) = -Ric` vanishes on a Weyl tensor, so a missing zero means the input is not Ricci-flat" -- is true of Li's operator and false of this implementation of it.

Four witnesses, none Ricci-flat, all passing:

| input | $\lvert\mathrm{Ric}\rvert_\infty$ | $\min\lvert\text{eig}\,\texttt{ring}()\rvert$ | assert fires | $\lvert\mathring R(\hat g)\rvert$ *unprojected* |
|---|---|---|---|---|
| round $S^6$, $\mathrm{Ric}=5g$ | $5.000$ | $3.3\times10^{-17}$ | **no** | $5.000000$ |
| round $S^{12}$, $\mathrm{Ric}=11g$ | $11.000$ | $8.2\times10^{-17}$ | **no** | $11.000000$ |
| random algebraic curvature, $n=6$ | $13.819$ | $1.7\times10^{-15}$ | **no** | $17.022606$ |
| random algebraic curvature, $n=8$ | $24.610$ | $8.0\times10^{-15}$ | **no** | $17.269423$ |

The last column is the quantity the assert believes it is testing, and it is large exactly where the assert is meant to fire. The assert's message is wrong on the mathematics too: for a non-Ricci-flat tensor the $S^2_0$ restriction *is* defined -- it is the compression $P\mathring RP$, which is what the code computes and what produces the $20$-against-$45$ witness of claim 5 below.

**What the check should be**, if the intent is to protect the restriction: `assert abs(np.einsum('ikjk->ij', W)).max() < 1e-9` on the input, or a norm test on the unprojected `ring(W) @ ghat`. Both fire on all four witnesses.

---

## Claim 5 -- $p_2=3/4$ survives, and the two-order form of the check is empty

### The sign fix cannot touch it, and does not

$p_2$ is even in $W$, so it is invariant under $W\mapsto-W$ by inspection; measured, at $\lVert W\rVert_4=1$:

| point | $p_2$ (fixed) | $p_2$ (old, $-W$) | $p_3$ (fixed) | $p_3$ (old) |
|---|---|---|---|---|
| $S^3\times S^3$ | $0.750000000$ | $0.750000000$ | $-0.223995$ | $+0.223995$ |
| $S^4\times S^4$ | $0.750000000$ | $0.750000000$ | $-0.265953$ | $+0.265953$ |
| $S^6\times S^6$ | $0.750000000$ | $0.750000000$ | $-0.300581$ | $+0.300581$ |
| $S^5\times S^7$ | $0.750000000$ | $0.750000000$ | $-0.291009$ | $+0.291009$ |

### "Both index orders" is one check written twice

$W_{ikjl}=-W_{iklj}$ by antisymmetry in the last pair, so the two operators are exact negatives: $\lVert\mathring W_{iklj}+\mathring W_{ikjl}\rVert_\infty=0.0\mathrm{e}{+}00$ at every point tested. Hence $p_2$ is **identically** equal in the two orders and $p_3$ **identically** opposite. The loop over `('iklj','ikjl')` in the $p_2$ assert cannot distinguish the conventions -- it runs the same test twice. The file's prose, "the one quantity no convention choice may move", is right, and the reason is stronger than stated: the choice is a global sign, so *no* even quantity moves. It follows that this assert gives no evidence at all about the index order; only the $p_3$ table does.

### Ricci-flatness is necessary and sufficient, with the deficit in closed form

Split $\mathrm{Sym}^2=\mathbb R\hat g\oplus S^2_0$ and write $\mathring R=\begin{pmatrix}a&v^{\mathsf T}\\ v&B\end{pmatrix}$, $a=\langle\hat g,\mathring R\hat g\rangle$, $v=P\mathring R\hat g$. Then $\operatorname{tr}(\mathring R^2)=a^2+2\lvert v\rvert^2+\operatorname{tr}(B^2)$, and Bianchi gives $\operatorname{tr}(\mathring R^2)=\tfrac34\lvert R\rvert^2$ on full $\mathrm{Sym}^2$ for every algebraic curvature tensor. So

$$p_2(S^2_0)=\tfrac34\lvert R\rvert^2-\big(a^2+2\lvert v\rvert^2\big),\qquad\text{equality}\iff \mathring R(\hat g)=0\iff\mathrm{Ric}=0 .$$

Necessity and sufficiency both, since $a^2+2\lvert v\rvert^2=0$ forces $a=0$ and $v=0$. Measured:

| tensor | $\tfrac34\lvert R\rvert^2$ | $p_2$ full | $p_2$ on $S^2_0$ | $a^2+2\lvert v\rvert^2$ |
|---|---|---|---|---|
| round $S^6$ | $45.000000$ | $45.000000$ | $20.000000$ | $25.000000$ |
| round $S^{12}$ | $198.000000$ | $198.000000$ | $77.000000$ | $121.000000$ |
| random ACR $n=6$ | $5312.240264$ | $5312.240264$ | $4736.873051$ | $575.367214$ |
| random ACR $n=8$ | $17711.867351$ | $17711.867351$ | $17121.633816$ | $590.233535$ |
| $S^6\times S^6$ Weyl | $237.600000$ | $237.600000$ | $237.600000$ | $0.000000$ |
| $\mathbb{CP}^2$ Weyl | $8.000000$ | $8.000000$ | $8.000000$ | $0.000000$ |

Every row closes to the last digit printed. The record's round-$S^6$ witness "$20$ against $45$" is reproduced, and it is the special case $\mathring R(\hat g)=-(n-1)\hat g$, giving deficit exactly $(n-1)^2$: $25$ at $n=6$ and $121$ at $n=12$, both confirmed. **So 5bda16a's correction is right**, and the hypothesis it restored is sharp rather than merely sufficient.

---

## Three stale artefacts in [run_second_kind_moment.py](../scripts/runs/run_second_kind_moment.py), found while checking claims 4 and 5

- **A comment that contradicts its own file.** Lines 214-218 still read "Which sign is correct is an OPEN CONFLICT recorded in the docstring ... this repo's own `ring()` ... returns +0.300581." The docstring above it now records the conflict as settled, and the table five lines earlier prints $-0.300581$ in that very order. The comment survived 5bda16a's rewrite of the docstring.
- **A dead check with a live claim.** The loop at lines 141-149 computes `lo` and does nothing with it; line 150 then prints "p_3^min < 0 at every n checked". The statement is true by inspection of the table above it, but nothing checks it any more. Either drop the print or restore an assert in the normalisation the table actually uses.
- **The two tables remain in different normalisations**, $m=1.348400$ above against $m=0.674200$ below at $n=12$, with no line saying so. Reviewer 230 flagged this as defect 2b and 5bda16a did not address it.

---

## Summary

| claim | outcome |
|---|---|
| 2 | Fix **confirmed** independently from the metric. Blast radius **two files**; no recorded number changes. The commit's "only a CUBIC quantity sees it" should read *odd*, and its "printed it for the whole programme" describes a printout the record never adopted |
| 3 | Guard **fires** on the planted old constructor. **Misses** the unbalanced-coefficient swap (which manufactures $\theta=1.268758>\theta_0(12)$), the $\mathbb{CP}^m$ sign, the `ring` index order -- the failure class of the dispute it was added to close -- and the isospectral family. Runs after the print |
| 4 | Restriction **correct** at all fourteen catalogued points, $p_2=0.750000$ throughout. Assert **vacuous**: the zero is created by `ring`'s own projector and four non-Ricci-flat inputs pass it |
| 5 | $p_2=3/4$ **survives**; it is even and cannot move. The two-order form of the check is one check twice, since the orders differ by a global sign. Ricci-flatness on $S^2_0$ is **necessary and sufficient**, deficit $a^2+2\lvert v\rvert^2$ |
