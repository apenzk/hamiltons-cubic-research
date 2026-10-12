# Verifier v313, Lemma L100: its range 8 to 11 against 9 to 11, the two horns, the reuse of L20's proof below the crossover, the input alpha at most 1/3, the radius 0.5748 and its metric

The brief ([BRIEF_L100.md](BRIEF_L100.md)) was cold. I did no numerical work: no scripts, no runs, and every value below is exact (rationals, closed-form roots, polynomial identities). The quotations were checked against [findings/route-a.md](../findings/route-a.md) lines 55, 69, 109, 127-141, 178, 180 and 196 only, and all match verbatim. Log: [agent_logs/verify-L100-v313.log](../agent_logs/verify-L100-v313.log).

| # | Claim checked | Verdict |
|---|---|---|
| C1 | L100 at $n=8$, the heading's range $8\le n\le11$ | HYPOTHESIS-DEBT |
| C2 | The two horns: "either $\max P\le\sqrt{3/2}$, or every maximizer farther than $0.5748$" | CONFIRMED |
| C3 | L20's proof uses $n\ge12$ only at its witness step, so it runs at $9\le n\le11$ | CONFIRMED |
| C4 | The input $\alpha\le\tfrac13$ at $9\le n\le11$ is L21 as stated, hypotheses matched | CONFIRMED |
| C5 | The expansion, $m\le\cos\varphi+m\sin^3\varphi$, and $\psi\le1\iff\sin\varphi\le s^*$ | CONFIRMED AS ALGEBRA |
| C6 | The radius: $\psi\le1$ on $[0,0.5748]$, i.e. $\sin(0.5748)\le s^*$ | HYPOTHESIS-DEBT |
| C7 | The metric of "farther than" is geodesic angular distance, matching L20's $d$ | CONFIRMED |
| C8 | Range edges: no quoted witness exceeds $\sqrt{3/2}$ at $8\le n\le11$, both parities clear from $n=12$ | CONFIRMED |
| C9 | Scope: L100 is the conditional part of L20's proof and decides neither horn at $9\le n\le11$ | CONFIRMED |

**Summary:** the derivation at $9\le n\le11$ is sound given L21, but the heading claims $n=8$, where no bound $\alpha\le\tfrac13$ is on file, and the radius $0.5748$ rests on a comparison that the written bracket does not decide.

## 0. Conventions, fixed once

- $\mathcal W_n=\mathrm{Weyl}_n$ with the Frobenius inner product, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, restricted to the unit sphere.
- $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, unit norm, $P(u)=\theta^*=\sqrt{3/2}$ at every $n\ge4$. $\mathcal O=SO(n).u$.
- $m:=\sqrt{2/3}\max P$ as in L20's proof. L21 uses the same letter for $n-4$. Below, $m$ is always L20's meaning, and $n-4$ is written out.
- $d$ is geodesic angular distance on the unit sphere, $\cos d(X,Y)=\langle X,Y\rangle$. $\varphi:=d(W^*,\mathcal O)$.
- $s=\sin\varphi$, $c=\cos\varphi$, $g(s)=s^3+s^2+s-1$, $s^*$ its real root, $\psi(\varphi)=c/(1-s^3)$.
- "Crossover" is $n_0=6+2\sqrt7$, the larger root of $n^2-12n+8$. The odd-parity polynomial $n^2-13n+18$ has larger root $n_1=(13+\sqrt{97})/2$.
- "Maximizer" is a point of the unit sphere of $\mathcal W_n$ where $P$ attains its maximum.

## Hypothesis inventory

**Statement of L100 (line 69).** Hypotheses: $9\le n\le11$ in the body, $8\le n\le11$ in the heading (line 55). The condition "wherever $\alpha\le\tfrac13$ holds" sits in the body and is absent from the heading.

**Imported from L20's proof (lines 127-141), each marked used or unused by the L100 derivation:**

