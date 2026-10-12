# ELIM-stratum, elimination audit of [stratum-two-negative.md](../findings/stratum-two-negative.md) and [bispectral.md](../findings/bispectral.md)

Auditor ELIM-stratum. Both files read in full (476 + 437 lines). Pure algebra; no script was run, nothing was evaluated numerically. Every substitution below is written out and was derived twice by hand.

The test applied to every bound, reduction, equivalence and "what a successor needs": substitute $W^\#=\theta W-W^2$ (criticality), $\operatorname{Ric}(W)=0$, first Bianchi, $\operatorname{tr}W=0$, then ask what free variable survives.

---

## Survivors, quantities that genuinely escape $(\text{spectrum},\theta)$

### S1. The bracket tensor $T_{\alpha\beta\gamma}$, and the exact boundary at which criticality determines it

At a critical point $W^\#$ is diagonal in $W$'s eigenbasis with $(W^\#)_{\beta\beta}=\lambda_\beta(\theta-\lambda_\beta)$. In the eigenbasis expansion the record already uses, $(W^\#)_{\beta\beta}=\tfrac12\sum_{p,q}T_{\beta pq}\lambda_p\lambda_q$, so criticality is

$$\tfrac12\sum_{p,q}T_{\beta pq}\,\lambda_p\lambda_q\;=\;\lambda_\beta(\theta-\lambda_\beta)\qquad\text{for every }\beta. \tag{$\ast$}$$

That is $N$ linear equations on $T$. Their contraction against $\lambda_\beta$ is exactly $\langle W,W^\#\rangle=\theta-\operatorname{tr}W^3$, the known tautology. **The other $N-1$ are new, and neither file uses a single one of them.**

The survivor is precisely $T$ modulo $(\ast)$, and the boundary is sharp. With $r$ nonzero eigenvalues the live entries of $T$ number $\binom r3$ against $r$ equations:

| $r$ | $\binom r3$ | equations | verdict |
|---|---|---|---|
| 3 | 1 | 3 | **overdetermined**, see T1 |
| 4 | 4 | 4 | **determined**, closed algebra, see S4 |
| $\ge5$ | $>r$ | $r$ | genuinely free; this is where the conjecture lives |

So the ELIM collapse bites at rank $\le4$ and stops dead at rank $5$. That is the one-line summary of what these two files can and cannot reach.

### S2. The per-row Bianchi balance, $N$ equations where the record carries $1$

This needs no criticality. The record's own operator identity (Lemma L33 in [stratum-two-negative.md](../findings/stratum-two-negative.md)) is $\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W$. Evaluate its quadratic form at $v_\beta$, using $\langle v_\beta,\mathrm{ad}(v_\alpha)^2v_\beta\rangle=-\lVert[v_\alpha,v_\beta]\rVert^2$:

$$-\sum_\alpha\lambda_\alpha\lVert[v_\alpha,v_\beta]\rVert^2=2\lambda_\beta .$$

Substituting $\epsilon_{\alpha\beta}=2-\lVert[v_\alpha,v_\beta]\rVert^2$ and $\operatorname{tr}W=0$ gives $\sum_\alpha\lambda_\alpha\epsilon_{\alpha\beta}=2\lambda_\beta$, and $\epsilon_{\beta\beta}=2$ absorbs the right side:

$$\boxed{\ \sum_{\alpha\ne\beta}\lambda_\alpha\,\epsilon_{\alpha\beta}=0\quad\textbf{for every }\beta.\ }$$

The file records only the fully contracted scalar $\sum_{\alpha\ne\beta}\epsilon_{\alpha\beta}\lambda_\alpha\lambda_\beta=0$ (the paragraph beginning "The pair cap is loose by a factor of six"), presented as "verified to $10^{-15}$ across the catalogue". It is one contraction of $N$ equations, and it is a theorem rather than a measurement.

**What this buys immediately, in the file's own hardest gap.** For a stratum with $k$ positive eigenvalues and negatives $-a\ge-b$, rows $\beta=N-1$ and $\beta=N$ add to

