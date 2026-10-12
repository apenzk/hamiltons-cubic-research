# Reviewer r362, Gate 2 on the double-root family, the classification and the $\nu_2$ branch

**S1, CONFIRMED**, with a scope correction: the form $2\nu_i[(n-1)\nu_j+\theta]$ belongs to the *six* four-type identities whose multiplier has $\nu_i$ as one of its two roots, not to the family; the other three carry the quadratic form, and the sentence in [bounds-relaxations.md](../findings/bounds-relaxations.md) that says "every identity's right-hand side has the form ... $2\nu_i[(n-1)\nu_j+\theta]$ for the four-type family" overstates.

**S2, REFUTED.** The four-type row of the classification table is wrong in all three of its cells. Correct: **two** are free of every hypothesis, **two** need only $\Pi$-strictness, **two** need the bracket $(n-1)\nu_2+\theta\ne0$. The double-root row's counts are right, but its column heading is not: of the five it calls "needs the sign of $\nu_2$", only two are settled by learning $\nu_2>0$.

**S3, REFUTED.** The hypothesis-free chain is $210\to209\to208\to201\to\mathbf{194}$, not $195$; the missing step is the free four-type identity S2 misclassified. And $194$ is itself not the honest figure: an unconditional dichotomy that needs no hypothesis at all brings it to $\mathbf{178}$.

**S4, REFUTED in part.** That the sign of $\nu_2$ is undetermined by anything on the record is **CONFIRMED**, though the recorded reason is the weak form of the true one. That the $\nu_2<0$ branch "costs exactly ONE identity" is **REFUTED**: it costs four, of which the repair reaches three. Something else in the classification does flip: the *pair cut* loses its direction, not merely its nonvanishing.

**S5, REFUTED.** Second-$\Pi$-strictness does not restore the pair cut, so the branches do not agree under it. It is a legitimate non-degeneracy condition but an unnecessary one, the dichotomy below replaces it and assumes nothing. And [Lemma L71](../findings/bounds.md) characterises $\Pi$-saturation only in conjunction with a spectral ratio the record's own $\Pi$-saturating witnesses fail, so the "the record can test it" clause is unfounded and nothing transfers to the middle eigenvalue, there being no proved bound $\theta\le(n-1)\lvert\nu_2\rvert$ for it to be the saturation of.

---

## S1, the two right-hand sides, derived from (A), (B), (C) alone

I worked from the reduced system in [Lemma L104](../findings/bounds-relaxations.md) without looking at the recorded answers first. Applying a multiplier polynomial $\varphi(x)=x^2-sx+p$ to row $i$ means forming $p(\mathrm A_i)-s(\mathrm B_i)+(\mathrm C_i)$. On the mixed types $j<k$ the three coefficient blocks are $2\mu_j\mu_k$, $\mu_j\mu_k(\nu_j+\nu_k)$ and $2\mu_j\mu_k\nu_j\nu_k$, so the combination is $2\mu_j\mu_k\big[p-\tfrac s2(\nu_j+\nu_k)+\nu_j\nu_k\big]=2\mu_j\mu_k\,\psi(\nu_j,\nu_k)$; on the repeated types it is $\mu_j(\mu_j-1)\varphi(\nu_j)$. So $\psi(x,y)=xy-\tfrac s2(x+y)+p$ is forced, and it is the polarisation the record names, with $\psi(x,x)=\varphi(x)$.

The right-hand side is then $2(n-2)p+2s\nu_i+2\nu_i\theta-2\nu_i^2$ in every case, and the two recorded forms fall out. **Double root** $\varphi=(x-\nu_r)^2$, so $p=\nu_r^2$, $s=2\nu_r$: $\mathrm{rhs}/2=(n-2)\nu_r^2-\nu_i^2+2\nu_i\nu_r+\nu_i\theta$, exactly as claimed, and $\psi(x,y)=(x-\nu_r)(y-\nu_r)$ annihilates a type iff one of its two non-row indices is $r$, three types survive, as claimed. **Four-type** $\varphi=(x-\nu_a)(x-\nu_b)$ with $a=i$, $b=j$: $\mathrm{rhs}=2(n-2)\nu_i\nu_j+2(\nu_i+\nu_j)\nu_i+2\nu_i\theta-2\nu_i^2=2\nu_i[(n-1)\nu_j+\theta]$, again as claimed.

