# ELIM-bounds, elimination audit of findings/bounds.md

Auditor ELIM-bounds. Assigned file [findings/bounds.md](../findings/bounds.md), read in full (649 lines, not 628). Pure algebra; no scripts, no solvers, no numerical evaluation. Every figure quoted below is either taken from the record itself or derived by hand from closed forms already on the record.

The file's freshest material, [Lemma L70](../findings/bounds.md), [Lemma L71](../findings/bounds.md), the deficiency identity and its reformulation, already carries the R14 closure box, and that box is correct. The audit's yield is therefore not the tautology it already names but four things it does not: one precisely located survivor, one false generalisation about eigenspace-constancy that closes off that survivor, a scope error in Lemma L71's hypothesis, and one load-bearing structural claim asserted in a parenthetical that the whole section rests on.

---

## Survivors

### S1. The per-row second moment $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}=\lVert\mathrm{ad}(v_\gamma)W\rVert^2=-\operatorname{tr}\big((\mathrm{ad}\,v_\gamma)^2W^2\big)$

**This is the one scalar per eigenvector row that criticality does not reach, and it is the only free variable anywhere in the deficiency material.**

Why it escapes, precisely. The Weyl per-row identity that fence post F18 records, $\Pi_{\mathcal W}(\mathrm{ad}(v)^2)=-2\Pi_{\mathcal W}(vv^{\mathsf T})$, equivalently $\operatorname{tr}((\mathrm{ad}\,v)^2X)=-2\langle v,Xv\rangle$, holds **only for $X\in\mathcal W_n$**. It pins the first moment, $\sum_\alpha\lambda_\alpha R_{\gamma\alpha}=-2\lambda_\gamma$, because $W\in\mathcal W_n$. It does **not** apply to $W^2$, because $W^2\notin\mathcal W_n$: the file's own Böhm–Wilking correction says the *sum* $W^2+W^\#$ preserves Bianchi while $W^\#$ alone does not, and records the nonzero cancellation $b(W^\#)=-b(W^2)$. So the second moment is unreached.

Consistency check against the record's own closed forms, no computation required. If $W^2$ were a Weyl tensor the per-row identity would give $\sum_\alpha\lambda_\alpha^2R_{v\alpha}=2\lambda_v^2$, hence

$$g_v=2\textstyle\sum_\alpha\lambda_\alpha^2R_{v\alpha}-4\langle v,W^\#v\rangle=8\lambda_{\min}^2-4\theta\lambda_{\min}.$$

At the balanced product with $n=6$ the record's own closed forms give $\lvert\lambda_{\min}\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2n-2}}=0.21082$ and $\theta_0(6)=1.054093$, so that expression equals $1.2445$, against the recorded $g_v=16(n-1)/n^2=2.2222$. The pin fails by a factor $1.79$, which is exactly the statement that $W^2$ leaves $\mathcal W_n$. Independently: $\sum_\gamma g_\gamma=4(n-1)=20$ at $n=6$ with $\Delta=0$ and no kernel puts all of it on $\dim\mathfrak m=n^2/4=9$ directions, giving $20/9=2.2222$, so the recorded value is the one that is right.

**What this buys a successor.** Every identity in the deficiency section reduces to the same shape: one linear functional of the row is pinned by criticality, one by Weyl membership, and the residual freedom is exactly $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$. The file says this once, correctly, at the per-direction identity, *"the only freedom left in its right-hand side is $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$"*, and then does not carry it into Lemma L70 or Lemma L71, where it is the same variable. A bound that does not constrain the second moment cannot bind, and the only handle the record has on it is the marginal-class cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$.

### S2. $\max_{v\in E_{\min}}g_v$ is a legitimate free parameter, and the record wrongly forbids it

The file writes, in the box that plainly states the polynomial substitution:

> *So Lemma L70's "for every unit $v\in E_{\min}$" is automatic rather than an extra hypothesis*, and **any per-$v$ statistic taken at $\lambda_{\min}$ is eigenspace-constant for free.**

The first clause is right. The second is false, and it is false in the direction that costs the programme its one free variable.

