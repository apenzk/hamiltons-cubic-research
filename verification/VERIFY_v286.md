# Verifier v286, tau preserving W_8, the criticality and theta^2 = 56/45 of tau W_{3,5}, the Hessian transfer, L3's local-maximum step, and the two peaks at n = 8

The brief ([BRIEF_L09_repair.md](BRIEF_L09_repair.md)) was read cold. No numerical work was done and no scripts were written or run. Every value below is exact rational arithmetic done by hand. Log: [agent_logs/verify-L09-v286.log](../agent_logs/verify-L09-v286.log). The quotation was checked against [findings/graded-half.md:264](../findings/graded-half.md#L264) and [findings/graded-half.md:266](../findings/graded-half.md#L266) only, and it matches the brief verbatim.

| # | Claim (brief's attack item) | Verdict |
|---|---|---|
| 1 | $\tau$ preserves $\mathcal W_8$ (decomposition, $35_x=S^2_0(8_x)$, permutation, complement) | CONFIRMED |
| 2 | $\tau W_{3,5}$ is a unit critical point with $P=\theta_{3,5}=\sqrt{56/45}>0$ | CONFIRMED |
| 3 | L27 at $(3,5)$, $L_e\mapsto L_{\tau e}$, orbit tangent to orbit tangent, the Hessian at $\tau W_{3,5}$ | CONFIRMED |
| 4 | L3's Hessian-to-maximum step applies at $\tau W_{3,5}$ | CONFIRMED |
| 5 | At least two peaks, in distinct $O(8)$-orbits | CONFIRMED |
| 6 | Scope, and the $\mathbb{HP}^2$ identification stated as a debt and unused | CONFIRMED |

**Summary.** Every link of the repaired proof follows from the one above it, the givens and correctly stated classical facts. Five candidates were raised and all five were withdrawn at the discrepancy protocol. **Overall verdict: PROVEN.**

## 0. Conventions, fixed once

- $\mathfrak g=\mathfrak{so}(8)=\Lambda^2\mathbb R^8$ with an $\mathrm{Ad}$-invariant inner product $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$. $\mathrm{Sym}^2(\mathfrak g)$ is the space of symmetric operators on $\mathfrak g$ with the Frobenius inner product.
- $\tau$ is a Lie algebra automorphism of $\mathfrak g$ in a triality class. $\hat\tau(S)=\tau S\tau^{-1}$ on $\mathrm{Sym}^2(\mathfrak g)$.
- The infinitesimal $\mathfrak{so}(8)$-action on $\mathrm{Sym}^2(\mathfrak g)$ is $\rho(X)S=[\mathrm{ad}_X,S]$. The $O(8)$-action is $g\cdot S=\mathrm{Ad}_gS\mathrm{Ad}_g^{-1}$.
- $W=W_{3,5}$ is the unit Weyl tensor of $S^3\times S^5$ with $P(W)>0$, $\theta=P(W)$, $e=W/\theta$, $W'=\hat\tau W$, $e'=\hat\tau e$.
- $\Sigma$ is the unit sphere of $\mathcal W_8$. $\mathcal O_X=O(8)\cdot X$ and $N_X$ is the orthogonal complement of $T_X\mathcal O_X$ in $T_X\Sigma=X^\perp\cap\mathcal W_8$.
- $Q(S)=S^2+S^\#$ with $S^\#=S\#S$, $R\#S(v,w)=-\tfrac12\operatorname{tr}(\mathrm{ad}_v R\,\mathrm{ad}_w S)$ ([Nienhaus, Definition 2.11](https://arxiv.org/abs/2311.02404), extraction L1060). $X\circ Y$ is the polarisation of $Q$.

## Hypothesis inventory

| Item | Hypothesis | Where the proof uses it | Holds? |
|---|---|---|---|
| Statement | $n=8$ | throughout | fixed |
| Statement | $W_{3,5}$ unit, $P(W_{3,5})>0$ | sign of $\theta$, negative definiteness | yes, by Nienhaus 2.25 |
| Statement | $\tau$ a triality automorphism acting by conjugation | every step | used only as an element of $\mathrm{Aut}(\mathfrak g)$ |
| L3 | $n$ even, $n\ge8$ | $W^*$ is a strict transverse maximum at $n=8$ | yes |
| L3's step | critical point, $\theta>0$, $O(n)$-invariance, negative definite transverse Hessian, compact orbit | transferred to $W'$ | yes, see Section 4 |
| L24 | $W$ critical on the unit sphere of $\mathcal W_n$, $\theta=P(W)>0$ | Hessian formula $6\theta(L_{e'}-\tfrac12)$ at $W'$ | yes, by Section 2 |
| L27 | $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$ | $(p,q)=(3,5)$, $n=8$ | yes |
| Nienhaus 2.25 | $k+l=n$, $S_{k,l}=S^k\times S^l_r$, $W_{S_{k,l}}$ normalised | $(k,l)=(3,5)$ | yes, normalisation at extraction L1443–1450 |
| Classical C1 | an automorphism of $\mathfrak{so}(8)$ preserves the Killing form $6\operatorname{tr}(XY)$, hence is orthogonal | "$\tau$ is an orthogonal automorphism" | correct, asserted without reason, not located in a filed note |
| Classical C2 | $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)=\langle\mathrm{Id}\rangle\oplus S^2_0(\mathbb R^n)\oplus\mathrm{Weyl}_n\oplus\Lambda^4(\mathbb R^n)$, invariant, orthogonal | the coarse form of the display | correct, filed: [Nienhaus, Proposition 2.9](https://arxiv.org/abs/2311.02404), extraction L969 |
| Classical C3 | $\Lambda^4\mathbb R^8=\Lambda^4_+\oplus\Lambda^4_-$ as $\mathfrak{so}(8)$-modules with $\Lambda^4_\pm\cong S^2_0(8_s),S^2_0(8_c)$ | the labels $35_s,35_c$ | correct, no filed source |
| Classical C4 | triality permutes $8_v,8_s,8_c$ | the permutation of the $35_x$ | correct. Filed: existence and $S_3$ ([Yokota, Theorem 1.3.5](../references/yokota-2009-exceptional-lie-groups/notes.md)), $\mathrm{Sym}(D_4)=S_3$ ([Ziller, Proposition 4.43, Example 4.45](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md)), the three 8-dimensional irreps inequivalent with outer equivalence promised ([Ziller extraction L5052](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf)). The permutation itself is printed in no filed source |
| Classical C5 | $\tau\,\mathrm{ad}_X\tau^{-1}=\mathrm{ad}_{\tau X}$ | orbit tangents, and implicitly the permutation of summands | stated in the proof, immediate from $\tau[X,Y]=[\tau X,\tau Y]$ |
| Classical C6 | orbits of a compact Lie group are compact embedded submanifolds, tubular neighbourhood theorem | L3's step at $W'$ | correct, stated inside L3's proof |
| Used, unstated | the display is multiplicity-free, $35_v,35_s,35_c$ pairwise non-isomorphic | "hence the three summands" | correct, highest weights $2\omega_1,2\omega_3,2\omega_4$ distinct (Section 1) |
| Used, unstated | $\hat\tau$ commutes with the orthogonal projection onto $\mathcal W_8$ | $L_e$ read as an operator on $\mathcal W_8$ | correct, $\hat\tau$ orthogonal and $\hat\tau\mathcal W_8=\mathcal W_8$ |

## 1. $\tau$ preserves $\mathcal W_8$ (brief item 1): CONFIRMED

**The written chain.** (a) $\tau$ preserves the bracket and inner product. (b) Triality permutes $8_v,8_s,8_c$, hence the three $35_x=S^2_0(8_x)$ in the display. (c) It fixes the trivial summand. (d) Being orthogonal, it preserves the complement of their sum, which is $\mathcal W_8$.

**Link (a).** Every automorphism of a semisimple Lie algebra preserves the Killing form $B(X,Y)=\operatorname{tr}(\mathrm{ad}_X\mathrm{ad}_Y)$, since $\mathrm{ad}_{\tau X}=\tau\mathrm{ad}_X\tau^{-1}$. On $\mathfrak{so}(8)$, $B(X,Y)=(n-2)\operatorname{tr}(XY)=6\operatorname{tr}(XY)=-12\langle X,Y\rangle$, so $\tau$ is orthogonal. Then $\hat\tau$ is orthogonal for Frobenius, $\langle\tau S\tau^{-1},\tau T\tau^{-1}\rangle=\operatorname{tr}(\tau ST\tau^{-1})=\langle S,T\rangle$ with $\tau^{-1}=\tau^{\mathsf T}$, and $\hat\tau$ sends symmetric operators to symmetric operators.

**The display.** Dimensions: $\dim\mathrm{Sym}^2(\Lambda^2\mathbb R^8)=\tfrac{28\cdot29}2=406$. $\dim\mathcal W_8=\tfrac{n^2(n^2-1)}{12}-\tfrac{n(n+1)}2=336-36=300$. $\dim\Lambda^4\mathbb R^8=70=35+35$. $\dim S^2_0(\mathbb R^8)=35$. So $406=300+1+35+70$, matching $300+1+3\cdot35$. C2 (filed, Nienhaus 2.9) gives the coarse decomposition. C3 refines $\Lambda^4\mathbb R^8$ under $\mathfrak{so}(8)$: $S^2(8_s)=1\oplus\Lambda^4_+$ and $S^2(8_c)=1\oplus\Lambda^4_-$ ($36=1+35$), while $S^2_0(8_v)=S^2_0(\mathbb R^8)$. The highest weights are $2\omega_1$ ($35_v$), $2\omega_3,2\omega_4$ ($35_s,35_c$), $2\omega_2$ ($\mathcal W_8$) and $0$, where $\omega_2$ labels the central node of $D_4$. All five are distinct, so the display is multiplicity-free. The statement is correct and is used as an $\mathfrak{so}(8)$-decomposition. Under $O(8)$ the two summands $35_s,35_c$ are swapped, which leaves their sum invariant and plays no role here.

**Link (b).** $\hat\tau\rho(X)\hat\tau^{-1}=\rho(\tau X)$, because $\tau[\mathrm{ad}_X,S]\tau^{-1}=[\tau\mathrm{ad}_X\tau^{-1},\tau S\tau^{-1}]=[\mathrm{ad}_{\tau X},\hat\tau S]$ by C5. So $\hat\tau$ carries each $\mathfrak g$-submodule $V$ onto a submodule isomorphic to $V$ twisted by $\tau^{-1}$. The twist of $S^2_0(8_x)$ is $S^2_0$ of the twisted $8_x$, which by C4 is $S^2_0(8_{\sigma x})$ for the permutation $\sigma$ induced by $\tau$. By multiplicity-freeness the image is the summand $35_{\sigma x}$. The same twist fixes $\mathcal W_8$, since $2\omega_2$ is fixed by $S_3$, and this confirms (d) independently.

**Link (c).** The trivial summand is $\langle\mathrm{Id}\rangle$, and $\hat\tau\,\mathrm{Id}=\mathrm{Id}$.

**Link (d).** The summands are pairwise non-isomorphic irreducibles under an invariant inner product, so the display is orthogonal and $\mathcal W_8=(\mathbf 1\oplus35_v\oplus35_s\oplus35_c)^\perp$. By (b) and (c), $\hat\tau$ maps $V=\mathbf 1\oplus35_v\oplus35_s\oplus35_c$ onto itself. An orthogonal bijection preserving $V$ preserves $V^\perp$. So $\hat\tau\mathcal W_8=\mathcal W_8$.

**Filed coverage.** C2 is filed (Nienhaus 2.9). C3, and C4 in the form "triality permutes $8_v,8_s,8_c$", are carried by no filed source. Yokota prints existence and $S_3$ and Ziller prints the inequivalence and promises the outer equivalence. The brief classes C3 and C4 as classical. Both are correctly stated and correctly used. This is recorded as a citation note, not a defect of the chain.

## 2. Criticality and $\theta$ (brief item 2): CONFIRMED

**$\hat\tau$ commutes with $Q$.** $(\hat\tau S)^2=\tau S^2\tau^{-1}=\hat\tau(S^2)$. For $\#$, with $v'=\tau v$, $w'=\tau w$:
$$(\hat\tau R)\#(\hat\tau S)(v',w')=-\tfrac12\operatorname{tr}\big(\mathrm{ad}_{\tau v}\,\tau R\tau^{-1}\,\mathrm{ad}_{\tau w}\,\tau S\tau^{-1}\big)=-\tfrac12\operatorname{tr}\big(\tau\,\mathrm{ad}_vR\,\mathrm{ad}_wS\,\tau^{-1}\big)=R\#S(v,w).$$
Read as operators through the orthogonal $\tau$, this is $(\hat\tau R)\#(\hat\tau S)=\hat\tau(R\#S)$. So $Q\hat\tau=\hat\tau Q$, and $P(\hat\tau S)=\langle\hat\tau S,\hat\tau Q(S)\rangle=P(S)$.

**Criticality.** Nienhaus 2.25 gives $Q(W)=\theta W$ exactly, with $P(W)=\theta$ and $W$ normalised (extraction L1443–1450), so $\|W\|=1$. Then $Q(W')=\hat\tau Q(W)=\theta W'$, $\|W'\|=1$, and $W'\in\mathcal W_8$ by Section 1. The Riemannian gradient of $P$ on $\Sigma$ is $3(\pi_{\mathcal W_8}Q(W')-\theta W')=0$. So $W'$ is a unit critical point with $P(W')=\theta$.

**Arithmetic.** $k=3$, $l=5$, $n=8$: $\tfrac{k-1}k=\tfrac23$, $\tfrac{l-1}l=\tfrac45$, $\tfrac{n-1}{n-2}=\tfrac76$. Product $\tfrac{2\cdot4\cdot7}{3\cdot5\cdot6}=\tfrac{56}{90}=\tfrac{28}{45}$. Then $\theta^2=2\cdot\tfrac{28}{45}=\tfrac{56}{45}$ and $\theta=\sqrt{56/45}>0$. The proof's $\sqrt2\sqrt{\tfrac23\cdot\tfrac45\cdot\tfrac76}=\sqrt{56/45}$ is correct. The sign: $\hat\tau$ is linear, so $P(W')=P(W)>0$, and the statement's choice $P(W_{3,5})>0$ matches Nienhaus's normalised $W_{S_{3,5}}$, for which $P=\theta_{3,5}>0$.

## 3. The transfer (brief item 3): CONFIRMED

**L27 at $(3,5)$.** The hypotheses hold: $3,5\ge3$, $(3,5)\ne(3,3)$, $n=8$. The given formula gives $\tfrac12-\mu=\tfrac{(3-2)(5-2)-1}{2\cdot2\cdot4}=\tfrac2{16}=\tfrac18>0$, and $\dim E(\tfrac12)=pq=15$. The orbit dimension is $\dim O(8)-\dim(O(3)\times O(5))=28-(3+10)=15$, consistent with L27's $\dim(\text{orbit})=pq$. L27 gives $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ attained exactly on $T_W\mathcal O_W$. So on $N_W$ every eigenvalue of $L_e$ is below $\tfrac12$. From the given formulas these are $\lambda_3=\tfrac14$, $\lambda_5=\tfrac38$, $\mu=\tfrac38$, $-\mu=-\tfrac38$ and $0$.

**$L_e\mapsto L_{e'}$.** $Q\hat\tau=\hat\tau Q$ and linearity give $\hat\tau(X\circ Y)=\hat\tau X\circ\hat\tau Y$. With $\hat\tau$ orthogonal and preserving $\mathcal W_8$, it commutes with $\pi_{\mathcal W_8}$. So $L_{e'}=\hat\tau L_e\hat\tau^{-1}$ on $\mathcal W_8$, $\hat\tau(W^\perp)=W'^\perp$, and eigenspaces map to eigenspaces with the same eigenvalue.

**Orbit tangents.** $T_W\mathcal O_W=\{[\mathrm{ad}_X,W]:X\in\mathfrak g\}$, the same for $SO(8)$ and $O(8)$. By Section 1, $\hat\tau[\mathrm{ad}_X,W]=[\mathrm{ad}_{\tau X},W']$. As $\tau$ is a bijection of $\mathfrak g$, $\hat\tau(T_W\mathcal O_W)=T_{W'}\mathcal O_{W'}$. Orthogonality then gives $\hat\tau N_W=N_{W'}$.

**Conclusion.** L24 applies at $W'$ (critical, $\theta>0$, Section 2): $\mathrm{Hess}_{W'}=6\theta(L_{e'}-\tfrac12)=\hat\tau\,\mathrm{Hess}_W\hat\tau^{-1}$. It is zero on $T_{W'}\mathcal O_{W'}$ and negative definite on $N_{W'}$, with top eigenvalue $6\theta(\tfrac38-\tfrac12)=-\tfrac{3\theta}4$. The proof's conclusion follows.

## 4. L3's step applying unchanged (brief item 4): CONFIRMED

L3's step, as filed at [findings/second-order.md](../findings/second-order.md) under Lemma L3, uses these ingredients.
- $\mathcal O$ is a compact submanifold of $\Sigma$. At $W'$: $\mathcal O_{W'}$ is an orbit of the compact group $O(8)$, lies in $\Sigma$ because $O(8)$ preserves $\mathcal W_8$ and the norm, and is embedded and compact (C6). It may have two components (two $SO(8)$-orbits), which the tubular neighbourhood theorem accepts.
- $P\equiv\theta$ on $\mathcal O$, by $O(8)$-invariance of $P$, which holds by the argument of Section 2 applied to $\mathrm{Ad}_g$.
- $df(0)=0$ by criticality (Section 2), and $d^2f(0)$ is the Hessian on $N_{W'}$.
- The quadratic coefficient: L3 uses $\mathrm{Hess}\le-6\theta/(n-2)$ on $N$. At $W'$ this becomes $\mathrm{Hess}\le-c$ with $c=\tfrac{3\theta}4>0$ (Section 3). See withdrawn candidate W2 for the change of constant.
- The Taylor remainder bound $K$ over a compact ball, and the transport to $gW'$ with normal space $gN_{W'}$, use only that each $g\in O(8)$ is an isometry of $\Sigma$ fixing $P$.
- $\rho'=\min(\rho/2,\,c/(2K))$ makes the right side below $\theta$ for $0<|v|<\rho'$, and $U$ is the image of an open set under the tubular diffeomorphism, on which $v\ne0$ exactly off $\mathcal O_{W'}$.

Nothing in the step refers to $W^*$ beyond these four inputs, so the step yields a neighbourhood $U$ of $\mathcal O_{W'}$ in $\Sigma$ with $P<\theta$ on $U\setminus\mathcal O_{W'}$. The link-by-link reading of L3's step found each inference valid: Taylor at order two with a cubic remainder, $Kr^3<\tfrac c2r^2$ for $r<c/(2K)$, and uniformity over the orbit by equivariance.

## 5. At least two peaks, in distinct orbits (brief item 5): CONFIRMED

- $W^*$ (of $S^4\times S^4$) is a strict transverse local maximum at $n=8$ by L3, whose hypothesis "even $n\ge8$" holds.
- $\theta_0(8)^2$ from $\theta_{m,m}=\sqrt2\tfrac{m-1}m\sqrt{\tfrac{n-1}{n-2}}$ at $m=4$: $2\cdot\tfrac9{16}\cdot\tfrac76=\tfrac{126}{96}=\tfrac{21}{16}$.
- $W'$ is a strict transverse local maximum at $\theta^2=\tfrac{56}{45}$ (Sections 2–4).
- The values are distinct: $56\cdot16=896\ne945=21\cdot45$, so $\tfrac{56}{45}<\tfrac{21}{16}$. Both $\theta$ are positive, so the values of $P$ themselves differ.
- $P$ is constant on $O(8)$-orbits, so $W'$ and $W^*$ lie in distinct orbits.

"At least two" is safe as a lower bound. $W_{3,5}$ itself is a peak at the same value as $W'$ and may or may not share its orbit, which leaves the count at two or more.

## 6. Scope, and the $\mathbb{HP}^2$ debt (brief item 6): CONFIRMED

- **Scope.** The statement is fixed at $n=8$, for any triality automorphism $\tau$ and the unit $W_{3,5}$ with $P>0$. The proof uses $\tau$ only as an element of $\mathrm{Aut}(\mathfrak{so}(8))$. So what is proven covers every automorphism, a superset of what is stated.
- **The debt.** The sentence "That identification, with its sign, is owed" states the $\mathbb{HP}^2$ identification as a debt. The proof never mentions $\mathbb{HP}^2$, and no conclusion depends on it. See withdrawn candidate W3 for the attached clause on $\theta^2$.

## 7. The fixed list

### 7.1 Hypothesis inventory

Given in full in the table above. Every hypothesis of the statement and of each given is used where it holds. The two used-but-unstated items (multiplicity-freeness, commuting with $\pi_{\mathcal W_8}$) are true and are verified in Sections 1 and 3.

### 7.2 Quantifier order and scope

- $n=8$ throughout, never a range. L3 is invoked at the single even value $n=8$.
- **The group.** The decomposition and the permutation are $\mathfrak{so}(8)$- (equivalently $\mathrm{Spin}(8)$-) statements. The orbits, the invariance of $P$ and the strictness are $O(8)$-statements.
- **The point.** L24, L27 and L3's step are each applied at the named point. L27 is applied at $W$, L24 and L3's step at $W'$, and the transfer goes through $\hat\tau$.
- **"Strict transverse to what".** Strict off $\mathcal O_{W'}=O(8)\cdot W'$, in the sense of L3: a neighbourhood $U$ of the orbit with $P<\theta$ on $U\setminus\mathcal O_{W'}$.
- **No finding** on quantifier order. $\tau$ is fixed before $W'$ is formed, and $K,\rho'$ are chosen after the point and uniformly over its orbit.

### 7.3 The edge of every range

- **$SO(8)$ against $O(8)$.** $\hat\tau$ conjugates $\mathrm{Int}(\mathfrak g)=\mathrm{Ad}(SO(8))$ to itself, but it can conjugate $\mathrm{Ad}_g$ for $g\in O(8)\setminus SO(8)$ into a different outer class. So $\hat\tau(\mathcal O_W)$ need not equal $\mathcal O_{W'}$ as a set. The proof never uses that equality. It transports only the tangent space, which is the same for both groups, and runs L3's step directly on $\mathcal O_{W'}$. No finding.
- **The sign of $\theta$.** $\theta>0$ is needed for negative definiteness. It is secured by $P(W_{3,5})>0$ and linearity of $\hat\tau$. For $-W_{3,5}$ the Hessian flips sign. No finding.
- **The two values distinct.** $896\ne945$. No finding.
- **The L27 exclusion.** $(3,5)$ sits one step from the excluded $(3,3)$. $\tfrac12-\mu=\tfrac18$ is strictly positive, so no collision occurs. No finding.

### 7.4 The gap between proven and stated

No finding. The mathematical content of the statement (preservation of $\mathcal W_8$, criticality, $\theta^2=\tfrac{56}{45}$, strict transverse maximum, two peaks in distinct orbits) is proven. The proof covers every automorphism, a superset of the statement. The $\mathbb{HP}^2$ remark is not a proven claim and is labelled owed (W3).

### 7.5 The brief's attack items

Items 1–6 are Sections 1–6.

### 7.6 Falsifying objects and the search for them

| Claim | Object that would falsify it | What was done |
|---|---|---|
| 1 | an automorphism $\tau$ and $S\in\mathcal W_8$ with $\hat\tau S\notin\mathcal W_8$, i.e. $\hat\tau$ moving a highest-weight label out of $\{0,2\omega_1,2\omega_3,2\omega_4\}$ | checked that $S_3$ permutes the outer nodes and fixes $\omega_2$, the dimension counts, and multiplicity-freeness |
| 2 | $R,S$ with $(\hat\tau R)\#(\hat\tau S)\ne\hat\tau(R\#S)$ | derived the identity from Definition 2.11 using only $\tau\mathrm{ad}_v\tau^{-1}=\mathrm{ad}_{\tau v}$ and orthogonality |
| 3 | a vector in $N_{W'}$ with $L_{e'}$-eigenvalue $\ge\tfrac12$, or $\hat\tau(T_W\mathcal O_W)\ne T_{W'}\mathcal O_{W'}$ | listed the L27 values at $(3,5)$ exactly (largest off-orbit $\tfrac38$) and derived the tangent identity |
| 4 | an ingredient of L3's step specific to $W^*$ | read the step link by link and found only the constant (W2) |
| 5 | $\theta_{3,5}^2=\theta_0(8)^2$ | cross-multiplied, $896\ne945$ |
| 6 | a use of the $\mathbb{HP}^2$ identification in the proof | read the proof sentence by sentence and found none |

## 8. Withdrawn candidates

**W1. "hence the three summands" is compressed (Section 1).**
1. Locate: "Triality permutes the three eight-dimensional representations $8_v,8_s,8_c$, hence the three summands $35_x=S^2_0(8_x)$".
2. Exhibit: the inference needs the twisting identity $\hat\tau\rho(X)\hat\tau^{-1}=\rho(\tau X)$ and multiplicity-freeness, neither written at that point.
3. Charitable reading: the identity $\tau\,\mathrm{ad}_X\tau^{-1}=\mathrm{ad}_{\tau X}$ is written two sentences later. Multiplicity-freeness is visible in the displayed decomposition (three non-isomorphic $35$s). The inference is the standard content of the classical fact the brief names.

Withdrawn at step 3.

**W2. "applies unchanged" while L3's display carries the constant $-6\theta/(n-2)$ (Section 4).**
1. Locate: "so it applies unchanged", against L3's $f(v)\le\theta-\frac{3\theta}{n-2}|v|^2+K|v|^3$.
2. Exhibit: at $n=8$, $-6\theta/(n-2)=-\theta$, but the Hessian at $W'$ has eigenvalue $6\theta(\tfrac38-\tfrac12)=-\tfrac{3\theta}4>-\theta$ on $\hat\tau(S^2_0(\mathbb R^5))\subset N_{W'}$. So L3's literal inequality is false at $W'$.
3. Charitable reading: the proof's sentence lists the inputs as "criticality, $\theta>0$, $O(8)$-invariance and that Hessian", meaning the Hessian at $W'$, not L3's constant. The step uses the constant only as a positive quadratic coefficient. The top eigenvalue $-c<0$ of a negative definite form on the finite-dimensional $N_{W'}$ supplies it, and L09's statement asserts no Hessian bound.

Withdrawn at step 3. *Editorial note, not a finding: "unchanged" would read more precisely as "with $6\theta/(n-2)$ replaced by $3\theta/4$".*

**W3. The clause "the two sharing $\theta^2=\tfrac{56}{45}$" is not proven in the passage (Section 6).**
1. Locate: the statement's italic sentence, [graded-half.md:264](../findings/graded-half.md#L264).
2. Exhibit: no closed-form object showing the $\mathbb{HP}^2$ Weyl tensor has $\theta^2\ne\tfrac{56}{45}$ was produced, and producing one would mean building a derivation.
3. Charitable reading: the clause reports what "the record identifies". It is followed at once by the debt label, and neither the proof nor any conclusion of the statement uses it.

Withdrawn at step 2, since no failure was exhibited.

**W4. $\hat\tau$ need not carry $\mathcal O_W$ onto $\mathcal O_{W'}$ (Section 7.3).**
1. Locate: no line of the proof asserts this. The proof transports only "the orbit tangent $[\mathrm{ad}_X,W]$".

Withdrawn at step 1.

**W5. Orthogonality of $\tau$ is asserted without reason (Section 1, C1).**
1. Locate: "$\tau$ is an orthogonal automorphism of $\mathfrak{so}(8)$: it preserves the bracket and the inner product".
2. Exhibit: no reason is written and no filed note carries it.
3. Charitable reading: invariance of the Killing form under automorphisms, together with $B=6\operatorname{tr}$ on $\mathfrak{so}(8)$, is the classical one-line fact. Every other orthogonality use in the programme (the $O(n)$-action) rests on the same fact.

Withdrawn at step 3.

## 9. Overall verdict

**PROVEN.** Every link of the proof at [graded-half.md:266](../findings/graded-half.md#L266) follows from the givens (L3, L24, L27, Nienhaus 2.25, each applied inside its hypotheses) and from correctly stated classical facts. Citation note for the record: the refinement $\Lambda^4\mathbb R^8=35_s\oplus35_c$ with $35_x=S^2_0(8_x)$, and the statement that triality permutes $8_v,8_s,8_c$, are carried by no filed source. Yokota and Ziller carry only the existence of triality, $\mathrm{Out}=S_3$ and the inequivalence of the three 8-dimensional irreps.
