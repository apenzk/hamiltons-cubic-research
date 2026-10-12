# REVIEW r448, adversarial audit of [Lemma L146](../findings/second-order.md): the operator norm on the margin summand

*Cold brief, **analysis only** ([.claude/rules/analysis-only.md](../.claude/rules/analysis-only.md)). Read in full: [Lemma L146](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md), [conventions.md](../findings/conventions.md), [r446](REVIEW_r446.md), [r447](REVIEW_r447.md). Every derivation below is by hand; one numeric screen of self-constructed objects is reported as a screen and is evidence for nothing. Working: [agent_logs/r448-L146.log](../agent_logs/r448-L146.log).*

## Verdict, per claim

| # | Claim | Verdict |
|---|---|---|
| 1 | The element is the Weyl image of $h\owedge g_q$, **diagonal on coordinate $2$-planes with eigenvalue $h_a$ on $e_a\wedge e_b$ and zero on planes inside a block** | **REFUTED.** Diagonality survives; the eigenvalues do not. The operator described is not a Weyl tensor at all (D1) |
| 2 | $\lVert H\rVert_F^2\propto m\lVert h\rVert^2$, with the proof dividing by $\sqrt m$ | **REFUTED as used.** The constant is $\tfrac{m(m-2)}{2(m-1)}\to\tfrac m2$, not $m$ (D2) |
| 3 | $\lVert H\rVert_{op}\le\sqrt{m-1}/m$ at $\lVert H\rVert_F=1$ | **REFUTED.** The true supremum is $1/\sqrt{m-1}$, exceeding the stated bound by $m/(m-1)$ at every $m\ge3$ (D3) |
| 4 | $\lVert H\rVert_{op}\ge1/m$, attained at the even split | **CONFIRMED as an inequality, REFUTED as an extremal claim.** The true bound is $1/(m-1)$ and the minimiser is not the even split (D4) |
| 5 | $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$; the disc is $\Omega(n^{-1/2})$ throughout and $\Theta(1)$ at best | **CONFIRMED.** Every order survives the correction; only the constants move (D5) |
| 6 | $L_e$ is a scalar $\lambda_m$ on the summand, so the margin is constant across it, and it is the same constant $c_p$ that [Lemma L145](../findings/second-order.md)'s chain uses | **CONFIRMED**, exactly: $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)=c_p$ (D6) |
| 7 | The infimum over $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ is attained on $S^2_0(\mathbb R^m)$ | **CONFIRMED for $m\ge5$ only**, and the lemma states no restriction; the joint eigenspace objection fails (D7) |
| 8 | "A tube radius is an infimum, so the best directions do not move it" | **CONFIRMED as a step, REFUTED as a reading of [r446](REVIEW_r446.md).** The computation meets [r446](REVIEW_r446.md)'s own stated criterion and therefore vindicates it (D8) |
| 9 | "The direction-blind radius is conservative **on the summand that binds**" | **PLAUSIBLE, unestablished.** Which summand binds must be recomputed once the disc is direction-dependent (D9) |
| 10 | The closing screen | **VACUOUS.** It re-evaluates the lemma's own closed form and could not have caught D1 (D10) |

**The headline.** The closed-form statement in the box is wrong on both sides and rests on an operator that is not a Weyl tensor; the asymptotic corollary the lemma is actually used for is right, and its framing of the [r446](REVIEW_r446.md)/[r447](REVIEW_r447.md) disagreement is backwards.

## D1, the embedding: the lemma applies the Weyl projection and then reports the pre-projection eigenvalues

