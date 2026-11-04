# Reviewer r151, Gate 2 on the Jensen refutation

**Claim under review.** Jensen's second Einstein metric on $S^3\times S^3$ is a graded critical point that is not the Casimir $W_{\mathfrak h}$ of any subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$. Commits [9f85f84](../findings/graded-half.md) and [7323e69](../plan.md).

## Verdict

**CONFIRMED, the claim is true, and it closes the unrestricted route only.** Two corrections attach to how it is argued and how it is graded.

| | finding |
|---|---|
| the claim itself | **true**, and provable in one line from data already on the page |
| argument (i) | valid, but a corollary of argument (ii)'s formula |
| argument (ii) | valid; the suspected hypothesis defect is **absent** |
| Gate 1 (b), "two independent arguments" | **not met**, one argument with a corollary |
| novelty | **the record already held the fact**, with a different witness, two paragraphs above |
| the regrade $6\to2$ | direction defensible, stated ground overstated |

## 1. The likeliest defect is not there: the $\theta$ formula does not presuppose (F1),(F2),(F3)

The theorem's hypotheses are exactly *"let $0<r<N$ and suppose $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$"*. (F1)–(F3) appear only afterwards, in a separate paragraph, as **sufficient conditions for that eigen-equation to hold**, the record's own words, "criticality is free under three hypotheses, and they are the practical way to produce members".

The proof uses nothing else. Reconstructed from the definitions:

- $\sum_{b,c}c_{abc}^2=\kappa=2(n-2)$ for every $a$, a property of $\mathfrak{so}(n)$, not of $\mathfrak h$.
- Summing that over $a\in\mathfrak h$ and over $a\in\mathfrak m$, and killing the mixed terms with $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, gives $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$ and $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$. **Only the subalgebra property is used.**
- $W_{\mathfrak h}$ has two eigenvalues $u=c(1-r/N)$, $v=-cr/N$, so averaging the diagonal of $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ over $\mathfrak h$ and over $\mathfrak m$ gives the two scalar equations recorded in [p5_casimir_family.py](../scripts/p5_casimir_family.py) lines 35–36. Eliminating $S_{\mathfrak{hhh}}$ and $S_{\mathfrak{mmm}}$ leaves $\theta$ and $S_{\mathfrak{hmm}}$.

So the formula holds for **every** Casimir satisfying the eigen-equation, whatever its normaliser does. Argument (ii) therefore inverts a formula that does apply.

**The remaining question is whether "critical" delivers the eigen-equation, and it does.** Criticality of $P$ on the unit sphere of $\mathrm{Weyl}_n$ gives only $\Pi_{\mathcal W}Q(W)=\theta W$, the record flags this hazard itself in [target.md](../findings/target.md), but $Q$ maps $\mathrm{Weyl}_n$ into itself: Ricci-flatness is preserved by [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6), and $\Phi$ preserves the first Bianchi identity. Hence $\Pi_{\mathcal W}Q(W)=Q(W)$ and the two forms coincide. Independently, [p3_jensen_s3s3.py](../scripts/pipelines/p3_jensen_s3s3.py) measures Jensen's residual as $\lVert Q(W)-\theta W\rVert/\lVert Q(W)\rVert$ with the **unprojected** $Q$, so the screened $3\times10^{-16}$ is already the theorem's hypothesis verbatim.

**Corroboration that the hypothesis is load-bearing rather than vacuous.** The two recorded non-members exceed $\theta_0$: the formula at $\mathfrak{so}(3)+\mathfrak{so}(5)\subset\mathfrak{so}(8)$ ($r=13$, $N=28$) returns $1.2315$, while the record's measured value is $1.151371$; at $\mathfrak{so}(4)+\mathfrak{so}(6)\subset\mathfrak{so}(10)$ ($r=21$, $N=45$) the formula returns $1.2550$ against a measured $1.203766$. The disagreement is exactly what it should be, those operators are Rayleigh quotients of non-eigenvectors, so the formula is silent on them, as the theorem says.

