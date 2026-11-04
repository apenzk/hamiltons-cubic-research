# Review r552, Lemma L28, the $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$

Reviewer r552, independent adversarial audit of [Lemma L28](../findings/nondegeneracy.md) as stated at [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 504, restated at [results.md](../results.md) lines 142 and 402 and cited at [findings/target.md](../findings/target.md) lines 423 and 466. Analysis only; no computation was run, and nothing below rests on a screen.

## Overall verdict: **REPAIRED**

**Every number in the Statement is correct**, and I reproduced all of them by routes sharing nothing with the block's: $\theta^2$, the orbit dimension, $\dim E(\tfrac12)$, $\lambda_{\max}=\frac{m+2}{2(m+1)}$, and the conclusion that $\mathbb{CP}^m$ is Morse–Bott nondegenerate and is not a maximiser. **One line of the proof is wrong**: the charge table's entry $4m$ names a summand that does not exist, and the summand it stands in for carries $4(m+1)$. The error is inert (it moves no eigenvalue to $\tfrac12$ and changes no $\lambda_{\max}$) but it is refuted three independent ways and must be corrected. Six further defects are presentational or scope, listed below with drop-in repairs. **The repairs are written out here and are not applied to the record**, a second reviewer being on the identical brief.

## What I derived from the definitions

### The decomposition, rebuilt from scratch, **CONFIRMED, ten summands, multiplicity-free**

$\mathcal R\otimes\mathbb C=\mathbb S_{(2,2)}(V^{\mathbb C})$ with $V^{\mathbb C}=E\oplus\bar E$. Littlewood–Richardson at $\lambda=(2,2)$ gives six $GL(E)\times GL(\bar E)$ pieces, from $c^{(2,2)}_{\mu\nu}=1$ at $(\mu,\nu)\in\{((2,2),\varnothing),(\varnothing,(2,2)),((2,1),(1)),((1),(2,1)),((2),(2)),((1,1),(1,1))\}$ and $0$ elsewhere. Decomposing each mixed piece and subtracting $S^2_0V^{\mathbb C}=V_{(2);\varnothing}\oplus V_{\varnothing;(2)}\oplus V_{(1);(1)}$ and one trivial leaves **ten complex summands, pairwise distinct**, hence **seven real summands**, three of the ten are conjugate pairs.

| complex summand | real dim | $c_S+q_S^2$ | $\lambda_S$ |
| --- | --- | --- | --- |
| $\mathbb C$, the line $\langle W\rangle$ | $1$ | $0$ | $1$ |
| $V_{(1);(1)}$, $\mathfrak{su}(m)$ adjoint | $m^2-1$ | $2m$ | $\frac{m+2}{2(m+1)}$ |
| $V_{(1,1);\varnothing}\oplus V_{\varnothing;(1,1)}$, the orbit tangent | $m(m-1)$ | $2(m+1)$ | $\tfrac12$ |
| $V_{(1,1);(1,1)}$ | $\frac{m^2(m+1)(m-3)}4$ | $4(m-1)$ | $\frac2{m+1}$ |
| $V_{(2,1);(1)}\oplus V_{(1);(2,1)}$ | $\frac{2m^2(m^2-4)}3$ | $4(m+1)$ | $0$ |
| $V_{(2);(2)}$ | $\frac{m^2(m-1)(m+3)}4$ | $4(m+1)$ | $0$ |
| $V_{(2,2);\varnothing}\oplus V_{\varnothing;(2,2)}$ | $\frac{m^2(m^2-1)}6$ | $4(m+4)$ | $-\frac3{m+1}$ |

I computed $c_S+q_S^2$ as $\sum_i\lambda_i(\lambda_i+m+1-2i)+(|\alpha|-|\beta|)^2$ on the $GL(m)$ highest weight $\lambda=(\alpha_1,\dots,0,\dots,-\beta_2,-\beta_1)$, the $\mathfrak{gl}(m)$ Casimir in the trace normalisation, plus the squared $U(1)$ charge. That normalisation is not fitted: it returns $0$ at the trivial and $2m$ at the adjoint, which are two of the block's own seven values, and it then returns four more of them unprompted.

**This table is already in the record**, in the notes for [Howe–Tan–Willenbring](../references/howe-tan-willenbring-2005-stable-branching/notes.md), with the same dimensions and the same eigenvalues including **$0$ on both** $V_{(2,1);(1)}\oplus$ dual and $V_{(2);(2)}$. My derivation and the record's reading agree summand for summand and were reached independently.

### The dimensions close, **CONFIRMED as a polynomial identity**

$$1+(m^2-1)+m(m-1)+\frac{m^2(m+1)(m-3)}4+\frac{2m^2(m^2-4)}3+\frac{m^2(m-1)(m+3)}4+\frac{m^2(m^2-1)}6=\frac{m(4m^3-7m-3)}3=\frac{m(m+1)(2m-3)(2m+1)}3,$$

which is $\dim\mathcal W_{2m}=\frac{n(n-3)(n+1)(n+2)}{12}$ at $n=2m$. Checked as an identity in $m$ and at $m=3$ ($84$) and $m=4$ ($300$), matching [findings/conventions.md](../findings/conventions.md) and matching the independently measured $1$ of $84$, $1$ of $300$ in [findings/target.md](../findings/target.md) line 462. **The brief's $212$ unaccounted at $m=4$ is exactly $64+64+84$**, the three summands the block leaves unnamed.

### The closed form of $e$, **CONFIRMED, by three checks it could not pass by accident**

For $e=-\frac1{2m-1}P_{\mathfrak m}+\frac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\frac{2(m-1)}{2m-1}P_\omega$ with ranks $m(m-1)$, $m^2-1$, $1$:

- **Traceless.** $\frac{m-1}{2m-1}\left[-m+(m-2)+2\right]=0$ exactly, as a Weyl operator must be.
- **Norm against $\theta$.** $\lVert e\rVert^2=\frac{m-1}{(2m-1)^2(m+1)}\left[m(m+1)+(m-2)^2+4(m-1)(m+1)\right]=\frac{3m(m-1)}{(2m-1)(m+1)}$, which is exactly $1/\theta^2$ for the stated $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$. The projector coefficients and $\theta$ are mutually consistent to the last digit.
- **[Lemma L70](../results.md) saturation.** $\lambda_{\max}(e)=\frac{2(m-1)}{2m-1}$ and $\lambda_{\min}(e)=-\frac1{2m-1}$, so $(n-2)|\lambda_{\min}|=(2m-2)\cdot\frac1{2m-1}=\lambda_{\max}$ exactly, the record's independently proved bound is saturated at $\mathbb{CP}^m$, as [results.md](../results.md) line 574 says it is.

$\theta^2$ itself has an independent literature derivation already in the record, at [findings/algebra.md](../findings/algebra.md) lines 25–29, from Fox's $|S^r|^2=6r(r-2)/((r+2)(r-1))$ via $\theta(S^r)^2=\frac{2(r+2)(r-1)}{3r(r-2)}$, which at $r=2m$ is $\frac{(m+1)(2m-1)}{3m(m-1)}$ exactly. I checked that reduction. The block does not cite it.

### The two eigenvalues that matter are derivable with no branching rule at all

- **$1$ on $\langle W\rangle$.** $e\circ e=Q(e)=Q(W)/\theta^2=W/\theta=e$, so $L_ee=e$.
- **$\tfrac12$ on the orbit tangent.** $Q$ is $O(n)$-equivariant, so $Q(g\cdot W)=g\cdot Q(W)$; differentiating at the identity, $DQ|_W(X\cdot W)=X\cdot Q(W)=\theta(X\cdot W)$, and since $DQ|_W=2\theta L_e$ this gives $L_e(X\cdot W)=\tfrac12X\cdot W$ for every $X\in\mathfrak{so}(2m)$.

These two pin the block's affine law. If $\lambda_S=A-B(c_S+q_S^2)$ at all, then $A=1$ from the first and $B=\frac1{4(m+1)}$ from the second, since the orbit's $c_S+q_S^2$ is $2(m+1)$. **Affineness itself I did not derive**, see defect D6.

### The orbit dimension, derived independently, **CONFIRMED**

$U(m)$ is a maximal connected subgroup of $SO(2m)$ for $m\ge3$ ($SO(2m)/U(m)$ is an irreducible Hermitian symmetric space of dimension $m(m-1)$), and $\mathcal W_{2m}$ carries no $SO(2m)$-invariant, so the stabiliser's identity component is exactly $U(m)$ and $\dim\mathcal O=m(2m-1)-m^2=m(m-1)$. As a $U(m)$-module the orbit tangent is $\mathfrak{so}(2m)/\mathfrak u(m)$, complexifying to $\Lambda^2E\oplus\Lambda^2\bar E$, the third row of the table. Corroborated by the record's own measured $\dim\mathfrak m=6,12$ at $\mathbb{CP}^3,\mathbb{CP}^4$ ([findings/target.md](../findings/target.md) lines 522 and 538).

**$E(\tfrac12)$ is the whole orbit tangent and not merely contains it.** Multiplicity-freeness makes $L_e$ scalar on each summand, so $E(\tfrac12)$ is a sum of whole summands; $c_S+q_S^2=2(m+1)$ holds on the orbit identically, and among the other six values only $4(m-1)=2(m+1)$ is solvable, at $m=3$, where that summand is absent. So $E(\tfrac12)=$ orbit tangent at every $m\ge3$, which is the equality Morse–Bott needs.

### Two moment identities pin the whole eigenvalue list, and refute the table's $4m$

Fox's Theorem 1.3, recorded at [findings/algebra.md](../findings/algebra.md) lines 12–16, gives $\mathop{\mathrm{tr}}L(x)=0$ and $\mathop{\mathrm{tr}}(L(x)L(y))=\kappa_F\langle x,y\rangle$ with $\kappa_F(n)=\frac{(2n-1)(n-1)}4$. Both hold exactly on the table above:

$$\mathop{\mathrm{tr}}L_e=1+\tfrac{(m-1)(m+2)}2+\tfrac{m(m-1)}2+\tfrac{m^2(m-3)}2-\tfrac{m^2(m-1)}2=1+\tfrac12(0\cdot m^2-2)=0,$$
$$\mathop{\mathrm{tr}}(L_e^2)=\frac{12m^3-15m^2+3m}{4(m+1)}=\frac{3m(m-1)(4m-1)}{4(m+1)}=\frac{(4m-1)(2m-1)}4\cdot\frac{3m(m-1)}{(m+1)(2m-1)}=\kappa_F(2m)\lVert e\rVert^2 .$$

Both are identities in $m$, and **both fail under the block's table**: replacing either $0$ by $\frac1{m+1}$ on a summand of dimension $\frac{2m^2(m^2-4)}3$ or $\frac{m^2(m-1)(m+3)}4$ makes $\mathop{\mathrm{tr}}L_e$ strictly positive for every $m\ge3$.

## Defects, in order

### D1, the charge table's $4m$ entry. **REFUTED, three independent ways; the Statement is unaffected**

The block's *How the eigenvalues are obtained* lists $c_S+q_S^2\in\{0,\,2m,\,2(m+1),\,4(m-1),\,4m,\,4(m+1),\,4(m+4)\}$. The true list is

$$\{0,\;2m,\;2(m+1),\;4(m-1),\;4(m+1),\;4(m+1),\;4(m+4)\},$$

$4(m+1)$ occurring twice (once for $V_{(2,1);(1)}\oplus$ conj and once for $V_{(2);(2)}$) and $4m$ not occurring at all. Refuted by (i) the Casimir-plus-charge computation above, (ii) the record's own [Howe–Tan–Willenbring notes](../references/howe-tan-willenbring-2005-stable-branching/notes.md), whose table gives $L_e=0$ on both, and (iii) the two Fox moment identities, which the block's list fails and the corrected list satisfies identically.

**The consequence is inert, and I checked that it is.** $4m$ would give $\lambda=\frac1{m+1}$, and $\frac1{m+1}=\tfrac12$ only at $m=1$, so no new $\tfrac12$ appears and $E(\tfrac12)$ is unchanged. $\frac1{m+1}<\tfrac12<\frac{m+2}{2(m+1)}$ for $m\ge3$, so $\lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)}$ either way, the comparison that decides it being $\frac{m+2}{2(m+1)}>\frac2{m+1}\iff m>2$. **So the Statement stands and only the proof line is wrong.**

