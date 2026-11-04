# VERIFY v128, L50: the bi-spectral identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$, the $n\le5$ collapse, and the $iklj$ index order

*Cold brief. **No numerical work was done**: no script was run, and every value below is an exact hand evaluation from closed forms already on the record. Log: [agent_logs/verify-L50-v128.log](../agent_logs/verify-L50-v128.log). Sources read: [findings/bispectral.md](../findings/bispectral.md), [results.md](../results.md), [findings/conventions.md](../findings/conventions.md), [ATTEMPTS.md](../ATTEMPTS.md), [references/dai-fu-2023-einstein-second-kind/](../references/dai-fu-2023-einstein-second-kind/) (notes, README and the arXiv text), [references/li-2021-nonnegative-second-kind/](../references/li-2021-nonnegative-second-kind/), [references/bourguignon-karcher-1978-pinching/notes.md](../references/bourguignon-karcher-1978-pinching/notes.md), [reviews/REVIEW_r97.md](../reviews/REVIEW_r97.md), [reviews/REVIEW_r98.md](../reviews/REVIEW_r98.md), [reviews/REVIEW_r672.md](../reviews/REVIEW_r672.md), [reviews/REVIEW_r463.md](../reviews/REVIEW_r463.md), [lean/INDEX.md](../lean/INDEX.md). No other verifier's report was opened.*

| # | Claim, as a consumer would read it | Verdict |
| --- | --- | --- |
| C1 | $\mathop{\mathrm{tr}}(\mathring W^2)=\tfrac34\lvert W\rvert^2$ at $s=0$, hence $\sum\omega^2=3$ when $\lVert M\rVert_F=1$ | **PROVEN**, re-derived here in full, independently of Dai–Fu |
| C2 | $\mathop{\mathrm{tr}}(\mathring W^3)=\tfrac18\alpha-\beta$ at $s=0$ | **PROVEN**, re-derived here in full, independently of Dai–Fu |
| C3 | $\alpha=8\mathop{\mathrm{tr}}(M^3)$ | **PROVEN**, re-derived here in three lines |
| C4 | $\beta=2\langle M^\#,M\rangle$, equivalently $\theta=\tfrac18\alpha+\tfrac12\beta$ | **HYPOTHESIS-DEBT**, no derivation anywhere on the record; the two Gate 2 reviewers confirmed it **numerically only** |
| C5 | $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$ | **PROVEN GIVEN C4**, the arithmetic from C1–C4 is exact and closes; and the display is confirmed exactly at $S^3\times S^3$ against $\theta_0(6)=\sqrt{10}/3$ |
| C6 | The pair $(\tfrac32,-\tfrac12)$, and what it depends on | **PROVEN, hypotheses corrected**: it depends on three conventions, of which the block names one |
| C7 | $\beta=\tfrac12\alpha$ at $n\le5$, by the Lovelock display | **HYPOTHESIS-DEBT**, the vanishing of $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ at $n\le5$ is a one-line theorem; the display it is applied to has no derivation on file, only a numerical calibration of $-64$ |
| C8 | "and only there" (the collapse **fails** at $n=6$ and above | **HYPOTHESIS-DEBT**), no witness is exhibited and no argument is given; a candidate witness sits nine lines above in the same file and is never joined to the claim |
| C9 | "This covers $n=4$ and $n=5$ by one mechanism" | **PROVEN GIVEN C7**, $6>n$ is the whole of it, and $n=4$ has an independent anchor on the record |
| C10 | The order $ikjl$ negates $\mathring W$ and the second coefficient | **PROVEN**, one line from the last-pair antisymmetry; and $\sum\omega^2=3$ is *unaffected*, which the block does not say |
| C11 | "the record uses one order consistently" | **BROKEN**, [references/dai-fu-2023-einstein-second-kind/notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md):17 and its [README.md](../references/dai-fu-2023-einstein-second-kind/README.md):6 state the identity with $+\tfrac12$, the $ikjl$ sign, inside the file L50's own attribution points at |
| C12 | The corollary is "correct only with $\mathrm{pr}$ on both sides" | **GAP**, the reason given ($W^\#\notin\mathrm{Weyl}_n$) is asserted from percentages; the structural reason is available and unstated |
| C13 | What [Lemma L52](../results.md) consumes is what this block establishes | **PROVEN**, L52 uses exactly the display, $\sum\mu=\sum\omega=0$, $p_2(\mu)=1$, $p_2(\omega)=3$, all in Li's order |
| C14 | A Lean row for L50 | **HYPOTHESIS-DEBT**, there is none; [L62](../lean/INDEX.md)'s row books L50's collapse as *imported and owed* |

**Summary.** Three of the four algebraic steps behind L50 are correct and I re-derived each of them from the Riemann symmetries alone; the fourth, the dictionary $\beta=2\langle M^\#,M\rangle$, which is the one step the record itself calls new, has never been derived anywhere on the record, and neither has the Lovelock display that carries the $n\le5$ collapse; the identity is nonetheless exactly right at $S^3\times S^3$, and the file L50 cites for its attribution states the identity with the wrong sign.

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md); nothing here is restated from memory.