$$\sum_{p\ \text{positive}}\lambda_p\big(\epsilon_{p,N-1}+\epsilon_{p,N}\big)\;=\;\sigma\,\delta,\qquad \delta:=\epsilon_{N-1,N},\ \ \sigma=\textstyle\sum_+\lambda .$$

The file treats $\delta$ as a free scan parameter and reports an overshoot window $0<\delta<0.005$ that it calls "the bridge", to be crossed by the *conjectured* $\epsilon_{\min}\le\frac2n(2-\lVert[X,Y]\rVert^2)$ whose "monotonicity in between is measured". The displayed identity is exact, needs no continuation ascent, and says what small $\delta$ means: the $\lambda$-weighted mean of the positive eigenvectors' bracket deficits against *both* negative directions is $\sigma\delta$. That is the quantitative near-padding statement the file says it is missing, and it is three lines from material already on the page.

### S3. $\min\omega$, and only $\min\omega$, in the bi-spectral route

At a critical point $\langle M^\#,M\rangle=\theta-p_3(\mu)$, so the bi-spectral identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ rearranges to

$$p_3(\omega)=3\,p_3(\mu)-2\theta .$$

**$p_3(\omega)$ is therefore not a survivor**, see T3. What *is* a survivor is the rest of $\omega$: its extreme eigenvalue, its majorization position, its cumulative sums. $-\min\omega$ is not a function of $(p_3(\mu),\theta)$, and the file's genuinely load-bearing results all use that and not $p_3(\omega)$, Reviewer 131's cap $\mu\le\sqrt{2(n-2)/(n-1)}$, and the bulk cumulative sums $\sum_{k\le j}d_k^\downarrow$ at $j\approx D/2$ that Reviewer 101 identified as what the relaxation actually consumes. That is the correct half of the route and it should be stated as "the second-kind *extreme eigenvalue and majorization data*", never as "the second spectrum's cubic".

### S4. What a successor should do with the $k\le2$ stratum

At $r=4$ (two positive $\lambda_1,\lambda_2$, two negative $-a,-b$) the live entries are $T_{123},T_{124},T_{134},T_{234}$ and $(\ast)$ at $\beta=1,2,3,4$ is a square linear system:

$$\begin{aligned} -a\lambda_2T_{123}-b\lambda_2T_{124}+ab\,T_{134}&=\lambda_1(\theta-\lambda_1)\\ -a\lambda_1T_{123}-b\lambda_1T_{124}+ab\,T_{234}&=\lambda_2(\theta-\lambda_2)\\ \lambda_1\lambda_2T_{123}-b\lambda_1T_{134}-b\lambda_2T_{234}&=-a(\theta+a)\\ \lambda_1\lambda_2T_{124}-a\lambda_1T_{134}-a\lambda_2T_{234}&=-b(\theta+b) \end{aligned}$$

Solve, then impose $T\ge0$ and the pair caps $\sum_\gamma T_{\alpha\beta\gamma}\le2$. The entire $k=2$ stratum at critical points becomes an explicit semialgebraic condition on $(\lambda_1,\lambda_2,a,b,\theta)$ with $\operatorname{tr}W=0$ and $\lVert W\rVert=1$, no $f(t)$ maximisation, no LP relaxation, no grid. This is the analytic replacement for the file's asserted-not-proved $k=2$ extension (see W4).

---

## Tautologies and collapses found

### T1. The whole of Lemma L29, at critical points, is three lines, and its "open equality clause" is closed

**Quoted claim.** *"Let $W\in\mathrm{Weyl}_n$ have $\lVert W\rVert=1$ and exactly one positive and two negative eigenvalues… Then $\theta(W)\le\sqrt{3/2}$… The converse (that equality forces that spectrum), is reduced to 'no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ for even $r\ge6$', excluded numerically at $r=6,8,10$ and untested at $r\ge12$."*

