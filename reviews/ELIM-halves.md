# ELIM-halves, elimination audit of [graded-half.md](../findings/graded-half.md) and [diagonal-half.md](../findings/diagonal-half.md)

*Analytical only; no script was run and no number was recomputed numerically. Every figure quoted below was rebuilt in closed form from the definitions, and where a rebuild disagrees with the file it is said so.*

Both files were read in full. The audit applies one test to every bound, reduction, equivalence and "what a successor needs": substitute $W^\#=\theta W-W^2$ (and, on the diagonal locus, $M^{\circ2}=\theta M-M^2+\mathop{\mathrm{diag}}(s)$), then ask what free variable is left. The two files fail it in different ways, [graded-half.md](../findings/graded-half.md) through quantities attached to a *grading*, [diagonal-half.md](../findings/diagonal-half.md) through quantities that look combinatorial and collapse to $(\text{spectrum},\theta)$.

---

## Survivors, what genuinely escapes $(\text{spectrum},\theta)$

Lead with these; they are the part of the audit that changes the next cycle.

### S1. The alignment sum $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$ is the *only* thing in the defect density that survives criticality

This is the general form of [Lemma L68](../findings/diagonal-half.md)(iii), and the file has it in pieces without assembling it. Start from the recorded decomposition $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ and the step [diagonal-half.md](../findings/diagonal-half.md) itself flags as unrecorded, $Q_\gamma=2(W^\#)_{\gamma\gamma}$. At a critical point $W^\#=\theta W-W^2$, so $(W^\#)_{\gamma\gamma}=\lambda_\gamma(\theta-\lambda_\gamma)$ at any eigenvector, and

$$g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}\;-\;4\theta\lambda_\gamma\;+\;4\lambda_\gamma^2 .$$

Everything after the first term is a function of $(\lambda_\gamma,\theta)$. **So the entire informational content of the Petersen–Wink density at a critical point (and hence of $\Delta=\sum_{\lambda_\gamma>0}g_\gamma$), is the alignment sum $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$**, which measures how the eigenbasis of $W$ sits against the Lie bracket. Confirmation that the identity is right: on the diagonal locus $R_{\gamma\alpha}$ is the "share exactly one index" indicator, $\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=s_a+s_b-2M_{ab}^2$, and substituting gives $g_{ab}=2(s_a+s_b)-4M_{ab}^2-4\theta M_{ab}+4M_{ab}^2=2(s_a+s_b)-4\theta M_{ab}$, exactly Lemma L68(iii).

Two consequences worth carrying:

- Any successor route that hopes to bound $\Delta$ must bound $\sum_{\gamma\in E_+}\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$ and nothing else; every other term it writes down will cancel.
- The file's own note *"Gate 2 owed on the one step that is not recorded: $Q_\gamma=2(W^\#)_{\gamma\gamma}$ per row, which with criticality pins $Q_\gamma=2(\theta\lambda_\gamma-\lambda_\gamma^2)$ instead of relaxing it into that class"* is the same observation caught in flight. It should be promoted from a parenthetical to the statement of Lemma L68, because it is what tells a reader which half of $g_\gamma$ is worth computing.

### S2. On the diagonal locus the free variable is the *arrangement*, not the spectrum

On this locus the eigenvalues of $W$ **are** the entries $M_{ab}$, so the multiset $\{M_{ab}\}$ is the spectrum. Then:

- $\lVert M\rVert_1=\sum|\lambda|$ and $\sum_a s_a=\mathop{\mathrm{tr}}M^2$ are spectral, hence carry nothing;
- $s_a=\sum_bM_{ab}^2$, $d_a^+$, $\mu_1(M)$ and $\Delta$ are **not**, they depend on which eigenvalue sits on which edge of $K_n$.

That is the precise survivor for the whole B1 programme, and it says what a proof must exploit: an inequality between the multiset of edge weights and their placement. Both live reductions in the file (the entry cap $2\theta M_{ab}\le s_a+s_b$ and the counting corollary $r\le2/\theta^2$), are of exactly this type, which is why they are the two that hold up.

### S3. The counting corollary is a genuine unconditional reduction

