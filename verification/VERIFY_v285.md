# Verifier v285, triality image of the $S^3\times S^5$ Weyl tensor as a strict transverse peak at $n=8$, and two peaks in distinct orbits

Cold brief ([BRIEF_L09_repair.md](BRIEF_L09_repair.md)), read in full. No numerical work was done, every value below is exact, and no script was written or run. The quotation was checked against [findings/graded-half.md](../findings/graded-half.md) lines 264 and 266 only, and it matches verbatim. Log: agent_logs/verify-L09-v285.log.

| # | Claim | Verdict |
|---|---|---|
| 1 | Every automorphism $\tau$ of $\mathfrak{so}(8)$ is orthogonal, preserves $Q$ and $P$, and its conjugation preserves $\mathcal W_8$ | CONFIRMED |
| 2 | $\tau W_{3,5}$ is a unit critical point with $\theta=\sqrt{56/45}>0$ | CONFIRMED |
| 3 | The Hessian at $\tau W_{3,5}$ is negative definite transverse to its orbit and zero along it | CONFIRMED |
| 4 | L3's step from Hessian to strict transverse local maximum applies at $\tau W_{3,5}$ | CONFIRMED |
| 5 | $W^*$ and $\tau W_{3,5}$ are strict transverse local maxima in distinct $O(8)$-orbits | CONFIRMED |
| 6 | Scope, and the $\mathbb{HP}^2$ identification stated as a debt and left unused | CONFIRMED |

**Summary: every link of the chain follows from the givens and from correctly stated classical facts, so the lemma is PROVEN. Six candidates were raised and all six withdrawn, two of them leaving editorial notes.**

## 0. Conventions, fixed once

- $\mathcal W_8\subset\mathrm{Sym}^2(\Lambda^2\mathbb R^8)$, symmetric operators on $\Lambda^2\mathbb R^8\cong\mathfrak{so}(8)$, Frobenius inner product. $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, critical on the unit sphere $\Sigma$ means $Q(W)=\theta W$, $e=W/\theta$, $L_e=e\circ(\cdot)$.
- For an automorphism $\tau$ of $\mathfrak{so}(8)$, $C_\tau S=\tau S\tau^{-1}$ on $\mathrm{Sym}^2(\Lambda^2\mathbb R^8)$.
- $g\in O(8)$ acts on $\Lambda^2\mathbb R^8$ by $\mathrm{Ad}_g$ and on $\mathcal W_8$ by $C_{\mathrm{Ad}_g}$. Its infinitesimal action is $X\cdot S=[\mathrm{ad}_X,S]$.
- $\theta_{k,l}$ is Nienhaus's value (Passage E). $\theta_0(8)=\theta_{4,4}$.
- Representation labels: $8_v,8_s,8_c$ with highest weights $\omega_1,\omega_3,\omega_4$ of $D_4$. $35_x=S^2_0(8_x)$ has highest weight $2\omega_x$. $\mathcal W_8$ has highest weight $2\omega_2$.

## Hypothesis inventory

| Source | Hypothesis | Used where | Holds? |
|---|---|---|---|
| Statement | $n=8$ | throughout | yes |
| Statement | $W_{3,5}$ unit, $P(W_{3,5})>0$ | sign of Hessian, value of $\theta$ | yes, fixes the sign choice |
| Statement | $\tau$ a triality automorphism of $\mathfrak{so}(8)$ | Claim 1 | the proof uses only that $\tau$ is a Lie algebra automorphism |
| L24 | $W$ critical, $\theta=P(W)>0$ | Claim 3 at $\tau W_{3,5}$ | yes, by Claim 2 |
| L24 | $L_e$ self-adjoint, $W^\perp$ invariant | Claim 3, splitting $W^\perp$ into $E(\tfrac12)$ and its complement | part of the given |
| L27 | $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$ | at $(3,5)$, $n=8$ | yes |
| L3 (statement) | even $n\ge8$ | $W^*$ at $n=8$ | yes |
| L3 (step) | critical, $\theta>0$, $O(n)$-invariance of $P$, compact orbit, negative definite Hessian on the normal space | Claim 4 | yes at $\tau W_{3,5}$, see §4 |
| Nienhaus 2.25 | $S_{k,l}$ with $k+l=n$ | $(3,5)$ and $(4,4)$ at $n=8$ | yes |
| Classical | every automorphism of simple $\mathfrak{so}(8)$ preserves its invariant inner product | Claim 1 | correct, one line from invariance of the Killing form and uniqueness of the invariant form up to scale. No filed source read carries it |
| Classical | $\mathrm{Out}(\mathfrak{so}(8))=S_3$ permutes $8_v,8_s,8_c$ | Claim 1 | correct. [Yokota](../references/yokota-2009-exceptional-lie-groups/notes.md) Theorems 1.3.5 and 1.3.6 carry the $S_3$ of automorphisms and infinitesimal triality, [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md) carries the $S_3$ diagram symmetry. Neither states the permutation of the three representations in those words |
| Classical | $\mathrm{Sym}^2(\Lambda^2\mathbb R^8)=\mathcal W_8\oplus\mathbf 1\oplus35_v\oplus35_s\oplus35_c$ under $SO(8)$, $35_s\oplus35_c=\Lambda^4_+\oplus\Lambda^4_-$, $35_x\cong S^2_0(8_x)$ | Claim 1 | correct: $406=300+1+35+70$, $\dim\mathcal W_8=\tfrac{64\cdot63}{12}-36=300$. No filed source carries it |
| Used, unstated | multiplicity one of each summand, and that $C_\tau$ intertwines the $\mathfrak{so}(8)$-actions up to $\tau$ | Claim 1 | both on the page, see §1.2 candidate (c) |