## 2. (i) and (ii) are one argument, not two, Gate 1 (b) is not met

The claimed independence is stated as *"the two arguments above share no arithmetic"*. They share more than arithmetic: they share the only load-bearing step.

- (ii) is the $\theta$ formula, inverted.
- (i) is the $\theta$ formula, plus $S_{\mathfrak{mmm}}=(N-r)\bigl[2(n-2)-4(n-1)r/N\bigr]\ge0$, plus monotonicity of $\theta$ in $r$. The $\theta$ formula and the $S_{\mathfrak{mmm}}$ formula come out of the **same elimination**, from the same two scalar equations.

So (i) is logically contained in (ii): (ii) rules out every real $r$ giving $\theta^2=6/5$; (i) rules out the sub-range $r\le n(n-2)/4$. If the $\theta$ formula is wrong, both fall together. The refutation rests on one derivation.

*(Also, (i) does not need its equality clause at all. Its operative step is the strict inequality $1.0954451>\theta_0(6)=1.0540926$ against a cap that binds every critical Casimir, graded or not. The sentence "Jensen is graded" is decoration there.)*

## 3. A genuinely independent argument exists, and it is stronger than both

Jensen's normalised Weyl operator has **three** distinct eigenvalues; $W_{\mathfrak h}$ with $0<r<N$ has exactly **two**, since $\Pi_{\mathfrak h}$ is a projection and $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ takes $c(1-r/N)$ on $\mathfrak h$ and $-cr/N$ on $\mathfrak m$. That settles it outright.

The spectrum is read off the record's own validation gate. Petersen–Stanfield's curvature operator has eigenvalues $\tfrac7{24}$ (mult 3), $\tfrac1{12}$ (mult 7), $-\tfrac1{24}$ (mult 5) on $\Lambda^2\mathbb R^6$; the metric is Einstein, so $\mathrm{Ric}_0=0$ and the Weyl part is $R$ minus a multiple of the identity, which cannot merge eigenvalues. By hand: mean $\tfrac1{12}$, so $W\propto(\tfrac5{24},0,-\tfrac18)$ with multiplicities $(3,7,5)$, and $\lVert W\rVert^2=\tfrac5{24}$, giving normalised $(0.4564355,\,0,\,-0.2738613)$. *A number, for one purpose: the existing script confirms this spectrum exactly, which the derivation-only route could not do without re-deriving Petersen–Stanfield's operator.*

This argument uses no $\theta$, no slack, no family theorem, and no convention. **It is the argument the section should have given as its second.**

## 4. Conventions and the equality clause check out

- **Same $Q$.** [p5_casimir_family.py](../scripts/p5_casimir_family.py) and [p3_jensen_s3s3.py](../scripts/pipelines/p3_jensen_s3s3.py) both call `Q_full` from the same module, both set $\theta=\langle W,Q(W)\rangle$ on a unit-norm $W$, and both measure criticality as $\lVert Q(W)-\theta W\rVert$. No mismatch.
- **Same slack.** Both use $S=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)$.
- **Equality clause consistent.** The theorem's clause is $S_{\mathfrak{mmm}}=0$; the family's slack is $S=\tfrac r{nN}(n^2-2n-4r)$ and $S_{\mathfrak{mmm}}=\tfrac{2(N-r)}n(n^2-2n-4r)$. Both are positive multiples of the same bracket for $0<r<N$, so on the family $S=0\iff S_{\mathfrak{mmm}}=0\iff r=n(n-2)/4$. The two senses of "graded" agree where the argument uses them.
- **Arithmetic reproduced.** $\theta_0(6)=\sqrt{40}/6=1.054092553$; the formula at $r=6$, the $\mathfrak{so}(3)+\mathfrak{so}(3)$ member, returns $\tfrac13\sqrt{10}=1.054092553$ and $r=6$ is exactly the cap $n(n-2)/4$. Inverting: $\theta^2=\tfrac{5r}{3(15-r)}$, and $\theta^2=6/5$ gives $25r=270-18r$, $43r=270$, $r=6.2790698$, between $10/9$ at $r=6$ and $35/24$ at $r=7$. All correct.