- $W$ is an algebraic Weyl tensor: $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, first Bianchi $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and Ricci-flat $\sum_kW_{ikkj}=0$.
- $\lvert W\rvert^2:=\sum_{i,j,k,l}W_{ijkl}^2$, the **four-index** norm. $M$ is $W$ as an operator on $\Lambda^2\mathbb R^n$, with matrix $M_{(ab),(cd)}=W_{abcd}$ in the basis $\{\varphi_{ab}\}_{a<b}$, $\varphi_{ab}=E_{ab}-E_{ba}$, which is **orthonormal under the half-trace pairing** $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, [conventions.md](../findings/conventions.md), "A bivector's norm". Hence $\lVert M\rVert_F^2=\sum_{a<b,c<d}W_{abcd}^2=\tfrac14\lvert W\rvert^2$, which is [conventions.md](../findings/conventions.md)'s $\lvert W\rvert^2=4\lVert W\rVert_F^2$.
- $\mathring W$ is Li's second-kind operator, $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ on $S^2_0$, [Li 2021](../references/li-2021-nonnegative-second-kind/notes.md) eq. (2.2), read in the reference folder, not from memory.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$. The record's $\#$ is pinned by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ ([target.md](../findings/target.md):741) and by [conventions.md](../findings/conventions.md)'s $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$.
- $p_k(x)=\sum_ix_i^k$, a definition that has **no row in [conventions.md](../findings/conventions.md)**, as [r657](../reviews/REVIEW_r657.md) already recorded; I adopt the power-sum reading, the only one under which the identity closes.
- $\alpha:=W_{tpsq}W_{tpkl}W_{sqkl}$, $\beta:=W_{tspq}W_{tjpl}W_{sjql}$, all indices summed over $1,\dots,n$, [Dai–Fu](https://arxiv.org/abs/2311.18235) p. 5, specialised to $T=R$, which is the form Lemma 3.3 uses and which their §4.2 writes out at pp. 18–19 of the text.

**Both cited sources are in [references/](../references/) and I read them.** [Dai–Fu arXiv:2311.18235](https://arxiv.org/abs/2311.18235) is present as PDF and text; its Lemma 3.3 on p. 7 of the text reads $\mathop{\mathrm{tr}}((\mathring R)^2)=\tfrac34\lvert R\rvert^2-\tfrac{s^2}{n^2}$ and $\mathop{\mathrm{tr}}((\mathring R)^3)=-\beta+\tfrac18\alpha+\tfrac{s^3}{n^3}$, so [notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md)'s transcription of Lemma 3.3 is verbatim correct. [Li arXiv:2112.08465](https://arxiv.org/abs/2112.08465) is present, and its eq. (2.2) is transcribed correctly in [notes.md](../references/li-2021-nonnegative-second-kind/notes.md). **No claim below rests on an unread source.**

## 1. The hypothesis inventory

**The block's own hypotheses**, as written at [bispectral.md](../findings/bispectral.md):133–137 and [results.md](../results.md):709–713.

| H | hypothesis | where it is used in the written proof | status |
| --- | --- | --- | --- |
| H1 | $W\in\mathrm{Weyl}_n$, pair symmetries, first Bianchi, Ricci-flat | throughout | stated |
| H2 | $\lVert M\rVert_F=1$ | only to identify $P(W)$ with $\theta$ and to fix $\sum\mu^2=1$, $\sum\omega^2=3$ | stated; **not needed for the identity itself**, which is homogeneous of degree three on both sides |
| H3 | $\mathring W$ in Li's $iklj$ order | the sign of the $-\tfrac12$ | stated, and load-bearing |
| H4 | $n\ge4$ | $\mathrm{Weyl}_n=0$ below it | **unstated**; harmless, since the display is $0=0$ at $n\le3$ |
| H5 | $M^\#$ "with respect to the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$" | the constant $2$ in $\beta=2\langle M^\#,M\rangle$ | stated, and **misleading**, see §2.4 |

**Hypotheses of the imported results, each checked against the object it is applied to.**

| import | its hypotheses | the object here | verdict |
| --- | --- | --- | --- |
| [Dai–Fu](../references/dai-fu-2023-einstein-second-kind/notes.md) Lemma 3.3 | *"Let $(M,g)$ be an $n$-dimensional Einstein manifold"*, a **Riemannian manifold**, with $\mathring R$ built from its curvature | an **algebraic** Weyl tensor on $\mathbb R^n$, with no manifold behind it | **the strip is legitimate and the block asserts rather than argues it.** Their proof, as transcribed and as printed at p. 7 of the [text](https://arxiv.org/abs/2311.18235), is a trace computation over $S^2(V)$ at one point: no derivative, no compactness, no second Bianchi. The block's phrase *"used as the pointwise algebraic identity it is"* is the right claim, offered without the check. **§2.1 and §2.2 below discharge it by re-deriving both identities from the algebraic symmetries alone.** |
| Dai–Fu's $\alpha,\beta$ | defined at their p. 5 for a *pair* $(R,T)$ of algebraic curvature tensors; Lemma 3.3 needs $T=R$ | $T=R=W$ | correct, their §4.2 (pp. 18–19) writes the specialisation out |
| Li eq. (2.2) | none beyond $R$ having the curvature symmetries | $W$ | correct |
| Lovelock's dimensionally-dependent identity | that $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ is the full antisymmetriser on six indices | six indices in $\{1,\dots,n\}$ | correct, and see §3 |
| Hamilton's $\#$ | a normalisation of the structure constants | the record's $\#$, pinned by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ | **the block names a different normalisation in the same sentence**, §2.4 |

**Which of these the written proof actually uses.** H1 in full (Ricci-flatness only at one place, §2.1); H3 for the sign; H5 for the constant $2$. **H2 is used nowhere in the derivation** and is a statement-level normalisation only.

**Quantifier order and scope.** The display is a pointwise identity: $\forall n\ge4\ \forall W\in\mathrm{Weyl}_n$. Nothing is quantified over frames, so no frame-versus-extremal hazard of the kind [conventions.md](../findings/conventions.md) flags for $t_F$ arises. The collapse clause is a different shape and is where the quantifiers matter, §3.

**The edge of every range.**

- **$n=4$.** $\mathrm{Weyl}_4=\mathcal W^+\oplus\mathcal W^-$ is $O(4)$-reducible. Nothing in the derivation uses irreducibility, so the identity holds; and the collapse has an *independent* anchor here, [target.md](../findings/target.md):741 records $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ *"rebuilding $\mathfrak{so}(4)$ by hand"*, and [ATTEMPTS.md](../ATTEMPTS.md):2273 records Reviewer 94's adjugate mechanism, $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$.
- **$n=5$.** $\dim\mathrm{Weyl}_5=35$, $\dim\Lambda^2=10$, $\dim S^2_0=20$. The identity holds; the collapse rests **entirely** on the Lovelock display (§3.1), with no independent anchor.
- **$n=6$.** The identity holds; the *failure* of the collapse is asserted and unargued (§3.2).
- **Odd $n$.** **No finding: nothing in L50 is parity-sensitive.** The derivation never splits $\Lambda^2$ or $S^2_0$ by parity, and the two dimensions $\binom n2$ and $\tfrac{(n-1)(n+2)}2$ enter only as sizes. The parity hazards the record carries ($\theta_0$ against $\Theta_n$), are downstream of L50 and not inside it.
- **$\ker W\ne0$.** **No finding: L50 is untouched by it.** Every step is a polynomial identity in the entries of $W$; no inverse, no normalisation by an eigenvalue, no eigenframe. In particular the padding of a lower-dimensional Weyl tensor (which has a large kernel by construction), is covered. This is unlike [W4](../findings/INDEX-traps.md), where $\ker W\ne0$ makes the gradedness screen vacuous; there is no analogue here.

## 2. Question 1, does the identity hold, with those coefficients?

The written proof is a chain of four links: $\alpha=8\mathop{\mathrm{tr}}(M^3)$; $\beta=2\langle M^\#,M\rangle$; Dai–Fu's $\mathop{\mathrm{tr}}(\mathring W^3)=\tfrac18\alpha-\beta$; and $\theta=\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle$. **I re-derived the first and third from the curvature symmetries. The second and fourth are one claim, and it is the claim with no derivation on the record.**

### 2.0 The arithmetic of the chain closes exactly

Granting the four links: $p_3(\mu)=\mathop{\mathrm{tr}}(M^3)=\tfrac18\alpha$, so $p_3(\omega)=\mathop{\mathrm{tr}}(\mathring W^3)=\tfrac18\alpha-\beta=p_3(\mu)-2\langle M^\#,M\rangle$, whence $\langle M^\#,M\rangle=\tfrac12\big(p_3(\mu)-p_3(\omega)\big)$ and

$$\theta=p_3(\mu)+\tfrac12\big(p_3(\mu)-p_3(\omega)\big)=\tfrac32p_3(\mu)-\tfrac12p_3(\omega).$$

No step is dropped and no sign is lost. This much is also what [r463](../reviews/REVIEW_r463.md) checked. It is bookkeeping, and it is correct; what follows is whether the four links are.

### 2.1 The pair operator, and both of Dai–Fu's $s=0$ identities re-derived

Work in $\mathbb R^{n\times n}$ with the full Frobenius pairing and the standard basis $f_{ij}$, and define the symmetric operator

$$B_{(ij),(kl)}:=W_{iklj},\qquad (Bh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}.$$

$B$ **is symmetric**: $B_{(kl),(ij)}=W_{kijl}=-W_{ikjl}=W_{iklj}=B_{(ij),(kl)}$, using only the first-pair and last-pair antisymmetries.

$B$ **preserves the symmetric/antisymmetric splitting.** Relabelling $k\leftrightarrow l$, $(Bh)_{ji}=\sum W_{jkli}h_{kl}=\sum W_{jlki}h_{lk}$, and $W_{jlki}=W_{kijl}=W_{iklj}$ by the pair symmetry and the two antisymmetries. So $(Bh)_{ji}=\pm(Bh)_{ij}$ according as $h$ is symmetric or antisymmetric. **Pair symmetries only; no Bianchi.**

**On $S^2$: $B|_{S^2}=\mathring W\oplus 0$.** $(Bg)_{ij}=\sum_kW_{ikkj}=0$ by Ricci-flatness, so $g$ is in the kernel; and $\mathop{\mathrm{tr}}(Bh)=\sum_{i,k,l}W_{ikli}h_{kl}=-\sum W_{ikil}h_{kl}=0$, again by Ricci-flatness, so $B$ maps $S^2$ into $S^2_0$. Hence $B|_{S^2_0}=\mathring W$ and $\mathop{\mathrm{tr}}\big((B|_{S^2})^m\big)=\mathop{\mathrm{tr}}(\mathring W^m)$ for every $m\ge1$. *This is the one place Ricci-flatness enters, and it is exactly where Dai–Fu's $s$-corrections live: for Einstein $R$ one has $Bg=-\tfrac sng$, which is their "subtract the $g/\sqrt n$ direction".*

**On $\Lambda^2$: $B|_{\Lambda^2}=-M$.** Take $u_{ab}=(f_{ab}-f_{ba})/\sqrt2$, $a<b$, orthonormal. Then

$$(Bu_{ab})_{ij}=\tfrac1{\sqrt2}\big(W_{iabj}-W_{ibaj}\big)=\tfrac1{\sqrt2}\big(W_{iabj}+W_{ibja}\big)=-\tfrac1{\sqrt2}W_{ijab},$$

the middle equality by the last-pair antisymmetry and the last by the **first Bianchi identity** $W_{iabj}+W_{ibja}+W_{ijab}=0$. Pairing,

$$\langle Bu_{ab},u_{cd}\rangle=-\tfrac12\big(W_{cdab}-W_{dcab}\big)=-W_{abcd}=-M_{(ab),(cd)}.$$

**The two traces.** $\mathop{\mathrm{tr}}(B^2)=\sum_{i,j,k,l}W_{iklj}^2=\lvert W\rvert^2$, the sum being a relabelling of the full four-index sum. Splitting,

$$\mathop{\mathrm{tr}}(\mathring W^2)=\mathop{\mathrm{tr}}(B^2)-\mathop{\mathrm{tr}}\big((B|_{\Lambda^2})^2\big)=\lvert W\rvert^2-\mathop{\mathrm{tr}}(M^2)=\lvert W\rvert^2-\tfrac14\lvert W\rvert^2=\tfrac34\lvert W\rvert^2 .$$

**C1 is proved.** For the cube, $\mathop{\mathrm{tr}}(B^3)=\sum W_{iklj}W_{kpql}W_{pijq}$. Rename $(i,k,p)\to(a,b,c)$ and keep $(j,l,q)$: the summand is $W_{ablj}W_{bcql}W_{cajq}$, in which $a,j$ are shared by factors 1 and 3, $b,l$ by 1 and 2, and $c,q$ by 2 and 3. Transposing one pair in each factor,

$$W_{ablj}=-W_{balj},\qquad W_{bcql}=-W_{bclq},\qquad W_{cajq}=-W_{acjq},$$

so $\mathop{\mathrm{tr}}(B^3)=-\sum W_{balj}W_{bclq}W_{acjq}$. Setting $t=b$, $s=a$, $p=l$, $q_\beta=j$, $j_\beta=c$, $l_\beta=q$, the three factors are exactly $W_{t s p q_\beta}$, $W_{t j_\beta p l_\beta}$, $W_{s j_\beta q_\beta l_\beta}$, the summand of $\beta$. Hence $\mathop{\mathrm{tr}}(B^3)=-\beta$, and

$$\mathop{\mathrm{tr}}(\mathring W^3)=\mathop{\mathrm{tr}}(B^3)-\mathop{\mathrm{tr}}\big((B|_{\Lambda^2})^3\big)=-\beta+\mathop{\mathrm{tr}}(M^3)=\tfrac18\alpha-\beta$$

once C3 below is in hand. **C2 is proved**, and it agrees sign for sign with the printed Lemma 3.3 at $s=0$. *So the block's hypothesis-strip from "Einstein manifold" to "algebraic Weyl tensor" is sound, and the record has nowhere said so; this is the check the phrase "used as the pointwise algebraic identity it is" stands in for.*

### 2.2 $\alpha=8\mathop{\mathrm{tr}}(M^3)$

Let $A_{(tp),(sq)}:=W_{tpsq}$ on $\mathbb R^{n\times n}$. $A$ is symmetric and kills the symmetric subspace ($\sum_{sq}W_{tpsq}h_{sq}=0$ for $h$ symmetric, by the last-pair antisymmetry). On $\Lambda^2$, $\langle Au_{tp},u_{sq}\rangle=\tfrac12\big(W_{sqtp}-W_{sqpt}-W_{qstp}+W_{qspt}\big)=2W_{tpsq}$, so $A=2M\oplus0$ and $\mathop{\mathrm{tr}}(A^3)=8\mathop{\mathrm{tr}}(M^3)$. Since $A$ is symmetric, $\alpha=\sum_{P,Q,K}A_{PQ}A_{PK}A_{QK}=\mathop{\mathrm{tr}}(A^3)$. **C3 is proved, from the pair antisymmetries alone**, which is [r97](../reviews/REVIEW_r97.md)'s "one line", and I confirm it and its scope: Bianchi and trace-freeness are unused, so it holds on all of $S^2(\Lambda^2)$.

### 2.3 The one link with no derivation: $\beta=2\langle M^\#,M\rangle$

Everything above is independent of $\#$. What remains, and what the whole identity now rests on, is

$$\theta=\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle\quad\text{together with}\quad\beta=2\langle M^\#,M\rangle,\qquad\text{i.e.}\qquad \boxed{\ \theta=\tfrac18\alpha+\tfrac12\beta\ }$$

**There is no derivation of this anywhere on the record.** What is on file, read in full:

- [bispectral.md](../findings/bispectral.md):139 asserts *"Expanding each in the coordinate pair basis and using only the pair symmetries gives $\alpha=8\mathop{\mathrm{tr}}(M^3)$ and $\beta=2\langle M^\#,M\rangle$."* That is a description of a method, not a derivation; and for $\beta$ it cannot be literally right, since $\#$ is built from the $\mathfrak{so}(n)$ bracket and no expansion "in the coordinate pair basis using only the pair symmetries" produces structure constants.
- The support cited beside it is [run_bispectral_dictionary.py](../scripts/runs/run_bispectral_dictionary.py), a script.
- **The two Gate 2 reviewers the record names confirmed it numerically and only numerically.** [r97](../reviews/REVIEW_r97.md):24 records *"$\max\lvert\alpha-8\mathop{\mathrm{tr}}M^3\rvert$ and $\max\lvert\beta-2\langle M^\#,M\rangle\rvert$ were $\le7\times10^{-16}$ at every $n=4,\dots,8$ over $25$ unit-norm samples each"*; [r98](../reviews/REVIEW_r98.md):29 is the same measurement at $\le8\times10^{-16}$. r97 then gives a proof of the $\alpha$ half alone (*"For $\alpha$ this is one line"*) and none of the $\beta$ half.
- [r274](../reviews/REVIEW_r274.md):7 uses $\beta=2\langle M^\#,M\rangle$ as a **cross-check** on its own implementation of the sharp, i.e. it consumes the claim rather than proving it.
- [ATTEMPTS.md](../ATTEMPTS.md):2294 says *"The mathematics is in [target.md](../findings/target.md)"*, **and it is not**: target.md carries no $\alpha$/$\beta$ dictionary, the material having been moved to [bispectral.md](../findings/bispectral.md) on 2026-08-31. That pointer is stale, and it is the pointer a reader chasing the derivation would follow.

**What would have to be shown.** With $\{v_A\}$ an orthonormal basis of $\mathfrak{so}(n)\cong\Lambda^2$ and $c_{ABC}=\langle[v_A,v_B],v_C\rangle$, the record's $\#$, pinned by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ against [Lemma L153](../findings/bounds.md)'s marginal $\sum_{B,C}c_{ABC}^2=2(n-2)$, gives $\langle M^\#,M\rangle=\tfrac12\sum c_{ABC}c_{A'B'C'}M_{AA'}M_{BB'}M_{CC'}$. In the coordinate basis $\{\varphi_{ab}\}$ that is a sum of $8^3$ Kronecker terms against three $W$'s. **The debt is: expand it and show it equals $\tfrac12\beta$.** I have deliberately not done so, supplying it here would hand the record a derivation nobody has audited, under the letterhead of a check.

**What partly discharges it, and how far.** The record holds an *independent* anchor at $n=4$: [target.md](../findings/target.md):741 and [ATTEMPTS.md](../ATTEMPTS.md):2273 both establish $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ on $\mathrm{Weyl}_4$ by rebuilding $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, giving $\theta=3\mathop{\mathrm{tr}}(W^3)$ there. Combined with $\beta=\tfrac12\alpha=4\mathop{\mathrm{tr}}(M^3)$ at $n\le5$ (§3), the ansatz $\theta=\tfrac18\alpha+c\beta$ forces $(1+4c)\mathop{\mathrm{tr}}(M^3)=3\mathop{\mathrm{tr}}(M^3)$, hence $c=\tfrac12$. **So the constant $\tfrac12$ is pinned by the record's own $n=4$ theorem**, but only *given* the collapse, and only *on the collapsed locus*: this pins the coefficient, not the identity at $n\ge6$, where $\beta$ is an independent invariant.

### 2.4 Which normalisations the pair $(\tfrac32,-\tfrac12)$ depends on

**Why $\sum\omega^2=3$ and not $1$, it is forced, not chosen.** §2.1 gives $\mathop{\mathrm{tr}}(\mathring W^2)=\tfrac34\lvert W\rvert^2$ and $\mathop{\mathrm{tr}}(M^2)=\tfrac14\lvert W\rvert^2$. The ratio is $3$ at every $W$ and every $n$, so **the moment $p_2(\omega)$ is a dependent quantity: once $\sum\mu^2=1$ is declared, $\sum\omega^2=3$ follows and cannot be renormalised away**. A reader who "normalises $\mathring W$ to $\sum\omega^2=1$" is rescaling $\mathring W$ by $1/\sqrt3$, which multiplies $p_3(\omega)$ by $3^{-3/2}$ and turns the second coefficient into $-\tfrac{3\sqrt3}2$. The block prints $\sum\omega^2=3$ as one of four normalisation clauses, side by side with $\sum\mu^2=1$, which reads as though both were choices; **only the first is.**

**The four things the pair actually depends on.**

| what changes | the pair becomes | evidence |
| --- | --- | --- |
| Li's $iklj\to$ BK's $ikjl$ | $(\tfrac32,+\tfrac12)$ | §4 below, one line |
| overall scale of $W$ | $(\tfrac32,-\tfrac12)$, **unchanged** | both sides are homogeneous of degree three in $W$; so [post F33](../findings/INDEX-traps.md)'s $\lvert W\rvert_4=1$ convention, where $p_2(\omega)=\tfrac34$, keeps the same coefficients and changes only the moments and the meaning of $\theta$, which is exactly the live cross-file trap [conventions.md](../findings/conventions.md) records |
| $M$ defined without Dai–Fu's $\tfrac12$ in $\hat R(e_i\wedge e_j)=\tfrac12\sum R_{ijkl}e_k\wedge e_l$, i.e. $M\mapsto2M$ | $(\tfrac3{16},-\tfrac12)$ | $p_3$ scales by $8$ |
| $\#$ taken without the extra $\tfrac12$, [r672](../reviews/REVIEW_r672.md)'s alternative reading, the one giving $\mathrm{Id}^\#=2(n-2)\mathrm{Id}$ | $(2,-1)$ | $\theta'=p_3(\mu)+\beta=2p_3(\mu)-p_3(\omega)$ |

**The block names one of the four, and names it wrongly.** *"$M^\#$ is Hamilton's sharp with respect to the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$"*, but under the record's own pairing $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, which [conventions.md](../findings/conventions.md) says *"is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal"*, that basis **is** the orthonormal one. So the word "unnormalised" names the plain-Frobenius pairing in a sentence whose other constant, $\alpha=8\mathop{\mathrm{tr}}(M^3)$, is the half-trace one. [r672](../reviews/REVIEW_r672.md):56 reached the same place (*"two normalisations named in one line"*) and adds that [conventions.md](../findings/conventions.md) *"tables $Q(W)=W^2+W^\#$ and the $\circ$ product and never defines $\#$ itself"*. [r98](../reviews/REVIEW_r98.md):36 reads the phrase the other way, as *"the orthonormal basis $\phi_{ij}/\sqrt2$ would halve $M^\#$"*. **Two Gate 2 reviewers of the same block read the same clause as naming opposite pairings, and both verdicts were CONFIRMED.** The correct statement is the anchor: *$\#$ is normalised so that $\mathrm{Id}^\#=(n-2)\mathrm{Id}$*, which is convention-free and settles it.

### 2.5 The display is exactly right at a named object

Not a screen, an exact evaluation from the record's own closed forms. At the balanced $S^3\times S^3$, $n=6$, $m=3$, [Lemma L67](../results.md) gives the $\mathring W$ spectrum in Li's order as $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, $-2m(m-1)A$ once, with $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$. At $m=3$: $A=1/(3\sqrt{10})$, $A^2=1/90$, and the spectrum is $3A$ ten times, $-2A$ nine times, $-12A$ once.

- $\sum\omega=30A-18A-12A=0$. ✓
- $\sum\omega^2=(10\cdot9+9\cdot4+144)A^2=270/90=3$. ✓ **The forced value of §2.4, met exactly.**
- $p_3(\omega)=(10\cdot27-9\cdot8-1728)A^3=-1530A^3=-1530/(270\sqrt{10})=-\dfrac{17}{3\sqrt{10}}$, matching [bispectral.md](../findings/bispectral.md)'s closed form $-\tfrac{4m^2-6m-1}{m\sqrt{(m-1)(2m-1)}}$ at $m=3$, which is $-17/(3\sqrt{10})$.
- $p_3(\mu)=\tfrac1{m\sqrt{(m-1)(2m-1)}}=\dfrac1{3\sqrt{10}}$.

Then

$$\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\frac1{3\sqrt{10}}\Big(\tfrac32+\tfrac{17}2\Big)=\frac{10}{3\sqrt{10}}=\frac{\sqrt{10}}3,$$

and $\theta_0(6)^2=\tfrac{2\cdot5\cdot4}{36}=\tfrac{10}9$, so $\theta_0(6)=\sqrt{10}/3$. **The two agree exactly**, with no decimals anywhere. The coefficients $\tfrac32$ and $-\tfrac12$ are therefore right at this point, and the check is independent of the dictionary of §2.3, it runs on L67's spectrum and the record's $\theta_0$.

## 3. Question 2, is the collapse range exactly $n\le5$?

The clause has two halves and they are in very different states.

### 3.1 The $n\le5$ half: one line of it is a theorem, the other has no derivation

The display is

$$\beta-\tfrac\alpha2=-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}\,W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6}.$$

**Given the display, the conclusion is immediate and correct.** $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ is the generalised Kronecker delta, the determinant $\det(\delta^{a_i}_{b_j})$, which is totally antisymmetric in $a_1,\dots,a_6$. When $n\le5$ any six indices drawn from $\{1,\dots,n\}$ repeat, so it vanishes identically. Hence $\beta=\tfrac\alpha2$, hence $\langle W^\#,W\rangle=\tfrac12\beta=\tfrac14\alpha=2\mathop{\mathrm{tr}}(M^3)$ and $\theta=\mathop{\mathrm{tr}}(M^3)+2\mathop{\mathrm{tr}}(M^3)=3\mathop{\mathrm{tr}}(M^3)$. [r672](../reviews/REVIEW_r672.md):50 states the same one-sentence argument. **This half is sound, and it is the whole of "why $n\le5$".**

**The display itself has no derivation on the record.** What is on file is *"The constant $-64$ is verified at $n=6,7,8$ ([run_lovelock_syzygy.py](../scripts/runs/run_lovelock_syzygy.py))"*, a numerical calibration of one constant, presupposing the proportionality it is calibrating. And the load-bearing part is not the constant: **any** nonzero constant would give the collapse. What is owed is the *proportionality*, that $\beta-\tfrac\alpha2$ is a multiple of that six-index contraction at all. Neither [bispectral.md](../findings/bispectral.md), [ATTEMPTS.md](../ATTEMPTS.md):2296, [fence-posts.md](../findings/fence-posts.md) nor [r672](../reviews/REVIEW_r672.md) derives it; each states it and attributes it to Lovelock without a page or an equation number. **The attribution is to "Lovelock's" with no entry in [references/](../references/)** (there is no Lovelock folder) so unlike Dai–Fu and Li, *this* citation does rest on an unread source.

**What is independently anchored.** $n=4$ is: [target.md](../findings/target.md):741 and [ATTEMPTS.md](../ATTEMPTS.md):2273 give $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ on $\mathrm{Weyl}_4$ from $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, without Lovelock. **$n=5$ is not.** The only support for $n=5$ beyond the display is [run_n5_syzygy.py](../scripts/runs/run_n5_syzygy.py)'s two controls (a sample of provable rank $10$ and $35$, and $64$ polarisations) which are numerical, and which the block correctly presents as controls rather than as proof.

### 3.2 The "and only there" half: **no argument on file**

The claim is $\forall n\ge6\ \exists W\in\mathrm{Weyl}_n$ with $\beta\ne\tfrac\alpha2$. Nothing on the record argues it.

- **The display does not give it.** $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}\not\equiv0$ at $n\ge6$ says the *contraction operator* is nonzero on some six-index tensor; it says nothing about whether the particular cubic contraction of three **Weyl** tensors is nonzero. The block writes the display and then the words *"and only there"* as though one gave the other.
- **The stated support is numerical**: *"It fails at $n=6,7$, which is what confines it"* ([bispectral.md](../findings/bispectral.md), the two-controls paragraph, citing [run_n5_syzygy.py](../scripts/runs/run_n5_syzygy.py)).
- **No dimension above $7$ is even measured**, while the claim quantifies over all $n\ge6$.
- **A candidate witness sits nine lines above, in the same file, and is never joined to the claim.** [bispectral.md](../findings/bispectral.md):33 records *"The $n=6$ isospectral family, 300 tensors, identical $\Lambda^2$-spectra, $P\in\{-24,0,+24\}$"*. Two tensors with the same $\Lambda^2$ spectrum and different $P$ cannot both satisfy $\theta=3\mathop{\mathrm{tr}}(M^3)$. **I record this as available and unused, not as a repair**: the family's construction, its common norm, and its isospectrality have no argument on file either (the sentence is a measurement) and even granted, it reaches $n=6$ only, not $n\ge7$.

