# Verifier v373, Lemma L20: the exact expansion, the first-variation step, the transfer of $\alpha\le\tfrac13$ from Lemma L21, the bootstrap $m\le\psi(\varphi)$, the radius $0.5748$, the witness at both parities, the degenerate branch, the canonical statement and the Lean declarations

Cold brief ([BRIEF_L20r2.md](BRIEF_L20r2.md)). No numerical work, no scripts written, no Lean build run. Every value below is exact or is a rational inequality followed by hand from the step's own algebra. Beyond the brief I opened only [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) and the extraction [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) at lines 1145–1148 and 1460–1500. Log: [verify-L20-v373.log](../agent_logs/verify-L20-v373.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The expansion $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ is exact with no linear term | CONFIRMED |
| 2 | A nearest orbit point exists and $V\perp T_u(SO(n).u)$ by first variation, the three "further hypotheses" | CONFIRMED (all three are consequences of the setting) |
| 3 | $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O^\perp$ | CONFIRMED AS ALGEBRA for the transfer from Passage B, HYPOTHESIS-DEBT inherited from Lemma L21 |
| 4 | $\gamma_V\le m$ and $m\le\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$ | CONFIRMED |
| 5 | $\psi\le1\iff s^2(1-s)(1-s-s^2-s^3)\ge0\iff s\le s^*$ on $0\le s<1$ | CONFIRMED |
| 6 | $\sin(0.5748)<0.543672$ in exact rationals, $0.5436890<s^*$ kernel-checked | CONFIRMED |
| 7 | The decimals $0.9785933$, $0.3747372$, $0.5748263$, $0.9999937$, $0.5830224$, $1.0020125$ | HYPOTHESIS-DEBT (none is used, their exact counterparts are CONFIRMED) |
| 8 | "Without the first-variation step the bound would be $\alpha\le\tfrac12$, at which the interval is empty" | CONFIRMED AS ALGEBRA (emptiness exact, the value $\tfrac12$ rests on the imported spectrum) |
| 9 | Witness at both parities, $n^2-12n+8$ and $n^2-13n+18$, both clear from $n\ge12$ | CONFIRMED |
| 10 | Degenerate branch $\varphi=0$, the contradiction is with the value | CONFIRMED |
| 11 | [results.md](../results.md) line 1065: "contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains" | REFUTED AS STATED (at odd $n$) |
| 12 | L20 stated unconditionally at [route-a.md](../findings/route-a.md) line 103 and [results.md](../results.md) line 1065 | HYPOTHESIS-DEBT (the proof on file is conditional on L21, as line 321 and the proof body say) |
| 13 | The Lean declarations of Passage D against Passages A and C | CONFIRMED AS ALGEBRA (the tube chain passes through one `sorry`, and no geometric object is typed) |

**The round should record L20 as proven conditional on Lemma L21, put that condition into the heading at route-a.md line 103 and the statement at results.md line 1065, and replace $\theta_0(n)$ by $\Theta_n$ in line 1065's closing sentence.**

## 0. Conventions, fixed once

- $\mathcal W_n=\mathrm{Weyl}_n$ with the Frobenius inner product, $SO(n)$ acting by conjugation on $\Lambda^2(\mathbb R^n)$, orthogonally.
- $B(X,Y)=\tfrac12(XY+YX)+X\#Y$, the symmetric bilinear map with $B(X,X)=Q(X)=X^2+X^\#$, and $T(X,Y,Z)=\langle B(X,Y),Z\rangle$. Its full symmetry is stated at source, [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) lines 1145–1148 ("Note that this is fully symmetric"). Then $F_u=B(u,\cdot)$, which is self-adjoint.
- $u=W_{\mathbb{CP}^2}$ padded, unit, $Q(u)=\theta^*u$, $\theta^*=\sqrt{3/2}$, $\mathcal O=SO(n).u$.
- $d$ is geodesic angle, $\cos d(X,Y)=\langle X,Y\rangle$, $d\in[0,\pi]$. $m=\sqrt{2/3}\max_{|W|=1}P(W)$, $c=\cos\varphi$, $s=\sin\varphi$, $s^*$ the real root of $s^3+s^2+s=1$.
- $\Theta_n=\theta_{k,l}$ at the balanced split $k=\lceil n/2\rceil$, $l=\lfloor n/2\rfloor$, with $\theta_{k,l}^2=\frac{2(k-1)(l-1)(n-1)}{kl(n-2)}$ from Proposition 2.25 at source (extraction lines 1484–1492).