**What the record's sentence gets wrong.** With $a,b$ both distinct from $i$ the same formula gives $2\big[(n-2)\nu_a\nu_b-\nu_i^2+\nu_i(\nu_a+\nu_b+\theta)\big]$, which is the quadratic column of [DERIVE-sp3c](DERIVE-sp3c.md)'s table and is not of the stated form. The classification table only ever counts six four-type identities, so nothing downstream breaks; the *statement* introducing it does.

**The pair-cut coefficients check out termwise**, which matters because S5 turns on their signs. Row $1$ against $\varphi=(x-\nu_1)(x-\nu_2)$: $\psi(\nu_1,\nu_2)=-\tfrac12(\nu_1-\nu_2)^2$, $\psi(\nu_1,\nu_3)=-\tfrac12(\nu_1-\nu_2)(\nu_1-\nu_3)$, $\psi(\nu_2,\nu_3)=\tfrac12(\nu_1-\nu_2)(\nu_2-\nu_3)$, $\varphi(\nu_3)=(\nu_1-\nu_3)(\nu_2-\nu_3)$, giving precisely the four coefficients [DERIVE-sp3c](DERIVE-sp3c.md) displays, with $t_{123}$ and $t_{133}$ the positive pair.

## S2, the classification, recounted from the definitions

Notation for the fifteen identities: `dr(i,r)` is row $i$ against the double root $\nu_r$, forbidding the three-subset $\{i\}\cup\{jj,jk,kk\}$ with $\{j,k\}=\{1,2,3\}\setminus\{r\}$; `ft(i,j)` is row $i$ against $(x-\nu_i)(x-\nu_j)$, forbidding row $i$'s six types minus $\{iii\}$ and $\{ijj\}$. Units $\lvert\nu_3\rvert=1$, so $\nu_3=-1$, $\nu_1=\rho_1>0$, and $\nu_2\in(-1,\rho_1)$ of unknown sign but nonzero. The standing facts used are $T\ge0$, $\theta>0$, kernel-freeness, the $\Pi$-bound $\theta\le n-1$ ([Lemma L107](../findings/bounds.md)) and [Lemma L73](../findings/bounds.md)'s $1\le(n-2)\rho_1$, all proved and unconditional, so leaning on them costs no hypothesis.

**The four-type six.** $\mathrm{rhs}=2\nu_i[(n-1)\nu_j+\theta]$, and the forbidding logic needs only that this be **nonzero**, the record's own rule, "a nonzero right-hand side forbids the surviving type-set". So the factor $\nu_i$ is disposed of by kernel-freeness alone, whatever its sign, and everything turns on the bracket.

| identity | forbidden four-subset | bracket | what it needs |
|---|---|---|---|
| ft(2,1) | $\{122,123,223,233\}$ | $(n-1)\nu_1+\theta>0$ | **nothing** |
| ft(3,1) | $\{123,133,223,233\}$ | $(n-1)\nu_1+\theta>0$ | **nothing** |
| ft(1,3) | $\{112,113,122,123\}$ | $\theta-(n-1)$ | $\Pi$ strict |
| ft(2,3) | $\{112,122,123,223\}$ | $\theta-(n-1)$ | $\Pi$ strict |
| ft(1,2) | $\{112,113,123,133\}$ | $(n-1)\nu_2+\theta$ | that bracket $\ne0$ |
| ft(3,2) | $\{113,123,133,233\}$ | $(n-1)\nu_2+\theta$ | that bracket $\ne0$ |

So the recorded "free $1$ / needs $\nu_2$ four / needs $\Pi$ strict one" is wrong three times over; it should read $2/2/2$. The two errors that matter are **ft(2,1)**, which the record puts in the $\nu_2$ column although $\nu_2[(n-1)\nu_1+\theta]$ cannot vanish on a kernel-free spectrum, and **ft(2,3)**, which needs $\Pi$-strictness and not $\nu_2$ at all. The claim in S2 that "the PAIR CUT is not free, it is $\nu_1[(n-1)\nu_2+\theta]$" is right, and is the ft(1,2) row above; but the pair cut and ft(1,2) are different deductions from one identity, and only the weaker one (nonvanishing) is available from $\ne0$. See S5.

