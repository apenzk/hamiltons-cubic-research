# r727, the real-to-complex extension of L148, read cold

**Cold brief.** Gate 2 on a derivation not yet on the record: [real-to-complex.md](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/real-to-complex.md), attacking the `HYPOTHESIS-DEBT` filed against [Lemma L148](../findings/second-order.md) and in [ROUND_L148-r2](../verification/ROUND_L148r2.md). **No computation was run**, the programme's [analysis-only rule](../.claude/rules/analysis-only.md) binds this review, and every number below is reproduced by hand from the record's own constants. Log: [agent_logs/r727.log](../agent_logs/r727.log).

| # | Claim | Verdict |
| --- | --- | --- |
| **C1** | Step 1, a real orthonormal basis of coordinate $2$-planes diagonalises $W^*$ and $H$ together, depends on $H$ alone, and makes $W(z)=W^*+zH$ diagonal with entries $\lambda_a+zh_a$ | **CONFIRMED** |
| **C2** | Step 2, the record's $W_-$ is the Riesz contour object, and for diagonal $W(z)$ it is diagonal in the same real basis | **CONFIRMED**, and the formula matches [second-order.md:1475](../findings/second-order.md) verbatim |
| **C3** | Step 3, $\mathrm{Alt}$ is $\mathbb C$-linear on the complexification and kills a coordinate-diagonal operator over $\mathbb C$ as over $\mathbb R$ | **CONFIRMED** |
| **C4** | The headline, $\mathrm{Alt}(W(z)_-)=0$ for admissible complex $z$ | **CONFIRMED**, on L156's *closed* disc and with the quantifier repaired; a second, independent route through the record's own $A$-decomposition confirms it |
| **C5** | *"the hypothesis this needs is exactly the one L156 already carries"* | **REFUTED AS STATED**, L156 carries six hypotheses and two objects, three of which L148 boasts of not needing |
| **C6** | *"the extension needs one imported hypothesis and no new object"* | **REFUTED**, $\Gamma$ is an object, and it is the object that *defines* the extended $W(z)_-$ |
| **C7** | *"Not on the record. Held for Gate 2."* | **REFUTED AS A NOVELTY CLAIM**, the argument is [VERIFY_v51.md:118](../verification/VERIFY_v51.md), and the sentence owed is written out at [:120](../verification/VERIFY_v51.md). Correct as a claim about what is *established* |
| **C8** | *"A Cauchy estimate of a function that is identically zero on the disc needs only the pointwise vanishing"* | **CONFIRMED IN CONCLUSION, REFUTED IN REASON**, closed-form counterexample below; what carries it is that the zero function has zero derivatives, and no Cauchy estimate is taken |
| **C9** | *"L148 was right to disclaim [analyticity]"* | **REFUTED as a reading of the chain**, L156's Neumann step *supplies* holomorphy on the disc, and the consumer needs it at every $w>0$ |
| **C10** | The claim's quantifier $\lvert z\rvert<\rho$ | **REFUTED AS STATED**, the consumer takes $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ on the circle the quantifier excludes; repaired by $\le$ |
| **C11** | *"which holds on $\lvert z\rvert\le\rho$ by the Neumann step"* (the two $\rho$'s | **REFUTED**), L156's $\rho$ has $\gamma^*=D/4$; [L146:1153](../findings/second-order.md) names the disc at $\gamma=1$, which L156's own domain excludes |
| **C12** | That the membership of the contour's interior is constant in $\arg z$ | **OWED**, true under $\gamma<d$, never argued, and the consumer's holomorphy fails without it |
| **C13** | The brief's own suggestion that $W(z)$ is not normal, so its spectral projection is oblique | **WITHDRAWN as an attack**, on $\Sigma$, $W(z)$ is diagonal in a *real* orthonormal basis, hence normal over $\mathbb C$ |
| **C14** | The record's two conventions for $W_-$ | **DISCREPANCY UPHELD, INERT HERE**, [route-a.md:229](../findings/route-a.md) declares $W_-\succeq0$, the contour object is $\preceq0$; the derivation copies the contour one faithfully |

**Summary in one line.** The mathematics of all three steps is correct and the headline stands on L156's closed disc, but it is not new, it is [VERIFY_v51](../verification/VERIFY_v51.md)'s own closure restated in three steps and uncited, and four of the write-up's supporting sentences fail, the load-bearing one being that its imported $\rho$ is not the $\rho$ its consumer integrates over.

## 0. Conventions, fixed once

**The base point and the direction.** $W^*=S^m\times S^m$, $n=2m$, $m\ge3$; $\Sigma$ the joint $\lambda_m$-eigenspace, *both* $S^2_0(\mathbb R^m)$ copies, of dimension $(m+2)(m-1)$; $H\in\Sigma$ with the diagonalising frame chosen after $H$; $W(z)=W^*+zH$.

**The spectrum.** $\operatorname{spec}W^*=\{\lambda_-,\lambda_+\}$ with $\lambda_-<0<\lambda_+$, $g_n:=\lvert\lambda_-\rvert=\operatorname{dist}(\operatorname{spec}W^*,0)$, and trace-freeness gives $\lambda_+m(m-1)+\lambda_-m^2=0$, hence $\lambda_+/\lvert\lambda_-\rvert=m/(m-1)$, [second-order.md:1475](../findings/second-order.md). The count in that identity fixes *which* planes carry which eigenvalue: there are $m(m-1)=2\binom m2$ coordinate $2$-planes inside a block and $m^2$ mixed ones, so $\lambda_+$ sits on the within-block planes and $\lambda_-$ on the mixed ones.

**The contour and the disc.** $\Gamma$ the circle of radius $\alpha g_n$ about $\lambda_-$; $D=\tfrac{2m-1}{m-1}=\lvert\lambda_+-\lambda_-\rvert/g_n$; $d=\min(\alpha,D-\alpha)$; $\rho=\gamma g_n/\lVert H\rVert_{op}$ on the domain $0<\alpha<D$, $0<\gamma<\min(d,1)$; optimum $\alpha^*=D/2$, $\gamma^*=D/4$, [L156](../findings/second-order.md).

**The negative part.** $W_-=-\tfrac1{2\pi i}\oint_\Gamma\zeta\,(W-\zeta)^{-1}\,d\zeta$, the contour enclosing the negative spectrum only, [second-order.md:1475](../findings/second-order.md).

**The defect.** $A(z)=\mathrm{Alt}(W(z)_-)$, and $\delta^2=\lVert A\rVert^2$, [route-a.md:229](../findings/route-a.md) writes $g(W):=\mathrm{Alt}(W_-)$. $\mathrm{Alt}(W^*_-)=0$ at the base point, [second-order.md:973](../findings/second-order.md), so $A(0)=0$ and $A$ is the increment as well as the value.

## 1. Step 1, CONFIRMED, and its $z$-independence is the whole of it

The derivation writes, at line 21: *"L148 gives a real orthonormal basis of Lambda^2 R^n, made of coordinate 2-planes, in which W\* and H are simultaneously diagonal. That basis does not depend on z."*

**This is right, and the reason is worth stating because the derivation does not.** The basis is chosen from $H$ alone: an orthonormal frame adapted to the splitting $\mathbb R^n=V_1\oplus V_2$ and diagonalising $h$ on $V_1$ and $k$ on $V_2$. $W^*$ is diagonal on the coordinate $2$-planes of *any* frame adapted to the splitting, by its $O(m)\times O(m)$-invariance; $H$ is diagonal on those of *this* frame. The parameter $z$ multiplies $H$ and moves no frame, so the same $\binom n2$ coordinate $2$-planes diagonalise $W(z)$ for every $z\in\mathbb C$, with $a$-th entry $\nu_a(z)=\lambda_a+zh_a$, where $\lambda_a\in\{\lambda_-,\lambda_+\}$ and $h_a\in\mathbb R$.

**One clause the derivation should add.** $A(z)$ is frame-independent, since $\mathrm{Alt}$ and $W\mapsto W_-$ are $O(n)$-equivariant and $\lVert\cdot\rVert$ is invariant, [L148](../findings/second-order.md)'s own scope box makes that the reason the frame may be chosen after $H$ at all. Without it, a reader may object that a $z$-dependent quantity is being computed in an $H$-dependent frame. The objection is answerable; it is not answered.

**And the derivation's own gloss at line 27 is stronger than it looks.** *"Diagonality is a statement about the basis, not about the field: no reality of the entries is used."* That is exactly right, and it is what makes C13 fail as an attack: see §5.

## 2. Step 2, CONFIRMED on the formula, REFUTED on the import

### 2.1 The formula matches the record

The derivation's line 32 writes $W(z)_-=-(1/2\pi i)\oint_\Gamma\zeta(W(z)-\zeta)^{-1}d\zeta$. [second-order.md:1475](../findings/second-order.md) writes $W_-=-\tfrac1{2\pi i}\oint_\Gamma\zeta\,(W-\zeta)^{-1}\,d\zeta$. **Character for character the same object.** The entry rule follows by residues: for diagonal $W(z)$ the resolvent is diagonal with entries $(\nu_a-\zeta)^{-1}$, and

$$\frac{-1}{2\pi i}\oint_\Gamma\frac{\zeta\,d\zeta}{\nu_a-\zeta}\;=\;\frac{1}{2\pi i}\oint_\Gamma\frac{\zeta\,d\zeta}{\zeta-\nu_a}\;=\;\begin{cases}\nu_a,&\nu_a\ \text{inside}\ \Gamma,\\0,&\text{outside},\end{cases}$$

the integrand having its only pole at $\zeta=\nu_a$ with residue $\nu_a$, and $\Gamma$ being a finite circle so that no behaviour at infinity enters. **The derivation's line 38 is therefore correct**, and it makes $W(z)_-$ diagonal in the same real basis for every complex $z$ at which $\Gamma$ misses the spectrum.

### 2.2 What the import actually is, C5 and C6 REFUTED

**Locate.** Lines 40–41: *"The hypothesis this needs is exactly the one L156 already carries: Gamma separates the spectrum of W(z)"*, and lines 54–58: *"the extension needs one imported hypothesis and no new object."*

**Exhibit.** [L156](../findings/second-order.md)'s statement carries, in its own first sentence: $m\ge2$; $\ker W^*=0$; $\operatorname{spec}W^*=\{\lambda_-,\lambda_+\}$, i.e. the balanced base point and no other; $\lVert H\rVert_{op}\le1$; $0<\alpha<D$; $0<\gamma<\min(d,1)$. It also introduces **two objects**, the contour $\Gamma$, a circle of radius $\alpha g_n$ about $\lambda_-$, and the disc radius $\rho=\gamma g_n/\lVert H\rVert_{op}$. Three of those hypotheses are ones [L148](../findings/second-order.md) advertises itself as *not* needing: its own line reads *"using no gap, no analyticity, no $\ker W^*=0$ and no smallness of $t$"*, and the record carries a named witness against the third, $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$ ([L147](../findings/second-order.md)'s hypotheses box).

