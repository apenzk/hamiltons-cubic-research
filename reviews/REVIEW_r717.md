# Review r717, Gate 2 on [Lemma L149](../findings/second-order.md)'s "THE UNIFORMITY CONSTANT AFTER THE MARGIN REPAIR"

*Cold brief, analysis-only. Every closed form below was derived by hand from the definitions; the only compute is one screen at $n\in\{10,12,14,16,18,20\}$ (plus four large $n$) evaluating those closed forms and one bracketed minimisation of a function I construct here, run to place minimisers I had already located analytically. It is reported as a screen and is the evidence for nothing positive. No search, sweep, census or falsifier hunt was run.*

| Claim | Verdict |
| --- | --- |
| **C1**, the margin is a quadratic form, so on $\lVert H\rVert_F=1$ it is a convex combination of summand margins, giving $c(H)\ge c_p+\rho_nw^2$ with $\rho_n=3\theta_0\tfrac{n-8}{2(n-2)}$, the old $c_p+w^2$ being a lower bound stated upward at $n=12$ and $n=14$ | **CONFIRMED**, and I re-derived it from [Lemma L27](../findings/nondegeneracy.md)'s ten eigenvalues rather than from [r716](REVIEW_r716.md). The combination is genuine, its coefficient is the *smallest* surviving summand margin (the $+\mu$ one on $\Lambda^2\otimes\Lambda^2$, $3\theta_0\tfrac{m-3}{2(m-1)}$) and the $m\to n$ substitution is exact: $\tfrac{m-4}{2(m-1)}=\tfrac{n-8}{2(n-2)}$ at $n=2m$. **Two scope repairs are owed**: the display is even-$n$ only, and $\theta_0$ must be read as $\theta_0(n)$, not $\sqrt2$ |
| **C2**, $g(w)=\sqrt{c+\rho w^2}/(A+Bw)$ has interior minimum $w^*=Bc/(\rho A)$ with value $\sqrt c/\sqrt{A^2+B^2c/\rho}$ | **ALGEBRA CONFIRMED, "INTERIOR" REFUTED.** Both closed forms are right. But under the entry's own $A=n^{1/2}$, $B=n$ the minimiser is $w^*=\tfrac{2\sqrt n}{n-8}$, which is $3.162$, $1.732$, $1.247$ at $n=10,12,14$ and reaches $1$ only at $n=16$. **The minimum is at the endpoint $w=1$ at every dimension the blockquote quotes a number for.** [Lemma L158](../findings/second-order.md) already records this defect for the unrepaired $w^*$; the repair reintroduces it |
| **C3**, $\kappa/\rho_n=2n/(n-8)$ exactly, so $\min_wg=\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ | **RATIO CONFIRMED EXACTLY; THE VALUE IS NOT THE MINIMUM AT $n\le14$.** $\kappa/\rho_n=2n/(n-8)$ is an identity and $\theta_0$ does cancel from *it*. The consequent value is a valid lower bound but is unattained on $[0,1]$ at $n=10,12,14$, understating $\min_{[0,1]}g$ by $11.3\%$, $2.6\%$, $0.4\%$. **And $\theta_0$ does not cancel from the displayed value**, which still carries $\kappa$ |
| **C4**, order untouched, constant moves by $0.882$/$0.978$/$\to1.32$, $\rho_n\in[0.45,2.11]$ for $m\ge5$, conclusion stands | **REFUTED IN THE INTERVAL AND IN THE READING OF THE FIGURES; THE ORDER CLAIM SURVIVES FOR A REASON THE ENTRY MIS-STATES.** $\rho_n$ increases to $3\sqrt2/2=2.12132$ and passes $2.11$ near $n\approx1450$, inside the range [r713](REVIEW_r713.md) exercises. The three ratios reproduce to five figures but relate two *unattained* values; the attained ratios are $0.788$, $0.901$, $0.980$ at $n=10,12,14$. And $\rho_n>0$ buys the **exponent**, not the constant: at $\rho=0$ the branch is $\Theta(n^{-3/2})$ |

