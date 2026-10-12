# Verifier v312, Lemma L100: its range, its two horns, the reuse of Lemma L20's proof below the crossover, the input $\alpha\le\tfrac13$, and the radius $0.5748$

Cold brief ([BRIEF_L100.md](BRIEF_L100.md)), read in full and nothing else from the record beyond the cited source lines. No numerical work was done: no scripts, no computations, every value below is exact (integers, rationals, surds, or decimals copied verbatim from the quoted text). Log: [agent_logs/verify-L100-v312.log](../agent_logs/verify-L100-v312.log).

| # | Claim checked | Verdict |
|---|---|---|
| C1 | The heading's range $8\le n\le11$ (against the body's $9\le n\le11$) | HYPOTHESIS-DEBT |
| C2 | The dichotomy "either $\max P\le\sqrt{3/2}$, or every maximizer sits farther than $0.5748$" as a logical statement | CONFIRMED AS ALGEBRA |
| C3 | "The same machinery, Lemma L20's proof" runs below the crossover, and only its last step uses $n\ge12$ | CONFIRMED |
| C4 | The input $\alpha\le\tfrac13$ at $9\le n\le11$ is Lemma L21 used as stated | CONFIRMED |
| C5a | The metric of "farther than" is Passage B's geodesic angular distance | CONFIRMED |
| C5b | The radius step, $\psi\le1$ on $[0,0.5748]$, via $\sin(0.5748)\le s^*$ | HYPOTHESIS-DEBT |
| C6 | "Wherever $\alpha\le\tfrac13$ holds" as a conditional, at every $n$ | CONFIRMED AS ALGEBRA |
| C7 | Scope: what L100 adds beyond L20 and the padding value, and the odd members $n=9,11$ | CONFIRMED |

**Summary.** The body's conditional dichotomy is a correct one-implication reading of L20's chain with its final contradiction removed, and it holds at $9\le n\le11$ on L21, but the heading's $n=8$ has no input on file and the radius comparison inherited from L20 rests on decimals whose written enclosure does not separate the two numbers compared.

## 0. Conventions, fixed once

- $\mathcal W_n=\mathrm{Weyl}_n$ with the Frobenius inner product. $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$ on the unit sphere. $\theta^*=\sqrt{3/2}$. $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, $P(u)=\theta^*$ at every $n\ge4$ (brief, Definitions).
- $m:=\sqrt{2/3}\max P$ at the fixed $n$ under discussion. So $m\ge1$ at every $n\ge4$, because $u$ is a unit Weyl operator with $\sqrt{2/3}P(u)=1$.
- $\mathcal O=SO(n).u$. $d$ is geodesic angular distance on the unit sphere, $\cos d(X,Y)=\langle X,Y\rangle$ (Passage B). $\varphi=d(W^*,\mathcal O)$ for a maximizer $W^*$.
- $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$, $\gamma_V=\sqrt{2/3}P(V)$, $F_u(h)=\tfrac12(uh+hu)+u\#h$, $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$, $s^*$ the real root of $s^3+s^2+s=1$.
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$ (even witness), $\Theta_n^2=2(n-1)(n-3)/((n-2)(n+1))$ (odd witness), both from Passage B.
- Quotation check: [findings/route-a.md](../findings/route-a.md) lines 55, 69, 109, 127-141, 178, 180, 196 were displayed alone and compared with the brief's passages. They agree verbatim (blank lines aside).

## 1. Hypothesis inventory

**Of L100's statement.**

| Hypothesis | Where stated | Used |
|---|---|---|
| $n$ in the range | Heading: $8\le n\le11$. Body: $9\le n\le11$, and "every $n\ge9$" | Yes, through L21 (see C1, C4) |
| $\alpha\le\tfrac13$ at that $n$ | Body only ("wherever $\alpha\le\tfrac13$ holds"). The heading drops it | Yes, load-bearing |
| $d$ geodesic angular | Body only. The heading says "farther than $0.5748$ from the orbit" with no metric | Yes, through the expansion |
| Orbit is $SO(n).W_{\mathbb{CP}^2}$ padded | Both | Yes |

**Imported from L20's proof (Passage B), in the order used.**

