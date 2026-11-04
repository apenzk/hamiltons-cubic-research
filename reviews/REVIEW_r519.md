# REVIEW r519, Lemma L68

**Target:** Lemma L68, "the symmetry defect on the diagonal locus, and the entry cap criticality forces", [findings/diagonal-half.md](../findings/diagonal-half.md), the `#### Lemma L68` block at line 86 down to the next heading (line 113); parts (i)–(iv).
**Reviewer:** r519, cold. Every step below was re-derived from the definitions before the record's own derivation was weighed.
**Footing:** analysis only. One screen was run, four matrices I constructed, seconds of compute, reported as a screen and never as evidence for a positive claim. Every positive claim here has a derivation above it.

---

VERDICT: **CONFIRMED**

**All four displayed statements of L68 are true and each is re-derived here from the definitions.** The constants in $g_{ab}$ are right. But the sentence that justifies them (*"with $\lVert\varphi\rVert^2=2$ throughout"*), is **false in the normalisation that makes the formula true**, and names the wrong mechanism for the factor $2$. Four repairs are owed, listed at the end; none of them changes a number, and none of the nine citations is disturbed.

---

## 1. The normalisation, settled first, the constants are right, the stated reason is wrong

### What `conventions.md` actually fixes

[conventions.md](../findings/conventions.md) gives the $\Lambda^2$ inner product as $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, "equivalent to $\mathop{\mathrm{tr}}(v^2)=-2$ for a unit bivector". For $\varphi_{ab}=E_{ab}-E_{ba}$, $\mathop{\mathrm{tr}}(\varphi_{ab}^{\mathsf T}\varphi_{ab})=2$, so

$$\langle\varphi_{ab},\varphi_{ab}\rangle=\tfrac12\cdot2=1 .$$

So $\varphi_{ab}$ **is** a unit bivector, and the sibling bullet *"$\lVert\varphi_{ab}\rVert^2=2$ for $\varphi_{ab}=E_{ab}-E_{ba}$"* is the plain $n\times n$ Frobenius number, printed under the same symbol $\lVert\cdot\rVert$ in the same list. **The collision is real and it is `conventions.md`'s, not L68's**, the file's own next bullet, *"the $\Lambda^2$ and $n\times n$ Frobenius pairings differ by a factor $2$"*, is the explanation of the collision sitting one line below it, unattached.

### Which one L68 is in, decided by the record's own anchors, not by preference

Three checks pin it, and they agree:

- **The file's own opening.** Line 13 of [diagonal-half.md](../findings/diagonal-half.md) says the transported $c^2_{\alpha\beta\gamma}$ *is $1$ on triangles*. Since $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$ exactly (checked below), $c_{(ab)(bd)(ad)}=\langle\varphi_{ad},\varphi_{ad}\rangle=\lVert\varphi_{ad}\rVert^2$. That is $1$ under the half-trace and $2$ under Frobenius. **The file is in the half-trace, eighty lines above L68.**
- **$\mathop{\mathrm{tr}}W^\#=-1$.** On the diagonal locus $(W^\#)_{(ab)(ab)}=\tfrac12\sum_{\gamma\delta}c^2_{(ab)\gamma\delta}M_{\gamma\gamma}M_{\delta\delta}=\sum_{d\ne a,b}M_{ad}M_{bd}=(M^2)_{ab}$, so $\mathop{\mathrm{tr}}W^\#=\sum_{a<b}(M^2)_{ab}=\tfrac12\big(\mathbf1^{\mathsf T}M^2\mathbf1-\mathop{\mathrm{tr}}M^2\big)=\tfrac12(0-2)=-1$. The trace is over the $\binom n2$ basis elements $\{\varphi_{ab}\}_{a<b}$, **which the count requires to be orthonormal**.
- **$\mathrm{Id}^\#=(n-2)\mathrm{Id}$.** $(\mathrm{Id}^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}c^2_{\alpha\gamma\delta}=\tfrac12\kappa=\tfrac12\cdot2(n-2)=n-2$, the same $\#$ convention (with its $\tfrac12$) and the same orthonormal pair basis.

The other two anchors reproduce with no work: $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ gives $10,84,1638$ at $n=4,6,12$; and $\theta_0(6)^2=2\cdot5\cdot4/36=10/9$, so $\theta_0(6)=\sqrt{10}/3=1.05409255\ldots$