**The convention.** Kulkarni–Nomizu as the record uses it, $(A\owedge B)_{ijkl}=A_{ik}B_{jl}+A_{jl}B_{ik}-A_{il}B_{jk}-A_{jk}B_{il}$, whence $\mathrm{Ric}(A\owedge B)=(\operatorname{tr}A)B+(\operatorname{tr}B)A-AB-BA$ under $\mathrm{Ric}_{jl}=\sum_iR_{ijil}$, and the decomposition $R=W+\tfrac1{n-2}\mathring{\mathrm{Ric}}\owedge g+\tfrac{\mathrm{scal}}{2n(n-1)}g\owedge g$. Both normalisations check against each other: $\mathrm{Ric}(\tfrac1{n-2}\mathring{\mathrm{Ric}}\owedge g)=\mathring{\mathrm{Ric}}$ and $\mathrm{Ric}(\tfrac{\mathrm{scal}}{2n(n-1)}g\owedge g)=\tfrac{\mathrm{scal}}ng$.

**The projection does not vanish.** With $h$ trace-free on the first block and $g_q$ the second block's identity, $hg_q=g_qh=0$ and $\operatorname{tr}h=0$, so

$$\mathrm{Ric}(h\owedge g_q)=m\,h\neq0,\qquad \mathrm{scal}=0,\qquad H:=\mathcal W(h\owedge g_q)=h\owedge g_q-\frac m{n-2}\,h\owedge g,\quad n-2=2m-2 .$$

Writing $\alpha=\tfrac{m-2}{2m-2}$ and $\beta=\tfrac m{2m-2}$, so that $\alpha+\beta=1$, this is $H=\alpha\,(h\owedge g_q)-\beta\,(h\owedge g_p)$.

**What survives and what does not.** With $h$ diagonalised (legitimate, since $O(m)\times O(m)$ preserves $W^*$ and both norms), every Kulkarni–Nomizu term forces $\{i,j\}=\{k,l\}$, so $H$ **is** diagonal on coordinate $2$-planes. The eigenvalues are not the ones claimed:

| plane | [Lemma L146](../findings/second-order.md) | correct |
|---|---|---|
| $e_a\wedge e_b$, $a$ in block $1$, $b$ in block $2$ ($m^2$ planes) | $h_a$ | $\alpha\,h_a$ |
| $e_a\wedge e_{a'}$, both in block $1$ ($\binom m2$ planes) | $0$ | $-\beta\,(h_a+h_{a'})$ |
| $e_b\wedge e_{b'}$, both in block $2$ ($\binom m2$ planes) | $0$ | $0$ |

**The decisive check.** The operator the lemma describes has $\mathrm{Ric}_{aa}=\sum_{c\ne a}H_{acac}=m\,h_a\neq0$ for $a$ in the first block, so it is **not Ricci-flat and therefore not an algebraic Weyl tensor**. It is $h\owedge g_q$ itself, before the projection. The corrected $H$ passes: $\mathrm{Ric}(H)=0$ on both blocks, by $\alpha m-\beta(m-2)=0$, and its trace over planes vanishes. *The lemma names the Weyl image in the sentence that defines the element and then reads off the eigenvalues of the object it was projecting.*

**The asymmetry is the tell.** The lemma's description is symmetric between the blocks; the correct one is not, and cannot be, $h$ breaks the symmetry, so a $\Theta(1)$ fraction of the norm has to land on the block-$1$ planes.

## D2, the Frobenius norm: constant on the summand, but the constant is $m/2$, not $m$

At $\lVert h\rVert=1$ with $\sum_ah_a=0$, the identity $\sum_{a<a'}(h_a+h_{a'})^2=(m-1)\lVert h\rVert^2+\big((\textstyle\sum h_a)^2-\lVert h\rVert^2\big)=m-2$ gives

$$\lVert H\rVert_F^2=\alpha^2m+\beta^2(m-2)=\frac{m(m-2)}{2(m-1)}\;\sim\;\frac m2 .$$

**This is a constant on the summand**, as $O(m)\times O(m)$-irreducibility demands, the lemma implicitly assumes that and is right to. But it is $\tfrac{m-2}{2(m-1)}$ times the value the proof uses, and the proof's "dividing by $\sqrt m$" is therefore short by a factor tending to $\sqrt2$.