| Hypothesis or input | Where stated | Used by L100 | Depends on $n$ in the text |
|---|---|---|---|
| Unit sphere of $\mathcal W_n$ compact, so $\max P$ attained | proof, first sentence | used | no |
| $d$ is $SO(n)$-invariant | one of the three listed | used | no |
| $\mathcal O$ compact embedded, nearest point exists, first variation holds | one of the three listed | used | no |
| $\varphi>0$, with $\varphi=0$ treated separately | one of the three listed | used | no |
| $P$ invariant under $SO(n)$ conjugation | inline | used | no |
| $P$ a cubic form with (symmetric) polarization $T$, and $T(u,u,V)=\langle Q(u),V\rangle$ | inline, not among the three | used | no |
| $Q(u)=\theta^*u$ | inline, not among the three | used | no |
| $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O^\perp$ | inline, labelled "the lemma's one unproved input" with its discharge route | used | through L21, $n\ge9$ |
| $\gamma_V\le m$ since $V$ is a unit Weyl operator | inline | used | no |
| Radius bound $\psi\le1$ on $[0,0.5748]$ | inline, decimals | used | no |
| Witness with $P>\sqrt{3/2}$: $\theta_0(n)$ at even $n$, $\Theta_n$ at odd $n$ | inline | **unused** by L100 | yes, $n\ge12$ |

**Imported from L21 (lines 178, 180, 196).** Hypotheses: $n\ge9$, $u$ padded and unit, $V$ unit in $u^\perp\cap T_u(SO(n).u)^\perp$. Conclusion used: the upper bound only, which line 196 names as what L20 may take. Attainment of $\tfrac13$ is unused, and line 196 records that no $\tfrac13$-eigenvector is exhibited.

**Used but unstated.** Two inline inputs of L20's proof, $Q(u)=\theta^*u$ and the identification $T(u,u,V)=\langle Q(u),V\rangle$ with $T(u,V,V)=\langle F_uV,V\rangle$ (full symmetry of $\langle Q(X,Y),Z\rangle$), are used and asserted without being among the "three further hypotheses". They belong to the given, carry no $n$-restriction in its text, and so transfer to $9\le n\le11$ exactly as they stand at $n\ge12$. No finding against L100.

## 1. C1, the heading's range at $n=8$

The heading (line 55) reads "Lemma L100, the $8\le n\le11$ dichotomy" with no condition. The body (line 69) reads "A bonus at $9\le n\le11$" and "The derivation holds at every $n\ge9$".

The only step of the derivation with an $n$-dependent source is $\alpha\le\tfrac13$ (C3 below). Its sources on file:

- L21, whose statement opens "Let $n\ge9$". At $n=8$ its hypothesis fails.
- L20's inline citation of Nienhaus 4.14(c), which L20's own text says "does not carry it".
- L20's discharge route: "the four rational $F_\lambda$ matrices have the tabulated spectra ... and that their entries do not depend on $m=n-4$". This is a statement of what would be needed, and L21's threshold $n\ge9$ is $n-4\ge5$. $n=8$ is $n-4=4$, outside it.

**Three-step record.**

1. *Location.* Line 55, "$8\le n\le11$", against line 69, "$9\le n\le11$" and "every $n\ge9$".
2. *Failure exhibited.* At $n=8$ the chain needs a bound $\sqrt{2/3}\langle F_uV,V\rangle\le\tfrac13$ for every unit $V\in u^\perp\cap T_u\mathcal O^\perp\subset\mathcal W_8$. No lemma on the brief states it at $n=8$, and the only one that states it (L21) excludes $n=8$ by hypothesis. The body itself does not claim $n=8$.
3. *Charitable reading.* The body's qualifier "wherever $\alpha\le\tfrac13$ holds" makes the statement conditional, and at $n=8$ the conditional statement is proved (the derivation is $n$-free given the input). On that reading the heading is a range written one lower than the body and missing the qualifier. The charitable reading rescues a conditional at $n=8$, and it leaves the heading's unconditional claim at $n=8$ without an argument.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: $\alpha\le\tfrac13$ on $u^\perp\cap T_u(SO(8).u)^\perp$ in $\mathcal W_8$, or the heading corrected to $9\le n\le11$ (or to "$8\le n\le11$, wherever $\alpha\le\tfrac13$ holds"). I did not look for a violating $V$ at $n=8$, since that needs a spectrum computation this loop does not do. I checked that $n-4=4$ is the one value excluded by L21's threshold, which is a place where the $SO(n-4)$ decomposition of $\Lambda^2\mathbb R^{n-4}$ splits further, so the threshold is plausibly structural and the extension to $n=8$ is not automatic. That remark is a reason for caution and is not evidence of failure.