**What would have to be shown**, precisely: (i) one explicit $W\in\mathrm{Weyl}_6$ with $\beta\ne\tfrac\alpha2$, exhibited rather than sampled; and (ii) that it propagates upward, $\alpha$ and $\beta$ are ambient-dimension-free index contractions, so a padding argument is the obvious route, but the record does not make it and I am not making it here.

### 3.3 "This covers $n=4$ and $n=5$ by one mechanism"

**Correct, conditional on §3.1's display.** The mechanism is a single statement ($6>n$), with no case split, and it subsumes the $\mathfrak{so}(4)$ adjugate argument rather than sitting beside it. The block's correction of [fence post F2g](../findings/fence-posts.md) is also right on its own terms: $\mathrm{Weyl}_5$ is $O(5)$-irreducible and collapses, so reducibility cannot be the separating fact. *One caveat a consumer should carry: the separating fact is then "the rank of the Kronecker delta", which is a property of $n$ alone and therefore says nothing about which sub-family of $\mathrm{Weyl}_6$ collapses, and §3.2 shows nothing on file establishes that any member fails to.*

## 4. Question 3, is the index order load-bearing as stated?

### 4.1 The sign claim is correct, and it is one line

The two orders differ by transposing the last two slots, so $W_{ikjl}=-W_{iklj}$. Writing $\mathring W'$ for the operator built with $ikjl$,