**And $\Gamma$ is not a bookkeeping device: it is the definiens.** [L148](../findings/second-order.md)'s statement contains no contour. For real $t$, $W(t)_-$ has a contour-free meaning, $\tfrac12(\lvert W\rvert-W)$ up to the sign of §7. For complex $z$ the operator is not Hermitian and *"the negative part"* has no spectral-theoretic meaning at all; the only object in play is $\Gamma$-relative. So the extension does not extend L148's object to a larger domain, **it replaces the object by a $\Gamma$-indexed family and proves the vanishing for each member.**

**Argue the opposite.** One could answer that $\Gamma$ is not new *to the chain*, since [L147](../findings/second-order.md)'s $A$ is already the contour object, which is true. But then the imported object comes from L147, not from L148, and the extension is no longer a statement about L148's affine subspace $W^*+\Sigma$; it is a statement about the consumer's disc. Either reading kills the sentence: on the first, an object is imported and denied; on the second, the claim's stated subject is wrong. **Both C5 and C6 stand refuted.**

**The strengthening this concedes.** The proof never uses *which* entries $\Gamma$ selects. Every member of the $\Gamma$-indexed family is diagonal, so the vanishing is uniform in $\alpha$, a stronger statement than the derivation makes, and the correct way to state a claim about an object that only exists relative to a contour.