## 2. C2, the two horns

Write $A$: $\max P\le\sqrt{3/2}$, and $B$: every maximizer $W^*$ has $d(W^*,\mathcal O)>0.5748$.

What the derivation proves, for a fixed maximizer $W^*$: if $\varphi(W^*)\le0.5748$ then $m\le1$, i.e. $A$. The argument uses only $P(W^*)=\max P$ (in the $\cos^3\varphi$ term through $m$, and in $\gamma_V\le m$), so it applies to each maximizer separately. Hence $\neg A\Rightarrow B$, which is the disjunction $A\vee B$.

Since $P(u)=\sqrt{3/2}$, $\max P\ge\sqrt{3/2}$, so $A$ is $\max P=\sqrt{3/2}$, and then $u$ is itself a maximizer at distance $0$, so $B$ fails. Conversely $B$ forces $\neg A$ because $u$ lies on $\mathcal O$. So exactly one horn holds, and the "dichotomy" is the single implication $\max P>\sqrt{3/2}\Rightarrow B$ written as a case split on the value of $\max P$. Both readings are the same statement.

**Degenerate branch.** If a maximizer lies on $\mathcal O$ ($\varphi=0$), then $\max P=P(u)=\sqrt{3/2}$ and horn $A$ holds directly. The first-variation step, which needs $\varphi>0$, is not reached. L100 needs no contradiction here, unlike L20.

**Verdict: CONFIRMED.**

## 3. C3, which steps of L20's proof use $n\ge12$

Link by link, for arbitrary $n\ge5$ given the input $\alpha\le\tfrac13$:

1. Compactness of the unit sphere: finite dimension, any $n$.
2. Nearest point on $\mathcal O$: $SO(n)$ compact, so $\mathcal O$ is compact, any $n$.
3. First variation: $d(W^*,g.u)$ is minimal where $\langle W^*,g.u\rangle$ is maximal ($\arccos$ decreasing), so $\langle W^*,Xu\rangle=0$ for $X\in\mathfrak{so}(n)$, i.e. $W^*\perp T_u\mathcal O$. The orbit lies on the unit sphere, so $u\perp T_u\mathcal O$. With $\varphi\in(0,\pi)$, $V=(W^*-\cos\varphi\,u)/\sin\varphi$ is unit, $V\perp u$, $V\perp T_u\mathcal O$. Any $n$.
4. Expansion (C5), any $n$.
5. $\alpha\le\tfrac13$: L21, $n\ge9$ (C4).
6. $\gamma_V\le m$: any $n$.
7. $\psi\le1$ on $[0,0.5748]$: $n$-free (C6).
8. Witness: $\theta_0(n)^2>\tfrac32\iff n^2-12n+8>0$ at even $n$, $\Theta_n^2>\tfrac32\iff n^2-13n+18>0$ at odd $n$. **This is the only step that uses $n\ge12$.**

L100 stops after step 7 and states the conclusion of steps 1-7 as horn $A$. The body's "The derivation holds at every $n\ge9$" is exactly steps 1-7 with L21 supplying step 5.

**Verdict: CONFIRMED.**

## 4. C4, the input $\alpha\le\tfrac13$

