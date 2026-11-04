# Verifier v284, Lemma L9: triality carries S^3 x S^5 to HP^2, the transfer of L27's spectrum, strict local maximality transverse to the orbit at n=8, the defect and peak framing, and the Lean statement

Cold brief ([BRIEF_L09.md](BRIEF_L09.md)), no numerical work, every value exact, no scripts. Log: [agent_logs/verify-L09-v284.log](../agent_logs/verify-L09-v284.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\tau$ is orthogonal on $\Lambda^2\mathbb R^8$, preserves the bracket, hence commutes with $W^2$, $\#$ and $Q$ | CONFIRMED |
| 2 | $\tau$ preserves $\mathcal W_8$ because the complement $1+35_v+35_++35_-$ has its three $35$s permuted | HYPOTHESIS-DEBT |
| 3 | $\mathbb{HP}^2=\tau(S^3\times S^5)$ | HYPOTHESIS-DEBT |
| 4 | L27 at $(p,q)=(3,5)$: $\tfrac12-\mu=\tfrac18$, $\dim E(\tfrac12)=15=\dim\mathcal O$ | CONFIRMED |
| 5 | $\tau$ normalises the inner automorphisms, so orbit tangents and the $\tfrac12$-eigenspace transfer | CONFIRMED |
| 6 | With L24's Hessian, strict local maximality transverse to the orbit | CONFIRMED (at the point $\tau W_{3,5}$ oriented with $\theta>0$) |
| 7 | "Nonzero defect" of $\mathbb{HP}^2$, and the counterexample framing | HYPOTHESIS-DEBT |
| 8 | "More than one peak", "several peaks below the two named ones" | HYPOTHESIS-DEBT |
| 9 | The Lean files state Lemma L9 | REFUTED AS STATED |

**Summary:** the chain from triality to a transverse strict local maximum is correct algebra at $\tau W_{3,5}$, but the identification of that point with the quaternionic-Kähler operator of $\mathbb{HP}^2$ (sign included), the nonzero defect and the distinctness of the peak have no argument on file, and the typed Lean statement is provable without $\mathbb{HP}^2$. **Overall: HYPOTHESIS-DEBT.**

## 0. Conventions, fixed once

- $\mathcal W_8\subset\mathrm{Sym}^2(\Lambda^2\mathbb R^8)$, $\Lambda^2\mathbb R^8\cong\mathfrak{so}(8)$ with the Frobenius inner product, which is a negative multiple of the Killing form.
- $\tau$ denotes a Lie algebra automorphism of $\mathfrak{so}(8)$ whose outer class in $\mathrm{Out}(\mathfrak{so}(8))\cong S_3$ moves the vector representation. It acts on symmetric operators by $W\mapsto\tau W\tau^{-1}$. This is the only reading under which "preserves the bracket and the inner product, hence $\#$ and $W^2$" has content, and it is the reading checked.
- $W_{3,5}$ is L27's normalised Weyl tensor of $S^3\times S^5$. $\mathcal O_W$ is the $O(8)$-orbit of $W$ under conjugation. $E(\tfrac12)$ is the $\tfrac12$-eigenspace of $L_e$ on $W^\perp$.
- Quotations: Passages A to D were displayed at exactly the cited lines ([graded-half.md](../findings/graded-half.md) 260, 264, 266; [results.md](../results.md) 140, 154, 320, 485; [second-order.md](../findings/second-order.md) 61-63, 67, 69; [nondegeneracy.md](../findings/nondegeneracy.md) 496-498, 511-518). All match the brief verbatim. Lines 25-36 of [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) were not read.

## Hypothesis inventory

| Hypothesis | Where | Used | Stated | Satisfiable / holds here |
|---|---|---|---|---|
| $n=8$ | A, line 485 | yes (triality exists only for $D_4$) | A and 485 yes, line 140 no | yes |
| $\tau\in\mathrm{Aut}(\mathfrak{so}(8))$ outer, moving the vector class | A | yes | "triality", class unnamed | yes, [Yokota](../references/yokota-2009-exceptional-lie-groups/notes.md) Thm 1.3.5, [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md) Prop 4.43, Ex 4.45 |
| Automorphisms preserve the Killing form | A ("preserves the inner product") | yes | asserted | yes, one line: $B(\sigma X,\sigma Y)=\mathop{\mathrm{tr}}(\sigma\,\mathrm{ad}_X\mathrm{ad}_Y\sigma^{-1})$ |
| The three $35$s are permuted by $\tau$ | A | yes | asserted, no argument, no filed source | standard, unfiled (Claim 2) |
| $\mathbb{HP}^2=\tau(W_{3,5})$, same sign | A | yes, load-bearing | asserted, no argument, no filed source | unargued (Claim 3) |
| L27: $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$ | D | yes | yes | holds at $(3,5)$, $n=8$ |
| L24: critical point, $\theta=P(W)>0$ | C | yes | L24 yes, A never states $\theta>0$ at $\mathbb{HP}^2$ | holds at whichever of $\pm\tau W_{3,5}$ has $P>0$ (Claim 6) |
| $\mathrm{Int}(\mathfrak{so}(8))\trianglelefteq\mathrm{Aut}(\mathfrak{so}(8))$ | A | yes | asserted | yes, $\sigma e^{\mathrm{ad}X}\sigma^{-1}=e^{\mathrm{ad}\,\sigma X}$ |
| $P$ constant on $O(8)$-orbits, and the second-derivative test on a slice (Morse–Bott) | A's last sentence | yes | used, unstated, uncited | standard and unfiled, holds (Claim 6) |
| Defect of $\mathbb{HP}^2$ nonzero | A framing, B | yes, for the counterexample | asserted, "defect" undefined in A and B | unargued (Claim 7) |
| $\mathbb{HP}^2\notin\mathcal O_{W_{3,5}}$, and values below "the two named ones" | B | yes, for "more than one peak" | no | unargued (Claim 8) |

## 1. $\tau$ commutes with $Q$

**Derivation.** $\tau$ is an automorphism of $\mathfrak{so}(8)$, so it preserves the Killing form, hence the Frobenius inner product on $\Lambda^2\mathbb R^8$, hence is orthogonal. Conjugation $W\mapsto\tau W\tau^{-1}=\tau W\tau^{T}$ is then orthogonal on $\mathrm{Sym}^2(\Lambda^2)$ for the Frobenius inner product and multiplicative: $(\tau W\tau^{-1})^2=\tau W^2\tau^{-1}$. In an orthonormal basis $\#$ is a bilinear expression in the structure constants $c$ of the bracket. $\tau$ maps an orthonormal basis to an orthonormal basis with the same structure constants, so $(\tau W\tau^{-1})^\#=\tau W^\#\tau^{-1}$. Hence $Q(\tau W)=\tau Q(W)$ and $P(\tau W)=P(W)$. By polarisation $\tau(X\circ Y)=\tau X\circ\tau Y$.

No finding: the step is correct, and the item-1 question "in what sense" is answered by the conjugation reading of Section 0.

## 2. $\tau$ preserves $\mathcal W_8$

**Dimensions checked.** $\dim\mathrm{Sym}^2(\Lambda^2\mathbb R^8)=\binom{29}{2}=406$. $\dim\mathcal W_8=n(n+1)(n+2)(n-3)/12=8\cdot9\cdot10\cdot5/12=300$. The complement is $1+35+35+35=106$, and $300+106=406$. At $n=8$, $\Lambda^4\mathbb R^8=35_+\oplus35_-$ under the Hodge star and $S^2_0\mathbb R^8=35_v$.

**Derivation of the inference.** For $X\in\mathfrak{so}(8)$ and $W\in\mathrm{Sym}^2(\Lambda^2)$, $\tau\,[\mathrm{ad}_X,W]\,\tau^{-1}=[\mathrm{ad}_{\tau X},\tau W\tau^{-1}]$. So $\tau$ carries each $\mathfrak{so}(8)$-submodule to an $\mathfrak{so}(8)$-submodule, and the isotypic component of type $\lambda$ to that of the twisted type. $\tau\,\mathrm{Id}\,\tau^{-1}=\mathrm{Id}$ fixes the trivial summand. If the twists of $35_v,35_+,35_-$ are again among these three, the complement is carried to itself (each type occurs once), and orthogonality of $\tau$ then carries its orthogonal complement $\mathcal W_8$ to itself. The inference is valid.

**The finding.**
1. Location: [graded-half.md:266](../findings/graded-half.md#L266), "the complement is $1+35_v+35_++35_-$, whose three $35$s it permutes."
2. Failure exhibited: the passage gives no argument that triality permutes the three $35$s, and no filed source states it. Yokota constructs $\kappa,\pi,\nu$ and Ziller gives $\mathrm{Out}=\mathrm{Sym}(D_4)=S_3$. Neither identifies $35_v,35_\pm$ with the highest weights $2\omega_1,2\omega_3,2\omega_4$ on the three outer nodes, which is what the permutation needs.
3. Charitable reading: this is standard representation theory of $D_4$, and nothing in the passages contradicts it. The reading makes the claim true, but it does not put an argument on file.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved or cited: $S^2_0\mathbb R^8$, $\Lambda^4_+$, $\Lambda^4_-$ are the $\mathfrak{so}(8)$-irreducibles of highest weights $2\omega_1,2\omega_3,2\omega_4$, and triality permutes $\omega_1,\omega_3,\omega_4$. Low severity: the fact is textbook.

## 3. $\mathbb{HP}^2=\tau(S^3\times S^5)$

1. Location: [graded-half.md:266](../findings/graded-half.md#L266), "$\mathbb{HP}^2=\tau(S^3\times S^5)$ with $\tau$ triality".
2. Failure exhibited: this is asserted with no argument. None of the three filed sources states it. [Yokota's notes](../references/yokota-2009-exceptional-lie-groups/notes.md) say in terms that the $S^3\times S^5$ against $\mathbb{HP}^2$ witness "remains the record's own", and [Ziller's README](../references/ziller-2010-lie-groups-symmetric-spaces/README.md) says no such pair is exhibited. The only support on the Lean side is the agreement $\theta^2=56/45$ from two closed forms ([L9.lean:9-13](../lean/HamiltonsCubic/Results/L9.lean#L9)). Those closed forms are not derived in the passages, and agreement of $\theta^2$ cannot fix the sign: $P(-W)=-P(W)$ gives the same $\theta^2$ at $\pm\tau W_{3,5}$.
3. Charitable reading: the identification is standard folklore (triality maps $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ to a conjugate of $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$), and the brief defines both objects as normalised Weyl tensors. The reading does not supply an argument, and it leaves the sign unfixed.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: (i) for the chosen $\tau$, $\tau(\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ is $SO(8)$-conjugate to the isotropy algebra $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ of $\mathbb{HP}^2$; (ii) the normalised Weyl tensor of each space is fixed by its isotropy algebra up to a scalar, so (i) carries one to a multiple of the other; (iii) the scalar is $+1$ in the normalisation the lemma names, equivalently $P(\mathbb{HP}^2)=P(W_{3,5})$ with the orientation for which L24 applies. Item (iii) is the sign of $\theta$ that attack item 5 asks about.

## 4. L27 at $(p,q)=(3,5)$

**Hypotheses.** $p=3\ge3$, $q=5\ge3$, $(3,5)\ne(3,3)$, $n=p+q=8$. All hold, and there is no padding.

**Values.** From L27, $\tfrac12-\mu=\dfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}=\dfrac{1\cdot3-1}{2\cdot2\cdot4}=\dfrac18>0$, so $\mu=\tfrac38$. $\dim E(\tfrac12)=pq=15$. The orbit has $\dim\mathcal O=pq=15$ by L27, consistent with $\dim O(8)-\dim(O(3)\times O(5))=28-13=15$. The other L27 values at $(3,5)$ are $\lambda_3=\tfrac14$, $\lambda_5=\tfrac38$, $+\mu=\tfrac38$, $-\mu=-\tfrac38$ and $0$, all below $\tfrac12$. The largest of them is $\tfrac38$.

No finding: the values are correct and L27's hypotheses hold. The coincidence $\lambda_5=\mu=\tfrac38$ merges two summands into one $\tfrac38$-eigenspace. That leaves $E(\tfrac12)$ unchanged, and L27 claims multiplicity-freeness of summands, not distinctness of eigenvalues.

## 5. Transfer of the orbit tangent and of $E(\tfrac12)$

**Derivation.** Put $W'=\tau W_{3,5}$. By Claim 1, $Q(W')=\tau Q(W_{3,5})=\theta W'$ with the same $\theta$, so $W'$ is critical on the unit sphere ($\tau$ is orthogonal). Also $e'=\tau e$, $L_{e'}=\tau L_e\tau^{-1}$ and $W'^\perp=\tau(W_{3,5}^\perp)$. So $L_{e'}|_{W'^\perp}$ has the same spectrum with $E'(\tfrac12)=\tau E(\tfrac12)$, of dimension $15$.

The orbit tangent at $W$ is $\{[\mathrm{ad}_X,W]:X\in\mathfrak{so}(8)\}$ for $O(8)$ and $SO(8)$ alike, since the two groups share a Lie algebra. By the identity in Claim 2, $\tau\,T_W\mathcal O_W=T_{\tau W}\mathcal O_{\tau W}$. So $E'(\tfrac12)=\tau E(\tfrac12)=\tau T\mathcal O_{W_{3,5}}=T\mathcal O_{W'}$, which is 15-dimensional.

**Reflections.** For $r\in O(8)\setminus SO(8)$, $\tau\,\mathrm{Ad}_r\,\tau^{-1}$ is outer and in general lies outside $\mathrm{Ad}(O(8))$. So $\tau$ need not carry the whole $O(8)$-orbit to an $O(8)$-orbit. The passage claims normality of the inner automorphisms only, and tangents need only that. No finding.

## 6. Strict local maximality transverse to the orbit

**Derivation.** By L24, the Riemannian Hessian at $W'$ is $6\theta(L_{e'}-\tfrac12\mathrm{Id})$ on $W'^\perp$, provided $\theta>0$. By Claims 4 and 5 it vanishes exactly on $T\mathcal O_{W'}$ and is at most $6\theta(\tfrac38-\tfrac12)=-\tfrac34\theta<0$ on the orthogonal complement. So the second variation is negative on the whole tangent space apart from the orbit directions, which is what A literally states.