## 1. Claim 1, $\tau$ preserves $Q$, $P$ and $\mathcal W_8$

### 1.1 Derivation checked

1. $\tau$ preserves the Killing form $B$, since $\mathrm{ad}_{\tau X}=\tau\,\mathrm{ad}_X\tau^{-1}$ gives $B(\tau X,\tau Y)=\mathrm{tr}(\tau\,\mathrm{ad}_X\mathrm{ad}_Y\tau^{-1})=B(X,Y)$. The inner product on $\Lambda^2\mathbb R^8$ is $O(8)$-invariant, hence $\mathrm{ad}$-invariant, hence a multiple of $B$ on the simple algebra. So $\tau$ is orthogonal, as the proof asserts.
2. $C_\tau$ is then orthogonal on $\mathrm{Sym}^2(\Lambda^2\mathbb R^8)$ and maps symmetric operators to symmetric ones. $(C_\tau W)^2=C_\tau(W^2)$ trivially. $W^\#$ is built from the structure constants in an orthonormal basis, and $\tau$ carries an orthonormal basis to one with the same structure constants, so $(C_\tau W)^\#=C_\tau(W^\#)$. Hence $Q\circ C_\tau=C_\tau\circ Q$ and $P\circ C_\tau=P$. The proof's first sentence is correct.
3. From $\tau[X,Y]=[\tau X,\tau Y]$, $C_\tau([\mathrm{ad}_X,S])=[\mathrm{ad}_{\tau X},C_\tau S]$. So $C_\tau$ maps an $\mathfrak{so}(8)$-submodule of type $\lambda$ onto a submodule of the type obtained by twisting with $\tau$.
4. The five summands are pairwise non-isomorphic: $300$ and $1$ by dimension, the three $35$s by highest weights $2\omega_1,2\omega_3,2\omega_4$. Each is therefore its own isotypic component, and $C_\tau$ permutes the isotypic components. Twisting by $\tau$ permutes $\{\omega_1,\omega_3,\omega_4\}$, so it permutes the three $35$s. $C_\tau\mathrm{Id}=\mathrm{Id}$ fixes $\mathbf 1$.
5. The sum $\mathbf 1\oplus35_v\oplus35_s\oplus35_c$ is $C_\tau$-stable, the decomposition is orthogonal (distinct isotypic components of an orthogonal representation), $\mathcal W_8$ is its orthogonal complement, and $C_\tau$ is orthogonal. So $C_\tau\mathcal W_8=\mathcal W_8$.

Every step matches the written proof. The route is sound at every automorphism, triality or not.

### 1.2 Candidates

**(a) Orthogonality of $\tau$ asserted without argument.** Located: "$\tau$ is an orthogonal automorphism of $\mathfrak{so}(8)$: it preserves the bracket and the inner product". Failure exhibited: none of the filed sources read states it. Charitable reading: it is a classical one-line consequence of Killing-form invariance (§1.1 step 1), which the brief admits as classical. **Withdrawn**, the step is correct.

**(c) "Permutes the representations, hence the three summands" skips multiplicity one and intertwining.** Located: "Triality permutes the three eight-dimensional representations $8_v,8_s,8_c$, hence the three summands $35_x=S^2_0(8_x)$". Failure exhibited: were some $35$ to occur twice, "the summand $35_x$" would not be a canonical subspace and a twisted image could land in a different copy. Charitable reading: the displayed decomposition carries distinct labels, so it is multiplicity-free, and the intertwining identity $\tau\,\mathrm{ad}_X\tau^{-1}=\mathrm{ad}_{\tau X}$ is written two sentences later in the same proof. **Withdrawn**.

