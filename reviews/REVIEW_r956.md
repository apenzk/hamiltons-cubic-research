# Review r956, Gate 2 on Lemma L229 ($G(2)$ at fixed total norm on the common-eigenvector stratum)

Reviewer **r956**, working [BRIEF_L229.md](BRIEF_L229.md) independently of r955. Log: `agent_logs/r956-L229.log`.

**Verdict convention.** CONFIRMED means the conclusion stands and the written justification establishes it. PLAUSIBLE means the conclusion stands and the written justification does not establish it, so a step is owed. REFUTED means the claim as written is wrong.

**Headline: the mathematics survives. Every number, coefficient, sign and closed form in items 1 to 4 is exact, and step 5's topology is sound.** Four steps are asserted rather than argued, and one Gate 1 clause misdescribes what the cited scripts do.

| # | Item | Verdict |
|---|---|---|
| 1 | Item 1's identity, and the conversion of $K_1,K_2,K_{12}$ to $\Lambda,\rho_1,\rho_2$ | CONFIRMED |
| 2 | $\Lambda>0$ and the normalisation $d_A,d_C,v_2>0$ | PLAUSIBLE |
| 3 | Item 2's annulus and the distance formula | CONFIRMED |
| 4 | Item 3's "exactly when $1\notin\operatorname{int}\mathcal A$" | CONFIRMED |
| 5 | Item 4's coefficients and the norm segment | CONFIRMED |
| 6 | Step 5's topology | PLAUSIBLE |
| 7 | The quantifier in the conclusion | PLAUSIBLE |
| 8 | Gate 1, clause (a), against the scripts | REFUTED |
| 9 | Gate 1, clause (c), "to $0$" | CONFIRMED |
| 10 | The Lean file | CONFIRMED |
| 11 | Scope | CONFIRMED |
| 12 | Against the record | CONFIRMED |

## 1. Item 1's identity, and the conversion from batch 11. CONFIRMED

**All three couplings convert exactly, the sign of $K_{12}$ included.** Batch 11 has $g=K_1\cos\vartheta_1+K_2\cos\vartheta_2+K_{12}\cos(\vartheta_1-\vartheta_2)$ with $K_1=2pd_A$, $K_2=2rd_C$, $K_{12}=-2\beta pv_2r$. Substituting $\Lambda=d_Ad_C/(\beta v_2)$, $\rho_1=\beta v_2r/d_A$, $\rho_2=\beta v_2p/d_C$:

- $2\Lambda\rho_2=2\cdot\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta v_2p}{d_C}=2pd_A=K_1$, and it multiplies $\cos\vartheta_1$ in both. Correct.
- $2\Lambda\rho_1=2\cdot\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta v_2r}{d_A}=2rd_C=K_2$. Correct.
- $-2\Lambda\rho_1\rho_2=-2\cdot\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta v_2r}{d_A}\cdot\frac{\beta v_2p}{d_C}=-2\beta pv_2r=K_{12}$. **Correct including the sign**, which is the check the brief singles out. Note that $\rho_1$ carries $r$ and pairs with $\cos\vartheta_2$ while $\rho_2$ carries $p$ and pairs with $\cos\vartheta_1$, a crossing that is easy to misread and is right in both the block and the Lean file.

**The expansion.** With $w=\rho_2e^{i\vartheta_1}+\rho_1e^{i\vartheta_2}$, $\lvert1-w\rvert^2=1-2\operatorname{Re}w+\lvert w\rvert^2$, where $\operatorname{Re}w=\rho_2\cos\vartheta_1+\rho_1\cos\vartheta_2$ and $\lvert w\rvert^2=\rho_1^2+\rho_2^2+2\rho_1\rho_2\cos(\vartheta_1-\vartheta_2)$. The cross term is $\cos(\vartheta_1-\vartheta_2)$ and not $\cos(\vartheta_1+\vartheta_2)$, because it comes from $2\operatorname{Re}\big(\rho_2e^{i\vartheta_1}\overline{\rho_1e^{i\vartheta_2}}\big)$, a product with a conjugate. Multiplying by $\Lambda$ gives $\Lambda(1+\rho_1^2+\rho_2^2)-g$ exactly. The block's own one-line reason, the addition formula for $\cos(\vartheta_1-\vartheta_2)$, is a correct route to the same place.

