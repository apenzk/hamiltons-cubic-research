# Reviewer 152, Gate 2 on the Jensen refutation, 9f85f84 and 7323e69

**Headline: the refutation itself is CONFIRMED (Jensen's Weyl operator is not the Casimir of any subalgebra) and everything built around it is wrong.** The brief's designated likeliest defect is not a defect: the family theorem's $\theta$ formula needs criticality alone, and I re-derived it by hand. What fails is the independence claim, the word "graded", the novelty, and the regrade. The narrowed form of plan item 1 (the form the regrade was meant to preserve), is refuted by a point the same file records eighty-five lines earlier, above the threshold.

| # | claim | verdict |
|---|---|---|
| 1 | the $\theta$ formula presupposes (F1),(F2),(F3) | **NOT a defect**, formula re-derived from criticality alone |
| 2 | "the two arguments share no arithmetic" (Gate 1(b)) | **REFUTED**, both are corollaries of the one closed form |
| 3 | Jensen is *graded* | **UNSUPPORTED**, only $S=0$ was measured, and the record itself says that is weaker |
| 4 | the refutation is new | **REFUTED**, already on the record twice, at [graded-half.md](../findings/graded-half.md) and [target.md](../findings/target.md) |
| 5 | (H) is untouched, Jensen sitting below $\sqrt{3/2}$ | **CONFIRMED** |
| 6 | item 1 regraded $6\to2$ | **WRONG**, its narrowed form is refuted too; the honest grade is $0$ |

## 1. THE DESIGNATED DEFECT IS NOT THERE, the $\theta$ formula holds for every critical Casimir

The theorem's own statement carries its hypothesis: *"Let $0<r<N$ and suppose $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$."* (F1),(F2),(F3) appear one paragraph later under a different heading, *"Criticality is free under three hypotheses"*, they are a sufficient condition for the hypothesis, never an ingredient of the conclusion. I checked that this is not merely how it is worded by redoing the proof.

Fix $\varphi_\alpha$ an orthonormal basis of $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$, $c_{\alpha\beta\gamma}=\langle[\varphi_\beta,\varphi_\gamma],\varphi_\alpha\rangle$ totally antisymmetric, and $W=u\Pi_{\mathfrak h}+v\Pi_{\mathfrak m}$ with $ur+v(N-r)=0$. For $W$ diagonal, $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\beta\gamma}c_{\alpha\beta\gamma}^2w_\beta w_\gamma$; this normalisation is pinned by the record's own two anchors, $\sum_{\beta\gamma}c_{\alpha\beta\gamma}^2=\kappa=2(n-2)$ and $Q(\mathrm{Id})=(1+\kappa/2)\mathrm{Id}=(n-1)\mathrm{Id}$, so $\sigma=n-1$.

Only $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ is used, and it is used twice: it kills $c_{\alpha\beta\gamma}$ for $\alpha,\beta\in\mathfrak h$, $\gamma\in\mathfrak m$, and it gives the two mass identities. Tracing $Q(W)=\theta W$ over $\mathfrak h$ and over $\mathfrak m$ separately:

$$\sigma ru^2+\tfrac12S_{\mathfrak{hmm}}(v^2-u^2)=\theta ur,\qquad \sigma(N-r)v+S_{\mathfrak{hmm}}(u-v)=\theta(N-r).$$

Substituting $v=-ur/(N-r)$ and eliminating gives $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ and $\theta=\sigma ur/(N-r)$, and with $c=\sqrt{N/(r(N-r))}$, $2N=n(n-1)$ that is $\theta=\tfrac2n\sqrt{rN/(N-r)}$, the recorded closed form, digit for digit in symbols. $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}=(N-r)[2(n-2)-4(n-1)r/N]$ likewise.

**Nothing in that chain touches Ricci-flatness, the Bianchi identity, $K$-irreducibility, or a normaliser.** Only the two block traces of the eigen-equation are used, and a trace of a necessary condition is a necessary condition. So the formula is a consequence of criticality for *every* subalgebra Casimir, and argument (ii) inverts a formula that does apply. The brief's worry is answered in the negative.

