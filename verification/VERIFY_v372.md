# Verifier v372, Lemma L20: the tube exclusion at radius 0.5748, its cubic expansion, the eigenvalue input, the radius arithmetic, the witness at both parities, the canonical statement and the Lean declarations

Cold brief ([BRIEF_L20r2.md](BRIEF_L20r2.md)). No numerical work, no scripts written, no computations run. Every value below is exact: a closed form, an exact rational, or a terminating decimal obtained by hand multiplication of the step's own numbers. The source of every quoted passage was re-read at the cited lines ([route-a.md](../findings/route-a.md) lines 103, 121-135 odd, 174, and [results.md](../results.md) lines 321, 1063, 1065) and matches the brief. Imported theorems were read at source in [the Nienhaus extraction](https://arxiv.org/abs/2311.02404) (Proposition 2.25 at L1483, the normalisation at L1443, Theorem 4.14 at L4365, Remark 4.16 at L4657, Theorem 4.17 at L4698). The Lean files were read only as the brief quotes them and were not built. Log: [agent_logs/verify-L20-v372.log](../agent_logs/verify-L20-v372.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The three proof hypotheses (invariance of $d$, nearest point with first variation, $\varphi>0$) hold and are the ones used | CONFIRMED |
| 2 | The expansion $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ is exact with no linear term | CONFIRMED |
| 3 | $\alpha\le\tfrac13$ on the transverse space, supplied by Passage B at $n\ge12$ | CONFIRMED (conditional on L21, a given with its own debt) |
| 4 | $\gamma_V\le m$ and $m\le\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$ | CONFIRMED |
| 5 | $\psi\le1\iff\sin\varphi\le s^*$ on $[0,\pi/2)$, with $s^*$ the unique real root of $s^3+s^2+s=1$ | CONFIRMED |
| 6 | $\sin(0.5748)<0.543672$ in exact rationals and $0.5436890<s^*$ | CONFIRMED |
| 7 | The decimals $0.9785933$, $0.3747372$, $0.5748263$, $0.9999937$, $0.5830224$, $1.0020125$ | HYPOTHESIS-DEBT (none is used by the proof, the location $\sin\varphi=\tfrac{\sqrt3-1}2$ is CONFIRMED in closed form) |
| 8 | A unit Weyl operator with $P>\sqrt{3/2}$ exists at both parities for every $n\ge12$ | CONFIRMED |
| 9 | The degenerate branch $\varphi=0$, and "the contradiction is with the value" | CONFIRMED |
| 10 | Passage C ([results.md](../results.md) line 1065) against Passage A | REFUTED AS STATED (names $\theta_0(n)$ as the attained witness value, false at odd $n$, and drops the conditional qualifier that line 321 and Passage A carry) |
| 11 | Passage D against Passages A and C | CONFIRMED AS ALGEBRA (one sorry, whose content the prose discharges, and every geometric input untyped) |
| 12 | The boundary: $n=12$, $n=13$, $\ker W^*\ne0$, orbit regularity | CONFIRMED |

**What the round should do:** keep L20's proof as written and correct [results.md](../results.md) line 1065 to name $\Theta_n$ as the witness value and to state the dependence on L21's $\alpha\le\tfrac13$, and align Passage A's sourcing of that input with L21.

## 0. Conventions, fixed once

- $\mathcal W_n=\mathrm{Weyl}_n$ with the Frobenius inner product, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$.
- $B(Y,Z)=\tfrac12(YZ+ZY)+Y\#Z$ is the polarisation of $Q$, so $Q(Y)=B(Y,Y)$, and $T(X,Y,Z)=\langle X,B(Y,Z)\rangle$.
- $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, unit norm, $Q(u)=\theta^*u$, $\theta^*=\sqrt{3/2}$. $\mathcal O=SO(n).u$. $F_u=B(u,\cdot)$.
- $d$ is geodesic distance on the unit sphere, $\cos d(X,Y)=\langle X,Y\rangle$.
- $m=\sqrt{2/3}\max P$, so $m>1\iff\max P>\theta^*$.
- $c=\cos\varphi$, $s=\sin\varphi$, $s^*$ the real root of $s^3+s^2+s-1$.
- $\theta_{k,l}^2=2\frac{k-1}k\frac{l-1}l\frac{n-1}{n-2}$ is Nienhaus's Proposition 2.25 value for the normalised Weyl operator of $S^k\times S^l$, $k+l=n$.