## The constants, found by their defining relations and evaluated at $n=12$

**Everything the blockquote turns on is $n$-dependent, and the entry used the finite-$n$ value in each case.** I checked this before attacking anything, because the alternative reading changes every number.

| quantity | defining relation | at $n=12$ | limit |
| --- | --- | --- | --- |
| $\theta_0(n)$ | $\theta_0^2=2(n-1)(n-2)/n^2$ ([conventions.md](../findings/conventions.md)) | $1.236033$ | $\sqrt2=1.414214$ |
| $c_p$ | $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ ([Lemma L141](../findings/second-order.md)) | $0.370810$ | $0$ |
| $\kappa$ | $nc_p=3\sqrt{2(n-1)/(n-2)}$ ([Lemma L158](../findings/second-order.md)) | $4.449719$ | $3\sqrt2=4.242641$, from above |
| $\rho_n$ | $3\theta_0\tfrac{n-8}{2(n-2)}=\kappa\tfrac{n-8}{2n}$ | $0.741620$ | $3\sqrt2/2=2.121320$, from below |
| $a_0n^{-1/2}$ | $\sqrt{2/(n-2)}=1/\sqrt{m-1}$ ([Lemma L146](../findings/second-order.md)) | $0.447214$ | $0$ |
| $1/g_n$ | $n^2c_p/6$ ([Lemma L158](../findings/second-order.md)) | $8.899438=0.7416\,n$ |, |

*Reading $\theta_0=\sqrt2$ at $n=12$ would give $\rho_{12}=0.848528$ and a ratio of $0.933$ in place of $0.882$; the entry's $0.741620$ and $0.882$ are the finite-$n$ pair, so it passes the test that [Lemma L158](../findings/second-order.md) failed on $\lvert\kappa_n\rvert$.* **$\rho_n$ is increasing in $n$**, both factors being increasing, so its range over $m\ge5$ is $[0.45,\,3\sqrt2/2)$ with the left end attained at $m=5$ exactly and the right end never.

## C1 stands, and I built the convex combination from [Lemma L27](../findings/nondegeneracy.md) rather than inheriting it

**The ten summand margins at $p=q=m$.** $L_e$ is a scalar $\lambda_j$ on each summand of [Lemma L27](../findings/nondegeneracy.md)'s multiplicity-free decomposition, so the second-order form is $c(H)=3\theta_0\sum_j(\tfrac12-\lambda_j)\lVert H_j\rVert^2$ and on $\lVert H\rVert_F=1$ the weights $\lVert H_j\rVert^2$ sum to $1$, a convex combination in the exact sense, with no averaging step. The margins are

$$-\tfrac32\theta_0\ \text{on}\ \langle W\rangle;\quad 0\ \text{on}\ \mathbb R^m\!\otimes\!\mathbb R^m;\quad c_p=\tfrac{3\theta_0}{n-2}\ \text{on each }S^2_0;\quad 3\theta_0\tfrac{m-3}{2(m-1)}\ \text{on}\ \Lambda^2\!\otimes\!\Lambda^2;\quad 3\theta_0(\tfrac12+\mu)\ \text{on}\ S^2_0\!\otimes\!S^2_0;\quad \tfrac32\theta_0\ \text{on the remaining four},$$

using $\tfrac12-\mu=\tfrac{(m-2)^2-1}{2(m-1)^2}=\tfrac{m-3}{2(m-1)}$ at $p=q=m$.

