# REVIEW r520, Lemma L68

**Target:** Lemma L68, "the symmetry defect on the diagonal locus, and the entry cap criticality forces", [findings/diagonal-half.md](../findings/diagonal-half.md), `#### Lemma L68` (line 86) down to the next heading.

**Reviewer:** r520, independent adversarial audit, cold. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts; screening only, labelled as such.

**Phase plan**

- P0 log + report skeleton
- P1 fix the normalisation from `findings/conventions.md`
- P2 derive `g_ab` from scratch in that normalisation
- P3 check the anchors (`tr W# = -1`, `theta_0(6)`, `Id# = (n-2)Id`, `dim W_n`)
- P4 the density `g_gamma` and the Petersen–Wink Prop 1.7 attribution
- P5 what part (i) actually needs ("with no hypothesis at all")
- P6 the move count `2(n-2)`
- P7 the `bounds.md` specialisation ("not a new identity")
- P8 the entry cap and what criticality forces
- P9 the 9 citations, density / cap / strengthening
- P10 cross-file contradiction sweep + provenance line
- P11 verdict

**VERDICT: CONFIRMED**, see the Verdict section at the foot.

## Findings

### F1, the normalisation: the block's constants are right, its stated normalisation is the wrong half of the collision (DEFECT, cosmetic but real)

**The collision is real.** [conventions.md](../findings/conventions.md), under "Norms and pairings", carries in consecutive bullets

- $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$, and
- $\lVert\varphi_{ab}\rVert^2=2$ for $\varphi_{ab}=E_{ab}-E_{ba}$.

Derived cold: $\varphi_{ab}^{\mathsf T}\varphi_{ab}=E_{aa}+E_{bb}$, so $\mathop{\mathrm{tr}}(\varphi^{\mathsf T}\varphi)=2$ and $\tfrac12\mathop{\mathrm{tr}}(\varphi^{\mathsf T}\varphi)=1$. The two bullets are two different pairings under one symbol $\lVert\cdot\rVert$, the second is plain matrix Frobenius, the first is the $\Lambda^2$ pairing. **Both numbers are true; the notation is not.**

**Which one is the record's working normalisation, settled by three independent anchors, all reproduced by hand here, all in $\lVert\varphi_{ab}\rVert^2=1$.** Take $W$ coordinate-diagonal, $W\varphi_{ab}=M_{ab}\varphi_{ab}$, $\mathop{\mathrm{tr}}M^2=\sum_{a\ne b}M_{ab}^2=2$ (the normalisation the section immediately above L68 works in).

1. $\mathop{\mathrm{tr}}W^\#=\tfrac12\sum_{\alpha\beta}c_{\gamma\alpha\beta}^2\lambda_\alpha\lambda_\beta$ summed over $\gamma$ gives $\tfrac12\sum_{a<b}M_{ab}\sum_{d\ne a,b}(M_{ad}+M_{bd})\cdot 2 = \sum_{a<b}M_{ab}(-2M_{ab})=-\sum_{a<b}M_{ab}^2=-1$, using $M\mathbf 1=0$. **$\mathop{\mathrm{tr}}W^\#=-1$ ✓.** Under $\lVert\varphi\rVert^2=2$ this would come out $-2$ or $-\tfrac12$ depending where the factor is placed.
2. $\sum_\gamma g_\gamma$: from the block's own $g_{ab}=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2$, summing over $a<b$ gives $4(n-1)+4-4=4(n-1)$, **exactly [bounds.md](../findings/bounds.md)'s constant $\sum_\gamma g_\gamma=4(n-1)$ ✓**.
3. $\sum_\gamma\lambda_\gamma g_\gamma$: from (iii)'s $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$, $\sum_{a<b}M_{ab}(s_a+s_b)=\sum_a s_a\sum_{b\ne a}M_{ab}=0$, leaving $-4\theta\sum_{a<b}M_{ab}^2=-4\theta$, **exactly [bounds.md](../findings/bounds.md)'s $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ ✓**.

