# Verifier v311, Lemma L100: its range 8 to 11 against 9 to 11, the two horns, the reuse of L20's proof below the crossover, the L21 input, and the radius 0.5748

The brief was cold. I did no numerical work and wrote no scripts. Every value below is exact or is a decimal quoted from the given proof. Log: agent_logs/verify-L100-v311.log. I checked the quotations by diffing the cited lines of findings/route-a.md (55, 69, 109, 127-141, 178, 180, 196) against the brief, and they are byte-identical.

| # | Claim | Verdict |
|---|---|---|
| 1 | The range: the heading says $8\le n\le11$, the body says $9\le n\le11$ and "every $n\ge9$" | HYPOTHESIS-DEBT (at $n=8$) |
| 2 | The dichotomy "either $\max P\le\sqrt{3/2}$, or every maximizer sits farther than $0.5748$" | CONFIRMED |
| 3 | "The same machinery, Lemma L20's proof" runs below the crossover | CONFIRMED |
| 4 | The input $\alpha\le\tfrac13$ at $9\le n\le11$ | CONFIRMED (from given L21) |
| 5 | The radius $0.5748$ in geodesic angular distance | CONFIRMED |
| 6 | "Wherever $\alpha\le\tfrac13$ holds", the conditional reading | CONFIRMED AS ALGEBRA (the heading drops the condition, see 1) |
| 7 | Scope, including odd $n=9,11$ | CONFIRMED |

Summary: at $9\le n\le11$ the implication $\max P>\sqrt{3/2}\Rightarrow$ every maximizer lies at angle $>0.5748$ from $SO(n).W_{\mathbb{CP}^2}$ follows from given L20's proof, cut off before its witness step, together with given L21. At $n=8$, which only the heading names, the bound $\alpha\le\tfrac13$ has nothing on file.

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of Weyl tensors with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$, taken on the unit sphere.
- $u$ is $W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$. It has unit norm, and $\theta^*=P(u)=\sqrt{3/2}$ at every $n\ge4$ (brief, Definitions).
- $m:=\sqrt{2/3}\max P$. Since $P(u)=\theta^*$, $m\ge1$ at every $n\ge4$.
- $\mathcal O:=SO(n).u$ under the conjugation action. $d$ is geodesic angular distance, $\cos d(X,Y)=\langle X,Y\rangle$ (Passage B). $\varphi(W):=d(W,\mathcal O)$.
- $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ with $F_u(h)=\tfrac12(uh+hu)+u\#h$. $\gamma_V=\sqrt{2/3}P(V)$. $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$. $s^*$ is the real root of $s^3+s^2+s=1$.
- The crossover is $n_c=6+2\sqrt7$. Its integer edge lies between $11$ and $12$.

## Hypothesis inventory

**Of the statement (L100, Passage A).**

- H1, the range. The heading says $8\le n\le11$. The body says "A bonus at $9\le n\le11$" and "The derivation holds at every $n\ge9$".
- H2, the condition "wherever $\alpha\le\tfrac13$ holds". It appears in the body only.
- H3, the metric, "geodesic angular distance". It appears in the body only.
- H4, the orbit, $\mathbb{CP}^2$ orbit, i.e. $SO(n).u$ as fixed in Passage B.

**Of the imported proof (given L20, Passage B), and where each is used.**

- B1: the unit sphere is compact, so $\max P$ is attained. This holds at every $n$ and is used.
- B2: $d$ is $SO(n)$-invariant (stated). This holds at every $n$ and is used for the rotation to $u$.
- B3: $\mathcal O$ is a compact embedded submanifold, so a nearest point exists and the first-variation condition holds (stated). This holds at every $n$ and is used to get $V\perp T_u\mathcal O$.
- B4: $\varphi>0$ for B3 to be non-vacuous, and the degenerate branch is treated separately (stated). This is used.
- B5: $P$ is $SO(n)$-invariant. This is used.
- B6: $Q(u)=\theta^*u$, giving no linear term. It is asserted in the proof with no dimension qualifier and is used. See withdrawn candidate W2.
- B7: $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O^\perp$. The proof flags it as its one unproved input, and given L21 supplies it at $n\ge9$. It is used, and it is the only step that carries a dimension restriction below $12$.
- B8: $\gamma_V\le m$, because $V$ is a unit Weyl tensor. This holds at every $n$ and is used.
- B9: the $\psi$ analysis on $[0,0.5748]$. It is independent of $n$ and is used.
- B10: a witness with $P>\sqrt{3/2}$, available at even $n\ge12$ and odd $n\ge13$. It is the only step using $n\ge12$. **L100 does not use it.**