L21's hypotheses against the use in step 3:

| L21 hypothesis | At the use |
|---|---|
| $n\ge9$ | $9\le n\le11$: holds. $n=8$: fails (C1). |
| $u=W_{\mathbb{CP}^2}$ padded, unit, $P(u)=\sqrt{3/2}$ | the rotated nearest point is $u$ itself: holds |
| $V$ unit in $u^\perp\cap T_u(SO(n).u)^\perp$ | step 3 gives exactly this: holds |
| $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$, $F_u(h)=\tfrac12(uh+hu)+u\#h$ | same definitions in the expansion: holds |

Conclusion taken: the upper bound only, which line 196 permits ("takes the upper bound $\alpha\le\tfrac13$ and nothing else" for L20, whose proof L100 reuses).

**Inherited debts.** L20's line 133 calls $\alpha\le\tfrac13$ "the lemma's one unproved input" and names its discharge: rank certificates over $\mathbb Q$ for four $F_\lambda$ matrices and independence of their entries from $n-4$. L21 as a given states the bound at $n\ge9$. L100 inherits whatever L21's own proof carries, which is outside the brief. L100's body flags the dependence explicitly ("wherever $\alpha\le\tfrac13$ holds"), so the inheritance is declared.

**Verdict: CONFIRMED**, with L21's standing as the load-bearing given and the n=8 exclusion recorded under C1.

## 5. C5, the algebra of the expansion and the reduction

**Expansion.** With $W^*=cu+sV$ and $T$ the symmetric trilinear polarization of $P$,
$$P(W^*)=c^3P(u)+3c^2s\,T(u,u,V)+3cs^2\,T(u,V,V)+s^3P(V).$$
$T(u,u,V)=\langle Q(u),V\rangle=\theta^*\langle u,V\rangle=0$. The polarization of $Q$ at $u$ is $Q(u,h)=\tfrac12(uh+hu)+u\#h=F_u(h)$ (from $Q(u+h)=u^2+uh+hu+h^2+u\#u+2u\#h+h\#h$ with $\#$ symmetric bilinear), so $T(u,V,V)=\langle F_uV,V\rangle$. Multiplying by $\sqrt{2/3}$ and using $\sqrt{2/3}\,\theta^*=1$ gives line 135's formula exactly.

**Bound.** $3cs^2\ge0$ and $s^3\ge0$ for $\varphi\in[0,\pi/2]$, so $\alpha\le\tfrac13$ and $\gamma_V\le m$ give $m\le c^3+cs^2+ms^3=c+ms^3$. Since $s<1$, $m\le c/(1-s^3)=\psi(\varphi)$.

**Reduction.** On $[0,\pi/2)$, both sides nonnegative, $\psi\le1\iff c\le1-s^3\iff1-s^2\le1-2s^3+s^6\iff s^2(s^4-2s+1)\ge0$. And $s^4-2s+1=(s-1)(s^3+s^2+s-1)$, expanded: $s^4+s^3+s^2-s-s^3-s^2-s+1=s^4-2s+1$. For $0<s<1$, $s-1<0$, so $\psi\le1\iff g(s)\le0\iff s\le s^*$ ($g$ strictly increasing, $g(0)=-1$, $g(1)=2$). At $s=0$ equality. **Exact, as line 139 says.**

**Critical point.** $\psi'=0\iff-s(1-s^3)+3s^2c^2=0\iff s(2s^3-3s+1)=0$, and $2s^3-3s+1=(s-1)(2s^2+2s-1)$, whose root in $(0,1)$ is $s=(\sqrt3-1)/2$. This matches line 139. The minimum value $0.9785933$ and $\varphi=0.3747372$ are decimals and are not load-bearing.

**Verdict: CONFIRMED AS ALGEBRA.**

## 6. C6, the radius $0.5748$