**On the counting convention the brief flags.** Both norms here are taken on the same operator on $\Lambda^2$, over an orthonormal plane basis, each unordered plane once, the record's own $\operatorname{tr}(W^2)=\sum_\alpha\lambda_\alpha^2$ from [conventions.md](../findings/conventions.md). The ratio $\lVert H\rVert_{op}/\lVert H\rVert_F$ is then convention-independent: doubling to ordered pairs scales $\lVert H\rVert_F$ by $\sqrt2$ and leaves $\lVert H\rVert_{op}$ alone, changing the ratio uniformly and not the comparison. **The lemma is internally consistent on this point**, its own $\lVert H\rVert_F^2=m$ counts the $m^2$ cross planes once each. The $\sqrt2$ the brief anticipated is real but it enters through D1, not through the counting.

## D3, the upper bound is false at every $m$

$$\lVert H\rVert_{op}=\max\Big(\alpha\max_a\lvert h_a\rvert,\ \beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\Big),$$

and the second entry (invisible to the lemma, because it lives on the block-$1$ planes the lemma sets to zero), is the larger one. Maximising the linear functional $h\mapsto h_a+h_{a'}$ on $\{\sum h=0,\lVert h\rVert=1\}$ gives $\max\lvert h_a+h_{a'}\rvert=\sqrt{2(m-2)/m}$, against $\max_a\lvert h_a\rvert=\sqrt{(m-1)/m}$, and

$$\beta\sqrt{\tfrac{2(m-2)}m}\ \Big/\ \alpha\sqrt{\tfrac{m-1}m}\;=\;m\sqrt{\frac2{(m-1)(m-2)}}\;>\;1\quad\text{for every }m\ge3 .$$

Dividing by $\lVert H\rVert_F$ from D2, the two square roots collapse:

$$\boxed{\ \sup_{\lVert H\rVert_F=1}\lVert H\rVert_{op}=\frac1{\sqrt{m-1}}\ }\qquad\text{against the lemma's }\frac{\sqrt{m-1}}m=\frac{m-1}m\cdot\frac1{\sqrt{m-1}} .$$

The stated inequality is violated by the factor $m/(m-1)$ at every $m$, and the extremal direction is not the one the lemma names: it is the **pair-concentrated** $h$, two entries at $+t$ and $m-2$ at $-2t/(m-2)$, not the singly-concentrated one.

## D4, the lower bound is true, its proof is not, and the parity objection is real but harmless

**The bound.** The same identity gives $\max_{a\ne a'}(h_a+h_{a'})^2\ge\frac{m-2}{\binom m2}=\frac{2(m-2)}{m(m-1)}$, so

$$\inf_{\lVert H\rVert_F=1}\lVert H\rVert_{op}\;\ge\;\frac\beta{\lVert H\rVert_F}\sqrt{\frac{2(m-2)}{m(m-1)}}\;=\;\frac1{m-1}\;>\;\frac1m .$$

**So the lemma's $1/m$ holds, vacuously with respect to its own argument.** The argument offered, $\max_ah_a^2\ge\frac1m\sum h_a^2$ with equality at entries of equal modulus, bounds the wrong entry of the maximum: at the even split the block-plane term $\beta\cdot2/\sqrt m$ is $\frac{2m}{m-2}$ times the cross term, so the even split is not where $\lVert H\rVert_{op}$ is smallest, and the true minimiser varies with $m$ (at $m=6$ the concentrated direction is lower; at $m=8$ the even split is).

**The parity point.** For odd $m$ the minimum of $\max_a\lvert h_a\rvert$ is $\sqrt{\tfrac{m+1}{m(m-1)}}$, not $1/\sqrt m$, attained at $\tfrac{m-1}2$ entries $+c$ against $\tfrac{m+1}2$ entries $-\tfrac{m-1}{m+1}c$. So the lemma's "attained" clause is even-$m$ only, which the lemma itself concedes; the **inequality** $\ge1/\sqrt m$ holds at every parity, so nothing in the $\Theta(n^{-1})$ order depends on it. *The parity objection the brief raises is real and inert; D3 is the one that bites.*