**Of given L21 (Passage C).**

- $n\ge9$, $m=n-4$, the padded $u$, and unit $V\in u^\perp\cap T_u\mathcal O^\perp$. It concludes $\alpha\le\tfrac13$ (attained).
- L100 uses the upper bound only, which is the use L21 permits for L20.
- The quoted lines list L20 and L134 as consumers and do not list L100. This is bookkeeping and has no mathematical effect.

**Used but unstated by L100.** Hypotheses B1 to B9, all by reference to "Lemma L20's proof". The one with a dimension restriction is B7, which L100 names as H2. Nothing else is used silently.

## 1. The range: heading $8\le n\le11$ against body $9\le n\le11$

**Derivation.** Section 3 shows the argument needs a dimension bound in exactly one place, B7. L21 gives B7 at $n\ge9$ and at no smaller $n$. At $n=8$ ($m=4$), no statement or argument for $\alpha\le\tfrac13$ appears in any passage on file. L20's own text says that without B7 the best available bound is $\alpha\le\tfrac12$, "at which the interval is empty". So $n=8$ has no substitute route.

**Candidate record.**

1. Location. Passage A heading (route-a.md line 55): "Lemma L100, the $8\le n\le11$ dichotomy, either $\max P\le\sqrt{3/2}$, or every maximizer sits farther than $0.5748$". It carries no condition on $\alpha$.
2. Failure, exhibited concretely. At $n=8$ the chain from Section 3 is valid except at B7. L21's hypothesis "$n\ge9$" fails at $n=8$, and L100's body excludes $n=8$ twice, in "$9\le n\le11$" and in "every $n\ge9$". The heading asserts the dichotomy unconditionally at a dimension where its one load-bearing input is absent. I exhibit no counterexample (see Section 6), so this is missing support rather than falsity.
3. Charitable reading. The body's "wherever $\alpha\le\tfrac13$ holds" makes the $n=8$ case conditional, so the heading could be shorthand for "at $n=8$, conditionally". The heading itself contains no such qualifier, though, and the body's stated range starts at $9$. Even charitably, the unconditional claim at $n=8$ has no argument. The candidate survives.

**Verdict: HYPOTHESIS-DEBT at $n=8$.** To discharge it, one must prove that the largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(8).u)^\perp$ is at most $\tfrac13\theta^*$, i.e. L21's conclusion at $m=4$. Alternatively, correct the heading to $9\le n\le11$, which is the range the body proves. At $9\le n\le11$ the claim stands (Sections 2 to 4).

## 2. The dichotomy: a case split or one implication

**Derivation.** Section 3 establishes, for any maximizer $W^*$ at $9\le n\le11$, the implication $\varphi(W^*)\le0.5748\Rightarrow m\le1$. The contrapositive is $m>1\Rightarrow\varphi(W^*)>0.5748$. The proof uses nothing about $W^*$ except unit norm and $\sqrt{2/3}P(W^*)=m$. L20 writes "attained, at some $W^*$", but the argument applies verbatim to each maximizer, so the quantifier "every" is supported. Since $m$ does not depend on $W^*$, the implication over all maximizers is logically equivalent to "$m\le1$, or every maximizer has $\varphi>0.5748$". The disjunction is therefore one implication written as a case split on the value of $\max P$.

**The horns are exclusive.** Padding gives $m\ge1$, so the first horn is exactly $\max P=\sqrt{3/2}$. In that case $u$ is itself a maximizer with $\varphi(u)=0$, so the second horn fails. In the other case $m>1$, and no point of $\mathcal O$ is a maximizer, since $P\equiv\sqrt{3/2}$ on $\mathcal O$ by B5. So exactly one horn holds.