*Repair, replace the sentence beginning "Setting $\lambda_S=\tfrac12$" with:* Setting $\lambda_S=\tfrac12$ is then the arithmetic condition $c_S+q_S^2=2(m+1)$: across the seven real summands that quantity is $0$, $2m$, $2(m+1)$, $4(m-1)$, $4(m+1)$, $4(m+1)$ and $4(m+4)$, so it holds identically on the orbit and elsewhere only at $m=3$.

The independently confirmed value $\lambda_{\max}=0.62500000$ with multiplicity $8$ at $\mathbb{CP}^3$, in [findings/target.md](../findings/target.md) line 560, is $\frac{m+2}{2(m+1)}$ on the $m^2-1$ adjoint at $m=3$ and corroborates the row the error does not touch.

### D2, the summand count. **REPAIRED; both numbers are right and the block switches between them silently**

"Ten summands, nine at $m=3$" is the **complex** count. "The remaining two" is the **real** count: the block names five real summands ($\langle W\rangle$, the adjoint, the orbit, $V_{(1,1);(1,1)}$, and $V_{(2,2);\varnothing}\oplus$ conj), leaving two, $V_{(2,1);(1)}\oplus$ conj and $V_{(2);(2)}$. Seven real, six at $m=3$, matching the Tricerri–Vanhecke count in [references/tricerri-vanhecke-1981-almost-hermitian-curvature/notes.md](../references/tricerri-vanhecke-1981-almost-hermitian-curvature/notes.md). **No summand is missing and nothing about $E(\tfrac12)$ depends on the reconciliation**, but a reader counting the named pieces gets nine against the announced ten, which is how the brief's question arose and how I read it first.