| # | Input | Status on file | $n$-dependence |
|---|---|---|---|
| H1 | Unit sphere of $\mathcal W_n$ compact, max attained | Stated | None |
| H2 | $d$ is $SO(n)$-invariant | Stated as hypothesis | None |
| H3 | $\mathcal O$ compact embedded, nearest point exists, first variation holds | Stated as hypothesis | None |
| H4 | $\varphi>0$ for first variation, $\varphi=0$ treated separately | Stated | None |
| H5 | $P$ invariant under the conjugation action | Stated | None |
| H6 | $P$ cubic with polarization $T$, $T(u,u,V)=\langle Q(u),V\rangle$, and the $\sin^2$ coefficient equals $3\cos\varphi\,\alpha$ | Asserted ("the expansion is exact") | None written |
| H7 | $Q(u)=\theta^*u$ | Asserted without argument, no $n$ restriction written | None written |
| H8 | $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O^\perp$ | L20's text: "the lemma's one unproved input", discharge named. L21: holds at $n\ge9$ | $n\ge9$ (L21) |
| H9 | $\gamma_V\le m$ | Stated with reason | None |
| H10 | $\sin(0.5748)\le s^*$ | Decimals only (see C5b) | None |
| H11 | Witness with $P>\sqrt{3/2}$ | Stated | $n\ge12$ |

**Used but unstated.** Two, neither failing where applied:

- $\cos\varphi\ge0$, needed to replace $3\cos\varphi\sin^2\varphi\,\alpha$ by $\cos\varphi\sin^2\varphi$. It holds because $\varphi\le0.5748<\pi/2$.
- $1-\sin^3\varphi>0$, needed to divide. It holds on the same interval.

**Of L21 (Passage C).** $n\ge9$, $m=n-4$, $u$ padded of unit norm with $P(u)=\theta^*$, $V$ unit in $u^\perp\cap T_u(SO(n).u)^\perp$. L100 at $9\le n\le11$ meets each of them (C4). L100 at $n=8$ fails the first (C1).

## 2. C1, the range

**Record.** Heading, line 55: "the $8\le n\le11$ dichotomy". Statement, line 69: "**A bonus at $9\le n\le11$.**" and "*The derivation holds at every $n\ge9$*".

**Derivation of what the argument reaches.** The chain of C3 runs at any $n\ge4$ at which H8 holds. H8 is supplied on the record only by L21, whose statement opens "Let $n\ge9$". L20's own text calls H8 unproved and gives no $n=8$ argument. So the argument reaches $9\le n\le11$ (and every $n\ge9$), and nothing in the brief covers $n=8$.

**Candidate record, "the heading claims $n=8$ without an argument".**

1. Located: line 55, "$8\le n\le11$", against line 69, "$9\le n\le11$" and "every $n\ge9$".
2. Failure exhibited: at $n=8$ the step "$\alpha\le1/3$" has no source. L21's hypothesis $n\ge9$ fails since $8<9$, and L20's text states the bound as unproved. Nothing is left to carry it at $n=8$ ($m=n-4=4$).
3. Opposite argued: the body's "wherever $\alpha\le\tfrac13$ holds" makes the lemma conditional, so at $n=8$ it asserts only "if $\alpha\le\tfrac13$ at $n=8$, then the dichotomy", which C6 confirms. This rescues the body, but the heading carries neither the condition nor the range $9\le n\le11$. Read as written, it asserts the dichotomy at $n=8$ unconditionally.

**Survives. HYPOTHESIS-DEBT.** What would have to be proved: $\sqrt{2/3}\langle F_uV,V\rangle\le\tfrac13$ for every unit $V\in u^\perp\cap T_u(SO(8).u)^\perp\subset\mathcal W_8$. The alternative is to correct the heading to $9\le n\le11$, or to state the condition in it. The candidate does not refute the dichotomy at $n=8$. It shows that no argument for it is on file.

## 3. C2, the two horns

**Derivation.** Fix $n$ with H1 to H10. Let $W^*$ be any maximizer.

- If $\varphi(W^*)\le0.5748$, the chain of C3 gives $m\le1$.
- Always $m\ge1$ (Section 0). So $m\le1$ is $m=1$, that is $\max P=\sqrt{3/2}$.

Hence the implication (I): *if some maximizer has $\varphi\le0.5748$, then $\max P=\sqrt{3/2}$*. Its contrapositive is: *if $\max P>\sqrt{3/2}$, then every maximizer has $\varphi>0.5748$*. The statement "either $\max P\le\sqrt{3/2}$, or every maximizer sits farther than $0.5748$" is the disjunction $\neg A\vee B$ of that contrapositive, with $A:\max P>\sqrt{3/2}$ and $B$: all maximizers have $\varphi>0.5748$. It is therefore one implication.

