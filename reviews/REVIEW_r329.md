# Review r329, is Lemma L71 non-vacuous, and does it do anything?

**Reviewer 329, adversarial, cold brief.** Everything measured below comes from an implementation written from the definitions alone, [scripts/reviewers/r329/](../scripts/reviewers/r329/), built without reading any script of this record. It is validated before use: the structure constants of $\mathfrak{so}(n)$ are totally antisymmetric with row mass exactly $2(n-2)$; the Weyl space is cut out by an SVD null space and has dimension $35,84,300$ at $n=5,6,8$, matching $n(n+1)(n+2)(n-3)/12$; $Q$ maps $\mathcal W_n$ into $\mathcal W_n$ to $10^{-15}$ at random $W\in\mathcal W_n$; the balanced products return $\theta=\theta_0(n)$ to twelve digits at $n=6,8,10$ with criticality residual $\le2.1\times10^{-16}$ and distance from $\mathcal W_n\le3.4\times10^{-15}$. All subspace work is SVD-based.

## Verdicts

| claim | verdict |
| --- | --- |
| **P4b**, does Lemma L71 constrain any non-saturating critical point? | **NO. CONFIRMED as a pure rigidity statement with no route to the conjecture.** Its only contrapositive content at a non-saturating point is "$D>0$", and at a critical point $D\equiv\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max}-\theta)$, so "$D>0$" *is* [Lemma L70](../findings/bounds.md)'s inequality, the one already known to be useless ($3.162$ against $1.054$ at $\mathbb{CP}^3$) |
| **P4a**, substantive, or a definition restated? | **SUBSTANTIVE, and NOT a third R14.** It is not recoverable from the prior record: before it, saturation gave only $\theta\ge\theta_0(n)$ (r324), which leaves a saturating point with $\theta>\theta_0$ open, a would-be counterexample at $n\ge12$. Lemma L71 closes that. The content is defensive, not progressive |
| **P4c**, another saturating critical point at $n\ge5$? | **None found**; search stopped on instruction and reported as supporting evidence only |
| **P1**, the ideal argument | **CONFIRMED, every link.** Span-vs-set survives; "every summand maps $\mathfrak g'$ into $\mathfrak g'$" *is* enough; $\mathfrak m\ne0$ is free; $\mathfrak{so}(6)=\mathfrak{su}(4)$ is simple |
| **P2**, the consequences | **CONFIRMED**, with one **REFUTED AS STATED**: the triality remark does not close the step it is placed at. Cartan classifies up to $\mathrm{Aut}$; the lemma needs $O(n)$-conjugacy, and at $n=8$ those differ |
| **P3**, the four withdrawals | **CONFIRMED and complete** for the four. But **two further defects stand**: the mass law's displayed equation mixes two mass conventions (factor $2$ on $M$), and the two claims imported from r327 in the same passage are both **REFUTED AS STATED** |
| **r327's "saturation forces $\ker W=0$ outright"** | **REFUTED as unscoped.** $W_{\mathbb{CP}^2}$ at $n=4$ saturates with $\dim\ker W=3$ |
| **r327's "$n=4$: the saturating critical points are $\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$"** | **REFUTED AS STATED.** Those four are exactly the critical points; only the two with $\theta>0$ saturate. Slack is $0$ at $+W_{\mathbb{CP}^2}$ and $+S^2\times S^2$, and $1.2247448714$ and $0.8660254038$ at the minus points |

---

## P4, the one that matters

### P4b. Lemma L71 says nothing about any non-saturating critical point, and cannot

This is the verdict. Lemma L71 is a conditional whose antecedent is $D(v)=0$. At a critical point that antecedent fails, and the only thing the lemma then yields is its contrapositive: *if $W$ is critical at $n\ge5$ and is not the balanced sphere product, then $D(v)>0$.* That is worth nothing, and the record already knows why. [Reviewer 323](REVIEW_r323.md)'s identity, restated in [bounds.md](../findings/bounds.md), is

