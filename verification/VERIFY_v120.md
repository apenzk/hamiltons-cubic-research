# VERIFY v120, Lemma L20: the tube of radius $0.5748$ around $SO(n).W_{\mathbb{CP}^2}$, its metric, its $\alpha\le\tfrac13$ input, and its final step at odd $n$

**Cold brief.** Verifier v120, round [L20](ROUND_L20.md), text as dispatched from [route-a.md](../findings/route-a.md):89–120 with the canonical form at [results.md](../results.md):673 and the landscape lines at [results.md](../results.md):41, :48 and :232. **No numerical work was done**: no script was run, and every number below is an exact hand evaluation, the transcendental ones by truncated Taylor series with the truncation error bounded and stated. Log: [agent_logs/verify-L20-v120.log](../agent_logs/verify-L20-v120.log).

## Claim table

| # | Claim as written | Verdict |
| --- | --- | --- |
| 1 | The unit sphere of $\mathrm{Weyl}_n$ is compact, so $m=\sqrt{2/3}\max P$ is attained | **CORRECT** |
| 2 | $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $V$ a unit vector of $\mathrm{Weyl}_n$ orthogonal to $u$ | **CORRECT for $\varphi\neq0$; $\varphi=0$ is outside the dispatched text** |
| 3 | $V\perp T_u(SO(n).u)$ by the first-variation condition | **CORRECT, two unstated hypotheses (orbit compact, orbit smooth)** |
| 4 | The expansion $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ is exact with no linear term | **CORRECT** |
| 5 | $\alpha\le\tfrac13$, "this is Nienhaus Theorem 4.14(c), valid for $n\ge9$" | **UNDER-CITED AND NOT PROVED ON THE RECORD**, 4.14(c) alone does not give it; the source's own proof carries a multiplicity-free hypothesis the record calls unverified |
| 6 | $\gamma_V\le m$ because $V$ is itself a unit Weyl operator | **CORRECT, AND NOT CIRCULAR** |
| 7 | $m\le\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$ | **CORRECT** |
| 8 | $\psi\le\psi(0)=1$ on $[0,0.5748]$ | **CORRECT** (margin $6.3\times10^{-6}$ at the right endpoint) |
| 9 | "$\psi$ falls to $0.9787$ near $\varphi=0.3927$" | **WRONG STATIONARY POINT**, the minimum is at $\sin\varphi=\tfrac{\sqrt3-1}{2}$, $\varphi=0.374737$, $\psi=0.978593$. Cosmetic |
| 10 | "first exceeding $1$ at $\varphi=0.5748$" | **FALSE AS WRITTEN, ERRING SAFE**, $\psi(0.5748)=0.9999937<1$; the crossing is at $0.5748263$ |
| 11 | The final step: "the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)$" | **EMPTY AT ODD $n$**, the named object does not exist there |
| 12 | $\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$; $n\ge12$ | **CORRECT** |
| 13 | The metric of $d$ | **UNDEFINED IN THE PROOF BLOCK AND IN [conventions.md](../findings/conventions.md)**; the expansion commits it to geodesic angular distance; the chord reading breaks the stated radius |
| 14 | "Proven unconditionally" ([results.md](../results.md):41, :48, :232) | **TRUE IN ONE SENSE, FALSE IN THE OTHER, AND THE THREE CITABLE LINES CARRY NO QUALIFIER** |

**Verdict: HYPOTHESIS-DEBT.** The bootstrap is sound and non-circular, the cubic expansion is exact, and $\psi\le1$ holds on the closed interval the proof uses. What is owed is named in §13: the odd-$n$ witness, and $\alpha\le\tfrac13$ at $n\ge12$ free of the multiplicity-free hypothesis its source's proof carries.

## 0. Conventions, fixed once

- $\mathrm{Weyl}_n\subset S^2(\Lambda^2\mathbb R^n)$ is a linear subspace, with the inner product $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$ that makes $\lVert W\rVert=1$ meaningful. $Q(W)=W^2+W^\#$, $P(W)=\langle Q(W),W\rangle$, and $T$ is the polarization normalised so that $T(W,W,W)=P(W)$.
- $u=W_{\mathbb{CP}^2}$ padded into $\mathrm{Weyl}_n$, $\theta^*=\sqrt{3/2}=P(u)$, $Q(u)=\theta^*u$. $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and $\Theta_n$ the diagonal maximum, $=\theta_0(n)$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, [conventions.md](../findings/conventions.md):18–19.
- $\mathcal O=SO(n).u$, $T_u\mathcal O$ its tangent space, $F_u(h)=\tfrac12(uh+hu)+u\#h$.
- $\varphi\in[0,\pi/2)$ throughout, so $\cos\varphi>0$, $\sin\varphi\ge0$ and $1-\sin^3\varphi>0$.
- Every decimal below is a truncated Taylor evaluation; alternating series with decreasing terms are used, so each truncation error is bounded by the first omitted term, and that bound is stated where it matters.

## 1. Hypothesis inventory, every input, and where it comes from