**The double-root nine.** The diagonal three come out as the record has them: $\mathrm{rhs}/2=\nu_i[(n-1)\nu_i+\theta]$, free at $i=1$, gated on the bracket at $i=2$, gated on $\Pi$-strictness at $i=3$. Of the six off-diagonal, two are free of $\nu_2$ and I reproduce both thresholds independently:

- dr(3,1), forbidding $\{223,233,333\}$: $\mathrm{rhs}/2=(n-2)\rho_1^2-1-2\rho_1-\theta\ \ge\ (n-2)\rho_1^2-2\rho_1-n=(\rho_1+1)\big[(n-2)\rho_1-n\big]$ by the $\Pi$-bound, positive exactly for $\rho_1>n/(n-2)$.
- dr(1,3), forbidding $\{111,112,122\}$: $\mathrm{rhs}/2=(n-2)-\rho_1^2-2\rho_1+\rho_1\theta\ \ge\ (n-1)-(\rho_1+1)^2$, positive for $\rho_1<\sqrt{n-1}-1$.

Both thresholds and the $n\ge7$ coverage $\sqrt{n-1}-1\ge n/(n-2)$ are confirmed, as is the $n=6$ gap. *A small addendum:* substituting [Lemma L70](../findings/bounds.md)'s $\theta\le-1+(n-2)\rho_1$ into the first gives $\rho_1[(n-2)\rho_1-n]$ (the same threshold) so the two standing spectral bounds do not separate here and $n/(n-2)$ is sharp for this argument.

The remaining four, dr(1,2), dr(2,1), dr(2,3), dr(3,2), genuinely depend on $\nu_2$, so the count "five" (with $i=r=2$) is right. **But "needs the sign of $\nu_2$" over-promises**: supplying $\nu_2>0$ settles only $i=r=2$ and dr(2,1), for dr(2,1), $0<\nu_2<\nu_1$ makes $(n-2)\nu_1^2>\nu_2^2$ and the other two terms positive. dr(1,2), dr(2,3), dr(3,2) stay quadratic conditions in $(\rho_1,\nu_2,\theta)$ under either sign. The column is a list of identities whose right-hand side *contains* $\nu_2$, not of identities the sign resolves.

## S3, the chain, recounted

The bookkeeping is a screen: the fifteen forbidden sets above against the $\binom{10}4=210$ four-subsets, on label sets I construct here, reported as a screen. *What would falsify my reading:* if the enumeration returned $195$ for the free set with ft(2,1) added, or something other than $195$ for the record's own three-identity free set, my hand count would be wrong. It returned $195$ and $194$ respectively, matching the inclusion–exclusion I did first by hand: the four removal families $\{$ft(3,1)$\}$, $\{$ft(2,1)$\}$, the $7$ supersets of $\{122,123,133\}$ and the $7$ supersets of the applicable $n\ge7$ three-subset are pairwise disjoint, $16$ in all.

**So the recorded chain is arithmetically correct on its own inputs and wrong on the inputs.** The corrected hypothesis-free chain is $210\to209\to208\to201\to\mathbf{194}$, ft(3,1), ft(2,1), then $\{122,123,133\}$, then whichever of the two $\rho_1$ conditions holds. The disjointness in both $\rho_1$ cases: $\{122,123,223,233\}$ contains neither $133$ nor $111$ nor $333$, so it lies outside all three of the other families.

**And $194$ is not the honest figure either, because an unconditional dichotomy is available.** Either $(n-1)\nu_2+\theta>0$, or $(n-1)\nu_2+\theta\le0$, and in the second case $\theta>0$ forces $\nu_2<0$ and $\theta\le(n-1)\lvert\nu_2\rvert<(n-1)\lvert\nu_3\rvert$, since $\nu_3<\nu_2<0$ gives $\lvert\nu_2\rvert<\lvert\nu_3\rvert$. **The second case is $\Pi$-strictness.** No hypothesis on the sign of $\nu_2$ enters, and the two cases exhaust the possibilities.