$$D(v)\;=\;\lvert\lambda_{\min}\rvert\big(\lambda_{\min}+(n-2)\lambda_{\max}-\theta\big)\qquad\text{identically at every critical point.}$$

So "$D>0$" and "$\theta<\lambda_{\min}+(n-2)\lambda_{\max}$" are the same sentence, and the second is [Lemma L70](../findings/bounds.md)'s inequality, whose right-hand side reaches $3.162$ against $\theta_0(6)=1.054$ at $\mathbb{CP}^3$. Strictness buys no gap, because no gap is quantified. Turning the strictness into a bound is precisely route R14 (bound $D$ from below) which the record has already closed as a tautology for the same reason.

The asymmetry is worth stating positively: **Lemma L70's bound is tight exactly where the conjecture is already easy, and Lemma L71 is a theorem about that tight locus.** Conjecture A is hard where the bound is loose, and the loose region is untouched. Every one of the $30$ critical points I solved at $n=5$ and $39$ at $n=6$ lies in it, slack $0.394806$ to $1.227130$ at $n=5$, $0.780770$ to $1.309362$ at $n=6$, all with criticality residual $\le1.1\times10^{-15}$ and distance from $\mathcal W_n\le1.7\times10^{-15}$.

**Verdict: Lemma L71 is a rigidity statement with no route to the conjecture. It should be recorded as one.**

### P4a. It is nonetheless not a third instance of a definition restated

The comparison with R14 and the LP sharpness table does not hold, and the reason is specific. A restated definition adds no exclusion; Lemma L71 adds one.

- **What the record held before it.** [Reviewer 324](REVIEW_r324.md): $D(v)=0$ forces $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)$, $\theta=(n-1)\lvert\lambda_{\min}\rvert$, and $\theta\ge\theta_0(n)$, *with equality iff two eigenvalues of multiplicities $n^2/4$ and $n(n-2)/4$.*
- **What that leaves open.** A saturating critical point with three or more eigenvalues would have $\theta>\theta_0(n)$ **strictly**, at $n\ge12$ that is a counterexample to Conjecture A. r324's inequality points the wrong way, so the prior record could not rule this out.
- **What Lemma L71 does.** It shows the strict case is empty for $n\ge5$, so the saturating locus is exactly $\{$balanced sphere product$\}$ and $\theta=\theta_0$ there.

So its value is defensive: it removes a family of would-be counterexamples that the record could not otherwise exclude. That is genuine, and it is also the whole of it.

The honest qualification on "substantive" is that the argument is short and the condition is very restrictive. Saturation says $\mathrm{ad}(v)$ is supported on $\mathfrak m\otimes\mathfrak h$ for every $v\in\mathfrak m$, which is a $\mathbb Z/2$-grading of $\mathfrak{so}(n)$ written in bracket coordinates; naming it a symmetric pair is a change of language. The one step that is not a translation is killing $\mathfrak r$ by simplicity (five lines) and after that Cartan does the rest. **Substantive, narrow, and correctly scoped as rigidity.**

### P4c. Search, supporting evidence only

Stopped where instructed. What it covered, all with my own criticality residual and my own SVD distance from $\mathcal W_n$:

