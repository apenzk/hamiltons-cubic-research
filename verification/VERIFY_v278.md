# Verifier v278, Lemma L3: local maximality of the balanced product at even n at least 8, its transverse constant, the n = 6 remark, and the Lean file

Cold brief ([verification/BRIEF_L03.md](BRIEF_L03.md)). No numerical work, every value exact, no scripts, no Lean build. Every quotation in the brief was checked against its cited lines only and matches verbatim. Log: [agent_logs/verify-L03-v278.log](../agent_logs/verify-L03-v278.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $W^*$ is a critical point with $\theta=P(W^*)>0$, the hypothesis under which L24 is applied | HYPOTHESIS-DEBT |
| 2 | The Riemannian Hessian at $W^*$ is negative definite on the normal space to the orbit and zero along the orbit, every even $n\ge8$ | CONFIRMED (given claim 1) |
| 3 | Hence $W^*$ is a local maximum of $P$ on the unit sphere of $\mathcal W_n$, strictly so transverse to its orbit | GAP |
| 4 | Transverse Hessian $\le-6\theta/(n-2)$ | CONFIRMED AS ALGEBRA (unwritten in the proof) |
| 5 | "Not merely within $\mathcal D_n$" | CONFIRMED |
| 6 | $n=6$: the statement is false, nine transverse null directions carry $P$ upward at cubic order | HYPOTHESIS-DEBT |
| 7 | "$n\ge12$ is about which of two local maxima wins globally" | HYPOTHESIS-DEBT |
| 8 | "The Schur mechanism that derives the analogous statement at the $\mathbb{CP}^2$-type competitor is what derives this one" | HYPOTHESIS-DEBT |
| 9 | [L3.lean](../lean/HamiltonsCubic/Results/L3.lean) states or proves L3 | REFUTED AS STATED (the file types scope arithmetic and a one-variable cubic fact, CONFIRMED AS ALGEBRA, and states no part of L3) |

**Summary.** The spectral half is right and the constant $-6\theta/(n-2)$ is exact and sharp, but the proof stops at the Hessian: the passage from "negative definite transverse, zero along the orbit" to "local maximum" is asserted, the sign $\theta>0$ that turns L27's spectrum into negative definiteness is used without a source, and the three surrounding remarks (the $n=6$ ascent, a second local maximum, the Schur/$\mathbb{CP}^2$ analogy) carry no argument in the passages.

**Overall verdict: GAP.**

## 0. Conventions, fixed once

- $S$ is the unit sphere of $\mathcal W_n$, $T=T_{W^*}S=W^{*\perp}$, $T_O\subset T$ the tangent space of the orbit $O=O(n)\cdot W^*$, and $N=T\cap T_O^\perp$ the normal space. "Transverse" means on $N$.
- $m=n/2$, so $W^*=W_{m,m}$ and L27 is applied at $p=q=m$.
- $\mathrm{Hess}$ is the Riemannian Hessian of $P|_S$ at $W^*$, a quadratic form on $T$. By L24 (Passage C) it is $6\theta(L_e-\tfrac12\mathrm{Id})$.
- In Passage D, "$\lambda_m$ on $S^2_0(\mathbb R^m)$" is read with $m\in\{p,q\}$, one value on $S^2_0(\mathbb R^p)$ and one on $S^2_0(\mathbb R^q)$. This is the only reading under which the summand is $O(p)\times O(q)$-irreducible, as L27 states every summand is, and under which the ten summands are ten. It matters: the constant of claim 4 depends on it (section 4).
- The ten L27 values at $(p,q)$: $1$ on $\langle W\rangle$; $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ (the orbit tangent); $\lambda_p$, $\lambda_q$ on $S^2_0(\mathbb R^p)$, $S^2_0(\mathbb R^q)$; $+\mu$ on $\Lambda^2\otimes\Lambda^2$; $-\mu$ on $S^2_0\otimes S^2_0$; $0$ on the remaining four.

## Hypothesis inventory

| Hypothesis | Source | Used by the argument? | Holds at $W^*$? | Satisfiable? |
|---|---|---|---|---|
| $n$ even, $n\ge8$ | L3 statement | Yes, to define $W^*=W_{n/2,n/2}$ and enter L27's scope | By assumption | Yes, $n=8$ |
| $W$ critical, $Q(W)=\theta W$ | L24 | Yes, the Hessian formula is stated at a critical point | Implicit in L27's given (eigenvalue $1$ on $\langle W\rangle$ with $e=W/\theta$ means $Q(W)=\theta W$, and D line 512 differentiates $Q(W_t)=\theta W_t$). Not stated in Passage A | Yes |
| $\theta=P(W)>0$ | L24 | **Yes, load-bearing**: $6\theta(L_e-\tfrac12)$ is negative definite on $N$ only if $\theta>0$ | $\theta\ne0$ is implicit in L27 ($e=W/\theta$ is defined). **The sign is on file nowhere in Passages A to D** | Yes: of $\pm W^*$, exactly one has $P>0$ (section 1) |
| "local maximiser" | L24's second clause | **No**. L3 uses only the Hessian formula, which L24 states at any critical point with $\theta>0$. No circularity | Not needed | n/a |
| $p,q\ge3$, $(p,q)\ne(3,3)$ | L27 | Yes | $p=q=m\ge4$ | Yes |
| $n=p+q$ (no padding) | L27 | Yes | $m+m=n$ | Yes |
| $O(n)$ acts orthogonally, $P$ invariant | Definitions | Yes, implicitly, for $T_O\subset T$ and for the orbit consisting of critical points at level $\theta$ | Yes | Yes |
| **Unstated**: a second-order sufficiency result modulo a group orbit (Morse–Bott lemma, or a slice argument) | Nowhere | **Yes**: it is the step from Hessian to local maximum | Its hypotheses are those of claim 2 | It is a standard true result |
| **Unstated**: $\theta(W^*)>0$ under the record's sign convention for $W^*$ and $Q$ | Nowhere in the passages | Yes | Unverified here | See row 3 |

## 1. Claim 1: $W^*$ critical with $\theta>0$

**Derivation.** Passage A's proof applies L24 at $W^*$ and then L27. L24's statement opens "Let $W$ be a critical point with $\theta=P(W)>0$". Passage A never checks either condition. Criticality and $\theta\ne0$ are carried by L27's given, which is stated about $L_e$ with $e=W/\theta$ and puts the eigenvalue $1$ on $\langle W\rangle$, that is $e\circ W=Q(W)/\theta=W$. The sign of $\theta$ is carried by nothing quoted.

**Candidate: the sign $\theta>0$ is used and not established.**

1. *Location.* Passage A, "so at $p=q=n/2\ge4$ the Hessian is negative definite transverse to the orbit". The step from "$\lambda<\tfrac12$ on $N$" to "negative definite" multiplies by $6\theta$.
2. *Failure exhibited.* $P$ is a cubic form, so $P(-W)=-P(W)$ and $Q(-W)=Q(W)$. Hence $-W^*$ is critical with multiplier $-\theta$, and $e(-W^*)=(-W^*)/(-\theta)=e(W^*)$, so $L_e$, its ten eigenvalues and the orbit tangent are identical at $W^*$ and $-W^*$. Also $-W^*\notin O$, since $P$ is constant on $O$ and $P(-W^*)=-\theta\ne\theta$. Every check the proof performs passes equally at $-W^*$, where $\mathrm{Hess}=-6\theta(L_e-\tfrac12\mathrm{Id})$ is positive definite on $N$ whenever it is negative definite at $W^*$. So the chain as written cannot tell a local maximum from a local minimum, and the sign of $P(W^*)$ is what decides.
3. *Charitable reading.* $W^*$ is a named geometric object, so the sign of $P(W^*)$ is a fact about it, and the "Needed because" line refers to a known diagonal-case proof, which presumably fixes it. That reading makes the lemma true for whichever of $\pm W^*$ has $P>0$ (satisfiability is certain, by step 2). It does not put the sign on file: the proof cites no source for it, and the diagonal-case result is neither quoted nor cited in the proof.

**Survives. HYPOTHESIS-DEBT.** What would have to be proved or cited: $Q(W^*)=\theta W^*$ with $\theta=P(W^*)>0$ under the record's normalisation of $W^*=S^{n/2}\times S^{n/2}$ and of $Q=W^2+W^\#$. Low severity: the fix is a citation or a sign convention, and the statement is then correct for the representative with $P>0$.

## 2. Claim 2: the Hessian is negative definite on $N$ and zero on $T_O$

**Derivation.** L27's hypotheses hold at $p=q=m\ge4$ with $n=p+q$. L27 gives $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ with $E(\tfrac12)$ equal to the orbit tangent, $\dim E(\tfrac12)=pq=\dim O$. Since $O(n)$ acts orthogonally, $O\subset S$ and $T_O\subset T=W^{*\perp}$. L24 (given, with claim 1) gives $\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})$ on $T$. L24 also records that $W^\perp$ is $L_e$-invariant and $L_e$ self-adjoint, so $T$ splits orthogonally into $L_e$-eigenspaces, and $N$ is the sum of those with eigenvalue below $\tfrac12$. Hence $\mathrm{Hess}|_{T_O}=0$ and $\mathrm{Hess}|_N<0$ when $\theta>0$.

**No finding** beyond the sign debt of section 1. The use of "attained exactly on the orbit tangent" matches L27's statement (Passage D line 496-498) word for word.

## 3. Claim 3: local maximum on $S$, strictly transverse to the orbit

**Derivation as written.** Passage A's proof ends "the Hessian is negative definite transverse to the orbit and zero along it. $\square$". The statement's conclusion is "a local maximum of $P$ on the unit sphere". Passage B's landscape line says "strictly so transverse to its orbit, by Lemmas L24 and L27". Neither passage contains, names or cites the inference from the second-order data to local maximality.

**Candidate: second-order sufficiency modulo the orbit is asserted, not argued (attack item 1).**

1. *Location.* The final sentence of Passage A's proof, quoted above, and Passage B "by Lemmas L24 and L27".
2. *Failure exhibited.* A Hessian that vanishes on a subspace decides nothing at second order along that subspace. The record's own Lean file makes exactly this point with $x^3$ ([L3.lean](../lean/HamiltonsCubic/Results/L3.lean) lines 16-19). Here $\mathrm{Hess}$ vanishes on the $pq$-dimensional $T_O$, so second-order information alone does not bound $P$ near $W^*$. What closes it is the extra fact that $T_O$ is tangent to a manifold of critical points at the same level ($P$ is constant on $O$), combined with a sufficiency theorem for such a critical manifold: the Morse–Bott lemma for a nondegenerate critical submanifold, or a slice argument for the $O(n)$-action. That theorem is the step, and it is absent.
3. *Charitable reading.* The step is standard and true: an $O(n)$-orbit of critical points at level $\theta$ whose normal Hessian is negative definite is a local maximum set, with $P<\theta$ at nearby points off the orbit. L27's given even ends "Morse–Bott nondegenerate", which a reader can take as the pointer. So the statement is not in danger and no counterexample exists. But the proof neither writes the step nor cites the theorem, and it is precisely the necessary-versus-sufficient step the lemma exists to take.

**Survives. GAP**, closable by citation. What would have to be supplied: a sufficiency theorem modulo a group orbit, with its hypotheses checked at $W^*$ (a Lie group acting smoothly and isometrically on $S$, the orbit consisting of critical points at level $\theta$, $\ker\mathrm{Hess}=T_O$, $\mathrm{Hess}|_N<0$). The last two are claim 2.

## 4. Claim 4: transverse Hessian $\le-6\theta/(n-2)$

**Derivation from Passage D's values at $p=q=m$.** On $N$ the eigenvalues of $\mathrm{Hess}$ are $6\theta(\lambda-\tfrac12)$ for $\lambda$ in $\{\lambda_m,\ \mu,\ -\mu,\ 0\}$, each summand nonzero at $m\ge4$.

- $\tfrac12-\lambda_m=\tfrac12-\frac{m-2}{2(m-1)}=\frac{1}{2(m-1)}$.
- From Passage D, $\tfrac12-\mu=\frac{(m-2)^2-1}{2(m-1)^2}=\frac{(m-3)(m-1)}{2(m-1)^2}=\frac{m-3}{2(m-1)}$, so $\mu=\frac{1}{m-1}>0$.
- $\tfrac12-(-\mu)=\tfrac12+\frac1{m-1}$ and $\tfrac12-0=\tfrac12$.

The smallest gap is $\min\big(\frac1{2(m-1)},\frac{m-3}{2(m-1)}\big)$, since $\tfrac12\ge\frac1{2(m-1)}$ for $m\ge2$ and $\tfrac12+\frac1{m-1}$ is larger still. The two candidates **tie exactly when $m-3=1$, that is $n=8$**, where $\lambda_4=\mu=\tfrac13$ and both gaps are $\tfrac16$. For $m\ge5$ the $S^2_0$ gap $\frac1{2(m-1)}$ is strictly smaller. In every case the smallest gap is $\frac1{2(m-1)}$, so

$$\mathrm{Hess}|_N\ \le\ -6\theta\cdot\frac1{2(m-1)}\ =\ -\frac{3\theta}{m-1}\ =\ -\frac{6\theta}{n-2},$$

with equality on $S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)$, and at $n=8$ also on $\Lambda^2\otimes\Lambda^2$. At $n=8$ the bound is $-\theta$, at $n=10$ it is $-\tfrac34\theta$. The non-strict $\le$ is correct and sharp.