| # | Input the written proof uses | Status |
| --- | --- | --- |
| H1 | $\mathrm{Weyl}_n$ finite-dimensional, so its unit sphere is compact and $\max P$ is attained | **proved here** (stated in the block) |
| H2 | $P$ is a cubic form whose polarization $T$ is totally symmetric, and $T(u,V,V)=\langle F_uV,V\rangle$ with $F_u(h)=\tfrac12(uh+hu)+u\#h$ | **imported, source read**: Nienhaus states the symmetry of $\mathrm{tri}(R,S,T)=\mathop{\mathrm{tr}}((R\circ S+S\circ R+2R\#S)T)$ in the proof of Theorem 4.17, extraction L4720. In [references/](../references/). Hypotheses: none beyond $W\in S^2(\Lambda^2)$, hold at $u,V$ |
| H3 | $P$ is $SO(n)$-invariant for the conjugation action, and the action is by isometries | **assumed, unstated in the block**; standard, and it is what licenses both the rotation to $u$ and $T_u\mathcal O\perp u$ |
| H4 | $Q(u)=\theta^*u$ with $\theta^*=\sqrt{3/2}$, $\lVert u\rVert=1$ | **imported, source read**: Nienhaus Proposition 2.25 and Chapter 4; in [references/](../references/) |
| H5 | The orbit $\mathcal O$ is compact, so a nearest point exists; and smooth, so $T_u\mathcal O$ exists | **used, nowhere stated**, see §3 |
| H6 | $\sin\varphi\neq0$, needed to divide $W^*-\cos\varphi\,u$ by $\sin\varphi$ and get $V$ | **used, nowhere stated in the dispatched text**; the source covers $\varphi=0$ one line past the quoted range, at [route-a.md](../findings/route-a.md):121 |
| H7 | $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O^\perp$ | **imported and not proved on the record**, see §4. Nienhaus Theorem 4.14 ($n\ge9$) plus Remark 4.16; 4.14's proof runs through Lemma 4.13, valid only on **multiplicity-free** isotypic components, a hypothesis the record itself calls unverified at Proposition 4.11's components. The record's replacement is [Lemma L21](../findings/route-a.md), whose exhaustion table is short by $940$ of $1638$ dimensions per [r484](../reviews/REVIEW_r484.md) |
| H8 | $V\in\mathrm{Weyl}_n$ and $\lVert V\rVert=1$, so $\gamma_V\le m$ | **proved here**; $\mathrm{Weyl}_n$ is a subspace and $W^*,u$ lie in it |
| H9 | $\psi\le1$ on $[0,0.5748]$ | **proved here**, and re-derived by hand in §6 |
| H10 | A unit Weyl operator with $P>\theta^*$ exists at every $n\ge12$ | **supplied only at even $n$**, see §7. Nienhaus Proposition 2.25 with $k=l=n/2$ gives $\theta_0(n)$; at odd $n$ the named object does not exist |
| H11 | $\theta_0(n)>\theta^*\iff n>6+2\sqrt7$ | **proved here**, checked exactly in §7 |

Two further hypotheses appear in the *statement* and not in the proof: the metric that $d$ is measured in (§5), and, reading the canonical form at [results.md](../results.md):232 alone, nothing at all fixing either the metric or the parity (§8).

## 2. The expansion, re-derived

Write $W^*=\cos\varphi\,u+\sin\varphi\,V$. Since $P$ is a cubic form with totally symmetric polarization $T$ (H2),

$$P(W^*)=\cos^3\varphi\,P(u)+3\cos^2\varphi\sin\varphi\,T(u,u,V)+3\cos\varphi\sin^2\varphi\,T(u,V,V)+\sin^3\varphi\,P(V).$$

**The constant term.** $\sqrt{2/3}\,P(u)=\sqrt{2/3}\cdot\sqrt{3/2}=1$ exactly, giving $\cos^3\varphi$. ✔

**The linear term vanishes.** $\nabla P(W)=3Q(W)$, because $P(W)=\langle Q(W),W\rangle$ with $Q$ the gradient direction of the same cubic; hence $T(u,u,V)=\tfrac13\langle\nabla P(u),V\rangle=\langle Q(u),V\rangle=\theta^*\langle u,V\rangle=0$ by H4 and $V\perp u$. This is exactly the block's sentence, and it is right. ✔

**The quadratic term.** The $t^2$ coefficient of $P(u+tV)$ is $3T(u,V,V)$. Computing it directly: from $\mathop{\mathrm{tr}}((u+tV)^3)$ the $t^2$ part is $\mathop{\mathrm{tr}}(uVV+VuV+VVu)=3\mathop{\mathrm{tr}}(uV^2)=3\langle\tfrac12(uV+Vu),V\rangle$; and from $\langle W,W^\#\rangle$, whose polarization $(A,B,C)\mapsto\langle A,B\#C\rangle$ is totally symmetric, the $t^2$ part is $\langle u,V\#V\rangle+2\langle V,u\#V\rangle=3\langle u\#V,V\rangle$. Adding, $3T(u,V,V)=3\langle F_uV,V\rangle$ with $F_u(h)=\tfrac12(uh+hu)+u\#h$, the block's $F_u$, term for term. ✔ So $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ is the block's $\alpha$.

**Consistency with the source.** Nienhaus writes the same expansion in the proof of Theorem 4.17 with $\alpha=\sqrt{2/3}\langle Q(W),W_{\mathbb{CP}^2}\rangle$ (extraction L4722). Total symmetry gives $T(u,V,V)=T(V,V,u)=\langle Q(V),u\rangle$, so the two definitions of $\alpha$ coincide. The block's expansion is Nienhaus's $f(\varphi)$ evaluated at $\varphi=d(W^*,\mathcal O)$, with $\gamma$ renamed $\gamma_V$. ✔

**No finding.** The expansion is exact, the linear term genuinely vanishes, and both coefficient identifications check.

## 3. The first-variation step

> "The vector $V$ is a unit vector orthogonal to $u$, and orthogonal also to $T_u(SO(n).u)$ by the first-variation condition for a nearest point on the orbit."

**What a nearest point gives.** On the unit sphere, minimizing the angle to the orbit is maximizing $g\mapsto\langle W^*,g.u\rangle$ over $SO(n)$. If the maximum is at $g=e$ then for every $X\in\mathfrak{so}(n)$ the derivative $\langle W^*,[X,u]\rangle$ vanishes, i.e. $W^*\perp T_u\mathcal O$. The action is isometric (H3), so $\mathcal O$ lies in the unit sphere and $u\perp T_u\mathcal O$. Hence $\sin\varphi\,V=W^*-\cos\varphi\,u\perp T_u\mathcal O$, and dividing by $\sin\varphi>0$ gives $V\perp T_u\mathcal O$. ✔ And $\lVert V\rVert=1$ follows from $1=\lVert W^*\rVert^2=\cos^2\varphi+\sin^2\varphi\lVert V\rVert^2$ with $V\perp u$. ✔