## Hypothesis inventory

| Hypothesis | Where it comes from | Checked against the object | Used by the written proof |
|---|---|---|---|
| $n\ge12$ | statement | both thresholds positive at $n=12$ (even) and $n=13$ (odd), §9 | yes, only at the witness step |
| $W^*$ a maximizer of $P$ on the unit sphere | statement | exists by compactness | yes, for $m=\sqrt{2/3}P(W^*)$ and for $\gamma_V\le m$ |
| $d$ geodesic angle | Passage A, conventions | the expansion needs $|W^*|=1$ and $\langle W^*,u\rangle=\cos\varphi$, both true for angle | yes |
| $d$ is $SO(n)$-invariant | "further hypothesis" | a theorem: the action is orthogonal | yes, to rotate the nearest point to $u$ |
| orbit compact embedded, nearest point, first variation | "further hypothesis" | a theorem for a compact Lie group, and first variation needs only smoothness of $t\mapsto\exp(tX).u$, §2 | yes, for $V\perp T_u\mathcal O$ |
| $\varphi>0$ | "further hypothesis" | a case split, $\varphi=0$ treated in §10 | yes, to define $V$ |
| $T$ fully symmetric and $T(X,X,Y)=\langle Q(X),Y\rangle$ | Definitions, source line 1148 | holds | yes, both for the vanishing linear term and for $T(u,V,V)=\langle F_uV,V\rangle$ |
| $Q(u)=\theta^*u$ for the padded $u$ | Definitions | given, $u^2$ and $u^\#$ are supported on $\mathfrak{so}(4)$ | yes, once |
| Lemma L21: $n\ge9$, padded $u$, unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$ | Passage B | same $u$, same $F_u$, same $\alpha$, same space, $n\ge12\ge9$ | yes |
| Proposition 2.25: $W_{S_{k,l}}$ unit Weyl, $P(W_{S_{k,l}})=\theta_{k,l}$ | source lines 1484–1492 | $k,l\ge6$ at $n\ge12$ | yes, as the witness |
| Nienhaus Theorem 4.14 and Remark 4.16 | cited in Passage A | Passage A itself says the citation does not carry the bound | only in the unused remark "$\alpha\le\tfrac12$" |
| $\ker W^*=0$ or any nondegeneracy | nowhere | none needed | no |
| $m\ge0$ | nowhere | none needed, §4 | no |

No hypothesis is stated and unused, and no step uses a hypothesis that is stated nowhere. The three "further hypotheses" are true in the setting, so calling them hypotheses does not narrow the lemma.

## 1. The exact expansion

For $|W^*|=1$ and $\langle W^*,u\rangle=\cos\varphi$ with $\varphi\in(0,\pi)$, $V:=(W^*-\cos\varphi\,u)/\sin\varphi$ is a unit Weyl operator orthogonal to $u$. Since $P(X)=T(X,X,X)$ with $T$ trilinear and fully symmetric, $P(cu+sV)=c^3P(u)+3c^2s\,T(u,u,V)+3cs^2\,T(u,V,V)+s^3P(V)$ with no remainder.

- Constant term: $\sqrt{2/3}\,P(u)=\sqrt{2/3}\sqrt{3/2}=1$.
- Linear term: $T(u,u,V)=\langle Q(u),V\rangle=\theta^*\langle u,V\rangle=0$. This uses only $Q(u)=\theta^*u$ and $V\perp u$. It uses neither the first-variation condition nor the invariance of $d$.
- Quadratic term: $T(u,V,V)=\langle B(u,V),V\rangle=\langle F_uV,V\rangle$, so the coefficient is $3cs^2\alpha$.
- Cubic term: $s^3\gamma_V$.

The coefficients are right. The first-variation condition enters only at §3, to place $V$ in the space where L21 applies. Invariance of $d$ enters only to rotate. $\varphi>0$ enters only to define $V$.