## D5, every order in the lemma survives the correction

With $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}$ and the disc $g_n/\lVert H\rVert_{op}$:

| quantity | [Lemma L146](../findings/second-order.md) | corrected | order |
|---|---|---|---|
| $\sup\lVert H\rVert_{op}$ | $\sqrt{m-1}/m$ | $1/\sqrt{m-1}$ | $\Theta(n^{-1/2})$, both |
| $\inf\lVert H\rVert_{op}$ | $1/m$ | $\ge1/(m-1)$, screened at $\approx1.8/m$ | $\Theta(n^{-1})$, both |
| smallest disc | $1/\sqrt{2m-1}$ | $\tfrac{m-1}{m\sqrt{2m-1}}\to1/\sqrt{2m}$ | $\Omega(n^{-1/2})$, both |
| largest disc | $\to1/\sqrt2$ | $\to\approx0.39$ | $\Theta(1)$, both |

So the three assertions the lemma is actually cited for, the disc is $\Omega(n^{-1/2})$ throughout, $\Theta(1)$ on the flattest directions, and a factor $\sqrt n$ better than the direction-blind $g_n$, are **CONFIRMED**. The correction moves constants only. *That is the reason this audit does not end in a bare REFUTED: the box is wrong, and the paragraph the box is used for is right.*

**Screen** (self-constructed objects, seconds; evidence for nothing). Building the Kulkarni–Nomizu tensors and the Weyl projection explicitly at $m=4,5,6,8$: first Bianchi residual $0$, $\lvert\mathrm{Ric}\rvert\le7\times10^{-16}$, and $\lVert H\rVert_F$, $\lVert H\rVert_{op}$ agreeing with the closed forms above to machine precision. $4000$ random directions per $m$ never exceed $1/\sqrt{m-1}$; the pair-concentrated direction attains it. Against the lemma's bound: $0.577$ vs $0.433$ at $m=4$, $0.500$ vs $0.400$ at $m=5$, $0.447$ vs $0.373$ at $m=6$, $0.378$ vs $0.331$ at $m=8$.

## D6, the scalar claim and the margin identity are exact

[Lemma L27](../findings/nondegeneracy.md)'s decomposition is multiplicity-free with pairwise distinct Young labels, $e$ is $O(p)\times O(q)$-invariant and $L_e$ is symmetric, so $L_e$ **is** a scalar on $S^2_0(\mathbb R^m)$, equal to $\lambda_m=(m-2)/(2(m-1))$. The margin is therefore constant across the summand, as the lemma says.

**And it is [Lemma L145](../findings/second-order.md)'s constant, exactly rather than up to order.** At $n=2m$,

$$3\theta_0\big(\tfrac12-\lambda_m\big)=3\theta_0\cdot\frac1{2(m-1)}=\frac{3\theta_0}{n-2}=c_p ,$$

which is verbatim [r446](REVIEW_r446.md)'s pair-block margin and the $3\theta_0(\lambda_m-\tfrac12)=-3\theta_0/(n-2)$ already recorded in [Lemma L133](../findings/second-order.md)'s proof of (b). The brief's worry (that the margin in the chain might be a different constant varying over the summand), does not materialise.

## D7, the binding direction is in this summand, for $m\ge5$

**The off-orbit spectrum at $p=q=m$.** [Lemma L27](../findings/nondegeneracy.md) gives $\lambda_m$ on the two $S^2_0(\mathbb R^m)$ summands, $\pm\mu$ on the two tensor summands and $0$ on four more, with $\tfrac12-\mu=\frac{(m-2)^2-1}{2(m-1)^2}$, hence $\mu=\frac1{m-1}$. Then

$$\lambda_m>\mu\iff\frac{m-2}2>1\iff m>4 ,$$

