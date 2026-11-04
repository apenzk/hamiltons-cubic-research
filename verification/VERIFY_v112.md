# VERIFY v112, Lemma L52: the shared-frame majorization bound, the "exact iff both operators are diagonal in one shared frame" clause, the second display $\theta\le(t_F/2)^{3/2}\Theta_n+\tfrac92(M_++m)(1-t_F/2)$, and the headline still standing at [results.md](../results.md):248 and :721

**Verifier v112, cold brief.** No numerical work was run: no script, no interpreter, no sweep. Every number below is an exact hand evaluation of a closed form, and where a decimal appears it is quoted from the record and immediately replaced by the surd it stands for. Log: [agent_logs/verify-L52-v112.log](../agent_logs/verify-L52-v112.log).

## Verdicts

| # | claim, as a consumer reads it | verdict |
| --- | --- | --- |
| C1 | The displayed inequality $\theta\le\tfrac32[p_3(K)+3M_+(1-p_2(K))]-\tfrac12[p_3(K')+3m(p_2(K')-3)]$ | **PROVEN** |
| C2 | The Jensen route replaces Karamata for the *inequality* | **PROVEN** |
| C3 | Equality clause, **"if"** half, both operators diagonal in one shared frame $\Rightarrow$ exact | **BROKEN** as written: false under the block's own definition of $K'$ as "the full $\mathring W$ diagonal" |
| C4 | Equality clause, **"only if"** half, Karamata route | **GAP**, needs strict *concavity* of $t^3-3M_+t^2$, which the sentence never states |
| C5 | Equality clause, **"only if"** half, Jensen route: *"each row a point mass, so $U$ is a permutation"* | **BROKEN**, false at every degenerate spectrum |
| C6 | Headline *"the two spectra do not couple usefully through a shared frame"* at [results.md](../results.md):248 and :721 | **BROKEN**, refuted on the findings page, uncorrected where a consumer reads |
| C7 | Second display, penalty term $\tfrac92(M_++m)(1-t_F/2)$ | **PROVEN**, derived, not screened; carries an unstated $\psi$-basis hypothesis |
| C8 | Second display, leading term $(t_F/2)^{3/2}\Theta_n$ | **PROVEN**, but the derivation exists only in [REVIEW_r480.md](../reviews/REVIEW_r480.md); [findings/bispectral.md](../findings/bispectral.md) prints the display with a six-digit screen and no derivation |
| C9 | *"So L52 is a reduction of Conjecture A to a lower bound on the frame-optimised diagonal mass $t_F$"* | **BROKEN**, §7 below, exactly |
| C10 | *"The true statement is quantitative: the coupling loses exactly when $t_F<\tfrac43$"* | **HYPOTHESIS-DEBT**, one half unstated-hypothesis, the other half unargued |
| C11 | [lean/INDEX.md](../lean/INDEX.md) row for L52 against the three Lean files | **GAP**, the row narrates steps the files do not contain, and the two files it composes have incompatible hypotheses |

**Overall verdict: BROKEN.** *The inequality is sound and survives every attack; the "if and only if" attached to it is false in the "if" direction under the definition of $K'$ that the canonical text gives, and its "only if" direction is argued by a step that is false; the headline the canon carries is refuted by the same file that proves the bound.* **What a consumer may cite is in §9, and it is the inequality alone.**

## 0. Conventions, fixed once