**The substitution.** Spectrum $(\lambda_1,-a,-b,0,\dots)$, so the only live entry is $T:=T_{1,N-1,N}$ ($T$ vanishes on repeated indices). $(\ast)$ at $\beta=1,\,N-1,\,N$:

$$\text{(i)}\ \ T\,ab=\lambda_1(\theta-\lambda_1),\qquad \text{(ii)}\ \ T\lambda_1b=a(\theta+a),\qquad \text{(iii)}\ \ T\lambda_1a=b(\theta+b).$$

Three expressions for one number. (ii)$=$(iii) gives $a^2(\theta+a)=b^2(\theta+b)$, so $a=b$ or $\theta=-\dfrac{a^2+ab+b^2}{a+b}$. Back-substituting the second branch into (ii), with $\theta+a=-b^2/(a+b)$, gives

$$T=\frac{a\cdot\big(-b^2/(a+b)\big)}{\lambda_1 b}=-\frac{ab}{\lambda_1^2}<0,$$

**impossible**, since $T=c'^2\ge0$. So $a=b$. Then $\operatorname{tr}W=0$ gives $\lambda_1=2a$, and (i) with (ii) gives $a^2(\theta+a)=\lambda_1^2(\theta-\lambda_1)=4a^2(\theta-2a)$, hence $\theta=3a$ and $T=(\theta+a)/\lambda_1=2$. Unit norm $6a^2=1$ then forces

$$a=b=1/\sqrt6,\quad\lambda_1=2/\sqrt6,\quad\theta=3/\sqrt6=\sqrt{3/2}.$$

**Verdict.** At critical points the lemma's entire apparatus, the pair cap, trace-freeness, the collapse to $f(t)=9\sqrt2\,t(t+1)/(4(t^2+t+1)^{3/2})$, the maximisation over $t\ge0$, is replaced by an overdetermined $3\times1$ linear system. The cap $T\le2$ is *never used*: $T=2$ comes out. And the converse the file leaves open, hedged on numerics at $r=6,8,10$ with $r\ge12$ untested, is **closed outright and dimension-free**: the only critical point in this stratum with $\theta>0$ has spectrum $(2,-1,-1)/\sqrt6$, and there is no other branch.

*The lemma's stated content (a bound over all unit $W$ in the stratum, not merely critical ones), is genuinely stronger and its $f(t)$ algebra checks out (I re-derived $f$ and $f(1)=\sqrt{3/2}$ by hand). What collapses is the part the conjecture actually needs.*

### T2. "The one inequality is an identity on this stratum", and the record proves it the long way

**Quoted claim.** *"Ricci-flatness here reads $\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$… the support of $W$ is exactly $\mathrm{im}\,v_1$, of even dimension $r$… at $r=4$ that is the self-dual family… where every orthonormal pair brackets to norm-squared $2$. So the pair cap is saturated identically."*

**The substitution.** Take S2's row identity at $\beta=1$. Among $\alpha\ne1$ only $N-1$ and $N$ carry nonzero $\lambda$, so

$$-a\,\epsilon_{1,N-1}-b\,\epsilon_{1,N}=0,\qquad a,b>0,\ \epsilon\ge0\ \Longrightarrow\ \epsilon_{1,N-1}=\epsilon_{1,N}=0 .$$

Then row $\beta=N$ reads $\lambda_1\epsilon_{1,N}-a\,\epsilon_{N-1,N}=0$, so $\epsilon_{N-1,N}=0$ as well. **All three pair caps saturate**, in three lines, with no Ricci-PSD support argument, no descent to $r=4$, no $\mathfrak{su}(2)$, and no dimension hypothesis. Feeding this into the record's own Lemma L31 (the cap's equality case) gives $\mathrm{im}\,v_1=\mathrm{im}\,v_{N-1}=\mathrm{im}\,v_N$ of dimension $4$, so $W$ is a padded $\mathrm{Weyl}_4$ element and $\theta\le\max_{\mathrm{Weyl}_4}\theta=\sqrt{3/2}$, an independent second closure of the same stratum, for *all* $W$ and not only critical ones, again dimension-free.