$$(\mathring W'h)_{ij}=\sum_{k,l}W_{ikjl}h_{kl}=-\sum_{k,l}W_{iklj}h_{kl}=-(\mathring Wh)_{ij}.$$

So $\mathring W'=-\mathring W$, $\omega'=-\omega$, $p_3(\omega')=-p_3(\omega)$, and the display becomes $\theta=\tfrac32p_3(\mu)+\tfrac12p_3(\omega')$. **C10 confirmed.** This uses only the last-pair antisymmetry (no Bianchi, no trace-freeness) so it holds on all of $S^2(\Lambda^2)$.

**Two things the block does not say and a consumer needs.**

- **$\sum\omega^2=3$ is invariant under the flip**, $p_2$ being even. So the normalisation clause is *not* a way to detect which order a source is in, which is exactly the trap [conventions.md](../findings/conventions.md) records for Bourguignon–Karcher, and [target.md](../findings/target.md):130 states the same invariance. The block's sentence *"the order $ikjl$ negates $\mathring W$ and the second coefficient"* leaves a reader to suppose the whole display flips.
- **$\mathring W$'s $\Lambda^2$ companion also flips.** §2.1 gives $B|_{\Lambda^2}=-M$ in Li's order; in the $ikjl$ order the same operator restricts to $+M$. A consumer converting a page between orders must flip both restrictions, not only the $S^2_0$ one.

### 4.2 Does the record use one order consistently? **No**, and the break is in the attribution file

Sweeping every occurrence of $iklj$ and $ikjl$ across [findings/](../findings/), [results.md](../results.md), [ATTEMPTS.md](../ATTEMPTS.md), [lean/INDEX.md](../lean/INDEX.md) and [references/](../references/):

| file | order | state |
| --- | --- | --- |
| [conventions.md](../findings/conventions.md), [bispectral.md](../findings/bispectral.md), [results.md](../results.md), [target.md](../findings/target.md):130, [nondegeneracy.md](../findings/nondegeneracy.md):260, [LEDGER.md](../findings/LEDGER.md):1081 | Li's $iklj$ | consistent |
| [stratum-two-negative.md](../findings/stratum-two-negative.md) | BK's $ikjl$ throughout | **labelled**: line 329 says so explicitly, gives the conversion $\mathring R_e=-\mathring W_e$, and queues the rewrite. Correct practice |
| [references/bourguignon-karcher-1978-pinching/notes.md](../references/bourguignon-karcher-1978-pinching/notes.md), [references/li-2021-nonnegative-second-kind/notes.md](../references/li-2021-nonnegative-second-kind/notes.md) | each its own source's | labelled, with the conversion |
| **[references/dai-fu-2023-einstein-second-kind/notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md) and [README.md](../references/dai-fu-2023-einstein-second-kind/README.md)** | **$ikjl$'s sign, unlabelled, inside an $iklj$ file** | **BROKEN, see §8, D1** |

## 5. The corollary "correct only with $\mathrm{pr}$ on both sides"

The corollary, at [bispectral.md](../findings/bispectral.md):106 and again at :147, is

$$\mathrm{pr}\big(W^\#\big)=\tfrac12\,\mathrm{pr}\big(\iota_1^*(M^2)\big)-\tfrac12\,\mathrm{pr}\big(\iota^*(\mathring W^2)\big),\qquad Q(W)=\tfrac13\nabla\theta .$$

**$Q=\tfrac13\nabla\theta$ is correct, and it is two lines.** $P(x)=T(x,x,x)$ with $T$ fully symmetric and $\langle x\circ y,z\rangle=T(x,y,z)$ ([Lemma L51](../results.md)'s own set-up), so $Q(W)=W\circ W$ and $\nabla P=3T(W,W,\cdot)=3\,W\circ W=3Q(W)$. The block's correction of the earlier $\nabla\theta$ to $\tfrac13\nabla\theta$ is right; its evidence is *"ratio $3.000000$ exactly in every component"*, where the two lines above would do.

**What fails without $\mathrm{pr}$, and at what object, this is where the block is thin.** Everything offered is a percentage over samples: *"about $60\%$ of $\lVert M^\#\rVert$ lies outside $\mathrm{Weyl}_n$"*, *"relative error $0.58$ unprojected against $5.8\times10^{-16}$ projected"*, *"$\mathrm{pr}$ discards $40$–$69\%$ of the norm"*, *"in $30$ of $30$ samples"*. **No object is named.** Not padded $W_{\mathbb{CP}^2}$, not a sphere product, not a dimension, the reader is given a range of percentages over an unnamed sample and asked to accept a qualitative claim ($W^\#\notin\mathrm{Weyl}_n$) that is not itself a percentage.

**And the reason given is not the operative one.** The identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ is an identity of functions **on $\mathrm{Weyl}_n$**; the three cubics extend to the ambient $S^2(\Lambda^2)$ as different functions, so their ambient gradients can agree only modulo $\mathrm{Weyl}_n^\perp$, and a projection on *both* sides is forced by the shape of the statement before any property of $W^\#$ is consulted. The block instead argues from a property of the left-hand object alone. **Both readings support the same corrected display, so nothing downstream is wrong**; what is missing is a reason a consumer can check without running a script. **Verdict: GAP.**

**The withdrawal is properly placed.** The refuted difference-of-two-PSD-squares reading is withdrawn *in both copies* (at :115 and at :147) and [bispectral.md](../findings/bispectral.md):100 carries the standing instruction that *"any correction must touch both"*. **On this point the record's signature failure does not fire.** *(It fires elsewhere; see §8, D2.)*

**One clause I flag without a verdict.** *"at $n=5$ the two terms are proportional, $\mathrm{pr}(\iota^*(\mathring W^2))=-3\,\mathrm{pr}(\iota_1^*(M^2))$, which is the operator-level form of the $n\le5$ collapse"* ([bispectral.md](../findings/bispectral.md):115, closing sentence), stated at $n=5$ only, with no support cited and no $n=4$ companion, while the collapse it is said to be the operator-level form of covers both. It is not consumed anywhere I can find.

## 6. Comparing the forms

| where | the form | what it omits |
| --- | --- | --- |
| [bispectral.md](../findings/bispectral.md):15–21 (in context) | display, all four normalisation clauses, Li's order named with the arXiv link, and the sign consequence spelled out | nothing |
| [bispectral.md](../findings/bispectral.md):133–137 (canonical) | identical, plus $\theta=\langle W,Q(W)\rangle$; **no collapse clause in the statement**, the collapse being a separate paragraph below |, |
| [results.md](../results.md):709–713 (detail entry) | word-for-word the canonical block's statement | **the collapse**, see §8, D2 |
| [results.md](../results.md):244 (glance entry) | display + *"Collapses to one spectrum exactly for $n\le5$"* | **all four normalisation clauses and the index order.** A consumer taking this line alone has no way to know the sign convention, and no way to identify $\theta$ with the right side, since $\theta=P/\lVert W\rVert^3$ while the display's $\theta$ is $\langle W,Q(W)\rangle$, these agree only at $\lVert M\rVert_F=1$ |
| [references/dai-fu-2023-einstein-second-kind/](../references/dai-fu-2023-einstein-second-kind/) | $+\tfrac12$ | **the sign is wrong**, §8, D1 |
| [lean/INDEX.md](../lean/INDEX.md) | **no row exists** | everything |

**There is no Lean row for L50.** I searched [lean/INDEX.md](../lean/INDEX.md) for it; L50 appears there only as an *import*, [L62](../lean/INDEX.md)'s row lists among its **Owed** *"that $P=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_5$ ([L50](../results.md)'s collapse) ... imported"*. So the Lean layer consumes L50's hardest clause and formalises none of it.

**What the row would have to claim, if written.** Split by what the record holds data for, as [lean/INDEX.md](../lean/INDEX.md)'s own convention requires:

- **Formalisable now, from §2.0's arithmetic alone:** that $\tfrac18\alpha=p_3(\mu)$, $p_3(\omega)=\tfrac18\alpha-\beta$ and $\theta=\tfrac18\alpha+\tfrac12\beta$ jointly imply $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$, three linear relations in $(\alpha,\beta,p_3(\mu),p_3(\omega),\theta)$, closing over $\mathbb Q$ with no analysis. And that the $S^3\times S^3$ values of §2.5 satisfy it exactly, $\theta_0(6)^2=10/9$ recovered as an equality of squares.
- **Owed, and stated as owed:** the dictionary $\theta=\tfrac18\alpha+\tfrac12\beta$ (§2.3); the Lovelock display (§3.1); and every instance of "and only there" (§3.2).

## 7. What a consumer may cite, and what [Lemma L52](../results.md) actually uses

**Citable as proved:** the display $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ **on $\mathrm{Weyl}_n$, in Li's $iklj$ order**, together with $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$ at $\lVert M\rVert_F=1$, *conditional on the single dictionary step of §2.3*, everything else in the chain being re-derived here. And $\theta=3\mathop{\mathrm{tr}}(W^3)$ **at $n=4$**, which has an independent anchor.

**Citable only with the condition attached:** $\theta=3\mathop{\mathrm{tr}}(W^3)$ at $n=5$, conditional on the Lovelock display, which is underived and whose source is not in [references/](../references/).

**Not citable:** *"and only there"*. Nothing on the record argues that the collapse fails at any $n\ge6$.

**L52's consumption is exactly what this block establishes.** [Lemma L52](../results.md):727–741 uses: the display; $p_2(\mu)=1$ and $p_2(\omega)=3$ (in its penalty terms $\tfrac32M_+(1-p_2(K))$ and $-\tfrac12\cdot3m(p_2(K')-3)$); $\sum\mu=\sum\omega=0$; and $\lVert M\rVert_F=1$, which it states in its own hypotheses. **All four are in L50's display, and L52 states the normalisation itself rather than inheriting it silently.** L52's other inputs, the NPW diagonal identity $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ and Schur's theorem, come from elsewhere and are not L50's. *I checked the one place the two could have separated: L52's diagonal identity is stated in Li's order, which is the order §4 shows the $-\tfrac12$ requires, so the two are in one convention.* **No finding: the consumer's use matches the supplier's claim.**