**So L68 is in the $\Lambda^2$ half-trace normalisation, where $\lVert\varphi_{ab}\rVert^2=1$, the exact opposite of what its own derivation line says.**

### The factor $2$ has nothing to do with the bivector norm

Write $A=\mathrm{ad}(\varphi_{ab})$ and $C=[A,W]$. From $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$ and $[\varphi_{ab},\varphi_{ad}]=-\varphi_{bd}$,

$$C\varphi_{bd}=(M_{bd}-M_{ad})\varphi_{ad},\qquad C\varphi_{ad}=(M_{bd}-M_{ad})\varphi_{bd},$$

so $C$ is a direct sum of $n-2$ blocks $\begin{pmatrix}0&c_d\\ c_d&0\end{pmatrix}$ with $c_d=M_{bd}-M_{ad}$, **each contributing $2c_d^2$ to the Hilbert–Schmidt norm because it has two nonzero entries**. Hence

$$g_{ab}=\lVert C\rVert^2=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2 .$$

The $2$ is the **two moved families $\varphi_{ad}$ and $\varphi_{bd}$**, not a bivector norm. The bivector norm enters only through the generator: $g_\gamma$ is defined at $v_\gamma$ an element of an **orthonormal** eigenbasis, so $v_{(ab)}=\varphi_{ab}$ under the half-trace. **Read the block's clause literally ($\lVert\varphi\rVert^2=2$, so the unit generator is $\varphi_{ab}/\sqrt2$) and $g_{ab}$ halves, and the identity is broken.**

### Independent confirmation of the constants, three ways

- **Petersen–Wink Prop 1.7, through the record's own translation** in [references/petersen-wink-2019-bochner-technique/notes.md](../references/petersen-wink-2019-bochner-technique/notes.md): $\lVert[\mathrm{ad}_{v_\gamma},W]\rVert^2=\sum_{\alpha,\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$, an **ordered** double sum absorbing PW's own $2\sum_{\alpha<\beta}$. For $\gamma=(ab)$ the triangles are $\{(ab),(ad),(bd)\}$, contributing the ordered pairs $((ad),(bd))$ and $((bd),(ad))$ for each $d$, **exactly the factor $2$**, by a route that never touches $\lVert\varphi\rVert$.
- **$\sum_\gamma g_\gamma=4(n-1)$** ([bounds.md:68](../findings/bounds.md), [target.md:331](../findings/target.md)). From (i): $\sum_{a<b}g_{ab}=2(n-1)\!\sum_a\!s_a-4\!\sum_{a<b}\!(M^2)_{ab}-4\!\sum_{a<b}\!M_{ab}^2=4(n-1)+4-4$. **Exact.** With $g$ halved it would give $2(n-1)$ and contradict the record.
- **$\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$** ([target.md:329](../findings/target.md)). From (iii): $\sum_{a<b}M_{ab}g_{ab}=2\sum_a s_a\sum_b M_{ab}-4\theta\sum_{a<b}M_{ab}^2=0-4\theta$, using $M\mathbf1=0$. **Exact.**