The proof of eigenspace-constancy is: $W^\#=\theta W-W^2$ is a polynomial in $W$, so $\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$ for every unit $v\in E_{\min}$. That argument reaches exactly the statistics that are functions of $W$. It does not reach $g_v=\lVert[\mathrm{ad}(v),W]\rVert^2$ or $\lVert\mathrm{ad}(v)W\rVert^2$, which are quadratic forms in $v$ associated with $-\sum_\alpha\lambda_\alpha^2\,\mathrm{ad}(\varphi_\alpha)^2$ and its relatives, operators that commute with the isotropy $\mathfrak k(W)$ and with nothing else. Only their pinned combination $-\tfrac14g_v+\tfrac12\lVert\mathrm{ad}(v)W\rVert^2=\langle v,W^\#v\rangle$ is constant on the unit sphere of $E_{\min}$; the two terms individually are not.

At every point where the record measured the spread, the isotropy acts on $E_{\min}$ with no invariants beyond the identity, which forces constancy for structural reasons that have nothing to do with criticality. **The measured spread $\le3\times10^{-16}$ is therefore evidence about the catalogue's symmetry, not about the claim as stated.** The operative consequence is positive: a successor may choose $v\in E_{\min}$ to maximise $g_v$, or to minimise $\lVert\mathrm{ad}(v)W\rVert^2$, and the record's sentence currently reads as forbidding that.

### S3. $b(W^2)=-b(W^\#)$ as a frame–spectrum relation

Endorsed as genuinely free, and the file's own reading of it (*"a relation between $\lambda$ and the frame that no marginal of $T$ can see"*), survives the substitution test. Under criticality it is not new information about $W^\#$ ($b(W^\#)=\theta\,b(W)-b(W^2)=-b(W^2)$ follows immediately from $b(W)=0$), but the object $b(W^2)=-\sum_\alpha\lambda_\alpha^2(v_\alpha\wedge v_\alpha)$ is a $\Lambda^4$-valued function of the eigenframe that no function of $(\text{spectrum},\theta)$ determines. It is a survivor in the strict sense, and it is the right place to look.

### S4. The off-diagonal criticality relations $M_{kl}=0$, $k\ne l$

Pinned rather than free, but **pinned and unspent**. Criticality forces $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ for all $k\ne l$, basis-independently, $N(N-1)/2$ scalar relations, against the single $\lambda_{\min}$ row the deficiency argument uses. The file names this reserve twice and never draws on it. Combined with S1, this is the sharpest statement of where the remaining information is: **the diagonal of $M$ is the tautology, the off-diagonal of $M$ is the reserve, and the second moment of the row marginal is the free variable the reserve would have to control.**

---

## Tautologies found

### T1. The deficiency reformulation, confirmed, and the file already closes it

The closure box is correct and I reproduce the substitution to certify it. With $\sum_{a,b}c_{vab}^2=2(n-2)$ over ordered pairs,

$$D(v)=\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2=\langle v,W^\#v\rangle-(n-2)\lambda_{\min}\lambda_{\max},$$

and criticality gives $\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$ for $v\in E_{\min}$, so

$$\frac{D(v)}{\lvert\lambda_{\min}\rvert}=\frac{\lambda_{\min}\theta-\lambda_{\min}^2-(n-2)\lambda_{\min}\lambda_{\max}}{-\lambda_{\min}}=\lambda_{\min}+(n-2)\lambda_{\max}-\theta .$$

Both sides of the displayed equivalence are functions of $(\theta,\lambda_{\min},\lambda_{\max})$ alone. Nothing survives. Route R14 is correctly closed and the box says so.

**What the box does not say, and should.** The boxed *identity* of Lemma L70 is the tautology; the *inequality* $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ is not. The inequality's content is entirely the termwise step $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_{\max}$ against the fixed mass $2(n-2)$, and that is real. The file blurs the two by calling the whole thing "the lossy half of an exact identity", but a reader who takes the closure box at face value will discard the inequality along with the identity, and the inequality is the one thing in the section that is not a rearrangement.

### T2. Lemma L71's hypothesis is a scalar spectral equation, not a structural one

The file states, in the surviving-content paragraph:

> $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ holds **iff** $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$, **a structural condition on the bracket that the spectrum does not see**.