## 2. $\Lambda>0$ and the normalisation. PLAUSIBLE

**The inequality is safe and the block reaches it by a route it does not justify.**

**$\Lambda>0$ needs no normalisation at all.** $\Lambda=\frac{d_Ad_C}{\beta v_2}$ and $\beta>0$, so $\Lambda>0\iff d_Ad_C/v_2>0\iff d_Ad_Cv_2>0$, multiplying by $v_2^2>0$. The right side is exactly batch 11's frustration condition $K_1K_2K_{12}<0$, which is the standing case assumption of the whole block. **So $\Lambda>0$ is equivalent to the case being treated, and the block should say that instead of leaning on a sign normalisation.**

**The normalisation itself is legitimate, by two symmetries the record does not write down.** The block says only "By the symmetries of the stratum take $d_A,d_C,v_2>0$", citing batch 11, and batch 11 contains no such symmetry. What it contains is the flip $v_2\mapsto-v_2$, which batch 12 is explicit **changes** the value by $-2\tilde cv_2$, so it is a move and not a symmetry. The two that do work:

- **Relabel $e_1$ and $e_3$**, relabelling $A$ and $C$ with them. This is an isometry of the configuration space carrying the problem with data $(A,C)$ to the problem with the permuted data, preserving $\Phi$, both norms and the set of pairs diagonal in $F$, and sending $(d_A,d_C)\mapsto(-d_A,-d_C)$ with $u_2,v_2,p,r$ fixed. So $d_A>0$ is free.
- **Send $V\mapsto-V$ and $C\mapsto-C$ together.** Then $\operatorname{tr}(\hat UV^2)$ and $\operatorname{tr}(\hat UA)$ are untouched, $\operatorname{tr}\big((-V)(-C)\big)=\operatorname{tr}(VC)$, both norms are untouched, and diagonal pairs go to diagonal pairs. In the parametrisation it reads $v_2\mapsto-v_2$, $r\mapsto r$, $\vartheta_2\mapsto\vartheta_2+\pi$, and on the data $(d_C,v_2)\mapsto(-d_C,-v_2)$.

With $d_A>0$ fixed by the first, frustration leaves $d_Cv_2>0$, which is the two cases $d_C,v_2>0$ and $d_C,v_2<0$, and the second symmetry carries the second to the first. **The normalisation therefore holds, and neither symmetry appears anywhere in the block, in batch 11, or in batch 13**, which asserts the same normalisation in the same words.

**The degenerate cases fall outside the written chain and are covered elsewhere.** At $v_2=0$ all three of $\Lambda,\rho_1,\rho_2$ are undefined, and at $d_A=0$ or $d_C=0$ one of $\rho_1,\rho_2$ is. In each of those $K_1K_2K_{12}=0$, so the problem is unfrustrated and batch 11's bound $g\le\lvert K_1\rvert+\lvert K_2\rvert+\lvert K_{12}\rvert$ applies with equality at $\vartheta_1,\vartheta_2\in\{0,\pi\}$, which is a diagonal pair. The conclusion holds there. **The gap is that the Statement paragraph asserts the conclusion for the whole stratum while the Setting quietly narrows to the frustrated case, and the proof never returns to say that batch 11 closes the rest.** One clause in step 5 would fix it.

## 3. Item 2's annulus and the distance formula. CONFIRMED

**The sum set is the closed annulus in every case, degenerate ones included.** For $\rho_1,\rho_2\ge0$ the triangle inequality gives $\big\lvert\rho_1-\rho_2\big\rvert\le\lvert w\rvert\le\rho_1+\rho_2$, and every modulus in that range is attained by fixing $\vartheta_1$ and turning $\vartheta_2$, the modulus being continuous. The three degenerate cases:

| case | sum set | $\mathcal A$ as written | agree |
|---|---|---|---|
| $\rho_1=0$ | circle of radius $\rho_2$ | $\{\rho_2\le\lvert z\rvert\le\rho_2\}$, that circle | yes |
| $\rho_1=\rho_2>0$ | closed disc of radius $2\rho_1$ | $\{0\le\lvert z\rvert\le2\rho_1\}$, that disc | yes |
| $\rho_1=\rho_2=0$ | $\{0\}$ | $\{0\le\lvert z\rvert\le0\}=\{0\}$ | yes |