**Candidate: the constant is not derived in the proof.**

1. *Location.* Statement of Passage A, "with transverse Hessian $\le-6\theta/(n-2)$". The proof mentions no constant, and Passage B omits it.
2. *Failure exhibited.* The proof's text yields "negative definite" and nothing quantitative. The constant needs $\lambda_m$, $\mu$ and the tie comparison above, none of which appears in Passage A.
3. *Charitable reading.* Every input is a value stated in the given L27 (Passage D), and the computation is four lines of exact arithmetic, so a reader with L27 in hand recovers it. The reading also depends on the convention $m\in\{p,q\}$ of section 0: with $m=n$ the gap would be $\frac1{2(n-1)}$ and the bound $-3\theta/(n-1)$, which is weaker than $-6\theta/(n-2)$ for $n\ge 3$, and the stated constant would be false. Under the only reading consistent with L27's irreducibility claim the constant holds.

**CONFIRMED AS ALGEBRA**, from the given values. The candidate survives as a written-proof defect only: the statement carries a constant the proof does not derive. Folded into the overall GAP.

## 5. Claim 5: "not merely within $\mathcal D_n$" (attack item 5)

L27's ten summands decompose all of $\mathcal W_n$ ($1$ on $\langle W\rangle$ is one of the ten), and L24's Hessian is on the tangent space of the sphere of all of $\mathrm{Weyl}_n$. So claim 2 covers every direction in $T$, diagonal or not, and the conclusion of claim 3 (subject to its GAP) is about a full neighbourhood in $S$. Restriction to $\mathcal D_n$ is then automatic.