*One knock-on worth naming for the consumer:* L52's bound has the shape $\tfrac32[\text{upper on }p_3(\mu)]-\tfrac12[\text{lower on }p_3(\omega)]$, so it inherits the sign of the second coefficient directly. **In the $ikjl$ order L52's inequality would point the wrong way**, both estimates then pushing against each other rather than together. That is the practical content of "load-bearing", and neither block says it.

## 8. The discrepancies, each under the three-step protocol

### D1, the file L50 cites for its attribution states the identity with the **wrong sign**. CONFIRMED

**Locate.** [references/dai-fu-2023-einstein-second-kind/notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md):17:

> *"…which is the content of the record's bi-spectral identity $\theta=\frac32\mathop{\mathrm{tr}}_{\Lambda^2}M^3+\frac12\mathop{\mathrm{tr}}_{S^2_0}\mathring W^3$"*

and the same folder's [README.md](../references/dai-fu-2023-einstein-second-kind/README.md):6:

> *"$P(W)=\tfrac32\mathop{\mathrm{tr}}_{\Lambda^2}W^3+\tfrac12\mathop{\mathrm{tr}}_{S^2_0}\mathring W^3$ follows"*

Both read $+\tfrac12$. [bispectral.md](../findings/bispectral.md):17 and :135, and [results.md](../results.md):711, read $-\tfrac12$. **[bispectral.md](../findings/bispectral.md):29 links to that exact notes.md as its authority for Lemma 3.3**, and [results.md](../results.md)'s literature section names Dai–Fu for L50.