## 3. Step 3, CONFIRMED, with the constancy clause OWED (C12)

### 3.1 The algebra over $\mathbb C$

$\mathrm{Alt}$ is defined by an index symmetrisation with rational coefficients: on a curvature-type tensor $R$, its $\Lambda^4$ components are $\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ over four *distinct* indices ([VERIFY_v51.md:71](../verification/VERIFY_v51.md) states it in these terms). A map given by a fixed rational-coefficient index formula extends to the complexification $\mathbb C$-linearly and is uniquely determined by its real restriction. **So C3's linearity clause is correct and needs no argument beyond naming the coefficients.**

A coordinate-diagonal operator $R$ has $R_{ijkl}=0$ whenever $\{i,j\}\ne\{k,l\}$, and four distinct indices force $\{i,j\}\ne\{k,l\}$ in each of the three terms. Complex entries change nothing: the vanishing entries are vanishing over any field. **$\mathrm{Alt}(W(z)_-)=0$.**

### 3.2 What diagonality with complex entries means, and the clause that is missing

The brief's question is the right one. Writing $z=re^{i\theta}$, the $a$-th entry traces a circle,

$$\nu_a(z)=\lambda_a+r h_a e^{i\theta},\qquad \lvert\nu_a(z)-\lambda_a\rvert=r\lvert h_a\rvert,$$