**What the step needs beyond the Hessian.**
- **$\theta>0$ at the point.** The passages give no sign. $W\mapsto-W$ sends $\theta\mapsto-\theta$ and leaves $e=W/\theta$ unchanged, so L27's spectrum is sign-blind and the conclusion holds at whichever of $\pm W'$ has $P>0$. The other sign is a strict local minimum transverse to the orbit. Whether that sign is "the quaternionic-Kähler operator on $\mathbb{HP}^2$" is item (iii) of Claim 3's debt, and it is recorded there.
- **From second order to a local maximum.** $P$ is $O(8)$-invariant, hence constant on $\mathcal O_{W'}$. A slice through $W'$ transverse to the orbit carries a negative-definite Hessian, and orbit times slice fills a neighbourhood. This is the standard second-derivative test with Morse–Bott, used without statement or citation (unfiled). It gives a local maximum, strict on the slice.

**Verdict: CONFIRMED** at $\tau W_{3,5}$ oriented with $\theta>0$.

## 7. "Nonzero defect" and the counterexample framing

1. Location: [graded-half.md:264](../findings/graded-half.md#L264) and [results.md:140](../results.md#L140), "Testing whether a nonzero defect forces instability answers no", "so nonzero defect does not force instability".
2. Failure exhibited: "defect" is defined nowhere in Passages A or B, and no line of A or B computes or bounds the defect of $\mathbb{HP}^2$. The proof establishes the second-order statement only. The value $2/63$ appears only in Lean as `hp2_defect_nonzero : (2:ℝ)/63 ≠ 0` ([L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean)), which is arithmetic on an underived number. There is also a reason the nonzero defect cannot be inherited through $\tau$. If "defect" is the Bianchi part $\|\mathrm{Alt}(W_-)\|^2$, as the Lean typing suggests, it reads the $\Lambda^4=35_+\oplus35_-$ component, which $\tau$ moves to other $35$s. So triality gives no transfer of the defect, and $\mathbb{HP}^2$ needs its own computation.
3. Charitable reading: the defect is defined elsewhere in the record and computed there. Nothing of that is in the passages or filed for this round, so the reading supplies no argument.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: a definition of the defect and $\mathrm{defect}(\mathbb{HP}^2)\ne0$ at the oriented point of Claim 6. Given that, "defectiveness alone permits a genuine peak" and "eliminating rivals cannot be a stability argument" follow from Claim 6, subject to Claim 8 for "rivals".

## 8. "More than one peak" and "several peaks below the two named ones"

1. Location: [results.md:140](../results.md#L140) heading "The high ground has more than one peak", and [results.md:485](../results.md#L485) "the landscape carries several peaks below the two named ones rather than a single ridge".
2. Failure exhibited: Claim 6 applies equally to $W_{3,5}$ itself (L27 plus L24 with $\theta>0$). A new peak therefore needs $\mathbb{HP}^2\notin\mathcal O_{W_{3,5}}$, and no passage argues that. Claim 5 shows $\tau$ need not respect $O(8)$-orbits, so distinctness does not come for free, and Yokota's notes record the non-conjugacy as the record's own, unsourced. "The two named ones" are not identified in A or B. "Below" needs values, and the only values are Lean arithmetic on underived closed forms ($56/45<21/16<3/2$). "Several" is supported in the passages by at most the one exhibited point.
3. Charitable reading: "the two named ones" are the record's two named families, and the plural counts peaks across $n$. The passages still hold no argument for distinctness or for the ordering.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: $\mathbb{HP}^2$ and $W_{3,5}$ lie in different $O(8)$-orbits (for instance, non-conjugate stabilisers), together with the identity of the two named peaks and exact values placing $\mathbb{HP}^2$ below both.

## 9. The Lean files

**What is typed.** [L9Statement.lean:170-172](../lean/HamiltonsCubic/Results/L9Statement.lean#L170) types `∃ W Wp Wm : W8, IsWeyl W ∧ normSq W = 1 ∧ IsSpectralSplit W Wp Wm ∧ altNormSq Wm ≠ 0 ∧ IsLocalMaxOn Pcubic {R | IsWeyl R ∧ normSq R = 1} W`, closed by `sorry`. The `sorry` is described (lines 37-41) as standing for the existence of the $\mathbb{HP}^2$ operator with nonzero defect as a local maximum. `hess_neg_of_not_half_eigenvector` and `psd_kernel` are proved, but abstractly: nothing identifies the $\tfrac12$-eigenspace with an orbit. The remaining theorems, and all of [L9.lean](../lean/HamiltonsCubic/Results/L9.lean), are rational arithmetic ($\mu(3,5)=3/8$, $3\cdot5=15$, the two $56/45$ closed forms, the inequalities). The file itself says the orbit, the Hessian formula and the triality identification are untyped.

**The finding.**
1. Location: [L9Statement.lean:74-79](../lean/HamiltonsCubic/Results/L9Statement.lean#L74). `IsSpectralSplit` requires `IsLinearOp`, `IsSymmetricOp` (symmetry at skew arguments only), `W X = Wp X - Wm X` for all `X`, positivity at skew `X`, and `Wp (Wm X) = 0` for all `X`. It does **not** require `Wp`, `Wm` to map skew matrices to skew matrices. [WeylReal.lean:115-124](../lean/HamiltonsCubic/Base/WeylReal.lean#L115) calls exactly that clause load-bearing for `IsWeyl`.
2. Failure exhibited, in closed form. Let $W_0$ be any unit element of $\mathcal W_8$ that is a local maximum of $P$ (one exists: a global maximum on the compact unit sphere of the $300$-dimensional coordinate space, by the extreme value theorem and [IsMaxOn.localize](https://github.com/leanprover-community/mathlib4/blob/master/Mathlib/Topology/Order/LocalExtr.lean)). Let $W_0=A_+-A_-$ be its spectral split on $\Lambda^2$. Put $v=\varphi_{12}+\varphi_{34}$, $K=v\otimes v$ and $B_-=A_-+tK$, $B_+=A_++tK$ with $t>0$, both positive semidefinite, $B_+-B_-=W_0$. Fix a linear injection $N:\Lambda^2\to\mathrm{Sym}^2(\mathbb R^8)$ into symmetric matrices ($28\le36$) and define $C$ on $N(\Lambda^2)$ by $C(Na)=-B_+B_-a-NB_-a$, extended by $0$ on a complement. For $X=a+y$ ($a$ skew, $y$ symmetric) set
   - $W_-(X)=B_-a+Na$,
   - $W_+(X)=B_+a+Na+Cy$,
   - $W(X)=W_0a+Cy$.

   Then `W X = Wp X - Wm X` holds for all $X$. Both parts are linear. Symmetry and positivity at skew arguments hold because `inner2 S Y = ½ tr(SᵀY) = 0` for $S$ symmetric and $Y$ skew. And $W_+(W_-X)=B_+B_-a+NB_-a+C(Na)=0$ for every $X$. `IsWeyl W`, `normSq W`, `Pcubic W` and `IsLocalMaxOn` read $W$ only at skew arguments (`phi`, `br` of skew matrices, and `R` of those), where $W=W_0$. `altNormSq Wm` reads only `inner2 (Wm (phi i j)) (phi k l)`, that is $B_-=A_-+tK$. Its bianchi coefficient at $(1,2,3,4)$ gets $K_{1234}+K_{1342}+K_{1423}=v_{12}v_{34}=1$ from $K$, so $t\mapsto$ `altNormSq`$(A_-+tK)$ is a real quadratic with positive leading coefficient. Any $t>0$ other than its at most two roots gives `altNormSq Wm ≠ 0`.
3. Charitable reading: the author intended `Wp`, `Wm` to be bivector-valued, and then `Wp ∘ Wm = 0` would pin the split. The typed proposition is what the `sorry` stands for, however, and as typed its defect clause is vacuous and the whole statement follows from compactness with no reference to $\mathbb{HP}^2$, triality, strictness or the orbit.

**Verdict: REFUTED AS STATED.** The Lean files do not state Lemma L9. They type a proposition that holds at any maximiser of $P$ on the unit sphere of $\mathcal W_8$. They prove none of L9's mathematics.

**Also recorded (docstring slip).** [L9.lean:67](../lean/HamiltonsCubic/Results/L9.lean#L67) says "the gap at `n = 8` is `11/90`" while the theorem on line 68 proves $21/16-56/45=49/720$. The other gap is $3/2-56/45=23/90$. Neither equals $11/90$.

## 10. Edges and scope (standing items 2, 3 and attack items 7, 9)

- **Which $n$.** A and line 485 fix $n=8$, and triality is specific to $D_4$. Line 140 names no dimension (see withdrawn W2).
- **Padded $\mathbb{HP}^2$ at $n>8$.** No claim in A, B or Lean reaches it. Triality does not exist in $\mathfrak{so}(n)$ for $n\ne8$ ([Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md) Ex 4.45), and L27 itself says padding destroys nondegeneracy for sphere products. No finding.
- **$SO(8)$ against $O(8)$.** The orbit tangents coincide (Claim 5). $\tau$ normalises $\mathrm{Int}=\mathrm{Ad}(SO(8))$ but not $\mathrm{Ad}(O(8))$, and the argument uses only the former. No finding for the local claim. The effect on distinctness is Claim 8.
- **Kernels.** $\ker(\text{Hessian})=T\mathcal O=E(\tfrac12)$, of dimension 15 (Claims 4 and 5). $-I\in O(8)$ acts trivially on $\Lambda^2$, so the action has the discrete kernel $\{\pm I\}$ and orbit dimensions are unaffected. Triality lives on $\mathfrak{so}(8)$ and $\mathrm{Spin}(8)$ and does not descend to an automorphism of $SO(8)$. The proof uses it only at the Lie algebra level and on $\mathrm{Int}$. The operator kernel of $\mathbb{HP}^2$ on $\Lambda^2$ is not consumed by the argument. No finding.
- **Strict against non-strict.** A says "strict ... transverse to the orbit". The Lean statement is non-strict, which is the correct shape for a positive-dimensional orbit.

## 11. Falsifiers named and what was done (standing item 7)

| Claim | Falsifying object | Search |
|---|---|---|
| 1 | an automorphism of $\mathfrak{so}(8)$ changing structure constants in an orthonormal basis | ruled out by the Killing-form identity |
| 2 | a $35$ carried into $\mathcal W_8$ by $\tau$ | ruled out by the isotypic argument, conditional on the unfiled weight fact |
| 3 | $\tau W_{3,5}=-\mathbb{HP}^2$, or $\tau W_{3,5}$ a Weyl tensor with a different isotropy algebra | read all three filed sources, and none states the identification. The Lean $\theta^2$ agreement is sign-blind |
| 4 | an L27 eigenvalue $\ge\tfrac12$ off the orbit at $(3,5)$ | every value computed exactly: max $\tfrac38$ |
| 5 | an orbit direction at $\tau W$ outside $\tau T\mathcal O_W$ | ruled out by $\tau[\mathrm{ad}_X,W]\tau^{-1}=[\mathrm{ad}_{\tau X},\tau W\tau^{-1}]$ |
| 6 | $\theta<0$ at the named point, making it a minimum | no sign on file, recorded under Claim 3 |
| 7 | $\mathrm{defect}(\mathbb{HP}^2)=0$ | no definition or value in A or B, and $\tau$ moves the $\Lambda^4$ component, so no transfer |
| 8 | $\mathbb{HP}^2\in\mathcal O_{W_{3,5}}$ | no argument on file either way |
| 9 | a proof of the typed `L9` without $\mathbb{HP}^2$ | exhibited in Section 9 |

### Withdrawn candidates

- **W1, "strict local maximum" at [results.md:140](../results.md#L140) is false literally.** (1) The landscape line says "is a strict local maximum" with no qualifier. (2) Points of the 15-dimensional orbit near $\mathbb{HP}^2$ share its value, so no punctured neighbourhood has $P<P(\mathbb{HP}^2)$. (3) Line 485 glosses the phrase at once ("its second variation is negative on the whole tangent space apart from the directions along its orbit"), and A says "transverse to the orbit". **Withdrawn**: the charitable reading is the record's own gloss.
- **W2, line 140 names no dimension.** (1) [results.md:140](../results.md#L140). (2) Read alone, it could be taken to cover padded $\mathbb{HP}^2$ at $n>8$. (3) It is the landscape summary of line 485, which fixes $n=8$, and triality exists only there. **Withdrawn**: no claim is made at $n>8$.
- **W3, "has to be sensitive to the value" is a non sequitur.** (1) [results.md:485](../results.md#L485). (2) What follows from a defective local maximum is that defect plus local stability cannot exclude it. An exclusion argument could read other data, such as the isotropy type, rather than the value. (3) The sentence is methodological and not a mathematical claim, and "the value" reads naturally as shorthand for global data beyond the defect. **Withdrawn**: no concrete valid exclusion argument insensitive to the value was exhibited, so step 2 fails.
- **W4, the binding gap is not $\tfrac12-\mu$.** (1) A cites only $\tfrac12-\mu=\tfrac18$. (2) $\lambda_5=\tfrac38$ is also a non-orbit eigenvalue. (3) $\lambda_5=\mu$ at $(3,5)$, so the gap is $\tfrac18$ either way. **Withdrawn**: step 2 fails.

## Overall verdict

**HYPOTHESIS-DEBT.** The triality chain is correct algebra, and so are L27's values at $(3,5)$, the transfer of the orbit tangent and the $\tfrac12$-eigenspace, and the Hessian conclusion at $\tau W_{3,5}$ oriented with $\theta>0$. The debts are these:
1. The identification $\mathbb{HP}^2=\tau(S^3\times S^5)$ with its sign.
2. The permutation of the three $35$s, standard but unfiled.
3. The nonzero defect of $\mathbb{HP}^2$.
4. The distinctness of the peak from the $S^3\times S^5$ orbit, and the ordering below "the two named ones".

Separately, the Lean statement is REFUTED AS STATED: its defect clause is vacuous and the typed proposition follows from compactness alone.