- *Bracket-positive branch.* ft(1,2), ft(3,2), dr(2,2) all hold, and so does the pair cut, whose right-hand side $2\nu_1[(n-1)\nu_2+\theta]$ is now positive rather than merely nonzero. With the free set: **$168$**.
- *$\Pi$-strict branch.* dr(3,3), ft(1,3), ft(2,3) hold. With the free set: **$185$**.

Two more identities are free on that second branch, from $\lvert\nu_2\rvert<\lvert\nu_3\rvert$, which the classification never uses. Write $\nu_2=-\beta$ with $\beta\in(0,1)$ and $\theta\le(n-1)\beta$.

- dr(2,3), forbidding $\{112,122,222\}$: $\mathrm{rhs}/2=(n-2)-\beta^2+2\beta-\beta\theta\ \ge\ (n-2)+2\beta-n\beta^2=(n\beta+n-2)(1-\beta)>0$.
- the quadratic four-type at row $2$ with roots $\nu_1,\nu_3$, forbidding $\{122,123,222,223\}$: $\mathrm{rhs}/2=-(n-2)\rho_1-\beta\rho_1-\beta\theta+\beta(1-\beta)\le-1+\tfrac14<0$, using $\beta(1-\beta)\le\tfrac14$ and [Lemma L73](../findings/bounds.md)'s $(n-2)\rho_1\ge1$.

That branch then reads **$178$** (177 when $\rho_1>n/(n-2)$), so the worst case over the dichotomy is $178$. **The hypothesis-free figure is $178$, against the recorded $195$**, and none of the sixteen identities used carries a hypothesis the record does not already prove.

For completeness, my recount of the two conditional rows: under $\nu_2>0$, everything above plus dr(2,1) gives $161$–$162$, not $173$, the recorded figure is loose rather than wrong, because it does not use the pair cut or dr(2,1) at that point. Under all fifteen identities plus the pair cut the count is $130$, which reproduces the recorded bottom of the chain exactly.

## S4, the branch

**The sign is undetermined, and I confirm it, but the recorded reason is the weak form.** [Lemma L35](../findings/stratum-two-negative.md) needs *at most two* negative eigenvalues; at $d=3$ with every $m_i\ge3$ the class of $\nu_3$ alone supplies three, so L35 is inapplicable on **both** branches and cannot distinguish them. Saying it fails because $\nu_2<0$ leaves $m_2+m_3\ge6$ negatives makes the failure sound branch-specific when it is not. Tracelessness gives $\nu_1>0>\nu_3$ and nothing more; L73 constrains only $\rho_1\in[1/(n-2),\,n-2]$; the pinned system's dependencies do not see the sign. So branching is required, though "undetermined" is a statement about the record's reach, no $\nu_2<0$ witness being on file, and I mark that half PLAUSIBLE rather than proved.

**"Exactly one identity" is REFUTED.** Relative to $\nu_2>0$, the $\nu_2<0$ branch loses four: ft(1,2), ft(3,2), dr(2,2), the three whose right-hand side is a nonzero multiple of $(n-1)\nu_2+\theta$, all vanishing on the single locus $\theta=(n-1)\lvert\nu_2\rvert$, and **dr(2,1)**, forbidding $\{222,223,233\}$, which is positive under $\nu_2>0$ and merely undetermined under $\nu_2<0$. dr(2,1) does not vanish on that locus, so second-$\Pi$-strictness does not reach it; what it does need is $\rho_1>n\beta/(n-2)$, which the free set's own case split does not supply. The recorded table is scoped to the three *diagonal* identities and within that scope its count of one is correct; the boxed conclusion drawn from it is not scoped, and S4 states it unscoped.

**Something else flips, and it is the pair cut.** Under $\nu_2>0$ the cut reads "no vertex support contains both $\{123\}$ and $\{133\}$", worth $28$ four-subsets. It is derived by moving the two negatively-signed terms of the row-$1$ identity across and needs the right-hand side **strictly positive**. Under $\nu_2<0$ with $\theta<(n-1)\lvert\nu_2\rvert$ the right-hand side is strictly *negative* and the inequality points the other way, the cut is not weakened, it is gone.