**Screen** (four matrices built for this purpose; `ad` matrices assembled entry by entry in the half-trace orthonormal pair basis and the commutator's HS norm taken directly, never from the closed form):

| point | $\max\lvert g_{\text{direct}}-2\sum(\cdot)^2\rvert$ | $\max\lvert \tfrac12 g_{\text{direct}}-2\sum(\cdot)^2\rvert$ | $\sum g$ vs $4(n-1)$ | $\sum\lambda g$ vs $-4\theta$ |
|---|---|---|---|---|
| balanced $n=6$ | $0$ | $1.111$ | $20.000$ / $20$ | agree to $10^{-15}$ |
| balanced $n=8$ | $2\times10^{-16}$ | $0.875$ | $28.000$ / $28$ | agree |
| balanced $n=12$ | $0$ | $0.611$ | $44.000$ / $44$ | agree |
| $C_5$ blow-up $n=10$ | $2\times10^{-16}$ | $0.600$ | $36.000$ / $36$ | agree to $10^{-10}$ (solver residual) |

The second column is the $\lVert\varphi\rVert^2=2$ literal reading; it fails by exactly the factor two at every point.

**Verdict on the normalisation: the constants $2$ and $4$ are correct; the clause "with $\lVert\varphi\rVert^2=2$ throughout" is false and must be deleted.** Nothing downstream rescales.

---

## 2. Part (i), the derivation, step by step

$\mathrm{ad}(\varphi_{ab})$ annihilates $\varphi_{ab}$ and every $\varphi_{cd}$ with $\{c,d\}\cap\{a,b\}=\emptyset$, so $[A,W]$ does too (both $AW$ and $WA$ vanish on them, $W$ being diagonal). On $\{\varphi_{ad},\varphi_{bd}\}_{d\ne a,b}$ it acts as above. **The move count $2(n-2)$ is exact**: $n-2$ values of $d$, two families, all $2(n-2)$ basis vectors distinct since $a\ne b$; $\varphi_{ab}$ itself is fixed, and the $\binom{n-2}2$ disjoint planes are fixed. **Confirmed, including the two cases the brief singles out.**

The middle step: $\lVert M_a-M_b\rVert^2$ runs over all $n$ coordinates, of which $d=a$ contributes $(M_{aa}-M_{ba})^2=M_{ab}^2$ and $d=b$ contributes $(M_{ab}-M_{bb})^2=M_{ab}^2$ **because $M$ is hollow**, so $\sum_{d\ne a,b}=\lVert M_a-M_b\rVert^2-2M_{ab}^2$ and $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$. Then $\lVert M_a-M_b\rVert^2=s_a+s_b-2(M^2)_{ab}$. **All three forms confirmed.**

### "With no hypothesis at all", checked, and it holds

- **Hollowness is not a hypothesis.** $M$ is *defined* as the symmetric zero-diagonal matrix of edge weights of $K_n$ (line 27 of the file). Hollowness is the encoding, not a condition on $W$.
- **Ricci-flatness $M\mathbf1=0$ is not used** anywhere in (i).
- **The normalisation $\mathop{\mathrm{tr}}M^2=2$ is not used.**
- **Criticality is not used.**

What (i) does need, and does not say: **$W$ diagonal in the coordinate pair basis**, which is the locus, so it is a scope and not a hypothesis. **The "no hypothesis at all" label is correct.** This is the opposite of the failure mode the brief warned about, and it agrees with r292's C1 note.

### "Not a new identity", the specialisation reduces exactly

The recorded general form is $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$, with $R_{\gamma\alpha}=\sum_\beta T_{\gamma\alpha\beta}=\lVert[v_\gamma,v_\alpha]\rVert^2$ and $Q_\gamma=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$; it follows from PW 1.7 by expanding $(\lambda_\alpha-\lambda_\beta)^2$ and using the total symmetry of $T$. That form is **undisturbed** by this session's repairs to [bounds.md](../findings/bounds.md), it appears at [bounds.md:245](../findings/bounds.md) as $g_k=2R_k-4\lambda_k(\theta-\lambda_k)$, the same thing with $Q_\gamma=2(W^\#)_{\gamma\gamma}$ and criticality substituted, and at [bounds-relaxations.md:69, :95](../findings/bounds-relaxations.md) in the L68 form verbatim.

Specialising: $R_{(ab)\alpha}$ is the shares-exactly-one-index indicator (a triangle on $(ab)$ and $\alpha$ closes with exactly one $\beta$), so $\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=\sum_{d\ne a,b}(M_{ad}^2+M_{bd}^2)=s_a+s_b-2M_{ab}^2$; and $Q_{(ab)}=2\sum_{d\ne a,b}M_{ad}M_{bd}=2(M^2)_{ab}$. Substituting gives $2(s_a+s_b)-4M_{ab}^2-4(M^2)_{ab}$, **(i)'s third form, exactly. The specialisation claim is confirmed.**

---

## 3. Part (ii), confirmed in every clause

$\Delta=0\iff g_{ab}=0$ at every positive edge $\iff M_{ad}=M_{bd}$ for all $d\notin\{a,b\}$. **Transitivity, derived:** let $a\!-\!b$ and $b\!-\!c$ be positive twin pairs. Taking $d=c$ in the first gives $M_{ac}=M_{bc}>0$, so $a\!-\!c$ is a positive edge. For $d\notin\{a,c,b\}$, $M_{ad}=M_{bd}=M_{cd}$; for $d=b$, the second pair at $d=a$ gives $M_{ab}=M_{ac}$ and the first at $d=c$ gives $M_{ac}=M_{bc}$, so $M_{ab}=M_{cb}$. **Both the positivity and the twinness of the closing edge come out, so linkage is transitive.**

Constancy inside a component ($M_{ab}=M_{ac}$ for any $a,b,c$ in one component, by the above) and across each pair of components ($a,a'$ twins force $M_{ab}=M_{a'b}$) follow, as does nonpositivity across components (a positive cross entry would merge them). The converse is immediate. **Block-constancy alone is genuinely not the condition**, screened: the $C_5$ blow-up is block-constant with $\Delta=12.000000$, its positive edges being the within-block pairs *and* the non-adjacent block pairs.