## Hypothesis inventory

| Hypothesis | Where it enters | Checked against the object | Used by the written proof |
|---|---|---|---|
| $n\ge12$ | statement | the witness polynomials and L21's $n\ge9$ | yes, in the witness (section 8) and to invoke Passage B |
| $W^*$ is a maximiser of $P$ on the unit sphere | statement | exists by compactness | yes, in $\gamma_V\le m$ and in $m=\sqrt{2/3}P(W^*)$ |
| $d$ geodesic | Passage A line 121 | commits $\cos d=\langle\cdot,\cdot\rangle$, which the decomposition $W^*=cu+sV$ needs | yes |
| $d$ is $SO(n)$-invariant | Passage A line 123 | $SO(n)$ acts orthogonally on $\mathcal W_n$, so this holds automatically | yes, in the rotation step |
| $P$ is $SO(n)$-invariant | Passage A line 123 | conjugation commutes with squaring and with $\#$ | yes, in the rotation step |
| the orbit is a compact embedded submanifold | Passage A line 123 | an orbit of a compact Lie group under a smooth action is one | partly: existence of a nearest point needs compactness only, and the first-variation condition needs only the curves $t\mapsto e^{tX}.u$ (section 1) |
| $\varphi>0$ | Passage A line 123 | a case split, the complement is the degenerate branch | yes, to define $V=(W^*-cu)/s$ |
| $Q(u)=\theta^*u$ | Passage A line 123, brief's definitions | Nienhaus L1716 ff. and the brief | yes, for the vanishing linear term |
| $T$ fully symmetric | Passage A line 123 ("polarization $T$") | Nienhaus L4704: $\mathrm{tri}(R,S,T)=\mathrm{tr}((RS+SR+2R\#S)T)$ is symmetric in all three arguments | yes, in both the linear and the quadratic coefficient |
| L21: $n\ge9$, $u$ padded, unit $V\in u^\perp\cap T_u\mathcal O^\perp$, conclusion $\alpha\le\tfrac13$ | Passage B | $n\ge12\ge9$, the same $u$, the same space (section 3) | yes. The clause "and $\tfrac13$ is attained" is unused, which is harmless |
| Nienhaus Theorem 4.14, $n\ge9$ | Passage A line 125 as the discussed citation | read at L4365, cases (a)-(g) | not used once Passage B is the source |
| Nienhaus Remark 4.16 | Passage A line 125 | read at L4657, identifies $T_u\mathcal O$ with the (b) eigenspace "by dimension comparison" | not used once Passage B is the source |
| Nienhaus Proposition 2.25, normalised $W_{S_{k,l}}$ | the witness, line 131 | read at L1483 and L1443, unit norm and $P=\theta_{k,l}$ | yes |
| $\sin x\le x-\tfrac{x^3}6+\tfrac{x^5}{120}$ for $x\ge0$ | line 131 | elementary, no argument on file (section 6) | yes |
| $\sin$ increasing on $[0,0.5748]$ | line 131 | $0.5748<3/2<\pi/2$ | yes |
| $m\ge0$ | nowhere stated | not needed | no, and correctly so (section 4) |

No hypothesis is used without being stated, apart from the elementary Taylor bound, which is standard. The "compact embedded submanifold" clause is stronger than what is used and is true.

## 1. The three proof hypotheses

Rotation step. Let $g.u$ be a nearest orbit point to $W^*$. Replace $W^*$ by $g^{-1}.W^*$. It is still a maximiser because $P$ is invariant, and its distance to $\mathcal O$ is unchanged because $d$ is invariant. Its nearest orbit point is now $u$. Correct.

First variation. Minimising $d(W^*,h.u)=\arccos\langle W^*,h.u\rangle$ over $h\in SO(n)$ is maximising $\langle W^*,h.u\rangle$. At $h=1$ the derivative along $e^{tX}$ is $\langle W^*,X.u\rangle=0$ for every $X\in\mathfrak{so}(n)$, so $W^*\perp T_u\mathcal O$. Since $\|h.u\|=1$, also $u\perp T_u\mathcal O$. Hence $V=(W^*-cu)/s$ is a unit vector in $u^\perp\cap T_u\mathcal O^\perp$ when $s>0$. On $\varphi\le0.5748<\pi/2$ the case $s>0$ is exactly $\varphi>0$. Each of the three hypotheses is used where Passage A says, and each holds for the objects at hand.

Candidate 1a, "the submanifold hypothesis may fail". Located: line 123, "that the orbit is a compact embedded submanifold". Exhibit: none exists, every orbit of the compact group $SO(n)$ acting smoothly is a compact embedded submanifold, and the argument needs only compactness and smooth curves. Charitable reading: the clause is a statement of a true fact. Withdrawn (no failure can be exhibited).

## 2. Exactness of the expansion

With $W^*=cu+sV$ and $T$ trilinear and fully symmetric,
$$P(W^*)=c^3T(u,u,u)+3c^2s\,T(u,u,V)+3cs^2\,T(u,V,V)+s^3T(V,V,V).$$
This is the binomial expansion of a symmetric trilinear form and has no remainder.

- $T(u,u,u)=P(u)=\theta^*$, so $\sqrt{2/3}\,c^3\theta^*=c^3$.
- $T(u,u,V)=\langle V,B(u,u)\rangle=\langle V,Q(u)\rangle=\theta^*\langle V,u\rangle=0$. This uses only $Q(u)=\theta^*u$, $V\perp u$ and full symmetry. It does not use the first-variation condition, as Passage A says.
- $T(u,V,V)=\langle V,B(u,V)\rangle=\langle F_uV,V\rangle$ by full symmetry, so the coefficient is $3cs^2\alpha$ with $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$.
- $T(V,V,V)=P(V)$, so the last term is $s^3\gamma_V$.

Full symmetry of $T$: for symmetric matrices $\mathrm{tr}(XYZ)$ is invariant under cyclic shifts and under reversal, which generate $S_3$, and $\langle X,Y\#Z\rangle$ is fully symmetric (Nienhaus L4704 states the combined form is). The coefficient $\tfrac12(uh+hu)+u\#h$ matches the derivative of $Q$: $\tfrac{d}{dt}Q(u+th)|_0=uh+hu+2u\#h=2F_u(h)$. The polarisation coefficients are correct.

Which hypothesis each step uses: invariance of $d$ and of $P$ in the rotation, the nearest point and first variation only to put $V$ in $T_u\mathcal O^\perp$ (needed in section 3, not here), $\varphi>0$ only to define $V$.

Test on a closed-form object: at $\varphi=0$ the right side is $1=\sqrt{2/3}P(u)$, matching. CONFIRMED.

## 3. The eigenvalue input $\alpha\le\tfrac13$

Passage B gives, for $n\ge9$, $u$ padded and of unit norm, and unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$, that $\alpha\le\tfrac13$ with $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ and $F_u(h)=\tfrac12(uh+hu)+u\#h$.

- Dimension: $n\ge12$ lies in $n\ge9$.
- Object: the same padded $u$, the same $F_u$, the same $\alpha$.
- Space: Passage A's $u^\perp\cap T_u(SO(n).u)^\perp$ is Passage B's space verbatim, and section 1 places $V$ in it.

So the step is exactly an application of Passage B. Passage B is a Rayleigh-quotient bound and needs no invariance argument from L20. For the record, the structure behind it is consistent: differentiating $Q(e^{tX}.u)=\theta^*e^{tX}.u$ gives $2F_u(X.u)=\theta^*X.u$, so $T_u\mathcal O$ lies in the $\tfrac12\theta^*$-eigenspace (Nienhaus Remark 4.16, L4657, derives the same and identifies the two by dimension comparison), and $F_u$ is self-adjoint, so $u^\perp\cap T_u\mathcal O^\perp$ is $F_u$-invariant.

Passage A's remark that without first variation the bound $\alpha\le\tfrac12$ leaves the interval empty was checked in closed form: $c(1+\tfrac{s^2}2)\le1-s^3$ is, after squaring two nonnegative sides, $(1-s^2)(1+\tfrac{s^2}2)^2\le(1-s^3)^2$, that is $1-\tfrac34s^4-\tfrac14s^6\le1-2s^3+s^6$, that is $8\le3s+5s^3$ for $s>0$, which fails on all of $(0,1)$. The remark is correct.

Debt carried: Passage A calls the input "the lemma's one unproved input" and the brief records that L21 carries its own debt. L20 is therefore proven relative to L21. CONFIRMED, conditional on L21. How the record expresses that dependence is section 10.

## 4. $\gamma_V\le m$ and the step to $\psi$

$V$ is a unit element of $\mathcal W_n$, so $\sqrt{2/3}P(V)\le\sqrt{2/3}\max P=m$. Correct, for every unit $V$, including $V$ with nontrivial kernel.

Substitution needs signs: the term $3cs^2\alpha$ is bounded by $3cs^2\cdot\tfrac13$ because $cs^2\ge0$, which holds since $c\ge0$ on $[0,0.5748]$. The term $s^3\gamma_V$ is bounded by $s^3m$ because $s^3\ge0$. Then $m\le c^3+cs^2+s^3m=c+s^3m$ using $c^2+s^2=1$. Since $s\le0.5436710<1$, $1-s^3>0$ and division gives $m\le\psi(\varphi)$. The sign of $m$ is never used, and none is needed. CONFIRMED.

## 5. The reduction $\psi\le1\iff s\le s^*$

Both $c$ and $1-s^3$ are positive, so $\psi\le1\iff c\le1-s^3\iff c^2\le(1-s^3)^2\iff 1-s^2\le1-2s^3+s^6\iff s^2(1-2s+s^4)\ge0$. And $1-2s+s^4=(1-s)(1-s-s^2-s^3)$, which is the ring identity TubeRadius.lean's quartic_factors states as $s^4-2s+1=(s-1)(s^3+s^2+s-1)$. For $0\le s<1$ the product is nonnegative iff $s=0$ or $1-s-s^2-s^3\ge0$, and since $s^3+s^2+s$ has derivative $3s^2+2s+1$ with discriminant $4-12<0$ it is strictly increasing, so the condition is $s\le s^*$ with $s^*$ unique. The squaring is legitimate because $c\ge0$ is available on the range, which is where the restriction $\varphi<\pi/2$ enters. CONFIRMED.

## 6. The radius arithmetic

With $x=0.5748=5748/10^4$, the hand products are exact terminating decimals:

- $5748^3=189{,}911{,}068{,}992$, so $x^3=0.189911068992$ and $x^3/6=0.031651844832$.
- $5748^5=1437^5\cdot4^5=6{,}127{,}507{,}347{,}270{,}957\cdot1024=6{,}274{,}567{,}523{,}605{,}459{,}968$, so $x^5=0.06274567523605459968$ and $x^5/120=0.000522880626967121664$.
- $x-\tfrac{x^3}6+\tfrac{x^5}{120}=0.543671035794967121664<0.543672$.

The Taylor bound $\sin x\le x-\tfrac{x^3}6+\tfrac{x^5}{120}$ for $x\ge0$ has no argument on file but is elementary: $g(x)=x-\tfrac{x^3}6+\tfrac{x^5}{120}-\sin x$ has $g=g'=g''=g'''=g''''=0$ at $0$ and $g^{(5)}=1-\cos x\ge0$. Monotonicity of $\sin$ on $[0,0.5748]$ holds since $0.5748<\pi/2$. Then $0.543672<0.5436890$, and TubeRadius.lean's bracket_tight states cubic$(5436890/10^7)<0$, which together with strict increase of $s^3+s^2+s-1$ on $s\ge0$ gives $0.5436890<s^*$. The last implication (that $s^*$ exists and lies above every point where the cubic is negative) is not typed in Lean, since $s^*$ is not defined there, and it is immediate from the intermediate value theorem and monotonicity. CONFIRMED.

## 7. The decimals

- The location of the minimum: $\psi'(\varphi)=\dfrac{-s(1-s^3)+3s^2c^2}{(1-s^3)^2}=\dfrac{s(-2s^3+3s-1)}{(1-s^3)^2}$ and $2s^3-3s+1=(s-1)(2s^2+2s-1)$, whose root in $(0,1)$ is $s=\tfrac{\sqrt3-1}2$. CONFIRMED in closed form.
- $0.9785933$, $0.3747372$, $0.5748263$, $\psi(0.5748)=0.9999937$, the chord angle $0.5830224$, and $\psi=1.0020125$ there: no derivation is on file for any of them, so each is supported only by evaluation. HYPOTHESIS-DEBT.
- None is used. The contradiction uses only $\psi\le1$ on $[0,0.5748]$, which section 5 and section 6 establish exactly. The qualitative claims attached to them are exact: $\psi(0)=1$, $\psi<1$ for $0<s<s^*$, $\psi>1$ for $s^*<s<1$ from the factorisation in section 5, so the true crossing is $\arcsin s^*$ and $0.5748$ lies below it because $\sin0.5748<s^*$. "Truncated in the safe direction" is CONFIRMED exactly. The chord remark is motivation for fixing the metric and carries no weight in the proof.

## 8. The witness at both parities

Nienhaus Proposition 2.25 (L1483) with the normalisation at L1443 gives unit Weyl operators $W_{S_{k,l}}$ with $P=\theta_{k,l}$.

- Even $n$, $k=l=n/2$: $\theta^2=2\big(\tfrac{n-2}n\big)^2\tfrac{n-1}{n-2}=\tfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. $\theta_0^2>\tfrac32\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$, roots $6\pm2\sqrt7$, and $2\sqrt7\in(5,6)$ since $25<28<36$. So from $n=12$: $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}>\tfrac{54}{36}$.
- Odd $n$, $k=\tfrac{n+1}2$, $l=\tfrac{n-1}2$: $\tfrac{k-1}k=\tfrac{n-1}{n+1}$ and $\tfrac{l-1}l=\tfrac{n-3}{n-1}$, so $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$. $\Theta_n^2>\tfrac32\iff4(n-1)(n-3)>3(n+1)(n-2)\iff n^2-13n+18>0$, roots $\tfrac{13\pm\sqrt{97}}2$, and $9<\sqrt{97}<10$ puts the larger root in $(11,11.5)$. At $n=13$: $\Theta_{13}^2=\tfrac{2\cdot12\cdot10}{14\cdot11}=\tfrac{120}{77}>\tfrac32$ since $240>231$.
- For $n\ge12$ both quadratics are increasing (vertices at $6$ and $6.5$) and positive at $12$ ($8$ and $6$), so both clear from $n\ge12$.

At odd $n$ no sphere product has value $\theta_0(n)$: with $k+l=n$, $\tfrac{k-1}k\tfrac{l-1}l=1-\tfrac{n-1}{kl}$ and $\big(\tfrac{n-2}n\big)^2=1-\tfrac{4(n-1)}{n^2}$, so equality forces $kl=n^2/4$, that is $k=l=n/2$, impossible at odd $n$. Passage A handles this correctly. The witness need not be the best split, only a unit Weyl operator with $P>\theta^*$, which each is. CONFIRMED.

## 9. The degenerate branch and "the contradiction is with the value"

At $\varphi=0$, $W^*\in\mathcal O$, so $\max P=P(W^*)=P(u)=\theta^*$, contradicting section 8's witness. No $V$, no first variation and no L21 are needed. The argument uses only that $\max P>\theta^*$ and never where the witness sits relative to the tube. Both CONFIRMED.

Quantifier order: the statement is for every $n\ge12$ and every maximiser $W^*$, $d(W^*,\mathcal O)>0.5748$. The proof fixes $n$, takes "some $W^*$" at which the maximum is attained, and uses no property of it beyond being a maximiser, so the argument applies to each maximiser. The radius is independent of $n$, and the only $n$-dependence sits in Passage B's range and the witness.

Candidate 9a, "the proof treats one maximiser and the statement quantifies over all". Located: line 123, "attained, at some $W^*$". Exhibit: no maximiser escapes, since nothing specific to the chosen $W^*$ is used. Charitable reading: "some" introduces an arbitrary maximiser. Withdrawn.

## 10. Passage C against Passage A

Range $n\ge12$, radius $0.5748$ and geodesic metric agree across line 321, line 1065 and Passage A ("angular distance" at 1065 is the geodesic reading of $\cos d=\langle\cdot,\cdot\rangle$). Two discrepancies survive.

Candidate 10a, the witness value at odd $n$.

- Located: [results.md](../results.md) line 1065, "contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains".
- Exhibited: at $n=13$ the best split $S^7\times S^6$ attains $\Theta_{13}^2=\tfrac{120}{77}$, while $\theta_0(13)^2=\tfrac{264}{169}$, and $\tfrac{120}{77}\ne\tfrac{264}{169}$ since $120\cdot169=20280\ne20328=264\cdot77$. Section 8 shows no split at odd $n$ attains $\theta_0(n)$.
- Opposite argued: "the sphere product" might mean the parity-appropriate one, with $\theta_0(n)$ as loose shorthand. The sentence names the value $\theta_0(n)$ and calls it attained, and at odd $n$ that value is attained by no sphere product, so the charitable reading does not rescue the sentence. The conclusion survives because $\Theta_n>\theta^*$ for odd $n\ge13$ (section 8), so the defect is in the statement's wording, not the mathematics.
- Stands. REFUTED AS STATED. Correction: "contradicting the value $\Theta_n>\theta^*$ the best sphere product attains, $\Theta_n=\theta_0(n)$ at even $n$".

Candidate 10b, the qualifier and the source of $\alpha\le\tfrac13$.

- Located: line 321 says the chain "is **conditional on one input nothing on the record proves**". Passage A line 125 calls it "the lemma's one unproved input" and discusses only Nienhaus as its citation. Line 1065 says "with the eigenvalue bound $\alpha\le\tfrac13$ of [Lemma L21]" with no conditional qualifier, and the heading at 1063 and Passage A's heading say "for every $n\ge12$" without one.
- Exhibited: a reader of 1065 alone takes L20 as unconditional, while line 321 and Passage A make it conditional. The two canonical statements of one result carry different hypotheses.
- Opposite argued: citing L21 by name transmits L21's recorded debt to anyone who follows the link, and "nothing on the record proves" is compatible with L21 being on the record with a debt. This reading makes 321 and 1065 consistent in content, but 1065 still reads as unconditional on its face and Passage A does not name L21 as the source of the input it uses, so the sourcing differs between the proof and the statement.
- Stands, as a qualifier correction. Correction: line 1065 states "conditional on the eigenvalue bound $\alpha\le\tfrac13$ of Lemma L21, which carries its own debt", and Passage A line 125 names L21 as the input it rests on.

## 11. Passage D against Passages A and C

What each declaration states.

- psi, psi_at_zero: $\psi(0)=1$. Matches section 9.
- sStar_bracket: $0.54368$ lies below $s^*$ and $0.54369$ above it, as cubic sign conditions. Matches section 6.
- cos_add_sin_cube_le_one: for $0\le s\le0.54368$, $c\ge0$, $c^2=1-s^2$, it concludes $c+s^3\le1$, which is $\psi\le1$ multiplied through. Matches section 5.
- max_le_one_of_sin_le: from $\cos\varphi\ge0$, $\sin\varphi\in[0,0.54368]$, and the three real-number hypotheses hexp, hα, hγ, it concludes $m\le1$. hexp and hα are hypotheses, the lemma's inputs, not its conclusions. Matches section 4.
- sin_radius_le: $\sin0.5748\le0.54368$, proved by sorry. Its content is true with room: section 6 gives $\sin0.5748\le0.543671035794967121664<0.54368$. The prose is the argument for it, and the Lean chain through max_le_one and tube_exclusion is not kernel-complete while the sorry stands. The quoted passages do not claim that L20Statement.lean is kernel-checked, and the one kernel claim they make ($0.5436890<s^*$ via TubeRadius.lean's bracket_tight) is accurate as a sign condition.
- tube_exclusion: $0\le\varphi$, hexp, hα, hγ and $1<m$ give $0.5748<\varphi$. Direction matches Passage A.
- even_threshold ($3\le n$), odd_threshold ($3<n$), OddWitness.witness_condition ($4\le n$ over $\mathbb Q$): the two iff statements of section 8, over the reals or rationals. Directions and polynomials match.
- thresholds_positive ($12\le n$), thresholds_at_eleven_twelve, crossover_bracket, thirteen_witness, polynomials_differ, discriminants_differ: match section 8.

What is not typed: $\mathcal W_n$, $P$, the orbit, $d$, nearest points and first variation, the expansion (hexp is assumed), $\alpha\le\tfrac13$ (hα is assumed), $\gamma_V\le m$ (hγ is assumed), $m=\sqrt{2/3}\max P$, the identification of theta0Sq and thetaOddSq with values of actual unit Weyl operators, the parity of $n$ (both are functions on $\mathbb R$), and $s^*$ itself. The Lean files certify the one-variable real arithmetic and nothing geometric, which matches what Passage A attributes to them. CONFIRMED AS ALGEBRA.

## 12. The boundary

- $n=12$: witness $\tfrac{55}{36}>\tfrac32$, and Passage B applies. Holds.
- $n=13$: first odd case, witness $\tfrac{120}{77}>\tfrac32$. Holds.
- $n=11$: outside the statement. Both polynomials are negative there ($-3$ and $-4$), so the statement correctly stops at $12$.
- Crossover $6+2\sqrt7\in(11,12)$: no integer sits on it.
- $\ker W^*\ne0$: $u$ itself is padded, Passage B is stated for the padded $u$, and $\gamma_V\le m$, the expansion and the first variation use nothing about kernels. No step changes.
- Orbit regularity: the orbit is always a compact embedded submanifold, and only compactness and smooth curves are used (section 1).
- Smallest admissible dimension for the imported results: Passage B needs $n\ge9$, Proposition 2.25 needs $k,l\ge2$, and both hold at $n\ge12$.

CONFIRMED.

## Withdrawn candidates

- 1a, orbit not a manifold: withdrawn, no failure exists for a compact group orbit, and only compactness and curves are used.
- 9a, one maximiser versus all: withdrawn, the chosen maximiser is arbitrary.
- 6b, the Taylor bound has no argument on file: withdrawn as a defect, the bound is elementary and its derivation fits in one line (section 6).
- 7b, the unsupported decimals invalidate the radius: withdrawn, none is used, and the radius rests on the exact bound of section 6.

## The falsifying object and the search for it

The statement is falsified by an $n\ge12$ and a maximiser $W^*$ with $d(W^*,\mathcal O)\le0.5748$. Given the proof, any such object must break one of three inputs: a unit $V\in u^\perp\cap T_u\mathcal O^\perp$ with $\alpha>\tfrac13$ at some $n\ge9$ (a counterexample to L21), a failure of the exact expansion (impossible, section 2), or $\max P\le\theta^*$ at some $n\ge12$ (impossible, section 8 exhibits unit operators above $\theta^*$ at every $n\ge12$).

Objects tried in closed form: the diagonal case $W^*=u$ ($\varphi=0$, expansion gives $1$, contradiction with $\tfrac{55}{36}$ and $\tfrac{120}{77}$), the padded $u$ (kernel of dimension at least $n-4$, no step changes), sphere products $S^6\times S^6$ at $n=12$ and $S^7\times S^6$ at $n=13$ (witnesses, and test objects for $\gamma_V\le m$, which holds by definition of $m$), and $V$ along $T_u\mathcal O$ (excluded by first variation, and it is exactly where $\alpha=\tfrac12$ would empty the interval, section 3). The chord reading of $d$ is the one input that changes the radius, and the record fixes the geodesic reading. No falsifier was found. A falsifier of L21 lies outside this brief.

## Overall verdict

**PROVEN (hypotheses corrected).** The proof in Passage A is correct step by step, conditional on L21's $\alpha\le\tfrac13$, which the brief makes a given. The canonical statement at [results.md](../results.md) line 1065 needs two corrections: the witness value is $\Theta_n$ (equal to $\theta_0(n)$ only at even $n$), and the dependence on L21 must be stated as a hypothesis, as line 321 and Passage A already do. The Lean chain is algebra only and carries one sorry whose content is discharged by section 6.
