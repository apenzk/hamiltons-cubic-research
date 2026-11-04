# Reviewer r410, Gate 2 on "L16's $J_5$ grant reduces to the condition number of $\mathrm{Ric}(|W|)$"

*Target: [ATTEMPTS.md](../ATTEMPTS.md) §"L16's $J_5$ grant reduces to the condition number of $\mathrm{Ric}(|W|)$" (lines 3830–3843, commit `91a5db4`). Route [R17](../routes.md), Conjecture [L16](../plan.md). **Analysis only**, no run was made; the one numerical statement below is arithmetic on a hand-built configuration and is reported as a screen.*

## Verdict

**The reduction does not hold, and it is not new.** Its own inequality, evaluated at $\kappa=1$, does not become trivial, it becomes a $\kappa$-free inequality about $C$'s block masses against the block *dimensions*, and that inequality is false at three comparable blocks. So "$\kappa$ small enough" is not sufficient for $J_5\ge0$ by this argument, and the section cannot prove even the case Theorem B already proves. Independently, $\kappa(\mathrm{Ric}(|W|))$ is **unbounded** on the catalogued critical set, it equals $q/p$ at $S^p\times S^q$, which follows from the record's own $K=n/(2p)$ at [ATTEMPTS.md](../ATTEMPTS.md) §"The Ricci spread $K$" (line 1272), so "$\kappa$ small enough" is a false statement about critical points, not a reduced form of a true one. And that section had already named the identical question as its own open target.

| # | Claim | Verdict |
| --- | --- | --- |
| I1 | $A\succeq0\Rightarrow\lVert A_{bc}\rVert_F\le\sqrt{\mathop{\mathrm{tr}}A_{bb}\mathop{\mathrm{tr}}A_{cc}}$ | **CONFIRMED** |
| I2 | "Applied to $C$ this is **exactly** the record's Theorem C" | **REFUTED**, Theorem C as recorded is not homogeneous in $H$ |
| I3 | $\lvert\mathrm{cross}\rvert\le4\sum_{b\ne c}\sqrt{m_bh_bm_ch_c}$, and its closed form | **CORRECTED**, valid, but not sharp where it must be; a free strengthening is given below |
| I4 | $J_5^{\mathrm{diag}}\ge\sum_b\lambda_{\min}(H_{bb})\mathop{\mathrm{tr}}X_{bb}$, every $X_{bb}\succeq0$ | **CONFIRMED**, the PSD hypothesis is on record, Result 5(a) |
| I5 | "the grant is a comparison of $\mathop{\mathrm{tr}}H_{bb}$ against $\lambda_{\min}(H_{bb})$, a block condition number of $H$, **and nothing else**" | **REFUTED**, witness below |
| I6 | $H$ is diagonal in $h$'s eigenbasis with eigenvalues $h_i+h_j$ | **CONFIRMED**, and **not novel**, Result 8 already uses it |
| I7 | $\lambda_{\max}(H)/\lambda_{\min}(H)\le\kappa(\mathrm{Ric}(|W|))$ | **CONFIRMED** |
| I8 | "the open grant is: $\kappa(\mathrm{Ric}(|W|))$ small enough" | **REFUTED**, does not follow, and is false at catalogued points |
| I9 | "the three-block factor the record calls the gap **is** a condition number" | **REFUTED**, it is a pair count times a block dimension |
| I10 | "a different kind of question from anything else this session asked" | **REFUTED** as novelty, it is [ATTEMPTS.md](../ATTEMPTS.md) line 1272's own stated target |