**The two dangerous summands are excluded by the domain, and both exclusions are load-bearing.** $\langle W\rangle$ carries a *negative* margin and would make $\rho_n$ meaningless; it is removed by $H\in T_{W^*}S$, and [Lemma L141](../findings/second-order.md) records the same exclusion in its own words. The orbit summand carries margin $0$ and would force $\rho_n\le0$; it is removed by $H\in T_{W^*}\mathcal O^\perp$, and [Lemma L27](../findings/nondegeneracy.md) makes $E(\tfrac12)$ *equal* the orbit tangent, so the removal is exact rather than approximate. **Of the six that survive, $\Lambda^2\otimes\Lambda^2$ is strictly the smallest** ($\tfrac{m-3}{2(m-1)}<\tfrac12<\tfrac12+\mu$) so $c_{\min,r}=3\theta_0\tfrac{m-3}{2(m-1)}$ and

$$c(H)\ \ge\ c_p(1-w^2)+c_{\min,r}w^2\ =\ c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2,$$

**with equality when $H_r$ concentrates in $\Lambda^2\otimes\Lambda^2$, so the coefficient is sharp and not merely a bound.** *The old $c_p+w^2$ overstates it by $35\%$ in $c$ at $n=12$ and $16\%$ in $\sqrt c$ at $w=1$, so [r716](REVIEW_r716.md)'s charge is right in kind and in sign.*

> **TWO SCOPE REPAIRS THE DISPLAY OWES.** *[Lemma L149](../findings/second-order.md) lives at $p=q=m$, $n=2m$, and the two-copy $S^2_0$ structure its whole set-up rests on exists only there.* **So $\rho_n=3\theta_0\tfrac{n-8}{2(n-2)}$, $\kappa/\rho_n=2n/(n-8)$ and $\min_wg$ are statements about even $n$ alone**, at odd $n$ there is no balanced $p=q$, and [conventions.md](../findings/conventions.md) further separates $\Theta_n<\theta_0(n)$ there, so the display would be evaluating the wrong quantity twice over. *And $2n/(n-8)$ has a pole at $n=8$ and is negative below it*: the closed form is meaningful only from $n=10$, which is exactly the $m\ge5$ the statement carries but the display does not.

## The defect: the "interior minimum" is outside $[0,1]$ at every dimension the entry quotes

**The algebra first, because it is correct and the failure is not algebraic.** With $G=g^2=(c+\rho w^2)/(A+Bw)^2$,

$$G'(w)=\frac{2(A+Bw)\big[\rho Aw-Bc\big]}{(A+Bw)^4},$$

so $\operatorname{sign}g'=\operatorname{sign}(\rho Aw-Bc)$, the stationary point is $w^*=Bc/(\rho A)$, and substituting gives $g(w^*)=\sqrt c/\sqrt{A^2+B^2c/\rho}$, both of C2's displays, confirmed. *The $\rho\mapsto1$ specialisation returns the entry's original pair, so the carry-through is clean.*

> **$w^*=\dfrac{2\sqrt n}{n-8}$, WHICH EXCEEDS $1$ FOR EVERY $n\le14$ AND EQUALS $1$ AT $n=16$.** With $c=\kappa/n$, $A=n^{1/2}$, $B=n$ and $\kappa/\rho_n=2n/(n-8)$, the $\theta_0$ that C3 cancels from the ratio cancels from the minimiser too:
> $$w^*=\frac{Bc}{\rho_nA}=\frac{\kappa}{\rho_n\sqrt n}=\frac{2\sqrt n}{n-8},\qquad w^*\le1\iff (\sqrt n-4)(\sqrt n+2)\ge0\iff n\ge16 .$$
> **So $w^*=3.1623$ at $n=10$, $1.7321$ at $n=12$, $1.2472$ at $n=14$.** *$g$ is decreasing on $[0,w^*]$, so on the admissible $w\in[0,1]$ the minimum is the endpoint $g(1)=\sqrt{c_p+\rho_n}/(A+B)$ and C2's word "interior" is false at the whole low end of the range.* **This is the defect [Lemma L158](../findings/second-order.md) already charges against the unrepaired form**, *"$w^*=\kappa n^{-1/2}$ exceeds $1$ for every $n\le19$, so under the entry's $A=n^{1/2}$ the interior minimum is unattained in most of the range"*, **restated with $\rho_n$ carried through and the same conclusion not drawn.**