Two internal cross-checks that the formula is the right one. At the cap $r=n(n-2)/4$ it returns $\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$ exactly; at $n=12$, $r=\dim(\mathfrak{so}(6)\oplus\mathfrak{so}(6))=30$ is the cap $n(n-2)/4=30$, matching the one *two-eigenvalue* row of the $n=12$ multifactor table at $\theta_0(12)=1.236033$. And $\mathfrak{so}(5)\oplus\mathfrak{so}(7)\subset\mathfrak{so}(12)$ has $r=31>30$, so the theorem forbids its Casimir from being critical, consistent with that row being a three-eigenvalue operator instead.

## 2. THE TWO ARGUMENTS ARE ONE, Gate 1(b) was not met

Both arguments run through the same closed form and differ only in what they append to it:

- **(i) by value** = the formula $+$ the cap $r\le n(n-2)/4$, which comes from $S_{\mathfrak{mmm}}\ge0$;
- **(ii) by dimension** = the formula $+$ integrality of $r$.

The commit message says "sharing no step" and the record says "the two arguments above share no arithmetic". They share the only substantive step. If the closed form were wrong both die together, which is precisely the failure mode Gate 1(b) exists to exclude.

**Worse, (ii) is redundant given (i).** At $n=6$ the cap is $r\le6$, and $r=6$ already gives $\theta=\theta_0(6)=1.054093$; the formula is increasing in $r$, so every critical Casimir at $n=6$ has $\theta\le1.054093<1.095445$. The non-integer $r=270/43$ is a fact about a value the cap has already excluded. (ii) has residual value only as a fallback if one distrusts the sum-of-squares step, which is a statement about confidence, not about independence.

**And argument (i) does not need gradedness.** The section routes it through "equality **exactly** when graded, so a graded critical Casimir sits at $\theta_0(n)$ and nowhere else", but the plain inequality $\theta\le\theta_0(n)$ does the whole job at $1.0954>1.0541$. Dragging the equality clause in is what imports the defect of §3.

## 3. "GRADED" AT JENSEN IS NOT THE "GRADED" IN THE THEOREM, the record already logged this trap

The theorem's equality clause reads $S_{\mathfrak{mmm}}=0$, i.e. $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, and it upgrades to a $\mathbb Z_2$-grading **only because $\mathfrak h$ is a subalgebra and $\mathfrak m=\mathfrak h^\perp$ by construction**, so the other two grading conditions are free. Jensen's $S$ is a different functional: [p3_jensen_s3s3.py](../scripts/pipelines/p3_jensen_s3s3.py) computes the graded-compression slack $S=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)$ on the negative eigenspace of an operator with no subalgebra attached.

This record already caught exactly this inference once. [second-order.md](../findings/second-order.md), *"Outside the subalgebra family, slack zero does not imply a $\mathbb Z_2$-grading"*: $W_{\mathbb{CP}^2}$ has $S=0$ with $[\mathfrak m,\mathfrak m]\to\mathfrak m$ at $10^{-32}$ while $[\mathfrak h,\mathfrak m]\to\mathfrak h$ and $[\mathfrak h,\mathfrak h]\to\mathfrak m$ leak at $4.0$ and $4.899$, and the paragraph closes with the lesson in the general form, *"the slack measures the third grading condition alone, so it certifies a grading only where the other two hold by construction, which is what defines the subalgebra family."* [reviews/INDEX.md](INDEX.md) records the same shape of error a second time: the two-block Fox plateau *"is not $\mathbb Z_2$-graded ($S_{\mathfrak{hhm}}=32$)"*. The Jensen commit measures $S$ and writes **graded** in the table and in the section title, with the other two leak terms never computed.