**It is also an exclusive split.**

- In horn 1, $\max P=\sqrt{3/2}$, so $u$ itself is a maximizer with $\varphi=0$, and $B$ fails.
- In horn 2, $A$ holds (else horn 1).

So exactly one horn holds, and horn 1 is $\max P=\sqrt{3/2}$ exactly. Its content beyond the padding value is the equality alone.

**Maximizer on the orbit.** The degenerate branch $\varphi=0$ (Passage B, line 141) puts $W^*\in\mathcal O$, so $\max P=P(u)=\sqrt{3/2}$. That is horn 1, consistent with (I) and needing no $V$.

**Quantifiers.** The chain uses only that $W^*$ is a maximizer on the unit sphere of the same $\mathcal W_n$, since $\gamma_V\le m$ compares with the maximum at that $n$. So it applies to every maximizer, which matches "every maximizer". CONFIRMED AS ALGEBRA, conditional on H8 and H10.

## 4. C3, L20's proof below the crossover

**The chain, link by link, with the $n$ each link uses.**

1. **Compactness, H1.** $\mathcal W_n$ is finite-dimensional. Any $n$.
2. **Rotation, H2 and H5.** Rotate a nearest orbit point to $u$. The rotated $W^*$ is still a maximizer. Any $n$.
3. **First variation, H3 and H4.** For $\varphi>0$, write $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $V$ unit, $V\perp u$ and $V\perp T_u\mathcal O$. Also $V\in\mathcal W_n$, since $V=(W^*-\cos\varphi\,u)/\sin\varphi$. Any $n$.
4. **Expansion, H6 and H7.** $m=\cos^3\varphi\,\sqrt{2/3}\,\theta^*+3\cos^2\varphi\sin\varphi\,\sqrt{2/3}\,T(u,u,V)+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$. Here $\sqrt{2/3}\,\theta^*=1$, and $T(u,u,V)=\theta^*\langle u,V\rangle=0$. No $n$ enters the written step.
5. **$\alpha\le\tfrac13$, H8.** $n\ge9$ by L21.
6. **$\gamma_V\le m$, H9.** Any $n$. With $\cos\varphi\ge0$ and $\sin^3\varphi\ge0$ this gives $m\le\cos^3\varphi+\cos\varphi\sin^2\varphi+m\sin^3\varphi=\cos\varphi+m\sin^3\varphi$. Since $1-\sin^3\varphi>0$, $m\le\psi(\varphi)$.
7. **$\psi\le1$ on $[0,0.5748]$, H10.** No $n$ (see C5b).
8. **Contradiction, H11.** This needs a unit Weyl operator with $P>\sqrt{3/2}$, and it is the only step using $n\ge12$.

**The last step fails at every $n$ in the range, exactly.**

| $n$ | Witness | Value | Against $\tfrac32$ | Passage B's polynomial |
|---|---|---|---|---|
| 8 | $\theta_0^2=\frac{2\cdot7\cdot6}{64}$ | $\frac{21}{16}$ | $<\frac{24}{16}$ | $64-96+8=-24<0$ |
| 9 | $\Theta_9^2=\frac{2\cdot8\cdot6}{7\cdot10}$ | $\frac{48}{35}$ | $<\frac{105}{70}=\frac{3}{2}$, as $96<105$ | $81-117+18=-18<0$ |
| 10 | $\theta_0^2=\frac{2\cdot9\cdot8}{100}$ | $\frac{36}{25}$ | $36<37.5$ | $100-120+8=-12<0$ |
| 11 | $\Theta_{11}^2=\frac{2\cdot10\cdot8}{9\cdot12}$ | $\frac{40}{27}$ | $80<81$ | $121-143+18=-4<0$ |

So below $n=12$ step 8 has no witness, and the proof stops at $m\le1$. That is exactly what L100 records as its first horn. Steps 1 to 7 carry no $n\ge12$. CONFIRMED, with steps 5 and 7 carrying the debts of C4 and C5b.

## 5. C4, the input $\alpha\le\tfrac13$

**What Passage C gives.** It gives $\alpha\le\tfrac13$ for unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$, at $n\ge9$, with $u$ padded of unit norm and $P(u)=\theta^*$. It also states that L20 "takes the upper bound $\alpha\le\tfrac13$ and nothing else", and that attainment governs only sharpness.