**Reviewer 292's singleton corollary is correct and is in fact slightly stronger than stated**: it needs only that $a$ carries no positive edge, whereupon $M_{ad}\le0$ for all $d$ and $\sum_d M_{ad}=0$ force row $a$ to vanish, so $\varphi_{ad}\in\ker W$ for every $d$. Hence $\Delta=0$ with $\ker W=0$ forces every component to have size $\ge2$. **Confirmed.**

---

## 4. Parts (iii) and (iv), the entry cap, stated precisely

**Statement.** At a diagonal critical point, the off-diagonal criticality equation $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ cancels both quadratic terms of (i):
$$g_{ab}=2(s_a+s_b)-4\theta M_{ab}\qquad(a\ne b),$$
whence, from $g_{ab}\ge0$ alone,
$$\boxed{\;2\theta M_{ab}\le s_a+s_b\quad\text{for every }a\ne b\;}$$
with **equality iff $g_{ab}=0$, i.e. iff $a$ and $b$ are twins outside their own pair**. Dividing at a positive edge ($\theta>0$) gives $\theta\le\min_{M_{ab}>0}\frac{s_a+s_b}{2M_{ab}}$, and the exact form $\theta=\frac{s_a+s_b}{2M_{ab}}-\frac{g_{ab}}{4M_{ab}}$ is the same equation rearranged. **All confirmed.**

**What criticality gives, and what it does not.**

| ingredient | status |
|---|---|
| $g_{ab}\ge0$, i.e. $\lVert M_a-M_b\rVert^2\ge2M_{ab}^2$ | hypothesis-free; hollowness only |
| $(M^2)_{ab}+M_{ab}^2=\theta M_{ab}$ | **criticality, load-bearing** |
| $\theta>0$ to divide | the record's sign convention |
| a positive edge exists | automatic: $M\ne0$ hollow with zero row sums |

**The block does not conflate (i)'s status with (iii)'s.** (i) is labelled hypothesis-free and is; (iii) is labelled "At a critical point", says "The cap needs criticality and nothing else", and adds "**Criticality is load-bearing**" with the violation figures. **The conflation the brief asked about is absent here.** *(It surfaces one heading level below, in a consumer, see §6.)*