There is positive reason to expect them nonzero. The value $\sqrt{6/5}$ and the multiplicity pattern $3,7,5$ match the $(\mathfrak{su}(3),\mathfrak{so}(3))$ point recorded at [target.md](../findings/target.md), $\mathfrak{su}(3)\subset\mathfrak{so}(6)$ with $p=\dim\mathfrak{so}(3)=3$, $q=5$, and $W$ vanishing on the $7$-dimensional complement of $\mathfrak{su}(3)$ in $\mathfrak{so}(6)$. The grading candidate is then $\mathfrak h=$ the nonnegative eigenspace $=\mathfrak{so}(3)\oplus\mathfrak{su}(3)^\perp$, of dimension $10$, which is not a subalgebra of $\mathfrak{so}(6)$; $[\mathfrak{su}(3)^\perp,\mathfrak{su}(3)^\perp]$ lands back in $\mathfrak{su}(3)$ and there is no reason for its $\mathfrak m$-component to vanish. **I did not compute the two leaks, the argument above is structural and does not settle the sign, so the claim is recorded as unsupported rather than as false.** What is settled is that the record's own stated rule forbids reading $S=0$ as gradedness here.

**Consequence.** The refutation survives untouched, because neither argument needs gradedness. The *section title* does not: "the graded critical set is strictly wider than the subalgebra family" needs Jensen to be graded, and what was verified is that the $\{S=0\}$ set is strictly wider. The title claim is nonetheless true, see §4, which supplies witnesses that are graded in the strict sense.

*One further convention caution, not load-bearing here.* [nondegeneracy.md](../findings/nondegeneracy.md) records $41$ indecomposable $C_5$ blow-ups where *"the two slack conventions disagree"*, so $S$ and $S_{\mathfrak{mmm}}$ are not interchangeable across the record as a matter of fact, not only of derivation.

## 4. THE CONCLUSION WAS ALREADY ON THE RECORD, TWICE, AND IN A STRONGER FORM

Question (b) of the brief, and this is the fourth-time-around pattern it warns about.

**Already stated in the same file, one paragraph above the new section.** [graded-half.md](../findings/graded-half.md) closes the family theorem with *"Members are the balanced $k$-block products and a handful of isotropy-irreducible points; the unbalanced products, $\mathbb{CP}^m$, $\mathbb{HP}^m$, the complex Grassmannians and every generic ungraded point sit outside"*, and it records $W_{\mathbb{CP}^3}$ at $n=6$ as *"critical at residual $5.1\times10^{-16}$ with $\theta=\theta_0(6)$ exactly, tying $S^3\times S^3$ from outside it"*, with the same file's Correction 3 reporting all four $\mathbb{CP}^m$ rows at $S=0$. Eighty-five lines earlier the enumeration section states *"only the balanced split is a two-eigenvalue operator. Every unbalanced sphere product is a genuine three-eigenvalue graded critical point"*. A Casimir $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has **exactly two** eigenvalues, $c(1-r/N)>0$ and $-cr/N<0$, for every $0<r<N$. Those two sentences therefore already say, in one line and with no new computation, that the graded critical set is strictly wider than the family.

**Already available at the very value Jensen supplies.** [target.md](../findings/target.md) lists the $(\mathfrak{su}(3),\mathfrak{so}(3))$ point at $n=6$, $\theta=1.095445115$, $S_{\mathfrak{mmm}}=1\times10^{-31}$, non-diagonal, the same $\theta$ Jensen has, and the Jensen paragraph itself concedes the coincidence (*"the value $\sqrt{6/5}$ coincides with the $\mathfrak{su}(3)$ Kähler point already in the enumeration"*). That point is refuted as a Casimir in **one line and without the $\theta$ formula**: it is supported on the $8$-dimensional $\mathfrak{su}(3)\subset\mathfrak{so}(6)$, so it has a $7$-dimensional kernel, while every $W_{\mathfrak h}$ is nonsingular. This is the genuinely independent second argument Gate 1(b) wanted, it was on the record, and the commit missed it.

So the deliverable is a re-derivation of a recorded fact by a new route, presented as new. The route is worth keeping as a cross-check; the framing is not.

## 5. THE SCOPE CLAIM IS RIGHT

(H) is *"every graded critical point with $\theta>\sqrt{3/2}$ is a sphere product"* ([plan.md](../plan.md)). $1.095445115<1.224744871$, so Jensen falls outside the hypothesis and (H) is untouched. Confirmed as stated, and the section is right to say so explicitly.

## 6. THE REGRADE IS WRONG, the narrowed item 1 is refuted too, above the threshold