**Match at $9\le n\le11$.**

- $n\ge9$ holds.
- $u$ is the same padded operator.
- The $V$ of step 3 is unit, lies in $\mathcal W_n$, and is orthogonal to $u$ and to $T_u\mathcal O$ with $\mathcal O=SO(n).u$.
- $\alpha$ and $F_u$ are defined identically in B and C.

L100 uses the upper bound only, as L20 does. The use matches the statement.

**Debts inherited.** L100 takes $\alpha\le\tfrac13$ on exactly L21's footing. Passage B's text records this input as "the lemma's one unproved input". It names the discharge: rank certificates over $\mathbb Q$ for the four rational $F_\lambda$ spectra, with entries independent of $m=n-4$. It also notes that the Schur step's multiplicity-free hypothesis fails. The quoted lines of Passage C state no debt. Taking L21 as given, per the brief, closes H8 at $9\le n\le11$. Whatever debt L21 carries passes to L100 unchanged, and L100 adds none. CONFIRMED as a use of the given. At $n=8$ see C1.

## 6. C5, the constant and the metric

### C5a, the metric

L100's body says "farther than $0.5748$ in geodesic angular distance". Passage B fixes $d$ as geodesic angular, $\cos d=\langle X,Y\rangle$. B notes that under a chord reading $0.5748$ is the angle $0.5830224$, where $\psi>1$ and the argument fails. The heading omits the metric, but the body, B and (per B) conventions.md fix it. The expansion in step 4 is written in the geodesic angle, since $\langle W^*,u\rangle=\cos\varphi$. CONFIRMED. A heading-only reader has an ambiguity, recorded as a withdrawn candidate (Section 9.3).

### C5b, the radius step

**Exact reduction, re-derived.** For $\varphi\in[0,\pi/2)$ put $s=\sin\varphi\in[0,1)$. Both $\cos\varphi=\sqrt{1-s^2}$ and $1-s^3$ are nonnegative, so

$$\psi\le1\iff1-s^2\le(1-s^3)^2\iff0\le s^2(s^4-2s+1)=s^2(s-1)(s^3+s^2+s-1).$$

For $0<s<1$, $s-1<0$, so this is $s^3+s^2+s-1\le0$. Since $s^3+s^2+s$ is increasing, that is $s\le s^*$. At $s=0$ both sides hold. So $\psi\le1\iff\sin\varphi\le s^*$, as written. The stationary point is also as written: $\frac{d\psi}{d\varphi}\cdot(1-s^3)^2=-s+3s^2-2s^4=-s(s-1)(2s^2+2s-1)$, which vanishes at $s=\tfrac{\sqrt3-1}2$. On $[0,0.5748]$, $\sin$ increases, so the step reduces exactly to $\sin(0.5748)\le s^*$.

**Candidate record, "the written enclosure does not decide $\sin(0.5748)\le s^*$".**

1. Located: line 139, "$s^*\in(0.5436,0.5437)$ against $\sin(0.5748)=0.5436669$". Also "first exceeds $1$ at $\varphi=0.5748263$" and "$\psi(0.5748)=0.9999937$".
2. Failure exhibited: $0.5436<0.5436669<0.5437$, a comparison of the written decimals alone. The value compared lies inside the enclosure given for $s^*$, so the enclosure is consistent with $s^*<\sin(0.5748)$ as well as with $s^*>\sin(0.5748)$. The written support for the needed direction is the three decimals $0.5436669$, $0.5748263$ and $0.9999937$, each stated without a derivation or an exact enclosure.
3. Opposite argued: the line "first exceeds $1$ at $\varphi=0.5748263$" supplies the separation if true. It places the crossing $\arcsin s^*$ above $0.5748$ by $2.63\times10^{-5}$ in angle, the stated radius being "the true crossing truncated in the safe direction". This reading makes the step correct, but it rests on decimal evaluations of $\sin$ and of a cubic root. Under the brief's rule, "a statement supported only by a run is HYPOTHESIS-DEBT". No rational enclosure of $s^*$ tight enough to exceed a proven upper bound for $\sin(0.5748)$ is on file.

**Survives. HYPOTHESIS-DEBT.** What would have to be proved is a rational $r$ with $\sin(0.5748)\le r$ (say, from an alternating Taylor bound) and $r^3+r^2+r\le1$. The step is $n$-independent. It is inherited from L20's proof and is the same debt there. It does not show the radius is wrong. It shows the written chain does not certify it.