$K^2-\lambda K\succeq0$ forces every positive eigenvalue of $M$ to be $\ge\theta$, so $r\theta^2\le\mathop{\mathrm{tr}}M^2=2$; hence $r\ge2\Rightarrow\theta\le1<\theta_0(n)$ for every even $n\ge6$, and at the conjectured value $r=1$. Rebuilt and correct. It uses criticality (through the Laplacian identity, which needs the vertex equation at every pair), it is not the target rearranged, and it eliminates a branch outright. It is the strongest thing in either file.

### S4. Lemma L55 is true, sharp, and needs no criticality, but its proof is not on the record

The proof is three lines and is nowhere in the file (see W5). For each row, the $n-1$ off-diagonal entries satisfy $\sum_bK_{ab}=0$ and $K_{ab}\ge-m$ with $m=|\min K_{ab}|$; the extreme point of that polytope is $n-2$ entries at $-m$ and one at $(n-2)m$, giving $s_a\le(n-1)(n-2)m^2$, and summing over $a$ gives $t\le n(n-1)(n-2)m^2$. Equality forces every row into that shape, i.e. a perfect matching, and there $K_{ab}=(n-2)c$ on the matching, $-c$ elsewhere, $t=n(n-1)(n-2)c^2$, the stated extremizer, exactly attaining the bound. **Write those three lines into the file**; the lemma is currently the only numbered result in either file whose argument the record does not hold.

### S5. Off the diagonal locus, the effective weights $K_{ab}^2+U_{ab}$