Anchors 2 and 3 would each be off by a factor $2$ or $\tfrac12$ in any other normalisation. **So the record runs at $\lVert\varphi_{ab}\rVert^2=1$, and L68's constants $2$ and $4$ are the correct ones there.**

**The defect.** L68's sentence *"so with $\lVert\varphi\rVert^2=2$ throughout"* names the other half of the collision, and the block is internally inconsistent about it two paragraphs later: the "not a new identity" paragraph asserts *"$R_{\gamma\alpha}$ is the indicator that two pairs share exactly one index"*, and $R_{\gamma\alpha}=\lVert[v_\gamma,v_\alpha]\rVert^2$ equals $\lVert\varphi_{ad}\rVert^2$ on such a pair, which is the indicator **only if $\lVert\varphi\rVert^2=1$**. The two sentences cannot both hold.

*What saves the arithmetic.* The Hilbert–Schmidt norm $\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ is invariant under rescaling the inner product, so the only normalisation-sensitive input is whether $v_\gamma$ is the matrix $E_{ab}-E_{ba}$ or that matrix over $\sqrt2$. Taking $v_\gamma=\varphi_{ab}$ literally (which is the *unit* eigenvector precisely in $\lVert\varphi\rVert^2=1$), gives the block's numbers. **Fix: replace the parenthetical with "with $\lVert\varphi_{ab}\rVert^2=1$, the $\Lambda^2$ pairing of conventions.md", and repair conventions.md's second bullet to say Frobenius explicitly.** No citation of L68 is rescaled by this.

### F2, part (i): the identity chain, derived cold, is CORRECT in every step