**What is needed and not stated.** Three things.

1. **The nearest point exists.** $SO(n)$ is compact and the action is continuous, so $\mathcal O$ is compact and the infimum is attained. The block says "a nearest point" and never says why one exists.
2. **The orbit is a smooth submanifold**, so that $T_u\mathcal O$ is a well-defined subspace rather than a symbol. This is the orbit of a compact Lie group acting smoothly, so it holds; the block does not say it.
3. **$\sin\varphi\neq0$.** At $\varphi=0$ the vector $V$ is not defined by the displayed equation at all. The dispatched text ends at "Therefore $\varphi>0.5748$" and never mentions it; the source covers it one line past the quoted range ([route-a.md](../findings/route-a.md):121), and the coverage is correct, at $\varphi=0$ one has $m=1$ directly and the same contradiction applies.

**Discrepancy, three-step record.** *Locate:* the sentence above, [route-a.md](../findings/route-a.md):111. *Exhibit:* at $\varphi=0$, i.e. $W^*\in\mathcal O$, a configuration the supposition $\varphi\le0.5748$ explicitly admits, the sentence quantifies over a $V$ that the preceding display does not determine. *Argue the opposite:* the most charitable reading is that "$\varphi:=d(W^*,\mathcal O)\le0.5748$" is being split silently into $\varphi=0$ and $\varphi>0$, which is what the source does one line later. **Verdict: withdrawn as a defect of the record, upheld as a defect of the dispatched excerpt**, the excerpt stops one line short of its own degenerate branch. Nothing is owed here.

## 4. $\alpha\le\tfrac13$, the arithmetic is exact, the citation is short, and the input is not proved on the record

> "The largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(n).u)^\perp$ is $\tfrac13\theta^*$, so $\alpha\le1/3$; this is Nienhaus Theorem 4.14(c), valid for $n\ge9$ and reverified here from scratch."

**The arithmetic.** Granting the eigenvalue statement, $\alpha=\sqrt{2/3}\langle F_uV,V\rangle\le\sqrt{2/3}\cdot\tfrac13\theta^*\lVert V\rVert^2=\sqrt{\tfrac23}\cdot\tfrac13\sqrt{\tfrac32}=\tfrac13$ exactly. ✔ And the substitution needs $\cos\varphi\ge0$ and $\sin\varphi\ge0$, both true on $[0,0.5748]$. ✔