**What C3's value then is.** An unconstrained infimum never exceeds a constrained one, so $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ remains a *valid lower bound* on $\min_{[0,1]}g$; it is simply not the minimum. The gap, from the closed forms:

| $n$ | C3's value | $\min_{[0,1]}g=g(1)$ | C3 understates by | C4's ratio | attained ratio |
| --- | --- | --- | --- | --- | --- |
| $10$ | $0.063960$ | $0.072076$ | $11.3\%$ | $0.70711$ | $0.78784$ |
| $12$ | $0.066441$ | $0.068204$ | $2.6\%$ | $0.88234$ | $0.90084$ |
| $14$ | $0.063055$ | $0.063311$ | $0.4\%$ | $0.97762$ | $0.97936$ |
| $16$ | $0.058574$ | $0.058574$ | $0$ | $1.03842$ | $1.03769$ |
| $20$ | $0.050147$ | $0.050147$ | $0$ | $1.11206$ | $1.11206$ |

*So C4's $0.882$ and $0.978$ are ratios of two numbers neither of which is attained; the honest figures at those dimensions are $0.901$ and $0.979$.* **The direction of that error is safe** (it understates a lower bound), **which is what distinguishes it from the defect the repair was made to fix.** The next one is not.

## An independent defect: $A=n^{1/2}$ and $B=n$ are order symbols, and a constant cannot be read off them

> **THE CHAIN'S OWN QUANTITIES ARE $A=a_0n^{1/2}$ AND $B\approx1/(\gamma g_n)$, AND THE BLOCKQUOTE USES NEITHER.** The set-up bullet gives $\lVert H\rVert_{op}\le a_0n^{-1/2}+w$ with $a_0n^{-1/2}=1/\sqrt{m-1}=0.447214$ at $n=12$ ([Lemma L146](../findings/second-order.md)), and the proof line reads it as $O(n^{1/2}+nw)$, a legitimate $O(\cdot)$, and the source of the $\Omega$ conclusion. **But the blockquote upgrades that $O(\cdot)$ to "THE UNIFORMITY CONSTANT ... IN CLOSED FORM" while keeping the placeholders.** $A$ should carry $a_0=\sqrt{2n/(n-2)}=1.549$ and $B$ should carry $1/g_n=0.7416\,n$, both of which [Lemma L158](../findings/second-order.md) prints in its own "four constants the entry had wrong" paragraph. *Restoring $A=n\sqrt{2/(n-2)}=5.3666$ at $n=12$ drops the closed form from $0.066441$ to $0.060652$, the displayed constant is $9.5\%$ high, and against the honest constrained value $g(1)=0.060733$ it is $9.4\%$ high.* **That is a lower bound stated upward, which is the exact defect the margin repair was performed to remove.**

**$w^*$ depends only on $A/B$, so this moves the minimiser too, and it does not rescue it.** Since $w^*$ is invariant under scaling $A$ and $B$ together, only the ratio matters, and the record's ratio is $a_0n^{-1/2}$ rather than $n^{-1/2}$:

$$w^*_{\text{corrected}}=\frac{c_p}{\rho_n\,a_0n^{-1/2}}=\frac{\sqrt{2(n-2)}}{n-8},\qquad w^*_{\text{corrected}}\le1\iff n\ge9+\sqrt{13}=12.606 .$$

*Values $2.0000$, $1.1180$, $0.8165$, $0.6614$ at $n=10,12,14,16$.* **So even with the record's own constants the minimiser leaves $[0,1]$ at $n=10$ and $n=12$**, and C2's "interior" fails at the conjectured maximiser's dimension under every reading of $A$ on the record.

## The kink: at $n=12$ and $n=14$ the claimed minimiser sits in the saturated region