**Exhibit, at a named object and exactly.** At the balanced $S^3\times S^3$, $n=6$, §2.5 gives $p_3(\mu)=\tfrac1{3\sqrt{10}}$ and $p_3(\omega)=-\tfrac{17}{3\sqrt{10}}$ in Li's order. The reference folder's formula returns

$$\tfrac32\cdot\tfrac1{3\sqrt{10}}+\tfrac12\cdot\Big(-\tfrac{17}{3\sqrt{10}}\Big)=\frac{1}{3\sqrt{10}}\Big(\tfrac32-\tfrac{17}2\Big)=-\frac{7}{3\sqrt{10}}=-\frac{7\sqrt{10}}{30},$$

**negative**, against $\theta(S^3\times S^3)=\theta_0(6)=+\sqrt{10}/3$. Wrong sign and wrong magnitude at the record's own reference point.

And it contradicts its **own file two lines above**: notes.md:11 transcribes $\mathop{\mathrm{tr}}(\mathring R^3)=-\beta+\tfrac18\alpha$, and notes.md:17 itself states $\alpha=8\mathop{\mathrm{tr}}_{\Lambda^2}M^3$. Substituting, the printed right-hand side is $\tfrac3{16}\alpha+\tfrac12(\tfrac18\alpha-\beta)=\tfrac14\alpha-\tfrac12\beta$, while $\theta=\tfrac18\alpha+\tfrac12\beta$. The two agree only where $\beta=\tfrac18\alpha$, at $n\le5$, where $\beta=\tfrac12\alpha$, only where $\alpha=0$.