The reformulation $v^{\mathsf T}(K^2-\lambda K)v=\tfrac12\sum_{a,b}(K_{ab}^2+U_{ab})(v_a-v_b)^2$ with $U:=\lambda K-K^{\circ2}-K^2$ hollowed is a real survivor: $U_{ab}$ carries $\lVert F_{(ab)}\rVert^2$ and $(W^\#)_{(ab),(ab)}$, i.e. the off-diagonal mass of $W$ on $\Lambda^2$, which is not a function of the pair-diagonal spectrum. The file's verdict (*"this is the form the identity should have been recorded in"*), is right.

---

## Tautologies found

### T1. The graded split of the criticality equation carries ZERO equations, not one

[graded-half.md](../findings/graded-half.md) records

$$\theta\lVert A\rVert^2=\mathop{\mathrm{tr}}A^3+\langle A,W^\#\vert_{\mathfrak p}\rangle,\qquad \theta\lVert B\rVert^2=\mathop{\mathrm{tr}}B^3+\langle B,W^\#\vert_{\mathfrak m}\rangle,$$

with *"each exact to $10^{-9}$ at $S^3\times S^5$ and at the $n=8$ non-equivariant witness"*, and concludes that **"the pair contains exactly one independent equation"**.

Substitute. $W$ is block-diagonal for the splitting, so $W^2=A^2\oplus B^2$ and $W^\#\vert_{\mathfrak p}=\theta A-A^2$. Then $\langle A,W^\#\vert_{\mathfrak p}\rangle=\theta\lVert A\rVert^2-\mathop{\mathrm{tr}}A^3$, and equation one reads

$$\theta\lVert A\rVert^2=\mathop{\mathrm{tr}}A^3+\theta\lVert A\rVert^2-\mathop{\mathrm{tr}}A^3 .$$

$0=0$. Identically, and the same for $B$. The reason is visible without algebra: both equations are $\langle A,\,Q(W)-\theta W\rangle=0$ and $\langle B,\,Q(W)-\theta W\rangle=0$, i.e. the criticality residual paired against two test directions, and the *same block of this file* proves $N:=Q(W)-\theta W=0$ unprojected. Pairing zero against anything gives zero. The count is not "one independent equation, not two"; it is **none**, and the sum being the definition of $\theta$ is a consequence of criticality rather than a constraint on $W$. The block that corrects an earlier overstatement overstates by exactly one itself.

This also disposes of what is built on the split: *"the second equation is the one to attack"*, r307's *"the move the pair supports is to eliminate $C$ between them"*, and the $10^{-9}$ verifications, which measure $\langle A,0\rangle=0$. What the equations *are* is two of the $\dim\mathcal W_n$ scalar components of one tensor identity, selected along $A$ and $B$, and the selection is a choice of grading, which is T2.

### T2. Every quantity in the "where the violating direction lives" table is a function of $(W,\sigma)$, and the file says so, four paragraphs earlier

[graded-half.md](../findings/graded-half.md) closes the section *"Where the violating direction does live, and this is the useful part"* with the block decomposition of the $\lambda_{\max}$ eigenvector, $0.7074$ on $\mathfrak m\times\mathfrak m$, $0.1853$, $0.0856$, $0.0217$, and draws the conclusion **"a successor should deform $B=W\vert_{\mathfrak m}$ rather than anything inside $\mathfrak p$."**

Reviewer 314, quoted in the same file, reports that the $n=8$ witness carries a **second** $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ splitting from which *"every figure this record argued over falls out of it exactly: $\lVert A\rVert^2=0.332496$, block traces $-0.214821$, Cauchy–Schwarz floor $0.019997$, cross-block Rayleigh $-0.290085$, and the eigenvector table $0.7074/0.1853/0.0856/0.0217$"*, that is, **this table**. And Reviewer 313 counts at least eight inequivalent gradings at the same point. The file then states the rule outright: *"any quantity defined from $\mathfrak p$ is a function of the pair $(W,\sigma)$ and never of $W$ alone."*

So "the violation lives on $\mathfrak m$" is a statement about a chosen involution, not about the witness. It is the fifth instance of the failure the record closed four routes for, and unlike the other four it is still standing as live guidance to a successor. The same applies to the sentence immediately above it, *"the violating direction is itself graded, it carries no mass off $\mathfrak p\oplus\mathfrak m$ at all"*: for a point carrying eight gradings, that is eight different claims.

### T3. The $\mathfrak p$-internal cross-block cannot separate the two loci in either direction

Proposed twice as the successor object, *"the natural candidate being the $\mathfrak p$-internal cross-block between simple factors, which vanishes by Schur at equivariance"* and *"the object V3's six closed routes never had"*. It is a $(W,\sigma)$ quantity, so:

- cross-block $\ne0$ for one $\sigma$ does not give non-equivariance, because $W$ may be equivariant for a different grading it carries;
- cross-block $=0$ for one $\sigma$ does not give equivariance, because Schur vanishing is a per-grading statement.

The separator is well posed only quantified (*"for every grading $W$ carries"*) and the file never quantifies it. The fence post below it then closes the route on one number ($-0.290085$) at one point, which r314 attributes to the *second* grading; so the closure is correct in outcome (the direction is inadmissible, $57.7\%$ of its mass outside $\mathcal W_n$) but its evidence is grading-indexed.

### T4. The canonical-grading mass bound has no bracket content at all

*"Which closes the mass route for arbitrary gradings and leaves it OPEN for the canonical one. Under this record's canonical choice $\mathfrak p=E_+$, r314 reports the mass bound holding at every point it tested."*

With $\mathfrak p=E_+$ the block mass is $\lVert A\rVert^2=\sum_{\lambda>0}\lambda^2$, a **spectral invariant of $W$**. So the surviving open question is an inequality between $\sum_{\lambda>0}\lambda^2$, $\#\{\lambda>0\}$ and $n$, with no bracket, no isotropy and no gradedness in it. It is not empty (from $\mathop{\mathrm{tr}}W=0$, $\lVert W\rVert=1$ one gets $\sum_{\lambda>0}\lambda^2\ge\tfrac1{2p}$ with $p=\#\{\lambda>0\}$, which is weaker than $p/\binom{n-1}2$ in the relevant range), but it cannot possibly separate equivariant from non-equivariant points except through their spectra, which is the job it was proposed for.

Worse, it is not well formed as written. The right-hand side $\lVert A_{\mathrm{equiv}}\rVert^2=\frac{p^2+q^2-n}{(n-1)(n-2)}$ is indexed by a **symmetric pair**, and $E_+$ names no pair: at $n=8$, $\dim\mathfrak p=13$ belongs to both $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$. The "live question the record had not distinguished" needs a statement before it needs a proof.

### T5. The diagonal half's Poincaré inequality is $\theta\le\frac{n-1}{n}\mu_1$ with the graph erased

This is the strongest collapse in either file, because the framing is explicitly *"the diagonal residual has left curvature entirely: it is a Poincaré inequality for a weighted graph"*. The boxed statement is

$$\sum_{i,j}M_{ij}^2\,(u_i-u_j)^2\ \ge\ \frac{2\mu_1^2}{n}.$$

Contract criticality $M^{\circ2}+M^2=\theta M+\mathop{\mathrm{diag}}(s)$ with the top eigenvector $u$ of $M$, using $s_i\equiv2/n$ on the vertex-transitive locus:

$$u^{\mathsf T}M^{\circ2}u=\theta\mu_1+\tfrac2n-\mu_1^2 .$$

The file's own Dirichlet identity $u^{\mathsf T}M^{\circ2}u=\tfrac2n-\tfrac12\sum_{ij}M_{ij}^2(u_i-u_j)^2$ then gives, with no inequality anywhere,

$$\sum_{i,j}M_{ij}^2\,(u_i-u_j)^2\;=\;2\mu_1\big(\mu_1-\theta\big).$$

**The edge weights cancel.** The Dirichlet energy of $u$ against the weights $M_{ij}^2$ is a function of $(\mu_1,\theta)$ alone at every vertex-transitive diagonal critical point, and the boxed inequality is, term for term,

$$2\mu_1(\mu_1-\theta)\ \ge\ \frac{2\mu_1^2}{n}\iff\theta\ \le\ \frac{n-1}{n}\,\mu_1 ,$$

which is the "single missing factor" the file states thirty lines earlier. Two forms of one statement, presented as a reduction of it. Check against the file's own numbers: $2\mu_1(\mu_1-\theta)$ at the balanced product is $2\cdot1.264911\cdot0.210818=0.533333333$ at $n=6$ and $2\cdot1.348400\cdot0.112367=0.303030303$ at $n=12$, the two values it reports, to the digit.

So "the diagonal residual has left curvature entirely" is true, and it has left the *graph* as well: what remains is a two-variable inequality between the top eigenvalue of $M$ and $\theta$.

### T6. The spectral-gap form, the "tersest form", and $n\mu(\mu-\theta)\ge\mu_1^2$ are all T5 again

- *"In its tightest form it is a spectral-gap statement"*: $\nu_2\big(\tfrac n2M^{\circ2}\big)\le1-\tfrac{\mu_1^2}2$.
- *"Tersest form"*: $\mu_1(M)^2+2\nu_2\big(\tfrac n2M^{\circ2}\big)\le\mathop{\mathrm{tr}}M^2$.
- *"The residual then reads, for whichever eigenvalue attains $\nu_2$"*: $n\mu(\mu-\theta)\ge\mu_1^2$.

The file itself supplies the collapse, in the section it labels a *"rigidity worth stating on its own"*: on the vertex-transitive locus criticality **is** $M^{\circ2}=\theta M-M^2+\tfrac2nI$, so $\nu(\mu)=1+\tfrac n2\mu(\theta-\mu)$ for every eigenvalue. Substituting turns each of the three displays into $n\mu(\mu-\theta)\ge\mu_1^2$ over $\mu\in\mathop{\mathrm{spec}}(M)\setminus\{0_{\mathbf1}\}$ (a statement in $(\mathop{\mathrm{spec}}M,\theta)$ with no matrix in it) and at $\mu=\mu_1$ it is verbatim $\theta\le\frac{n-1}n\mu_1$. The chain "missing factor $\to$ Poincaré $\to$ spectral gap $\to$ tersest form" is one inequality wearing four costumes, plus companion conditions at the non-top eigenvalues. The claim **"in its tightest form"** should be struck; the file already struck the parallel claim *"the matrix form constrains the whole spectrum, not one Rayleigh quotient"* on the same grounds, and did not propagate the correction.

### I28. The "rigidity" is criticality, and $\nu(\mu)=1+\tfrac n2\mu(\theta-\mu)$ is the record's own closed route in positive dress

*"And feeding criticality in gives a rigidity worth stating on its own … the Hadamard square of $M$ is a quadratic polynomial in $M$."* On the diagonal locus $W^2\leftrightarrow M^{\circ2}$ and $W^\#\leftrightarrow M^2$, so this display is $W^2=\theta W-W^\#$, criticality, rearranged, with $s_i$ set to $2/n$. Its corollary, that every scalar built from $M^{\circ2}$ at an eigenvector of $M$ equals $1+\tfrac n2\mu(\theta-\mu)$, is precisely the brief's $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$. **The record has this mechanism catalogued as the thing that kills routes and is here recording it as a discovery.**

One consequence to fix in the text: *"with $u$ also being the second eigenvector of $M^{\circ2}$ there"*, offered as why equality holds at the sphere products, is automatic at **every** vertex-transitive diagonal critical point, since $M^{\circ2}$ is then a polynomial in $M$. It distinguishes nothing.

### T8. Lemma L68(iv) is R14's shape, an identity, not a conversion

$$\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$$

is rebuilt and correct (sum $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ over positive edges, and $\sum_{+}M_{ab}=\tfrac12\lVert M\rVert_1$ because the row sums vanish). It is billed as *"route R10's conversion of defect into $\theta$ deficit, exact and with no estimate anywhere"*. Being exact is the problem: it rearranges to $\theta=\big(\sum_ad_a^+s_a-\tfrac12\Delta\big)/\lVert M\rVert_1$, so proving $\theta\le\theta_0$ through it is proving $\sum_ad_a^+s_a-\tfrac12\Delta\le\theta_0\lVert M\rVert_1$, the target with the same terms moved across. It is the R14 pattern exactly: a substitution presented as a reduction. It is worth keeping as a bookkeeping identity (both sides carry arrangement data, per S2), and it should stop being described as a conversion.

Similarly (iii)'s *"and exactly $\theta=\frac{s_a+s_b}{2M_{ab}}-\frac{g_{ab}}{4M_{ab}}$ at every positive edge"* is $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ divided by $4M_{ab}$. The file's own rider on the cap (*"which is $g_{ab}\ge0$ written out, not an independent argument"*), is honest and should be extended to this display.

### T9. The dichotomy "every graded critical point is either equivariant or $\Delta>0$" uses the crossing the same file marks UNSOUND

*"By the recorded equivalence, on a graded point $\Delta=0$ **iff** $W$ is $\mathrm{ad}(\mathfrak p)$-equivariant. So every graded critical point is either equivariant, where [Lemma L69](../findings/graded-half.md) applies … or non-equivariant, which is to say $\Delta>0$."*

The labelling table at the end of the same file rules: *"$\Delta=0\Rightarrow$ Lemma L69 applies, **UNSOUND off $\ker W=0$**. Padded $W_{\mathbb{CP}^2}$ has $\Delta=0$ vacuously and is equivariant for no symmetric subalgebra."* Padded $W_{\mathbb{CP}^2}$ at $n\ge12$ is slice-graded, has $\Delta=0$, has $\theta=\sqrt{3/2}\ge\sqrt{3/2}$, is not a sphere product, and is a local maximum on its slice. It falls in **neither** branch: Lemma L69 does not reach it (it is not equivariant for any grading) and V3-restricted does not reach it ($\Delta=0$). So the closing claim **"proving it closes the graded half outright, since a graded critical point is then either a sphere product covered by Lemma L69 or not a maximiser"** is false as stated, and holds only with "graded" read as (A) sign-graded, which by the file's own table is incomparable with the (C) sense Lemma L69 is proved in. The gap is not incidental: the point it lets through is the rival maximiser's padding.

---

## Weak evidence

**W1, the canonical mass bound rests on the catalogue.** *"r314 reports the mass bound holding at every point it tested, with r307's census supporting it."* r307's census is 18 graded critical points at $n=8$, built from symmetric constructions; that is evidence about the construction. Combined with T4 (the bound is spectral), the honest statement is that nothing has been tested that could have failed for a structural reason.

**W2, the association-scheme structure theorem rests on three points.** *"So on the vertex-transitive locus a diagonal critical point carries an association scheme, and the conjectured maximiser is the 2-class case."* The derivation supplies only $M\circ M\in\mathop{\mathrm{span}}\{I,M,M^2\}$; full Hadamard closure of the algebra is **measured**, at $S^3\times S^3$, $S^6\times S^6$ and the $C_5$ blow-up, three highly symmetric points, with the one non-vertex-transitive control failing by $0.18$. The deduction does go through when $M$ has exactly three distinct eigenvalues (there $\mathop{\mathrm{span}}\{I,M,M^2\}=\mathop{\mathrm{span}}\{I,J,M\}$, which contains $I$ and $J$ and is $\circ$-closed by the rigidity, so Bose–Mesner applies), **that special case should be stated as the theorem**, and the general $d$-class claim demoted to what it is.

**W3, "settled by enumeration" is settled to $n=24$.** *"Maximising over every feasible parameter set gives exactly $\theta_0(n)$ … at every even $n$ from $6$ to $24$."* The parameter enumeration is per-$n$ and finite; there is no argument for general $n$. "On that locus B1 is now settled by enumeration" should read "verified for $6\le n\le24$". The a-fortiori point (the enumeration runs over a superset of realisable SRGs) is sound and worth keeping.

**W4, equality "exactly at the sphere products" is forced by the two closed forms, not by the mechanism.** The chain's equality case is $\theta=\frac{n-1}n\mu_1$ with $\mu_1$ at its spectral cap $\sqrt{2(n-2)/(n-1)}$. But $\theta_0(n)=\frac{n-1}n\sqrt{2(n-2)/(n-1)}$ is an **identity between the two closed forms** (the file states it as such) and the balanced product is the configuration that attains the cap. So *"the equality case is the conjectured maximiser, exactly as it should be"* is arithmetic, not evidence that the inequality is the right one. This is the third flag of the brief, and it applies to all four costumes in T5/T6.

**W5, Lemma L55's proof pointer is broken.** *"the argument is in this file under 'It does NOT survive off the diagonal locus, and the failure is systema'"*, the title is truncated, and the section it names is about $K^2-\lambda K\succeq0$ and contains no min-entry argument. See S4 for the three lines that should replace the pointer.

**W6, two different $T_{\max}$ in one section.** *"$\mathop{\mathrm{tr}}M=0$ with $\mathop{\mathrm{tr}}M^2=2$ caps $\mathop{\mathrm{tr}}M^3$ at $2\sqrt2(n-2)/\sqrt{n(n-1)}$, so $\tfrac12\mathop{\mathrm{tr}}M^3\le1.2309$ at $n=12$, $99.6\%$ of the target from the spectrum alone."* That cap ignores $M\mathbf1=0$. Two paragraphs later the file uses the sharp cap $T_{\max}=2\sqrt2\,c_n$, $c_n=(n-3)/\sqrt{(n-1)(n-2)}$, which at $n=12$ gives $\tfrac12T_{\max}=1.21356$, i.e. $98.2\%$, and $E_0=2\theta_0-T_{\max}=0.044946$ is computed with the sharp one. The headline "$99.6\%$" is therefore in a superseded normalisation, and the same paragraph mixes $\theta$-scale ($1.2309$) with $2\theta$-scale ($0.0449$) figures without saying so.

**W7, the $\mathbb{HP}^3$ "coincidence" has no referent.** *"$\mathbb{HP}^3$ lands at $\theta=0.852943860$, which is numerically the ceiling this project's ungraded frontier measurements kept reaching … the coincidence is exact to nine digits."* The record's ungraded ceiling is stated twice in the same file as $0.900828$. Either the ceiling being matched is a different number that is not on the record, or the claim is wrong; as written it cannot be checked.

**W8, the Cauchy–Schwarz floor's tightness is Schur, not the bound.** Already flagged by the file (*"that floor is worthless off the equivariant locus"*), and correctly: $\lVert A\rVert^2=\sum_i(\mathop{\mathrm{tr}}A_i)^2/\dim\mathfrak p_i$ is an identity whenever $A$ is scalar on each block, so equality at $S^3\times S^5$ carries no information about the inequality. Recorded here only because the paragraph appears **twice, byte-identical**, at [graded-half.md:219](../findings/graded-half.md#L219) and [graded-half.md:227](../findings/graded-half.md#L227).

---

## Editorial defects that change what a reader concludes

**E1, a withdrawn rebuttal is restated as live, eight lines after its withdrawal.** [graded-half.md:221](../findings/graded-half.md#L221): *"$A$ is the block of a grading, and the witness's eigenspace splitting IS one, an earlier rebuttal here is WITHDRAWN … r308 was right."* [graded-half.md:229](../findings/graded-half.md#L229): *"$A$ is the block of a GRADING, and the spectral split is not one, settled by a bracket test with controls … That is refuted here."* These are direct contradictions on the same measurement, with opposite verdicts on r308 and opposite bracket-defect figures ($2.1\times10^{-15}$ against $3.6\times10^{-1}$). The later one is the withdrawn text. A reader arriving at line 229 has no way to know it is dead. Delete it, or mark it.

**E2, the same fence post appears twice, byte-identical**, at lines 219 and 227, with the withdrawn/live pair sandwiched between them. The section reads as three overlapping drafts stacked.

**E3, cross-file collision on $0.375$, $0.3333$, $0.375$, $0.400$.** [graded-half.md:272](../findings/graded-half.md#L272) reports these as $\lambda_{\max}$ **on the slice** $V=\mathop{\mathrm{fix}}(\Lambda^2\sigma)$ (dimension $155$ at $n=8$) at $(3,5),(4,4),(5,5),(6,6)$, and concludes *"the point is a strict, isolated, nondegenerate local maximum there, owing nothing to third order."* [diagonal-half.md:137](../findings/diagonal-half.md#L137) and [diagonal-half.md:141](../findings/diagonal-half.md#L141) report the identical four numbers as the **diagonal-locus** $\lambda_{\max}$, with closed form $\frac{M-2}{2(M-1)}$, $M=\max(p,q)$, which reproduces all four exactly, and proves the diagonal restriction is *strictly lossy at every sphere product*, the full space reaching $0.500$ where the diagonal sees $0.375$. Either $\lambda_{\max}\vert_V$ coincides with $\lambda_{\max}\vert_{\text{diag}}$ at four distinct splits (asserted nowhere, and it would need the slice's top direction to be diagonal), or graded-half is quoting diagonal figures for the slice, in which case its local-maximum conclusion is unsupported. **This one is worth resolving before anything else in either file**, because graded-half's repair of the C3 non-sequitur rests entirely on those four numbers.

**E4, $\dim\mathfrak k(W)=32$ against an algebra of dimension 31.** [graded-half.md:340](../findings/graded-half.md#L340) gives padded $W_{\mathbb{CP}^2}$ at $n=12$ as $\dim\mathfrak k(W)=32$ and names the algebra $\mathfrak{su}(2)\oplus\mathfrak{so}(8)$, which has dimension $3+28=31$. The stabiliser is $\mathfrak u(2)\oplus\mathfrak{so}(8)$, dimension $4+28=32$, consistent with the $n=8$ figure $\dim\mathfrak k=10=4+6$. The exclusion argument survives the correction (neither $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ nor $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ has a simple ideal that can map into $\mathfrak u(2)$, so both would have to sit inside $\mathfrak{so}(8)$, and $30>28$), but it is **not** the dimension count that settles $n=8$ and $n=10$, and the sentence *"the same count holds at $n=10$"* invites reading it as one.

**E5, $p,q$ are overloaded** across [graded-half.md](../findings/graded-half.md): $p=\dim\mathfrak k,\ q=\dim\mathfrak m$ in the two-eigenvalue ansatz and in Lemma L8's formula, versus $p,q$ = sphere dimensions in $\lVert A\rVert^2=\frac{p^2+q^2-n}{(n-1)(n-2)}$ and throughout Lemma L69. Both conventions appear within a few paragraphs of each other.

---

## Clean, checked by substitution or rebuilt in closed form, and passing

Each of these I rebuilt independently; they are listed by name only.

- **The Dimension Lemma.** $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\tfrac16$, Cauchy–Schwarz step and the rearrangement both correct.
- **$n^2-12n+8$, all four appearances.** $\theta_0^2\ge\tfrac32$; $\tfrac16\ge\frac{n^2}{8(n-1)(n-2)}$; $\frac{n(n-2)}4>\frac{3n^2(n-1)}{2(7n-4)}$; and (with $n^2-7n-54$) Lemma L69's $p=5$ case. The same polynomial each time, genuinely.
- **The reducible partition argument.** $f(m)=\frac m{8(m-1)}$ decreasing and convex, $kf(n/k)=\frac{kn}{8(n-k)}$ increasing in $k$, minimum at $k=2$ balanced.
- **[Lemma L69](../findings/graded-half.md)'s split arithmetic.** $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$; $p=4$ gives $q\ge n$; $p=5$ gives $n^2-7n-54\ge0$, root $(7+\sqrt{265})/2=11.639$, hence $n\ge12$. Correct, and the $\tfrac18$ really does cancel.
- **Class 3.1 Type II.** $\lVert W\rVert^2=\frac{n(n-3)}{16(n-1)}$ rebuilt from $\lambda=\tfrac14$ on $\mathfrak g$ and $c=\frac1{2(n-1)}$; $3n^2-17n+8\ge0$ from $n\ge6$; $\mathfrak{su}(3)$ at $\tfrac5{14}$, $\theta=\sqrt{7/10}$.
- **$\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$** and $c=\frac1{2(n-1)}$ universal, from $\mathop{\mathrm{tr}}R=n/4$.
- **The closed forms.** $\theta^2(\mathbb{CP}^m)$, $\theta^2(\mathbb{HP}^m)$ (values at $m=2,3,4$ and the limit $\sqrt2/3$), $\theta^2(\mathrm{Gr}_{\mathbb C}(p,q))$ against both tabulated values ($14/27$, $275/774$), and the elementary positivity of $34m^3-12m^2+3m+2$.
- **$S_{\mathfrak{mmm}}=\frac{12(m-2)(m-1)(m+1)(2m+1)}m$** at $m=2,3,4,5$ against the measured $0,224,810,\tfrac{9504}5$.
- **$\lVert A\rVert^2=\frac{\dim\mathfrak p}{\binom{n-1}2}$ at the equivariant point**, rebuilt from the Einstein normalisation at $S^3\times S^5$: $\kappa_3=\tfrac14$, $\kappa_5=\tfrac18$, $c=\tfrac1{14}$, block masses $300/630$ and $90/630$, total $13/21=0.619048$, and $\lVert W\rVert^2=45/224$ giving $\theta=1.115547$.
- **$n=13$:** $\theta^2=120/77$ for $S^6\times S^7$ against $\theta_0^2=264/169$.
- **Diagonal functional.** $\theta=\tfrac12(\sum_{a,b}M_{ab}^3+\mathop{\mathrm{tr}}M^3)$ from the triangle count.
- **[Lemma L68](../findings/diagonal-half.md)(i).** $g_{ab}=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2$, including the hollowness step that drops exactly $2M_{ab}^2$.
- **Lemma L68(ii).** Twin characterisation, transitivity of linkage, block-constancy across component pairs, and Reviewer 292's singleton corollary, all correct.
- **Lemma L68(iii), (iv).** The substitution and the summation, both exact; (iii) rebuilt as an equality at the balanced product, where $\frac{s_a}{\alpha}=\frac{\sqrt{(p-1)(2p-1)}}p=\theta_0(2p)$ exactly.
- **The $\theta_0$ decomposition.** $\theta_0(n)=\sqrt2\,c_n+\frac{2\sqrt2}{n\sqrt{(n-1)(n-2)}}$ verified as an identity, and the second term rebuilt as $\sum_{a<b}M_{ab}^3=\frac1{p\sqrt{(2p-1)(p-1)}}$ at the balanced product, the claim that it *is* $\mathop{\mathrm{tr}}W^3$ there is correct.
- **$\max\sum x^3=s^{3/2}\frac{k-2}{\sqrt{k(k-1)}}$** applied spectrally ($k=n-1$) and row-wise ($k=n-1$), same $c_n$; monotonicity in $k$ makes the row-wise use a valid bound.
- **$\mu_1\le\sqrt{2(n-2)/(n-1)}$** and $\theta_0(n)=\frac{n-1}n\mu_1^{\max}$ identically.
- **The contraction identity** $u^{\mathsf T}M^{\circ2}u=\theta\mu_1+\sum_is_iu_i^2-\mu_1^2$ and its equivalence to $u^{\mathsf T}M^{\circ2}u\le\frac{2-\mu_1^2}n$.
- **The counting corollary** $r\le2/\lambda^2$ and $r\ge2\Rightarrow\theta\le1$.
- **$E$ hollow at every $W$**, and the multiplier argument $v=0$ in the Euler–Lagrange equation.
- **The second-order operator** $\mathcal L(N)=M\circ N+\tfrac12(MN+NM)=\tfrac12D\Phi(M)[N]$, and the hollowing correction to $\tfrac12D[\Phi-\mathop{\mathrm{diag}}(s)]$.
- **The direct-sum scaling** $\theta=(\sum_i\theta_i^{-2})^{-1/2}$ and the admissibility condition $\sum_ca_c\theta_c^{-2}=0$.
- **[Lemma L55](../findings/diagonal-half.md)**, statement and sharpness both correct (proof supplied at S4).
- **The gap $\frac1{2(M-1)}$** between $\frac{M-2}{2(M-1)}$ and $\tfrac12$, consistent across both files.