### 1.3 Withdrawn candidates for this claim

(a) and (c) above.

No finding on Claim 1.

## 2. Claim 2, criticality and $\theta$

### 2.1 Derivation checked

- Unit: $C_\tau$ is orthogonal, so $\|C_\tau W_{3,5}\|=1$.
- Critical: $Q(C_\tau W_{3,5})=C_\tau Q(W_{3,5})=\theta\,C_\tau W_{3,5}$, and $C_\tau W_{3,5}\in\mathcal W_8$ by Claim 1.
- Value: $P(C_\tau W_{3,5})=P(W_{3,5})$. Nienhaus 2.25 at $k=3$, $l=5$, $n=8$ gives $W^2+W^\#=\theta_{3,5}W$ and $P=\theta_{3,5}>0$. Since $P(W)=\theta$ with $Q(W)=\theta W$ forces $\|W\|=1$, Nienhaus's tensor is unit with positive $P$, which is the statement's $W_{3,5}$.
- Arithmetic: $\tfrac23\cdot\tfrac45\cdot\tfrac76=\tfrac{56}{90}=\tfrac{28}{45}$, times $2$ is $\tfrac{56}{45}$. So $\theta_{3,5}=\sqrt2\sqrt{28/45}=\sqrt{56/45}>0$. Correct.

### 2.2 Candidates

**(d) "The unit Weyl tensor of $S^3\times S^5$" leaves the radii free.** Located: statement, "$W_{3,5}$ be the unit Weyl tensor of $S^3\times S^5$". Failure exhibited: the curvature operator of $S^3(a)\times S^5(b)$ depends on $(a^{-2},b^{-2})$. Charitable reading: the Weyl part is linear in the two curvatures and vanishes on the conformally flat product of opposite curvatures, so its image is a line, and the unit tensor is fixed up to sign by the splitting and the sign by $P>0$. The statement names Nienhaus's object. **Withdrawn**.

No finding on Claim 2.

## 3. Claim 3, the Hessian transfer

### 3.1 Derivation checked

1. L27 at $(3,5)$: hypotheses hold. $\tfrac12-\mu=\tfrac{(1)(3)-1}{2\cdot2\cdot4}=\tfrac18$, correct. $\dim E(\tfrac12)=pq=15$, and $\dim O(8)/(O(3)\times O(5))=28-3-10=15$, correct. So on $W_{3,5}^\perp$ the value $\tfrac12$ is attained exactly on the orbit tangent and every other eigenvalue is below $\tfrac12$.
2. $\circ$ is built from $Q$, so $C_\tau(X\circ Y)=C_\tau X\circ C_\tau Y$. $C_\tau$ commutes with the orthogonal projection onto $\mathcal W_8$ (it preserves $\mathcal W_8$ and is orthogonal), so whichever of the full product or its compression L24 means, $L_{C_\tau e}=C_\tau L_eC_\tau^{-1}$ on $\mathcal W_8$. And $C_\tau e=C_\tau W_{3,5}/\theta$, the $e$ of $\tau W_{3,5}$ with the same $\theta$.
3. $C_\tau$ maps $W_{3,5}^\perp$ onto $(C_\tau W_{3,5})^\perp$ and the orbit tangent $\{[\mathrm{ad}_X,W_{3,5}]\}$ onto $\{[\mathrm{ad}_{\tau X},C_\tau W_{3,5}]\}$, which is the full orbit tangent at $C_\tau W_{3,5}$ since $\tau$ is onto $\mathfrak{so}(8)$. The $O(8)$- and $SO(8)$-orbits have the same tangent.
4. So $L_{C_\tau e}$ on $(C_\tau W_{3,5})^\perp$ has eigenvalue $\tfrac12$ exactly on the orbit tangent and values below $\tfrac12$ on its orthogonal complement $N$, which is invariant by self-adjointness (L24).
5. L24 at $C_\tau W_{3,5}$ (critical, $\theta>0$) gives Hessian $6\theta(L_{C_\tau e}-\tfrac12)$: zero on the orbit tangent, negative definite on $N$.

The written proof states steps 1, 3 and 5 and the operator conjugation of step 2. Correct.

No finding on Claim 3.

## 4. Claim 4, L3's step applies

### 4.1 Derivation checked