Candidate 1.1 (identity used without citation). Location: "Since $P$ is a cubic form with polarization $T$, and $Q(u)=\theta^*u$ makes $T(u,u,V)=\theta^*\langle u,V\rangle$". Failure: the step needs $T(X,X,Y)=\langle Q(X),Y\rangle$, which requires full symmetry of $\langle B(X,Y),Z\rangle$, and the proof does not say so. Charitable reading: the Definitions call $T$ the fully symmetric polarisation, and the identity is stated at source line 1148. No failure can be exhibited. **Withdrawn.**

## 2. The nearest point and first variation

$\mathcal O$ is the image of the compact group $SO(n)$ under a continuous map, so a maximizer $x_0$ of $x\mapsto\langle W^*,x\rangle$ on $\mathcal O$ exists, and it minimizes $d$ because $\arccos$ decreases. For $X\in\mathfrak{so}(n)$ the smooth function $t\mapsto\langle W^*,\exp(tX).x_0\rangle$ has a maximum at $t=0$, so $\langle W^*,X.x_0\rangle=0$. Rotating by $g$ with $g.x_0=u$ preserves $P$, the norm, and $d$ (the action is orthogonal), so the rotated $W^*$ is again a maximizer at the same distance. Since $T_u\mathcal O=\{X.u\}\subset u^\perp$ (the orbit lies in the unit sphere), $\langle V,X.u\rangle=\langle W^*,X.u\rangle/\sin\varphi=0$.

This argument needs no manifold structure on the orbit, so brief item 10's case "the orbit is not a manifold" cannot break the step (and the orbit of a compact Lie group is in any case an embedded submanifold).

## 3. $\alpha\le\tfrac13$

**The transfer is exact.** Passage B fixes the same padded $u$, the same $F_u$, the same $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$, the same space $u^\perp\cap T_u(SO(n).u)^\perp$, and the range $n\ge9$, which contains $n\ge12$. It concludes $\alpha\le\tfrac13$ for every unit $V$ there, which is what §4 uses. Passage A's phrasing "the largest eigenvalue of $F_u$ on" that space is well defined, because the space is $F_u$-invariant: $F_u$ is self-adjoint, $F_uu=B(u,u)=\theta^*u$, and differentiating $Q(\exp(tX).u)=\theta^*\exp(tX).u$ at $t=0$ gives $2B(u,X.u)=\theta^*X.u$, so $T_u\mathcal O$ lies in the $\tfrac12\theta^*$-eigenspace. The bound $\tfrac13\theta^*$ gives $\alpha\le\sqrt{2/3}\cdot\tfrac13\sqrt{3/2}=\tfrac13$.

**What L21 carries.** Passage A records L21's debt: the tabulated spectra of four rational $F_\lambda$ matrices by rank certificates over $\mathbb Q$, and independence of their entries from $m=n-4$. The Nienhaus notes record the record's reproduction of Theorem 4.14 at $n=10,12,14$ only, a subfamily. The brief grants L21 as a given, so L20's chain is proven relative to it, and L20 inherits whatever status L21 has. This is the trap "a claim proven on a subfamily and stated in general", located in L21 and not in L20.

**Passage A against Passage C line 321.** Passage A says the input is unproved and that Nienhaus 4.14(c) does not carry it. Line 321 says "conditional on one input nothing on the record proves". Line 1065 cites "the eigenvalue bound $\alpha\le\tfrac13$ of Lemma L21" with no qualifier. §12 records the discrepancy.

## 4. $\gamma_V\le m$ and $m\le\psi(\varphi)$

$V$ is a unit Weyl operator, so $\sqrt{2/3}P(V)\le m$. On $\varphi\in[0,0.5748]$ one has $0.5748<\pi/2$ (as $\pi>3$), so $c>0$ and $s\ge0$.

- $3cs^2\alpha\le cs^2$ needs $cs^2\ge0$, true.
- $s^3\gamma_V\le s^3m$ needs $s^3\ge0$, true.
- $c^3+cs^2=c$.

So $m\le c+s^3m$, and $1-s^3>0$ since $s<1$, giving $m\le c/(1-s^3)$. **The sign of $m$ is never used**, since the division is by the positive $1-s^3$ and no inequality is multiplied by $m$.