## 5. The scope claim is right, and the threshold is exactly where the witnesses stop

[plan.md](../plan.md) states (H) as *"every graded critical point with $\theta>\sqrt{3/2}$ is a sphere product"*, and item 1 as the same hypothesis with "is a Casimir". Jensen at $1.0954451<1.2247449$ fails that hypothesis, so **(H) is untouched, confirmed.**

Worth adding to the record: the threshold is sharp against the known witnesses. $W_{\mathbb{CP}^2}$ is graded, critical, non-diagonal and sits at $\theta=\sqrt{3/2}$ **exactly**, with eigenvalues $(0.816497,-0.408248,-0.408248,0,0,0)$, three distinct values, so it too is no Casimir. The counterexamples run right up to the threshold and stop at it.

## Answers

**(a) CONFIRMED.** It closes only the unrestricted route, "classify subalgebras and be done" is dead as a proof of *every graded critical point is a Casimir*. It does **not** close the subalgebra route to (H) or to item 1's narrowed form, because no witness above $\sqrt{3/2}$ is produced. Narrowing, not closing.

**(b) The record already held this, and the new section is a second witness for a fact stated 4 paragraphs above it.** At [graded-half.md](../findings/graded-half.md), in the paragraph immediately preceding the new section and present before commit 9f85f84: *"the maximum is unique only within the family, $W_{\mathbb{CP}^3}$ at $n=6$ is critical at residual $5.1\times10^{-16}$ with $\theta=\theta_0(6)$ exactly, tying $S^3\times S^3$ from outside it … $\mathbb{CP}^m$ … sit outside."* Combined with [target.md](../findings/target.md), also predating the commit, $\mathbb{CP}^3$ is an $n=6$ critical point with $S=2\times10^{-30}$, $\mathbb{CP}^m$ for $m\ge3$ *"has $S=0$, hence is graded"*, and $\mathbb{CP}^m$ has three eigenvalues so is outside the two-eigenvalue class, the record already carried a graded critical point at $n=6$ outside the subalgebra family. **Jensen is the fifth-ish instance of this programme re-deriving something it holds.** What Jensen genuinely adds is a witness whose $\theta$ is *above* $\theta_0(n)$, which $\mathbb{CP}^3$ (sitting exactly at $\theta_0(6)$) does not supply.

**(c) The regrade $6\to2$ is defensible in direction and overstated in its ground.** The stated reason (*"attackable dropped $3\to1$, since classifying subalgebras is no longer a route"*), is a statement about the unrestricted claim, and item 1 is scored in its **narrowed** form, whose hypothesis Jensen does not satisfy. Nothing shown here bears on whether the family exhausts the graded critical set *above* $\sqrt{3/2}$. Two further points cut the same way: the ground was already on the record via $\mathbb{CP}^3$, so no information arrived on the day of the regrade; and $W_{\mathbb{CP}^2}$ at the threshold makes it likely the narrowed statement is also false, which would be a real regrade, but that is not what was shown. **Recommendation: keep the grade, restate the reason as "the unrestricted form is refuted and the narrowed form is untested", and record $\mathbb{CP}^3$ as the earlier witness.**

## Disagreements with the record, stated explicitly

1. **Gate 1 (b) is not met.** "The two arguments above share no arithmetic" is false; both rest on the family theorem's $\theta$ formula, and (i) is a corollary of (ii). One argument, not two.
2. **The novelty claim is wrong.** The graded critical set was already recorded as strictly wider than the subalgebra family, on the same page, before this commit.
3. **The regrade's stated ground does not support it**, for the reason in (c).

None of these touches the truth of the claim, which stands on the eigenvalue count independently of everything above.