and the derivation's own selection clause (*"if that eigenvalue lies inside Gamma, 0 otherwise"*), is on its face a function of $\theta$. **The derivation never argues that it is not.**

Under L156's domain it is not: $r\lvert h_a\rvert\le\rho\lVert H\rVert_{op}=\gamma g_n<d\,g_n$, and $\operatorname{dist}(\lambda_-,\Gamma)=\alpha g_n$ while $\operatorname{dist}(\lambda_+,\Gamma)=(D-\alpha)g_n$, so $\operatorname{dist}(\lambda_a,\Gamma)\ge d\,g_n>r\lvert h_a\rvert$ for both $a$-types and no entry can reach $\Gamma$. **The membership pattern is therefore constant on the closed disc, and equals the pattern at $z=0$.**

**Why the omission is not cosmetic.** For the headline it is harmless, any selection of diagonal entries is diagonal, so $\mathrm{Alt}=0$ either way, and this is the derivation's real robustness. But at a membership jump $W(z)_-$ is *discontinuous*, jumping by $\nu_aP_a$, and the consumer's Cauchy estimate needs $z\mapsto A(z)$ holomorphic. The derivation cites $\gamma<d$ for a different purpose (finiteness of the resolvent) and never spends it on constancy. **One clause, owed.**

## 4. The disclaimer, C8 and C9

**Locate.** Lines 62–64: *"the claim is that the vanishing holds pointwise at each admissible complex z, not that W(z)\_- is analytic in z. A Cauchy estimate of a function that is identically zero on the disc needs only the pointwise vanishing."*

**Exhibit, in closed form.** Cauchy's inequality $\lVert A''(0)\rVert\le 2M/\rho^2$, with $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$, which is [L147](../findings/second-order.md)'s form at [:1173](../findings/second-order.md), and [:1265](../findings/second-order.md)'s $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$, is a theorem about *holomorphic* functions and is false without that hypothesis. Take

$$f(z)=\lvert z\rvert^2-\rho^2 \quad\text{on } \overline{D(0,\rho)}.$$