**Progress or relabelling: relabelling**, with one real by-product (I3's corrected form). The gap the section claims to have named was already named, in the same object, with a negative answer attached.

## Part 1, what I derived before reading the section

Recorded first in [agent_logs/gate2-j5-B.log](../agent_logs/gate2-j5-B.log), phase 1.

**(a) The sharp PSD off-diagonal bound.** For $A\succeq0$ and orthogonal projections $P_b$, the compression $\begin{pmatrix}A_{bb}&A_{bc}\\A_{cb}&A_{cc}\end{pmatrix}$ is PSD, so $A_{bc}=A_{bb}^{1/2}KA_{cc}^{1/2}$ with $\lVert K\rVert_{\mathrm{op}}\le1$. Hence $\lVert A_{bc}\rVert_F^2=\mathop{\mathrm{tr}}(K^*A_{bb}KA_{cc})\le\lambda_{\max}(A_{cc})\mathop{\mathrm{tr}}A_{bb}$, and symmetrically,
$$\lVert A_{bc}\rVert_F^2\ \le\ \min\big(\lambda_{\max}(A_{bb})\mathop{\mathrm{tr}}A_{cc},\ \lambda_{\max}(A_{cc})\mathop{\mathrm{tr}}A_{bb}\big)\ \le\ \mathop{\mathrm{tr}}A_{bb}\mathop{\mathrm{tr}}A_{cc},$$
tight at $A=vv^*$, $v=(u_b,u_c)$. **The record's $\sqrt{m_bm_c}$ is the crude corner of this**, and it loses a factor $\sqrt{\text{effective rank}}$ whenever a diagonal block is spread out. Sharper still, and this is the step the section misses: $A-\lambda_{\min}(A)\,\mathrm{Id}\succeq0$ has the **same** off-diagonal blocks, so
$$\lVert A_{bc}\rVert_F^2\ \le\ \big(\mathop{\mathrm{tr}}A_{bb}-d_b\lambda_{\min}(A)\big)\big(\mathop{\mathrm{tr}}A_{cc}-d_c\lambda_{\min}(A)\big).\tag{$\star$}$$

**(b) $\mathrm{Ric}^*$, derived rather than fitted.** With $\mathrm{Ric}(R)_{ik}=\sum_jR_{ijkj}$ and $\{e_i\wedge e_j\}_{i<j}$ orthonormal, expanding $\tfrac14\sum_{ijkl}R_{ijkl}(h\odot\delta)_{ijkl}$ for the four-term Kulkarni–Nomizu product $(h\odot\delta)_{ijkl}=h_{ik}\delta_{jl}-h_{il}\delta_{jk}-h_{jk}\delta_{il}+h_{jl}\delta_{ik}$ gives four copies of $\sum_{ijk}h_{ik}R_{ijkj}$, so $\mathrm{Ric}^*(h)=h\odot\delta$ **exactly, as an identity, for every symmetric $R$**. Its matrix entries on $\{e_i\wedge e_j\}$ in an eigenbasis of $h$ are $(h\odot\delta)_{ijij}=h_i+h_j$ with all off-diagonal entries zero, so $\mathop{\mathrm{spec}}(H)=\{h_i+h_j\}_{i<j}$. This upgrades Result 6's numerically fitted coefficient $1.0000000000$ to a two-line proof, and it confirms the section's normalisation: the record's $h\wedge2\,\mathrm{id}$ agrees only under the half-convention $(h\wedge k)(x\wedge y)=\tfrac12(hx\wedge ky+kx\wedge hy)$, which is what the section's own displayed action $x\wedge y\mapsto hx\wedge y+x\wedge hy$ uses. **No normalisation error.**

**(c) $h\succeq0$**, hence $H\succeq0$: $\langle hv,v\rangle=\sum_j\langle|W|(v\wedge e_j),v\wedge e_j\rangle\ge0$. Confirms Result 5(b) by a shorter route.

**(d) The block-free criterion.** Writing $h=\lambda_{\min}(h)\mathrm{Id}+h'$ gives $H=2\lambda_{\min}(h)\mathrm{Id}+\mathrm{Ric}^*(h')$ with $\lambda_{\max}(\mathrm{Ric}^*(h'))\le2\lVert h'\rVert_{\mathrm{op}}$, so
$$J_5\ \ge\ 2\lambda_{\min}(h)\mathop{\mathrm{tr}}X_{\mathrm{inv}}-2\lVert h'\rVert_{\mathrm{op}}\lVert X_{\mathrm{inv}}\rVert_*\quad\Longrightarrow\quad J_5\ge0\ \text{ whenever }\ \kappa(h)-1\le\frac{\mathop{\mathrm{tr}}X_{\mathrm{inv}}}{\lVert X_{\mathrm{inv}}\rVert_*}.$$
**This needs no block decomposition at all.** It is the correct shape of a $\kappa$-criterion: the right-hand side is $\le1$, is $1$ exactly when $X_{\mathrm{inv}}\succeq0$, and the criterion is *satisfied* at $\kappa=1$. Any $\kappa$-criterion that is not satisfied at $\kappa=1$ is wrong, which is the test the section fails.

## Part 2, the refutation of I5 and I8

**The blocks are three, and they are $P_+$, $P_-$, $P_0$**, the spectral blocks of $W$ on $\Lambda^2$ (Result 5(a), [ATTEMPTS.md](../ATTEMPTS.md) line 888). Write $d_b=\dim$ of block $b$, so $d_++d_-+d_0=\binom n2$; every $d_b$ is large, of order $n^2$.

**The dropped factor is $d_b$.** The section compares $\mathop{\mathrm{tr}}H_{bb}$ with $\lambda_{\min}(H_{bb})$ and calls the ratio a condition number. It is not: interlacing gives $\lambda_{\min}(H_{bb})\ge\lambda_{\min}(H)$ and $\lambda_{\max}(H_{bb})\le\lambda_{\max}(H)$, so $\kappa(H_{bb})\le\kappa(H)$, but the quantity that actually enters is
$$h_b:=\mathop{\mathrm{tr}}H_{bb}\ \le\ d_b\,\lambda_{\max}(H_{bb})\ \le\ d_b\,\kappa(H)\,\lambda_{\min}(H_{bb}).$$
**The block dimension $d_b$ appears in every step and is named nowhere in the section.** It does not cancel, because the diagonal side of the comparison carries one factor per block and the cross side carries one per *ordered pair*.

**Witness, the section's criterion at $\kappa(H)=1$.** Assemble the section's own two inequalities into the sufficient condition it asserts:
$$\sum_b\lambda_{\min}(H_{bb})\mathop{\mathrm{tr}}X_{bb}\ \ge\ 4\sum_{b\ne c}\sqrt{m_bh_bm_ch_c}.\tag{S}$$
Put $H=c\,\mathrm{Id}$, the case the section says $\kappa$ measures. Then $\lambda_{\min}(H_{bb})=c$ and $h_b=c\,d_b$, and **$c$ cancels from both sides**, leaving
$$\mathop{\mathrm{tr}}X_{\mathrm{inv}}\ \ge\ 4\sum_{b\ne c}\sqrt{m_bd_bm_cd_c},$$
an inequality in which **$H$ does not appear at all**. Take three blocks of equal dimension $d$ and equal mass $m_b=m$, and grant the section its most favourable possible diagonal side $\mathop{\mathrm{tr}}X_{bb}=4m_b$ (true only on the $+$ block, see below). Left side $12m$; right side $4\cdot6\cdot md=24md$. **(S) fails for every $d\ge1$, by a factor $2d$**, and $d\sim n^2/6$ in the real setting, so by a factor of order $n^2$. *Reported as a screen: this is arithmetic on a configuration I constructed, not a measurement at a critical point.*

So the section's inequality **cannot prove its own $\kappa=1$ case**, which Theorem B proves outright by $H_{\mathrm{cross}}=0$. The reason is structural and is worth stating plainly: **the bound $4\sum_{b\ne c}\sqrt{m_bh_bm_ch_c}$ does not vanish when $H$ is scalar, although $\mathrm{cross}$ does.** A bound that is insensitive to the exact configuration it is supposed to be measuring the distance from cannot deliver a criterion in that distance. I5 and I8 are refuted.

**I9 follows.** The "three-block factor" is not a condition number. It is the count $\binom32\cdot2=6$ ordered off-diagonal pairs against $3$ diagonal terms, multiplied by the block dimension $d_b$ that ($\star$)-free Cauchy–Schwarz leaves in. At two blocks the pair count gives equality and the bound closes; at three it is short, which is exactly what "three blocks short" in [plan.md](../plan.md) line 51 records. **The record's own phrase was already the correct diagnosis, and it is combinatorial.**

## Part 3, the repair, and why it still does not reduce the grant

The fix is one line and the section is adjacent to it. Set $\lambda:=\lambda_{\min}(H)$ and $\hat h_b:=\mathop{\mathrm{tr}}H_{bb}-\lambda d_b\ge0$. Since $H-\lambda\,\mathrm{Id}\succeq0$ has the same cross blocks as $H$, applying the section's own PSD lemma to it (that is, ($\star$)), gives the strictly stronger and correctly-vanishing bound
$$\lvert\mathrm{cross}\rvert\ \le\ 4\sum_{b\ne c}\sqrt{m_bm_c\,\hat h_b\hat h_c}\ =\ 4\Big[\Big(\sum_b\sqrt{m_b\hat h_b}\Big)^2-\sum_bm_b\hat h_b\Big],$$
which **is** zero when $H$ is scalar. With $\hat h_b\le d_b\lambda(\kappa(H)-1)$ and $J_5^{\mathrm{diag}}\ge\lambda\mathop{\mathrm{tr}}X_{\mathrm{inv}}$, the honest criterion is
$$\boxed{\ \kappa(\mathrm{Ric}(|W|))\ \le\ 1+\frac{\mathop{\mathrm{tr}}X_{\mathrm{inv}}}{4D},\qquad D:=\Big(\sum_b\sqrt{m_bd_b}\Big)^2-\sum_bm_bd_b.\ }$$

**But this is not a reduction either, and its own scaling says so.** Under the equal-block hypothesis above, $D\approx6md$ and $\mathop{\mathrm{tr}}X_{\mathrm{inv}}\lesssim12m$, so the criterion reads $\kappa-1\lesssim1/(2d)=O(n^{-2})$. **The repaired criterion demands that $\mathrm{Ric}(|W|)$ be scalar to within $O(n^{-2})$**, Theorem B's hypothesis with an epsilon, not a weakening of it. *Stated as a scaling estimate under an explicit equal-mass, equal-dimension hypothesis, not as a theorem.*

## Part 4, is $\kappa(\mathrm{Ric}(|W|))$ bounded at a general critical point? The record already answered

**Yes, and the answer is no.** [ATTEMPTS.md](../ATTEMPTS.md) §"The Ricci spread $K$, no uniform bound, but it is anti-correlated with $\theta$" (line 1272) studies $K:=n\lambda_{\max}(\mathrm{Ric}(W_-))/\mathop{\mathrm{tr}}\mathrm{Ric}(W_-)$, the max-over-mean spread of exactly this matrix: $\mathrm{Ric}(|W|)=2\,\mathrm{Ric}(W_-)$ by Result 11, so $\kappa(\mathrm{Ric}(|W|))=\kappa(\mathrm{Ric}(W_-))$ and
$$\kappa(\mathrm{Ric}(|W|))\ \ge\ \frac{\lambda_{\max}}{\text{mean}}\ =\ K.$$
That section's headline is **"$K$ grows linearly, and the maximum is exactly $n/4$"**, attained at $S^2\times S^{n-2}$, with a proven ceiling $K\le n/2$ and the explicit family value $K=n/(2p)$ at $S^p\times S^q$, $p\le q$.

**The exact value of $\kappa$ on that family, derived from the record's own formula.** At a product $h$ is scalar on each factor, $h=\alpha P_1+\beta P_2$ with $\alpha\ge\beta$. Then $K=\alpha n/(p\alpha+q\beta)$, and setting this equal to $n/(2p)$ forces $p\alpha=q\beta$, so
$$\kappa(\mathrm{Ric}(|W|))\big|_{S^p\times S^q}\ =\ \frac{\alpha}{\beta}\ =\ \frac qp,\qquad\text{hence } \frac{n-2}2\ \text{ at } S^2\times S^{n-2}.$$
So $\kappa$ is **unbounded over the catalogued critical set, growing linearly in $n$**, while $J_5\ge0$ holds there. "$\kappa$ small enough" is therefore not the grant restated; it is a strictly stronger statement that is *false* at critical points the record has certified ([ATTEMPTS.md](../ATTEMPTS.md) Result 12, sphere splits at $n=8,12,14$).

**And the section's novelty claim fails on the same page.** Line 1272's "Consequence for the route" reads: *"Do not seek a uniform bound on $K$, it is false. Seek instead the joint constraint … a proof that $K>1+\epsilon$ forces $\theta$ below $\sqrt{3/2}$ directly."* That is precisely the question the new section proposes as "a different kind of question from anything else this session asked, and the one L16 needs", same object, same quantity, already open, already reformulated, with an anti-correlation observation ("every high-$\theta$ point has $K\approx1$") that is the only genuine encouragement in the neighbourhood and that the new section does not cite.

**The screen missed it.** The section records screening "against [INDEX-traps.md](../findings/INDEX-traps.md) first … then by expression". Line 1272 is neither a fence post nor an expression match for $\kappa$, it is spelled $K$ and called a *spread*. This is item 3 of [findings/INDEX.md](../findings/INDEX.md)'s own usage rule firing again: the search used the vocabulary of the construction rather than the value.

## Part 5, I2, I3, I4, I6, I7 in detail

**I1 CONFIRMED.** $A_{bc}=(P_bS)(SP_c)$ with $A=S^2$, then $\lVert XY\rVert_F\le\lVert X\rVert_F\lVert Y\rVert_{\mathrm{op}}$ and $\lVert P_bS\rVert_F^2=\mathop{\mathrm{tr}}A_{bb}$. Correct, and it is my (a) restricted to $K=\mathrm{Id}$.

**I2 REFUTED, a homogeneity witness.** $\mathrm{cross}=\langle X_{\mathrm{cross}},H_{\mathrm{cross}}\rangle$ is **linear in $H$**. Theorem C as recorded ([ATTEMPTS.md](../ATTEMPTS.md) line 930) is $\lvert\mathrm{cross}\rvert\le8\sum_{b<c}\sqrt{m_bm_c}$ with $m_b=\mathop{\mathrm{tr}}C_{bb}$, which contains no $H$ at all: replace $H$ by $tH$ and the left side scales by $t$ while the right side is fixed, so the statement is false for $t$ large. Either Theorem C is missing a factor $\lVert H_{bc}\rVert_F$, in which case the new section's "**exactly** the record's Theorem C" is wrong, and its bound is a genuine correction rather than a re-derivation, or $m_b$ is not $\mathop{\mathrm{tr}}C_{bb}$, in which case the section's identification is wrong for the other reason. **Either way the identification claim fails, and Theorem C's recorded statement needs a factor restored.** *This is the one place where the section is doing more than it says: its bound is right and the thing it claims to reproduce is not.*

**I3 CORRECTED.** The chain $\lvert\mathrm{cross}\rvert=4\lvert\langle C_{\mathrm{cross}},H_{\mathrm{cross}}\rangle\rvert\le4\sum_{b\ne c}\lVert C_{bc}\rVert_F\lVert H_{bc}\rVert_F$ is right, and the closed form is right: with $t_b=\sqrt{m_bh_b}$, $\sum_{b\ne c}t_bt_c=(\sum t_b)^2-\sum t_b^2$. Superseded by the $(\star)$-shifted form in Part 3.

**I4 CONFIRMED, hypothesis on record.** $\langle X_{bb},H_{bb}\rangle\ge\lambda_{\min}(H_{bb})\mathop{\mathrm{tr}}X_{bb}$ requires $X_{bb}\succeq0$, which is **proved** at all three blocks, $P_+X P_+=4P_+CP_+$, $P_-XP_-=2P_-(W_+^\#+W_-^\#)P_-$, $P_0XP_0=P_0|W|^\#P_0$, each PSD by the $\#$-calculus (Result 5(a), with one-line proofs at Result 3). **No silent hypothesis here.**

**But the comparison in step 4 is between non-comparable quantities**, the brief's priority 2, and the answer is that it is not. $m_b=\mathop{\mathrm{tr}}C_{bb}$ and $\mathop{\mathrm{tr}}X_{bb}$ coincide up to the factor $4$ **only on the $+$ block**. On the $-$ block $\mathop{\mathrm{tr}}X_{--}=2\mathop{\mathrm{tr}}(W_+^\#+W_-^\#)_{--}$ and on the $0$ block $\mathop{\mathrm{tr}}X_{00}=\mathop{\mathrm{tr}}(|W|^\#)_{00}$; neither is $4m_b$ and nothing in the section relates them to $m_-$ or $m_0$. So (S)'s two sides are indexed by the same three blocks but measure different objects on two of them, and the ratio $\mathop{\mathrm{tr}}X_{bb}/m_b$ is uncontrolled. **This is a second, independent reason the comparison is not "a condition number and nothing else".** *In the witness above I granted $\mathop{\mathrm{tr}}X_{bb}=4m_b$ on all three blocks, so the witness is not sensitive to this point, it makes matters worse, not better.*

**I6 CONFIRMED, NOT NOVEL.** The spectrum $\{h_i+h_j\}$ is correct (Part 1(b)). But **the record already has it**: Result 8's proof of the lifted Lemma 3.4.6 turns on "*in an orthonormal eigenbasis of $\mathrm{Ric}$, both $\mathrm{Ric}\wedge\mathrm{Ric}$ and $\mathrm{Ric}\wedge2\,\mathrm{id}$ are diagonal on the induced basis of $\Lambda^2$*", which is this fact, and the identity $\mathrm{Ric}^*(h)=h\wedge2\,\mathrm{id}$ is Result 6. **The section's "which is computable, because $H$'s spectrum is $h$'s doubled" restates two established results.** Nothing is lost by that, but it is not the step that was missing.

**I7 CONFIRMED.** $\lambda_{\max}(H)/\lambda_{\min}(H)=(h_{(n-1)}+h_{(n)})/(h_{(1)}+h_{(2)})\le\max(h_{(n-1)}/h_{(1)},h_{(n)}/h_{(2)})\le h_{\max}/h_{\min}$ by the mediant inequality. *Note it is a genuine inequality, often strict: $H$ is better conditioned than $h$, so routing through $\kappa(h)$ discards something.*

## Silently used hypotheses

1. **$d_b$, the block dimension, is dropped.** $\mathop{\mathrm{tr}}H_{bb}\le d_b\kappa(H)\lambda_{\min}(H_{bb})$ is the only route from the section's stated comparison to $\kappa$, and $d_b\sim n^2$. **This is the decisive omission**, Part 2's witness is exactly it.
2. **$\mathop{\mathrm{tr}}X_{bb}\propto m_b$ uniformly across blocks**, true only on $P_+$.
3. **$\lVert H_{bc}\rVert_F\le1$**, needed for I2's identification with Theorem C, never stated anywhere.
4. **$\lambda_{\min}(\mathrm{Ric}(|W|))>0$.** $h\succeq0$ is proved; $h\succ0$ is not. If $h$ has a two-dimensional kernel then $\lambda_{\min}(H)=0$ and $\kappa=\infty$, and the whole criterion is vacuous. Nothing on record excludes it.
5. **The restriction to the non-commuting remainder is dropped.** The criterion is stated as "the open grant", unrestricted; on the commuting class it is not needed, and there $\kappa$ is provably large (Part 4). The honest statement is "$[H,W]=0$ **or** $\kappa$ small", which is a disjunction of two special cases, not a reduction.
6. **Notation collision.** $\kappa$ already denotes two other things in this record, the Killing constant $\kappa(\mathfrak h)$ ([findings/ungraded-slack.md](../findings/ungraded-slack.md)) and the frame-invariant diagonal spread $\kappa(W)=\max_F\lVert K(F)\rVert_F$ ([findings/bispectral.md](../findings/bispectral.md) line 204). A third meaning in the same file invites exactly the convention accident [post F53](../findings/second-order.md) records as having cost two cycles.

## What survives, and what should replace the section

**Keep.** The observation that the PSD lemma was applied to $C$ and never to $H$ is correct and worth having; the corrected bound is Part 3's $(\star)$-shifted form, $\lvert\mathrm{cross}\rvert\le4\sum_{b\ne c}\sqrt{m_bm_c\hat h_b\hat h_c}$ with $\hat h_b=\mathop{\mathrm{tr}}H_{bb}-d_b\lambda_{\min}(H)$, which is strictly stronger than both Theorem C and the section's bound and vanishes with $H_{\mathrm{cross}}$. That is the section's one deliverable.

**Retire.** "The grant reduces to $\kappa(\mathrm{Ric}(|W|))$ small enough", and with it the identification of the three-block factor as a condition number. **Record instead**, as a fence: *no bound of the form $\lvert\mathrm{cross}\rvert\le f(m_b,\mathop{\mathrm{tr}}H_{bb})$ can close the $J_5$ grant, because any such $f$ is positive when $H$ is scalar and $\mathrm{cross}$ is zero. The cross term must be bounded through a quantity that vanishes with $H_{\mathrm{cross}}$*, $\hat h_b$, or Theorem D's $\lVert[H,W]_{bc}\rVert_F$, which is the record's existing certificate and already has this property. **Theorem D is therefore the stronger instrument, not the one the section supersedes**, and the live question is whether $\lVert[H,W]\rVert$ admits a bound at a general critical point, the same shape as line 1272's open target, and the honest successor to this section.

*Reviewer r410, 2026-09-03. Analysis only; no computational run was made.*