Screen, not evidence: at $n=8$, $\dim\mathcal W_8=\tfrac{8\cdot9\cdot10\cdot5}{12}=300$, and the named summands give $1+16+9+9+36+81=152$, leaving $148$ for the four zero summands, consistent with two copies of $\mathcal W_4$ ($10$ each) and two of a $64$-dimensional mixed summand. Nothing turns on this.

**No finding.**

## 6. Claim 6: $n=6$ (attack item 6)

**What is on file.** L27's given (Passage D line 496) states that at $(3,3)$ "$\mu=\tfrac12$ giving $\dim E(\tfrac12)=18$ against an orbit of $9$". Consistently, $\tfrac12-\mu=\frac{1\cdot1-1}{2\cdot2\cdot2}=0$ at $p=q=3$. Since $E(\tfrac12)\subset W^\perp$, this yields exactly nine Hessian null directions transverse to the orbit, the summand $\Lambda^2\mathbb R^3\otimes\Lambda^2\mathbb R^3$ of dimension $3\cdot3=9$. That part of Passage B is supported by the given.

**Candidate: "carry $P$ upward at cubic order" and "the statement is false" have no argument.**

1. *Location.* Passage B line 114, "**At $n=6$ the statement is false**, that is L27's excluded $(3,3)$, where nine Hessian null directions transverse to the orbit carry $P$ upward at cubic order", and line 404, "**At $n=6$ it is false**, that being the case Lemma L27 excludes."
2. *Failure exhibited.* Exclusion from L27 establishes only that the Hessian is degenerate on $N$, which leaves local maximality undecided at second order. Falsity needs an ascent. For a unit $X\in N$ with $\mathrm{Hess}(X,X)=0$, the great circle $\gamma(t)=\cos t\,W+\sin t\,X$ gives, exactly, $P(\gamma(t))=\theta\cos t\,(1+\tfrac12\sin^2t)+P(X)\sin^3t$ (using $\langle Q(W),X\rangle=0$ and $\langle W\circ X,X\rangle=\theta\langle L_eX,X\rangle=\theta/2$), so "upward at cubic order" is the assertion that $P(X)\ne0$ for some $X$ in the nine-dimensional null summand. Nothing in the passages evaluates $P$ there or shows it is not identically zero. A nonzero value is not forced by symmetry either: on $\Lambda^2\mathbb R^3\otimes\Lambda^2\mathbb R^3\cong\mathbb R^{3\times3}$ the stabiliser $O(3)\times O(3)$ acts by $M\mapsto\det g\,\det h\,gMh^{\mathsf T}$, which admits the cubic invariant $\det M$, so $P$ restricted there is some multiple $c\det M$, and $c=0$ is not excluded by anything quoted.
3. *Charitable reading.* The remark may summarise a computation elsewhere in the record. None is cited in either passage, and the Lean file's $x^3$ example (claim 9) illustrates insufficiency of a semidefinite Hessian, not an ascent at $W_{3,3}$. The lemma does not use the $n=6$ remark: its statement is for even $n\ge8$.