**The distance formula is right in all of them.** $\operatorname{dist}(1,\mathcal A)=\max(0,1-\rho_1-\rho_2,\lvert\rho_1-\rho_2\rvert-1)$ splits into three regimes, and in each the other two arguments of the max are non-positive: if $1>\rho_1+\rho_2$ then $\lvert\rho_1-\rho_2\rvert-1\le\rho_1+\rho_2-1<0$, and if $1<\lvert\rho_1-\rho_2\rvert$ then $1-\rho_1-\rho_2\le1-\lvert\rho_1-\rho_2\rvert<0$, and inside both are non-positive. At $\rho_1=0$ it returns $\lvert1-\rho_2\rvert$, the distance to a circle, and at $\rho_1=\rho_2=0$ it returns $1$. **Item 2's conclusion also needs $\Lambda>0$ to turn "maximise $g$" into "minimise the distance", which item 2 does not restate, and which item 2's own sentence "by item 1" carries only implicitly.** The minimum is attained because $\mathcal A$ is closed.

## 4. Item 3's "exactly when $1\notin\operatorname{int}\mathcal A$". CONFIRMED, both directions

**The nearest point formula is right.** $\mathcal A$ is rotation invariant about $0$ and $1$ is real positive, so the nearest point is the real number $\min\big(\rho_1+\rho_2,\max(1,\lvert\rho_1-\rho_2\rvert)\big)$: it returns $1$ when $\lvert\rho_1-\rho_2\rvert\le1\le\rho_1+\rho_2$, returns $\rho_1+\rho_2$ when $1>\rho_1+\rho_2$, and returns $\lvert\rho_1-\rho_2\rvert$ when $1<\lvert\rho_1-\rho_2\rvert$.

**Forward direction.** If $1\notin\operatorname{int}\mathcal A$ then either $1\ge\rho_1+\rho_2$, where $\operatorname{dist}(1,\mathcal A)=1-\rho_1-\rho_2$ and among the four points $\lvert1-\lvert\rho_1-\rho_2\rvert\rvert=1-\lvert\rho_1-\rho_2\rvert\ge1-\rho_1-\rho_2$, so the minimum over the four is $1-\rho_1-\rho_2$ too, or $1\le\lvert\rho_1-\rho_2\rvert$, where $\operatorname{dist}(1,\mathcal A)=\lvert\rho_1-\rho_2\rvert-1$ and $\lvert1-(\rho_1+\rho_2)\rvert=\rho_1+\rho_2-1\ge\lvert\rho_1-\rho_2\rvert-1$, so again the minimum over the four agrees. The two boundary cases give $0$ on both sides.

**Reverse direction, and the brief's question about equality in the interior.** If $1\in\operatorname{int}\mathcal A$ then $\lvert\rho_1-\rho_2\rvert<1<\rho_1+\rho_2$ with **both inequalities strict**, so $\operatorname{dist}(1,\mathcal A)=0$ while $\min\big(\lvert1-\rho_1-\rho_2\rvert,\lvert1-\lvert\rho_1-\rho_2\rvert\rvert\big)>0$. **The distance to the four points is strictly larger at every interior point, never equal**, so with $\Lambda>0$ the two values differ throughout the interior and the "exactly when" is an equivalence, not an implication. The case $\rho_1=\rho_2$ does not break it: there $\operatorname{int}\mathcal A$ is the open disc including $0$, and $1\in\operatorname{int}\mathcal A$ still forces $0=\lvert\rho_1-\rho_2\rvert<1$ strictly.

**One elision.** The written argument never says that the four points $\pm\rho_1\pm\rho_2$ all lie in $\mathcal A$, which is what gives $\operatorname{dist}(1,\{\pm\rho_1\pm\rho_2\})\ge\operatorname{dist}(1,\mathcal A)$ and turns "the nearest point of $\mathcal A$ is one of the four" into equality of the two distances. It is true, each of the four has modulus $\rho_1+\rho_2$ or $\lvert\rho_1-\rho_2\rvert$, and it is one clause.

## 5. Item 4's coefficients and the norm segment. CONFIRMED, every term

