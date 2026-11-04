# Review r409, Gate 2 on "L16's $J_5$ grant reduces to the condition number of $\mathrm{Ric}(|W|)$"

*Cold brief. Steps 1–5 were re-derived from the definitions before [run_j5cross_proof.py](../scripts/runs/run_j5cross_proof.py) was opened; the derivation order is in [agent_logs/gate2-j5-A.log](../agent_logs/gate2-j5-A.log). **Analysis only**, no run was opened. One screen was taken on matrices constructed for the purpose (two random PSD $10\times10$ operators, one $4{+}6$ block split), reported below as a screen and used only to confirm a factor already derived in closed form. Target: the final section of [ATTEMPTS.md](../ATTEMPTS.md).*

## Verdicts

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | For PSD $A$, $\lVert A_{bc}\rVert_F\le\sqrt{\mathop{\mathrm{tr}}A_{bb}\mathop{\mathrm{tr}}A_{cc}}$ | **CONFIRMED** as an inequality. **CORRECTED as the right tool**, the mixed-norm/contraction form is needed, and the record already uses it |
| 2 | "Applied to $C$ this IS the record's Theorem C, and it was never applied to $H$" | **REFUTED.** Theorem C's $m_b:=\mathop{\mathrm{tr}}(C_{bb}H_{bb})$ **already carries $H$**, jointly. The new bound is strictly *weaker* than the one it claims to improve. The $4$-over-ordered $=8$-over-unordered arithmetic is **CONFIRMED** |
| 3 | $J_5^{\mathrm{diag}}\ge\sum_b\lambda_{\min}(H_{bb})\mathop{\mathrm{tr}}X_{bb}$ | **CONFIRMED** as an inequality; **a second gratuitous weakening** of an identity the record already has exactly |
| 4 | The grant becomes a comparison of $\mathop{\mathrm{tr}}H_{bb}$ against $\lambda_{\min}(H_{bb})$ | **REFUTED.** The quantities are comparable (the record has the exact conversion) but the resulting criterion is **unsatisfiable except at block masses unbalanced by a factor $\gtrsim4d_bd_c$**, and it fails at the scalar-$H$ points where the true cross term is $0$ |
| 5 | $H=h\wedge2\,\mathrm{id}$ is diagonal with eigenvalues $h_i+h_j$; $\lambda_{\max}(H)/\lambda_{\min}(H)\le\kappa(h)$ | **CONFIRMED**, normalisation included. **NOT NEW**, it is [Lemma B'](../ATTEMPTS.md)'s $(c_k+c_l)$ statement written in the full eigenbasis |
| 6 | "The open grant is $\kappa(\mathrm{Ric}(|W|))$ small enough", $=1$ at every named point by isotropy | **REFUTED three times over.** $\kappa=+\infty$ at Fox and the plateau, where the grant *holds*; isotropy delivers **block-scalar** $h$, not scalar, so $\kappa>1$ already at unbalanced sphere products; and step 4 produced $\mathop{\mathrm{tr}}H_{bb}/\lambda_{\min}(H_{bb})$, which is **not** a condition number, it exceeds the block dimension $d_b$ |

**The section's headline is false in the direction that matters.** It presents itself as using PSD-ness of $H$ for the first time; the record used it first, and used it better. What the section actually does is take [Theorem C](../ATTEMPTS.md), weaken both sides, and name the ratio of the weakened sides a condition number. Against [routes.md](../routes.md)'s own standard for [R17](../routes.md) (*"the record says nothing lossy will finish it"*), this is a step backwards.

## Step 1, the inequality is true, and it is the wrong one

Write $A=S^2$, $S=A^{1/2}\succeq0$. Then $A_{bc}=(P_bS)(SP_c)$, and $\lVert P_bS\rVert_F^2=\mathop{\mathrm{tr}}(P_bS^2)=\mathop{\mathrm{tr}}A_{bb}$, likewise for $c$. Sub-multiplicativity $\lVert XY\rVert_F\le\lVert X\rVert_F\lVert Y\rVert_F$ gives the stated bound. **Valid.**

But the brief's question (*mixed norm or not*), has a sharp answer, and it decides the whole section. The correct instrument for a PSD block matrix is the **contraction representation**: $\begin{pmatrix}A_{bb}&A_{bc}\\A_{cb}&A_{cc}\end{pmatrix}\succeq0$ forces $A_{bc}=A_{bb}^{1/2}\Gamma A_{cc}^{1/2}$ with $\lVert\Gamma\rVert_{\mathrm{op}}\le1$. Paired with $\lVert X\Gamma\rVert_F\le\lVert X\rVert_F\lVert\Gamma\rVert_{\mathrm{op}}$ this is *strictly stronger* than the Frobenius–Frobenius split, and (decisively), it survives being applied to two PSD objects at once without decoupling them.

**Equivalently, in one line.** Set $U_b:=C^{1/2}P_bH^{1/2}$. Then

$$\langle C_{bc},H_{bc}\rangle=\mathop{\mathrm{tr}}\!\big(C^{1/2}P_bH^{1/2}\cdot H^{1/2}P_cC^{1/2}\big)=\langle U_b,U_c\rangle,\qquad \lVert U_b\rVert_F^2=\mathop{\mathrm{tr}}(C_{bb}H_{bb}).$$

Cauchy–Schwarz on the $U$'s gives $|\langle C_{bc},H_{bc}\rangle|\le\sqrt{m_bm_c}$ with $m_b=\mathop{\mathrm{tr}}(C_{bb}H_{bb})$, **which is Theorem C exactly.** The pairing is a Gram matrix of three vectors $U_+,U_-,U_0$; that is the natural structure here, and the Frobenius–Frobenius split destroys it.

## Step 2, the section's central premise is false against the record

[run_j5cross_proof.py](../scripts/runs/run_j5cross_proof.py) states Theorem C in its own header:

> `(C)  |cross| <= 8 * sum_{b<c} sqrt(m_b m_c),   m_b := tr(C_bb H_bb) >= 0`

**So $H$ is inside $m_b$.** The claim reads $m_b$ as $\mathop{\mathrm{tr}}C_{bb}$, concludes that $H$ was never used, and "adds" it as a separate factor $\sqrt{h_bh_c}$. The two bounds are then comparable directly, since $\mathop{\mathrm{tr}}(C_{bb}H_{bb})\le\lambda_{\max}(H_{bb})\mathop{\mathrm{tr}}C_{bb}\le\mathop{\mathrm{tr}}H_{bb}\mathop{\mathrm{tr}}C_{bb}$:

$$\underbrace{8\sum_{b<c}\sqrt{m_bm_c}}_{\text{Theorem C}}\;\le\;\underbrace{8\sum_{b<c}\sqrt{\mathop{\mathrm{tr}}C_{bb}\,h_b}\sqrt{\mathop{\mathrm{tr}}C_{cc}\,h_c}}_{\text{the new bound}} .$$

**The new bound is the old one multiplied by $\sqrt{r_br_c}$, where $r_b:=\mathop{\mathrm{tr}}H_{bb}/\lambda_{\max}(H_{bb})\in[1,d_b]$ is the effective rank of $H_{bb}$.** The loss is *maximal*, $r_b=d_b$ exactly, when $H_{bb}$ is scalar, that is, in precisely the regime the section advertises as the favourable one.

*Arithmetic that does check out:* $4\sum_{b\ne c}=8\sum_{b<c}$, and $X_{\mathrm{cross}}=4C_{\mathrm{cross}}$ with $|\langle X_{bc},H_{bc}\rangle|\le4\sqrt{\cdot}$ per ordered pair, gives $8$ per unordered pair. **No double count.** The factor $4$ versus the record's $8$ is the ordered/unordered bookkeeping and is consistent.

**Screen** (constructed objects, seconds; not evidence for any positive claim). Random PSD $C,H$ on $\mathbb R^{10}$, blocks of size $4$ and $6$: the new bound is $4.9$–$5.6\times$ the Theorem C bound across four draws; with $H=3I$ the ratio is $4.899=\sqrt{4\cdot6}$ to three decimals, matching $\sqrt{d_bd_c}$ in closed form.

## Step 3, true, and the third thing thrown away

$\langle A,B\rangle=\mathop{\mathrm{tr}}(A^{1/2}BA^{1/2})\ge\lambda_{\min}(B)\mathop{\mathrm{tr}}A$ for $A,B\succeq0$, since $A^{1/2}BA^{1/2}\succeq\lambda_{\min}(B)A$. With $X_{bb}\succeq0$ (Result 5a) and $H_{bb}\succeq0$ (compression of a PSD operator), **the inequality holds**, reading $\lambda_{\min}(H_{bb})$ as the minimum over the block subspace, which is the only non-vacuous reading.

But $J_5^{\mathrm{diag}}=\sum_b\langle X_{bb},H_{bb}\rangle$ is an **identity**, and it is the identity Theorem C already compares against. Replacing it by $\sum_b\lambda_{\min}(H_{bb})\mathop{\mathrm{tr}}X_{bb}$ costs a second factor of the same shape as step 2's: $\langle X_{bb},H_{bb}\rangle/\big(\lambda_{\min}(H_{bb})\mathop{\mathrm{tr}}X_{bb}\big)$ is again bounded below by $1$ and reaches $\kappa(H_{bb})$-sized values. There is no reason to take it.

## Step 4, the comparison is between comparable quantities, and it still cannot close

The brief asks whether the section compares incomparable things. **It does not**, the conversion exists, and the record already carries it. From $|W|^\#=W^\#+4C$, $W^\#=\theta W-W^2$ at a critical point, and $W_-$ vanishing on the $+$ and $0$ blocks:

| block | $\mathop{\mathrm{tr}}X_{bb}$ | why |
| --- | --- | --- |
| $+$ | $4\mathop{\mathrm{tr}}C_{++}$ | $X_{++}=4C_{++}$ exactly |
| $0$ | $4\mathop{\mathrm{tr}}C_{00}$ | $(W^\#)_{00}=\theta W_{00}-(W^2)_{00}=0$ on $\ker W$ |
| $-$ | $4\mathop{\mathrm{tr}}C_{--}-2\mathop{\mathrm{tr}}(\theta W_-+W_-^2)$ | $X_{--}=4C_{--}-2\theta W_--2W_-^2$, the subtracted part PSD |

which is [run_j5cross_proof.py](../scripts/runs/run_j5cross_proof.py)'s own $4m_+=\langle X_{++},H_{++}\rangle$, $4m_0=\langle X_{00},H_{00}\rangle$, $4m_-=\langle X_{--},H_{--}\rangle+\rho$, $\rho:=2\langle\theta W_-+W_-^2,H\rangle\ge0$, read at $H=\mathrm{Id}$. **So the objects match up to an explicit deficit at the $-$ block, and that deficit has the unfavourable sign.**

**The criterion is nevertheless unsatisfiable.** Write $c_b:=\mathop{\mathrm{tr}}C_{bb}$, $\ell_b:=\lambda_{\min}(H_{bb})$, $h_b:=\mathop{\mathrm{tr}}H_{bb}$, and $t_b:=\sqrt{c_bh_b}$. Closing needs

$$8\sum_{b<c}t_bt_c\;\le\;\sum_b\ell_b\mathop{\mathrm{tr}}X_{bb}\;\le\;4\sum_b\ell_bc_b\;\le\;4\sum_b\frac{h_b}{d_b}c_b=4\sum_b\frac{t_b^2}{d_b},$$

using only $\ell_b\le h_b/d_b$. So a necessary condition is $2\sum_{b<c}t_bt_c\le\sum_bt_b^2/d_b$. **The quadratic form $t_b^2/d_b-2t_bt_c+t_c^2/d_c$ is PSD only when $d_bd_c\le1$**, both blocks one-dimensional, impossible for $n\ge4$ where $\dim\Lambda^2\ge6$. For fixed block masses the condition holds only outside the roots, i.e. when $t_b^2/t_c^2$ is off $1$ by a factor of order $4d_bd_c$. At $n=12$, $\dim\Lambda^2=66$, so that is a required imbalance of order $10^3$.

**And the failure is worst where the statement is easiest.** If $h$ is scalar then $H=\alpha\,\mathrm{Id}$ on all of $\Lambda^2$, so $H_{bc}=\alpha P_bP_c=0$ and $\mathrm{cross}=0$ **exactly**, yet the chain bounds $\lVert H_{bc}\rVert_F$ by $\sqrt{h_bh_c}=\alpha\sqrt{d_bd_c}$, which is $\Theta(n^2)$, and the criterion fails. *A criterion that is violated at the points where the quantity it bounds vanishes identically is not a reduction of the grant.*

## Step 5, correct, correctly normalised, and already on record

$\mathrm{Ric}^*(h)$ acts as the derivation $D_h(x\wedge y)=hx\wedge y+x\wedge hy$, so in an eigenbasis of $h$ it is diagonal on $\Lambda^2$ with entries $h_i+h_j$, $i<j$. **The normalisation checks against the record's own convention test**: at $h=vv^\top$ with $v$ a unit vector, $D_h(v\wedge y)=v\wedge y$ for $y\perp v$ and $D_h(x\wedge y)=0$ for $x,y\perp v$, i.e. $D_h=\Pi_{v\wedge v^\perp}$, which is exactly the $\mathrm{Ric}^*(vv^\top)=\Pi_v$ identity that [run_j5cross_proof.py](../scripts/runs/run_j5cross_proof.py)'s PART 0 verifies. So $H=D_h$ with no stray factor.

The ratio claim follows: $\lambda_{\max}(H)=h_{(1)}+h_{(2)}$, $\lambda_{\min}(H)=h_{(n-1)}+h_{(n)}$, hence $\lambda_{\max}(H)/\lambda_{\min}(H)\le2h_{\max}/2h_{\min}=\kappa(h)$, **provided $h_{\min}>0$**.

**Novelty: none.** [Lemma B'](../ATTEMPTS.md) already states that $H=h\wedge2\,\mathrm{id}$ acts as $(c_k+c_l)\,\mathrm{Id}$ on the sector $V_k\wedge V_l$ when $h=\sum_kc_k\Pi_{V_k}$. Taking $V_k$ the one-dimensional eigenspaces of $h$ is the same sentence. A grep of [findings/](../findings/) and [ATTEMPTS.md](../ATTEMPTS.md) for the condition number of $\mathrm{Ric}(|W|)$ returns nothing prior, but $\kappa$ is already in use in this record for an unrelated object, [Reviewer 101/102's](../findings/bispectral.md) frame-maximal diagonal spread $\kappa(W)=\max_F\lVert K(F)\rVert_F$. **The symbol collides.**

## Step 6, the difficulty is renamed, and the new name is wrong

**(a) $\kappa=+\infty$ at named points where the grant holds.** [Lemma B'](../ATTEMPTS.md) records the shape of $h$ at each named point, including "*$c_2=0$ padding blocks at Fox and the plateau*". A zero block means $h_{\min}=0$, so $\kappa(\mathrm{Ric}(|W|))=+\infty$ at Fox, a genuine critical point at which $J_5\ge0$ is not merely true but *sharp*, and at which Theorem B discharges the grant through $\mathrm{cross}=0$. A proposed criterion that is infinite at Fox is not the grant restated; it is a strictly stronger and sometimes-false hypothesis.

**(b) Isotropy gives block-scalar, not scalar.** The section asserts $\kappa=1$ "*is what the isotropy argument delivers at every named critical point*". [Lemma B'](../ATTEMPTS.md) delivers $h$ scalar **on each isotypic factor**, $h=c_1\Pi_p\oplus c_2\Pi_q$ at the sphere products. At an unbalanced sphere product $c_1\ne c_2$ and $\kappa=c_1/c_2>1$, while $\mathrm{cross}=0$ to $10^{-15}$ regardless. Global scalarity is the special case, not the output.

**(c) $\mathop{\mathrm{tr}}H_{bb}/\lambda_{\min}(H_{bb})$ is not a condition number.** It satisfies $\mathop{\mathrm{tr}}H_{bb}/\lambda_{\min}(H_{bb})\ge d_b$ always, and equals $d_b\cdot\kappa(H_{bb})$ when $H_{bb}$ has two distinct eigenvalues at the extremes. Step 4 produces this quantity; step 5 bounds $\lambda_{\max}(H)/\lambda_{\min}(H)$. **The passage from step 4 to step 6 silently substitutes $\lambda_{\max}(H_{bb})$ for $\mathop{\mathrm{tr}}H_{bb}$, dropping a factor of the block dimension, $O(n^2)$.** That single substitution is where the section's conclusion comes from, and it is unjustified.

**(d) The two things being identified are two different theorems.** "*The three-block factor the record calls the gap is a condition number*" conflates [Theorem C](../ATTEMPTS.md)'s shortfall (the pair-sum factor, "*a three-block factor short of closing*"), with [Theorem D](../ATTEMPTS.md)'s $g_{bc}$, the distance between $\mathop{\mathrm{spec}}(W|_b)$ and $\mathop{\mathrm{spec}}(W|_c)$. Theorem D is a different mechanism: it bounds $\lVert H_{bc}\rVert_F\le\lVert[H,W]_{bc}\rVert_F/g_{bc}$, which **vanishes on the commuting class** and therefore is sharp exactly where the new criterion is worst. **Theorem D strictly dominates the proposal**; the proposal is neither Theorem D renamed nor a weakening of it, it is a weakening of Theorem C, which Theorem D already improves on.

**Is $\kappa$ bounded at a non-named critical point?** Unknown, and answering it needs a run this review is not authorised to open. What such a run would decide: evaluate $\kappa(\mathrm{Ric}(|W|))$ at the record's worst non-commuting point, the $n=5$ critical point at $\theta=0.882135$ with $\lVert[H,W]\rVert=0.39$ and $|\mathrm{cross}|/J_5^{\mathrm{diag}}=0.159$. A large or infinite $\kappa$ there confirms the criterion is void on the very remainder it was proposed for; a small $\kappa$ would still not rescue it, because §4 shows the criterion fails even at $\kappa=1$. **The run is therefore not worth requesting**, the closed-form argument settles it either way.

## What is worth keeping, and where a repair would have to go

**The block/cross framing is optional, and it overstates the difficulty.** From Theorem A, $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2$, so with no block split at all

$$J_5=\langle X_{\mathrm{inv}},H\rangle=4\langle C,H\rangle-2\langle\theta W_-+W_-^2,\,H\rangle,$$

and **both pairings are pairings of PSD operators, hence nonnegative**: $C=W_+\#W_-\succeq0$, $H\succeq0$, $\theta W_-+W_-^2\succeq0$ for $\theta>0$. So the grant is the single frame-free inequality

$$2\,\langle W_+\#W_-,\;H\rangle\;\ge\;\langle\theta W_-+W_-^2,\;H\rangle,$$

sharp as an operator identity at every point where $X_{\mathrm{inv}}=0$. There is no cross term in this statement. The cross term is an artefact of splitting $\langle C,H\rangle$ (a quantity that is manifestly nonnegative *before* the split), across blocks and then having to reassemble it; Theorem C's factor-of-8 shortfall is the price of that split, not a feature of the grant.

**Where slack actually remains, if the block route is kept.** $\langle C_{bc},H_{bc}\rangle=\langle U_b,U_c\rangle$ makes $(\langle U_b,U_c\rangle)_{b,c}$ a $3\times3$ Gram matrix with diagonal $m_b$ and total sum $\mathop{\mathrm{tr}}(CH)\ge0$. Theorem C bounds each off-diagonal entry by $\sqrt{m_bm_c}$, **individually sharp**, attained when $U_b\parallel U_c$. The three cannot be pairwise anti-aligned at once, so the loss is entirely in summing three separately-sharp pair bounds. A repair belongs there, a Gram/positive-semidefiniteness argument on the $3\times3$ matrix, or an argument killing $U_0$, and not in re-bounding $H$, which Theorem C already handles optimally.

## Recommendation

**Withdraw the section's conclusion.** Specifically: the sentence "*it was never applied to $H$*" is false and should be struck; the claim that the grant reduces to $\kappa(\mathrm{Ric}(|W|))$ should be replaced by the record that the proposed criterion is strictly weaker than Theorem C, is dominated by Theorem D, and is $+\infty$ at Fox. **The one durable output is the frame-free form of the grant above**, which is worth promoting into [findings/](../findings/) as the statement a proof should target, together with the Gram observation locating Theorem C's remaining slack in the pair-sum.

*A fence post is warranted:* **re-bounding $H$'s off-diagonal blocks by trace data cannot close $J_5\ge0$**, any bound of the form $\lVert H_{bc}\rVert_F\le f(\mathop{\mathrm{tr}}H_{bb},\mathop{\mathrm{tr}}H_{cc})$ is insensitive to $H$ being scalar, where $H_{bc}=0$, and so carries an unavoidable factor $\sqrt{d_bd_c}=\Theta(n^2)$.