*Repair, say which count is which, and name the two:* "…is $U(m)$-multiplicity-free with **ten complex summands**, nine at $m=3$, falling into **seven real summands** since three are conjugate pairs" and "…and $0$ on the remaining two real summands, $V_{(2,1);(1)}\oplus\text{conj}$ of dimension $\frac{2m^2(m^2-4)}3$ and $V_{(2);(2)}$ of dimension $\frac{m^2(m-1)(m+3)}4$."

### D3, the dimension audit. **CONFIRMED, no defect.** The seven real dimensions sum to $\dim\mathcal W_{2m}$ identically in $m$, verified above. Naming the last two summands is what closes the audit a reader can run.

### D4, $m=3$ lies outside the cited authority. **REPAIRED here; the block does not flag it**

[Howe–Tan–Willenbring §2.3.1](https://arxiv.org/abs/math/0311159) requires partitions with at most $\lfloor n/2\rfloor$ parts, so at $\lambda=(2,2)$ it applies from $m\ge4$; the record's own notes say so in terms, and record that $m=3$ agrees with a **measured** decomposition. **$m=3$ is precisely the case the whole argument turns on**, being where $\frac2{m+1}=\tfrac12$, so a proof that cites a rule out of range there is citing nothing.

*The gap is fillable by hand and I filled it.* At $m=3$ every mixed piece is a standard $\mathfrak{su}(3)$ tensor product: $\mathbf 8\otimes\bar{\mathbf 3}=\bar{\mathbf 3}\oplus\mathbf 6\oplus\mathbf{15}$, $\mathbf 6\otimes\bar{\mathbf 6}=\mathbf 1\oplus\mathbf 8\oplus\mathbf{27}$, $\bar{\mathbf 3}\otimes\mathbf 3=\mathbf 1\oplus\mathbf 8$, the last producing **no** $V_{(1,1);(1,1)}$. Subtracting $S^2_0$ and one trivial from $105=\dim\mathbb S_{(2,2)}(\mathbb C^6)$ leaves nine complex summands of dimensions $6,6,15,15,3,3,27,8,1$, summing to $84=\dim\mathcal W_6$. So the decomposition at $m=3$ is a theorem, not a measurement, and the block should carry this line rather than the citation.

### D5, "precisely where its summand's dimension vanishes". **REPAIRED**

At $m=3$ the summand is **absent**: $V_{(1,1);(1,1)}$ needs $\ell(\alpha)+\ell(\beta)=4$ rows against $m=3$ available, and the branching rule does not produce it, as the $\bar{\mathbf 3}\otimes\mathbf 3$ product above shows directly. The formula $\frac{m^2(m+1)(m-3)}4$ evaluating to $0$ is the analytic continuation agreeing with the absence, not the reason for it. [results.md](../results.md) line 142 already says "that summand is empty", which is the right word; the block should use it too.

### D6, the "What is not proved" concession is incomplete. **REPAIRED**

Three things the block leans on and does not flag:

- **The affine law is asserted.** "Closed forms for $\sharp(P_\omega,\cdot)$ and $\sharp(P_{\mathfrak u},\cdot)$ then make every block value depend only on the $U(1)$ charge", neither closed form is stated, cited or derived, and the step from them to $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ is a sketch. What can be said instead, and what I verified: **given** that $\lambda_S$ is affine in $c_S+q_S^2$, the law is forced by $L_ee=e$ and by equivariance putting the orbit at $\tfrac12$, and the resulting seven values satisfy $\mathop{\mathrm{tr}}L_e=0$ and $\mathop{\mathrm{tr}}(L_e^2)=\kappa_F(2m)\lVert e\rVert^2$ identically in $m$, two constraints the list would fail if any single value were wrong by a rational function of $m$.
- **Criticality is asserted.** That $W_{\mathbb{CP}^m}$ is critical is proved elsewhere in the record and unjoined: $\dim\mathcal W_{2m}^{U(m)}=1$, so $Q(W)$ is again $U(m)$-invariant and hence a multiple of $W$ ([findings/target.md](../findings/target.md) lines 460–462). That one-line argument belongs in the block, and it is also the independent confirmation that the trivial summand occurs exactly once.
- **$\theta^2$ is asserted.** Derived in [findings/algebra.md](../findings/algebra.md) from Fox's Lemma 10.1 and (10.4), and unjoined here. The block's own $e$ corroborates it through $\lVert e\rVert^2=1/\theta^2$, which is worth stating since it checks the projector coefficients at the same time.

### D7, the $n=6$ coincidence. **CONFIRMED consistent; the block should say why**

$\theta^2(\mathbb{CP}^3)=\frac{4\cdot5}{3\cdot3\cdot2}=\tfrac{10}9=\theta_0(6)^2$, so $\mathbb{CP}^3$ sits exactly at $\Theta_6$, and $\lambda_{\max}=\tfrac58>\tfrac12$ says it is not a local maximiser. **There is no contradiction with [Lemma L24](../results.md)**, and the reason is already in the record: $\Theta_n$ is the *diagonal* maximum, $\mathbb{CP}^3$ is non-diagonal by the frame-independent criterion of [findings/target.md](../findings/target.md) line 534, and padded $W_{\mathbb{CP}^2}$ puts $\sqrt{3/2}=1.2247$ into $\mathcal W_6$, above $\Theta_6=1.0541$, by [Lemma L2](../results.md) and the fact that padding preserves $\theta$. So the global maximum at $n=6$ strictly exceeds $\Theta_6$, and Conjecture A is in any case asserted only from $n\ge12$.

I re-derived L24's bound rather than assuming it. Along $W+tv$ with $v\perp W$, $\lVert v\rVert=1$, and $T$ the symmetric trilinear form of $P$,
$$\theta(W+tv)=\big[P(W)+3t\langle v,Q(W)\rangle+3t^2\langle v,W\circ v\rangle+t^3P(v)\big](1+t^2)^{-3/2}=\theta+3\theta\,t^2\!\left(\langle v,L_ev\rangle-\tfrac12\right)+O(t^3),$$
so the Hessian of $\theta$ on the sphere is $6\theta\left(L_e|_{W^\perp}-\tfrac12\right)$: its kernel is $E(\tfrac12)$, which is what makes "$E(\tfrac12)$ = orbit tangent" **equivalent** to Morse–Bott nondegeneracy, and $\lambda_{\max}>\tfrac12$ an ascent direction. At $\mathbb{CP}^m$ that direction is the $\mathfrak{su}(m)$ adjoint, of dimension $m^2-1$.

*Repair, one sentence at the end of the Statement:* At $m=3$ this puts $\mathbb{CP}^3$ at $\theta^2=\tfrac{10}9=\theta_0(6)^2$, which is consistent because $\Theta_n$ is the diagonal maximum and padded $W_{\mathbb{CP}^2}$ already reaches $\sqrt{3/2}$ at $n=6$.

**The other half of the $n=6$ picture is [Lemma L27](../findings/nondegeneracy.md)'s excluded $(3,3)$**, where $S^3\times S^3$ is degenerate and, by [Lemma L3](../results.md), not a local maximum either. So both critical points at $\theta=\sqrt{10/9}$ fail to be maximisers, one by a nonzero Hessian direction and one at cubic order, a coherent picture, and one the block would do well to state, since it currently reads as though $n=6$ were a problem.

### D8, the closing note about the slice corrector. **REPAIRED; it is retracted 36 lines later and the retraction is not linked**

[findings/nondegeneracy.md](../findings/nondegeneracy.md) line 556 flags a corrector reaching residual $1.9\times10^{-13}$ at transverse distance $0.2$ with $\theta$ unchanged, as "the wrong direction for an isolated orbit". Line 592 of the same file says that citation "has no script in the tree", was "almost certainly measuring orbit motion", and "must be re-measured against the orbit before being reused", line 580 having established that every corrector flagged as moving off was within $3.8\times10^{-3}$ of the orbit once the distance was measured as $\min_g\lVert gW'g^{\mathsf T}-W_0\rVert$. **So the note is compatible with L28 because it carries no evidence at all.** It also never says which orbit the corrector started from; if it started at $S^3\times S^3$ there was never a tension, that orbit being degenerate. *Repair: add the pointer to line 592 at line 556, or drop the flag.*

### D9, a citation outside the hypotheses. **REPAIRED**

[findings/target.md](../findings/target.md) line 466 uses "Lemma L28's $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, maximised at $m=2$ at exactly $\tfrac32$". L28 is stated for $m\ge3$, so $m=2$ is outside it. The value at $m=2$ is right and is covered by [findings/algebra.md](../findings/algebra.md)'s Fox derivation, which holds for every even $r\ge4$; that is the citation the line wants. The other uses are inside the hypotheses: [results.md](../results.md) line 142 (restatement, and it says "empty" correctly), line 382 ([Observation L25](../results.md), "$\mathbb{CP}^m$ at $m\ge3$"), line 402 (restatement), and [findings/target.md](../findings/target.md) line 423 (the closed form for maximality). [Route R12](../routes.md) needs nondegeneracy only at $\theta\ge\sqrt{3/2}$, above every $\mathbb{CP}^m$ with $m\ge3$, so L28 is not load-bearing there.

### D10, the heading. **CONFIRMED as a proof of the nondegeneracy half only**

Unlike the four blocks the brief warns about, this one does carry an argument to a $\square$. What it proves is the nondegeneracy: given the decomposition and the affine law, $E(\tfrac12)$ is the orbit. **Criticality and $\theta^2$ are quoted from elsewhere in the record without saying so**, which is D6. The heading "canonical statement and proof" is defensible once those two lines are added.

## What the record already knew, unjoined

Four facts settling parts of this result sit in other files and are not cited by the block: the corrected seven-row table with $L_e=0$ on both remaining summands ([Howe–Tan–Willenbring notes](../references/howe-tan-willenbring-2005-stable-branching/notes.md)); the Fox derivation of $\theta^2$ ([findings/algebra.md](../findings/algebra.md)); the one-line criticality argument from $\dim\mathcal W_{2m}^{U(m)}=1$ ([findings/target.md](../findings/target.md) line 462); and the measured $\lambda_{\max}=0.625$ at multiplicity $8$ ([findings/target.md](../findings/target.md) line 560). **The block's own error at D1 is contradicted by the record's reference notes, which were written for this very lemma**, the table was read correctly into [references/](../references/) and mis-transcribed into the proof.

## Sources consulted

[findings/conventions.md](../findings/conventions.md), [findings/nondegeneracy.md](../findings/nondegeneracy.md), [findings/target.md](../findings/target.md), [findings/algebra.md](../findings/algebra.md), [results.md](../results.md), [routes.md](../routes.md), [plan.md](../plan.md), [ATTEMPTS.md](../ATTEMPTS.md), [references/howe-tan-willenbring-2005-stable-branching/notes.md](../references/howe-tan-willenbring-2005-stable-branching/notes.md), [references/tricerri-vanhecke-1981-almost-hermitian-curvature/notes.md](../references/tricerri-vanhecke-1981-almost-hermitian-curvature/notes.md). No primary source was fetched: the record's own reading answered every question the brief put to the sources.
