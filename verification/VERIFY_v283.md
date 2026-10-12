# Verifier v283, Lemma L9: triality as an automorphism of W_8, the identification HP^2 = tau(S^3 x S^5), L27 at (3,5), the orbit transfer, strict maximality from L24's Hessian, the framing, the scope and the Lean files

Cold brief ([BRIEF_L09.md](BRIEF_L09.md)), no numerical work, every value exact, no scripts. Log: [agent_logs/verify-L09-v283.log](../agent_logs/verify-L09-v283.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\tau$ is an orthogonal automorphism of $\mathcal W_8$ preserving the bracket, the inner product, $\#$, $W^2$, $Q$ and $\mathcal W_8$ | CONFIRMED |
| 2 | $\mathbb{HP}^2=\tau(S^3\times S^5)$ | HYPOTHESIS-DEBT |
| 3 | L27 at $(3,5)$: $\tfrac12-\mu=\tfrac18>0$, $\dim E(\tfrac12)=15=\dim\mathcal O$, hypotheses hold | CONFIRMED |
| 4 | $\tau$ carries orbit tangents to orbit tangents and $L_e$ to $L_{\tau e}$, so the $\tfrac12$-eigenspace identity transfers | CONFIRMED |
| 5 | With L24's Hessian, strict local maximality transverse to the orbit | CONFIRMED AS ALGEBRA |
| 6a | $\mathbb{HP}^2$ has nonzero defect, so "nonzero defect does not force instability" and "defectiveness alone permits a genuine peak" | HYPOTHESIS-DEBT |
| 6b | "sensitive to the value", "several peaks below the two named ones rather than a single ridge" | HYPOTHESIS-DEBT |
| 7 | The landscape entry ([results.md](../results.md) line 140): "is a strict local maximum", no $n$, no orbit | REFUTED AS STATED |
| 8a | The Lean files state or prove L9 | GAP |
| 8b | [L9.lean](../lean/HamiltonsCubic/Results/L9.lean) line 67 docstring: "the gap at $n = 8$ is $11/90$" | REFUTED AS STATED |
| 9 | $SO(8)$ against $O(8)$, and the kernel | CONFIRMED |

**Summary: the second-order algebra from L27 at $(3,5)$ through $\tau$ to L24's Hessian is sound, but the load-bearing identification $\mathbb{HP}^2=\tau(S^3\times S^5)$ carries no argument and no filed source, and the defect and value claims that give L9 its point are unargued in the passages.**

## 0. Conventions, fixed once

- $\mathcal W_8$ is the space of algebraic Weyl tensors on $\mathbb R^8$ read as symmetric operators on $\Lambda^2\mathbb R^8\cong\mathfrak{so}(8)$ with the Frobenius inner product. $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, a critical point on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$, $e=W/\theta$, $L_e=e\circ(\cdot)$.
- $O(8)$ acts on $\mathcal W_8$ by $g\cdot W=(\Lambda^2g)\,W\,(\Lambda^2g)^{-1}$. $\mathcal O$ is the $O(8)$-orbit.
- $\tau$ is an automorphism of the Lie algebra $\mathfrak{so}(8)$ whose class in $\mathrm{Out}(\mathfrak{so}(8))\cong S_3$ has order 3 ([Yokota, Theorem 1.3.5](../references/yokota-2009-exceptional-lie-groups/notes.md), [Ziller, Example 4.45](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md)). It acts on $\mathcal W_8$ by $W\mapsto\tau W\tau^{-1}$.
- **Sign.** $Q(-W)=Q(W)$, so $W$ and $-W$ are both critical with opposite $\theta$ and the same $e$. The record's convention is $\theta>0$ ([findings/nondegeneracy.md](../findings/nondegeneracy.md) line 290, read at source because L24's hypothesis $\theta>0$ must be checked where applied), and $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ with a positive coefficient is on file at [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 99.
- Quotations: Passages A (graded-half.md lines 260, 264, 266), B (results.md lines 140, 485), C (second-order.md lines 61-63, 67, 69; results.md line 320) and D (nondegeneracy.md lines 496-498, 511-518; results.md line 154) were displayed at their cited lines and match the brief verbatim.

## Hypothesis inventory

| Hypothesis | Source | Used where | Stated? | Satisfiable / holds? |
|---|---|---|---|---|
| $n=8$ | Passage A, line 485 | everywhere ($\tau$ exists only for $D_4$) | yes in A and line 485, absent at line 140 | yes |
| $W$ is the normalised Weyl tensor of $\mathbb{HP}^2$, $\theta>0$ representative | statement | the object | the sign is not stated in A or B | yes, by the record's convention (§0) |
| L24: $W$ critical, $\theta=P(W)>0$ | Passage C | Hessian $6\theta(L_e-\tfrac12\mathrm{Id})$ | criticality follows from $\tau$-equivariance of $Q$, and $\theta>0$ is not checked in A | holds given claim 2, since $\theta(\tau W)=\theta(W_{3,5})>0$ |
| L24: "local maximiser" | Passage C | not used (A uses only the Hessian identity, which holds at every critical point with $\theta>0$) | n/a | n/a |
| L27: $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$ | Passage D | at $(3,5)$ | yes | $3,5\ge3$, $(3,5)\ne(3,3)$, $n=8$: holds |
| Triality exists as an automorphism of $\mathfrak{so}(8)$ | Yokota Thm 1.3.5, filed | claim 1 | cited by name only | yes |
| Automorphisms of $\mathfrak{so}(8)$ preserve the Frobenius inner product | used, unstated | claim 1 | asserted ("preserves ... the inner product") | yes: automorphisms preserve the Killing form, which on the simple $\mathfrak{so}(8)$ is a negative multiple of the Frobenius form |
| $\mathrm{Sym}^2(\Lambda^2\mathbb R^8)=\mathcal W_8\oplus1\oplus35_v\oplus35_+\oplus35_-$, multiplicity-free, $\tau$ permuting the $35$s | used, stated in part, unsourced | claim 1 | the decomposition is stated, multiplicity-freeness is not | yes (§1) |
| $\mathbb{HP}^2=\tau(S^3\times S^5)$ | none | claims 2, 4, 5 | asserted | unargued, unsourced (§2) |
| Second-order negative definiteness modulo a compact-group orbit implies a strict local maximum modulo the orbit (Morse–Bott lemma) | none | claim 5, literal reading | unstated | a standard theorem, **unfiled** |
| $\mathbb{HP}^2$ has nonzero defect | none in A–D | 6a | asserted | unargued in the passages (§6) |
| $P(\mathbb{HP}^2)$ lies below "the two named ones" | none in A–D | 6b | asserted | unargued in the passages (§6) |

## 1. $\tau$ as an orthogonal automorphism of $\mathcal W_8$ (attack item 1): CONFIRMED

**Derivation.**

- *Bracket and inner product.* $\tau$ is a Lie algebra automorphism of $\mathfrak{so}(8)$, so it preserves the bracket. Every automorphism of a Lie algebra preserves its Killing form $B$. On $\mathfrak{so}(8)$, $B(X,Y)=6\operatorname{tr}(XY)$, a negative multiple of the Frobenius form, so $\tau$ is orthogonal on $\Lambda^2\mathbb R^8$.
- *Action on operators.* $W\mapsto\tau W\tau^{-1}$ sends symmetric operators to symmetric operators (as $\tau^{-1}=\tau^{\mathsf T}$) and preserves $\operatorname{tr}(WV)$, so it is orthogonal on $\mathrm{Sym}^2(\Lambda^2)$. $(\tau W\tau^{-1})^2=\tau W^2\tau^{-1}$.
- *$\#$.* With $\langle W^\#\omega,\eta\rangle=\tfrac12\sum_{\alpha,\beta}\langle[W\varphi_\alpha,W\varphi_\beta],\omega\rangle\langle[\varphi_\alpha,\varphi_\beta],\eta\rangle$ over an orthonormal basis, substitute the orthonormal basis $\varphi_\alpha=\tau\psi_\alpha$ and use $\tau[\cdot,\cdot]=[\tau\cdot,\tau\cdot]$ and orthogonality: $\langle(\tau W\tau^{-1})^\#\omega,\eta\rangle=\langle W^\#\tau^{-1}\omega,\tau^{-1}\eta\rangle$, so $(\tau W\tau^{-1})^\#=\tau W^\#\tau^{-1}$. Hence $Q$ is $\tau$-equivariant and $P$ is $\tau$-invariant. If $Q$ carries a projection onto $\mathcal W_8$, $\tau$ commutes with it once it preserves $\mathcal W_8$ and its complement, which the next bullet gives.
- *$\mathcal W_8$.* $\dim\mathrm{Sym}^2(\Lambda^2\mathbb R^8)=\tfrac{28\cdot29}2=406$. Algebraic curvature tensors: $\tfrac{n^2(n^2-1)}{12}=336$, so $\mathcal W_8$ has dimension $336-35-1=300$ and $\Lambda^4\mathbb R^8$ has $70=35_++35_-$. Check: $300+1+35+70=406$. As $\mathrm{Spin}(8)$-modules the five summands have highest weights $2\omega_2,0,2\omega_1,2\omega_3,2\omega_4$, pairwise distinct, so the decomposition is multiplicity-free and each summand is an isotypic component. The map $\tau$ intertwines the representation on $\mathrm{Sym}^2$ with its twist by $\tau^{-1}$, so it sends the isotypic component of weight $\lambda$ onto that of the permuted weight. Triality permutes $\omega_1,\omega_3,\omega_4$ and fixes $\omega_2$, so it permutes the three $35$s, fixes the trivial line ($\tau\,\mathrm{Id}\,\tau^{-1}=\mathrm{Id}$), and, being orthogonal, preserves the orthogonal complement $\mathcal W_8$.

**Record.** The passage's sentence is correct. It leaves multiplicity-freeness implicit, which is what turns "permutes the three $35$s" from a statement about isomorphism classes into one about subspaces. No finding: the unstated link holds by the distinct highest weights.

## 2. $\mathbb{HP}^2=\tau(S^3\times S^5)$ (attack item 2): HYPOTHESIS-DEBT

1. **Location.** Line 266: "$\mathbb{HP}^2=\tau(S^3\times S^5)$ with $\tau$ triality". No citation and no derivation follow. [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) lists "The triality identification" under "What is NOT typed here". The filed Yokota notes say, at [notes.md](../references/yokota-2009-exceptional-lie-groups/notes.md) line 20: "the record's witness ($S^3\times S^5$ against $\mathbb{HP}^2$, both at isotropy dimension $13$), remains the record's own". Ziller and Holland–Ion carry no statement about it (Holland–Ion's notes: "$n=8$ is not distinguished"). A grep of the other reference folders for triality found no source either.
2. **Exhibit.** The failure is an absent argument. The only support on file is [L9.lean](../lean/HamiltonsCubic/Results/L9.lean) line 11, "The triality identification checks numerically, and exactly", resting on $\theta^2(\mathbb{HP}^2)=\tfrac{(2+2)^2(4\cdot2-1)}{9\cdot2\cdot1\cdot5}=\tfrac{112}{90}=\tfrac{56}{45}$ and $\theta^2(S^3\times S^5)=\tfrac{2\cdot7\cdot2\cdot4}{6\cdot15}=\tfrac{112}{90}=\tfrac{56}{45}$ (both checked exactly). Because $P$ is $\tau$-invariant, equal $\theta^2$ is **necessary** for the identification and fixes neither the orbit nor the sign: it is one real invariant on a 300-dimensional space.
3. **Charitable reading.** The identification is consistent with everything I could check without supplying it: the isotropy algebras $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ are isomorphic and both of dimension 13, and triality exchanges the vector representation, on which $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ acts as $3+5$, with a half-spin representation, on which it acts as $(2,4)$, the isotropy representation of $\mathbb{HP}^2$. I found no falsifier. That consistency concerns subalgebras. The proof needs a statement about Weyl tensors, and the step from one to the other is not on file.

**Retained.** What would have to be proved:

- (i) a triality automorphism $\tau$ carries $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ onto an $SO(8)$-conjugate of the holonomy algebra $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ of $\mathbb{HP}^2$.
- (ii) $\tau$ carries the normalised Weyl tensor $W_{3,5}$ to the normalised Weyl tensor of $\mathbb{HP}^2$, and not to a different unit vector of $\mathcal W_8$ with the same stabiliser. Each curvature operator is supported on its holonomy algebra with its own weights on the two simple factors, so this needs the Weyl projections of the two curvature operators related through $\tau$, with the sign fixed in the $\theta>0$ normalisation.

Everything in the proof after the first sentence is about $\tau(W_{3,5})$. Without (i) and (ii) it proves strict maximality at $\tau(W_{3,5})$, an unnamed point, and the name $\mathbb{HP}^2$ is carried by this debt alone.

## 3. L27 at $(p,q)=(3,5)$ (attack item 3): CONFIRMED

- Hypotheses: $p=3\ge3$, $q=5\ge3$, $(3,5)\ne(3,3)$, $n=p+q=8$. All hold.
- $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}=\frac{1\cdot3-1}{2\cdot2\cdot4}=\frac2{16}=\frac18>0$. So $\mu=\tfrac38$, agreeing with [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean)'s $\mu=\frac{p+q-2}{2(p-1)(q-1)}=\frac6{16}$, and the two forms agree identically: $(p-1)(q-1)-(p+q-2)=pq-2p-2q+3=(p-2)(q-2)-1$.
- The other L27 values at $(3,5)$: $\lambda_3=\tfrac14$, $\lambda_5=\tfrac38$, $+\mu=\tfrac38$, $-\mu=-\tfrac38$, $0$. All are below $\tfrac12$. The value $1$ sits on $\langle W\rangle$, outside $W^\perp$.
- $\dim E(\tfrac12)=pq=15$, which L27 equates with the orbit dimension. Independently, $\dim\mathfrak{so}(8)-\dim(\mathfrak{so}(3)\oplus\mathfrak{so}(5))=28-13=15$, consistent.

No finding.

## 4. Orbit tangents and the $\tfrac12$-eigenspace transfer (attack item 4): CONFIRMED

- *Tangents.* The orbit tangent at $W$ is $\{[\mathrm{ad}X,W]:X\in\mathfrak{so}(8)\}$, where $\mathrm{ad}X$ acts on $\Lambda^2\cong\mathfrak{so}(8)$. Since $\tau\,\mathrm{ad}X\,\tau^{-1}=\mathrm{ad}(\tau X)$, $\tau[\mathrm{ad}X,W]\tau^{-1}=[\mathrm{ad}(\tau X),\tau W\tau^{-1}]$, and $X\mapsto\tau X$ is a bijection of $\mathfrak{so}(8)$. So $\tau$ maps the orbit tangent at $W_{3,5}$ onto the orbit tangent at $\tau W_{3,5}$. This is the content of "$\tau$ normalises the inner automorphisms", which is correct as stated: $\tau\,\mathrm{Ad}(g)\,\tau^{-1}=\mathrm{Ad}(\tilde\tau(g))$ for the lifted automorphism $\tilde\tau$ of $\mathrm{Spin}(8)$.
- *$L_e$.* Equivariance of $Q$ gives equivariance of $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. With $\theta(\tau W)=\theta(W)$ from invariance of $P$, $e(\tau W)=\tau e$ and $\tau L_e\tau^{-1}=L_{\tau e}$. Also $\tau(W^\perp)=(\tau W)^\perp$ by orthogonality. So eigenspaces and eigenvalues of $L_e|_{W^\perp}$ are carried bijectively, and "$\lambda_{\max}=\tfrac12$, attained exactly on the orbit tangent" transfers.
- *Reflections.* Treated in §9 and in the withdrawn candidates: tangents depend only on $\mathfrak{so}(8)$, so the reflections play no role.

No finding.

## 5. Strict local maximality from L24's Hessian (attack item 5): CONFIRMED AS ALGEBRA

**Derivation.** At $\tau W_{3,5}$, L24 (hypotheses: critical, $\theta>0$) gives the Riemannian Hessian $6\theta(L_e-\tfrac12\mathrm{Id})$ on $T=W^\perp$, which is $L_e$-invariant (L24's argument). By §3 and §4 the spectrum of $L_e|_{W^\perp}$ is $\tfrac12$ on the 15-dimensional orbit tangent and values in $\{\tfrac38,\tfrac14,0,-\tfrac38\}$ elsewhere. So the Hessian is $0$ on the orbit tangent and at most $6\theta(\tfrac38-\tfrac12)=-\tfrac34\theta$ on its orthogonal complement in $W^\perp$, which is negative definite iff $\theta>0$.

**What the step needs beyond the Hessian.**

- *The sign of $\theta$.* The passages never check it, and it is decisive: $-W$ has the same $e$ and the Hessian $6(-\theta)(L_e-\tfrac12\mathrm{Id})$, a strict local minimum transverse to its orbit. The record supplies it outside the passages: the convention $\theta>0$ ([nondegeneracy.md](../findings/nondegeneracy.md) line 290) and $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ (line 99), so $\theta(W_{3,5})>0$ and $\theta(\tau W_{3,5})=\theta(W_{3,5})>0$. Given claim 2 in the $\theta>0$ normalisation, the hypothesis holds. Three-step record in the withdrawn candidates.
- *From second order to an actual local maximum.* Passage A's statement defines its claim by the colon ("its second variation is negative on the whole tangent space apart from the directions along its orbit"), and that second-order claim is what the derivation proves. Reading "strict local maximum transverse to the orbit" as a statement about values of $P$ requires the Morse–Bott lemma for a function invariant under a compact group: negative definite Hessian on a slice through the critical point gives a strict maximum on the slice, and invariance spreads it along the orbit. This is standard, used without statement, and **unfiled**.

**Verdict reason.** The algebra is correct, and the second-order claim follows at $\tau(W_{3,5})$. Its application to $\mathbb{HP}^2$ is conditional on §2. The value-level reading rests on an unfiled standard import.

## 6. The framing in Passage A and the consequences in Passage B (attack item 6)

### 6a. Nonzero defect: HYPOTHESIS-DEBT

1. **Location.** Line 264: "Testing whether a nonzero defect forces instability answers no, and the counterexample is one of the named families." Line 140: "so nonzero defect does not force instability". Line 485: "since defectiveness alone permits a genuine peak".
2. **Exhibit.** "Defect" is defined nowhere in Passages A–D or in the brief's definitions, and no passage states or derives that $\mathbb{HP}^2$ has nonzero defect. The only object on file is Lean: [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) lines 170-171 type it as `altNormSq Wm ≠ 0` for the spectral splitting $W=W_+-W_-$ and the docstring calls it "Bianchi defect" with value $2/63$. The theorem `hp2_defect_nonzero` (line 203) proves only `(2:ℝ) / 63 ≠ 0`, with $2/63$ entered as a literal. "The named families" are not named in the passages.
3. **Charitable reading.** The defect may be derived elsewhere in the record. The brief quotes no such derivation, and the proof in Passage A never touches the defect, so the lemma's proof does not establish the property that makes $\mathbb{HP}^2$ a counterexample. The passages also leave unaddressed whether the defect is $\tau$-invariant: if it were, $S^3\times S^5$ would carry the same defect.

**Retained.** What would have to be proved: a definition of the defect and a derivation that its value at the normalised $\mathbb{HP}^2$ operator is nonzero (the Lean docstring's $2/63$). Conditional on that, "nonzero defect does not force instability" and "defectiveness alone permits a genuine peak" follow from §5 as valid inferences.

### 6b. The value comparison and "several peaks": HYPOTHESIS-DEBT

1. **Location.** Line 485: "Any argument excluding defective rivals has to be sensitive to the value and not only to the defect, since defectiveness alone permits a genuine peak. And the landscape carries several peaks below the two named ones rather than a single ridge, so eliminating rivals cannot be a stability argument."
2. **Exhibit.** "The two named ones" are not identified in Passages A–D, and neither $P(\mathbb{HP}^2)$ nor any comparison value appears there. Lean names them: `peak_below_competitors` compares $56/45$ with $3/2$ and with $\theta_0(8)^2=21/16$, which is arithmetic on literals. Passage B cites no second peak. L27 would give $S^4\times S^4$ at $n=8$ as nondegenerate, but B does not invoke it, and $S^3\times S^5$ is the $\tau$-preimage of $\mathbb{HP}^2$ at the same value. So "several" has no argument in B. "Sensitive to the value" additionally needs $\mathbb{HP}^2$ to be a rival, i.e. below the global maximum, which is again the missing comparison.
3. **Charitable reading.** Granting a peak strictly below the top value, the inference "eliminating rivals cannot be a stability argument" is sound: a strict local maximum passes every test that uses only local second-order information. The inference is fine and its premise is what is missing.

**Retained.** What would have to be proved: the values of the two named competitors and $\theta(\mathbb{HP}^2)$ (with $\theta^2=56/45$ on file only in Lean), the strict inequalities between them, and for "several", a second peak cited with its own argument.

## 7. Scope of the landscape entry (attack item 7): REFUTED AS STATED

1. **Location.** [results.md](../results.md) line 140: "The quaternionic-Kähler operator on $\mathbb{HP}^2$ is a strict local maximum, so nonzero defect does not force instability". It names no $n$ and no orbit. This is the line quoted verbatim into [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean).
2. **Exhibit.** $P$ is $O(8)$-invariant (the argument of §1 with $\Lambda^2g$ in place of $\tau$). The orbit through $W$ has dimension 15 (Passage A). Take $X\in\mathfrak{so}(8)$ outside the stabiliser algebra and $g_t=\exp(tX)$. Then $g_t\cdot W\ne W$ for small $t\ne0$ and $P(g_t\cdot W)=P(W)$. Every neighbourhood of $W$ on the unit sphere contains $W'\ne W$ with $P(W')=P(W)$, so $W$ is not a strict local maximum in the literal sense. L24's own passage makes the same point: "the orbit is never a point".
3. **Charitable reading.** "Strict local maximum" as the record's shorthand for "strict transverse to the orbit", with $n=8$ implicit because $\mathbb{HP}^2$ is 8-dimensional. Line 485 and line 264 spell out both. The meaning is recoverable from the detail entry, but not from line 140 on its own, and line 140 is the statement carried into Lean.

**Retained, as a wording correction that leaves the proof untouched.** Corrected form: "is a strict local maximum transverse to its $O(8)$-orbit, at $n=8$".

**Padded $\mathbb{HP}^2$ at $n>8$.** No passage proves anything there. $\tau$ exists only for $D_4$ (Ziller, Example 4.45: $\mathrm{Sym}(D_n)=\mathbb Z_2$ for $n\ne4$), so the transfer has no analogue. L27's "padding destroys nondegeneracy" concerns sphere products and does not transfer through $\tau$. I exhibited no closed-form falsifier at $n>8$, so the only finding is that the claim is scoped to $n=8$ and line 140 must say so.

## 8. The Lean files (attack item 8)

### 8a. Whether they state or prove L9: GAP

- [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) lines 170-172, `theorem L9`, is `sorry`. It types: there exist $W,W_+,W_-$ at $n=8$ with `IsWeyl W`, `normSq W = 1`, a spectral split, `altNormSq Wm ≠ 0`, and `IsLocalMaxOn Pcubic` on the unit sphere. That is a **non-strict**, **existential** statement. It names neither $\mathbb{HP}^2$ nor the orbit nor strictness. The docstring's "What the `sorry` is" (line 37) says it stands for building the $\mathbb{HP}^2$ operator with nonzero defect as a local maximum, needing triality and L27's decomposition. Having read the typed statement, I find that account accurate.
- `hess_neg_of_not_half_eigenvector` (lines 123-124) is proved without `sorry`. It is abstract: on any real inner product space, with $L$ symmetric, **$0<\theta$**, and $\langle Lx,x\rangle\le\tfrac12\|x\|^2$, it gives $6\theta(\langle Lv,v\rangle-\tfrac12\|v\|^2)<0$ off the $\tfrac12$-eigenspace. Its hypothesis `hθ : 0 < θ` is the sign §5 identifies as needed. It is never instantiated at $\mathbb{HP}^2$.
- The remaining theorems in both files (`half_minus_mu`, `eigenspace_matches_orbit` = `3 * 5 = 15`, `triality_value_agreement`, `peak_below_competitors`, `hp2_defect_nonzero`, and all of [L9.lean](../lean/HamiltonsCubic/Results/L9.lean)) are `norm_num`/`decide` identities on literals.
- **So the Lean layer proves no part of L9 at $\mathbb{HP}^2$**. It states a weaker existential with `sorry`, and it types none of claims 1, 2, 4, the Hessian, or the defect value.

### 8b. The docstring gap at $n=8$: REFUTED AS STATED

1. **Location.** [L9.lean](../lean/HamiltonsCubic/Results/L9.lean) line 67: "the gap at `n = 8` is `11/90`", above line 68: `theorem gap_at_eight : (21 : ℚ) / 16 - 56 / 45 = 49 / 720`.
2. **Exhibit.** $\tfrac{21}{16}-\tfrac{56}{45}=\tfrac{945-896}{720}=\tfrac{49}{720}$, which is what the theorem proves. $\tfrac{11}{90}=\tfrac{88}{720}$.
3. **Charitable reading.** Try the other named gap, $\tfrac32-\tfrac{56}{45}=\tfrac{135-112}{90}=\tfrac{23}{90}\ne\tfrac{11}{90}$. No reading gives $11/90$.

**Retained**, docstring only. The theorem is correct and does not bear on L9's proof.

## 9. $SO(8)$ against $O(8)$, and the kernel (attack item 9): CONFIRMED

- **$SO(8)$ against $O(8)$.** $P$ is $O(8)$-invariant. The $O(8)$-orbit and the $SO(8)$-orbit share their tangent space, the image of $\mathfrak{so}(8)$, so $\dim\mathcal O=15$ and the transverse statement are the same for both groups. $\tau$ normalises $\mathrm{Inn}(\mathfrak{so}(8))$, the image of $SO(8)$, but **not** the image of $O(8)$. The reflections realise a transposition $\sigma$ in $\mathrm{Out}\cong S_3$, and $\tau\sigma\tau^{-1}$ is a different transposition. So $\tau$ need not carry the full $O(8)$-orbit of $W_{3,5}$ onto the $O(8)$-orbit of $\tau W_{3,5}$ component by component. The passage claims normalisation of the inner automorphisms only, and uses only tangents. No finding (withdrawn candidate below).
- **The kernel of the action.** $O(8)\to O(\mathcal W_8)$ has kernel $\{\pm1\}$, which changes no orbit dimension. No finding.
- **The kernel of $L_e$.** L27's "$0$ on the remaining four" summands carry Hessian $6\theta(0-\tfrac12)=-3\theta<0$ for $\theta>0$. They are strictly negative directions, not degenerate ones. No finding.
- **The kernel of the operator $W_{\mathbb{HP}^2}$ on $\Lambda^2$.** No step of the proof uses it, and $\tau$-conjugation preserves kernel dimension, so whatever it is at $W_{3,5}$ it is at $\tau W_{3,5}$. No finding.

## 10. The standing list

1. **Hypothesis inventory.** In the table above. Every hypothesis is satisfiable. Used but unstated: multiplicity-freeness (holds), Killing-form orthogonality (holds), $\theta>0$ (holds by convention, given §2), the Morse–Bott lemma (unfiled), the identification (debt), the defect (debt), the value comparison (debt).
2. **Quantifier order and scope.** $n=8$ only. The group is $O(8)$ acting by conjugation through $\Lambda^2$, and its tangent is that of $SO(8)$. Strict is meant as transverse: negative definite on the orthogonal complement of the orbit tangent inside $W^\perp=T_W S(\mathcal W_8)$. Lean types non-strict. Line 140 drops both $n$ and "transverse" (§7).
3. **Edges.** $SO(8)$ against $O(8)$: §9, no finding. Padded $\mathbb{HP}^2$ at $n>8$: §7, unreached by any argument, and line 140 needs $n=8$. The kernel: §9, no finding.
4. **Proven against stated or used.** Proven: the second-order claim at $\tau(W_{3,5})$ for any triality $\tau$ (§§1, 3, 4, 5). Stated in A: the same at $\mathbb{HP}^2$, which needs §2. Stated in B: additionally nonzero defect, a value below two named competitors, and several peaks, none argued in A–D (§6). The landscape line's literal "strict local maximum" is false (§7).
5. **Lean.** §8. It states a weaker non-strict existential with `sorry` and proves only arithmetic, plus an abstract criterion never applied at $\mathbb{HP}^2$.
6. **Attack items.** §§1-9 above, numbered as in the brief.
7. **Falsifying objects and what I did.**
   - Claim 1: a vector of $\mathcal W_8$ whose $\tau$-image has a component in $1+35_v+35_++35_-$. I excluded it by dimension count, highest weights, and orthogonality.
   - Claim 2: a triality $\tau$ with $\tau(W_{3,5})\ne W_{\mathbb{HP}^2}$. I checked the isotropy representation content, which is consistent. None was exhibited, and the debt stands for want of an argument.
   - Claim 3: an L27 eigenvalue $\ge\tfrac12$ off the orbit summand at $(3,5)$. I checked all values exactly.
   - Claim 4: a $\tfrac12$-eigenvector of $L_{\tau e}$ outside $\tau$(orbit tangent). It is impossible, since $\tau L_e\tau^{-1}=L_{\tau e}$ is a bijection of eigenspaces.
   - Claim 5: a transverse direction with Hessian $\ge0$, or the $\theta<0$ representative. The latter is real for $-W$, and it is excluded by the $\theta>0$ convention.
   - Claim 6: a zero-defect $\mathbb{HP}^2$, or a named competitor below $P(\mathbb{HP}^2)$. Neither can be examined, since the passages define neither.
   - Claim 7: the curve $\exp(tX)\cdot W$, exhibited.
   - Claim 8b: the exact difference, computed by hand.
   - Claim 9: a reflection breaking the tangent correspondence, excluded because tangents depend on $\mathfrak{so}(8)$ alone.

## Withdrawn candidates

- **$\theta<0$ at $\mathbb{HP}^2$ makes it a minimum.** (1) Line 266 applies "Lemma L24's Hessian $6\theta(L_e-\tfrac12\mathrm{Id})$" without checking L24's hypothesis $\theta>0$. (2) $Q(-W)=Q(W)$, so $-W$ is critical with $-\theta$, the same $e$, and a Hessian of the opposite sign. With the wrong sign the point is a strict minimum transverse to the orbit. (3) The record fixes $\theta>0$ as its convention ([nondegeneracy.md](../findings/nondegeneracy.md) line 290), $\theta(W_{3,5})>0$ from $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ (line 99), and $P$ is $\tau$-invariant, so $\tau W_{3,5}$ is the $\theta>0$ representative of whatever it equals. **Withdrawn**: the sign is supplied, conditionally on §2, outside the passages. The passage should say so.
- **"$\tau$ normalises the inner automorphisms" misapplied to the $O(8)$-orbit.** (1) Line 266, against the brief's definition of $\mathcal O$ as an $O(8)$-orbit. (2) $\tau$ does not normalise the image of $O(8)$ in $\mathrm{Aut}(\mathfrak{so}(8))$ (§9). (3) The passage says "inner", which is correct, and uses only orbit tangents, which are the image of $\mathfrak{so}(8)$ for both groups. **Withdrawn.**
- **[L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) line 177 says $\mu$ is "the eigenvalue L27 carries on $S^2_0\otimes S^2_0$ and $\Lambda^2\otimes\Lambda^2$".** (1) Line 177. (2) L27 (Passage D) gives $+\mu$ on $\Lambda^2\otimes\Lambda^2$ and $-\mu$ on $S^2_0\otimes S^2_0$. (3) Read as "$\pm\mu$", the docstring is right, and the theorem it heads uses only $\tfrac12-\mu$, which is governed by $+\mu$. **Withdrawn** as imprecision.
- **Multiplicity-freeness missing from the preservation of $\mathcal W_8$.** (1) Line 266, "whose three $35$s it permutes". (2) Without multiplicity-freeness, a $\tau$-image of $35_v$ could meet $\mathcal W_8$. (3) The highest weights $2\omega_2,0,2\omega_1,2\omega_3,2\omega_4$ are distinct, so each summand is isotypic and the permutation is of subspaces. **Withdrawn.**

## Overall verdict: HYPOTHESIS-DEBT

The chain from L27 at $(3,5)$ through the triality automorphism to L24's Hessian is correct and proves the second-order strict-maximality claim at $\tau(W_{3,5})$. The lemma is about $\mathbb{HP}^2$, and the identification $\mathbb{HP}^2=\tau(S^3\times S^5)$ that names the point has no argument and no filed source. The filed Yokota notes say explicitly that it is the record's own. The defect and value claims that make L9 a counterexample are unargued in the passages. The landscape line needs "transverse to its $O(8)$-orbit, at $n=8$". [L9.lean](../lean/HamiltonsCubic/Results/L9.lean) line 67 needs $49/720$.