- $\Lambda\rho_2^2=\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta^2v_2^2p^2}{d_C^2}=\frac{\beta v_2d_A}{d_C}x$. Correct.
- $\Lambda\rho_1^2=\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta^2v_2^2r^2}{d_A^2}=\frac{\beta v_2d_C}{d_A}y$. Correct.
- Batch 11's cubic part $\alpha\big(\tfrac34u_2^3-3u_2p^2\big)$ gives the constant $\tfrac34\alpha u_2^3$ and the coefficient $-3\alpha u_2$ on $x$. Correct.
- Batch 11's $\beta\big(u_2v_2^2-u_2(\tfrac{v_2^2}4+r^2)\big)=\tfrac34\beta u_2v_2^2-\beta u_2y$ gives the constant $\tfrac34\beta u_2v_2^2$ and the coefficient $-\beta u_2$ on $y$. Correct.
- The field terms $A_2u_2-\tfrac{u_2}2(A_1+A_3)=\tilde au_2$ and $C_2v_2-\tfrac{v_2}2(C_1+C_3)=\tilde cv_2$, matching the definitions of $\tilde a$ and $\tilde c$ in the Setting. Correct.
- The cap's constant term is $\Lambda=\frac{d_Ad_C}{\beta v_2}$, which is the last summand of the bracket. Correct.

**The norm and the asymmetric weights.** $\lvert\hat U\rvert^2=\tfrac32u_2^2+2x$ and $\lvert V\rvert^2=\tfrac32v_2^2+2y$ from batch 11, so $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2=\tfrac94u_2^2+3x+\tfrac34v_2^2+y=T$. **The $3$ on $x$ against the $1$ on $y$ is right**, it is $\tfrac32\cdot2$ against $\tfrac12\cdot2$, and $B=T-\tfrac94u_2^2-\tfrac34v_2^2$ follows. I also checked the parametrisation itself is consistent: $\hat U$ has eigenvalues $u_2,-\tfrac{u_2}2\pm p$, which is traceless and has $\lvert\hat U\rvert^2=\tfrac32u_2^2+2p^2$.

## 6. Step 5's topology. PLAUSIBLE, the crux implication is asserted

**Everything in the step is true and every edge case the brief names works out. One implication, the one the argument turns on, is stated without its reason.**

**What holds.** $\rho_1=\beta v_2\sqrt y/d_A$ and $\rho_2=\beta v_2\sqrt x/d_C$ are continuous on $I$ because $\sqrt{\cdot}$ is continuous on $[0,\infty)$, and $E=\{\lvert\rho_1-\rho_2\rvert\le1\le\rho_1+\rho_2\}$ is cut out by two weak inequalities, so $E$ is closed in $I$. $I$ is a compact interval, so $E$ is compact, and a connected component of a closed subset of $\mathbb R$ is a closed connected set, that is a closed bounded interval, possibly a single point. An affine function on a closed interval attains its maximum at an endpoint. On $E$ the free value is $c_0+c_1x+c_2y$ because $\operatorname{dist}(1,\mathcal A)=0$ there, so item 4's affineness applies exactly on $E$ and nowhere wider.

**The asserted implication.** "Such an endpoint is either an endpoint of $I$ ... or a boundary point of $E$ in $I$, where $1\in\partial\mathcal A$" needs a line the block does not give: **if $s\in E$ is an endpoint of its component and not an endpoint of $I$, then $1\notin\operatorname{int}\mathcal A(s)$.** Proof: suppose $1\in\operatorname{int}\mathcal A(s)$, so $\lvert\rho_1-\rho_2\rvert<1<\rho_1+\rho_2$ strictly at $s$. Both sides are continuous on $I$, so both strict inequalities persist on an $I$-neighbourhood of $s$, so that whole neighbourhood lies in $E$ and $s$ is interior to its component, contradiction. **This is the whole mechanism of the step and it is the one sentence missing.**

**The edge cases.**

| case | what happens | outside $E^\circ$ |
|---|---|---|
| $E$ empty | $E^\circ$ empty, all of $I$ handled by the first half of step 5 | yes |
| $E$ a single point $s$ | its component is $\{s\}$, so $s$ is an endpoint of its component, and the line above applies | yes |
| $E=I$ | the one component is $I$, its endpoints are the vertices of $I$ | yes |
| $B=0$ | $I=\{(0,0)\}$, $\rho_1=\rho_2=0$, $\mathcal A=\{0\}$, $1\notin\mathcal A$, so $E=\varnothing$ | yes |
| value constant on a component | the maximum is attained at an endpoint as well as everywhere else, and the conclusion is an inequality, so equality suffices | yes |