## 7. C6, the conditional reading

**Statement read.** For each $n\ge4$: if $\alpha\le\tfrac13$ on $u^\perp\cap T_u(SO(n).u)^\perp\subset\mathcal W_n$, then either $\max P\le\sqrt{3/2}$ or every maximizer has $\varphi>0.5748$.

**Derivation.** It is C3's steps 1 to 7 with step 5 as the antecedent. None of those steps cites $n$ (H6, H7 and H10 carry their own status as recorded). So the conditional holds as algebra at every $n\ge4$, subject to H10.

**How it reads where the input is not established.**

- At $n=8$ (and below), the conditional is true but its antecedent is not on file, so it yields nothing unconditional. This is the gap between line 69 and the heading of line 55 (C1).
- At $9\le n\le11$ the antecedent is L21, so the conditional discharges.

"The derivation holds at every $n\ge9$" is correct in that sense. CONFIRMED AS ALGEBRA.

## 8. C7, scope and the odd members

**Beyond L20.** At $n\ge12$ L20 is this dichotomy plus a witness killing horn 1. L100 is the dichotomy at $9\le n\le11$, where no witness exists (table in C3). Beyond the padding value $P(u)=\sqrt{3/2}$ (which alone gives $\max P\ge\sqrt{3/2}$), L100 contributes one thing: the implication that $\max P>\sqrt{3/2}$ pushes every maximizer out of the tube of radius $0.5748$. It does not decide which horn holds at any $n$ in the range, and it does not claim to.

**Odd $n=9,11$.** No step of the chain uses parity. Parity enters only in step 8's witness, which L100 does not use. At $n=9$ and $n=11$ the odd witness gives $\frac{48}{35}$ and $\frac{40}{27}$, both below $\tfrac32$. So the odd members stand exactly as the even member $n=10$ does. CONFIRMED.

**"The crossover is only where the first horn stops surviving."** Read as "where a known witness first refutes horn 1": the even threshold is $n>6+2\sqrt7$ (between $11$ and $12$). The odd polynomial $n^2-13n+18$ has larger root $\frac{13+\sqrt{97}}2$, which lies between $11$ and $12$ since $9<\sqrt{97}<11$. So at integers both parities switch between $11$ and $12$, and the first odd integer past it is $13$, as B says. See the withdrawn candidate 9.1.

## 9. Withdrawn candidates

### 9.1 "The crossover $6+2\sqrt7$ is the even threshold, so it misplaces the odd first-horn boundary"

1. Located: line 69, "the crossover is only where the first horn stops surviving".
2. Failure sought: an odd integer $n$ where the placement differs. None exists. Horn 1 is refuted by a witness at $n=12$ (even) and $n\ge13$ (odd), and not at $n\le11$ of either parity (C3 table). Both real thresholds lie in $(11,12)$.
3. Opposite: at integers the sentence is exact.

Withdrawn: step 2 exhibits no failure.

### 9.2 "Horn 1 should read $=$, so $\le$ misstates it"

1. Located: line 69, "$\max P\le\sqrt{3/2}$".
2. Failure sought: a case where $\le$ is false while the dichotomy's intent holds. None exists, since $\le$ is implied by $=$.
3. Opposite: $\le$ is exactly what the chain yields, and with $m\ge1$ it is equality (C2).

Withdrawn: true as written, only non-sharp.

### 9.3 "The heading's 'farther than $0.5748$' has no metric, and under a chord reading the claim is unsupported"

1. Located: line 55.
2. Failure: under the chord reading the radius is the angle $0.5830224$, where B states $\psi>1$.
3. Opposite: the body on line 69 names geodesic angular distance, B fixes $d$, and B places it in conventions.md. A heading is read with its body.

Withdrawn: step 3 holds.

### 9.4 "$Q(u)=\theta^*u$ and the cubic polarization identities are used at $9\le n\le11$ with no argument"

1. Located: line 131, "$Q(u)=\theta^*u$ makes $T(u,u,V)=\theta^*\langle u,V\rangle=0$".
2. Failure sought: a statement or restriction on file making either identity $n$-dependent. None is written. The identity is asserted with no $n$ restriction in the given proof.
3. Opposite: L100 uses it in the same form as the given L20 at $n\ge12$, and the brief takes L20 as quoted.

Withdrawn as a finding against L100. Recorded as H6 and H7 in the inventory, on the given's footing.