**Is the cap attained?** Yes, and at exactly the twin pairs. Screened: $\min_{M_{ab}>0}\frac{s_a+s_b}{2M_{ab}}=\theta$ to $10^{-16}$ at the balanced products at $n=6,8,12$ (every within-block pair is a twin pair), and to $10^{-11}$ at the $C_5$ blow-up (the within-block pairs are twins there too, the solver's own residual). **So the cap is an equality at the $C_5$ blow-up as well as at every balanced product**, the block says as much in (iv), and the fence's "equality at every balanced product" understates its own reach by one point.

**(iv), derived.** Summing $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ over the **unordered** positive edges: $\sum_{a<b,+}(s_a+s_b)=\sum_a d_a^+s_a$, and $\sum_{a<b,+}M_{ab}=\tfrac12\lVert M\rVert_1$ because $\sum_{a<b}M_{ab}=0$ splits $\lVert M\rVert_1$ evenly between the signs. So $\Delta=2\sum_a d_a^+s_a-2\theta\lVert M\rVert_1$, i.e. $\theta\lVert M\rVert_1=\sum_a d_a^+s_a-\tfrac12\Delta$. **Exact.** Screened to $4\times10^{-15}$ at all four points. This matches r292's C9 reading, (iv) is (iii) summed, *plus one further use of $M\mathbf1=0$*.

---

## 5. Findings requiring repair

**F1, the justifying clause is false in the normalisation the formula lives in.** *"so with $\lVert\varphi\rVert^2=2$ throughout"* (line 90). The formula is right; this reason is not, and taken literally it halves $g_{ab}$ and breaks (iv) and every citation. **Repair:** replace with *"the two families $\varphi_{ad},\varphi_{bd}$ contributing equally"*, and quote the half-trace normalisation from [conventions.md](../findings/conventions.md) rather than restating a norm. Severity: **prose, load-bearing on a reader's reconstruction, zero numerical impact.**

**F2, `conventions.md` carries the collision that produced F1.** Its bullet *"A bivector's norm: $\lVert\varphi_{ab}\rVert^2=2$"* sits in the $\Lambda^2$ list one line below *"$\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$ ... equivalent to $\mathop{\mathrm{tr}}(v^2)=-2$"*, which gives $1$. Both numbers are true, in different pairings, under one symbol. **Repair:** label it, e.g. *"$\lVert\varphi_{ab}\rVert^2_{\Lambda^2}=1$ and $\lVert\varphi_{ab}\rVert^2_F=2$; the pair basis $\{\varphi_{ab}\}_{a<b}$ is orthonormal for the $\Lambda^2$ pairing, which is what makes $\mathop{\mathrm{tr}}W^\#=-1$ and $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ come out."* This is the same class as the file's own tabled $B$, $M$ and $\mu$ collisions.

**F3, (iv) omits its hypothesis.** The identity $\theta\lVert M\rVert_1=\sum_a d_a^+s_a-\tfrac12\Delta$ is **false at a non-critical diagonal point**; it inherits criticality from (iii), which its heading *"Traced over $\mathfrak p$"* does not say. It also uses $M\mathbf1=0$, which on this locus is automatic. **Repair:** *"(iv) Traced over $\mathfrak p$ at a critical point"*. No citation currently takes (iv), so nothing propagates.

**F4, the $\Delta$ sum is unlabelled against the file's own convention.** (ii) writes $\Delta=\sum_{M_{ab}>0}g_{ab}$, while [conventions.md](../findings/conventions.md) rules *"sums over pairs are over ORDERED pairs unless the line says otherwise"*. Read as ordered, $\Delta$ doubles and (iv) needs $\tfrac14\Delta$. The correct reading is **unordered**, $\Delta$ is a trace over the positive eigenspace, whose basis is $\{\varphi_{ab}\}_{a<b}$, and (iv) and the $C_5$ value $12$ both come out only that way. **Repair:** write $\sum_{a<b,\,M_{ab}>0}$.

**F5, a dead in-file anchor.** [diagonal-half.md:475](../findings/diagonal-half.md) links to `#lemma-l68--the-symmetry-defect-in-closed-form`; the heading now slugs to `#lemma-l68--the-symmetry-defect-on-the-diagonal-locus-and-the-entry-cap-criticality-forces`. The file's other three in-file anchors (L97, L129, L74) all resolve, so the slug convention is GitHub's and this one is simply stale from the rename. [findings/INDEX.md:53](../findings/INDEX.md) also still prints the old name in prose, though its link carries no fragment and resolves.

**F6, the label is ahead of the audit.** [INDEX-results.md:82](../findings/INDEX-results.md) labels L68 **Lemma**, which that index defines as *"proven, Gate 1 and Gate 2 passed"*; [LEDGER.md:56](../findings/LEDGER.md) records it **SINGLE-AUDITED** (r292 alone, r291 outstanding) and [plan-verification.md:26](../plan-verification.md) has it unchecked. *This review is a second independent cold pass and confirms every step, so folding it in discharges the gap rather than widening it.*

---

## 6. The citations, what each takes, and none rests on a refuted claim

| site | what it takes | status |
|---|---|---|
| [INDEX.md:53](../findings/INDEX.md) | (i) $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$ and (ii) the twin-clique characterisation | **constants correct**; prose keeps the pre-rename name |
| [INDEX.md:75](../findings/INDEX.md) | (iii), "L68 prices the norm" of $o$ | correct |
| [INDEX-results.md:82](../findings/INDEX-results.md) | index row | correct name; see **F6** |
| [diagonal-half.md:475](../findings/diagonal-half.md), Lemma L130(ii) | the cap, via $g_{ab}\ge0$ plus criticality | **substance correct**; the sub-heading word *"unconditional"* is loose, the *cap* needs criticality, only $g_{ab}\ge0$ is hypothesis-free. The body immediately says *"so with criticality"* and *"at every pure critical point"*, so no false statement propagates. Anchor dead: **F5** |
| [second-order.md:967, :969](../findings/second-order.md) | (iii), as the incumbent identity the orbit route lost to | correct |
| [bounds-relaxations.md:82](../findings/bounds-relaxations.md) | the general per-direction identity, noting L68's form is diagonal-only | correct, I checked the general $\theta=\frac{\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}}{2\lambda_\gamma}+\lambda_\gamma-\frac{g_\gamma}{4\lambda_\gamma}$ collapses on this locus to L68(iii)'s exact form, the $\lambda_\gamma$ terms cancelling |
| [results.md:766](../results.md) | (iii) cap and (iv) | correct, and it labels the status |
| [LEDGER.md:56](../findings/LEDGER.md), [plan.md:199](../plan.md) | status rows | see **F6** |
| eight sites in [ATTEMPTS.md](../ATTEMPTS.md) | $\lVert o^{(jk)}\rVert^2=s_j+s_k-2\theta M_{jk}$, i.e. **(iii) halved**, and $\lVert\tilde o\rVert^2=\lVert o\rVert^2+2M_{jk}^2$ | correct: $\lVert o^{(jk)}\rVert^2=g_{jk}/2$ by (i), and $\tilde o$ adds the two coordinates $\pm M_{jk}$. The recurring *"L68 gives $s_j=s_k=\theta M_{jk}$ at a twin pair"* is loose, L68 gives only the **sum** $s_j+s_k=2\theta M_{jk}$; $s_j=s_k$ comes from twinness, which does hold, so the conclusion stands. Already corrected on the record by [r398](REVIEW_r398.md) |

**No citation takes a strengthening the block does not support, and none rests on a claim the block refutes.** The one systematic looseness (the twin-pair split) is already recorded.

---

## 7. Cross-file consistency

- **No file restates $g_{ab}$ with different constants.** [bounds.md:245](../findings/bounds.md), [bounds-relaxations.md:69, :95](../findings/bounds-relaxations.md), [target.md:329, :661](../findings/target.md) and [INDEX.md:53](../findings/INDEX.md) are the only other carriers; each is the general form or the same specialisation, and each specialises to (i) exactly. Both of target.md's moment identities are **reproduced exactly by (i)'s constants**, which is what makes the factor $2$ un-negotiable.
- **No later passage of [diagonal-half.md](../findings/diagonal-half.md) contradicts the block.** L130(ii) agrees; L97, L99, L129 and L144 do not touch $g$.
- **One staleness, just outside the target.** The fence at line 120 says *"Gate 2 owed on the one step that is not recorded: $Q_\gamma=2(W^\#)_{\gamma\gamma}$ per row"*, and [plan.md:199](../plan.md) says *"the per-row $Q_\gamma$ step, never audited"*, but [LEDGER.md:57](../findings/LEDGER.md) records **Gate 2 LANDED (Reviewers 293 and 294, agreeing on every number)**, and [bounds-relaxations.md:78–86](../findings/bounds-relaxations.md) carries the audited result. **Two of the three are stale.** Outside the block, adjacent to it, and worth one edit each.
- **Provenance.** The block carries no dated provenance line. Its two attributions, *"Corollary (Reviewer 292)"* and *"rebuilt here from the reviewer's matrix, criticality residual $2.8\times10^{-17}$"*, both correspond to real files, and [REVIEW_r292.md](REVIEW_r292.md) does carry the singleton corollary among its confirmed claims.

## 8. What was not settled, and what would settle it

The fence's $n=6$ comparison point ($M=\sqrt{2/21}\,Z$, every $s_a=\tfrac72c^2$, cap $1.080123$ against $\theta=0.308607$) was **not rebuilt**, the matrix $Z$ is not on the record here. Its arithmetic is internally consistent ($\sum_a s_a=21c^2=2$ exactly at $c^2=2/21$, and $s/c=3.5c=1.080124$), but $s_a=3.5c^2$ rules out a $\{0,\pm c\}$ matrix, so $Z$ has entries of more than one magnitude. **What would settle it:** printing $Z$ beside the claim, or one evaluation of the two bounds at that point. It is a comparison in the fence, one heading below the target, and no statement of L68 rests on it.