## 5. The reduction $\psi\le1\iff s\le s^*$

With $c>0$ and $1-s^3>0$, $\psi\le1\iff c\le1-s^3\iff c^2\le(1-s^3)^2$, squaring being reversible between nonnegatives. Then $(1-s^3)^2-(1-s^2)=s^2-2s^3+s^6=s^2(s^4-2s+1)$, and $s^4-2s+1=(s-1)(s^3+s^2+s-1)$ by expansion ($s^4+s^3+s^2-s-s^3-s^2-s+1$), so the difference is $s^2(1-s)(1-s-s^2-s^3)$, as written. For $s=0$ it vanishes and $\psi=1$. For $0<s<1$ its sign is that of $1-s-s^2-s^3$, which decreases strictly (derivative $-(1+2s+3s^2)<0$ on $s\ge0$, the record's "$3s^2+2s+1>0$"), so $\psi\le1\iff s\le s^*$. **CONFIRMED.**

## 6. The radius

**Taylor bound.** $\cos x\ge1-\tfrac{x^2}2$ for all real $x$. Integrating from $0$ gives $\sin x\ge x-\tfrac{x^3}6$ for $x\ge0$, again $1-\cos x\ge\tfrac{x^2}2-\tfrac{x^4}{24}$, again $\sin x\le x-\tfrac{x^3}6+\tfrac{x^5}{120}$ for $x\ge0$. The inequality holds.

**The rational at $x=\tfrac{1437}{2500}=0.5748$**, followed by hand:

- $5748^2=33\,039\,504$, so $x^2=0.33039504$ exactly.
- $33\,039\,504\cdot5748=189\,911\,068\,992$, so $x^3=0.189911068992$ exactly and $x^3/6=0.031651844832$ exactly.
- $x^5=x^3x^2<0.18991107\cdot0.330396<0.0627458579$, so $x^5/120<0.000522882150$.
- Hence $x-\tfrac{x^3}6+\tfrac{x^5}{120}<0.5748-0.031651844832+0.000522882150=0.543671037318<0.543672$.

**The bracket.** [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) `bracket_tight` states $\mathrm{cubic}(5436890/10^7)<0<\mathrm{cubic}(5436891/10^7)$ and `cubic_strict_mono` states strict increase on $[0,\infty)$, so every nonnegative root exceeds $0.5436890$. Therefore $\sin\varphi\le\sin(0.5748)<0.543672<0.5436890<s^*$, with $\sin$ increasing on $[0,\pi/2]$. **CONFIRMED.**

Candidate 6.1 (kernel-check overstated). Location: "$0.5436890<s^*$ is kernel-checked in TubeRadius.lean". Failure: $s^*$ is not a Lean object, and no declaration states the inequality about it. Charitable reading: the two declarations named above are the statement's full content, and the inference from them is one line of monotonicity. **Withdrawn.**

## 7. The decimals

Exact counterparts, each derived here in closed form:

- $\psi'(\varphi)=s(3s-1-2s^3)/(1-s^3)^2$, and $2s^3-3s+1=(s-1)(2s^2+2s-1)$, so the interior critical point is $s=\tfrac{\sqrt3-1}2$, as stated. At it $s^2=\tfrac{2-\sqrt3}2$, $c^2=\tfrac{\sqrt3}2$, $1-s^3=\tfrac{9-3\sqrt3}4$, so $\psi_{\min}=\frac{4(\sqrt3/2)^{1/2}}{9-3\sqrt3}$.
- By §5, $\psi=1$ exactly at $\varphi=\arcsin s^*$ and $\psi>1$ on $(\arcsin s^*,\pi/2)$, so "first exceeds $1$ at $\arcsin s^*$" and "the stated radius is the crossing truncated in the safe direction" are exact consequences of $\sin(0.5748)<s^*$.
- The chord reading: a chord $0.5748$ is the angle $2\arcsin(0.2874)$, and the argument fails there iff $2\arcsin(0.2874)>\arcsin s^*$.

The seven-digit values $0.9785933$, $0.3747372$, $0.5748263$, $0.9999937$, $0.5830224$, $1.0020125$ have no argument on file, and none enters the chain from the expansion to the contradiction. **HYPOTHESIS-DEBT, harmless.** What would discharge them is a rational bracket for each, or deleting the digits in favour of the closed forms above.

## 8. The remark "$\alpha\le\tfrac12$ empties the interval"

With $\alpha\le\tfrac12$ the bootstrap gives $m(1-s^3)\le c^3+\tfrac32cs^2=c(1+\tfrac{s^2}2)$. Then $c^2(1+\tfrac{s^2}2)^2=1-\tfrac34s^4-\tfrac14s^6$ and $(1-s^3)^2-c^2(1+\tfrac{s^2}2)^2=s^3\big(-2+\tfrac34s+\tfrac54s^3\big)<0$ for $0<s<1$. So the bound exceeds $1$ at every $\varphi\in(0,\pi/2)$ and the argument excludes nothing beyond the orbit itself. The emptiness is exact. That $\tfrac12$ is the next bound without first variation rests on Theorem 4.14 being exhaustive, which the chain does not need, and §3 shows at least that $T_u\mathcal O$ realizes $\tfrac12$. The remark is unused. **CONFIRMED AS ALGEBRA.**

## 9. The witness at both parities

Proposition 2.25 at source gives, for every split, a Weyl operator with $W^2+W^\#=\theta_{k,l}W$ and $P(W)=\theta_{k,l}$, hence $|W|^2=1$. The balanced split gives both Definitions formulas:

- $n=2k$: $\theta^2=\frac{2(k-1)^2(n-1)}{k^2(n-2)}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$.
- $n=2k+1$: $(k-1)k=\frac{(n-3)(n-1)}4$ and $k(k+1)=\frac{(n-1)(n+1)}4$, so $\theta^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$.

Thresholds: $\frac{2(n-1)(n-2)}{n^2}>\tfrac32\iff4n^2-12n+8>3n^2\iff n^2-12n+8>0$, and $\frac{2(n-1)(n-3)}{(n-2)(n+1)}>\tfrac32\iff4n^2-16n+12>3n^2-3n-6\iff n^2-13n+18>0$ (denominators positive for $n>2$). The larger roots are $6+2\sqrt7\in(11,12)$ (as $25<28<36$) and $\tfrac{13+\sqrt{97}}2\in(11,12)$ (as $81<97<121$). At the edge: $n=11$ gives $-3$ and $-4$, $n=12$ gives $8$, $n=13$ gives $18$. So even $n\ge12$ and odd $n\ge13$ clear, and "both clear from $n\ge12$" is right. Concretely $\Theta_{12}^2=\tfrac{55}{36}>\tfrac{54}{36}$ and $\Theta_{13}^2=\tfrac{120}{77}>\tfrac32$ since $240>231$. $\Theta_n>0$ by Proposition 2.25, so $\Theta_n^2>\tfrac32$ gives $P(W)>\sqrt{3/2}$, that is $m>1$. **CONFIRMED.**

## 10. The degenerate branch and "the value, not the location"

At $\varphi=0$, $W^*=g.u$ and $\max P=P(u)=\sqrt{3/2}$, which the witness contradicts. The expansion at $s=0$ gives the same $m=1$ without $V$. The contradiction uses only $P(W^*)=\max P$, never where the witness lies, so a witness inside the tube would be no obstruction. **CONFIRMED.**

## 11. Passage C line 1065, the witness value

Location: results.md line 1065, "contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains". Failure: at $n=13$ no sphere product attains $\theta_0(13)$. Proposition 2.25's $\theta_{k,l}^2=\frac{2\cdot12(k-1)(l-1)}{11kl}$ is maximized over $k+l=13$ at $(7,6)$, where it is $\tfrac{120}{77}$, while $\theta_0(13)^2=\tfrac{264}{169}$, and $120\cdot169=20280<264\cdot77=20328$. So the named value exceeds every sphere product at $n=13$. Passage A says the same: "at odd $n$ the balanced sphere product is not one, it does not exist". Charitable reading: "the sphere product" means the best one, and at odd $n\ge13$ its value $\Theta_n$ still exceeds $\theta^*$ (§9), so the conclusion survives. The sentence as written names a value not attained. **REFUTED AS STATED, conclusion unaffected.** Fix: "contradicting the value $\Theta_n>\theta^*$ the best sphere product attains". The preamble "$\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$" is correct algebra for real $n\ge3$ and misleads only if read as the witness at odd $n$.

## 12. The status of the statement

Location: route-a.md line 103, "#### Lemma L20, no maximizer lies near the rival maximizer's orbit, for every $n\ge12$", and results.md line 1065, "For every $n\ge12$, no maximizer ... lies within angular distance $0.5748$". Failure: the proof on file derives this from $\alpha\le\tfrac13$, which Passage A calls "the lemma's one unproved input" and line 321 calls "conditional on one input nothing on the record proves". At those two lines the statement reads unconditionally. Charitable reading: line 1065 does name L21 as its source, which is the usual form of a lemma resting on another. But L21 carries a computational debt (§3), so the chain is conditional, and line 1065 omits the qualifier that line 321 and Passage A carry. **HYPOTHESIS-DEBT for the unconditional reading.** Fix: add "conditional on Lemma L21's $\alpha\le\tfrac13$" to both lines.

A secondary inconsistency: line 321 says "nothing on the record proves" the input, while L21 on the record states exactly that input. Both are true only if L21 is itself counted unproven, which the debt Passage A records implies. The round should make the two lines say the same thing.

## 13. The Lean declarations

- `max_le_one_of_sin_le`: binders $m,\varphi,\alpha,\gamma\in\mathbb R$, hypotheses $\cos\varphi\ge0$, $\sin\varphi\ge0$, $\sin\varphi\le0.54368$, `hexp` (the expansion as an equation of reals), `hα`: $\alpha\le\tfrac13$, `hγ`: $\gamma\le m$, conclusion $m\le1$. Direction and content match §4–§5, with $0.54368$ in place of $s^*$. Its proof steps (`h1`, `h2`, `h3`, `hs3lt`) follow the paper order exactly.
- `cos_add_sin_cube_le_one`: $c+s^3\le1$ from $0\le s\le0.54368$, $c\ge0$, $c^2=1-s^2$. This is $\psi\le1$ in cleared form. `sStar_bracket` places $0.54368$ below $s^*$, consistent with `bracket_tight`.
- `sin_radius_le`: $\sin0.5748\le0.54368$, proved by `sorry`. It is true, and §6 discharges it on paper since $0.543672<0.54368$. `sin_le_of_le_radius`, `max_le_one` and `tube_exclusion` all depend on it, so **the Lean tube chain is not kernel-checked end to end**. Passage A claims a kernel check only for the bracket, so no quoted passage overclaims.
- `tube_exclusion`: hypotheses `h0`, `hexp`, `hα`, `hγ`, `hm`: $1<m$, conclusion $0.5748<\varphi$. `hexp` and `hα` are **inputs**, and so is `hm`. The lemma's conclusion is the output.
- **Not typed**: $\mathrm{Weyl}_n$, $P$, $F_u$, the orbit, geodesic distance, the maximizer, the nearest point and first variation, that $\alpha$ and $\gamma$ are the quantities of §1, the exactness of the expansion, L21, and the link from $\Theta_n^2>\tfrac32$ to `hm`.
- `even_threshold`, `odd_threshold`, `thresholds_positive`, `crossover_bracket`, and in [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean) `witness_condition` and `thirteen_witness`, state exactly the algebra of §9 over $\mathbb R$ or $\mathbb Q$, with no integrality or parity binder, which the algebra does not need. `polynomials_differ` ($10-n$) and `discriminants_differ` ($97$, $112$) are correct and unused.
- [L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean) was not built by this verifier. Statements are checked as quoted, and whether the proofs compile is taken from the record.

## Edges and traps, by name

- **Quantifier order.** The statement is $\forall n\ge12\ \forall W^*$ maximizer, $d(W^*,\mathcal O)>0.5748$. Candidate E.1: the proof says "attained, at some $W^*$", which reads existentially. Charitable reading: the argument uses only $P(W^*)=\max P$ and so applies verbatim to every maximizer. **Withdrawn.**
- **Smallest admissible dimension.** $n=12$ even and $n=13$ odd clear with values $8$ and $18$. $n=11$ fails both, and the lemma does not claim it.
- **Odd $n$.** Handled in Passage A through $\Theta_n$, mishandled in line 1065 (§11).
- **Crossover $6+2\sqrt7$.** Lies in $(11,12)$, so no integer sits at it. The odd crossover $\tfrac{13+\sqrt{97}}2$ also lies in $(11,12)$, so the two polynomials never disagree at an admissible integer.
- **$\ker W\ne0$.** $u$ is padded with an $(n-4)$-dimensional kernel, and Passage B is stated for exactly that padded $u$. Nothing in the proof uses invertibility of $W^*$, $u$ or $V$. The only padded fact used is $Q(u)=\theta^*u$, given, and consistent because $u^2$ and $u^\#$ are supported on $\mathfrak{so}(4)$.
- **Boundary of the radius.** The tube is closed ($\varphi\le0.5748$) in the proof and "within" in the statement, and the conclusion is strict, so the endpoint is covered.
- **Subfamily stated in general.** Present in L21's support ($n=10,12,14$ reproduced), absent from L20's own steps.
- **Stated but unused, used but unstated.** None in L20 (inventory). The three "further hypotheses" are consequences of the setting.
- **Universal claim with no witness.** The universal claims in the chain (the Taylor bound, the reduction, $\gamma_V\le m$) are proved. The existential "a unit Weyl operator with $P>\sqrt{3/2}$" has its witness from Proposition 2.25.
- **Imported theorem with unchecked hypotheses.** Proposition 2.25 is stated for every split $k+l=n$ at source, and $k,l\ge6$ here. L21's hypotheses match (§3). Theorem 4.14 is cited only for the unused remark.

## Withdrawn candidates

| # | Candidate | Reason withdrawn |
|---|---|---|
| 1.1 | $T(X,X,Y)=\langle Q(X),Y\rangle$ used without argument | full symmetry is in the Definitions and at source line 1148, no failure exists |
| 6.1 | "kernel-checked" applied to $0.5436890<s^*$ with $s^*$ not a Lean object | the two declarations carry the content, the inference is one line |
| E.1 | "at some $W^*$" against "no maximizer" | the argument applies to every maximizer verbatim |
| E.2 | first variation fails when the orbit is not a manifold | first variation needs only $t\mapsto\exp(tX).u$ smooth, §2 |
| E.3 | $m\ge0$ used silently | never used, §4 |

## What would falsify the statement

A unit Weyl maximizer $W^*$ at some $n\ge12$ with $d(W^*,\mathcal O)\le0.5748$. Given the chain above, such an object forces the failure of L21: a unit $V\in u^\perp\cap T_u\mathcal O^\perp$ with $\langle F_uV,V\rangle>\tfrac13\theta^*$. What I did to look:

- The eigenvalues $F_u$ exceeds $\tfrac13\theta^*$ at that are identifiable in closed form are $\theta^*$ on $\langle u\rangle$ and $\tfrac12\theta^*$ on $T_u\mathcal O$ (§3), and both spaces are removed from the domain.
- Whether other directions, such as the balanced sphere product components or padded $\mathbb{CP}^m$ Weyl tensors orthogonal to $\mathcal O$, meet a larger eigenvalue is exactly L21's content. Deciding it in closed form means rebuilding L21's spectrum, which is outside a check of L20 and belongs to L21's own round.
- Every step that is L20's own (§1, §2, §4–§6, §9, §10) is proved for all admissible $\varphi$ and $n$, so no witness can exist there.

## Overall verdict

**PROVEN (hypotheses corrected).** Every step from the expansion to $\varphi>0.5748$ follows, exactly, from Lemma L21's $\alpha\le\tfrac13$, Proposition 2.25, and facts of the setting. The corrections:

- The statement at route-a.md line 103 and results.md line 1065 must carry "conditional on Lemma L21", matching line 321 and the proof body, since L21 carries a computational debt.
- results.md line 1065 must name $\Theta_n$, not $\theta_0(n)$, as the witness value at odd $n$.
- Optional: drop or bracket the six unused decimals, and discharge `sin_radius_le` by the rational bound of §6.