## 10. Falsifiers named, and what was done

| Claim | Falsifying object | What I did |
|---|---|---|
| C1 | At $n=8$: a maximizer $W^*$ of $P$ on $\mathcal W_8$ with $P(W^*)>\sqrt{3/2}$ and $d(W^*,SO(8).u)\le0.5748$. For the proof alone: a unit $V\in u^\perp\cap T_u\mathcal O^\perp\subset\mathcal W_8$ with $\sqrt{2/3}\langle F_uV,V\rangle>\tfrac13$ | Searched the brief for any $n=8$ spectral input. None. No closed-form candidate is available without computation, so none is exhibited |
| C2 | An $n$ with H8 and H10 where $\max P>\sqrt{3/2}$ and some maximizer has $\varphi\le0.5748$ | Excluded by the re-derived chain wherever H8 and H10 hold |
| C3 | A link among steps 1 to 7 that uses $n\ge12$ | Read each link. None does. The witness table shows step 8 fails at every $n\in\{8,\dots,11\}$ |
| C4 | A hypothesis of L21 unmet at $9\le n\le11$, or a use beyond the upper bound | Checked $n$, $u$, the domain of $V$, the definition of $\alpha$. All match |
| C5a | A step written in chord distance | The expansion uses $\langle W^*,u\rangle=\cos\varphi$, which is geodesic. None found |
| C5b | $\varphi\in[0,0.5748]$ with $\psi(\varphi)>1$, equivalently $s^*<\sin(0.5748)$ | Re-derived the exact reduction. Found that the written enclosure does not exclude this object. Did not evaluate $\sin$ or $s^*$ (no numerics) |
| C6 | An $n$ where the antecedent holds and a link fails | Same as C3. None |
| C7 | A parity-dependent step in the chain | None. Parity enters only the unused witness |

## 11. Standing list, answered

1. **Hypothesis inventory**: Section 1. Used but unstated are $\cos\varphi\ge0$ and $1-\sin^3\varphi>0$, both holding on the interval. The heading drops the $\alpha$ condition and the metric that the body states.
2. **Quantifier order and scope**: $n$ is fixed first. "Maximizer" means of $P$ on the unit sphere of $\mathcal W_n$ at that $n$, and the chain holds for every maximizer. The metric is geodesic angular. The orbit is $SO(n).u$ with $u$ padded to that $n$ (C2, C5a). No finding.
3. **Edges**:
   - $n=8$ has no input (C1, HYPOTHESIS-DEBT).
   - $n=9$ is the first $n$ of L21 and is covered.
   - Odd $n=9,11$ carry no parity-dependent step (C7).
   - At the crossover $6+2\sqrt7$ nothing in the chain changes except step 8's witness (C3, 9.1).
   - A maximizer on the orbit forces horn 1 (C2).
4. **Proven versus stated**:
   - Proven, conditional on H8 and H10: the conditional at every $n\ge4$, and the dichotomy at $9\le n\le11$ via L21.
   - Stated but not proven: the dichotomy at $n=8$ (heading), and the radius comparison $\sin(0.5748)\le s^*$ beyond decimals.
5. **Brief's items**:
   1. Range: the argument reaches $n\ge9$, and nothing covers $n=8$ (C1).
   2. Horns: one implication, also an exclusive split, with horn 1 equal to $\max P=\sqrt{3/2}$ (C2).
   3. Machinery: runs below the crossover. Only the witness step uses $n\ge12$ (C3).
   4. Input: L21 at $n\ge9$, used as stated. Its debts, as recorded in B's text, pass to L100 unchanged (C4).
   5. Constant and metric: geodesic is confirmed. The radius comparison is HYPOTHESIS-DEBT (C5).
   6. Conditional: true as algebra everywhere, discharged at $9\le n\le11$, undischarged at $n=8$ (C6).
   7. Scope: the implication alone, with the odd members identical to the even one (C7).
6. **Falsifiers**: Section 10.

## Overall verdict

**HYPOTHESIS-DEBT.**

- At $9\le n\le11$ the dichotomy follows correctly from L20's chain on L21. It carries L21's inherited debt and the radius comparison $\sin(0.5748)\le s^*$, which is supported only by decimals.
- The heading's $n=8$ has no argument. What would clear it is the bound $\alpha\le\tfrac13$ at $n=8$, or a heading corrected to $9\le n\le11$ with the condition stated.