with equality at $m=4$ and $\lambda_3<\mu=\tfrac12$ at the excluded $(3,3)$. So the smallest off-orbit margin sits on $S^2_0(\mathbb R^m)$ **for $m\ge5$**, and [Lemma L146](../findings/second-order.md) states no restriction. Harmless for [Lemma L145](../findings/second-order.md), which lives at $n\ge12$, but it should be written down.

**The joint-eigenspace objection fails.** The binding set is the full $\lambda_m$-eigenspace, both copies of $S^2_0$, not one summand; the lemma analyses one. Taking $H=H_1(h)+H_2(k)$, the cross planes carry $\alpha(h_a+k_b)$ and each block's own planes carry $-\beta$ times that block's pair sums, and $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}(\lVert h\rVert^2+\lVert k\rVert^2)$, the two copies are orthogonal, with tracelessness killing the cross term. The joint supremum is $\max$ of $\beta\sqrt{2(m-2)/m}$ (all weight on one copy) and $\alpha\sqrt2\sqrt{(m-1)/m}$ (split evenly, both concentrated), and the first exceeds the second by $m/\sqrt{(m-1)(m-2)}>1$. **So the joint supremum is again $1/\sqrt{m-1}$** and restricting to one summand costs nothing.

**The ten-summand objection is answered in D9, not here.** Other summands do carry larger operator norms, that is exactly what makes D9 live.

## D8, the infimum argument is sound and is a reading of a claim [r446](REVIEW_r446.md) did not make

**The step is right.** Within the summand $c(H)$ is constant (D6) and only the disc varies, so a direction with a larger disc has a strictly larger local radius, and an infimum is not moved by it. That much is correct, and it is correct **because** of D6, the argument would fail on a summand where $L_e$ was not scalar.

**But it settles a strawman.** [r446](REVIEW_r446.md)'s D6 does not claim the flat directions lower the infimum. It states the opposite and then names the test: *"What would settle it is one computation nobody has done: $\lVert H\rVert_{op}$ on the two $S^2_0(\mathbb R^m)$ summands … If it is $o(1)$ there, the exponent is not $-3/2$ and [I31](../plan.md) should be re-promoted."* [Lemma L146](../findings/second-order.md)'s own answer is $\sup\lVert H\rVert_{op}=\Theta(n^{-1/2})=o(1)$. **The criterion is met.**

**Following it through the chain [r446](REVIEW_r446.md) and [r447](REVIEW_r447.md) both use.** With disc $\rho$ and $M=O(\rho)$, Cauchy gives $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)$, which reproduces $O(n)$ at the direction-blind $\rho=\Theta(g_n)$. At $\rho=\Theta(n^{-1/2})$ it is $O(n^{1/2})$, and the defect-quartic branch on the binding directions moves

$$\frac{\sqrt{c_p}}{\lVert A''\rVert}:\quad\frac{\Theta(n^{-1/2})}n=\Theta(n^{-3/2})\ \longmapsto\ \frac{\Theta(n^{-1/2})}{\Theta(n^{1/2})}=\Theta(n^{-1}) .$$

It stops capping. What is left at $u=0$ is the cubic branch $c_p/\sup\lvert P\rvert$, which is $\Theta(n^{-3/2})$ at $\sup\lvert P\rvert=\Theta(\sqrt n)$ and $\Theta(n^{-1})$ at $\sup\lvert P\rvert=\Theta(1)$. **So [r447](REVIEW_r447.md)'s "the exponent is pinned by $(c_p,\lVert A''\rVert=O(n))$ and by nothing else, and [I31](../plan.md) provably cannot move it" is what the computation contradicts**, and [r446](REVIEW_r446.md)'s D6 is what it vindicates.

**Verdict on the box.** "THIS DECIDES THE DISAGREEMENT, AND AGAINST BOTH READINGS" is **REFUTED as a characterisation**. It decides the disagreement in [r446](REVIEW_r446.md)'s favour. The lemma's own third bullet says so in substance (a factor $\sqrt n$ of room) and the header contradicts the bullet beneath it.