**Verdict: CONFIRMED.** No finding: the "either/or" is the exact contrapositive, and it is exclusive once padding is used.

## 3. L20's proof below the crossover, step by step

I checked each link of Passage B, at a general $n$, for dependence on $n\ge12$.

- **Existence and rotation (B1, B2, B3, B5).** These use compactness and invariance only, with no dimension bound. When $\varphi>0$, $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $V$ a unit vector. $V\perp u$ by construction. $V\perp T_u\mathcal O$ follows because $t\mapsto\langle W^*,g_t.u\rangle$ is maximal at $t=0$, and $u\perp T_u\mathcal O$ holds on the sphere. Both conditions are independent of $n$.
- **Expansion (B6).** Put $Q(u+th)=Q(u)+t\,DQ_u h+t^2Q(h)$ with $DQ_u h=uh+hu+2u\#h$. The $t$-coefficient of $\langle u+th,Q(u+th)\rangle$ is $\langle h,Q(u)\rangle+\langle u,DQ_uh\rangle=3\langle Q(u),h\rangle$. This uses $\langle u,uh+hu\rangle=2\langle u^2,h\rangle$ and the full symmetry of $\langle A,B\#C\rangle$. The $t^2$-coefficient is $\langle u,Q(h)\rangle+\langle h,DQ_uh\rangle=3\,\mathrm{tr}(uhh)+3\langle u\#h,h\rangle=3\langle F_uh,h\rangle$. With $Q(u)=\theta^*u$ and $h=V\perp u$, the linear term vanishes. Multiplying by $\sqrt{2/3}$ gives Passage B's display $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ exactly. This is algebra with no dimension bound. It is an internal check of the given's display, and I supply nothing the given lacks.
- **Substitution (B7, B8).** $3\cos\varphi\sin^2\varphi\,\alpha\le\cos\varphi\sin^2\varphi$ needs $\alpha\le\tfrac13$ and $\cos\varphi\ge0$, and $0.5748<\pi/2$. $\sin^3\varphi\,\gamma_V\le m\sin^3\varphi$ needs $\sin\varphi\ge0$. Together with $\cos^3+\cos\sin^2=\cos$ these give $m(1-\sin^3\varphi)\le\cos\varphi$. Because $1-\sin^3\varphi>0$, $m\le\psi(\varphi)$. **Only B7 depends on $n$, through L21's $n\ge9$.**
- **The $\psi$ step (B9).** Write $s=\sin\varphi\in[0,1)$. Then $\psi\le1\iff\sqrt{1-s^2}\le1-s^3\iff0\le s^2-2s^3+s^6=s^2(s-1)(s^3+s^2+s-1)$. For $s<1$ this holds iff $s\le s^*$. The reduction is exact, as stated. Also $\frac{d\psi}{d\varphi}\,(1-s^3)^2=-s+3s^2-2s^4=-s(s-1)(2s^2+2s-1)$, which vanishes at $s=\frac{\sqrt3-1}{2}$, as stated. $\psi$ decreases below that point and increases above it. So $\psi\le1$ on $[0,0.5748]$ iff $\sin0.5748\le s^*$. That comparison rests on the given's decimals (W1). No dimension enters.
- **Conclusion.** $\varphi\le0.5748\Rightarrow m\le1$, with no $n\ge12$ anywhere. The degenerate branch $\varphi=0$ gives $W^*=u$ and $m=1$ directly.
- **Witness (B10).** This is the only use of $n\ge12$. From the given's formulas: at even $n$, $n^2-12n+8$ equals $-12$ at $n=10$ and $8$ at $n=12$. At odd $n$, $n^2-13n+18$ equals $-18$ at $n=9$, $-4$ at $n=11$, and $18$ at $n=13$. So no witness on file exists at $9\le n\le11$. I checked by hand that the two polynomial equivalences are correct: $4(n-1)(n-3)>3(n-2)(n+1)\iff n^2-13n+18>0$, and $4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$. L100 stops before this step, as it should.

**Verdict: CONFIRMED.** L20's proof, truncated at "Hence $m\le1$", runs at every $n$ where B7 holds. On file that is $n\ge9$. The crossover enters only through B10.