Then $M=\sup_{\lvert z\rvert=\rho}\lvert f\rvert=0$, while $\partial_x^2f\equiv2$. **So $M=0$ alone gives nothing**, and *"a Cauchy estimate … needs only the pointwise vanishing"* is false as a general principle.

**Argue the opposite.** Under the charitable reading (the derivation wrote *"identically zero on the disc"*, not on the circle), the conclusion is correct: if $A\equiv0$ on an open set then every derivative of $A$ on that set is $0$, in any sense of derivative. **The conclusion survives; the reason does not.** What carries $\lVert A''\rVert=0$ at $w=0$ is that the zero function has zero derivatives, and *no Cauchy estimate is taken at all*, the derivation's closing sentence, *"the Cauchy estimate L147 takes is legitimate"*, describes an instrument the argument has just made unnecessary. **C8: confirmed in conclusion, refuted in reason.**

**C9, and it is the sharper half.** *"Analyticity of anything, which L148 was right to disclaim"* misreads what the chain needs. L148 was right that *its own* proof needs no analyticity, it is an algebraic identity on a real affine subspace. But [L156](../findings/second-order.md)'s Neumann step *supplies* holomorphy of $z\mapsto(W(z)-\zeta)^{-1}$ on the disc, uniformly in $\zeta\in\Gamma$, hence of $z\mapsto W(z)_-$ and of $A$; and the chain needs that holomorphy at every direction with $w>0$, where $A\not\equiv0$ and the Cauchy estimate is doing real work. **Presenting the absence of analyticity as a virtue inverts the chain's actual dependency**, and (see §6), it discards the shorter of the two closures already on file.

## 5. The non-normality objection, WITHDRAWN (C13)

The brief proposes that $W(z)$ is complex symmetric and not normal, so its spectral projection is oblique rather than orthogonal, and *"the negative part"* is not the right object. **I tested this and it fails on this family.**

In the basis of §1, $W(z)$ is a *diagonal* matrix with respect to a **real** orthonormal basis. A complex diagonal matrix $\Delta$ satisfies $\Delta\Delta^*=\Delta^*\Delta$ entrywise, so $W(z)$ is normal for every $z\in\mathbb C$, its Riesz projections are the orthogonal coordinate projections $P_a$, and no obliqueness arises. **The objection is withdrawn.**

**What survives of it, and it is the scope warning the derivation should carry.** For $H\notin\Sigma$, the mixed directions, which [L148](../findings/second-order.md)'s own closing box names as *"where the question lives"*, $W(z)$ is complex symmetric and generically non-normal, the Riesz projection is oblique, $\lVert\Pi(z)\rVert>1$, and none of steps 1–3 has an analogue. The extension is exactly as narrow as L148 and buys the chain nothing at $w>0$.

## 6. The record already carries the argument, C7 REFUTED as a novelty claim

**Locate.** Line 3: *"**Not on the record.** Held for Gate 2."* And lines 52–58, *"What this uses that L148 does not state."*

**Exhibit.** [VERIFY_v51.md:118](../verification/VERIFY_v51.md), filed 2026-09-05 in the very round that recorded the debt, states both closures and the second is this derivation:

> *"Or extend the entry's own argument: $W(z)=W^*+zH$ is diagonal in the same frame for complex $z$, its entries being affine in $z$, and the contour integral of a diagonal matrix is diagonal, so $A(z)=0$ on the whole disc without any analyticity."*

And [:120](../verification/VERIFY_v51.md) writes out the sentence owed, with the L156 import already in it: *"for $H\in H_s$ and every complex $z$ in the disc of Lemma L156, $W(z)$ is diagonal in the frame diagonalising $(h,k)$, hence so is its Riesz negative part, hence $A(z)=0$ and $M=\lVert A''\rVert=0$."* **Steps 1, 2 and 3 are that sentence expanded.** [ROUND_L148-r2:56](../verification/ROUND_L148r2.md) carries the pointer in its own words (*"v51 notes two one-line closures exist"*) so the closure is reachable from the round the derivation cites in its opening paragraph.