$X:=[\mathrm{ad}(\varphi_{ab}),W]$ on $\Lambda^2$. Structure constants, computed from $E$-matrices: $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$ ✓ (the block's monomial) and $[\varphi_{ab},\varphi_{ad}]=-\varphi_{bd}$. Hence

- $X\varphi_{bd}=(M_{bd}-M_{ad})\varphi_{ad}$, the block's stated action ✓
- $X\varphi_{ad}=(M_{bd}-M_{ad})\varphi_{bd}$, **the second family, which the block's sentence does not name but its factor $2$ requires**
- $X\varphi_{ab}=0$ and $X\varphi_{cd}=0$ for $\{c,d\}\cap\{a,b\}=\emptyset$.

So $g_{ab}=\sum_{d\ne a,b}2(M_{ad}-M_{bd})^2$ ✓. Middle step: $\lVert M_a-M_b\rVert^2$ over all $d$ adds $d=a$ giving $(0-M_{ab})^2$ and $d=b$ giving $(M_{ab}-0)^2$, both $M_{ab}^2$ by hollowness ✓, so $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$ ✓. Third step: $\lVert M_a-M_b\rVert^2=s_a+s_b-2\langle M_a,M_b\rangle$ and $\langle M_a,M_b\rangle=(M^2)_{ab}$ by symmetry of $M$ ✓.

### F3, the move count $2(n-2)$: CORRECT, and the block's own sentence under-reports it

The moved directions are $\varphi_{ad}$ **and** $\varphi_{bd}$, $d\ne a,b$: $2(n-2)$ of them ✓. Nothing else moves: $\varphi_{ab}$ is annihilated because $[\varphi_{ab},\varphi_{ab}]=0$, and a plane disjoint from $\{a,b\}$ because $\mathfrak{so}$ brackets of disjoint coordinate bivectors vanish ✓. **But the block writes only "sending $\varphi_{bd}\mapsto(M_{bd}-M_{ad})\varphi_{ad}$", one family of the two**, a reader reconstructing the factor $2$ from that sentence plus $\lVert\varphi\rVert^2=2$ gets the right answer by the wrong route (summing $\lVert X\varphi_{bd}\rVert_F^2$ over a non-orthonormal basis restricted to half the moved directions). *Fix: name both images.*

### F4, "not a new identity": the specialisation CHECKS OUT against bounds.md, and pins $Q_\gamma$ independently

From the definitions, in an orthonormal eigenbasis, $[A,W]_{\alpha\beta}=(\lambda_\beta-\lambda_\alpha)c_{\gamma\beta\alpha}$, so $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}=2R_\gamma-2Q_\gamma$ with $R_\gamma=\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$, $R_{\gamma\alpha}=\lVert[v_\gamma,v_\alpha]\rVert^2$, and $Q_\gamma=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}=2(W^\#)_{\gamma\gamma}$. This is L68's cited general form ✓ and, at a critical point, is [bounds.md](../findings/bounds.md)'s own $g_k=2R_k-4\lambda_k(\theta-\lambda_k)$ ✓ (line 245), the two recorded forms are one identity, and the audit has not disturbed either.

Diagonal specialisation, derived cold: $\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=\sum_{d\ne a,b}(M_{ad}^2+M_{bd}^2)=s_a+s_b-2M_{ab}^2$ ✓ (block's value), and $(W^\#)_{(ab)(ab)}=\sum_{d\ne a,b}M_{ad}M_{bd}=(M^2)_{ab}$ by hollowness, so $Q_{(ab)}=2(M^2)_{ab}$ ✓ (block's value). **The specialisation reduces exactly.** *Side effect: the block's own closing fence says "Gate 2 owed on the one step that is not recorded: $Q_\gamma=2(W^\#)_{\gamma\gamma}$ per row", that step is derived here and is correct, so the debt can be discharged.*

### F5, parts (ii), (iii), (iv) all reproduce, and the balanced-product equality is confirmed BY HAND

**(ii)** $g_{ab}=0\iff M_{ad}=M_{bd}\ \forall d\ne a,b$ ✓. Transitivity: $a\!-\!b$ twins gives $M_{ac}=M_{bc}$, so $b\!-\!c$ positive forces $a\!-\!c$ positive ✓. Constancy within a component and across each pair of components both follow from twinning ✓. Converse ✓. Singleton corollary ✓: a singleton's whole row is cross entries, all $\le0$, summing to $0$ by $M\mathbf1=0$, hence identically zero, hence $\ker W\ne0$.

**(iii)** The off-diagonal criticality equation is $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ ✓, it is the section above L68, and it also drops straight out of $Q_\gamma=2\lambda_\gamma(\theta-\lambda_\gamma)$, an independent route. Substituting cancels both quadratics, giving $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ ✓; $g_{ab}\ge0$ gives $2\theta M_{ab}\le s_a+s_b$ ✓; equality $\iff$ twins ✓; the min is correctly restricted to $M_{ab}>0$ (dividing by a negative entry flips) ✓; the exact form $\theta=\frac{s_a+s_b}{2M_{ab}}-\frac{g_{ab}}{4M_{ab}}$ ✓.

**The anchor, checked by hand at the balanced product $n=2m$.** Two blocks, within-block $\alpha$, cross $\beta=-\frac{(m-1)\alpha}{m}$ from $M\mathbf1=0$; $\mathop{\mathrm{tr}}M^2=2$ gives $\alpha^2=\frac{2}{(n-1)(n-2)}$; then $s_a=1/m=2/n$ ✓ (the file's recorded "diagonal reading $2/n$"), criticality gives $\theta=\frac{\sqrt{(m-1)(2m-1)}}{m}=\frac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n)$ ✓, and the cap reads $\frac{s_a+s_b}{2M_{ab}}=\frac{2/n}{\alpha}=\theta_0(n)$, **equality, exactly as (iii) and the fence claim** ✓. At $n=6$ this is $\sqrt{10}/3$ ✓.

**(iv)** $\Delta=\sum_{a<b,\,M_{ab}>0}[2(s_a+s_b)-4\theta M_{ab}]=2\sum_a d_a^+s_a-4\theta\sum_{a<b,+}M_{ab}$, and $M\mathbf1=0$ makes $\sum_{a<b,+}M_{ab}=\tfrac12\lVert M\rVert_1$, giving $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$ ✓ **exactly**. It is an equality at the balanced product: both sides are $2(m-1)$, checked by hand ✓. *This also settles that $\Delta$ is the UNORDERED-pair sum, against conventions.md's default "sums over pairs are over ORDERED pairs unless the line says otherwise", the line does not say otherwise, and the ordered reading breaks (iv) by a factor $2$. A second small convention debt, on the same block.*

### F6, "with no hypothesis at all": the label is defensible, the sentence following it is not

Part (i) uses: $M$ symmetric, $M$ hollow, $W\varphi_{ab}=M_{ab}\varphi_{ab}$. It does **not** use $M\mathbf1=0$ and does **not** use criticality. Hollowness is not a hypothesis, $M_{aa}=W_{aaaa}=0$ by the pair antisymmetry of a curvature operator, and [conventions.md](../findings/conventions.md) defines the locus as $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf1=0\}$, so hollowness is definitional. **So (i) holds for every coordinate-diagonal operator on $\Lambda^2$, Weyl or not, critical or not, the label is right**, read as "nothing beyond membership of the diagonal locus", and the block is transparent about the hollowness step.

**The one sentence that overreaches is in (iii), not (i):** *"The cap needs criticality and nothing else"*. It needs hollowness as well, that is exactly what makes the two dropped coordinates equal $M_{ab}^2$ in the inequality $\lVert M_a-M_b\rVert^2\ge2M_{ab}^2$ the sentence then quotes. *Fix: "needs criticality and hollowness, nothing else."* **No conflation of (i)'s hypothesis-free status with (iii)'s criticality was found**, (iii) states "Criticality is load-bearing" outright and (iv) inherits both criticality and $M\mathbf1=0$ correctly.

### F7, the Petersen–Wink attribution is CORRECT, and correctly split

[notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) carries Prop 1.7 verbatim: $|LR|^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2g(L\Xi_\alpha,\Xi_\beta)^2$ for every $L\in\mathfrak{so}(V)$, with $\{\Xi_\alpha\}$ an **orthonormal** eigenbasis. Setting $L=v_\gamma$ and $\Lambda^2\cong\mathfrak{so}(n)$ gives $\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$, **identical to what I derived cold** from $[A,W]_{\alpha\beta}=(\lambda_\beta-\lambda_\alpha)c_{\gamma\beta\alpha}$. So $g_\gamma$ **is** the Prop 1.7 density ✓.

The split of credit is right too: PW supply the identity; $\Delta$ (the trace over $\{\lambda>0\}$) is the record's own, and the block attributes it to [bounds.md](../findings/bounds.md), which defines $\Delta(W)=\sum_{\gamma\in\mathfrak p}\lVert v_\gamma\!\cdot\!W\rVert^2$ over the positive eigenvectors ✓, matching [conventions.md](../findings/conventions.md)'s "traced over $\{\lambda>0\}$ only" ✓. The trace is well posed at degenerate eigenvalues because $v\mapsto g_v$ is a quadratic form, so the sum is basis-independent inside the eigenspace, worth one clause in the block, since the diagonal locus is massively degenerate.

*One reinforcement of F1 from this source:* Prop 1.7 requires $\{\Xi_\alpha\}$ orthonormal, and $\Delta$ is a trace, so $v_\gamma$ must be the **unit** eigenvector. On the diagonal locus that unit vector is $E_{ab}-E_{ba}$ only when $\lVert\varphi_{ab}\rVert^2=1$.

### F8, "criticality is load-bearing" is true, and provable without the sweep the block cites

The block supports it with maximised violations $+0.075,\dots,+0.370$ at $n=5,\dots,12$, a numerical claim this review does not audit. **It does not need one.** Write the per-entry criticality residual $\rho_{ab}:=\theta M_{ab}-M_{ab}^2-(M^2)_{ab}$. Then, from (i) exactly,

$$2\theta M_{ab}-(s_a+s_b)\;=\;2\rho_{ab}-\tfrac12 g_{ab},$$

so **the cap fails at $(a,b)$ exactly when $\rho_{ab}>\tfrac14g_{ab}$**. Contracting the residual against $M$ gives $\sum_{a\ne b}M_{ab}\rho_{ab}=2\theta-\langle M^{\circ2}+M^2,M\rangle=0$, which is the *only* constraint on $\rho$; individual entries are free in sign, so a positive residual exceeding $\tfrac14g_{ab}$ at a positive edge is unobstructed. *That is the load-bearing statement, in one line, and it also says the violation is measured by the residual rather than by anything curvature-specific.* Recommend replacing the sweep numbers with it, or keeping both.

### F9, the specialisation agrees with the OTHER recorded general form as well

[bounds-relaxations.md](../findings/bounds-relaxations.md) records, at a critical point, $\theta=\frac{\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}}{2\lambda_\gamma}+\lambda_\gamma-\frac{g_\gamma}{4\lambda_\gamma}$ for $\lambda_\gamma>0$. Substituting the diagonal values $\lambda_\gamma=M_{ab}$ and $\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=s_a+s_b-2M_{ab}^2$ gives $\frac{s_a+s_b}{2M_{ab}}-M_{ab}+M_{ab}-\frac{g_{ab}}{4M_{ab}}$, **exactly L68 (iii)'s exact form** ✓. Three recorded forms of one identity, mutually consistent under the specialisation.