## 4. The input $\alpha\le\tfrac13$

- **What L21 gives.** At $n\ge9$, for unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$, $\alpha\le\tfrac13$. This is exactly the object B7 needs, since Section 3 puts $V$ in that subspace for $\varphi>0$.
- **Debts.** Passage B calls B7 "the lemma's one unproved input" and names what would discharge it. Passage C states the bound as a lemma "structural at every $n\ge9$". The only limitation in the quoted lines concerns attainment ("no $\tfrac13$-eigenvector is exhibited"). Under the loop's rules L21 is a given, so L100 inherits exactly L21's standing: the upper bound at $n\ge9$, with whatever debts L21 carries. Attainment governs only the sharpness of the radius, and L100 does not use it.
- **Match of use.** L100 takes the upper bound and nothing else, which is the use L21 licenses for L20.
- **At $n=8$.** L21 gives nothing (Section 1).

**Verdict: CONFIRMED at $9\le n\le11$.** No finding beyond Section 1. L100 inherits L21's standing without adding to it.

## 5. The constant $0.5748$ and the metric

- **Metric.** L100's body says "in geodesic angular distance", which is Passage B's $d$. The expansion $W^*=\cos\varphi\,u+\sin\varphi\,V$ requires that reading, and Passage B records that under the chord reading $\psi>1$ and the argument fails. The body and the proof agree.
- **Radius.** The radius enters only through B9, which is independent of $n$. So L100's radius is exactly L20's, and it is correctly "farther than", strict, by the contrapositive in Section 2.

**Verdict: CONFIRMED**, relative to the given's decimals (W1). No finding: the heading omits the metric, but the body fixes it (W4).

## 6. "Wherever $\alpha\le\tfrac13$ holds"

- **Reading.** The body's statement is conditional: $\alpha\le\tfrac13$ at dimension $n$ implies the dichotomy at $n$. As algebra, Sections 2 and 3 confirm it for any $n\ge4$, since B7 is the only dimension-dependent input. Combined with L21, the condition is met at $9\le n\le11$, so there the statement is unconditional relative to the givens.
- **Where the input is absent.** At $n\le8$ the conditional is true but carries no information. The heading drops the condition at $n=8$, which is Section 1's debt.
- **"The crossover is only where the first horn stops surviving."** At every $n\ge12$ a witness exists (Section 3), so the first horn fails there. Below $12$ the record neither proves nor refutes the first horn (W3).

**Verdict: CONFIRMED AS ALGEBRA.** The conditional is exactly right. The unconditional heading at $n=8$ is the debt already recorded in Section 1.

## 7. Scope

- **What L100 adds.** L20 covers $n\ge12$, and the padding value gives $m\ge1$ everywhere. L100 adds, at $9\le n\le11$: any maximizer within angle $0.5748$ of $\mathcal O$ forces $\max P=\sqrt{3/2}$. Equivalently, if anything beats $\mathbb{CP}^2$ at these dimensions, every maximizer lies outside the tube. Since no witness with $P>\sqrt{3/2}$ is on file at $9\le n\le11$, L100 decides neither horn. It is a genuine structural statement, weaker than L20's, as the word "dichotomy" signals.
- **Odd $n=9,11$.** Parity enters L20's proof only in B10, which L100 does not use. Nothing in B1 to B9 depends on parity, and L21 covers both parities. The odd members are covered exactly as the even member $n=10$ is.
- **Edges.**
  - $n=8$: Section 1.
  - $n=9$: this is L21's lower edge, $m=5$, and it is covered.
  - $n=11$: this is below both parity thresholds ($-4<0$), so the first horn is open there and L100 is the right form.
  - A maximizer on the orbit: this is the degenerate branch, which forces the first horn (Section 2).

**Verdict: CONFIRMED.** No finding.

## 8. Falsifiers, and what I did to look for them