**Argue the opposite, and it partly succeeds.** The record's standing policy is that a derivation arriving inside a check is *not* established: [ROUND_L62:166](../verification/ROUND_L62.md), *"A verifier that supplies a missing argument hands the record fresh mathematics under the letterhead of a check"*, and [ATTEMPTS.md:4445](../ATTEMPTS.md) says the same. So *"not on the record"* is true in the sense of *not established*, and putting the closure through Gate 2 is the correct process, not a duplication of effort. **The claim that fails is the implicit one**: that the mathematics is the derivation's. It is v51's, uncited, and the second closure v51 names, the identity theorem, one line, and *stronger*, since it delivers the holomorphy §3.2 and §4 show the chain needs, is discarded in the derivation's closing paragraph as something L148 was right not to want.

**Why this is the finding the record most needs recorded.** [second-order.md:1394](../findings/second-order.md) carries the block's own verdict on this failure mode in capitals, *"THE NOVELTY SCREEN FAILED, FOR THE THIRD TIME IN A DAY AND ON A SENTENCE THE RECORD HAD ALREADY CORRECTED THREE TIMES"*, and [:1265](../findings/second-order.md) records the same thing as *"a search by vocabulary rather than by object"*. This derivation searched neither: the string *real-to-complex* appears in [ROUND_L148r2.md](../verification/ROUND_L148r2.md) and [VERIFY_v51.md](../verification/VERIFY_v51.md) and nowhere else on the record, and one grep reaches both.

## 7. The two $\rho$'s, C10 and C11, the load-bearing finding

### 7.1 The quantifier excludes the circle the consumer measures on (C10)

**Locate.** Line 15 states the claim *"for every complex z with |z| < rho"*; line 41 justifies it *"on |z| <= rho"*; the consumer at [second-order.md:1173](../findings/second-order.md) takes $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$, a supremum **on the boundary circle**, which the claim's own quantifier excludes.

**Exhibit.** The claim as written says nothing at any point of $\{\lvert z\rvert=\rho\}$, so it does not by itself set $M$ to zero, which is the single quantity L147 consumes.

**Argue the opposite.** $\gamma<d$ is strict, so $\lVert zH\rVert_{op}\le\gamma g_n<d\,g_n$ holds *at* $\lvert z\rvert=\rho$ as well, the Neumann step covers the closed disc, and the repair is one character. **Upheld as a defect of statement, trivially repaired**, but a claim written to discharge a debt must reach the object the debt is about, and this one stops one circle short of it.

### 7.2 The imported $\rho$ is not the consumer's $\rho$ (C11)

**Locate.** Line 41: *"which holds on |z| <= rho by the Neumann step"*, one $\rho$, silently.

**Exhibit, three radii, all called $\rho$, on the record:**