**Survives. HYPOTHESIS-DEBT.** What would have to be proved: some $X$ in the transverse null space at $W_{3,3}$ with $P(X)\ne0$ (equivalently $c\ne0$ above), or, failing that, an ascent at higher order. Until then "at $n=6$ the statement is false" should read "at $n=6$ the argument does not apply".

## 7. Claim 7: "$n\ge12$ is about which of two local maxima wins globally" (attack item 7)

**Candidate: a second local maximum is named with no argument.**

1. *Location.* Passage A line 49 and Passage B line 404, "So $n\ge12$ is about which of two local maxima wins globally, not about $W^*$ losing local maximality."
2. *Failure exhibited.* L3 supplies one local maximum family, $W^*$ at even $n$. The sentence asserts a second local maximum at $n\ge12$ and that the global maximum is one of the two. Neither passage identifies the second object, proves it a local maximum, or proves the global maximum lies in the two-element set. The sentence also ranges over odd $n\ge13$, where $W^*$ is undefined and L3 says nothing.
3. *Charitable reading.* The second object is presumably the $\mathbb{CP}^2$-type competitor of Passage B, whose local maximality the record may prove elsewhere, and "$n\ge12$" means even $n$. The half that L3 does support is "not about $W^*$ losing local maximality" at even $n\ge12$, subject to claims 1 and 3. The rest is not on file here, and the lemma does not use it.