**The vertices of $I$.** At $(0,B)$ we have $x=0$ so $\rho_2=0$, and at $(B/3,0)$ we have $y=0$ so $\rho_1=0$. In both $\mathcal A$ is a circle, whose interior in $\mathbb C$ is empty, so $1\notin\operatorname{int}\mathcal A$. The block's phrase "$\rho_1\rho_2=0$" is right.

**A notation trap worth fixing.** $E^\circ$ is defined as $\{1\in\operatorname{int}\mathcal A\}$ and is not in general the interior of $E$ in $I$. The inclusion $E^\circ\subseteq\operatorname{int}_IE$ holds because the defining conditions are open, and the reverse can fail. Nothing in the proof needs the reverse, so this is a reader hazard rather than a defect.

## 7. The quantifier in the conclusion. PLAUSIBLE, attainment is owed one line

**The two claims are different, and the proof produces the weaker one.** The proof gives, for each configuration, a diagonal configuration of at least the same value, at the same $T$, $u_2$ and $v_2$. That establishes $\sup_{\text{stratum}}\Phi=\sup_{\text{diagonal points}}\Phi$, an equality of suprema. The Statement says the supremum "is attained with $\hat U$ and $V$ both diagonal in $F$", which asserts that a maximiser exists and that one of them is diagonal.

**The stronger claim is true and its proof is short, and it is nowhere in the block.** The stratum with shared eigenvector $e_2$ is $\{\hat Ue_2\in\mathbb Re_2,\ Ve_2\in\mathbb Re_2\}$, a closed linear condition, and intersecting it with $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2=T$ gives a compact set. $\Phi$ is a polynomial, so it attains its maximum there, at some $z^\ast$. Step 5 supplies a diagonal $w$ with $\Phi(w)\ge\Phi(z^\ast)=\sup$, and $\Phi(w)\le\sup$ forces equality, so $w$ is a diagonal maximiser. **Add the compactness sentence and the Statement is earned. Without it the block proves an equality of suprema and claims attainment.**

## 8. Gate 1, clause (a), against the scripts. REFUTED on two counts

**The brief's warning lands. The clause misdescribes both of its halves, and the arithmetic it reports is real.**

**First half.** The clause says batch 11's reduction "was screened against the trusted block value to $10^{-14}$" in [screen_I106_G2_commonaxis.py](../scripts/misc/screen_I106_G2_commonaxis.py). What that script does is build $U$ and $V$ as explicit $3\times3$ numpy arrays and compute $\alpha\operatorname{tr}U^3+\beta\operatorname{tr}(UV^2)+\operatorname{tr}(UA)+\operatorname{tr}(VC)$ from them, comparing that against batch 11's formula in $(u_2,p,\varphi,v_2,r,\chi)$. **It imports numpy and nothing else**, so it never touches the trusted operator. Compare the Gate 1 clause of L228 four paragraphs above in [second-order.md](../findings/second-order.md), which names "the trusted $Q$ of [curvature_operator.py](../scripts/lib/curvature_operator.py)" and "L226's block norm" explicitly. **The check is a check of batch 11's algebra against the definition of $\Phi$ given in the Setting, which is a real and useful check, and it is not a check against the trusted block value.** The link from $\Phi$ back to the trusted operator sits in L226 and [screen_I106.py](../scripts/misc/screen_I106.py), which this clause does not cite.

**Second half, the more substantive one.** The clause says "items 1 to 4 are checked against that reduced formula, formula to formula". In [screen_I106_annulus.py](../scripts/misc/screen_I106_annulus.py), `check_identity` and `check_closed_form` draw $\rho_1,\rho_2,\Lambda$ directly at random and set $a=2\Lambda\rho_2$, $b=2\Lambda\rho_1$, $c=2\Lambda\rho_1\rho_2$. **They therefore assume the conversion from $K_1,K_2,K_{12}$ rather than check it.** Batch 11's constants $2pd_A$, $2rd_C$, $-2\beta pv_2r$ appear nowhere in that script. So items 1, 2 and 3 are checked against $g$ already written in the $(\Lambda,\rho_1,\rho_2)$ coordinates, not against batch 11's reduced formula. **Item 4 alone earns the description**, because `value` does build batch 11's phase-free part $S$ from $\alpha,\beta,u_2,v_2,p,r,\tilde a,\tilde c$.