The two halves of that sentence contradict each other, and the identity of T1 is why. At a critical point the structural condition is equivalent to $D(v)=0$, and $D(v)$ is a function of $(\theta,\lambda_{\min},\lambda_{\max})$. So the bracket condition **is** seen, by the spectrum together with $\theta$. The sentence is defensible only if "the spectrum" is read as excluding $\theta$, and that reading has to be written down, because the whole point of the deficiency route was that $\theta$ is the unknown.

**The consequence is a scope limit on Lemma L71 that the file does not record.** Lemma L71 is unconditionally correct (I checked its chain line by line, see Clean below) but its hypothesis can be restated with no Lie theory in it at all:

> *A critical $W\in\mathcal W_n$, $n\ge5$, with $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ is the balanced sphere product $S^{n/2}\times S^{n/2}$.*

Read that way it is plainly a classification of a measure-zero set defined by an equation in the unknown, and it cannot be a step in a proof of $\theta\le\theta_0$: verifying its hypothesis requires already knowing $\theta$. It gives nothing at any point with $D>0$, and the record's own numbers show how much room that leaves, $\lambda_{\min}+(n-2)\lambda_{\max}=3.162$ at $\mathbb{CP}^3$, where $\theta=\theta_0(6)=1.054$, a slack of $2.1$ at a point sitting exactly on the conjectured ceiling. The section heading *"Saturation is a Lie-theoretic condition, and unwinding it is the whole proof"* overstates by scope: it is the whole proof of the classification of the saturating set, and no part of the proof of Conjecture A.

**What a successor would need instead, stated positively:** a *quantitative* stability version ($D(v)\le\varepsilon\Rightarrow W$ within $f(\varepsilon)$ of a balanced product) which the record does not have and which does not follow from Lemma L71, because the map $D\mapsto\theta$ passes through $\lambda_{\min}+(n-2)\lambda_{\max}$ and that quantity is unconstrained.

### T3. $\theta=\theta_0(n)$ at saturation is forced by normalisation

Lemma L71's *"Consequently $\theta=\theta_0(n)$ exactly"* is arithmetic, not mechanism, and the derivation is four lines. Given two eigenvalues, tracelessness makes $\lambda_{\max}\dim\mathfrak h=\lvert\lambda_{\min}\rvert\dim\mathfrak m$, so the imported ratio $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$ **is** the dimension split $\dim\mathfrak h=n(n-2)/4$, $\dim\mathfrak m=n^2/4$, one statement, not two. Unit norm then gives

$$\lambda_{\min}^2\Big[\tfrac{n^2}{(n-2)^2}\cdot\tfrac{n(n-2)}4+\tfrac{n^2}4\Big]=\lambda_{\min}^2\cdot\tfrac{n^2}4\cdot\tfrac{2n-2}{n-2}=1,\qquad \lvert\lambda_{\min}\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2n-2}},$$

and $\theta=\lambda_{\min}+(n-2)\lambda_{\max}=(n-1)\lvert\lambda_{\min}\rvert=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$.

The file already flags this species of defect once, in the LP ablation box, *"the value is forced arithmetic: tracelessness makes $\lambda_{\min}+(n-2)\lambda_{\max}=\theta_0(n)$ identically at $r=n(n-2)/4$"*, and then does not apply the same flag to Lemma L71's own concluding clause, which is the same arithmetic. Not an error; a missing cross-reference that will mislead.

### T4. The $g_\gamma$ cap and Lemma L70 have the identical equality case, so they are not two pieces of evidence

The file records the per-coordinate cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$ as Gate 2 output from Reviewers 109 and 110, with *"at the maximiser costs nothing, the cap is saturated exactly on $S^k\times S^k$"*, and records Lemma L70's tightness at the balanced products separately. **They saturate for the same reason.** Both come from a termwise step against the same fixed mass $2(n-2)$; the cap's equality case is *all row mass on pairs achieving $(\lambda_\alpha-\lambda_\beta)^2=(\lambda_{\max}-\lambda_{\min})^2$*, and Lemma L70's is *all row mass on pairs achieving $\lambda_\alpha\lambda_\beta=\lambda_{\min}\lambda_{\max}$*; with $\lambda_{\min}<0<\lambda_{\max}$ both conditions are exactly "$\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$".