> **$w^*>w_0=\tfrac{n-4}n$ AT EXACTLY THE DIMENSIONS THE BLOCKQUOTE QUOTES.** [Lemma L158](../findings/second-order.md)'s Gate-2'd envelope is $\lVert H\rVert_{op}\le\min\big(a_0n^{-1/2}\sqrt{1-w^2}+w,\,1\big)$, saturating at $w_0=(n-4)/n$. **Above $w_0$ the denominator is constant and the numerator $\sqrt{c_p+\rho_nw^2}$ is increasing, so $g$ is strictly increasing there and neither C2's stationarity nor C3's value can describe the minimum.** Comparing:
> | $n$ | $w_0$ | $w^*$ under $A=n^{1/2}$ | $w^*$ under $A=a_0n^{1/2}$ |
> | --- | --- | --- | --- |
> | $10$ | $0.6000$ | $3.1623$ | $2.0000$ |
> | $12$ | $0.6667$ | $1.7321$ | $1.1180$ |
> | $14$ | $0.7143$ | $1.2472$ | $0.8165$ |
> | $16$ | $0.7500$ | $1.0000$ | $0.6614$ |
> | $18$ | $0.7778$ | $0.8485$ | $0.5657$ |
> | $20$ | $0.8000$ | $0.7454$ | $0.5000$ |
>
> *Under the entry's literal constants $w^*>w_0$ for every $n\le18$; under the record's corrected $A$, for $n=10,12,14$.* **Only from $n=16$ does the repaired interior minimiser enter the region where the linear envelope is the binding one**, so the closed form describes the minimum nowhere in the dimensions this programme argues about.

*A screen of the prefactor-free objective under the admissible kinked envelope, with $\rho_n$ carried, puts its minimiser at $0.598$ at $n=12$ and $0.522$ at $n=14$, below $w_0$ in both cases, so the repair moves the minimiser away from the kink rather than onto it. That is the opposite of [r716](REVIEW_r716.md)'s expectation, but r716 was minimising with $(1-\eta^*)^2$ present and I am not, so the two are not in conflict and I do not press it.*

## What $\rho_n>0$ actually buys, which C4 mis-states

**The entry says $\rho_n\in[0.45,2.11]$ keeps "the constant" $\Theta(1)$. It keeps the exponent.** From C2's own value with $A\asymp n^{1/2}$, $B\asymp n$, $c=\kappa/n$,

$$\min_wg=\frac1n\sqrt{\frac{\kappa}{1+\kappa/\rho}}=\frac1n\sqrt{\frac{\kappa\rho}{\rho+\kappa}},$$

so $\rho\to0$ sends this to $\sqrt\rho/n$, and at $\rho=0$ exactly, $g$ is $\sqrt{c}/(A+Bw)$, minimised at $w=1$ with value $\asymp n^{-3/2}$. **So $m\ge5$ is load-bearing for $\Omega(n^{-1})$ itself and not only for its constant**; at $m=4$, where $\rho_8=0$, branch $2$ degrades by a full half-power. *The lemma's hypothesis is therefore stronger than the entry's gloss admits, which is a point in the lemma's favour and should be recorded as one.*

**And the interval is wrong at the top.** $\rho_n=\tfrac{3(n-8)}{2n}\sqrt{\tfrac{2(n-1)}{n-2}}$ increases monotonically to $3\sqrt2/2=2.121320$, crossing $2.11$ near $n\approx1450$, *inside the range [Lemma L158](../findings/second-order.md) cites [r713](REVIEW_r713.md) for, "branch 2 binds at every $n$ up to $\approx1800$"*, so the failure is not out of scope. The correct statement is $\rho_n\in[0.45,\,3\sqrt2/2)$, left end attained at $m=5$, right end approached and never reached.

## What I did not settle