This also explains why the $k\ge3$ case is hard in exactly the right terms: at $\beta=$ a positive index with $k\ge2$, the row reads $\sum_{p\ne\beta,\,p>0}\lambda_p\epsilon_{p\beta}=a\epsilon_{N-1,\beta}+b\epsilon_{N,\beta}$, which forces nothing. The collapse is specific to $k=1$, and $\epsilon$ is the survivor everywhere else.

### T3. "$P$ is a function of two spectra" trades one unknown scalar for one unknown scalar

**Quoted claim.** *"Every route this document records that reached $P$ through the spectrum of $W$ on $\Lambda^2$ has failed, and the recorded reason was that the value lives in eigenspace alignment, which no spectrum sees. That diagnosis is half right. There is a second spectrum, and together the two determine $P$ exactly."*

**The substitution.** $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ is equivalent to $\langle M^\#,M\rangle=\tfrac12(p_3(\mu)-p_3(\omega))$. At a critical point $\langle M^\#,M\rangle=\theta-p_3(\mu)$, so

$$p_3(\omega)=3\,p_3(\mu)-2\theta .$$

The unknown alignment scalar $\langle M^\#,M\rangle$ has become the unknown spectral scalar $p_3(\omega)$, invertibly. As a statement about $\theta$ the "second spectrum" contributes **exactly one degree of freedom**, and it is the one that was already there.

**The file writes the collapse itself without naming it.** In "The maximiser's position in the bi-spectral plane": *"Its coordinates are $p_3(\mu)=2\sqrt2/(n\sqrt{(n-1)(n-2)})$… and $p_3(\omega)=3p_3(\mu)-2\theta_0(n)$."* That is the identity rearranged. Consequently the display

$$\tfrac32p_3(\mu)-\tfrac12p_3(\omega)-\theta_0(2m)=0\quad\text{identically in }m$$

is **forced** the moment $p_3(\mu)=\operatorname{tr}W^3$ and $\theta=\theta_0(2m)$ at the balanced product are known, both already on the record. It is a transcription check on Li Theorem 1.8, valuable as that, and it is not evidence about the conjecture. The heading "the identity closes symbolically" reads as a result; it is a consistency test.

*I verified the underlying spectrum by hand and it is correct:* multiplicities sum to $2m^2+m-1=\dim S^2_0$; $\sum\omega=A(m-1)[m(m+2)-m^2-2m]=0$; $\sum\omega^2=3A^2m^2(m-1)(2m-1)=3$; and $p_3(\omega)=A^3m^2(m-1)(-8m^3+16m^2-4m-1)$ which equals the file's $-(4m^2-6m-1)/(m\sqrt{(m-1)(2m-1)})$ since $-(4m^2-6m-1)(2m-1)=-8m^3+16m^2-4m-1$. The mathematics is right; the framing overstates it.

### T4. "The ceiling is exactly the target… identically in $n$" is $\theta_0$'s definition rewritten

**Quoted claim.** *"$\sqrt{\tfrac{2(n-2)}{n-1}}=\dfrac{n\,\theta_0(n)}{n-1}$ **identically in $n$**… Verified to $0$ at $n=6,8,10,12,20,100$."*

**The substitution.** $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, so $\dfrac{n\theta_0(n)}{n-1}=\dfrac{\sqrt{2(n-1)(n-2)}}{n-1}=\sqrt{\dfrac{2(n-2)}{n-1}}$. The two sides are the same radical written two ways; there is no $n$-dependence to verify and the six-dimension numerical check tests floating-point arithmetic. What is real here is Reviewer 131's cap $\mu\le\sqrt{2(n-2)/(n-1)}$, which is a theorem; the "coincidence" it is said to exhibit with branch 1's requirement is bookkeeping. *The parity remark attached to it (that the identity is even-$n$ only, because $\Theta_n<\theta_0(n)$ at odd $n$), is genuine content and survives.*