The arithmetic confirms it. At a balanced product, $\lambda_{\max}-\lambda_{\min}=\lvert\lambda_{\min}\rvert\tfrac{2n-2}{n-2}$ and $\lambda_{\min}^2=\tfrac4{n^2}\tfrac{n-2}{2n-2}$, so

$$2(n-2)(\lambda_{\max}-\lambda_{\min})^2=2(n-2)\cdot\tfrac4{n^2}\cdot\tfrac{2n-2}{n-2}=\tfrac{16(n-1)}{n^2}=g_v$$

exactly, the recorded value. The two results are one result in two coordinate systems, and the file should stop citing the cap's tightness at $S^k\times S^k$ as independent corroboration of anything.

### T5–I28. Tautologies the file already owns, checked and confirmed

- **The Hilbert–Schmidt form.** $\theta=\lambda_{\min}+\tfrac{g_v}{4\lvert\lambda_{\min}\rvert}-\tfrac{\lVert\mathrm{ad}(v)W\rVert^2}{2\lvert\lambda_{\min}\rvert}$ is the eigenbasis identity under $2ab=a^2+b^2-(a-b)^2$; the file's box says so and is right. Note the correct residue, which the box does not state: the *combination* is a re-partition, the two *terms* are not, see S2.
- **The per-direction identity.** $\theta=\tfrac{\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}}{2\lambda_\gamma}+\lambda_\gamma-\tfrac{g_\gamma}{4\lambda_\gamma}$ follows from $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ with $Q_\gamma=2(W^\#)_{\gamma\gamma}=2(\theta\lambda_\gamma-\lambda_\gamma^2)$. Verified; the file's reading (*"being an identity is exactly why it cannot close"*), is correct, and the slack $g_\gamma/(4\lambda_\gamma)$ is right.
- **The product route, $\Pi/4=\theta$.** The slack identity is consistent only with $\Pi=\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma$ (not $\lvert\lambda_{\min}\rvert\sum_\gamma g_\gamma$); under that reading $\Pi-4\theta=\sum_{\mathfrak m}(\lvert\lambda_{\min}\rvert-\lvert\lambda_\gamma\rvert)g_\gamma+\sum_{\mathfrak p}\lambda_\gamma g_\gamma$ checks out term by term, and the kernel correctly enters neither side. The definition is not restated in this file and the identity is unreadable without it.

---

## Weak evidence

### W1. "$Q$ maps $\mathcal W_n$ into $\mathcal W_n$", asserted in a parenthetical, and the entire deficiency section rests on it

This is the most serious item in the audit. The claim appears once, in a list of *"three free constraints the record has not used"*, with no proof and no citation:

> $Q$ maps $\mathcal W_n$ into $\mathcal W_n$, so criticality carries no Weyl projection and several recorded statements assume one that is not there.

Everything in the deficiency material needs it. If the constrained criticality equation is $\Pi_{\mathcal W}Q(W)=\theta W$ rather than $Q(W)=\theta W$, then $W^\#$ is **not** a polynomial in $W$, the eigenvector relation $(W^\#)_{aa}=\theta\lambda_a-\lambda_a^2$ fails, and with it Lemma L70's identity, the R14 closure, Lemma L71's hypothesis, the per-direction identity and the eigenspace-constancy argument. The gap cannot be closed by pairing: $\langle v,W^\#v\rangle=\langle vv^{\mathsf T},W^\#\rangle$ and $vv^{\mathsf T}\notin\mathcal W_n$, so a projected criticality equation genuinely does not deliver the diagonal entries.

The claim is *plausible*, and the file itself supplies the shape of the proof it owes: the Bianchi half is exactly the recorded cancellation $b(W^\#)=-b(W^2)$, and the Ricci half would be the parallel statement $\mathrm{Ric}(W^\#)=-\mathrm{Ric}(W^2)$. That is not automatic, the space of quadratic $O(n)$-equivariant maps $\mathcal W_n\to\mathrm{Sym}^2_0(\mathbb R^n)$ is nonzero (the trace-free part of $W_{iabc}W_{jabc}$ lives in it), so the cancellation is a coefficient identity that has to be computed, not a representation-theoretic accident.

The evidence offered is the catalogue: *"verified to $4\times10^{-16}$ at the balanced products, the maximal tori, $\mathrm{ad}(\mathfrak{su}(3))$ and padded $W_{\mathbb{CP}^2}$"*, four points, all critical, all highly symmetric, and the file elsewhere records the exact mechanism by which such points can force a Ricci residual to vanish for reasons unrelated to the claim (hypothesis (F2), $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, invoked two sections later to catch two reviewers reporting non-Weyl operators as Weyl values). **The claim needs a proof or a citation, and it needs it before anything else in the section is used.**

### W2. Catalogue-based claims

- **Lemma L7's equality class**: *"Every known critical point with value above $1$ satisfies it, the sphere pairs, the $\mathbb{CP}^2$-type competitor, the Ricci-flat Kähler family, $\mathbb{CP}^3$, $\mathbb{HP}^2$."* Every name on that list is a symmetric construction, and the equality condition is *"the eigenspace ranges are graded by the Lie bracket, which is exactly the condition defining a compact symmetric pair"*. The evidence is that symmetric constructions satisfy a symmetry condition. It is evidence about the catalogue's construction, and the lemma's real content, the inequality itself, whose right-hand side $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ is genuine frame data and survives the substitution test, does not need it.
- **Conjecture L6's symmetry-free remainder**: *"searches seeded deliberately from high-value starts return to the diagonal maximizers rather than climbing, and at $n=12$ produced no non-diagonalizable zero-defect critical point at all."* A negative result from a search over a set the file's own fence post F16 says must be constructed rather than sampled. The file states that rule and does not apply it here.
- **Lemma L71's search controls**: *"~$200$ critical points at $n=4$–$8$ and $92$ at $n=5$, none saturating off the family."* Harmless now that the lemma is unconditional, but it should be labelled a control rather than support, since a saturating point off the family would contradict a theorem.

### W3. Random-element screens

The file has already paid for one of these and records it, Reviewer 326's finding that the bracket-form "equivalently" passed a screen built from random Weyl tensors and is falsified by the diagonal family. Two survivors of the same shape remain, one benign and one not:

- **Benign, and I certify them as sound**: the screens that use random Weyl tensors to prove a constraint is *independent* ($Q_\gamma$'s pin *"is violated by $0.19$–$0.51$ at random Weyl tensors, so it is genuinely outside the list"*) or to prove criticality is *unused* (*"the identities hold at random Weyl tensors too, so criticality contributes nothing"*). A single violating witness settles independence, and random points are genuine Weyl tensors, so the logic runs in the direction that works.
- **Not benign**: *"Stacked with the recorded sharpening, all four of $109$'s random-point maxima fall below $\sqrt{3/2}$."* Random Weyl tensors are the direction that cannot conclude. The file appends the correct caveat two sentences later (*"random Weyl tensors are not the live band"*), so the defect is that the sentence is stated at all rather than that it is unqualified.
- The `random Weyl | 6–10 | $\approx0$ | $\Delta\approx\tfrac12\cdot4(n-1)$` row of the defect table is uninformative for the same reason and reads as a data point.

### W4. Tightness forced by normalisation rather than by mechanism

Beyond T3 and T4, three more instances, all of which the file partially owns:

- The diagonal-criticality LP returning $\theta_0(n)$ to nine digits at $n=6,8,10,12$. Owned, and correctly: ablation showed one row reproduces the optimum and the value is forced by tracelessness at $r=n(n-2)/4$.
- *"It is exact at every balanced sphere product ... That is structural rather than lucky."* The mechanism given is right ($S_{\mathfrak{mhh}}=0$ makes both mass bounds equalities, the two-valued spectrum attains every eigenvalue factor) but "structural" is doing work the sentence has not earned: the *value* being $\theta_0(n)$ is still T3's arithmetic, and the band maximum of $8.16$–$13.78$ recorded three lines later is the honest reading.
- *"A single expression reproduces both $\sqrt{3/2}$ and $\theta_0(n)$"* for the min-of-two-bounds. This is the exact shape the programme has been burned by before, sharp at the equality family, useless between. The file immediately reports the band failure, so it is owned; it should not be described as *"exact at all eight test points"* without the qualifier in the same sentence.

### W5. Fence post F20's "closed form" is forced by a dimension count

$\theta=c_n\Psi_3+\tfrac5{72}\Phi$ is presented with residuals and out-of-sample confirmations as if it were an empirical discovery. On Ricci-flat $W$ the cubic invariants are a **2-plane** spanned by $\operatorname{tr}W^3$ and $\langle W,W^\#\rangle$, the file says so itself. $\theta$ is the point with $a/b=1$, $\Psi_3$ the point with $a/b=-14$, $\Phi$ the point with $a/b=-\tfrac12$. Any two distinct points of a 2-plane span it, so the existence of the closed form is automatic and only the coefficients carry information. Solving $\theta=x\Psi_3+y\Phi$ in those coordinates gives $x\,b_\Psi=-\tfrac19$ and $y\,b_\Phi=\tfrac{10}9$, so $\Phi$'s coefficient is $n$-independent exactly when $b_\Phi=16$ is, which is the fact worth recording, rather than the fit.

**A gift back, derived by hand from the file's own three integers.** The recorded $c_n=1050,\,2310,\,4620$ at $n=6,7,8$ has a closed form:

$$c_n=\frac{(n-1)n(n+1)(n+2)(n+3)(n+4)}{144}.$$

Check: $5\cdot6\cdot7\cdot8\cdot9\cdot10=151200$, $/144=1050$; $6\cdot7\cdot8\cdot9\cdot10\cdot11=332640$, $/144=2310$; $7\cdot8\cdot9\cdot10\cdot11\cdot12=665280$, $/144=4620$. Three for three, and it is the natural degree-$3$ sibling of the file's own $\Psi_2=12/\big((n-1)n(n+1)(n+2)\big)\lVert W\rVert^2$. The record should carry the formula rather than the case list.

### W6. Lemma L13's quoted excesses do not follow from its own inequality

*"the method's ceiling is $\lambda\le2-o(1)$ against a true $\sqrt2$: an excess of $49.7\times$ at $n=12$ and $3.09\times$ asymptotically."*

From the displayed $\lambda^2(1+\tfrac{k_0}4)\le\tfrac{(n-1)(2n-1)}4$ with $k_0\le\binom n2$: at $n=12$ the ceiling is $\lambda^2\le\tfrac{63.25}{17.5}=3.6143$, so $\lambda\le1.9012$, an excess of $1.34\times$ over $\sqrt2$; asymptotically the ratio tends to $4$, so $\lambda\to2$ and the excess tends to $1.41\times$. The "$\lambda\le2-o(1)$" clause is right and the two multipliers beside it are not reconstructible from it, nor is the excess *decreasing* in $n$, as $49.7\to3.09$ would require, since the ceiling *rises* toward $2$. The route is closed either way, so nothing turns on it, but the numbers should be re-derived or struck rather than carried.

---

## Clean

Listed by name; each was substituted and survives.

- **Lemma L70, the nonnegativity $D(v)\ge0$.** Termwise $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_{\max}$ holds in all four sign cases given $\lambda_{\min}<0\le\lambda_{\max}$; the recorded hypothesis and the recorded all-negative counterexample are both correct.
- **Lemma L70, the equality case.** $\lambda_{\min}\lambda_{\max}<0$ strictly, so a product attaining it needs opposite signs, and $\lvert\lambda_a\lambda_b\rvert\le\lvert\lambda_{\min}\rvert\lambda_{\max}$ with equality only at both extremes. Rigorous as written.
- **Lemma L70's three bracket inclusions** $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$. Each follows from the support condition by inspecting which index pairs are permitted; the $\mathfrak r$ orthogonality that the first inclusion needs is present.
- **Lemma L71's ideal argument.** $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ absorbs $\mathfrak m$, $\mathfrak h$ and $\mathfrak r$, all three checked line by line, the $\mathfrak h$ step using only $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ and Jacobi. $\mathfrak{so}(n)$ simple for $n\ge5$ and $\mathfrak m\ne0$ gives $\mathfrak g'=\mathfrak{so}(n)$, hence $\mathfrak r=0$ and $[\mathfrak m,\mathfrak m]=\mathfrak h$. The four self-recorded defects, including the circularity of the earlier two-eigenvalue derivation, are correctly diagnosed.
- **Lemma L71's uniqueness step.** $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\tfrac{n^2}4+t^2-\tfrac n2$ forces $t=0$ against the target $\tfrac{n(n-2)}4$ at every even $n$; $\mathfrak u(n/2)$ has $\dim=n^2/4$ and misses; those are the only symmetric subalgebras of $\mathfrak{so}(n)$; $\dim\mathfrak g^\theta$ is an $\mathrm{Aut}$-invariant so triality adds nothing at $n=8$. Correct, and the case list is rightly deleted.
- **Lemma L7's inequality**, whose right-hand side $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ is frame data and not a function of $(\text{spectrum},\theta)$, it passes the elimination test, unlike its equality-case evidence.
- **Fence post F21's quantitative closure.** The canonical-form expansion, Berger on each off-diagonal four-frame, and $\lVert\sigma\rVert_1^2-\lVert\sigma\rVert_2^2\le r-1$ give $\lvert\lambda_{\min}\rvert\le\lvert K_{\min}\rvert+\tfrac23(K_{\max}-K_{\min})(r-1)$ as stated; tracelessness supplies $K_{\min}\le0$, which the $\lvert K_{\min}\rvert$ term needs.
- **Fence post F19's corrected closure**, whose load-bearing clause is that Lemma 6.3 speaks only of realised compact metrics while Conjecture A is pointwise algebraic. Sound, and independent of the sign correction.
- **The per-coordinate cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$** as an inequality, valid, though see T4 on its equality case.
- **$\Delta$'s identification as orbit-motion mass**, the exactness of $P$ along the orbit, and $\mathcal O\subseteq E_{L_e}(\tfrac12)$ with the exact splitting of the orbit part. The scoped closure (*no argument evaluating the second-order form on the orbit tangent can produce a violation*), is stated at its true width, and the positive instruction that $\Delta>0$ enters as a hypothesis about small isotropy rather than as a supply of test directions is the right reading.
- **The graded/$\Delta=0$ Schur argument** giving at most two distinct positive eigenvalues for $p,q\ne4$, with the $p=4$ exception correctly identified and correctly called narrow.
- **$\lambda_{\max}(M)=\theta$ at a global maximiser** and the by-product $\theta\ge\max_\alpha\lambda_\alpha$, the diagonal-entry step is right and the maximiser hypothesis is load-bearing and stated.
- **$\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A**, correct, since $\lambda_{\max}(M)\ge\langle\lambda,M\lambda\rangle=\theta$ at unit $\lambda$.
- **The $S^3\times S^3$ degeneracy warning** on $b(W^2)$ and $b(W^\#)$, the right lesson, stated positively.

### One unstated qualifier, small but load-bearing

*"$\Pi/4=\theta_0(n)$ at any two-eigenvalue critical point with $\Delta=0$"* is contradicted by padded $W_{\mathbb{CP}^2}$ ($\Delta=0$, nonzero eigenvalues $\{2c,-c\}$, and $\Pi/4=\sqrt{3/2}\ne\theta_0(n)$ for $n\ge6$), unless "two-eigenvalue" is read as *exactly two eigenvalues counting the kernel*, i.e. trivial kernel. Under that reading the claim stands. The qualifier is not written and the file's own most-cited witness is the counterexample to the unqualified form.

---

## The one-line instruction this audit leaves

**Stop looking for a lower bound on $D$; the deficiency's magnitude is $(\theta,\lambda_{\min},\lambda_{\max})$ and always will be. The free variable is the second moment $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$ of each row marginal, free because $W^2$ leaves $\mathcal W_n$, and the unspent constraints on it are the off-diagonal criticality relations $M_{kl}=0$, the Jacobi identity, and $b(W^2)=-b(W^\#)$. Before any of that is used, prove or cite $\mathrm{Ric}(W^2+W^\#)=0$ on $\mathcal W_n$.**