**Consequence, and why it is a wording defect rather than an error.** The single unscreened link, the conversion of the three couplings, is precisely what item 1 of this review verifies by hand, and all three convert exactly. No script on the record screens it: [screen_I106_G2_remaining.py](../scripts/misc/screen_I106_G2_remaining.py) works in the $K$ variables throughout and never forms $\Lambda,\rho_1,\rho_2$. **Suggested replacement**: "Batch 11's reduction of the two-block value and both norms to $(u_2,p,\varphi,v_2,r,\chi)$ was screened against $\Phi$ evaluated on explicitly built $3\times3$ blocks to $10^{-14}$ (screen_I106_G2_commonaxis.py). Items 1 to 3 are checked in the scale-free coordinates and item 4 against batch 11's phase-free part, formula to formula (screen_I106_annulus.py), the conversion of $K_1,K_2,K_{12}$ into $\Lambda,\rho_1,\rho_2$ being done by hand."

**Two smaller notes on the same clause.** The residual $9\cdot10^{-5}$ is called "that grid's resolution", and the resolution is $2\pi/1440=4.4\cdot10^{-3}$. The residual is consistent with the $O(h^2)$ deficit of sampling a smooth maximum on a grid of that spacing, which is the right explanation, so the number is benign and the phrase is loose. The reported figures otherwise correspond to the script's five printed quantities.

## 9. Gate 1, clause (c), "to $0$". CONFIRMED as the theorem's prediction

**It is the theorem, not a self-comparison, and the exactness has a mechanical cause.** In `check_affine_and_closure`, `free` and `diag` are maxima of two genuinely different functions over the same grid on the segment, differing by `annulus_dist` against `collinear_dist`. Those two agree exactly outside $\operatorname{int}\mathcal A$ and differ strictly inside it. Since `annulus_dist` $\le$ `collinear_dist` pointwise, `free` $\ge$ `diag` always, so the reported maximum gap is a one-sided quantity that could only have come out positive. **The exact $0$ arises because the argmax lands at a grid point where $1\notin\operatorname{int}\mathcal A$, and there the two code paths evaluate the identical floating-point expression**, so the difference is bitwise zero rather than small.

**Screen I ran to decide this, reported as a screen and not as evidence.** A six-case cut of the same comparison, with the strictly-interior grid points counted:

```
gap=+0.000e+00  strict_interior_pts=2005/4001
gap=+0.000e+00  strict_interior_pts= 276/4001
gap=+0.000e+00  strict_interior_pts=2352/4001
gap=+0.000e+00  strict_interior_pts=   0/4001
gap=+0.000e+00  strict_interior_pts= 445/4001
gap=+0.000e+00  strict_interior_pts=   0/4001
```

In four of the six the two functions differ on a large part of the segment, and in every one the two argmaxes coincide at the same grid index with both distances equal there. **So the comparison had somewhere to fail and did not.** The clause's own gloss, "the maximiser landing where the two formulas agree", is the correct reading, and the clause correctly labels itself a screen of a derived conclusion.

## 10. The Lean file. CONFIRMED, with the sorry correctly isolated

**Axioms, from `#print axioms` run against a build of [L229Statement.lean](../lean/HamiltonsCubic/Results/L229Statement.lean).** The six proved declarations, `phase_deficit`, `phase_le_cap`, `collinear_eq_phaseSum`, `collinear_deficit`, `cap_attained_of_boundary` and `capValue_affine`, each depend on `propext, Classical.choice, Quot.sound` and nothing else. `diagonal_matches` adds `sorryAx` and is the only declaration that does. **The prose's "All proved on standard axioms" is accurate, and the single `sorry` is where the prose says it is.**