**Argue the opposite.** *(i) The notes might silently be in Bourguignon–Karcher's $ikjl$ order, in which $+\tfrac12$ is correct.* Refuted at the file's own head: notes.md:3 declares *"$\mathring R(e_i\odot e_j)=R_{iklj}\,e_k\odot e_l$ … following Li and Cao–Gursky–Tran"*, and I read the arXiv text (lines 30–45), which prints the same $iklj$. *(ii) $\mathop{\mathrm{tr}}_{S^2_0}\mathring W^3$ might not mean $p_3(\omega)$.* It is the trace of the cube of a self-adjoint operator; it is $p_3$ of its spectrum. *(iii) It is a fossil of the pre-standardisation convention.* That is the **cause**, [ATTEMPTS.md](../ATTEMPTS.md):2300 records that the sweep *"recorded the identity in the first while citing Li and Dai–Fu, who use the second"* and that *"the two scripts written under the other convention were rewritten"*. The scripts were rewritten; **these two prose files were not.** A cause is not a defence.

**Impact.** A consumer checking L50's attribution (the recommended move, and the one this brief mandates), reads the identity negated in the file the lemma points at, in an order the file itself declares to be Li's. This is the record's signature failure in its exact form: **the correction landed in [bispectral.md](../findings/bispectral.md), [results.md](../results.md) and [conventions.md](../findings/conventions.md), and beside (not on), the two files that carry the citation.**

### D2, [results.md](../results.md)'s canonical L50 **asserts the collapse in its title and states it nowhere**. CONFIRMED

**Locate.** [results.md](../results.md):707 heads the detail entry *"Lemma L50, the potential is a function of two spectra, and collapses to one only below dimension six"*. Its body, :709–713, is the statement, the display and the index-order sentence. **The words $n\le5$, "collapse" and $\mathop{\mathrm{tr}}(W^3)$ do not appear in it.**

**Exhibit, at a named consumer.** [lean/INDEX.md](../lean/INDEX.md):106, [L62](../lean/INDEX.md)'s row, lists among its **Owed**: *"that $P=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_5$ ([L50](../results.md)'s collapse) … imported"*, and links to [results.md](../results.md). A reader following that link reaches an entry that does not contain the imported claim. The claim exists in the glance line at [results.md](../results.md):244 as *"Collapses to one spectrum exactly for $n\le5$"*, sixteen words, carrying the word **exactly**, whose "only there" half §3.2 shows has no argument anywhere.

**Argue the opposite.** *The heading is part of the statement, and the glance entry carries the claim; between them the record says it twice.* This is the strongest reading and it still fails on the record's own rule: [results-spec.md](../.claude/skills/research-loop/results-spec.md) makes section 10 *"the full statement of each"* and caps a glance entry at 60 words precisely because *"an entry running past 60 words is carrying an argument, a caveat or a second result, all three belong in section 10"*. The caveat that "exactly" needs therefore belongs in the detail entry, which has neither the claim nor the caveat. A second reading, that the collapse is a corollary rather than part of L50, is refuted by the title, which states it as part of the lemma.

### D3, the $\#$-normalisation clause names two pairings in one sentence. CONFIRMED

**Locate.** [bispectral.md](../findings/bispectral.md):139 (and verbatim in the brief): *"$\beta=2\langle M^\#,M\rangle$, where $M^\#$ is Hamilton's sharp with respect to the **unnormalised** $\phi_{ij}=E_{ij}-E_{ji}$"*, in the same sentence as $\alpha=8\mathop{\mathrm{tr}}(M^3)$.