## D9, "the summand that binds" is the step that is not established

Making the disc direction-dependent is precisely what forbids holding the binding summand fixed: the infimum $\inf_Hc(H)/C(H)$ must be re-minimised over all ten of [Lemma L27](../findings/nondegeneracy.md)'s summands, because the summands with the **largest** margins are also the ones with the **smallest** discs.

- **They exist.** A low-rank Weyl tensor padded into the first factor (a $\mathbb{CP}^2$-type element for $p\ge4$), lies in the $\mathrm{Weyl}_p$ summand and has $\lVert H\rVert_{op}/\lVert H\rVert_F=\Theta(1)$, hence disc $\Theta(g_n)=\Theta(n^{-1})$ and $\lVert A''\rVert=O(n)$: exactly the direction-blind estimate, with no room in it at all.
- **Their margin is $\Theta(1)$**, since $L_e$ vanishes on $\mathrm{Weyl}_p$, giving quartic branch $\sqrt{\Theta(1)}/n=\Theta(n^{-1})$.
- **So the conclusion is not vacated**, those directions tie with the improved $S^2_0$ branch at $\Theta(n^{-1})$ rather than beating it, **but the sentence as written is unestablished**, and it is the sentence a successor will quote.

The lemma's own guard, "re-running the chain is a separate step and is not done here", covers the arithmetic but not the quantifier: the claim *which* summand binds is part of the re-run, not part of what is settled. **PLAUSIBLE.**

## D10, the closing screen is vacuous

$$\frac{\sqrt{m-1}/m}{g_n}=\sqrt{m-1}\cdot\sqrt{\frac{2m-1}{m-1}}=\sqrt{2m-1},$$

and the reported $3.32,\ 4.36,\ 6.25,\ 9.95,\ 19.98$ are $\sqrt{11},\sqrt{19},\sqrt{39},\sqrt{99},\sqrt{399}$ to every digit shown. **The screen evaluates the lemma's own closed form in closed form.** It constructs no curvature tensor, applies no Weyl projection, and could not have detected D1 by any outcome. Under the corrected supremum the same quantity is $\frac m{m-1}\sqrt{2m-1}$, $3.98$ at $m=6$ against the reported $3.32$, so a screen built from an actual $h\owedge g_q$ would have caught the error at the first value. *Secondary: "matching $\sqrt2\sqrt m$" mis-describes even these numbers, which are $\sqrt{2m-1}$; $\sqrt2\sqrt6=3.46$, not $3.32$.*

## What to change

1. **Replace the element.** State $H=\alpha(h\owedge g_q)-\beta(h\owedge g_p)$ with $\alpha=\frac{m-2}{2m-2}$, $\beta=\frac m{2m-2}$, and the three-row eigenvalue table of D1. Record that the pre-projection object fails Ricci-flatness, so the projection cannot be skipped.
2. **Replace the box** with $\frac1{m-1}\le\lVert H\rVert_{op}\le\frac1{\sqrt{m-1}}$ at $\lVert H\rVert_F=1$, upper attained at the pair-concentrated direction, lower a Cauchy–Schwarz bound over the $\binom m2$ block planes rather than an attained value.
3. **Keep the corollary unchanged**, every order in it survives.
4. **Rewrite the verdict box.** The computation meets [r446](REVIEW_r446.md)'s stated criterion; say so, and withdraw "against both readings" in favour of "[r447](REVIEW_r447.md)'s pinning claim does not survive, and [I31](../plan.md) is re-promoted pending the re-run".
5. **Qualify the setting** with $m\ge5$, where $\lambda_m>\mu$ makes $S^2_0(\mathbb R^m)$ the binding summand, and record that the joint $\lambda_m$-eigenspace has the same supremum so one copy suffices.
6. **Delete or rebuild the screen.** As it stands it is a closed form evaluated numerically; a screen that builds the tensor would have caught D1.