---

## Weak evidence

### W1. The exactly-$\tfrac12$ table is symmetry-forced, and it is the file's own item (iii)

**Quoted claim.** *"$C\le0\iff\langle E,L_eE\rangle\le\tfrac12$… **precisely Lemma L24's bound**… Computed on exactly that subspace at padded $W_{\mathbb{CP}^2}$: [$n=8$: 132 of 300, $0.500000$; $n=10$: 275 of 770, $0.500000$; $n=12$: 494 of 1638, $0.500000$], **Exactly $\tfrac12$, at every dimension.**"* Item 3 of the three owed is *"$\langle E,L_eE\rangle\le\tfrac12$ is computed at padded $W_{\mathbb{CP}^2}$, where it is exactly $\tfrac12$."*

Three separate defects, and they compound.

- **The $0.500000$ is the $O(n)$-orbit and cannot be anything else.** $\theta$ is $O(n)$-invariant, padded $W_{\mathbb{CP}^2}$ is a critical point (T1), and rotating its $4$-plane against the complement gives $4(n-4)=16,\,24,\,32$ orbit directions that *leave the padding*, inside the $132,\,275,\,494$ counted. Along them $\theta$ is constant, so $C=0$, so $\langle E,L_eE\rangle=\tfrac12$ exactly. With Lemma L24's ceiling the maximum is then forced. **This is the record's own general fact**: [results.md:165](../results.md#L165) states "$\tfrac12$ attained by orbit directions at every critical point", and [LEDGER.md:63](../findings/LEDGER.md#L63) states "every orbit direction is an $L_e$-eigenvector at exactly $\tfrac12$". The table restates a known theorem and is presented as three dimensions of evidence for item (iii).
- **Lemma L24 is invoked where it has no content.** [bounds.md:103](../findings/bounds.md#L103) records exactly this error: *"Lemma L24 says if $W$ is a maximizer then $\lambda_{\max}\le\tfrac12$. This record used the conclusion as a fact about critical points."* At $n=12$, $\theta(\text{padded }W_{\mathbb{CP}^2})=\sqrt{3/2}<\theta_0(12)$, so it is **not** the maximiser and Lemma L24 says nothing about it. The $n=12$ row of the table is Lemma L24 applied off its hypothesis.
- **[bispectral.md](../findings/bispectral.md) already has the right mechanism.** Its refutation of the stability statement says *"the form's top eigenvalue on $\mathcal W_n^{\text{off}}$ is exactly $\theta_0/2$ and that eigenspace **is** the $O(n)$-orbit, dimension $pq$, principal angles $1.000000$."* Same phenomenon, same number ($L_e=L_W/\theta$, so $\theta_0/2\mapsto\tfrac12$), correctly attributed. [stratum-two-negative.md](../findings/stratum-two-negative.md) attributes it to "being the maximiser, not having a two-dimensional negative eigenspace", closer than nothing, but the two files disagree and the bi-spectral one is right. The two should be reconciled, and item (iii) should be restated as owed at *non-orbit* directions only.

### W2. Normalisation-forced tightness in the second bound

**Quoted claim.** *"$\langle W,W^\#\rangle\le(\lambda_1+b)\big[(\sigma^2-p)+2ab\big]+b$, which is **exactly tight at padded $W_{\mathbb{CP}^2}$**, $0.816497$ against $0.816497$, at $n=6,8,12$ alike, with the $(\sigma^2-p)$ term vanishing there."*

At that point $k=1$ kills $\sigma^2-p$, and $a=b$, $\lambda_1=2a$ reduce the bound to $3a\cdot2a^2+a=6a^3+a$ against the true $6\lambda_1ab=12a^3$. Equality holds iff $6a^3+a=12a^3$, i.e. iff $6a^2=1$, which is **$\lVert W\rVert^2=\lambda_1^2+a^2+b^2=6a^2=1$**, the normalisation. The bound's mechanism (the $S_-=S_++2$ deficit transport, the interval $\sum_\gamma T_{\alpha\beta\gamma}\lambda_\gamma\in[-bu,\lambda_1u]$) contributes nothing to the tightness; the unit-sphere constraint does all of it. This is the third defect in the audit brief, exactly.

### W3. Claims resting on the catalogue and on random screens

- *"the recorded numerics put the stratum's true maximum at exactly $\sqrt{3/2}$"*, used to soften the $0.22\%$ overshoot. The catalogue is built from symmetric constructions; T1 now supplies the analytic version at critical points, which is what should carry that sentence.
- *"$\theta=9qr(q+r)/\lVert W\rVert^3$ **exactly**, to twelve digits at six $(q,r)$ and at $n=4,6,7$"*, the $\theta$ here is the value of $P$, and the family is **not critical** except at $q=r$ (T1). The paragraph reads as though the family were a family of critical points; it is a family of unit tensors. Worth stating, because the "one-parameter family, not a point" framing is what motivates the $C\le0$ programme, and the programme is about a neighbourhood of a *critical* point.
- *"Across $600$ orthonormal pairs at $n=12$… so a near-tight bracket does force a near-common kernel"*, followed by *"the constant relating them is not recorded from this"*. The file is honest that this is sampled. S2 replaces it with an exact identity; the $\epsilon_{\min}\le\frac2n\delta$ conjecture is not needed.
- *"Over random $K$ that are hollow, symmetric and have zero row sums… **Infeasible in all $42$ cells** across $n=6,8,12$… So **the joint relaxation is strictly below $4.0129$ everywhere**."* A positive claim from $6$ random samples per cell, and it is **refuted twenty lines later in the same file**, *"the $\mu$ side is feasible at $n=6$, $t=0.25$, so 'infeasible in all 42 cells' was wrong"*, with the earlier paragraph left unmarked. A reader arriving at the first paragraph is misled.
- *"the ratio $\lambda_{\max}(\mathring R_W)/\theta$ splits the catalogue by diagonality"*, the file itself calls this "a four-point pattern, not a finding" and notes only one point is in the stratum. Correctly self-flagged; listed for completeness.
- *"$30$ of $30$ samples"* for the projection killing positivity, and *"$-0.100$ to $+0.116$ on random points"* for sign-indefiniteness, are **legitimate** uses of random screens: both establish negatives, where one witness suffices.

### W4. The $k=2$ extension asserts a reason that does not cover the case

**Quoted claim.** *"**The Lemma extends to two positive eigenvalues, for the same reason.** $(+++)$ needs three *distinct* positive indices, so it vanishes at $k=2$ as well; maximising the resulting bound over the whole two-parameter family returns $\sqrt{3/2}$ again."*

The stated reason addresses only $(+++)$. The $(++-)$ block needs **two** distinct positive indices, and at $k=2$ there are two, so the block that Lemma L29's proof disposes of by "only one exists" is live here and the paragraph is silent on it. "Maximising the resulting bound" is asserted, and the resulting bound is not written down. S4 gives the analytic route that closes it at critical points.

### W5. Ascent landing on the same point at $n=12$ is symmetric criticality

**Quoted claim.** *"Above the crossover both directions land on the same point… **Below the crossover the two directions have different champions; at $n=12$ they coincide**, which is what the crossover *is*, made concrete."*

The balanced sphere product has an isotropy group under which $\mathbb R W$ is the only trivial summand of $\mathrm{Weyl}_n$; by symmetric criticality every $O(n)$-invariant polynomial's gradient there is parallel to $W$. So it is simultaneously critical for $p_3(\mu)$, $p_3(\omega)$ and $\theta$ *by symmetry*, whatever $n$, and the coincidence of the two landing points says the ascent converged to that symmetric point, not that the two directions' champions merged. The file's own caveat paragraph ("Ascent bounds each direction's maximum from below… consistent with Conjecture A rather than evidence for it") is right; the sentence above overstates against it.

### W6. Single-audited section left load-bearing

*"**SINGLE-AUDITED, Reviewer 103 full, Reviewer 104 killed mid-run.** The two-implementation guarantee the skill's design rests on is absent here; 103's corrections stand on one build."* Correctly flagged in place, and 103's corrections then propagate into the retraction of the stability statement and into "the maximisation over $K$ was the weak part, at every $t$". Those downstream conclusions inherit the single audit and do not repeat the flag.

### W7. Notation collision in [bispectral.md](../findings/bispectral.md)

$\mu$ is the $\Lambda^2$ spectrum throughout the file, then redefined as a scalar: *"$\mu:=-\min\omega=2m(m-1)A$"*. Both meanings are then used within a few paragraphs, *"$\mu\le\sqrt{\tfrac{2(n-2)}{n-1}}$"* (scalar) against *"$\mu\succ d_\varphi$ is a second, entirely unused Schur–Horn constraint"* (spectrum). A reader cannot disambiguate the boxed cap from the majorization without tracking which section defined it last.

---

## Clean

Claims that pass the substitution, listed by name. Where I re-derived the algebra by hand it is noted.

- **Lemma L29's $f(t)$ algebra.** $\lambda_1=a+b$, $6a^2(t^2+t+1)/3\cdot$…, re-derived: $a^2=1/(2(t^2+t+1))$, $\operatorname{tr}W^3+6\lambda_1ab=9ab(a+b)=9ta^3(1+t)$, giving $f(t)=9\sqrt2\,t(t+1)/(4(t^2+t+1)^{3/2})$ and $f(1)=\sqrt6/2$. Correct.
- **Lemma L30**, small negative eigenspace forces small support. The PSD identity $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ and the invariant $\dim U<n$ hypothesis; the stated scope correction against the rank-sum form is right.
- **Lemma L31**, the bracket cap characterised, via $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ from the root system, Cauchy–Schwarz, and the two equality steps. The recorded retraction of the $4s_1^2$ argument is correct and the replacement is sound.
- **Lemma L33**, one eigenvalue of one sign forces vanishing, via $\ker N_x\subseteq\bigcap\ker N_{y_i}$ and Lemma L32. The attribution to Besse §1.143 / Petersen–Wink 1.6 is honest about what is cited and what is new.
- **Lemma L34**, full-support witnesses at $m=6,8$ by summing two padded $W_4(q,r)$; linearity of both defining conditions is the whole proof and it holds. The consequence stated (that B0's descent is *unproved* rather than differently proved), is the right conclusion to draw.
- **$\operatorname{tr}(W^\#)=-\lVert W\rVert^2$.** Re-derived from Lemma L33's operator identity: contract $-\sum_\alpha\lambda_\alpha\lVert[v_\alpha,v_\beta]\rVert^2=2\lambda_\beta$ against $\lambda_\beta$. The file's justification ("$Q$ preserves the trace-free Weyl space") is weaker than the fact; the fact is right.
- **The Killing marginal** $\sum_\beta\epsilon_{\alpha\beta}=2(N-n+1)$ for $\beta\ne\alpha$. Re-derived: $2N-2(n-2)-2$; matches $20,42,72$ at $n=6,8,10$. Provable, so "verified at" understates it.
- **The coordinate-diagonal half of the stratum**, by the negative-edges-cover-the-support counting argument, together with the recorded correction that routing through $\max_{\mathrm{Weyl}_4}\theta$ is lossy (the true value there is $0$).
- **$\lambda_{\max}(\mathring R_W)=\max_{\text{frames}}\lambda_{\max}(K)$, $K$ hollow with vanishing row sums, $\lVert K\rVert_F^2\le2$ with equality iff coordinate-diagonal.**
- **Lemma L50**, the bi-spectral identity itself, and its Dai–Fu / Li attribution. Criticality-independent, and the index-order warning is load-bearing and correctly stated.
- **The $n\le5$ Lovelock syzygy**, with the two controls (the sample spans $\mathrm{Weyl}_4$ and $\mathrm{Weyl}_5$; $64$ polarisations), and the correction of fence post F2g's three inferences.
- **Lemma L52**, the shared-frame majorization coupling, *as corrected*: the penalties are the gap to $\theta_{\text{diag}}$, the discarded difference is sign-indefinite, exactness holds iff both operators are diagonal in one shared frame, and it loses to $\tfrac32(M_++m)$. The self-verdict "inert rather than absent" is the right one.
- **Lemma L54**, the two diagonals and rigidity at $t=2$. Karamata with equal sums and equal norms under strict convexity forces $\mu=d_\varphi$, $\omega=d$. *Note that this rigidity is itself normalisation-forced ($\sum d^2=\tfrac32t=3=\sum\omega^2$), which is why the file's own later verdict, "any bound that is exact at $t=2$ and monotone in diagonal information is $\ge\theta_0$ at every $t<2$", is the correct reading.*
- **Lemma L67**, the $\omega$-spectrum of the balanced product. Verified by hand: multiplicities sum to $2m^2+m-1$, $\sum\omega=0$, $\sum\omega^2=3$, and $p_3(\omega)$ matches.
- **$\mu=-\min\omega=\tfrac{n}{n-1}\theta_0(n)$ at the balanced product.** Verified: $\sqrt{2m^2-3m+1}=\sqrt{(2m-1)(m-1)}$, so both sides are $2\sqrt{m-1}/\sqrt{2m-1}$.
- **Reviewer 131's cap $\mu\le\sqrt{2(n-2)/(n-1)}$**, frame by frame through $\mu=v^{\mathsf T}K^Fv\le\mu_1(K^F)$ and $t_F\le2$, with the even-$n$ scope limit stated. The strongest thing in either file.
- **The min-$K$ lemma** $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$, and its sharpness at even $n$ on a perfect matching. Re-derived: the minimiser of $\lvert\min y\rvert$ at fixed $\sum y=0,\sum y^2=s$ over $M$ reals is $M-1$ equal negatives against one positive, giving $s=M(M-1)\alpha^2$; then $\max_a s_a\ge t/n$. *Presentational note only: the displayed vector $y=(\alpha,\dots,\alpha,-(M-1)\alpha)$ is described as "$M-1$ equal negatives against a single positive", which needs the unstated $\alpha<0$; the plain reading with $\alpha>0$ is the maximiser.*
- **$\tfrac32\max p_3(\mu)=1.4657>\theta_0(12)$**, hence no $\omega$-side improvement alone can close the conjecture. A clean, decisive negative.
- **"A lower bound on $\kappa$ is worth exactly nothing"**, with the provable majorization reason rather than the sampled one.
- **The retraction of the stability statement** $\theta\le\theta_0(n)+O(2-\kappa^2)$, and the replacement $\lambda'=\theta_0\frac{n-4}{2(n-2)}$, $C'=-\frac{3\theta_0}{2(n-2)}$ with the orbit deflated. This is the model of how the exactly-$\tfrac12$ phenomenon should be handled, and W1 is the same phenomenon handled worse.

---

## What a successor should take from this

1. **Use $(\ast)$.** Criticality gives $N$ equations on $T$, of which $N-1$ are unused. They determine $T$ completely when $\operatorname{rank}W\le4$ and are informative for every $r$.
2. **Use the row form of the deficit identity** (S2), not its contraction. It is $N$ equations, it needs no criticality, it saturates the pair caps in the $k=1$ stratum in three lines, and it gives $\sigma\delta$ as an exact weighted mean of the positive-side deficits, the bridge across $0<\delta<0.005$ that the file says is missing.
3. **Retire item (iii) in its current form.** Its evidence is an $O(n)$-orbit eigenvalue that is $\tfrac12$ at every critical point by symmetry, measured at one point that is not a maximiser at $n=12$.
4. **Stop quoting $p_3(\omega)$ as information.** At a critical point it is $3p_3(\mu)-2\theta$. Quote $\min\omega$ and the cumulative sums instead.