### F10, the nine citations: what each takes, and none rests on a refuted claim

| site | what it takes |
| --- | --- |
| [diagonal-half.md:475](../findings/diagonal-half.md#L475) (Lemma L130 (ii)) | **the cap**, $M_{ab}\le\frac{s_a+s_b}{2\theta}$, plus "$g_{ab}\ge0$ with no hypothesis" |
| [second-order.md:967](../findings/second-order.md#L967) | **the density as an identity** for $\lVert o\rVert$, as the incumbent to beat |
| [second-order.md:969](../findings/second-order.md#L969) and [INDEX.md:75](../findings/INDEX.md#L75) | **the density**, "L68 prices the norm", so a rearrangement pricing the norm again is inert |
| [bounds-relaxations.md:82](../findings/bounds-relaxations.md#L82) | **the density**, as the locus-bound form the general $\theta$-solve improves on |
| [INDEX.md:53](../findings/INDEX.md#L53), [INDEX-results.md:82](../findings/INDEX-results.md#L82), [results.md:766](../../results.md#L766) | index restatements, **density and cap**, constants identical to the block ✓ |
| [results.md:50](../../results.md#L50) | the **Petersen–Wink attribution**, confirmed in F7 |
| [LEDGER.md:56](../findings/LEDGER.md#L56) | the audit status |

**None takes a strengthening**, and none rests on anything the block refutes. Two loose citations are already caught and recorded in the review record and are correct against my derivation: [r398](REVIEW_r398.md) item 8 ("$s_j=s_k=\theta M_{jk}$ at a twin pair", L68 gives only the *sum* $s_j+s_k=2\theta M_{jk}$) and [r401](REVIEW_r401.md) item 4b (L68 supplies $\lVert\tilde o\rvert_I\rVert^2$, not $\lVert\tilde o\rVert^2=\lVert\tilde o\rvert_I\rVert^2+2M_{jk}^2$).

**One live wording risk, in the citing block rather than in L68.** [Lemma L130](../findings/diagonal-half.md)'s part label reads *"(ii) The entry cap, unconditional."* Its body is correct ("so with criticality … at every pure critical point") but the bold label is exactly the conflation the audit is watching for, and [r402](REVIEW_r402.md) line 143 already repeats it as "$M_{ab}\le(s_a+s_b)/(2\theta)$ **unconditionally**". *Recommend: "(ii) The entry cap, with no structural hypothesis beyond criticality."*

### F11, a broken anchor, from the rename this block went through

[diagonal-half.md:475](../findings/diagonal-half.md#L475) links `[Lemma L68](../findings/diagonal-half.md#lemma-l68-the-symmetry-defect-on-the-diagonal-locus-and-the-entry-cap-criticality-forces)`. **No heading in the file matches that anchor**, L68's heading is "the symmetry defect **on the diagonal locus, and the entry cap criticality forces**". [INDEX.md:53](../findings/INDEX.md#L53) still calls it "the symmetry defect in closed form", so the old title is the anchor's source. Commit `1c88933` ("the bare mentions and anchored links the rename missed") repaired others of these and missed this one. *Fix: point it at `#lemma-l68--the-symmetry-defect-on-the-diagonal-locus-and-the-entry-cap-criticality-forces`.*

### F12, cross-file sweep: no contradiction found

Every restatement of $g_{ab}$ in [findings/](../findings/) carries the block's constants, [INDEX.md:53](../findings/INDEX.md#L53) and [results.md:766](../../results.md#L766) both print $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$ and $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ ✓. The passages **below** the block in [diagonal-half.md](../findings/diagonal-half.md) (the "what it does not reach" fence, the second-order section, L98, L99, L129, L130), narrow and qualify L68 but contradict none of (i)–(iv); the fence's own "Gate 2 owed on $Q_\gamma=2(W^\#)_{\gamma\gamma}$ per row" is discharged in F4. The provenance the block carries, *"Corollary (Reviewer 292)"*, is **true**: [REVIEW_r292.md](REVIEW_r292.md) proves the twin-clique classification and states the singleton-block corollary in its own words, and its recorded corrections (the division step restricted to $M_{ab}>0$, the "no defect machinery" gloss removed, the sharpness qualified) are all visibly absorbed into the current text.

## Verdict

**VERDICT: CONFIRMED**

Parts (i), (ii), (iii) and (iv) were each re-derived from the definitions without using the block, and every constant, every equality case and every anchor came out. Four independent checks pin the arithmetic: $\mathop{\mathrm{tr}}W^\#=-1$, $\sum_\gamma g_\gamma=4(n-1)$, $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$, and the balanced product returning $s_a=2/n$, $\theta=\theta_0(n)$ and the cap as an equality, all by hand, all in agreement.

**Three repairs owed, none of which moves a number or rescales any citation:**

1. **The normalisation label.** Replace *"with $\lVert\varphi\rVert^2=2$ throughout"* by the $\Lambda^2$ pairing $\lVert\varphi_{ab}\rVert^2=1$; as printed it contradicts the block's own "$R_{\gamma\alpha}$ is the indicator" two paragraphs later, and it is the wrong half of a genuine collision in [conventions.md](../findings/conventions.md), whose bullet *"A bivector's norm: $\lVert\varphi_{ab}\rVert^2=2$"* should say **Frobenius** explicitly. **F1.**
2. **Name both moved families.** $[\mathrm{ad}(\varphi_{ab}),W]$ sends $\varphi_{bd}\mapsto(M_{bd}-M_{ad})\varphi_{ad}$ *and* $\varphi_{ad}\mapsto(M_{bd}-M_{ad})\varphi_{bd}$; the block prints only the first, and the factor $2$ is not reconstructible from what is printed. **F3.**
3. **"The cap needs criticality and nothing else"** should read "criticality and hollowness"; hollowness is what makes the two dropped coordinates equal $M_{ab}^2$ in the very inequality the sentence quotes. **F6.**

Plus two housekeeping items: the broken in-file anchor at [line 475](../findings/diagonal-half.md#L475) (**F11**), and the "(ii) The entry cap, **unconditional**" label in [Lemma L130](../findings/diagonal-half.md) (**F10**).

**One free strengthening on offer:** the cap fails at $(a,b)$ **exactly** when the per-entry criticality residual exceeds $\tfrac14g_{ab}$, which proves "criticality is load-bearing" analytically and retires the sweep the block cites for it (**F8**).

*Analysis only throughout. No search, sweep, census or optimisation was run; no numerical claim in the block was re-measured, and the block's screened figures ($C_5$ blow-up $\Delta=12$, the $\theta_0(n)$ table at $n=6\dots20$, the violation maxima, the $n=6$ comparison at $1.080123$) are outside this review's scope and are neither confirmed nor disputed here.*