The step needed: every $\varphi\in[0,0.5748]$ has $\sin\varphi\le s^*$, i.e. $\sin(0.5748)\le s^*$. The record's written support (line 139): "$s^*\in(0.5436,0.5437)$ against $\sin(0.5748)=0.5436669$", then "$\psi$ ... first exceeds $1$ at $\varphi=0.5748263$" and "$\psi(0.5748)=0.9999937$".

**Three-step record.**

1. *Location.* Line 139, the sentence "$s^*\in(0.5436,0.5437)$ against $\sin(0.5748)=0.5436669$".
2. *Failure exhibited.* $0.5436<0.5436669<0.5437$, so the stated bracket for $s^*$ contains the stated value of $\sin(0.5748)$ and does not order them. The comparison $\sin(0.5748)\le s^*$ is left undecided by the written bracket. The sentences that would decide it, the crossing $0.5748263$ and $\psi(0.5748)=0.9999937$, are seven-digit decimals with no derivation, interval certificate or error bound on file. The margin they assert is $2.63\times10^{-5}$ in $\varphi$, so the truncation of each figure matters.
3. *Charitable reading.* The author intends the crossing $0.5748263$ as the decisive figure, and "truncated in the safe direction" states the right logical relation. On that reading the chain is complete provided the decimal is correct. It is still a figure supported only by an evaluation, and this loop records such a statement as HYPOTHESIS-DEBT. I ran no screen, so this finding is about what is on file and makes no claim that the inequality fails.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: $g(\sin 0.5748)\le0$, for instance by an exact rational upper bound for $\sin(0.5748)$ and a rational $r$ with that bound $\le r$ and $g(r)\le0$. **Spread:** the step is $n$-free and is the same step in L20 at every $n\ge12$, so the debt is shared with L20 and is not specific to L100.

## 7. C7, the metric

Line 69: "farther than $0.5748$ in geodesic angular distance from the $\mathbb{CP}^2$ orbit". Line 129 fixes $d$ as geodesic angular distance and records that as a chord the radius fails. The heading (line 55) omits the metric, and the body supplies it, consistent with line 129 and with the expansion ($\langle W^*,u\rangle=\cos\varphi$), which is valid only for the angular reading.

No finding: the metric in the body matches L20's $d$, and the heading's omission is resolved by the body and by conventions.md as cited at line 129.

**Verdict: CONFIRMED.**

## 8. C8, the edges of the range

Exact values of the quoted witnesses:

| $n$ | parity | witness square | against $\tfrac32$ |
|---|---|---|---|
| 8 | even | $\theta_0^2=\frac{2\cdot7\cdot6}{64}=\frac{21}{16}$ | $21<24$, below |
| 9 | odd | $\Theta_9^2=\frac{2\cdot8\cdot6}{7\cdot10}=\frac{48}{35}$ | $96<105$, below |
| 10 | even | $\theta_0^2=\frac{2\cdot9\cdot8}{100}=\frac{36}{25}$ | $72<75$, below |
| 11 | odd | $\Theta_{11}^2=\frac{2\cdot10\cdot8}{9\cdot12}=\frac{40}{27}$ | $80<81$, below |
| 12 | even | $\theta_0^2=\frac{2\cdot11\cdot10}{144}=\frac{55}{36}$ | $55>54$, above |
| 13 | odd | $\Theta_{13}^2=\frac{2\cdot12\cdot10}{11\cdot14}=\frac{120}{77}$ | $240>231$, above |

Polynomials: $4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$, and $4(n-1)(n-3)>3(n-2)(n+1)\iff n^2-13n+18>0$. Both confirmed by expansion. $n_0=6+2\sqrt7$ lies in $(11,12)$ since $25<28<36$. $n_1=(13+\sqrt{97})/2$ lies in $(11,13)$ since $81<97<169$, and no integer of either parity falls between $n_0$ and $n_1$ that changes the table.