- $W\in\mathrm{Weyl}_n$, $n\ge4$. $M$ is $W$ acting on $\Lambda^2\mathbb R^n$ with $\lVert M\rVert_F=1$ and spectrum $\mu$ (length $\binom n2$); $\mathring W$ is the curvature operator of the second kind on $S^2_0$ in Li's order $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, spectrum $\omega$ (length $(n-1)(n+2)/2$). Source read: [conventions.md](../findings/conventions.md) lines 63–90 and [references/li-2021-nonnegative-second-kind/README.md](../references/li-2021-nonnegative-second-kind/README.md) as quoted there.
- $p_k(x)=\sum_ix_i^k$. $\sum\mu=\sum\omega=0$, $p_2(\mu)=1$, $p_2(\omega)=3$; $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ ([Lemma L50](../results.md), audited).
- $K$ is the sectional vector $(W_{ijij})_{i<j}$, read as the $\Lambda^2$ diagonal in the frame's induced basis; as an $n\times n$ hollow symmetric matrix it is $K_{ab}=W_{abab}$ with $t_F=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ over **ordered** pairs, so $p_2(K)=t_F/2$ over unordered pairs. $K'$ is the $\mathring W$ diagonal in an orthonormal basis $\{\varphi_{ij}\}\cup\{\psi_k\}$ of $S^2_0$; $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$ and the $\psi_k$ span the diagonal traceless part.
- $M_+$ is any constant with $\mu_i\le M_+$ for all $i$; $m$ is any constant with $\omega_i\ge-m$. Both are frame-independent.
- $\Theta_n$ is the **diagonal maximum**: $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ at even $n$, $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$ ([conventions.md](../findings/conventions.md) line 19).
- $s:=t_F/2\in[0,1]$, $C:=M_++m$, $O:=\tfrac32C$ the one-line bound, $D:=\theta_{\mathrm{diag}}=\tfrac32p_3(K)-\tfrac12p_3(K')$. In this notation the first display reads $\theta\le D+\tfrac92C(1-s)$ and the second reads $\theta\le s^{3/2}\Theta_n+\tfrac92C(1-s)$.

## 1. Hypothesis inventory

**Carried by the block itself.**

| # | hypothesis | stated? | checked against |
| --- | --- | --- | --- |
| H1 | $W$ is a Weyl tensor with $\lVert M\rVert_F=1$ | inherited from the file header, **absent from the block and from [results.md](../results.md):721** | $p_2(\mu)=1$ and $p_2(\omega)=3$ are used as numbers inside the display; both are normalisation-dependent |
| H2 | An orthonormal frame $F$ of $\mathbb R^n$ is fixed, and *both* $K$ and $K'$ are read in it | stated ("in any orthonormal frame") | satisfied; see §4 for the quantifier |
| H3 | The $\psi$-block of the $S^2_0$ basis is an eigenbasis of $K$ on $\mathbf1^\perp$ | **not stated anywhere in the block or the canon** | required by the "if" half (§3) and by the second display (§6); recorded only at [conventions.md](../findings/conventions.md) line 22, [bispectral.md](../findings/bispectral.md) line 477, and [REVIEW_r479.md](../reviews/REVIEW_r479.md) §4 |
| H4 | $\mu_i\le M_+$ | stated | forced non-vacuous: $\sum\mu=0$ with $p_2(\mu)=1$ gives $\max\mu>0$, so $M_+>0$ |
| H5 | $\omega_i\ge-m$ | stated | likewise $m>0$ |
| H6 | $\Theta_n$ is the diagonal maximum at **both** parities (second display only) | not stated | [conventions.md](../findings/conventions.md) line 19; the same symbol was wrong on the record until 2026-09-04, so it must be quoted with its parity clause |
| H7 | $\theta_{\mathrm{diag}}\ge0$ (the $t_F<4/3$ clause only) | **not stated** | §8 |

**Imported results, each against the object it is applied to.**

| # | import | applied to | status |
| --- | --- | --- | --- |
| I1 | NPW Prop 3.10: $\{\varphi_{ij},\psi_k\}$ orthonormal in $S^2_0$ and $g(\mathring R\varphi_{ij},\varphi_{ij})=R_{ijij}$ | $\mathring W$ | **read on file**, [notes.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md), quoted in full with a transcription correction to $\psi_k$'s coefficient. Order matches Li's (round sphere $\mathring R=+\mathrm{Id}$, $R_{ijij}=+1$), so no sign trap |
| I2 | $M_{(ij),(ij)}=W_{ijij}$ | $M$ on $\Lambda^2$ | internal; self-consistent with $t_F\le2$ and $p_2(\mu)=1$, since $p_2(K)=t_F/2=1$ exactly at the coordinate-diagonal end |
| I3 | **Schur's theorem** (diagonal $\prec$ spectrum) | $K\prec\mu$, $K'\prec\omega$ | classical; **no source in [references/](../references/)**, the claim rests on an unread source. Its content is however re-proved internally by the Jensen route (§2), so the debt is discharged for the inequality |
| I4 | **Karamata / Hardy–Littlewood–Pólya with equality case** | both convexity transfers | classical; **no source in [references/](../references/)**, unread source. The block explicitly says it is not needed; §3 shows the equality clause is where that matters |
| I5 | Double stochasticity of $(\lvert U_{ij}\rvert^2)$ | the Jensen route | classical (unitary $U$); the record itself calls this the only remaining import |
| I6 | [Lemma L50](../results.md) $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ | the substitution | audited on the record |
| I7 | [Lemma L94](../findings/bispectral.md) $t_F\le2$ per frame | second display's range | on file, with the per-frame/extremal distinction flagged at [conventions.md](../findings/conventions.md) line 112 |
| I8 | $\Theta_n$ is attained on the coordinate-diagonal locus and bounds it (second display) | $\widehat K$ | on file via [Lemma L57](../results.md) as reported by [REVIEW_r479.md](../reviews/REVIEW_r479.md) §7 |

**Which of these the written proof actually uses.** The inequality uses H1, H2, H4, H5, I1, I2, I6, and one of I3/I5, the block offers both and they are interchangeable here. It does **not** use H3, H6, H7, I4, I7, I8. The equality clause as written invokes I4 (Karamata) or I5 (Jensen), and **silently requires H3**. The second display requires H3, H6, I7, I8 on top of everything else.

## 2. Question 1a, the inequality. **PROVEN**, by both routes, with every convexity direction checked against its range

**The $\omega$ side.** $f(t)=t^3+3mt^2$, $f''(t)=6(t+m)$, so $f''\ge0$ exactly on $[-m,\infty)$. H5 puts every $\omega_i$ there. Every $K'_i$ is a Rayleigh quotient of $\mathring W$ at a unit vector, hence lies in $[\min\omega,\max\omega]\subset[-m,\infty)$, so both vectors sit in the interval on which $f$ is convex, which is what Karamata requires and what a bound asserted on the wrong range would miss. Convexity plus $K'\prec\omega$ gives $\sum f(K')\le\sum f(\omega)$, i.e. $p_3(K')+3mp_2(K')\le p_3(\omega)+3m\cdot3$, i.e.
$$p_3(\omega)\ \ge\ p_3(K')+3m\big(p_2(K')-3\big).$$
This is the block's display, and $p_2(\omega)=3$ is used exactly once, correctly.

**The $\mu$ side.** $h(t)=t^3-3M_+t^2$, $h''(t)=6(t-M_+)$, so $h''\le0$ exactly on $(-\infty,M_+]$; H4 puts $\mu$ there and $K\prec\mu$ puts $K$ there. Concavity reverses: $\sum h(K)\ge\sum h(\mu)$, i.e. $p_3(K)-3M_+p_2(K)\ge p_3(\mu)-3M_+$, i.e.
$$p_3(\mu)\ \le\ p_3(K)+3M_+\big(1-p_2(K)\big).$$

**The combination.** $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$; the $+\tfrac32$ multiplies an **upper** bound and the $-\tfrac12$ multiplies a **lower** bound, so both push upward. The display follows. *The direction of every convexity claim is right, and each is asserted on the range where it holds and nowhere else.*

**The Jensen route, which the block says makes Karamata unnecessary.** Write $M=U\mathop{\mathrm{diag}}(\mu)U^*$; then $K_i=M_{ii}=\sum_j\lvert U_{ij}\rvert^2\mu_j=\sum_jP_{ij}\mu_j$ with $P_{ij}=\lvert U_{ij}\rvert^2$ doubly stochastic. For convex $g$, each row is Jensen, $g(K_i)\le\sum_jP_{ij}g(\mu_j)$; summing over $i$ and exchanging the order,
$$\sum_ig(K_i)\ \le\ \sum_j\Big(\sum_iP_{ij}\Big)g(\mu_j)\ =\ \sum_jg(\mu_j),$$
the collapse being by the **column** sums, exactly as the block says. No sorting, no Abel summation, no majorization theory. **This is correct and it is a complete substitute for I3 in the inequality**, applied with $g=f$ on the $\omega$ side and $g=-h$ on the $\mu$ side. *One scope note the block does not make: the Jensen route needs $g$ convex only on an interval containing $\mu$ (and hence $K$, being convex combinations), which is precisely the interval Karamata would have needed, so the substitution loses nothing.*

**No finding:** the inequality survives. Signs, directions, ranges and the substitution into L50 are all right, and this agrees with [REVIEW_r479.md](../reviews/REVIEW_r479.md) §1 and [REVIEW_r480.md](../reviews/REVIEW_r480.md) Finding 1, which I read after completing my own check.

## 3. Question 1b, the "if and only if". **The "if" half is false as written**

### 3.1 Locate it exactly

> *"Writing $K$ for the sectional vector and $K'$ for the full $\mathring W$ diagonal … The bound is **exact if and only if both operators are diagonal in one shared frame**"*, [findings/bispectral.md](../findings/bispectral.md) lines 87–90, verbatim at [results.md](../results.md):721.

$K'$ is defined as *"the full $\mathring W$ diagonal"* in the frame. **The frame of $\mathbb R^n$ does not determine it.** The $\varphi$-block of the $S^2_0$ basis is fixed by the frame, but the $\psi$-block (an orthonormal basis of the diagonal traceless part, $n-1$ dimensional), carries a further $O(n-1)$ of freedom. Under the reading the words give ("any orthonormal $S^2_0$ basis adapted to the frame"), $K'$ is not a function of the frame, and the "if" half fails.

### 3.2 Exhibit the failure concretely

Take any $W$ that is coordinate-diagonal in the frame $F$, the record's own diagonal family, at any $n\ge5$, with sectional matrix $K$ hollow, symmetric, $K\mathbf1=0$, and $K$ **not** a multiple of a projection, so that $K\vert_{\mathbf1^\perp}$ has at least two distinct eigenvalues. Both operators are then diagonal in one shared frame, so the "if" half asserts exactness. Now take the $\psi_k$ to be NPW's own staircase basis of [Proposition 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md), the basis the block's own citation supplies. The $\psi$-block of $\mathring W$ is $-K\vert_{\mathbf1^\perp}$ ([bispectral.md](../findings/bispectral.md) line 236, verified there), and the staircase vectors are fixed by the frame alone, carrying no dependence on $W$; a $K$ with two distinct eigenvalues on $\mathbf1^\perp$ is **not** diagonal in them. So $K'\ne\omega$ as multisets, $p_2(K')<3$ strictly, and the penalty $-\tfrac12\cdot3m(p_2(K')-3)=\tfrac32m(3-p_2(K'))>0$ is strictly positive. **The bound is strict at a point where the stated condition holds.**

*The record itself says the staircase will not serve*, [bispectral.md](../findings/bispectral.md) line 477: *"the eigenbasis is load-bearing and NPW's own staircase $\psi_k$ will not serve, being fixed by the frame and carrying no dependence on $W$, so a hollow nonzero $K$ is never diagonal in it."* That sentence is four hundred lines away from the block, and it is absent from [results.md](../results.md):721 entirely.

### 3.3 Argue the opposite, the most charitable reading

Read *"the full $\mathring W$ diagonal"* as *"the diagonal of $\mathring W$ in the basis that makes the $\psi$-block diagonal"*, i.e. H3. Then $K'=d$, the "if" half holds, and the clause is true. This reading is available to a reader of [bispectral.md](../findings/bispectral.md) who has read line 477 or [conventions.md](../findings/conventions.md) line 22 first. **It is not available to a reader of [results.md](../results.md):721**, which is where the canon puts the lemma, and it is not available to a reader of the block that advertises itself as standing alone. The candidate therefore survives all three steps.

**What would falsify this finding:** a sentence in the block or in the canon fixing the $\psi$-basis. I grepped [findings/bispectral.md](../findings/bispectral.md) and [results.md](../results.md) for $\psi$ inside the L52 block and for "eigenbasis"; the specification appears only at [bispectral.md](../findings/bispectral.md) line 477, in a different block, and at [conventions.md](../findings/conventions.md) line 22.

### 3.4 This is exactly the record's named trap

[REVIEW_r479.md](../reviews/REVIEW_r479.md) §4 states the same defect (*"As written, $K'$ is undefined; under the reading 'any $\psi$-basis' the 'iff' is false"*), dated 2026-09-04. **The correction landed in a review file. The statement it corrects is unchanged in both places a consumer reads.** The audit banner at [bispectral.md](../findings/bispectral.md):71 even records the block as *"THE BOUND IS CONFIRMED"* with *"the equality case"* explicitly among what *"survives every attack"*, which is the strongest possible form of the trap: the correction and a clearance of the same clause sit in the same file, and the clearance is the one printed in bold.

## 4. Question 1c, the "only if" half, and which route the equality case actually needs

Equality in the display means $\tfrac32\Pi_\mu+\tfrac12\Pi_\omega=0$ where $\Pi_\mu:=p_3(K)+3M_+(1-p_2(K))-p_3(\mu)\ge0$ and $\Pi_\omega:=p_3(\omega)-p_3(K')-3m(p_2(K')-3)\ge0$. Both are non-negative and the coefficients are positive, so **equality forces both to vanish separately**. The forward direction therefore needs a strictness statement on *each* of the two functions.

### 4.1 The Karamata route states one strictness and needs two, **GAP**

> *"by strict convexity of $t^3+3mt^2$ and the equality case of Karamata"*

$f''=6(t+m)>0$ on $(-m,\infty)$ and vanishes only at the left endpoint, so $f$ is strictly convex on the closed $[-m,\infty)$. **That is correct**, and with HLP it gives $K'=\omega$ as multisets, hence $\mathring W$ diagonal in the basis used. It says nothing about $M$. The conjunction *"both operators are diagonal"* additionally needs $K=\mu$ as multisets, which comes from **strict concavity of $h(t)=t^3-3M_+t^2$ on $(-\infty,M_+]$**, a statement the sentence never makes and the block never makes anywhere. $h''=6(t-M_+)<0$ on the interior, so the missing statement is true; **it is nevertheless missing**, and a consumer reconstructing the proof from the sentence gets only half of the conclusion.

*Charitable reading:* "strict convexity of $t^3+3mt^2$" is shorthand for "strict convexity of the relevant function on each side". The words do not support it, one function is named, with its constant $m$, and the other constant $M_+$ appears nowhere in the justification. **Candidate survives, severity: incomplete rather than false.**

*What is not needed, and this is worth recording positively:* neither strictness step requires $M_+$ and $m$ to be the true extremes $\max\mu$ and $-\min\omega$. Any valid bounds work: $\Pi_\mu=0$ still forces $K$ to rearrange $\mu$, because strict concavity holds on the whole of $(-\infty,M_+]$ however large $M_+$ is taken. **The equality clause is robust to slack in the support constants**, which the record does not say and which is the one place its two constants could have leaked into the rigidity.

### 4.2 The Jensen route's equality case is **BROKEN**

**Locate it.** > *"The equality case follows directly: tightness in every row makes each row a point mass under strict convexity, so $U$ is a permutation, which is the shared frame."*, [bispectral.md](../findings/bispectral.md) line 89, in the block, and repeated verbatim in the [lean/INDEX.md](../lean/INDEX.md) row for [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean).

**Exhibit the failure.** Jensen equality at row $i$ for a strictly convex $g$ says the weights $P_{i\cdot}$ are supported where $\mu_j$ takes a **single value**, a point mass in the *value*, not in the *index*. When $\mu$ has a repeated eigenvalue the two differ. Concretely, take $\mu=(\lambda,\lambda,\nu)$ with $\lambda\ne\nu$, and
$$P=\begin{pmatrix}\tfrac12&\tfrac12&0\\[2pt]\tfrac12&\tfrac12&0\\[2pt]0&0&1\end{pmatrix},$$
which is doubly stochastic and arises from $U$ a rotation by $\pi/4$ in the degenerate eigenplane. Then $K=P\mu=(\lambda,\lambda,\nu)=\mu$, every row is tight in Jensen for every $g$, and **$U$ is not a permutation and $P$ is not a permutation matrix**. The stated inference fails.

**And the failure is at the objects L52 is about, not at a contrivance.** $\mathring W$'s spectrum at the record's own conjectured maximiser is massively degenerate: [conventions.md](../findings/conventions.md) line 86, quoting Li Example 2.5, gives $\mathbb{CP}^m$'s second-kind spectrum as two eigenvalues with multiplicities $m^2-1$ and $m(m+1)$. Degeneracy is the generic situation for these operators, not a corner of the statement.

**Argue the opposite.** The most charitable reading is that "$U$ is a permutation" is loose phrasing for "$P$ is supported on the eigenvalue blocks, so the frame diagonalises the operator". Under that reading the *conclusion* of the equality clause survives, a diagonal equal to the spectrum forces the off-diagonal to vanish, since $\sum_iK_i^2=\sum_i\mu_i^2=\lVert M\rVert_F^2=\sum_{i,j}M_{ij}^2$. **But the written step is not that step**, and the reading requires the reader to notice the error and repair it. *This verification does not supply the repair; it records that the sentence on file does not carry it.*

**Which route the equality case actually needs.** Neither, in the form offered. The Karamata route delivers the $\omega$ half correctly and is silent on the $\mu$ half; the Jensen route's final inference is false. **What would have to be shown**, and is nowhere on file in the block: (i) strict concavity of $t^3-3M_+t^2$ on $(-\infty,M_+]$; (ii) that row-tightness forces $P$ to be block-supported on eigenvalue levels, and that this makes $K$ a rearrangement of $\mu$ with multiplicity; (iii) that a diagonal equal to the spectrum forces the operator to be diagonal. [REVIEW_r480.md](../reviews/REVIEW_r480.md) Finding 1 carries (iii) in one line and asserts (i) implicitly by naming both $f$ and $g$; **neither the block nor [results.md](../results.md):721 carries any of the three.**

## 5. Quantifier order and scope, was a $\sup$ or an $\inf$ over frames distributed?

**In the first display: no, and this is the block's strongest feature.** *"In any orthonormal frame"* is a universal quantifier placed **outside** the whole display. One frame $F$ supplies $K$ and $K'$ simultaneously; both majorizations are read against that one $K$; the two penalties are evaluated at that one $F$. There is no step where the $\mu$-term is optimised over one frame and the $\omega$-term over another, which is the failure the brief asks about, and it would be a real risk here because $K$ appears in both terms through the shared-diagonal dictionary. **No finding.**

**In the equality clause: the quantifier changes silently.** The bound is per-frame; *"exact if and only if both operators are diagonal in **one shared frame**"* reads as an existential over frames. The two are reconciled only because exactness at $F$ turns out to be equivalent to diagonality at $F$, so *"there exists a frame in which both are diagonal"* is equivalent to *"the bound is exact in that same frame"*, not to *"the bound is exact in the frame you happen to be using"*. **A consumer who evaluates the display in an arbitrary frame at a coordinate-diagonal $W$ and finds it strict has not contradicted the clause**, and nothing in the wording tells them so. This compounds §3: the clause is a statement about one frame dressed as a statement about the tensor.

**In the second display: the substitution $t_F\mapsto\kappa^2=\max_Ft_F$ is where the trap is live.** [conventions.md](../findings/conventions.md) line 112 warns in terms: *"substituting the extremal value into a bound that decreases in $t$ turns it into an unjustified claim"*. Here the substitution happens to be legitimate **for a reason the record does not give**: the display holds in every frame, so $\theta\le\min_F[\,\cdot\,]$, and $M_+$, $m$, $\Theta_n$ are all frame-independent, so the right-hand side depends on $F$ through $t_F$ alone. The minimum is at $\max_Ft_F$ **provided the right-hand side is decreasing in $t_F$**, which is [REVIEW_r480.md](../reviews/REVIEW_r480.md) Finding 4's monotonicity step, and that step carries an unstated hypothesis (§8). *So the licence to write $t=\max_Ft_F$ exists, but it is exactly as secure as the monotonicity claim, and the record asserts the substitution without asserting the monotonicity.*

## 6. Question 3, the second display. The penalty is **derived**; the leading term is derived **only in a review file**

### 6.1 The penalty coefficient $\tfrac92(M_++m)(1-t_F/2)$, checked by hand, exactly

The record's own two identities are all that is needed, and both are on file:

- [bispectral.md](../findings/bispectral.md) line 51: bound $-\;\theta_{\mathrm{diag}}=\tfrac92M_+\lVert M_{\mathrm{off}}\rVert_F^2+\tfrac32m\lVert\mathring W_{\mathrm{off}}\rVert_F^2$.
- [bispectral.md](../findings/bispectral.md) line 305 and [conventions.md](../findings/conventions.md) line 22: $p_2(K)=\sum d_\varphi^2=t_F/2$ and $p_2(K')=\sum d^2=\tfrac32t_F$, **the second under H3**.

Hence $\lVert M_{\mathrm{off}}\rVert_F^2=p_2(\mu)-p_2(K)=1-\tfrac{t_F}2$ and $\lVert\mathring W_{\mathrm{off}}\rVert_F^2=p_2(\omega)-p_2(K')=3-\tfrac32t_F=3\big(1-\tfrac{t_F}2\big)$. Substituting,
$$\tfrac92M_+\Big(1-\tfrac{t_F}2\Big)+\tfrac32m\cdot3\Big(1-\tfrac{t_F}2\Big)\;=\;\tfrac92(M_++m)\Big(1-\tfrac{t_F}2\Big).$$
The two coefficients $\tfrac92$ and $\tfrac32\cdot3=\tfrac92$ agree exactly, which is why the collapse is possible at all. **The coefficient is right, and the collapse is an identity, not a coincidence**, the off-diagonal masses are locked in the ratio $3:1$ in every frame.

**The record's stated support is weaker than the fact.** [bispectral.md](../findings/bispectral.md):79 offers only *"screened against this record's own six digits, $\tfrac92(1.632993)(0.5)=3.674235$, the block's penalty sum exactly."* That is a consistency check of one product at one point, presented as the display's support. **The support the record needed was two lines of its own algebra, and it is available.** *Exact form of the screened numbers, so that no decimal is load-bearing here:* at padded $W_{\mathbb{CP}^2}$ the block's one-line figure $\tfrac32(M_++m)=2.449490$ is $\sqrt6$, so $M_++m=\tfrac23\sqrt6=\sqrt{8/3}$; with $t_F=1$ the penalty is $\tfrac92\cdot\tfrac23\sqrt6\cdot\tfrac12=\tfrac32\sqrt6$, whose square is $\tfrac{27}2$, and $3.674235^2<\tfrac{27}2<3.674236^2$, which is what [L52.lean](../lean/HamiltonsCubic/Results/L52.lean)'s `penalty_sum_bracket` records. So the six digits are the surd $\tfrac32\sqrt6$ and nothing is being fitted.

**Finding, recorded:** the penalty term is **PROVEN**, and it carries **H3** (the $\psi$-eigenbasis) because $p_2(K')=\tfrac32t_F$ is an identity only there. In any other adapted basis $p_2(K')<\tfrac32t_F$, the true penalty is *larger* than the display's, and the display is then **not** implied by the first one. The display is silent on this, exactly as the block is (§3).

### 6.2 The leading term $(t_F/2)^{3/2}\Theta_n$

The step needed is $\theta_{\mathrm{diag}}\le(t_F/2)^{3/2}\Theta_n$. It holds: $\theta_{\mathrm{diag}}=\tfrac32p_3(K)-\tfrac12p_3(K')$ is a cubic form in $K$, so with $\widehat K=K/\sqrt{t_F/2}$ one has $\theta_{\mathrm{diag}}(K)=(t_F/2)^{3/2}\theta_{\mathrm{diag}}(\widehat K)$, and $\widehat K$ is hollow, symmetric, $\widehat K\mathbf1=0$, $\lVert\widehat K\rVert_F^2=2$, the vertex matrix of a **unit coordinate-diagonal** Weyl tensor, at which $\theta_{\mathrm{diag}}$ is $\theta$ itself, bounded by the diagonal maximum $\Theta_n$.

**Where this argument lives.** [REVIEW_r480.md](../reviews/REVIEW_r480.md) Finding 2, in that file only. [findings/bispectral.md](../findings/bispectral.md):78–79 prints the display, credits a six-digit screen that touches only the penalty, and asserts the consequence. **Nothing in [findings/](../findings/) or [results.md](../results.md) derives the $\Theta_n$ factor, and nothing there records that it needs H6 (the parity clause on $\Theta_n$) or the identification of $\theta_{\mathrm{diag}}$ with $\theta$ at a coordinate-diagonal tensor.** So: **the answer to question 3 is "derived, but not where it is displayed"**, the display is on the findings page with a screen for support, and its argument is in a review file that the display does not cite.

## 7. The consequence the record draws from the second display is **BROKEN**

### 7.1 Locate it

> *"**So L52 is a reduction of Conjecture A to a lower bound on the frame-optimised diagonal mass $t_F$**, which is an analytic statement where the block leaves a numerical appraisal."*, [findings/bispectral.md](../findings/bispectral.md):79, and in the same words at [REVIEW_r480.md](../reviews/REVIEW_r480.md) Finding 2: *"At $t=2$ it returns $\Theta_n$, the conjecture, at even $n$, and it degrades linearly below."*

The claim is that some lower bound $t_F\ge\tau$ with $\tau<2$ would, through the display, deliver $\theta\le\Theta_n$.

### 7.2 Exhibit the failure, exactly, and at every $n$

Write $s=t_F/2$, $C=M_++m$. The display gives $\theta\le\Theta_n$ only if
$$s^{3/2}\Theta_n+\tfrac92C(1-s)\ \le\ \Theta_n\qquad\Longleftrightarrow\qquad \tfrac92C(1-s)\ \le\ \Theta_n\big(1-s^{3/2}\big).$$
Put $u=\sqrt s\in[0,1]$. Then
$$\frac{1-s^{3/2}}{1-s}=\frac{1-u^3}{1-u^2}=\frac{1+u+u^2}{1+u}\ \le\ \frac32 \iff 2(1+u+u^2)\le3(1+u) \iff (2u+1)(u-1)\le0,$$
which holds for every $u\in[0,1]$. So for $s<1$, dividing by $1-s>0$, the display can give $\theta\le\Theta_n$ **only if**
$$\tfrac92C\ \le\ \tfrac32\Theta_n,\qquad\text{i.e.}\qquad M_++m\ \le\ \tfrac13\Theta_n .$$
But the one-line bound, two lines, proved from H4 and H5 alone: $\mu_i^2(\mu_i-M_+)\le0$ gives $p_3(\mu)\le M_+$, and $\omega_i^2(\omega_i+m)\ge0$ gives $-p_3(\omega)\le3m$, hence $\theta\le\tfrac32(M_++m)$, then yields
$$\theta\ \le\ \tfrac32(M_++m)\ \le\ \tfrac12\Theta_n .$$

**So at every $W$ and in every frame with $t_F<2$, the second display certifies $\theta\le\Theta_n$ only where the one-line bound already certifies $\theta\le\tfrac12\Theta_n$.** The display's reach beyond the one-line estimate is empty, and it is empty *uniformly in $n$, in $t_F$ and in the tensor*. The only value of $t_F$ at which the display closes anything the one-line bound does not is $t_F=2$ exactly, which by [Lemma L94](../findings/bispectral.md) means $W$ is coordinate-diagonal in that frame, the case already granted by [Lemma L57](../results.md).

### 7.3 Argue the opposite

The most charitable reading is that "reduction" means only *"the display's right-hand side hits $\Theta_n$ at $t_F=2$"*, which is true and is [Lemma L54](../results.md)'s rigidity restated. Under that reading the sentence is a true statement about one endpoint dressed as a research programme, *"a lower bound on $t_F$"* invites the reader to look for $\tau<2$, and §7.2 shows every such $\tau$ is worthless. **The candidate survives all three steps.** The word doing the damage is *"reduction"*: a reduction whose only admissible hypothesis is the conclusion's own granted case reduces nothing.

### 7.4 What would break this finding

A configuration with $t_F<2$ at which $\tfrac92(M_++m)(1-t_F/2)\le\Theta_n(1-(t_F/2)^{3/2})$ and yet $\tfrac32(M_++m)>\tfrac12\Theta_n$. **No such configuration exists**, and the reason is the chain above, which uses only $(2u+1)(u-1)\le0$ on $[0,1]$, an algebraic identity, not an estimate. I looked for the escape in the two places it could hide: a frame-dependence in $M_+$ or $m$ that would let them shrink as $t_F$ grows (they are spectral, hence frame-independent, §5), and a sharper constant than $\tfrac32$ in $\frac{1-u^3}{1-u^2}$ (the ratio attains $\tfrac32$ at $u=1$, so $\tfrac32$ is the exact supremum and no sharpening exists).

## 8. The $t_F<\tfrac43$ threshold, **HYPOTHESIS-DEBT** on both halves

> *"**The true statement is quantitative: the coupling loses exactly when $t_F<\tfrac43$.**"*, [findings/bispectral.md](../findings/bispectral.md):75, carried into [L52.lean](../lean/HamiltonsCubic/Results/L52.lean) as the docstring of `threshold_nonempty`.

With $D=\theta_{\mathrm{diag}}$, the comparison is exact: coupling $-\;O=D+\tfrac92C(1-s)-\tfrac32C=D+\tfrac32C(2-3s)$.

- **"Loses when $t_F<\tfrac43$" ($s<\tfrac23$) needs $D\ge0$**, which is **H7 and is nowhere stated**. The record itself says the discarded piece $\theta_{\mathrm{diag}}-\theta$ is *"sign-indefinite"* ([bispectral.md](../findings/bispectral.md):53), and $\theta_{\mathrm{diag}}$ is the value of the cubic at a diagonal surrogate, a quantity that takes both signs on the diagonal family, the surrogate of $-W$ has $-\theta_{\mathrm{diag}}$. So the half of the biconditional that is argued is argued under an unstated hypothesis.
- **"Wins when $t_F>\tfrac43$" is not argued at all.** Winning at $s$ requires $D<\tfrac32C(3s-2)$, and $D$ is bounded above by $s^{3/2}\Theta_n$ (§6.2) but not below the threshold. At $s=\tfrac34$ ($t_F=\tfrac32>\tfrac43$) with the record's own constants at padded $W_{\mathbb{CP}^2}$, $C=\sqrt{8/3}$, and $n=12$, winning requires $D<\tfrac38C=\tfrac38\sqrt{8/3}=\tfrac{\sqrt6}4$, while the ceiling on $D$ is $(\tfrac34)^{3/2}\Theta_{12}=\tfrac{3\sqrt3}8\cdot\tfrac{\sqrt{220}}{12}=\tfrac{\sqrt{660}}{32}$. Comparing squares, $\big(\tfrac{\sqrt6}4\big)^2=\tfrac6{16}=\tfrac{384}{1024}$ against $\big(\tfrac{\sqrt{660}}{32}\big)^2=\tfrac{660}{1024}$: **the ceiling is strictly above the threshold**, so the interval of admissible $D$ at which the coupling *loses* while $t_F>\tfrac43$ is non-empty as a parameter range. Whether a Weyl tensor realises it is an existence question; settling it would need computation and **is not settled here**.
- **Charitable reading, and it is a good one.** As $C\to\infty$ the crossover $s^*$ solving $s^{3/2}\Theta_n=\tfrac32C(3s-2)$ tends to $\tfrac23$ from above. So $t_F<\tfrac43$ is exactly the region where the coupling loses **for every** value of the support constants, the uniform-in-$C$ statement. Written as *"loses exactly when"*, it reads as a per-tensor threshold, which it is not.

**Verdict on the clause: HYPOTHESIS-DEBT.** What would have to be shown: (i) $\theta_{\mathrm{diag}}\ge0$ at the configurations the clause quantifies over, or a restatement that does not need it; (ii) for the converse half, that $t_F>\tfrac43$ implies $D<\tfrac32C(3s-2)$, which §8's parameter range says is not automatic.

## 9. Question 2, does the headline follow from the bound?

**No. The bound establishes the opposite of what the headline says, and something on the same page says so.**

**What the bound establishes.** A shared frame ties $\mu$ and $\omega$ to one vector $K$, and the transfer is *exact* on the whole coordinate-diagonal family. That is a coupling that carries strictly more than the two moments and a support bound, and the file says so in its own words at [bispectral.md](../findings/bispectral.md):62: *"majorization against a shared frame **is** information about $\omega$ beyond its first two moments and a support bound. It is **inert rather than absent**."*

**What is on the same page and bears on it.** Four screens below the block, [bispectral.md](../findings/bispectral.md):276–280 proves
$$-\omega_{\min}=v^{\mathsf T}K^Fv\le\mu_1(K^F)\le\sqrt{\tfrac{t_F(n-2)}{n-1}}\le\sqrt{\tfrac{2(n-2)}{n-1}},$$
by taking $F$ to be the eigenframe of $\mathring W$'s bottom eigenvector. **That chain runs $\mu$-side budget $\to$ shared frame $\to$ $\omega$-spectrum**, which is a shared-frame coupling of the two spectra, and the file says it *proves the second-kind projection estimate at even $n$*, one of the programme's two standing estimates. **A page that uses a shared-frame coupling to prove a standing estimate cannot head a lemma "the two spectra do not couple usefully through a shared frame".**

**The scope of what the bound does support.** *The shared-frame **diagonal** does not transfer $p_3$ usefully.* That is one member of the class the headline quantifies over, and the block never enumerates the class. The distinction is not rhetorical: §7 shows the transfer is inert for a reason internal to $p_3$ and the support constants, while §9's cap is sharp and is about $p_2$-budgets and an eigenvector, a different mechanism entirely.

**The named trap, read as a consumer.** I read [results.md](../results.md):721 alone, as a consumer would. It gives the dictionary, Schur, the convexification, the display, and the "if and only if". **It contains not one word arguing that the coupling is useless**, and the heading above it asserts exactly that. [results.md](../results.md):248 is worse: it prints the headline *plus* the operative clause *"off it, loses to a one-line estimate and to the moment relaxation it was built to improve"*, with no $t_F$ qualification and no pointer to the refutation. **Both are uncorrected. The refutation is in a banner at [bispectral.md](../findings/bispectral.md):73–79 (a different file) and in [REVIEW_r479.md](../reviews/REVIEW_r479.md) §2 and [REVIEW_r480.md](../reviews/REVIEW_r480.md) Finding 3.** This is the record's signature failure in its purest form: the correction is beside the statement, in another file, and every citation of the canon inherits the defect.

**One further reading of the operative clause that the banner gets right and the canon does not.** *"Off the diagonal family it loses to the one-line $\tfrac32(M_++m)$"* is a universal over the complement of a proper subvariety. §7's chain shows the coupling's right-hand side exceeds the one-line bound's whenever $\tfrac92C(1-s)>\tfrac32C$, i.e. $s<\tfrac23$; but at $s$ near $1$ the coupling is exact and the one-line bound is strictly loose at **every** unit Weyl tensor (equality would need every $\mu_i\in\{0,M_+\}$, whence $\mu_i^2=M_+\mu_i$ termwise and $p_2(\mu)=M_+\sum\mu=0$, against $p_2(\mu)=1$). By continuity in a fixed frame the coupling therefore beats the one-line bound on a neighbourhood of the diagonal family, and that neighbourhood meets the complement of a locus of dimension at most $\tfrac{n(n-3)}2+\tfrac{n(n-1)}2=n^2-2n$ inside $\dim\mathrm{Weyl}_n$ ($8<10$ at $n=4$, $15<35$ at $n=5$). **So the clause is false as a universal, and the canon prints it as one.**

## 10. Compare the forms

| where | what it says | how it differs |
| --- | --- | --- |
| [findings/bispectral.md](../findings/bispectral.md):85–95 | statement, both routes, equality clause, "what it costs" numerics, $\square$ | the $\square$ is placed after the numerical paragraph, so the QED closes a measurement rather than the proof, which ends a paragraph earlier |
| [findings/bispectral.md](../findings/bispectral.md):40–56 | the same derivation in context, plus the penalty decomposition | **only here** is it said that the penalties are the gap to $\theta_{\mathrm{diag}}$ and not to $\theta$, and that the discarded remainder is sign-indefinite |
| [findings/bispectral.md](../findings/bispectral.md):71–81 | the audit banner: bound confirmed, headline refuted, second display, $t_F<\tfrac43$, F26 subsumption | sits **above** the block it corrects; a reader who arrives at the block from [results.md](../results.md)'s "Proof:" pointer lands below it |
| [results.md](../results.md):721 | dictionary, Schur, convexification, display, "if and only if" | **drops H1 (the normalisation), H3, the penalty decomposition, the sign-indefinite remainder, the second display, and every correction.** The "if and only if" is printed with no repair |
| [results.md](../results.md):248 | headline + *"identity on the diagonal family and, off it, loses to a one-line estimate and to the moment relaxation"* | the landscape line; carries the refuted universal with no $t_F$ qualification |
| [lean/INDEX.md](../lean/INDEX.md):120 | L52 row, **partial** | see below |

**The Lean layer against its index row, GAP.**

- [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean) proves `row_jensen`, `sum_collapses`, `diagonal_le_spectrum`, `equality_forces_rowwise`, `permutation_gives_equality`. **It does not prove "each row tight $\Rightarrow$ $P$ is a permutation"**, the step §4.2 shows to be false. The index row nevertheless narrates that step as done: *"for strictly convex $g$ that makes each row a point mass, so $U$ is a permutation, which is the block's 'both operators diagonal in one shared frame'"*. **The file is honest; the row is not.** What the file actually closes is one implication (`equality_forces_rowwise`) and its converse at a permutation (`permutation_gives_equality`), the two ends of a bridge whose span is missing, and the missing span is the false step.
- **The two Lean files do not compose.** `diagonal_le_spectrum` and `row_jensen` take `hg : ConvexOn ℝ Set.univ g`, convexity on **all** of $\mathbb R$. L52's $g(t)=t^3+3mt^2$ is convex only on $[-m,\infty)$, which is the whole point of the block's *"majorization alone bounds nothing, $t^3$ being neither convex nor concave"*. [CubicConvexity.lean](../lean/HamiltonsCubic/Results/CubicConvexity.lean) correspondingly proves only the **two-point** inequality under `-m < x`, `-m < y`. **So the index row's claim that "[DoublyStochastic](../lean/HamiltonsCubic/Results/DoublyStochastic.lean) closes the majorization step by Jensen" and "the strict convexity it needs is [CubicConvexity](../lean/HamiltonsCubic/Results/CubicConvexity.lean)" describes a composition the hypotheses forbid.**
- `threshold_nonempty : (4 : ℚ)/3 < 2` carries the docstring *"The coupling loses exactly below `t_F = 4/3`"*. The theorem says $\tfrac43<2$. **The docstring asserts §8's unargued biconditional above a triviality.**
- `penalty_antitone` proves the **penalty** is decreasing in $t$. Post F26's subsumption needs the **whole bound** $s^{3/2}\Theta_n+\tfrac92C(1-s)$ to be decreasing, which is a different statement and needs $\tfrac32\Theta_n\sqrt s<\tfrac92C$. The row's *"the penalty vanishes at $t_F=2$ and is strictly decreasing below it, which is exactly post F26's class"* substitutes the first for the second.
- **No Lean row states the lemma.** `cap_identity`, `two_valued_impossible`, `strictly_loose`, `Mm_sq`, `penalty_sum_sq`, `penalty_sum_bracket`, `diagonal_locus_proper` are all counts from the *audit*, not the lemma. **What an honest L52 row would have to claim:** the inequality of §2 with H1, H2, H4, H5 explicit; the equality clause with **H3** explicit; and the two owed steps of §4.2 named as owed rather than narrated as done.

## 11. The edge of every range

| edge | what happens | finding |
| --- | --- | --- |
| $\ker W\ne0$, i.e. $0\in\mu$ or $0\in\omega$ | $0<M_+$ and $0>-m$ always (§1, H4/H5), so a zero eigenvalue sits in the **interior** of both convexity intervals. Nothing in the derivation inverts either operator | **no finding** for the inequality. But a kernel is multiplicity, and multiplicity is exactly where §4.2's Jensen step fails, so $\ker W\ne0$ is the standing case of the broken step, not an exception to it |
| $\omega_i=-m$ attained | $f''=6(t+m)=0$ there. $f$ is still strictly convex on the closed $[-m,\infty)$, since two-point strictness needs $x+y+u+3m>0$ and $x=-m$, $y>-m$, $u>-m$ give $>0$ | **no finding** analytically. **[CubicConvexity.lean](../lean/HamiltonsCubic/Results/CubicConvexity.lean) hypothesises `-m < x` strictly**, so the Lean layer does not cover the attained endpoint the record's `≥` allows |
| $\mu_i=M_+$ attained | symmetric; $h$ strictly concave on the closed $(-\infty,M_+]$ | no finding |
| $M_+$ or $m$ taken slack | the inequality only weakens; **the equality clause is unaffected** (§4.1) | no finding, and this robustness is not recorded anywhere |
| $t_F=0$ ($K=0$) | first display gives $\theta\le\tfrac92(M_++m)=3O$, three times the one-line bound; second display agrees. The $\psi$-eigenbasis H3 is then *entirely* ambiguous, $\mathbf1^\perp$ being one degenerate eigenspace | **the "any orthonormal frame" phrasing is most misleading precisely here**, where $K'$ is least determined |
| $t_F=2$ | both penalties vanish, bound $=\theta=\theta_{\mathrm{diag}}$, and $W$ is coordinate-diagonal in that frame ([Lemma L94](../findings/bispectral.md)) | the only point where the second display closes anything (§7.2) |
| smallest admissible $n$ | $n=4$: $\lvert K\rvert=\binom42=6$, $\lvert K'\rvert=\dim S^2_0=9=6+3$ with $n-1=3$ $\psi$'s; both majorizations are between equal-length vectors. $\dim\mathrm{Weyl}_4=10>n^2-2n=8$ | **no finding**; note [L52.lean](../lean/HamiltonsCubic/Results/L52.lean)'s `diagonal_locus_proper` assumes `5 ≤ n`, though the count already holds at $n=4$, the Lean statement is weaker than the truth, not wrong |
| parity of $n$ (second display only) | $\Theta_n$ differs from $\theta_0(n)$ at odd $n$; the display is correct at both **only** because $\Theta_n$ is defined as the diagonal maximum at both | **H6 is unstated**, and the record's own history shows this symbol carried a wrong value until 2026-09-04 |

## 12. The gap between what is proven and what is used, what a consumer may cite

**May be cited, unconditionally:**

> In any orthonormal frame of $\mathbb R^n$ and any orthonormal basis of $S^2_0$ adapted to it, with $\lVert M\rVert_F=1$, $\mu_i\le M_+$ and $\omega_i\ge-m$, $$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big].$$

**May be cited with H3 written into the statement**, the $\psi$-block an eigenbasis of $K$ on $\mathbf1^\perp$:

> the penalty collapse $\text{bound}-\theta_{\mathrm{diag}}=\tfrac92(M_++m)(1-t_F/2)$, and the second display $\theta\le(t_F/2)^{3/2}\Theta_n+\tfrac92(M_++m)(1-t_F/2)$ with $\Theta_n$ the diagonal maximum at both parities.

**May not be cited:**

- *"exact if and only if both operators are diagonal in one shared frame"*, the "if" half is false without H3 (§3), and the "only if" half's argument is incomplete in the Karamata route and false in the Jensen route (§4).
- *"the two spectra do not couple usefully through a shared frame"*, refuted on the page that proves the bound (§9).
- *"off it, loses to a one-line estimate and to the moment relaxation it was built to improve"* as a universal (§9).
- *"a reduction of Conjecture A to a lower bound on $t_F$"*, §7.
- *"loses exactly when $t_F<\tfrac43$"*, §8.

**The gap in one line:** what is proven is one inequality; what is used, eight times over, is a route verdict the inequality does not reach and a rigidity clause whose statement is under-specified.

## 13. Verdict

**BROKEN.**

- The **inequality** is **PROVEN**, by either route, with every convexity direction correct on the range it is asserted on.
- The **equality clause** is **BROKEN as written**: its "if" direction fails under the block's own definition of $K'$, and its "only if" direction is supported by one strictness claim where two are needed (Karamata route) and by a false inference (Jensen route).
- The **headline** carried at [results.md](../results.md):248 and :721 is **BROKEN**, refuted by a proof on the same findings page, and uncorrected in both canonical locations.
- The **second display** is **PROVEN** in its penalty term and in its leading term, but the derivation lives only in [REVIEW_r480.md](../reviews/REVIEW_r480.md); the consequence the record draws from it is **BROKEN** (§7).

**Sources.** [NPW Prop 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md) and [Li's convention](../references/li-2021-nonnegative-second-kind/README.md) were read on file. **Schur's theorem and Karamata/Hardy–Littlewood–Pólya with its equality case have no entry in [references/](../references/)**; those two claims rest on unread sources, though the Jensen route in the block and in [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean) discharges the first for the inequality.

**Named-trap sweep.** I read [results.md](../results.md):721 and :248 in isolation, without the findings page. A consumer who does the same gets: a correct inequality with its normalisation hypothesis missing, an "if and only if" whose forward half is false, and a title asserting a negative that the body does not argue and the record refutes elsewhere. **Every one of the corrections that would repair this is filed beside the statement rather than in it.**

**What would break these findings.** For §3, a sentence anywhere in the block or the canon fixing the $\psi$-basis, I grepped both files and found it only at [bispectral.md](../findings/bispectral.md):477 and [conventions.md](../findings/conventions.md):22, in other blocks. For §4.2, a doubly stochastic $P$ with all rows tight in Jensen at a *degenerate* $\mu$ that is nevertheless forced to be a permutation, the $3\times3$ rotation above is a counterexample, so no such forcing exists. For §7, a configuration escaping $\tfrac{1-u^3}{1-u^2}\le\tfrac32$, the ratio attains $\tfrac32$ at $u=1$, so the constant is exact and there is no escape. For §9, a reading of *"do not couple usefully"* under which the boxed cap at [bispectral.md](../findings/bispectral.md):276 is not a shared-frame coupling, the cap is evaluated in $\mathring W$'s bottom eigenvector's own frame and bounds $\omega_{\min}$ by a $\mu$-side budget through $K^F$, which is the definition.