| Where | The disc | In L156's $\gamma$ |
| --- | --- | --- |
| [L156:1432](../findings/second-order.md) | $\rho=\gamma g_n/\lVert H\rVert_{op}$, $0<\gamma<\min(d,1)$, optimum $\gamma^*=D/4$ | $\gamma^*=\tfrac12+\tfrac1{4(m-1)}$, i.e. $0.55$ at $n=12$ |
| [L146:1153](../findings/second-order.md) | *"the analyticity disc $g_n/\lVert H\rVert_{op}$"* | $\gamma=1$, **the excluded endpoint** |
| [L145's table, :1115](../findings/second-order.md) | *"the complex radius must be $\rho<g_n/2$, not $\rho=g_n/2$"* | $\gamma<\tfrac12$ at $\lVert H\rVert_{op}=1$ |

At the optimum $\alpha^*=D/2$ we have $d=D/2=1+\tfrac1{2(m-1)}>1$, so $\min(d,1)=1$ and **the binding constraint on $\gamma$ is $\gamma<1$**, whose stated reason in L156 is that it *"keeps the perturbed negative cluster off $0$"*. L146's named disc sits exactly on that boundary. In radius the two differ by $1/\gamma^*=\tfrac{20}{11}=1.818$ at $n=12$, hence by $3.31$ in the $\rho^2$ of the Cauchy denominator.

**And on the larger disc the integrand stops being the defect.** For diagonal $W(z)$ the negative cluster reaches $0$ at
$$\lvert z\rvert \;=\; \min_{a:\ \lambda_a=\lambda_-}\frac{g_n}{\lvert h_a\rvert}\;=\;\frac{g_n}{\max\{\lvert h_a\rvert:\ \lambda_a=\lambda_-\}}\;\ge\;\frac{g_n}{\lVert H\rVert_{op}},$$
**with equality exactly when $\lVert H\rVert_{op}$ is attained on one of the $m^2$ mixed $2$-planes**, the ones carrying $\lambda_-$, by the count in §0. For such an $H$ the crossing sits precisely on L146's circle: at that $z$ an entry of the enclosed cluster is $0$, and just outside it is positive while still enclosed, since $\lvert\nu_a-\lambda_-\rvert\approx g_n<\alpha^*g_n$. **The record's own defining requirement at [:1475](../findings/second-order.md) ($\Gamma$ *"enclosing the negative spectrum only"*) then fails**, and the contour object is no longer any negative part. That is what L156's $\gamma<1$ exists to forbid, and the display above shows the constraint is sharp for exactly this class of directions.

**Argue the opposite, and it is the honest half.** For the derivation's *headline* this is inert: whatever $\Gamma$ encloses, the selected entries are diagonal and $\mathrm{Alt}$ kills them, so $\mathrm{Alt}(W(z)_-)=0$ survives on any disc on which the resolvent exists. The damage is to the identification of $A$ with the defect, i.e. to the consumer. So the finding is not that the vanishing is false anywhere, **it is that line 41's single $\rho$ conceals a factor $1.818$ and a change of object, and the claim is true only on the smaller disc while the debt was booked against the larger one.** The repair is to name L156's $\rho$ explicitly and to let L147's disc shrink to it.

## 8. The confirmation the derivation did not take, and one it did not need

**A second, independent route to C4, through the record's own decomposition.** [second-order.md:1471](../findings/second-order.md) records $A=\mathrm{Alt}\big(-\Pi(z)(W(z)-W^*)-(\Pi(z)-\Pi(0))W^*\big)$. For $H\in\Sigma$ every factor is diagonal in the basis of §1: $\Pi(z)$ is a $0/1$ coordinate projection, $W(z)-W^*=zH$ is diagonal, $W^*$ is diagonal, and products of diagonals are diagonal. **So both summands are coordinate-diagonal and $\mathrm{Alt}$ kills each separately**, the vanishing holds term by term in the decomposition the chain actually uses, not only for the assembled object. This is a stronger statement than the derivation makes and it costs one line.

**And the shorter closure remains available.** $A$ is holomorphic on L156's disc by the Neumann step; it vanishes on the real diameter by [L148](../findings/second-order.md); the real diameter has a limit point in the disc; so $A\equiv0$ by the identity theorem. **One line, and it delivers the holomorphy the consumer needs at $w>0$ as a by-product.** The derivation's closing paragraph rejects this route on the ground that L148 disclaimed analyticity, but L148 disclaimed *needing* it, not *having* it, and L156 supplies it independently.

## 9. The sign, which is the record's and not the derivation's (C14)

**Locate.** [route-a.md:229](../findings/route-a.md) fixes the convention in capitals: *"$W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$"*, and records that the opposite sign, once carried, *"refute[d] three lemmas downstream"*. [second-order.md:1475](../findings/second-order.md) defines $W_-$ by the contour, and the derivation copies it.

**Exhibit.** By §2.1's residue, the contour object is $\sum_{\lambda_a<0}\lambda_aP_a=-\tfrac12(\lvert W\rvert-W)\preceq0$, **the negative of the declared convention.** The derivation's own entry rule at line 38, *"$(\lambda_a+zh_a)$ if that eigenvalue lies inside Gamma"*, confirms it uses the $\preceq0$ object.

**Argue the opposite.** A global sign is inert for $\mathrm{Alt}(\cdot)=0$, for $\lVert\cdot\rVert$, for $\delta^2$ and for the $1$-Lipschitz estimate, so no number on the record moves. **Upheld as an inherited inconsistency between two files, inert for this claim, and not chargeable to the derivation**, which reproduces its source faithfully. It is recorded here because the record's own box says this is the sign that once cost three lemmas.

## 10. What I would write into L148, if the debt is to be discharged

> **The extension to complex $z$.** *Fix $H\in\Sigma$ and the frame chosen after it, and take $\Gamma$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$ as in [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour), on its domain $0<\alpha<D$, $0<\gamma<\min(d,1)$. On the **closed** disc $\lvert z\rvert\le\rho$ the Neumann step gives $\lVert zH\rVert_{op}\le\gamma g_n<d\,g_n\le\operatorname{dist}(\operatorname{spec}W^*,\Gamma)$, so no eigenvalue of the diagonal $W(z)$ meets $\Gamma$ and the membership pattern is the one at $z=0$. Hence $W(z)_-=\sum_{\lambda_a=\lambda_-}(\lambda_a+zh_a)P_a$ is coordinate-diagonal, $\mathrm{Alt}$ has no four-distinct-index component to act on, and $A(z)=0$ on the closed disc, so $M=0$ and $\lVert A''\rVert=0$ by differentiation of the zero function rather than by a Cauchy estimate. The vanishing is uniform in $\alpha$ and holds term by term in [:1471](../findings/second-order.md#lemma-l152-refuted-as-stated-the-numerator-identity-holds-the-constant-it-was-built-into-has-no-range-and-the-disagreement-it-claimed-to-resolve-was-never-one)'s decomposition of $A$. The argument is [VERIFY_v51.md](../verification/VERIFY_v51.md)'s second closure, put through Gate 2 here; the first, the identity theorem on the holomorphy L156's Neumann step supplies, is shorter and additionally delivers the analyticity the chain needs at $w>0$. **It imports L156's $\ker W^*=0$, its balanced base point and its $\lVert H\rVert_{op}\le1$, none of which the real statement needs, and it holds on L156's disc and not on [L146:1153](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects)'s $\gamma=1$ disc, where the enclosed cluster can reach $0$ and $\Gamma$ ceases to enclose the negative spectrum only.**

## 11. Candidates examined and withdrawn

- **"Step 2 is wrong because a spectral projection of a non-normal operator is oblique."** *Withdrawn*, §5. Diagonal in a real orthonormal basis is normal over $\mathbb C$.
- **"The membership can flip with $\arg z$, so $W(z)_-$ jumps and the claim is false somewhere on the disc."** *Withdrawn as a falsifier, recorded as the owed clause C12*, §3.2. It cannot flip under $\gamma<d$, and even if it did the object stays diagonal.
- **"The claim is vacuous because its hypothesis 'such that $\Gamma$ separates' may hold nowhere off the real axis."** *Withdrawn*, the Neumann step gives separation on the whole closed disc, so the hypothesis is satisfied identically there and the quantifier is redundant rather than empty.
- **"$\mathrm{Alt}$ is only $\mathbb R$-linear, so the complexification step fails."** *Withdrawn*, §3.1. A fixed rational-coefficient index formula extends $\mathbb C$-linearly and uniquely.
- **"$\Sigma$ is empty or $\lVert H\rVert_{op}\le1$ is unsatisfiable there."** *Withdrawn*, $\dim\Sigma=(m+2)(m-1)$ and $\lVert H\rVert_{op}\le1$ is a normalisation, [L146:1153](../findings/second-order.md) giving $\lVert H\rVert_{op}=O(n^{-1/2})$ on the summand at unit Frobenius norm.
- **"The extension does not repair the chain, so it is worthless."** *Withdrawn as a charge against this derivation, recorded as scope*, §5. It discharges a debt at $w=0$, which is what it was asked to do; that the live question is at $w>0$ is L148's own observation and not a defect here.