**Exhibit, at two named sources.** [conventions.md](../findings/conventions.md) rules that $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing, *"which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal"*, and $=2$ under plain Frobenius, so the very basis the clause calls "unnormalised" is the record's orthonormal one, and $\alpha=8\mathop{\mathrm{tr}}(M^3)$ in the same sentence is computed in the half-trace pairing. The two Gate 2 reviewers of this block split on it: [r98](../reviews/REVIEW_r98.md):36 reads it as *"the orthonormal basis $\phi_{ij}/\sqrt2$ would halve $M^\#$"*; [r672](../reviews/REVIEW_r672.md):56 reads it as *"two normalisations named in one line"* and adds that [conventions.md](../findings/conventions.md) *"never defines $\#$ itself"*.

**Argue the opposite.** *"Unnormalised" means only "as an $n\times n$ matrix, without dividing by $\sqrt2$", and everything else is the record's default, under which the clause is a harmless gloss and the constant $2$ is right.* I believe that is what was meant, and §2.4 shows the constant is right. But the words do not determine it, and the proof that they do not is that two reviewers of the identical block read them oppositely and both returned CONFIRMED. The convention-free repair is one clause: **$\#$ is normalised so that $\mathrm{Id}^\#=(n-2)\mathrm{Id}$**, the anchor [target.md](../findings/target.md):741 already uses.

### D4, the pointer to the derivation points at a file that no longer has it. CONFIRMED, minor

**Locate.** [ATTEMPTS.md](../ATTEMPTS.md):2294: *"Derived in three steps from Dai–Fu Lemma 3.3 via the dictionary $\alpha=8\mathop{\mathrm{tr}}(M^3)$, $\beta=2\langle M^\#,M\rangle$. **The mathematics is in [target.md](../findings/target.md).**"*

**Exhibit.** [target.md](../findings/target.md) contains no $\alpha$/$\beta$ dictionary and no occurrence of either contraction; every occurrence of the letter $\beta$ in it is an eigenbasis index $v_\beta$. [bispectral.md](../findings/bispectral.md):127 records that the material was *"moved here from [results.md](../results.md) on 2026-08-31"*. So the one navigational pointer at the derivation is dead, and it is the pointer a reader hunting §2.3's missing step would follow, as I did.

**Argue the opposite.** *It was true when written, and [ATTEMPTS.md](../ATTEMPTS.md) is a dated log rather than a live index, so stale pointers are expected there.* Fair, and it is why this is graded minor rather than as a defect of L50. It is recorded because [ATTEMPTS.md](../ATTEMPTS.md) is the file this brief names as *"sometimes carrying the only derivation"*, and here it promises one and delivers a dead link.

### Withdrawn candidates

- **"$\sum\omega^2=3$ is a second free normalisation."** *Withdrawn*, §2.4 shows it is forced by $\sum\mu^2=1$, so listing it beside the others is presentation, not error.
- **"Dai–Fu's Einstein hypothesis is stripped without warrant."** *Withdrawn*, §2.1 re-derives both identities from the algebraic symmetries, so the strip is sound. What survives is the weaker observation, recorded in §1, that the record asserts rather than checks it.
- **"The identity needs $\lVert M\rVert_F=1$."** *Withdrawn*, both sides are homogeneous of degree three, so the display holds unnormalised with $\theta$ read as $P(W)$. The normalisation is needed only for the moment clauses and for $\theta=P/\lVert W\rVert^3$.

## 9. What would break it, and what I did to look

- **The display.** §2.1–§2.2 reduce it to the single statement $\theta=\tfrac18\alpha+\tfrac12\beta$. A falsifier is therefore one $W\in\mathrm{Weyl}_n$ at which $\langle M^\#,M\rangle\ne\tfrac12\beta$ under the record's $\#$ (the one with $\mathrm{Id}^\#=(n-2)\mathrm{Id}$). **I looked at two independent anchors and both close exactly**: $S^3\times S^3$ at $n=6$, where §2.5 returns $\sqrt{10}/3=\theta_0(6)$ with no decimals, and $n=4$, where [target.md](../findings/target.md):741's hand rebuild of $\mathfrak{so}(4)$ pins the coefficient $\tfrac12$ independently. **I did not find a falsifier and do not expect one.** The debt is a proof, not a doubt, which is why the verdict is HYPOTHESIS-DEBT and not GAP or BROKEN.
- **The $n\le5$ collapse.** A falsifier is one $W\in\mathrm{Weyl}_5$ with $\beta\ne\tfrac12\alpha$. I looked for an obstruction in the derivation and found none; the vanishing argument is airtight *given* the display, and the record's own controls (a sample of provable rank $35$, and $64$ polarisations) are aimed exactly at this and are numerical.
- **"And only there".** Here the missing object is the *witness*, not the falsifier: one exhibited $W\in\mathrm{Weyl}_6$ with $\beta\ne\tfrac12\alpha$. I searched [findings/](../findings/), [results.md](../results.md), [ATTEMPTS.md](../ATTEMPTS.md) and [reviews/](../reviews/) for one and found none; the nearest thing is the unargued isospectral family of §3.2.
- **The index-order claim.** A falsifier would be a Weyl tensor with $W_{ikjl}\ne-W_{iklj}$, impossible, that being the last-pair antisymmetry. §4.1 is unconditional.

## Verdict: **HYPOTHESIS-DEBT**

**The identity is right, and most of it is now proved here.** $\alpha=8\mathop{\mathrm{tr}}(M^3)$, $\mathop{\mathrm{tr}}(\mathring W^2)=\tfrac34\lvert W\rvert^2$ and $\mathop{\mathrm{tr}}(\mathring W^3)=\tfrac18\alpha-\beta$ are re-derived in §2.1–§2.2 from the curvature symmetries alone, which also discharges the Einstein-to-algebraic hypothesis strip the block asserts; the coefficients $\tfrac32$ and $-\tfrac12$ close exactly at $S^3\times S^3$ against $\theta_0(6)=\sqrt{10}/3$; and the $ikjl$ sign flip is a one-line theorem.

**Three things would have to be shown for the block to stand as written.**

1. **The dictionary $\theta=\tfrac18\alpha+\tfrac12\beta$**, equivalently $\beta=2\langle M^\#,M\rangle$, the one step the record itself calls new. No derivation exists anywhere: not in [bispectral.md](../findings/bispectral.md), not in [ATTEMPTS.md](../ATTEMPTS.md), not in [r97](../reviews/REVIEW_r97.md) or [r98](../reviews/REVIEW_r98.md), whose Gate 2 CONFIRMED rests on residuals of $10^{-16}$ over $25$ samples per dimension. Its constant is pinned at $n=4$ by an independent record theorem; the identity at $n\ge6$ is not.
2. **The Lovelock display $\beta-\tfrac\alpha2=-\tfrac1{64}\delta^{a_1\cdots a_6}_{b_1\cdots b_6}WWW$**, not the constant $-64$, which is calibrated numerically and which the conclusion does not need, but the *proportionality*. Its attribution is to a source with no entry in [references/](../references/), so it is the one claim here that does rest on an unread source.
3. **"And only there"**, one exhibited $W\in\mathrm{Weyl}_6$ with $\beta\ne\tfrac12\alpha$, and its propagation to $n\ge7$. Nothing on the record argues either half.

**And one confirmed defect to repair, independent of the debts.** [references/dai-fu-2023-einstein-second-kind/notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md):17 and [README.md](../references/dai-fu-2023-einstein-second-kind/README.md):6 state the identity with $+\tfrac12$ (the $ikjl$ sign), inside a file that declares Li's $iklj$ two lines above and transcribes Lemma 3.3 correctly. Both are the files L50's own attribution points at. **D1 in §8, with the failure exhibited exactly at $S^3\times S^3$.**