| Claim | Falsifying object | Search |
|---|---|---|
| 1 at $n=8$ | A unit $V\in u^\perp\cap T_u(SO(8).u)^\perp$ with $\sqrt{2/3}\langle F_uV,V\rangle>\tfrac13$. By itself this breaks only the proof. To break the statement you would also need a maximizer at angle $\le0.5748$ with $\max P>\sqrt{3/2}$ at $n=8$. | Nothing on file gives the spectrum of $F_u$ at $m=4$. I exhibit no closed-form candidate and ran no computation. I record the claim as unsupported, which is different from refuted. |
| 2 | A maximizer at angle $\le0.5748$ with $\max P>\sqrt{3/2}$ at some $9\le n\le11$ | Section 3's chain excludes it given L21. I checked each link by hand (expansion coefficients, the substitution signs, the exact factorisation of $\psi\le1$). |
| 3 | A step of L20's proof that uses $n\ge12$ other than B10 | I read all ten steps (inventory). None does. |
| 4 | A $V$ with $\alpha>\tfrac13$ at $9\le n\le11$ | This would contradict given L21, which is out of scope for this round. |
| 5 | $\sin0.5748>s^*$, or a chord reading | The chord reading is excluded by L100's body text. The comparison with $s^*$ rests on the given's decimals (W1). |
| 6 | A dimension-dependent input other than B7 | None found. |
| 7 | A parity-dependent step outside B10 | None found. |

## 9. Withdrawn candidates

**W1. The enclosure of $s^*$ does not decide the radius.**

1. Location. Passage B: "$s^*\in(0.5436,0.5437)$ against $\sin(0.5748)=0.5436669$."
2. Failure. $0.5436669$ lies inside $(0.5436,0.5437)$, so the displayed enclosure alone does not decide $\sin0.5748\le s^*$.
3. Charitable reading. The next sentences give the crossing $\varphi=0.5748263>0.5748$ and $\psi(0.5748)=0.9999937<1$, and these decide the comparison. They sit inside given L20's proof, and L100 uses them identically. So they are not a defect of L100. **Withdrawn** as a finding against L100. For the record: the decisive inequality is carried by decimals that have no exact certificate in the quoted text.

**W2. $Q(u)=\theta^*u$ at $9\le n\le11$.**

1. Location. Passage B: "$Q(u)=\theta^*u$ makes $T(u,u,V)=\theta^*\langle u,V\rangle=0$."
2. Failure. L20 is given at $n\ge12$, and L100 uses this sentence at $9\le n\le11$.
3. Charitable reading. The sentence is a property of the padded tensor, asserted without any dimension qualifier. The proof it sits in is the machinery L100 explicitly imports, and L21 (given at $n\ge9$) works with the same padded $u$ and its linearisation $F_u$. **Withdrawn.**

**W3. "The crossover is only where the first horn stops surviving" as a claim that the first horn holds below.**

1. Location. Passage A, last sentence.
2. Failure. Read as "$\max P=\sqrt{3/2}$ at $n\le11$", the sentence would be unproven.
3. Charitable reading. The literal content is that the first horn fails from $n\ge12$ on, which the witness polynomials confirm for both parities. **Withdrawn.**

**W4. The heading omits the metric.**

1. Location. The heading's "farther than $0.5748$ from the $\mathbb{CP}^2$ orbit".
2. Failure. Under the chord reading the statement is not what the proof gives.
3. Charitable reading. The body fixes "geodesic angular distance", and Passage B says the convention is recorded in conventions.md. **Withdrawn.**

**W5. "at even $n$ it is $\theta_0(n)$, exceeding $\tfrac32$".**

1. Location. Passage B, witness sentence.
2. Failure. The polynomial $n^2-12n+8$ encodes $\theta_0(n)^2>\tfrac32$, while the sentence compares $\theta_0(n)$ itself with $\tfrac32$.
3. Charitable reading. The sentence is parallel to the preceding $\Theta_n^2$, and the setting's "$\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$" is the correct squared form. This is a notational slip in the given's witness step, which L100 does not use. **Withdrawn.**

## Overall verdict

**HYPOTHESIS-DEBT.** Relative to givens L20 and L21, L100 is proven on $9\le n\le11$, both parities, as the body states it. The heading's $n=8$ has no $\alpha\le\tfrac13$ on file. To discharge it, prove L21's bound at $m=4$, or correct the heading to $9\le n\le11$. With that correction the verdict would be PROVEN (hypotheses corrected).