- **$n=8$:** C1.
- **$n=9$:** L21 applies at its boundary value. Confirmed.
- **Odd $n$ (9, 11):** the derivation is parity-free. The line-69 phrase "below the crossover" names $n_0$, the even polynomial's root. The odd polynomial's threshold $n_1$ is also above $11$, so the phrase is correct at $n=11$.
- **Crossover:** non-integer. "The crossover is only where the first horn stops surviving" is correct at the integers: every $n\ge12$ has a quoted witness, every $n\le11$ lacks one.
- **Maximizer on the orbit:** C2, horn $A$.

**Verdict: CONFIRMED.**

## 9. C9, scope

- L100 is steps 1-7 of L20's proof, stated without step 8. Beyond L20 it adds the observation that the conditional holds at $9\le n\le11$ and the explicit case split.
- With the padding value $P(u)=\sqrt{3/2}$ it reads: at $9\le n\le11$, either $u$ is a global maximizer of $P$, or no maximizer lies within geodesic angle $0.5748$ of $\mathcal O$.
- It decides neither horn at any $n\in\{9,10,11\}$: the table in C8 shows no quoted witness exceeds $\sqrt{3/2}$ there, and nothing on the brief shows $\max P=\sqrt{3/2}$ there.
- At odd $n$ the body of L20 notes the balanced sphere product does not exist, and L100 makes no use of it. No odd-$n$ step differs from even $n$.

**Verdict: CONFIRMED.**

## 10. The standing list

1. **Hypothesis inventory.** Given above. Used but unstated: $Q(u)=\theta^*u$ and full symmetry of the polarization, both inline in the given with no $n$-restriction. Stated hypothesis missing from the heading: "wherever $\alpha\le\tfrac13$ holds".
2. **Quantifier order and scope.** $n$ fixed first, in $9\le n\le11$ (heading $8\le n\le11$, C1). "Every maximizer" is correct, since the argument runs per maximizer (C2). Metric: geodesic angular (C7). Orbit: $SO(n).u$ with $u$ padded. No finding beyond C1.
3. **Edges.** $n=8$: HYPOTHESIS-DEBT (C1). $n=9$: L21's boundary, holds. Odd $n$: parity-free derivation, no finding. Crossover: non-integer, no finding. Maximizer on the orbit: horn $A$ directly, no finding.
4. **Proven against stated.** Proven, given L21 and the radius comparison: the dichotomy at $9\le n\le11$. Stated: the heading at $8\le n\le11$ unconditionally. The gap is $n=8$ (C1) and the radius comparison at every $n$ (C6).
5. **Brief's attack items.**
   1. Range: the argument reaches $n\ge9$ through L21. Nothing on file covers $n=8$. C1, HYPOTHESIS-DEBT.
   2. Horns: one implication written as a case split on $\max P$, exactly one horn holds. C2, CONFIRMED.
   3. Machinery below the crossover: only the witness step uses $n\ge12$. C3, CONFIRMED.
   4. Input: L21 at $n\ge9$, hypotheses matched, L20's recorded debt inherited through L21. C4, CONFIRMED.
   5. Constant and metric: the metric matches (C7, CONFIRMED). The constant's decisive comparison is undecided by the written bracket (C6, HYPOTHESIS-DEBT).
   6. Conditional: the body is conditional, the heading is not. At $n\ge9$ L21 discharges the condition. At $n=8$ it is not established, so the body is a true conditional and the heading is unsupported (C1).
   7. Scope: C9, CONFIRMED. The odd members $9$ and $11$ carry no quoted witness and need none.