This is the finding with the largest cost, because the regrade is what keeps item 1 alive as *"the only nonzero score in section 1"*.

The narrowed statement is: **every graded critical point of $P$ with $\theta>\sqrt{3/2}$ is $W_{\mathfrak h}$ for some subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$.** The record refutes it:

> $S^5\times S^7$ at $n=12$. [graded-half.md](../findings/graded-half.md)'s multifactor table gives $\theta=1.228239158$, three eigenvalues with $a\ne b$, from a solve that imposes Ricci-flatness and unit norm and reproduces Nienhaus Proposition 2.25 to nine digits. The same paragraph calls it *"a genuine three-eigenvalue graded critical point"* and flags that it *"sits at $1.228239>\sqrt{3/2}=1.224745$, above the threshold the enumeration was built to police"*.

It is graded in the strict sense, not merely $S=0$: $\mathfrak h=\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ is the fixed algebra of an involution of $\mathfrak{so}(12)$, so all three grading conditions hold by construction. It is critical. It is above $\sqrt{3/2}$. And it has three distinct eigenvalues, so it is not $W_{\mathfrak h}$ for **any** subalgebra, by the two-eigenvalue count alone. Independently, the family theorem forbids it directly: $r=10+21=31$ exceeds the cap $n(n-2)/4=30$.

**So the subalgebra route to (H) is closed outright, not narrowed.** Item 1's *closes* factor is intact and its *attackable* factor is $0$, not $1$: there is no gap left to attack, because the statement being attacked is false at $n=12$. On the recorded grading scheme that is a value of $0$, not $2$. Section 1 then has no nonzero item, which is a harder place to be but is where the record actually stands.

Note that (H) itself remains consistent, $S^5\times S^7$ is a sphere product, so it is a counterexample to "is a Casimir" and not to "is a sphere product". What dies is the reduction of (H) to a subalgebra classification, in every form, restricted or not.

## Answers to the brief's questions

**(a) Is the refutation confirmed?** **CONFIRMED** in its narrow statement, Jensen's Weyl operator is not the Casimir of any subalgebra $\mathfrak h\subseteq\mathfrak{so}(6)$, and it rests on one argument rather than two. It does **not** merely narrow the subalgebra route to (H); the route is fully closed, but by $S^5\times S^7$ rather than by Jensen, and that closure was available before this cycle.

**(b) Anything asserted as new that the record already holds?** Yes, and it is the main defect after §6. "The graded critical set is strictly wider than the subalgebra family" is stated in the immediately preceding paragraph of the same file and follows in one line from the $n=12$ enumeration table plus the definition of $W_{\mathfrak h}$. The $\theta=\sqrt{6/5}$ point at $n=6$ is already tabulated as $(\mathfrak{su}(3),\mathfrak{so}(3))$, and the section itself notes the coincidence without drawing the consequence that the claim is therefore not new.

**(c) Is the regrade right?** **No.** $6\to2$ should be $6\to0$ for the statement as written, or item 1 must be restated as something other than "is a Casimir", at which point it collapses into (H) itself and stops being a separate item.

## Disagreements, stated explicitly

1. I disagree with the brief's own prior that item 1 was the likeliest defect. The $\theta$ formula is clean and hypothesis-free beyond criticality; I re-derived it rather than accepting the wording.
2. I disagree with the record's Gate 1(b) ("the two arguments above share no arithmetic") which is false, and with Gate 1(c) ("Jensen's criticality and **gradedness** are screened values already on this page") where only $S=0$ is screened.
3. I disagree with the plan's *"Jensen sits below $\sqrt{3/2}$, so (H) itself survives, what fell is the unrestricted reading."* (H) survives, but the narrowed reading fell at the same moment, and the plan retains it.

## Method

Derivation only, per the brief. The $\theta$ formula, $S_{\mathfrak{hmm}}$, $S_{\mathfrak{mmm}}$, the cap and $\theta_0(n)$ were re-derived by hand from the structure-constant definitions; the eigenvalue-count and kernel arguments are structural. No script was run and no number was computed; every figure quoted is read from the record.