**Each declaration states what the prose attributes to it.** `phase_deficit` writes the squared modulus as $(1-\rho_2\cos\vartheta_1-\rho_1\cos\vartheta_2)^2+(\rho_2\sin\vartheta_1+\rho_1\sin\vartheta_2)^2$, which is $\lvert1-w\rvert^2$ with the sign of the imaginary part squared away correctly. `phase_le_cap` asks only `0 ≤ l`, matching the prose's use of $\Lambda>0$. `collinear_deficit` carries $e_1^2=e_2^2=1$, which is what makes the deficit an exact square. `cap_attained_of_boundary` hypothesises $\rho_1+\rho_2=1$ or $\rho_1-\rho_2=\pm1$, which is exactly $1\in\partial\mathcal A$. `capValue_affine` reproduces item 4 term for term, with $\rho_1=bv_2\sqrt y/d_A$ and $\rho_2=bv_2\sqrt x/d_C$, the same crossing of $x$ with $d_C$ and $y$ with $d_A$ as the prose.

**`diagonal_matches` is a faithful typing of step 5, neither weaker nor vacuous.** It says: for every $(x,y)$ on $3x+y=B$ with $x,y\ge0$ there are $(x',y')$ on the same segment with the free value at $(x,y)$, the affine part less $l\cdot\mathrm{annulusDist}^2$, at most the diagonal value at $(x',y')$, the affine part less $l\cdot\mathrm{collinearDist}^2$. That is step 5's conclusion in item 4's coordinates. It quantifies $c_0,c_1,c_2$ over all reals, which is faithful rather than over-strong, because step 5's argument uses only that the value is affine and never the values of the coefficients. `annulusDist` and `collinearDist` match the prose's two distances, both symmetric in their arguments, so no argument-order hazard. The passage back to blocks diagonal in $F$ is outside the file, which [lean/INDEX.md](../lean/INDEX.md) states.

**Non-vacuity, exhibited.** I type-checked three `example`s against the built file, all compiling with exit code $0$:

- `capValue_affine (15/4) (9/4) 0 1 1 1 0 0 1 1` with all six side conditions by `norm_num`, that is $\alpha=\tfrac{15}4$, $\beta=\tfrac94$, $u_2=0$, $v_2=1$, $d_A=d_C=1$, $\tilde a=\tilde c=0$, $x=y=1$.
- `cap_attained_of_boundary 3 (1/2) (1/2) (Or.inl ...)`, that is $\Lambda=3$ and $\rho_1=\rho_2=\tfrac12$ on the outer circle.
- `diagonal_matches 0 1 1 1 1 1 1 1 ... 0 1 ...`, that is $B=1$ at the vertex $(x,y)=(0,1)$.

**So none of the three has unsatisfiable hypotheses**, and in particular `capValue_affine`'s four non-vanishing conditions and `diagonal_matches`' five positivity conditions are jointly realisable.

## 11. Scope. CONFIRMED, with one cosmetic defect

**Nothing in the block claims more than the common-eigenvector stratum, and nothing suggests $G(2)$ or the $\lvert J\rvert=3$ step of R27 is closed.**

| place | reading | verdict |
|---|---|---|
| "What it gives" in [second-order.md](../findings/second-order.md) | names the stratum, and lists as Open both the no-shared-eigenvector stratum and the induction from $G(2)$ to $G(m)$ | scoped |
| [results.md](../results.md) glance entry | "the supremum is attained with both blocks diagonal in $F$ whenever they share an eigenvector of $F$", marked *Gate 2 in flight* | scoped |
| [findings/INDEX-results.md](../findings/INDEX-results.md) row | "Closes the stratum carrying F68's witness", stratum named throughout | scoped |
| [lean/INDEX.md](../lean/INDEX.md) row | **partial**, names the `sorry` and the two untyped bridges as owed | scoped |
| [plan.md](../plan.md) I106 row | L229 under Done with "Gate 2 in flight", the other stratum and the induction under Open | scoped |

**The one defect is cosmetic.** The INDEX-results.md row ends "Closes the stratum carrying [F68](INDEX-traps.md)'s witness. the common-eigenvector stratum", a stray trailing fragment left from editing. It should be deleted.

**A scope point that belongs with item 2 rather than here.** The Statement asserts the conclusion for the stratum while the Setting narrows to the frustrated sign case. The unfrustrated case is genuinely closed by batch 11, so the scope of the claim is right, and the proof does not say where the rest of the stratum went.

## 12. Against the record. CONFIRMED, with two corrections

**Item 2 does reproduce batch 12's closed form in all three regimes.** With $a=2\Lambda\rho_2$, $b=2\Lambda\rho_1$, $c=2\Lambda\rho_1\rho_2$:

- *Interior.* $\tfrac12\big(\frac{ab}c+\frac{bc}a+\frac{ca}b\big)=\tfrac12\big(2\Lambda+2\Lambda\rho_1^2+2\Lambda\rho_2^2\big)=\Lambda(1+\rho_1^2+\rho_2^2)$, which is item 2 at $\operatorname{dist}=0$.
- *Outside the outer circle,* $1>\rho_1+\rho_2$. Item 2 gives $\Lambda\big[1+\rho_1^2+\rho_2^2-(1-\rho_1-\rho_2)^2\big]=2\Lambda(\rho_1+\rho_2-\rho_1\rho_2)=a+b-c$, and there $\rho_1,\rho_2<1$ makes $c$ the smallest of the three, so $a+b+c-2\min=a+b-c$. Agree.
- *Inside the hole,* $1<\rho_1-\rho_2$ say. Item 2 gives $\Lambda\big[1+\rho_1^2+\rho_2^2-(\rho_1-\rho_2-1)^2\big]=2\Lambda(\rho_1\rho_2+\rho_1-\rho_2)=b+c-a$, and there $\rho_1>1+\rho_2>1$ makes $a$ the smallest, so $a+b+c-2\min=b+c-a$. Agree.

**Correction one, to Gate 1 clause (b).** The clause says "the triangle condition is $1\in\mathcal A$". Batch 12's condition is $\lvert a-c\rvert<ac/b<a+c$, which in the scale-free variables reads $\lvert1-\rho_1\rvert<\rho_2<1+\rho_1$, that is $\lvert\rho_1-\rho_2\rvert<1<\rho_1+\rho_2$ with **both inequalities strict**. So the triangle condition is $1\in\operatorname{int}\mathcal A$, and batch 13 states it that way, "$\rho_1+\rho_2>1$ with $\lvert\rho_1-\rho_2\rvert<1$". The difference is harmless, because on $\partial\mathcal A$ the two branches of the closed form agree, and the clause should still read $1\in\operatorname{int}\mathcal A$.

**Correction two, to the provenance line.** The block says it supersedes batch 12 and removes what batch 13 left owed. **Batch 13 already carries $\Lambda$, $\rho_1$, $\rho_2$ and the interior value $\frac{d_Ad_C}{s}(1+\rho_1^2+\rho_2^2)$**, so what batch 14 and this lemma add is the identity of item 1, the unification of batch 12's three cases as one distance to one annulus, and the affineness that closes the stratum. The scale-free variables and the interior closed form are batch 13's and the provenance line does not say so.

**No earlier result carries item 1's identity or item 2's closed form under another name.** Searching the record by the objects rather than by this block's vocabulary, for "annulus", "two circles", "sum of two" and "squared distance" across [findings/](../findings/), [reviews/](.), [results.md](../results.md), [routes.md](../routes.md) and [lean/INDEX.md](../lean/INDEX.md), returns nothing relevant. The hits are unrelated senses: a spectral annulus in [REVIEW_r728.md](REVIEW_r728.md) and [REVIEW_r441.md](REVIEW_r441.md), the two circles of diagonal configurations in [fence-posts.md](../findings/fence-posts.md)'s F68 and [BRIEF_F68.md](BRIEF_F68.md), and many "sum of two PSD operators". The only other occurrences of this identity are batch 14 of [the derivation](2026-09-15-I106-m3-derivation.md) and the Lean file, both of which are this same result.

## The four steps owed, in order of weight

1. **The compactness sentence** that turns equality of suprema into attainment, item 7.
2. **The continuity line** giving that an endpoint of a component of $E$ interior to $I$ has $1\notin\operatorname{int}\mathcal A$, item 6, which is the mechanism of step 5.
3. **The two symmetries** behind "take $d_A,d_C,v_2>0$", and the observation that $\Lambda>0$ is just frustration and needs no normalisation, item 2. A clause saying batch 11 closes the unfrustrated remainder, including $v_2=0$ and $d_A d_C=0$.
4. **Gate 1 clause (a) rewritten** to say what the two scripts do, item 8, and clause (b) corrected to $1\in\operatorname{int}\mathcal A$, item 12.

None of the four changes a number, a sign or the conclusion.