- **A factor $2$ between [Lemma L141](../findings/second-order.md) and the summand-margin list.** L141 reports $Q(W^*)=+3\theta_0$ on the radial direction, where $3\theta_0(\tfrac12-\lambda)$ at $\lambda=1$ gives $\tfrac32\theta_0$. *It is inert here (the radial direction is excluded from the domain in both readings) but one of the two normalisations is off by $2$ and I could not tell which from the entries themselves.*
- **Whether $\lVert H\rVert_{op}\le1$ is reachable near $w=1$.** [r716](REVIEW_r716.md) leaves this open and it bears directly on my endpoint values: if the saturation constant is below $1$, every $g(1)$ in the tables above rises. *Naming it is analytical work.*
- **The $w$-dependence of $(1-\eta^*)^2$.** Excluded from the blockquote's $g$ by construction, and [Lemma L158](../findings/second-order.md) shows it cannot overturn a rise, so it changes minimisers without changing the shape verdicts. I did not carry it.

**Inherited without re-derivation**: [Lemma L146](../findings/second-order.md)'s $\lVert H\rVert_{op}$ supremum and its extension to the joint two-copy eigenspace; [Lemma L156](../findings/second-order.md)'s $J^*$; [Lemma L157](../findings/second-order.md)'s fixed point; [Lemma L141](../findings/second-order.md)(a)'s contraction; $g_n$ and $\theta_0(n)$ from [conventions.md](../findings/conventions.md). **Re-derived here**: [Lemma L27](../findings/nondegeneracy.md)'s ten summand margins at $p=q=m$ and the identification of $\Lambda^2\otimes\Lambda^2$ as the smallest surviving one; the convex-combination bound and its sharpness; the $m\to n$ substitution; $\operatorname{sign}g'$, $w^*$ and $g(w^*)$ with $\rho$ carried; $\kappa/\rho_n=2n/(n-8)$; $w^*=2\sqrt n/(n-8)$ and $\sqrt{2(n-2)}/(n-8)$; the $\rho\to0$ order collapse; the monotonicity and supremum of $\rho_n$.

## Recommended repairs

1. **Delete the word "interior".** State $w^*=\tfrac{2\sqrt n}{n-8}$ (or $\tfrac{\sqrt{2(n-2)}}{n-8}$ with the record's $A$) and that it exceeds $1$ for $n\le14$, so the minimum on $[0,1]$ is $g(1)=\sqrt{c_p+\rho_n}/(A+B)$ there. **Cite [Lemma L158](../findings/second-order.md), which records the same failure for the unrepaired minimiser.**
2. **Keep $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ but label it a lower bound**, not the minimum, and give the attained values $0.072076$, $0.068204$, $0.063311$ at $n=10,12,14$ beside it.
3. **Restore $a_0$ and $1/g_n$**, or drop the words "in closed form". As written the constant is $9.4\%$ high at $n=12$, in the unsafe direction.
4. **Replace the ratios** $0.882$ and $0.978$ by the attained $0.901$ and $0.980$, or say explicitly that they compare two unattained infima.
5. **Correct the interval** to $\rho_n\in[0.45,\,3\sqrt2/2)$ and say that $\rho_n>0$ carries the *exponent*: at $m=4$ branch $2$ is $\Theta(n^{-3/2})$.
6. **Restrict the display to even $n=2m$, $m\ge5$**, and record that $\theta_0$ there is $\theta_0(n)$ and not its limit.
7. **Add the kink cross-reference**: $w^*>w_0=(n-4)/n$ at $n=10,12,14$ under every reading of $A$ on the record, so the minimum sits in [Lemma L158](../findings/second-order.md)'s saturated region and the closed form describes it at no dimension below $16$.

**What survives all of it.** The margin repair itself is correct and sharp, the ratio identity is exact, the order $\Theta(n^{-1})$ is untouched, and the repair does lower branch $2$ at $n=12$ and $n=14$, so [Lemma L149](../findings/second-order.md)'s stated conclusion, and [Lemma L158](../findings/second-order.md)'s that branch $2$ binds, both hold. *It is the closed-form constant and its minimiser that do not.*