## S5, the repair

**It does not do what is claimed for the pair cut, and that is decisive.** $\theta\ne(n-1)\lvert\nu_2\rvert$ leaves $\theta<(n-1)\lvert\nu_2\rvert$ open, which is exactly the region where the pair cut's sign fails. The recorded sentence "rescues the $\nu_2$ row, two of the six clean four-subsets, and the pair cut" is right on the first two items and wrong on the third; and since it also misses dr(2,1), the branches do not agree under it.

**It is a legitimate hypothesis in the sense that it excludes nothing the record cares about, and it is also unnecessary.** On $\nu_2<0$ the two degeneracies are mutually exclusive, $\lvert\nu_2\rvert<\lvert\nu_3\rvert$ makes $\theta=(n-1)\lvert\nu_2\rvert$ imply $\Pi$ strict, and $\theta=(n-1)\lvert\nu_3\rvert$ imply second-$\Pi$ strict, so at most one of the two identity triples can be lost, ever. That is the dichotomy of S3, it assumes nothing, and it strictly dominates the repair: the repair buys three identities on one branch, the dichotomy buys three on whichever branch you are on. **A hypothesis that can be replaced by a case split on a quantity already in the system should be.**

**What Lemma L71 actually says, and why it does not transfer.** [Lemma L71](../findings/bounds.md) is about saturation of [Lemma L70](../findings/bounds.md), $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$, and it forces the balanced sphere product. Reviewer 323, recorded in the same file, sharpens saturation to *$\Pi$-saturation together with $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$*. So L71 characterises a **strictly stronger** condition than $\Pi$-saturation, and $\Pi$-saturation alone is known to hold away from the maximiser, [Lemma L105](../findings/bounds-relaxations.md)'s own reading of the facet $t_{112}=0$ puts the $n=8$ maximal torus at $0.540062$ and $\mathrm{ad}(\mathfrak{su}(3))$ at $0.836660$ on it. So "the record can test it, since Lemma L71 characterises $\Pi$-saturation" is false as stated, and $\Pi$-strictness is a real hypothesis excluding real critical points rather than only the known extremum.

**And the middle eigenvalue has no bound to saturate.** The $\Pi$-bound comes from row $\arg\max$ of (C) with $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_{\max}$; the identity $\theta=(n-1)\lvert\nu_2\rvert$ is not the equality case of any proved inequality, because $\theta\le(n-1)\lvert\nu_2\rvert$ is *strictly stronger* than the $\Pi$-bound when $\nu_2<0$ and is not on the record. Second-$\Pi$-saturation is a coincidence locus strictly inside the feasible region, not a saturation. Nothing of L71's rigidity content reaches it, and naming it by analogy with $\Pi$ invites the reading that it inherits a classification it does not have.

## What I would fix, in order

1. **[bounds-relaxations.md](../findings/bounds-relaxations.md)'s reconciliation table**: four-type row becomes free $2$ / needs $\Pi$ strict $2$ / needs $(n-1)\nu_2+\theta\ne0$ $2$, naming ft(2,1) and ft(3,1) as the free pair; double-root column heading becomes "contains $\nu_2$" rather than "needs the sign of $\nu_2$", with the note that only two of the five are settled by that sign.
2. **The hypothesis-free chain**: $210\to209\to208\to201\to194$ on the corrected free set, then $\to178$ through the dichotomy, replacing $195$. The three figures now on record for this quantity ($192$, $201$, $195$), are all wrong, and the pattern is that each was computed from a free set rather than from the definitions.
3. **The branch section**: state the cost as four identities, name dr(2,1) as the one the repair misses, and record that the pair cut loses its direction rather than its nonvanishing.
4. **Replace second-$\Pi$-strictness by the dichotomy**, and strike the sentence attributing a $\Pi$-saturation characterisation to Lemma L71.

*Method note: no computation beyond the four-subset bookkeeping screen, declared above with its falsifier. Every right-hand side, threshold and sign in this report was derived by hand from (A), (B), (C).*