| point | $n$ | $\theta$ | criticality residual | dist from $\mathcal W_n$ | slack |
| --- | --- | --- | --- | --- | --- |
| balanced $\mathfrak{so}(3)+\mathfrak{so}(3)$ | $6$ | $1.054093$ | $2.2\times10^{-16}$ | $2.2\times10^{-15}$ | $-0.000000000$ |
| balanced $\mathfrak{so}(4)+\mathfrak{so}(4)$ | $8$ | $1.145644$ | $2.1\times10^{-16}$ | $2.7\times10^{-15}$ | $+0.000000000$ |
| maximal torus | $6$ | $0.645497$ | $6.8\times10^{-17}$ | $1.9\times10^{-15}$ | $+1.290994449$ |
| maximal torus | $8$ | $0.540062$ | $3.1\times10^{-17}$ | $2.2\times10^{-15}$ | $+2.160246899$ |
| padded $W_{\mathbb{CP}^2}$ | $5,6,7,8$ | $1.224745$ | $\le2.1\times10^{-15}$ | $\le2.7\times10^{-15}$ | $0.8165,\,1.6330,\,2.4495,\,3.2660$ |
| padded $S^2\times S^2$ | $5,6,7,8$ | $0.866025$ | $\le2.3\times10^{-16}$ | $\le2.6\times10^{-15}$ | $0.5774,\,1.1547,\,1.7321,\,2.3094$ |
| $\mathbb{CP}^3$ padded | $6$ | $1.054093$ | $2.2\times10^{-15}$ | $1.3\times10^{-15}$ | $+2.108185107$ |
| $\mathbb{CP}^4$ padded | $8$ | $0.986013$ | $2.8\times10^{-15}$ | $1.9\times10^{-15}$ | $+3.944053189$ |
| $\mathfrak u(3)$, $\mathfrak u(4)$ | $6,8$ | $0.878410$, $1.050174$ | $0.458$, $0.340$ | $0.745$, $0.764$ | $-0.351$, $-0.286$ |
| unbalanced $\mathfrak{so}(p)+\mathfrak{so}(q)$ | $5$–$8$ |, | $0.053$–$0.340$ | $0.258$–$0.764$ | $-0.286$ to $-0.042$ |
| Newton solves from random starts | $5$ |, | $\le9.7\times10^{-16}$ | $\le1.2\times10^{-15}$ | $0.394806$–$1.227130$ ($30$ points) |
| Newton solves from random starts | $6$ |, | $\le1.1\times10^{-15}$ | $\le1.7\times10^{-15}$ | $0.780770$–$1.309362$ ($39$ points) |
| diagonal $\mathcal W_6$ (dim $9=n(n-3)/2$) | $6$ |, | $0.43$–$0.59$ | $\le1.1\times10^{-15}$ | $1.01$–$1.42$ |

**Two things in that table are worth keeping.** First, the structured families the record's screening rule names (diagonal, padded, subalgebra-Casimir, sphere products, $\mathbb{CP}^m$, tori), were all included, and the diagonal family was constructed as an SVD intersection rather than sampled, so it is the family a random draw cannot see. Second, **negative slack appears, and it is not a violation of $D\ge0$**: the unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$ operators return slack down to $-0.351$, and every one of them is both non-critical (residual $0.05$–$0.46$) and *not a Weyl tensor at all* (distance $0.26$–$0.76$ from $\mathcal W_n$). $D\ge0$ is asserted only at critical points of $\mathcal W_n$; these are neither. This is the trap the record has been caught in before, and it is live in exactly this table.

---

## P1, the ideal argument. Every link holds

**The support condition.** $\operatorname{tr}W=0$ and $W\ne0$ give $\lambda_{\min}<0<\lambda_{\max}$ ($\lambda_{\max}=0$ would force $W\preceq0$ with zero trace). For eigenvalues of $W$, $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_{\max}$ with equality iff $\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}$: same signs give $\lambda_a\lambda_b\ge0>\lambda_{\min}\lambda_{\max}$, and for $\lambda_a<0<\lambda_b$, $\lvert\lambda_a\lambda_b\rvert\le\lvert\lambda_{\min}\rvert\lambda_{\max}$ with equality only at both extremes. $D(v)$ is then a sum of nonnegative terms, so $D\equiv0$ on $\mathfrak m$ kills each: $c_{vab}=0$ for $v\in\mathfrak m$ unless $(a,b)\in\mathfrak m\times\mathfrak h\cup\mathfrak h\times\mathfrak m$. It holds for all $v\in\mathfrak m$, not a chosen one, because $v\mapsto c_{vab}^2$ is a nonnegative quadratic form and the sum vanishes identically on $E_{\min}$. Total antisymmetry of $c$ then gives the three inclusions verbatim.