**The citation is short of what it is used for.** [Nienhaus, Theorem 4.14](https://arxiv.org/abs/2311.02404) (extraction L4365) lists seven eigenvalues of $F_{W_{\mathbb{CP}^2}}$ on all of $\mathrm{Weyl}_n$, namely $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}\cdot\theta^*$. Clause **(c)** names the $\tfrac13\theta^*$-eigenspace and nothing more; on its own it does not say that $\tfrac13\theta^*$ is the **largest** eigenvalue on $u^\perp\cap T_u\mathcal O^\perp$. That statement needs, in addition:

- clause **(a)**, which puts the eigenvalue $\theta^*$ on $\langle u\rangle$, removed by $u^\perp$; and
- the identification of clause **(b)**'s $\tfrac12\theta^*$-eigenspace $\mathrm{Weyl}_4^{-,1}\oplus X_4^{-,2}\otimes\mathbb R^{n-4}$ with $T_u\mathcal O$, removed by $T_u\mathcal O^\perp$.

The second is the load-bearing one, and it is **not in Theorem 4.14**. It is in [Nienhaus, Remark 4.16](https://arxiv.org/abs/2311.02404) (extraction L4655), which proves $F(W)=\tfrac12\theta^*W$ for $W\in T_u\mathcal O$ by differentiating $Q$ along the orbit, and then obtains the identification "by dimension comparison". The dimension comparison is checkable and it closes: $\dim T_u\mathcal O=\dim\mathfrak{so}(n)-\dim\mathrm{Stab}(u)=\tfrac{n(n-1)}2-\bigl(4+\tfrac{(n-4)(n-5)}2\bigr)=\tfrac{8n-20}2-4=4n-14$, against $\dim\mathrm{Weyl}_4^{-,1}+(n-4)\dim X_4^{-,2}=2+4(n-4)=4n-14$. ✔ The same count is on the record at [r464](../reviews/REVIEW_r464.md):119.

**Why this matters rather than being pedantry.** If any part of clause (b) lay outside $T_u\mathcal O$, then $V$ could carry a $\tfrac12\theta^*$-component and the bound would be $\alpha\le\tfrac12$, at which, by the record's own scaling note, [route-a.md](../findings/route-a.md):99, the critical angle is zero and the lemma is empty. So the block cites, for its single quantitative input, a clause that supplies about half of it; the other half is one remark away in a source that is in [references/](../references/).

**And the input is not proved on the record.** Theorem 4.14's proof runs through [Nienhaus Lemma 4.13](../references/nienhaus-2023-second-best-einstein/notes.md) (extraction L4349), Schur's lemma applied to isotypic components, **valid only on multiplicity-free components**, the reference card records this, and the record's own [Lemma L21](../findings/route-a.md) exists precisely because that hypothesis is unverified at Proposition 4.11's decomposition. So:

- **as an import**, $\alpha\le\tfrac13$ has a source in [references/](../references/), read here, whose *stated* hypothesis $n\ge9$ holds at every $n\ge12$, but whose *proof* carries a hypothesis the record itself calls unchecked at the object;
- **as a claim proved elsewhere on the record**, it is [Lemma L21](../findings/route-a.md), whose exhaustion table accounts for $698$ of $\dim\mathrm{Weyl}_{12}=1638$ dimensions, the other $940$ carried by a row reading "two higher types … $0$ throughout" with no types and no dimensions ([r484](../reviews/REVIEW_r484.md)), and whose $F_\lambda$ spectra the record describes as exact only at $n=6,8,10$ and floating-point at $n=12,14$.

**The block's phrase "reverified here from scratch" is a claim about work elsewhere**, not an argument in the block, and the block never names L21, so a reader who follows only the citation lands on Nienhaus and inherits the multiplicity-free hypothesis. **Finding: H7 is owed.** *Locate:* [route-a.md](../findings/route-a.md):115. *Exhibit:* at $n=12$, the $940$ dimensions L21's table does not name are exactly where a $\tfrac13\theta^*$-exceeding eigenvalue would have to hide; nothing in the block or in L21's table excludes one. *Argue the opposite:* the most charitable reading is that the block is citing a published theorem whose statement covers $n\ge12$, that the author's proof is the author's problem, and that the record's own repair is an improvement rather than a dependency, on that reading the block is a faithful citation of a published result and the debt is Nienhaus's. **The candidate stands under the charitable reading too**, because the record's canonical form calls the lemma *proven unconditionally*, which a faithful citation of an unrepaired published proof does not support.

## 5. What is $d$?, the metric the expansion commits to, and what a different reading costs

**The proof's own parametrization fixes it.** From $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $V\perp u$ and $\lVert V\rVert=1$ one gets $\langle W^*,u\rangle=\cos\varphi$, i.e.

$$\varphi=\arccos\langle W^*,u\rangle,$$

the **angle** between $W^*$ and the nearest orbit point, geodesic distance on the unit sphere of $\mathrm{Weyl}_n$, of diameter $\pi$. That is the only reading under which the symbol $\varphi$ in "$\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})$" and the symbol $\varphi$ in the expansion are the same number, and the proof uses them as the same number throughout.

**Where it is stated.** [results.md](../results.md):673 says "within angular distance $0.5748$". That is the *only* place: [conventions.md](../findings/conventions.md) has no row for $d$; the proof block at [route-a.md](../findings/route-a.md):111 writes $d(\cdot,\cdot)$ with no definition; and the two landscape lines, [results.md](../results.md):232 and :48, say "within $0.5748$ of the rival maximizer's orbit" and "closes the tube itself" with no metric at all.

**What the chord reading costs, exhibited exactly.** Read $d$ as the ambient distance $\lVert W^*-g.u\rVert=2\sin(\varphi/2)$. Then $d\le0.5748$ is $\varphi\le2\arcsin(0.2874)$. By the arcsine series $\arcsin x=x+\tfrac{x^3}6+\tfrac{3x^5}{40}+\tfrac{15x^7}{336}+\tfrac{105x^9}{3456}+\cdots$ at $x=0.2874$ (all terms positive, the tail beyond $x^9$ bounded by $3\times10^{-8}$):

$$\arcsin(0.2874)=0.2874+0.00395648+0.00014706+0.00000723+0.00000041=0.29151118,\qquad \varphi=0.5830224.$$

At that angle, by the alternating Taylor series for $\sin$ and $\cos$ (each truncation error below $10^{-8}$),

$$\cos(0.5830224)=0.8348025,\qquad \sin(0.5830224)=0.5505496,\qquad \sin^3=0.1668742,$$

$$\psi(0.5830224)=\frac{0.8348025}{1-0.1668742}=\frac{0.8348025}{0.8331258}=1.0020125>1.$$

So under the chord reading the chain gives $m\le1.00201$, no contradiction with $\theta_0(12)\sqrt{2/3}=\sqrt{55/54}=1.00921\ldots$, and **the proof does not reach its own stated radius**: the band of angles $(0.5748263,\,0.5830224]$ is left unproved. The claim is not false under that reading, it is unproved, and it is a strictly stronger claim, since chord $0.5748$ is angle $0.5830$.

**Finding, three-step record.** *Locate:* "$\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})\le0.5748$", [route-a.md](../findings/route-a.md):111, and the canonical one-liner at [results.md](../results.md):232. *Exhibit:* at the angle $0.5830224$ (inside the tube under the chord reading, outside it under the geodesic reading), $\psi>1$ by the exact evaluation above, so the argument produces no contradiction there. *Argue the opposite:* the charitable reading is that the expansion itself defines $\varphi$ as the angle, so a reader who reads the proof cannot get the chord reading; and [results.md](../results.md):673 says "angular". **The candidate survives for [results.md](../results.md):232 and :41/:48, which are the citable one-liners and say neither**, and is withdrawn for the proof block read in full.

## 6. The bootstrap $\gamma_V\le m$, $V$ is a unit Weyl operator, and the inequality closes

**$V$ is one.** $\mathrm{Weyl}_n$ is a linear subspace of $S^2(\Lambda^2\mathbb R^n)$; $W^*$ lies in it because the maximum is taken over its unit sphere, and $u=W_{\mathbb{CP}^2}$ padded lies in it. Hence $V=(W^*-\cos\varphi\,u)/\sin\varphi\in\mathrm{Weyl}_n$, and $\lVert V\rVert=1$ was shown in §3. So $\gamma_V=\sqrt{2/3}P(V)\le\sqrt{2/3}\max P=m$. ✔ Nienhaus's Remark 4.16 independently records that every element of $T_u\mathcal O$ is a Weyl operator, which is the neighbouring fact and is not the one needed here.

**It closes rather than circling.** $m$ is a *number* (the value of an attained maximum over a compact set), fixed before the supposition is made and never assumed to satisfy any bound. Substituting $\alpha\le\tfrac13$ and $\gamma_V\le m$ into the expansion, and using $\cos^3\varphi+\cos\varphi\sin^2\varphi=\cos\varphi$:

$$m\le\cos^3\varphi+\cos\varphi\sin^2\varphi+m\sin^3\varphi=\cos\varphi+m\sin^3\varphi\ \Longrightarrow\ m(1-\sin^3\varphi)\le\cos\varphi.$$

Since $\varphi\le0.5748<\pi/2$ gives $1-\sin^3\varphi>0$, division is legitimate and $m\le\psi(\varphi)$. ✔ The inequality is a genuine constraint on $m$ rather than a tautology precisely because the coefficient $\sin^3\varphi<1$: with $\sin^3\varphi=1$ it would read $m\le m$ and say nothing, and the whole strength of the step is that $\sin^3\varphi$ is bounded away from $1$ on the tube. **No finding.**

**What the bootstrap replaces.** Nienhaus's Theorem 4.17 (extraction L4698) caps $\gamma$ using "$f(\varphi)\le1$ on $[0,\pi]$", which is the statement that $W_{\mathbb{CP}^2}$ is the global maximizer, available only for $n\le11$, hence circular against this programme's goal at $n\ge12$. The block's substitution of the attained $m$ for that cap is exactly the repair, and it is legitimate. ✔ Read in the source, not from memory.

## 7. $\psi\le1$ on $[0,0.5748]$, proved exactly, and two descriptive errors

Write $s=\sin\varphi$, $c=\cos\varphi$ with $\varphi\in[0,\pi/2)$, so $c=\sqrt{1-s^2}>0$ and $1-s^3>0$.

$$\psi(\varphi)\le1\iff c\le1-s^3\iff 1-s^2\le1-2s^3+s^6\iff 0\le s^2\bigl(s^4-2s+1\bigr)\iff s^4-2s+1\ge0.$$

Now $s^4-2s+1=(s-1)(s^3+s^2+s-1)$, expand: $s^4+s^3+s^2-s-s^3-s^2-s+1=s^4-2s+1$. ✔ On $[0,1)$ the factor $s-1$ is negative, so

$$\boxed{\ \psi(\varphi)\le1\iff q(s):=s^3+s^2+s-1\le0\iff s\le s^*\ }$$

with $s^*$ the unique root of $q$ in $(0,1)$, unique because $q'(s)=3s^2+2s+1>0$ everywhere. Exact bracketing, by integer arithmetic on the decimals:

- $q(0.5436)=0.160634321856+0.29550096+0.5436-1=-0.000264718144<0$;
- $q(0.5437)=0.160722988453+0.29560969+0.5437-1=+0.000032678453>0$.

So $s^*\in(0.5436,0.5437)$, and linear interpolation against $q'\approx2.974$ puts it at $0.5436889$. And by the alternating series for $\sin$ at $0.5748$ (terms $0.5748$, $0.03165185$, $0.00052288$, $0.00000411$, $0.0000000189$; truncation error below $2\times10^{-8}$),

$$\sin(0.5748)=0.54366694<0.5436889\le s^*,$$

confirmed independently by $q(0.54366694)\approx-0.000264718+2.974\times0.0000669=-0.0000657<0$. Hence **$\psi\le1$ on the whole closed interval $[0,0.5748]$**, so $m\le1$, i.e. $\max P\le\sqrt{3/2}$. ✔ The margin is $s^*-\sin(0.5748)=2.2\times10^{-5}$, i.e. $\varphi_c-0.5748=2.63\times10^{-5}$ in angle, the radius is the root truncated downwards, and it is truncated in the safe direction.

**Two descriptive errors in the same sentence.**

1. > "$\psi$ falls to $0.9787$ near $\varphi=0.3927$"

 *Locate:* [route-a.md](../findings/route-a.md):119. *Exhibit:* the stationary point of $\psi$ solves $-s+s^4+3s^2c^2=0$, i.e. after dividing by $s$ and substituting $c^2=1-s^2$, $\,2s^3-3s+1=0$, i.e. $(s-1)(2s^2+2s-1)=0$, whose root in $(0,1)$ is $s=\tfrac{\sqrt3-1}2=0.3660254$, giving $\varphi=\arcsin(0.3660254)=0.3747372$ and $\psi=0.9306049/(1-0.0490381)=0.9785933$. The quoted $0.3927$ is $\pi/8$, where $\psi=0.9787302$ and $\psi'>0$ already: the numerator $-s+s^4+3s^2c^2$ equals $-0.3826834+0.0214466+0.3750000=+0.0137632>0$, so $0.3927$ is on the rising branch, not at the minimum. *Argue the opposite:* "near" is vague and both numbers agree to three decimals with the true minimum, so the sentence is a shape description and the shape (dips below $1$, rises again), is correct. **Verdict: real but cosmetic**; nothing downstream uses the location or the depth of the minimum.

2. > "first exceeding $1$ at $\varphi=0.5748$"

 *Locate:* same line. *Exhibit:* $\psi(0.5748)=0.9999937<1$, since $\sin(0.5748)<s^*$ above; $\psi$ first exceeds $1$ at $\arcsin s^*=0.5748263$. *Argue the opposite:* the sentence is a rounded statement of the crossing, and it errs in the direction that makes the proof valid rather than invalid. **Verdict: real, harmless, and worth one word**, "first exceeding $1$ just above $0.5748$" would be true.

## 8. The final step at odd $n$, the object it needs, and whether that object exists

> "But the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)$, which exceeds $\sqrt{3/2}$ for $n\ge12$, a contradiction."

**Follow it to its conclusion.** The chain has delivered $m\le1$, i.e. $\max P\le\theta^*$. To contradict that, one needs precisely:

> **an object $X\in\mathrm{Weyl}_n$ with $\lVert X\rVert=1$ and $P(X)>\theta^*=\sqrt{3/2}$.**

Nothing else, not criticality, not diagonality, not a location relative to the tube. The block supplies the object by name: the *balanced* sphere product, with value $\theta_0(n)$.

**At even $n$ the object exists and the value is right.** [Nienhaus Proposition 2.25](../references/nienhaus-2023-second-best-einstein/notes.md) gives $\theta_{k,l}=\sqrt2\sqrt{\tfrac{k-1}k\cdot\tfrac{l-1}l\cdot\tfrac{n-1}{n-2}}$ with $P(W_{S_{k,l}})=\theta_{k,l}$. At $k=l=n/2$: $\tfrac{k-1}k=\tfrac{l-1}l=\tfrac{n-2}n$, so $\theta_{k,l}^2=2\cdot\tfrac{(n-2)^2}{n^2}\cdot\tfrac{n-1}{n-2}=\tfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. ✔ Exactly the block's $\theta_0$. And $\theta_0(n)^2>\tfrac32\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915\ldots$ ✔, so the block's threshold statement is exact, and at $n=12$, $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}$ against $\tfrac32=\tfrac{54}{36}$, a margin of exactly $\tfrac1{36}$.

**At odd $n$ the named object does not exist.** There is no balanced split of an odd $n$. The nearest splits are $k=\tfrac{n-1}2$, $l=\tfrac{n+1}2$, and Proposition 2.25 gives

$$\theta_{k,l}^2=2\cdot\frac{n-3}{n-1}\cdot\frac{n-1}{n+1}\cdot\frac{n-1}{n-2}=\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\Theta_n^2,$$

which is **strictly below** $\theta_0(n)^2$: the difference is $\tfrac{2(n-1)\left[(n-2)^2(n+1)-n^2(n-3)\right]}{n^2(n+1)(n-2)}$ and the bracket is $(n^3-3n^2+4)-(n^3-3n^2)=4$ identically, so

$$\theta_0(n)^2-\Theta_n^2=\frac{8(n-1)}{n^2(n+1)(n-2)}>0\quad\text{at every }n.$$

✔ (This is the identity [results.md](../results.md):48 and [conventions.md](../findings/conventions.md):18 record; it checks.) So at odd $n$ **no sphere product attains $\theta_0(n)$**, and the block's sentence names an object that is not there. Every other route to $\theta_0(n)$ at odd $n$ is likewise absent from the block: it offers no other family, and no argument that some unit Weyl operator attains $\theta_0(n)$.

**Finding, three-step record.** *Locate:* [route-a.md](../findings/route-a.md):119, quoted above, reproduced at [results.md](../results.md):673 as "contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains" and at [results.md](../results.md):232 as "contradicting the sphere product's larger value". *Exhibit:* at $n=13$ (inside the lemma's stated range $n\ge12$), the block's witness would need $P=\theta_0(13)=\sqrt{2\cdot12\cdot11}/13=\sqrt{264}/13$, i.e. $\theta_0(13)^2=\tfrac{264}{169}$, while the largest sphere-product value at $n=13$ is $\Theta_{13}^2=\tfrac{2\cdot12\cdot10}{14\cdot11}=\tfrac{120}{77}$, and $\tfrac{264}{169}-\tfrac{120}{77}=\tfrac{264\cdot77-120\cdot169}{13013}=\tfrac{20328-20280}{13013}=\tfrac{48}{13013}>0$. The named object does not exist at $n=13$. *Argue the opposite:* the most charitable reading is that "balanced sphere product" is shorthand for "the best sphere product", whose value at odd $n$ is $\Theta_n$ rather than $\theta_0(n)$, but the block writes the value $\theta_0(n)$ explicitly, twice derives its threshold $n>6+2\sqrt7$ from that formula, and the record elsewhere records $\theta_0(n)>\Theta_n$ at odd $n$ as a distinct fact, so the shorthand reading contradicts the block's own arithmetic. **The candidate stands.**

**What would have to be shown, and what I am not doing.** The conclusion is recoverable, and I do not record it as recovered: recovering it requires a *different* witness and a *different* threshold, $\Theta_n^2>\tfrac32\iff4(n-1)(n-3)>3(n+1)(n-2)\iff n^2-13n+18>0\iff n>\tfrac{13+\sqrt{97}}2=11.4244\ldots$, a polynomial the block never writes and whose root differs from $6+2\sqrt7$. Neither the substitution of $\Theta_n$ for $\theta_0(n)$ nor the threshold $n^2-13n+18>0$ appears in the proof block or in either canonical statement. **This is HYPOTHESIS-DEBT at odd $n$, not a refutation**; §11 records where on the record the repair does live, and why that placement is itself the finding.

## 9. Quantifier order, scope, and every edge of every range

- **"No maximizer" versus "some $W^*$".** The block writes "the maximum is attained, at some $W^*$", then supposes *that* $W^*$ is near the orbit, and concludes "$\varphi>0.5748$". Read literally that is a statement about one maximizer, while the canonical form quantifies over all of them. The proof survives the gap because nothing about $W^*$ is used beyond $\sqrt{2/3}P(W^*)=m$, and the contradiction reached is global ($\max P\le\theta^*$ against a fixed witness value), so the identical argument applies to every maximizer. **Charitable reading holds; the wording is loose.** ✔
- **$n=12$ exactly.** $\theta_0(12)^2=\tfrac{55}{36}>\tfrac{54}{36}$; $\sqrt{2/3}\,\theta_0(12)=\sqrt{55/54}=1.00921\ldots>1$. Strict, with margin $\tfrac1{36}$ in $\theta^2$. ✔
- **$n=11$, just below.** $n^2-12n+8=-3<0$ and $n^2-13n+18=-4<0$: no witness at either parity's formula, and the argument correctly returns $\max P\le\theta^*$ with nothing to contradict, the block says exactly this at [route-a.md](../findings/route-a.md):123. ✔
- **Odd $n$.** $n=13$ is the first odd value in range: §8. **Empty as written.**
- **$\varphi=0$.** Outside the dispatched excerpt; handled correctly one line past it. ✔ (§3)
- **$\varphi=0.5748$, the right endpoint.** Included in the supposition ("$\le0.5748$") and covered: $\sin(0.5748)<s^*$ strictly, so $\psi(0.5748)<1$. ✔ Had the radius been quoted as $0.57483$ the endpoint would fail.
- **$\varphi$ between $0.5748$ and $\varphi_c=0.5748263$.** Not claimed, and true; the statement is the weaker one. ✔
- **The hypothesis "$n\ge9$" of the imported eigenvalue bound** is implied by $n\ge12$. ✔ Its *proof's* hypothesis is §4's finding.

## 10. The forms compared

| Where | What it says | What it omits |
| --- | --- | --- |
| [route-a.md](../findings/route-a.md):89 (heading) + :109–124 | Heading, a notation line, and the proof | **It carries no statement.** $0.5748$ appears only inside the supposition "$\varphi\le0.5748$"; the heading says "near", with no radius, no metric and no quantifier over maximizers |
| [results.md](../results.md):673 | Full statement: "for every $n\ge12$, no maximizer … within **angular** distance $0.5748$", with the proof sketch naming [L21](../findings/route-a.md) and the self-bootstrap | The odd-$n$ defect, it repeats "the value $\theta_0(n)>\theta^*$ the sphere product attains" |
| [results.md](../results.md):232 | The one-line canonical form: "No maximizer lies within $0.5748$ … Proven unconditionally by bootstrap" | **The metric, the parity, and every qualifier on the inputs** |
| [results.md](../results.md):41 | "The neighbourhood of the rival is closed **unconditionally** for every $n\ge12$ (**Lemmas 20–22**), including the estimate Nienhaus states and leaves open" | That the bundle it names includes [Observation L22](../findings/route-a.md), which the record itself calls **conditional** at [results.md](../results.md):232 and in its own entry, so the sentence attaches "unconditionally" to a set with a conditional member |
| [results.md](../results.md):48 | "Lemma L20 closes the tube itself unconditionally for $n\ge12$ and does not rest on Lemma L22" | The metric; the qualifier on $\alpha\le\tfrac13$ |
| [ROUND_L20.md](ROUND_L20.md):35 (canonical form as quoted to this round) | Identical to :232 | Identical omissions |

**Lean.** [lean/INDEX.md](../lean/INDEX.md) carries six rows touching L20, and **none of them formalises the lemma**:

- [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean), *partial*: $\psi(\varphi)=1$ reduces to the real root of $s^3+s^2+s-1$, bracketed to $(0.5436890,0.5436891)$ and shown irrational. **This is the same factorisation I derived independently in §7**, and the bracket agrees with my $q(0.5436)<0<q(0.5437)$. Owed there: that $\varphi=\arcsin s^*$ and the cubic expansion.
- [L20.lean](../lean/HamiltonsCubic/Results/L20.lean) and [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean), *proved*: the radius as an algebraic number, and the odd-$n$ witness under $\Theta_n$ with threshold $n^2-13n+18>0$. Both rows state **"Owed: the cubic expansion and $\alpha\le\tfrac13$"**.
- [TubeInputs.lean](../lean/HamiltonsCubic/Results/TubeInputs.lean), [Crossover.lean](../lean/HamiltonsCubic/Results/Crossover.lean), [L21.lean](../lean/HamiltonsCubic/Results/L21.lean), the threshold arithmetic and L21's missing $940$ dimensions.

**What a row for the lemma itself would have to claim**, and none does: *for every $n\ge12$ and every maximizer $W^*$ of $P$ on the unit sphere of $\mathrm{Weyl}_n$, $\arccos\langle W^*,g.W_{\mathbb{CP}^2}\rangle>0.5748$ for all $g\in SO(n)$*, which requires formalising $\mathrm{Weyl}_n$, $Q$, $\#$, the orbit and its tangent space, and would have $\alpha\le\tfrac13$ as an explicit hypothesis. The existing rows are the two constants and one arithmetic threshold; the analysis is untouched.

## 11. The named trap, each citable claim read alone, as a consumer would

The record's corrections to this lemma exist. **Every one of them sits beside a statement that still carries the defect.**

| Correction | Where it lives | What still carries the defect |
| --- | --- | --- |
| The metric is geodesic angular distance | blockquote at [route-a.md](../findings/route-a.md):101 | the proof block ([route-a.md](../findings/route-a.md):111, "$d$" undefined); [results.md](../results.md):232, :41, :48; [conventions.md](../findings/conventions.md) has no row at all |
| The final step is empty at odd $n$; use $\Theta_n$ | blockquote at [route-a.md](../findings/route-a.md):103, plus two Lean rows | the proof's own last sentence ([route-a.md](../findings/route-a.md):119); **[results.md](../results.md):673, whose two blockquotes are about "unconditional" and about past misdescriptions and say nothing about parity**; [results.md](../results.md):232 |
| "Unconditional" means free of circular inputs, not input-complete | blockquote at [results.md](../results.md):675 | [results.md](../results.md):41, :48, :232, and the canonical form as dispatched to this round |
| The input is [L21](../findings/route-a.md), not Nienhaus alone | [results.md](../results.md):673 and its second blockquote | **the proof block, which names Nienhaus 4.14(c) and never names L21**, the reverse direction of the same trap |

**Read alone, in the way a citation reads:**

1. **[results.md](../results.md):232**, a reader gets a radius with no metric, a range covering odd $n$ whose proof is empty there, and the word "unconditionally" attached to a chain whose one quantitative input is unproved on this record. Four defects inherited in one line.
2. **[results.md](../results.md):41**, inherits "unconditionally" over a bundle containing a conditional observation.
3. **[results.md](../results.md):673**, the best of them: the metric is right and "unconditional" is qualified next to it. It still hands the reader the odd-$n$ witness that does not exist.
4. **[route-a.md](../findings/route-a.md):89–124 read as a unit**, a reader gets the corrections first, because they are blockquoted above the proof. This is the one placement on the record that does not spring the trap, and it works only because the blockquotes precede rather than follow the argument.

## 12. What would falsify the statement, and what I did to look for it

**The falsifier for the statement** is a single object: a maximizer $W^*$ of $P$ on the unit sphere of $\mathrm{Weyl}_n$ at some $n\ge12$ with $\arccos\langle W^*,g.u\rangle\le0.5748$ for some $g\in SO(n)$. Producing one would refute the lemma outright.

**The falsifier for the argument** is cheaper and is where I looked: a unit $V\in u^\perp\cap T_u\mathcal O^\perp$ with $\sqrt{2/3}\langle F_uV,V\rangle>\tfrac13$. What I did, analytically and with no computation:

- **Read the whole spectrum in the source.** [Nienhaus Theorem 4.14](https://arxiv.org/abs/2311.02404) (a)–(g) gives $F_u$'s eigenvalues as $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}\cdot\theta^*$. Only two exceed $\tfrac13\theta^*$: clause (a) on $\langle u\rangle$, killed by $V\perp u$, and clause (b) on $\mathrm{Weyl}_4^{-,1}\oplus X_4^{-,2}\otimes\mathbb R^{n-4}$.
- **Checked whether clause (b) leaves any room outside the orbit tangent**, since any such room would be a falsifier with $\alpha$ up to $\tfrac12$, where the tube radius collapses to zero. It does not: $\dim T_u\mathcal O=4n-14$ by $\tfrac{n(n-1)}2-4-\tfrac{(n-4)(n-5)}2$, and $\dim$(b)$=2+4(n-4)=4n-14$, and $T_u\mathcal O\subseteq$ (b) because $F_u$ acts on the orbit tangent as $\tfrac12\theta^*$ ([Nienhaus Remark 4.16](https://arxiv.org/abs/2311.02404), extraction L4655, by differentiating $Q(W(t))=\theta^*W(t)$ along the orbit). Equal dimensions plus containment gives equality, so **no falsifier of this kind exists**, granting 4.14.
- **Did not look for one numerically.** This programme is on an analysis-only footing; no script was run, and none of the above needed one.

**Where a falsifier could still live:** inside Theorem 4.14 itself, whose proof uses Schur on components not verified to be multiplicity-free. If some component of Proposition 4.11's decomposition carries a multiplicity, 4.14's eigenvalue list is not established at that component and an eigenvalue above $\tfrac13\theta^*$ outside $\langle u\rangle\oplus T_u\mathcal O$ is not excluded. That is precisely what [Lemma L21](../findings/route-a.md) is for, and precisely where its table leaves $940$ of $1638$ dimensions unnamed.

## 13. Verdict, HYPOTHESIS-DEBT

**The analysis is sound where it is written.** The expansion is exact and its linear term genuinely vanishes (§2); the first-variation step is what a nearest point gives (§3); the bootstrap is legitimate and non-circular, and it is exactly the repair Nienhaus's $n\le11$ cap needed (§6); $\psi\le1$ on the closed interval $[0,0.5748]$, with the radius the root of $s^3+s^2+s=1$ truncated downwards (§7); the crossover arithmetic is exact (§8, §9).

**Three things are owed, and none of them is supplied here.**

1. **The odd-$n$ witness.** The final step needs a unit Weyl operator with $P>\sqrt{3/2}$ at every $n\ge12$. The block names one that does not exist at odd $n$. **To be shown:** that some unit Weyl operator exceeds $\sqrt{3/2}$ at every odd $n\ge13$, with the threshold arithmetic that goes with whatever value it has, which for the near-balanced sphere product is $n^2-13n+18>0$ and not the block's $n^2-12n+8>0$.
2. **$\alpha\le\tfrac13$ at $n\ge12$.** The block cites Nienhaus Theorem 4.14(c). **To be shown:** (a) that $\tfrac13\theta^*$ is the largest eigenvalue of $F_u$ on $u^\perp\cap T_u\mathcal O^\perp$, 4.14(c) gives one eigenspace, and the statement additionally needs 4.14(a),(d)–(g) and the identification of 4.14(b) with $T_u\mathcal O$, which is Remark 4.16 and is not cited; and (b) that the eigenvalue list itself holds without the multiplicity-free hypothesis its published proof uses, which is [Lemma L21](../findings/route-a.md)'s job and is not finished, $940$ of $1638$ dimensions at $n=12$ being carried by an unnamed row.
3. **The metric of $d$.** **To be fixed:** a [conventions.md](../findings/conventions.md) row stating that $d$ is geodesic angular distance on the unit sphere, since the radius is not reading-independent, under the chord reading the same numeral means angle $0.5830224$, where $\psi=1.0020125>1$ and the argument reaches no contradiction.

**Two cosmetic errors** stand in the $\psi$ sentence: the minimum is at $\varphi=0.3747372$ with value $0.9785933$, not "near $0.3927$" with value $0.9787$ (that is $\pi/8$, already on the rising branch); and $\psi$ first exceeds $1$ at $0.5748263$, not at $0.5748$, the latter erring in the safe direction.

**What the verdict is not.** It is not `BROKEN`: no object was found that contradicts the statement, and §12 records that the one cheap class of falsifiers is excluded by the source's own spectrum plus a dimension count that closes. It is not `PROVEN`: the citable forms at [results.md](../results.md):232, :41 and :48 assert a metric-free, parity-blind, "unconditional" theorem, and two of the three inputs behind those words are owed rather than held.