L3's step ([findings/second-order.md](../findings/second-order.md), "From the Hessian to a local maximum") uses: compactness of the orbit and $P\equiv\theta$ on it (invariance); the normal tubular neighbourhood; $df(0)=0$ (criticality); $d^2f(0)$ the Hessian on $N$; a Taylor bound with a positive quadratic coefficient; transport of that bound along the orbit by isometries fixing $P$; a radius below which the right side is below $\theta$. Each holds at $C_\tau W_{3,5}$ with its $O(8)$-orbit, a compact orbit of the same isometric action. Nothing uses the balanced product except the constant, treated below.

### 4.2 Candidates

**(b) The constant $3\theta/(n-2)$ in L3's displayed inequality is false at $\tau W_{3,5}$.** Located: L3's step writes $f(v)\le\theta-\frac{3\theta}{n-2}\lvert v\rvert^2+K\lvert v\rvert^3$ and $\rho'=\min(\rho/2,\,3\theta/((n-2)K))$, and the proof under audit says the step "applies unchanged". Failure exhibited: from L27's values at $(3,5)$, off the orbit tangent in $W^\perp$ the eigenvalues are $\lambda_3=\tfrac14$, $\lambda_5=\tfrac38$, $\mu=\tfrac38$, $-\mu=-\tfrac38$, $0$, so the transverse Hessian bound is $6\theta(\tfrac38-\tfrac12)=-\tfrac34\theta$, attained on $S^2_0(\mathbb R^5)$. L3's $-\tfrac{6\theta}{n-2}$ at $n=8$ is $-\theta$, which does not hold. Charitable reading: the proof names what the step uses, "criticality, $\theta>0$, $O(8)$-invariance and that Hessian", the Hessian at the new point. The constant enters L3's step only as a positive lower bound on $-\tfrac12\mathrm{Hess}$ over $N$, and the same lines run with $\tfrac38\theta$ (or any positive bound, which negative definiteness on finite-dimensional $N$ supplies). **Withdrawn**. Editorial note: "unchanged" reads more accurately as "with the transverse bound $-\tfrac34\theta$ in place of $-\tfrac{6\theta}{n-2}$".

No finding on Claim 4.

## 5. Claim 5, two peaks in distinct orbits

### 5.1 Derivation checked

- $W^*$ at $n=8$ is covered by L3 (even $n\ge8$).
- $\tau W_{3,5}$ is covered by Claims 1 to 4.
- Values: $\theta_{4,4}^2=2\cdot\tfrac34\cdot\tfrac34\cdot\tfrac76=\tfrac{126}{96}=\tfrac{21}{16}$, and $\theta_{3,5}^2=\tfrac{56}{45}$. $56\cdot16=896\ne945=21\cdot45$, both $\theta$ positive, so $P(W^*)\ne P(\tau W_{3,5})$. $P$ is constant on $O(8)$-orbits, so the orbits are distinct. Correct.

### 5.2 Candidates

**(e) $\theta_0(8)^2=\tfrac{21}{16}$ is cited to L3, whose quoted statement does not contain it.** Located: "at $\theta_0(8)^2=\tfrac{21}{16}$ ([Lemma L3](second-order.md))". Failure exhibited: Passage B's statement carries no value of $\theta$. Charitable reading: L3's proof on file writes $\theta=\theta_{m,m}=\sqrt2\,\tfrac{m-1}m\sqrt{\tfrac{n-1}{n-2}}$ from Nienhaus 2.25, which at $m=4$ is $\tfrac{21}{16}$ squared. **Withdrawn**.

No finding on Claim 5.

## 6. Claim 6, scope and the owed identification

### 6.1 Checked