**Survives. HYPOTHESIS-DEBT** on the second local maximum and on "wins globally". Commentary only, not load-bearing.

## 8. Claim 8: the Schur-mechanism remark (attack item 8)

**Candidate: the analogy is asserted without content.**

1. *Location.* Passage B line 114, "*The Schur mechanism that derives the analogous statement at the $\mathbb{CP}^2$-type competitor is what derives this one.*"
2. *Failure exhibited.* The half about "this one" is consistent with the given: L27 states the ten summands are irreducible with distinct Young labels, so $L_e$ is scalar on each, which is Schur's lemma, and Passage A rests on L27. The half about the $\mathbb{CP}^2$-type competitor has no statement, object or argument in either passage, so "derives the analogous statement" cannot be checked.
3. *Charitable reading.* A cross-reference to a result elsewhere. It is uncited and not used by L3.

**Survives, as to the $\mathbb{CP}^2$ half only. HYPOTHESIS-DEBT**: a statement and proof of local maximality at the $\mathbb{CP}^2$-type competitor by the same multiplicity-free decomposition would have to be on file. The "this one" half: no finding.

## 9. Claim 9: the Lean file (attack item 9, standing item 5)

Read in full ([L3.lean](../lean/HamiltonsCubic/Results/L3.lean)), not built. Scope definitions confirmed from [L126.lean:62](../lean/HamiltonsCubic/Results/L126.lean#L62) and [L126.lean:65](../lean/HamiltonsCubic/Results/L126.lean#L65): L27scope $p\,q := 3\le p\wedge3\le q\wedge\neg(p=3\wedge q=3)$, L126scope $p\,q := p=2\vee q=2\vee(p=3\wedge q=3)$.

| Theorem | What it types | Correct as algebra? |
|---|---|---|
| three_three_excluded | $\neg$ L27scope 3 3 | Yes |
| three_three_in_L126 | L126scope 3 3 | Yes, the third disjunct |
| even_eight_in_scope | $4\le p\to4\le q\to$ L27scope $p\,q$ over $\mathbb Z$ | Yes. The docstring's "every even $n\ge8$" and $p=q=n/2$ are not typed |
| cubic_not_max | $0<\varepsilon\to0<\varepsilon^3$ over $\mathbb Q$ | Yes |
| semidefinite_insufficient | $\exists f:\mathbb Q\to\mathbb Q,\ f0=0\wedge\forall\varepsilon>0,\ f0<f\varepsilon$ | Yes, with $f=x^3$. It types no derivative or semidefiniteness condition, so $f=x$ witnesses it equally, and the name overstates the content |

**Candidate: the file states L3.** Location: the file header, "Lemma L3: refuted at $n = 6$, a Lemma everywhere else." Failure exhibited: no theorem mentions $\mathcal W_n$, $P$, a Hessian, an orbit or a local maximum. Nothing typed proves L3 at even $n\ge8$ or refutes it at $n=6$. Charitable reading: the file records the scope bookkeeping that selects $n\ge8$ and the one-variable reason a semidefinite Hessian is insufficient, and does not claim more in its theorems. The header's prose does claim more. **REFUTED AS STATED** for "states or proves the lemma". The typed theorems are CONFIRMED AS ALGEBRA.

## Withdrawn candidates

- **Lean header, "No sharpening of a necessary condition reaches a sufficient one"** ([L3.lean](../lean/HamiltonsCubic/Results/L3.lean) lines 18-19 and 52-54). (1) Located there. (2) As a general proposition it is false: $f(x)=-x^2$ has a negative definite Hessian, a sharpening of semidefinite, and that is sufficient, which is exactly the sharpening Passage A's proof makes transverse to the orbit. (3) Charitable reading: the sentence is about $n=6$, where the nine null directions make the semidefinite condition impossible to sharpen, and it is comment prose attached to no typed claim. **Withdrawn**: the reading is coherent and no theorem is affected.
- **"Needed because the known diagonal-case proof cannot see whether $W^*$'s criticality survives"** (Passage A line 33). (1) Located there. (2) Criticality is first-order, and the lemma is about second-order maximality. (3) "Criticality" is loose wording for "its critical-point type", and the statement that follows is unambiguous. **Withdrawn**: motivation line, no logical role.
- **Padded object near $W^*$** (attack item 10). (1) L27 states "padding destroys nondegeneracy", so a padded $W_{p,q}$ with $p+q<n$ inside $\mathcal W_n$ is a candidate nearby degenerate critical point. (2) No failure: the local claim concerns a neighbourhood of $W^*$, and claim 3's conclusion, once its GAP is closed, bounds $P$ at every point of that neighbourhood whatever its type. $W^*$ itself has $n=p+q$ and is unpadded. (3) n/a. **Withdrawn**: not a defect of L3.

## Standing items

1. **Hypothesis inventory.** Table above. Used but unstated: the sufficiency theorem modulo an orbit (section 3) and $\theta(W^*)>0$ (section 1). L24's "local maximiser" clause is unused. All hypotheses are satisfiable.
2. **Quantifier order and scope.** For each even $n\ge8$ separately, there is a neighbourhood of $W^*$ in $S$ (depending on $n$) on which $P\le\theta_n$. "Strictly transverse" is strict on $N=T\cap T_O^\perp$, the normal space in the sphere's tangent space. The constant is non-strict and attained. No finding beyond sections 1 and 3.
3. **Edges.** $n=8$: in scope ($p=q=4$), $\tfrac12-\mu=\tfrac16>0$, the tie of section 4, bound $-\theta$. $n=6$: excluded, the falsity claim is debt (section 6). Odd $n$: $W^*$ undefined, L3 silent, only the remark of section 7 strays there. Kernel of $W$ nonzero: withdrawn, above.
4. **Proven versus stated.** Proven, given L24, L27 and $\theta>0$: claim 2 and, as algebra from L27's values, the constant. Stated beyond the proof: local maximality (section 3), the constant (section 4, not written), $n=6$ falsity (section 6), a second local maximum (section 7), the $\mathbb{CP}^2$ analogy (section 8). Passage B omits the constant and adds the three remarks. Nothing downstream in the passages uses the remarks.
5. **Lean.** States no part of L3 (section 9).
6. **Attack items.** 1: section 3, GAP. 2: section 1, HYPOTHESIS-DEBT on the sign. 3: section 2, no finding. 4: section 4, CONFIRMED AS ALGEBRA with the tie at $n=8$, unwritten. 5: section 5, no finding. 6: section 6, HYPOTHESIS-DEBT, unused by the lemma. 7: section 7, HYPOTHESIS-DEBT. 8: section 8, HYPOTHESIS-DEBT on the $\mathbb{CP}^2$ half. 9: section 9. 10: standing item 3 and the withdrawn padded candidate.
7. **Falsifiers and what was done.**

| Claim | Falsifying object | Search |
|---|---|---|
| 1 | A sign convention under which $P(W^*)<0$ | Showed by oddness that exactly one of $\pm W^*$ has $P>0$ and that the proof's data cannot tell them apart. Sign not evaluated (would be supplying the argument) |
| 2 | A vector in $N$ with $L_e$-eigenvalue $\ge\tfrac12$ | Excluded by L27 as given at $p=q\ge4$ |
| 3 | $W\in S$ arbitrarily near $W^*$, off $O$, with $P(W)\ge\theta$ | None can exist once the standard orbit sufficiency theorem applies. The defect is the missing step, not the conclusion |
| 4 | A normal eigenvalue with $\tfrac12-\lambda<\frac1{2(m-1)}$ | All four candidate gaps computed exactly at $p=q=m$ |
| 5 | An off-diagonal direction outside L27's decomposition | L27 decomposes all of $\mathcal W_n$. Dimension screen at $n=8$ consistent |
| 6 | $P\equiv0$ on $\Lambda^2\mathbb R^3\otimes\Lambda^2\mathbb R^3$ at $W_{3,3}$ with no higher-order ascent | Reduced ascent to $P(X)\ne0$ in closed form. Found no argument either way on file |
| 7 | Absence of a second local maximum at even $n\ge12$, or a global maximiser outside the pair | Nothing on file in the passages |
| 8 | A proof at the $\mathbb{CP}^2$-type competitor not running through a multiplicity-free decomposition | Nothing on file in the passages |
| 9 | A theorem in the file about $P$ on $\mathcal W_n$ | Read every declaration. None |

## Overall verdict

**GAP.** The spectral content is sound and the constant $-6\theta/(n-2)$ is exact and sharp. The proof omits the step it exists to make (a sufficiency theorem modulo the $O(n)$-orbit) and uses $\theta(W^*)>0$ without a source. Both are closable by citation. The $n=6$ falsity, the second local maximum and the $\mathbb{CP}^2$ analogy are HYPOTHESIS-DEBT, none used by the lemma. The Lean file does not state L3.