6. **Falsifying objects and what I did.**
   - C1: a unit $V\in u^\perp\cap T_u\mathcal O^\perp\subset\mathcal W_8$ with $\sqrt{2/3}\langle F_uV,V\rangle>\tfrac13$, or a maximizer on $\mathcal W_8$ within $0.5748$ of $\mathcal O$ with $P>\sqrt{3/2}$. I checked every source of the input on the brief for coverage of $n-4=4$. No search for $V$ (a spectrum computation).
   - C2: an $n$ where both horns fail, or both hold. Excluded exactly by $P(u)=\sqrt{3/2}$.
   - C3: a step among 1-7 using $n\ge12$. Read each, none.
   - C4: a mismatch between the $V$ of step 3 and L21's $V$. Compared hypotheses one by one, none.
   - C5: a failing identity in the expansion or factorization. Both factorizations expanded in full above.
   - C6: $\varphi\le0.5748$ with $\psi(\varphi)>1$, equivalently $\sin(0.5748)>s^*$. The written bracket does not exclude it, and no exact decision is on file. I did not evaluate it.
   - C7: a reading of "farther than" under which the expansion fails. The chord reading, which line 129 already excludes, and the body names geodesic.
   - C8: a quoted witness exceeding $\sqrt{3/2}$ at $8\le n\le11$. Exact table above, none.
   - C9: a claim in L100 beyond steps 1-7. None.

## 11. Withdrawn candidates

- **"The proof treats one maximizer, so 'every maximizer' is unsupported."** (1) Line 131, "attained, at some $W^*$", against line 69, "every maximizer". (2) The failure would be a second maximizer to which the argument does not apply. (3) The argument uses only $P(W^*)=\max P$, so it applies verbatim to any maximizer. *Withdrawn: the charitable reading is the correct one.*
- **"The sign of $3\cos\varphi\sin^2\varphi$ is needed to substitute $\alpha\le\tfrac13$."** (1) Line 137, "Substituting both". (2) With $\cos\varphi<0$ the substitution would reverse. (3) The case assumed is $\varphi\le0.5748<\pi/2$, where $\cos\varphi>0$. *Withdrawn.*
- **"'The crossover is only where the first horn stops surviving' presupposes the first horn holds below it."** (1) Line 69. (2) Nothing on the brief shows $\max P=\sqrt{3/2}$ at $9\le n\le11$. (3) Read as "survives the known witnesses", which C8's table confirms at every integer. *Withdrawn: the phrase is loose and the claim it makes about witnesses is correct.*
- **"At odd $n$ the relevant crossover is $n_1$, and 'below the crossover' names the wrong one."** (1) Line 69, "below the crossover", with $n_0$ from line 127. (2) An odd $n$ between $n_0$ and $n_1$ would be misclassified. (3) $n_0,n_1\in(11,12)$ and $(11,13)$ with no odd integer in $[n_0,n_1]$ (11 lies below $n_0$, 13 above $n_1$). *Withdrawn.*
- **"Line 139 writes 'at even $n$ it is $\theta_0(n)$, exceeding $\tfrac32$', which is $\theta_0>\tfrac32$ and not $\theta_0^2>\tfrac32$."** (1) Line 139. (2) $\theta_0(n)>\tfrac32$ would give a different polynomial. (3) "It" is the witness value, the sentence's subject is $\Theta_n^2$, and the polynomial $n^2-12n+8$ matches $\theta_0^2>\tfrac32$. In any case step 8 is unused by L100. *Withdrawn.*
- **"The letter $m$ means $\sqrt{2/3}\max P$ in L20 and $n-4$ in L21, and the collision could corrupt the input."** (1) Line 131 against line 180. (2) Reading L21's $m$ into L20's bound would be meaningless. (3) L21's $m$ is only a label in its statement and never enters the inequality used. *Withdrawn.*

## Overall verdict

**HYPOTHESIS-DEBT.** The derivation at $9\le n\le11$ is correct as algebra and uses L21 exactly as stated. Two debts stand:

- **$n=8$ (C1):** the heading's range has no bound $\alpha\le\tfrac13$ on file. It needs that bound at $n=8$, or the heading corrected to the body's $9\le n\le11$ or conditioned.
- **The radius (C6):** $\sin(0.5748)\le s^*$ rests on decimals, and the written bracket does not decide it. It needs an exact certificate. This debt is shared with L20.