- The proof uses nothing about $\mathbb{HP}^2$. The statement's italic sentence says the identification "with its sign, is owed". It is a debt stated as a debt.
- Scope of $\tau$: the proof holds for every automorphism of $\mathfrak{so}(8)$. For inner $\tau$, and for the outer class realised by $O(8)$ (Yokota's $\kappa$), $\tau W_{3,5}$ lies in the $O(8)$-orbit of $W_{3,5}$, and the conclusion is then L27 plus L24 plus L3's step at $W_{3,5}$ itself. The statement does not claim $\tau W_{3,5}\notin O(8)\cdot W_{3,5}$ for the order-3 classes, and the proof does not show it.
- "At least two peaks" counts $W^*$ and $\tau W_{3,5}$. The count is met, and it would be met by $W_{3,5}$ in place of $\tau W_{3,5}$. The triality image adds a peak beyond $W_{3,5}$'s orbit only through the owed separation, which the statement does not use.

### 6.2 Candidates

**(f) "The two sharing $\theta^2=\tfrac{56}{45}$" asserts a value for $\mathbb{HP}^2$ with no argument on file.** Located: "*The record identifies $\tau W_{3,5}$ with the quaternionic-Kähler Weyl tensor of $\mathbb{HP}^2$, the two sharing $\theta^2=\tfrac{56}{45}$. That identification, with its sign, is owed.*" Failure exhibited: nothing in the brief supplies $\theta$ for the $\mathbb{HP}^2$ Weyl tensor. Charitable reading: the sentence reports the record's identification and flags it owed, and no conclusion of the lemma rests on it. **Withdrawn**. Editorial note: the $\mathbb{HP}^2$ value is part of what is owed, and the sentence could say so.

No finding on Claim 6.

## Fixed-list answers

1. **Hypothesis inventory.** Table above. Used but unstated: multiplicity one and the intertwining property of $C_\tau$, both recoverable from the page (candidate (c), withdrawn). No hypothesis of a given fails where applied.
2. **Quantifier order and scope.** $n=8$ fixed. For each automorphism $\tau$ (the proof needs no more than an automorphism), the point $C_\tau W_{3,5}$ with $W_{3,5}$ the positive-$P$ unit tensor. Strict means $P<\theta$ on $U\setminus\mathcal O$ for a neighbourhood $U$ in $\Sigma$ of the $O(8)$-orbit $\mathcal O$ of $C_\tau W_{3,5}$. No finding.
3. **Edges.** $SO(8)$ against $O(8)$: the five-summand decomposition is the $SO(8)$ one, under $O(8)$ the two spinor $35$s merge into $\Lambda^4$, and the complement argument uses only their sum, so it holds either way. Orbit tangents agree. Sign of $\theta$: $C_\tau$ preserves $P$, so $\theta>0$ transfers, and $e$ is sign-blind so the Hessian's sign rests on $\theta$, which the statement fixes. Distinct values: $\tfrac{56}{45}<\tfrac{21}{16}$ exactly. No finding.
4. **Proven against stated.** The proof delivers exactly the statement. The only mismatch is wording, "unchanged" for a constant that changes (candidate (b), withdrawn). No finding.
5. **Brief's attack items.** (1) §1, CONFIRMED. (2) §2, CONFIRMED, arithmetic checked. (3) §3, CONFIRMED. (4) §4, CONFIRMED, the step uses the balanced product only through its constant. (5) §5, CONFIRMED. (6) §6, CONFIRMED, the $\mathbb{HP}^2$ identification is stated as a debt and unused.
6. **Falsifying objects and what was done.** Claim 1: a $W\in\mathcal W_8$ with $C_\tau W$ having a component in $\mathbf 1\oplus35_v\oplus35_s\oplus35_c$. Looked for via isotypic types, none possible since $300$ is the only summand of its type. Claim 2: a nonzero component of $Q(C_\tau W_{3,5})$ orthogonal to $C_\tau W_{3,5}$. Excluded by $Q\circ C_\tau=C_\tau\circ Q$. Claim 3: a vector in $N$ with $L_{C_\tau e}$-value at least $\tfrac12$. Its $C_\tau^{-1}$-image would contradict L27. Claim 4: a point of $U\setminus\mathcal O$ with $P\ge\theta$. The Taylor bound with constant $\tfrac38\theta$ excludes it (candidate (b)). Claim 5: $g\in O(8)$ with $C_{\mathrm{Ad}_g}W^*=C_\tau W_{3,5}$. Excluded by $\tfrac{21}{16}\ne\tfrac{56}{45}$. Claim 6: any use of $\mathbb{HP}^2$ in the proof. The proof was read line by line and none was found.

## Withdrawn candidates

| Candidate | Location | Reason withdrawn |
|---|---|---|
| (a) orthogonality of $\tau$ unargued | proof, sentence 1 | classical one-liner, correct |
| (b) L3's constant $-6\theta/(n-2)$ fails at $\tau W_{3,5}$ ($-\tfrac34\theta$ is the true bound) | L3's step, "applies unchanged" | the step uses only a positive bound, which the Hessian at the new point supplies. Editorial note left |
| (c) multiplicity one and intertwining unstated | proof, "hence the three summands" | distinct labels displayed, intertwining identity stated in the same proof |
| (d) radii of $S^3\times S^5$ unspecified | statement | unit Weyl tensor independent of radii up to sign |
| (e) $\tfrac{21}{16}$ cited to L3's statement | statement | L3's proof on file carries $\theta_{m,m}$ |
| (f) $\mathbb{HP}^2$ value asserted | statement, italic sentence | flagged owed and unused. Editorial note left |

## Overall verdict

**PROVEN.**