**Span versus set, the Jacobi step survives.** $[\mathfrak m,\mathfrak m]$ must be read as the span, and that is the reading under which the argument works. $\mathrm{ad}(H)$ is linear, so it suffices to check it on the generators $[x,y]$, $x,y\in\mathfrak m$: $[H,[x,y]]=[[H,x],y]+[x,[H,y]]$ with $[H,x],[H,y]\in\mathfrak m$, so both terms are in $[\mathfrak m,\mathfrak m]$, and linearity extends this to the span. **The displayed chain $[[\mathfrak m,\mathfrak m],[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,[\mathfrak m,[\mathfrak m,\mathfrak m]]]$ is not a containment of sets as written** (r328 flagged this already) but the conclusion is immediate from the same expansion, or, once $\mathfrak h$ normalises $[\mathfrak m,\mathfrak m]$, from $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$.

**"Every summand maps $\mathfrak g'$ into $\mathfrak g'$" is enough.** The brief's worry (that $\mathfrak g'$ is a sum of two of three summands), does not bite. Being an ideal means $[\mathfrak{so}(n),\mathfrak g']\subseteq\mathfrak g'$; $\mathfrak g'$ is a subspace, $\mathrm{ad}$ is linear in its first argument, and $\mathfrak m\cup\mathfrak h\cup\mathfrak r$ spans $\mathfrak{so}(n)$. So checking $\mathfrak m$, $\mathfrak h$, $\mathfrak r$ separately settles it:

$$[\mathfrak m,\mathfrak g']\subseteq[\mathfrak m,\mathfrak m]+[\mathfrak m,\mathfrak h]\subseteq\mathfrak g',\qquad [\mathfrak h,\mathfrak g']\subseteq\mathfrak m+[\mathfrak m,\mathfrak m]=\mathfrak g',\qquad [\mathfrak r,\mathfrak g']=0 .$$

Which two of the three summands $\mathfrak g'$ happens to meet is irrelevant to the argument.

**Simplicity, with one wording correction.** $\mathfrak{so}(n)$ is simple for $n=3$ and for every $n\ge5$; $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is the only failure. So "simple for $n\ge5$" is true, but *"exactly $n\ge5$"* would be false, $\mathfrak{so}(3)$ is simple too. Harmless here, since $\dim\mathcal W_3=0$. $n=6$ is fine: $\mathfrak{so}(6)\cong\mathfrak{su}(4)$ is simple.

**$\mathfrak m\ne0$ is free**, and needs no assumption on $\theta$: $\operatorname{tr}W=0$ with $W\ne0$ forces $\lambda_{\min}<0$, so $E_{\min}\ne0$. ($\operatorname{tr}W=0$ on $\mathcal W_n$ verified independently: $\lvert\operatorname{tr}W\rvert\le5.3\times10^{-15}$ at random $W\in\mathcal W_n$, $n=5,6,8$.) Likewise $\mathfrak h\ne0$ by definition, which the write-up does not need to say but which the symmetric-pair conclusion quietly uses.

**Measured at the balanced products**, in my own eigenbasis, all masses exact zeros rather than roundoff:

| $n$ | $\dim\mathfrak m/\mathfrak h/\mathfrak r$ | $[\mathfrak m,\mathfrak m]$ off $\mathfrak h$ | $[\mathfrak m,\mathfrak h]$ off $\mathfrak m$ | $[\mathfrak m,\mathfrak r]$ | $\dim[\mathfrak m,\mathfrak m]$ | $[\mathfrak h,\mathfrak h]$ off $\mathfrak h$ |
| --- | --- | --- | --- | --- | --- | --- |
| $6$ | $9/6/0$ | $0$ | $0$ | $0$ | $6=\dim\mathfrak h$ | $0$ |
| $8$ | $16/12/0$ | $0$ | $0$ | $0$ | $12=\dim\mathfrak h$ | $0$ |

and $\dim\mathfrak m+\dim[\mathfrak m,\mathfrak m]=N$ in both.

---

## P2, the consequences. One reason is not the reason

**The chain confirmed.** $\mathfrak g'$ a nonzero ideal in a simple algebra gives $\mathfrak g'=\mathfrak{so}(n)$; with $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ and $\mathfrak m\perp\mathfrak h$ this forces $\mathfrak r=0$ and $[\mathfrak m,\mathfrak m]=\mathfrak h$, hence two eigenvalues, hence $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ and a symmetric pair. With r324's ratio and $\dim\mathfrak m+\dim\mathfrak h=N$, $\operatorname{tr}W=0$ gives $\dim\mathfrak m=n^2/4$, $\dim\mathfrak h=n(n-2)/4$.

**The dimension count is right and the case list is genuinely unnecessary.** $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=(p^2+q^2-n)/2=n^2/4+t^2-n/2$ with $p=\tfrac n2+t$; the target $n(n-2)/4=n^2/4-n/2$ forces $t=0$. At odd $n$ the same computation forces $t^2=0$ with $t$ a half-integer, which is a second, independent reason odd $n$ carries no saturating point. $\mathfrak u(n/2)$ has $n^2/4$, excluded. The classification of compact symmetric pairs of $\mathfrak{so}(n)$ ($\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$), is complete.

**$\theta=\theta_0(n)$ follows in closed form.** With $\dim\mathfrak m=n^2/4$, $\dim\mathfrak h=n(n-2)/4$, $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)$ and unit norm, $\lambda_{\min}^2=2(n-2)/(n^2(n-1))$, so $\theta=(n-1)\lvert\lambda_{\min}\rvert=\sqrt{2(n-1)(n-2)}/n$. Reproduced to twelve digits at $n=6,8,10$. And $W=\Pi_{\mathfrak h}-(\dim\mathfrak h/N)I$ normalised **is** the Weyl tensor of $S^{n/2}\times S^{n/2}$: the product's curvature operator is $\Pi_{\mathfrak h}$, its Ricci is a multiple of $g$, and subtracting the constant-curvature part leaves exactly that.

### REFUTED AS STATED, the triality remark does not close the step it is attached to

> *"$\dim\mathfrak g^\theta$ is an $\mathrm{Aut}$-invariant, so triality produces no new dimension at $n=8$."*

The sentence is true and does not do the job. Cartan's classification enumerates symmetric pairs up to conjugacy in $\mathrm{Aut}(\mathfrak g)$. What the lemma needs is that $\mathfrak h$ is conjugate to $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ **under $O(n)$**, because $W$ is recovered from $\mathfrak h$ as an operator on $\Lambda^2\mathbb R^n$ and only $O(n)$-conjugation preserves $\mathcal W_n$. For $n\ne8$ every automorphism of $\mathfrak{so}(n)$ is induced by $O(n)$ and the two notions agree. **At $n=8$ they do not** (triality is outer and is not induced by $O(8)$) so ruling out a new *dimension* leaves open a second $O(8)$-class *at the same dimension*, which is exactly what would break "$W$ is the balanced sphere product".

**The repair, and it closes.** The inner involutions of $\mathfrak{so}(8)$ are $\mathrm{Ad}(J)$ for an involution $J\in SO(8)$ (fixed algebra $\mathfrak{so}(p)\oplus\mathfrak{so}(8-p)$) and $\mathrm{Ad}$ of a complex structure (fixed algebra $\mathfrak u(4)$, dimension $16$). Only $p=4$ gives dimension $12$, and all splittings $\mathbb R^8=\mathbb R^4\oplus\mathbb R^4$ are $SO(8)$-conjugate, so that is a single inner class. $\mathrm{Inn}$ is normal in $\mathrm{Aut}$, so the triality image of $\mathrm{Ad}(J_4)$ is again inner with a $12$-dimensional fixed algebra, hence lies in that same class. **So there is no second class, and the conclusion stands, but on this argument, not on the invariance of dimension.**

---

## P3, the withdrawals are right; two further defects stand

**The four withdrawals are correct, and I find nothing else in the section resting on what they removed.**

- *(i)* Under the old hypothesis $\mathfrak r=0$, "exactly two eigenvalues" is that hypothesis restated. Correct; the ideal argument is what converts it to a derivation.
- *(ii)* $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ was used and never derived. Correct, and it now follows from $\mathfrak h=[\mathfrak m,\mathfrak m]$ plus the normalisation.
- *(iii)* Routes (i) and (ii) both terminate in Cartan. Correct, Lemma L23's admissibility cap is itself an enumeration of the symmetric pairs of $\mathfrak{so}(n)$.
- *(iv)* Mass counting alone gives only $\dim\mathfrak m\le2\dim\mathfrak h$ (from the residue being nonnegative); the closed form $\dim\mathfrak h(n-4)$ is equivalent to $n\dim\mathfrak h=(n-2)\dim\mathfrak m$, so it assumes r324's ratio. Correct.

**The corrected mass-law premise is right.** At saturation the rows through $\mathfrak m$ are supported on $(\mathfrak m,\mathfrak m,\mathfrak h)$ and $T$ itself is not: measured off-support mass of $T$ is exactly $12,48,120,240$ at the balanced products $n=6,8,10,12$ and $0$ at $W_{\mathbb{CP}^2}$, reproduced independently.

### REFUTED AS STATED, the mass law's displayed equation mixes two conventions

The sentence declares the row mass as $\sum_{bc}T_{abc}=2(n-2)$, which is the sum over **ordered** pairs, I verify it is exactly $2(n-2)$ per row in my basis. Summing that over $\mathfrak m$ gives $2(n-2)\dim\mathfrak m$, not $(n-2)\dim\mathfrak m$. The residue, by contrast, is stated and reported in ordered units. Measured on both sides:

| point | $\mathfrak m$-row mass on $(\mathfrak m,\mathfrak h)$, ordered | halved | record's $M=\dim\mathfrak m(n-2)$ | residue, ordered | halved | record's residue |
| --- | --- | --- | --- | --- | --- | --- |
| balanced $n=6$ | $72$ | $36$ | $36$ | $12$ | $6$ | $12$ |
| balanced $n=8$ | $192$ | $96$ | $96$ | $48$ | $24$ | $48$ |
| $W_{\mathbb{CP}^2}$, $n=4$ | $8$ | $4$ | $4$ | $0$ | $0$ | $0$ |
| $S^2\times S^2$, $n=4$ | $16$ | $8$ | $8$ | $0$ | $0$ | $0$ |
| torus $n=6$ (control) | $48$ | $24$ | $48$ | $0$ | $0$ | $6$ |

So $M$ is in halved (unordered-pair) units and the residue is in ordered units. **The two halves of one displayed equation cannot both be right.** The repair, in the convention the same sentence declares:

$$M=2(n-2)\dim\mathfrak m,\qquad \big(\text{mass of }\mathfrak h\text{'s rows outside }\mathfrak m\times\mathfrak m\big)=(n-2)\big(2\dim\mathfrak h-\dim\mathfrak m\big)=\dim\mathfrak h\,(n-4),$$

with the reported values $36,96,200,360$ then reading $72,192,400,720$. Every other number in the passage reproduces, including the control ($M=24$ against $48$ in halved units at the $n=6$ torus). One thing the control hides: at the torus the ratio-free form $(n-2)(2\dim\mathfrak h-\dim\mathfrak m)$ returns $-24$, a negative mass, because the derivation presumes the $\mathfrak m$-rows sit wholly on the $(\mathfrak m,\mathfrak h)$ block, which is saturation. The residue formula is therefore not a test that a non-saturating point can fail informatively.

### REFUTED, "saturation in fact forces $\ker W=0$ outright"

As written, unscoped, this is contradicted by the record's own witness two paragraphs above it. $W_{\mathbb{CP}^2}$ at $n=4$ is a unit critical Weyl tensor with criticality residual $2.1\times10^{-15}$, distance from $\mathcal W_4$ of $6.4\times10^{-16}$, slack $0.0000000000$ (it saturates) and spectrum $(-0.408248^{\times2},\,0^{\times3},\,0.816497)$, so $\dim\ker W=3$.

The claim is true for $n\ge5$, where it is an immediate **corollary** of $\mathfrak r=0$ (since $\lambda_{\min}<0<\lambda_{\max}$, $\ker W\subseteq\mathfrak r$). Calling it "stronger than either" inverts the implication: $\mathfrak r=0$ implies $\ker W=0$, not the reverse. Repair: *for $n\ge5$, saturation forces $\ker W=0$, as a consequence of $\mathfrak r=0$.*

### REFUTED AS STATED, the $n=4$ classification

> *"the saturating critical points are $\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$, and nothing else."*

The list is right for **critical** points and wrong for **saturating** ones. I classified $n=4$ analytically. $\mathfrak{so}(4)=\Lambda^+\oplus\Lambda^-$ with $[\Lambda^+,\Lambda^-]=0$, so $W=W^+\oplus W^-$ with each block traceless symmetric on a $3$-space, and in my normalisation $W^\#=2\,\mathrm{adj}$ on each block. Criticality reads $a_i^2+2a_ja_k=\theta a_i$; differencing pairs and using $a_i+a_j=-a_k$ gives $(a_i-a_j)(3a_k+\theta)=0$, so each block is either $0$ or has spectrum $(2t,-t,-t)$ with $t=\theta/3$. Normalising: one block zero gives $\theta=\pm\sqrt{3/2}$ ($W_{\mathbb{CP}^2}$), both nonzero gives $\theta=\pm\sqrt3/2$ ($S^2\times S^2$). **That is the complete list of unit critical points at $n=4$**, and $120$ Newton solves from random starts land on exactly those four $\theta$ values (counts $3/51/65/1$, residuals $\le2\times10^{-15}$, distance from $\mathcal W_4\le1.7\times10^{-15}$).

But the sign matters for saturation, and only the two with $\theta>0$ saturate:

| point | $\theta$ | criticality residual | dist from $\mathcal W_4$ | $\dim\ker W$ | slack |
| --- | --- | --- | --- | --- | --- |
| $+W_{\mathbb{CP}^2}$ | $+1.224745$ | $2.1\times10^{-15}$ | $6.4\times10^{-16}$ | $3$ | $0.0000000000$ |
| $-W_{\mathbb{CP}^2}$ | $-1.224745$ | $2.1\times10^{-15}$ | $6.4\times10^{-16}$ | $3$ | $1.2247448714$ |
| $+S^2\times S^2$ | $+0.866025$ | $5.6\times10^{-17}$ | $1.7\times10^{-15}$ | $0$ | $0.0000000000$ |
| $-S^2\times S^2$ | $-0.866025$ | $5.6\times10^{-17}$ | $1.7\times10^{-15}$ | $0$ | $0.8660254038$ |

Repair: *at $n=4$ the critical points are exactly $\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$ up to $O(4)$, and the saturating ones are exactly the two with $\theta>0$.* The statement as written is what would be quoted if the $n=4$ case were ever used to calibrate a general-$n$ criterion, and it would be quoted wrongly.

---

## What I would change in the record

1. **State P4b in [bounds.md](../findings/bounds.md) explicitly**, next to Lemma L71: the lemma constrains no non-saturating critical point, because $D>0$ at a critical point *is* Lemma L70's inequality and nothing more. It belongs beside the R14 tautology note, in the same voice.
2. **Repair the mass law's displayed $M$** to $2(n-2)\dim\mathfrak m$, or restate the residue in halved units, and update $36,96,200,360$ accordingly.
3. **Scope r327's $\ker W=0$ to $n\ge5$** and record it as a corollary of $\mathfrak r=0$.
4. **Fix the $n=4$ sentence** to separate "critical" from "saturating".
5. **Replace the triality remark** with the inner-class argument, or drop the appeal to dimension-invariance and say plainly that $O(8)$-conjugacy is what is needed and why it holds.
