# Reviewer 103, the both-sided Schur–Horn relaxation, and whether it is circular

Cold brief, own implementation, adversarial. Scripts in [scripts/reviewers/r103/](../scripts/reviewers/r103/); log at [agent_logs/reviewer103.log](../agent_logs/reviewer103.log).

## Verdicts

| Claim | Verdict |
|---|---|
| 1, the two diagonals | **CONFIRMED**, with one over-stated sentence ("Ricci-flatness *is* the vanishing of $K$'s row sums") |
| 2, $t=2$ is forced, and the "iff" | **CONFIRMED**, and the iff is one line, not a numerical fact |
| 3, the constraint is active everywhere | **CONFIRMED and upgraded** from 42 sampled cells to a theorem; two phrasing corrections |
| 4, the relaxation, solved | **REFUTED as maxima.** Every one of the six reported values is too low; I beat all six |
| 5, the route-closing inference | **Conclusion CONFIRMED; every reason given for it is wrong or superfluous**, and the "circular" reading needs re-scoping |

## The implementation these verdicts rest on

Built from the brief's definitions, nothing quoted from the record ([r103_core.py](../scripts/reviewers/r103/r103_core.py)): random algebraic Weyl tensors by Bianchi projection followed by Kulkarni–Nomizu trace removal, $M$ on $\Lambda^2$ over pairs $i<j$, $\mathring W$ on $S^2_0$ in Li's convention $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$, the $\{\varphi_{ab},\psi_k\}$ basis, $K_{ab}=W_{abab}$, and $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$.

Controls that passed before anything was reviewed ([r103_validate.py](../scripts/reviewers/r103/r103_validate.py), [r103_claim1_fine.py](../scripts/reviewers/r103/r103_claim1_fine.py)):

- $\theta(S^{n/2}\times S^{n/2})=\theta_0(n)$ to $2\times10^{-15}$ at $n=6,8,12$; $\theta(\mathbb{CP}^2)=\sqrt{3/2}$; $\theta(\mathbb{CP}^4)=0.986013$ at $n=8$, reproducing the record's figure to six digits.
- $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$ on every sample.
- The sampler **spans**: numerical rank $35/84/168$ against $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ at $n=5,6,7$, singular-value gap $2\times10^0\to3\times10^{-14}$. Spanning is not load-bearing for Claims 1–2 (proved analytically below) but it makes the identity checks non-vacuous.

## Claim 1, CONFIRMED, one sentence over-stated

Residuals on random Weyl tensors at $n=5,6,7,8$ ([r103_claim12.py](../scripts/reviewers/r103/r103_claim12.py)):

| | $n=5$ | $n=6$ | $n=7$ | $n=8$ |
|---|---|---|---|---|
| $\lvert\operatorname{diag}M-K\rvert$ | $0.0$ | $0.0$ | $0.0$ | $0.0$ |
| $\lvert\psi\text{-block}+K\rvert_{\mathbf1^\perp}\rvert$ | $3.3\mathrm e{-16}$ | $1.3\mathrm e{-16}$ | $1.7\mathrm e{-16}$ | $8.3\mathrm e{-17}$ |
| $\lvert\sum d^2-\tfrac32t\rvert$ | $1.1\mathrm e{-16}$ | $1.1\mathrm e{-16}$ | $5.6\mathrm e{-17}$ | $0.0$ |
| $\lvert K\mathbf1\rvert$ | $6.9\mathrm e{-17}$ | $3.5\mathrm e{-17}$ | $3.8\mathrm e{-17}$ | $5.6\mathrm e{-17}$ |

All four are exact identities, and each is two lines by hand rather than a measurement:

- $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=\tfrac12(W_{abab}+W_{baba})=K_{ab}$, and $M_{(ab),(ab)}=W_{abab}=K_{ab}$ by definition. The first diagonal is a **restatement of the definitions**; the content of the claim is that the *same* $K$ serves both sides.
- For $h=\operatorname{diag}(v)$, $(\mathring Wh)_{ii}=\sum_kW_{ikki}v_k=-\sum_kK_{ik}v_k$, so the $\psi$-block is $-K|_{\mathbf1^\perp}$ exactly.
- Hence $\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=t/2$ and $\sum d_\psi^2=\operatorname{tr}(K^2)=t$, giving $\sum d^2=\tfrac32t$.

**The over-statement.** "$K\mathbf1=0$, i.e. Ricci-flatness is exactly the vanishing of $K$'s row sums" holds only left-to-right in a single frame. $\operatorname{Ric}_{jj}=\sum_iK_{ij}$, so vanishing row sums give only $\operatorname{diag}(\operatorname{Ric})=0$. Witness at $n=6$: the Bianchi-projected $R=\frac1{n-2}(\operatorname{Ric}_0\wedge\delta)$ (Kulkarni–Nomizu) with $\operatorname{Ric}_0=E_{12}+E_{21}$ has $K\mathbf1=0$ to $0.0$ and $\operatorname{Ric}\ne0$ (off-diagonal entry $1.000000$). The frame-invariant version ($K(F)\mathbf1=0$ for **every** frame $F$ $\iff$ $\operatorname{Ric}=0$), is correct, and the same witness has $\max_F\lvert K(F)\mathbf1\rvert=0.78$ over $30$ rotated frames.

This is inert for the relaxation: $\{$hollow, symmetric, $K\mathbf1=0$, $\lVert K\rVert_F^2\le2\}$ is still **exactly** the set of realisable vertex matrices (see the witness under Claim 5), so the optimisation is over the right set. Only the sentence is wrong.

## Claim 2, CONFIRMED, and the iff is immediate

The forcing is verified at the sphere products: at $t=2$, $\lvert\operatorname{sort}(\omega)-\operatorname{sort}(d)\rvert\le2.2\times10^{-16}$ and $\lvert\operatorname{sort}(\mu)-\operatorname{sort}(d_\varphi)\rvert\le5.6\times10^{-17}$ at $n=6,8,12$. The mechanism is standard and worth stating so nobody re-measures it: $\omega\succ d$ with $\sum\omega=\sum d$ and $\sum\omega^2=\sum d^2$ forces $\omega$ to be a permutation of $d$, because $x\mapsto x^2$ is *strictly* convex and majorization gives $\sum f(\omega)\ge\sum f(d)$ for convex $f$ with equality only at a permutation.

**The iff direction the brief asked about is a one-liner, not a numerical question.** Since $\operatorname{diag}M=K$ over the $D=\binom n2$ coordinate $2$-planes,

$$\tfrac t2+\lVert M-\operatorname{diag}M\rVert_F^2=\lVert M\rVert_F^2=1 ,$$

verified to $5.6\times10^{-16}$ on $800$ random Weyl tensors at $n=5,\dots,8$. So $t\le2$ always, and $t=2$ **iff** every off-diagonal entry of $M$ vanishes, i.e. $W_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$, precisely Jäger's $\langle W\rangle_d$. Yes, $t=2$ forces coordinate-diagonality, and the record can state it as an identity instead of a computation.

## Claim 3, CONFIRMED, and it is a theorem, not 42 cells

The brief's own worry ("does $6$ random $K$ per cell, from one distribution, support 'all $42$ cells'"), dissolves, because the $\omega$ side is provable for **every** $K$ in the vertex class ([r103_claim3.py](../scripts/reviewers/r103/r103_claim3.py)).

**The proof.** The $\psi$-block of $d$ is $-\operatorname{spec}(K|_{\mathbf1^\perp})$: a zero-sum vector of length $n-1$ with sum of squares exactly $t$. A zero-sum vector of length $m$ with sum of squares $s^2$ has largest entry at least $s/\sqrt{m(m-1)}$ (the minimum is attained at one large negative entry and $m-1$ equal positives). Hence

$$\max d\ \ge\ \sqrt{\tfrac t{(n-1)(n-2)}} .$$

The $\omega$-side Okumura minimiser is $\omega^\star=(b,\dots,b,-(N-1)b)$ with $b=\sqrt{3/(N(N-1))}$, $N=\tfrac{n(n+1)}2-1$, so its largest partial sum at $j=1$ is $b$. Majorization already fails at $j=1$ whenever

$$t\ >\ \frac{3(n-1)(n-2)}{N(N-1)}\ =\ \frac{12(n-2)}{(n+2)(n^2+n-4)} .$$

| $n$ | $6$ | $8$ | $10$ | $12$ | $16$ | $20$ | $24$ |
|---|---|---|---|---|---|---|---|
| threshold on $t$ | $0.1579$ | $0.1059$ | $0.0755$ | $0.0564$ | $0.0348$ | $0.0236$ | $0.0170$ |

Every cell in the reported table ($t\in[0.5,2]$, $n=6,8,12$) is far above its threshold. So the Okumura extremiser is infeasible on the $\omega$ side for *all* vertex matrices, and since one side sufficing is enough, the joint relaxation is strictly below $4.0129$ at every $t$ above the threshold, with no sampling involved. Numeric confirmation of the inequality: over $3000$ random vertex $K$, $\max d\big/\sqrt{t/((n-1)(n-2))}$ never fell below $1.68$, $2.44$, $3.74$ at $n=6,8,12$.

**Two corrections to how Claim 3 is phrased.**

1. **The $\mu$ side is not infeasible everywhere.** Maximising the majorization slack *over* $K$ adversarially (Nelder–Mead, $25$ starts per cell) reaches slack exactly $0$ at $n=6$, $t=0.25$, the $\mu$-side Okumura extremiser **is** feasible there. The reported table starts at $t=0.5$, so there is no contradiction, but the $\mu$ side is fragile: its best slack is only $-0.041$ at $n=6,t=0.5$. The result rests on the $\omega$ side.
2. **"Slack $-0.4$ to $-4.6$" is a property of the sample, not a bound.** The adversarial maxima over $K$ range from $-0.041$ ($\mu$, $n=6$, $t=0.5$) to $-2.29$ ($\omega$, $n=12$, $t=2.0$). Quoting the random draws' slack invites the reader to think the margin is large; at the corner that matters it is $0.04$.

## Claim 4, REFUTED as maxima. All six entries beaten

Two independent routes, agreeing to the digit ([r103_claim4.py](../scripts/reviewers/r103/r103_claim4.py) joint SLSQP over $(K,\mu,\omega)$ with $150$ starts and the sphere-product $K$ among the seeds; [r103_headtohead.py](../scripts/reviewers/r103/r103_headtohead.py) with the outer search deleted entirely and $K$ fixed to $\sqrt{t/2}\,K_{S^3\times S^3}$).

| $t$ | Claim 4 | R103 joint | R103 single fixed $K$ | beaten by |
|---|---|---|---|---|
| $0.25$ | $3.586$ | $\mathbf{3.7278}$ | $3.7278$ | $+0.142$ |
| $0.5$ | $3.247$ | $\mathbf{3.5245}$ | $3.5245$ | $+0.278$ |
| $1.0$ | $2.519$ | $\mathbf{2.8097}$ | $2.8097$ | $+0.291$ |
| $1.5$ | $1.660$ | $\mathbf{1.9385}$ | $1.9385$ | $+0.279$ |
| $1.9$ | $-0.144$ | $\mathbf{1.2230}$ | $1.2230$ | $+1.367$ |
| $2.0$ | $-0.146$ | $\mathbf{1.054093}$ | $1.054093$ | $+1.200$ |

Feasibility of my points: equality residual $\le4.6\times10^{-11}$, inequality slack $\ge-1.5\times10^{-8}$. Two anchors fall out exactly and confirm the machinery: $R(2)=1.054093=\theta_0(6)$ to $10^{-15}$, and $R(0.05)=R(0.1)=3.744641$, the **unconstrained** Okumura value, matching the analytic threshold $t^\ast=0.1579$ below which both extremisers are feasible at $n=6$.

**The under-exploration is everywhere, not only at $t\ge1.9$.** The record quarantined the last two entries; in fact the first four are low by $4$–$11\%$ as well. And the beating witness needs *no outer search*: the maximiser at every $t$ is simply the scaled balanced-sphere-product vertex matrix. The weak part of the reported computation was the max over $K$, and four random draws never found the one structured $K$ that matters.

**The monotonicity gate is not a validity gate, for two independent reasons.**

- **Monotonicity is a theorem, so the gate carries no information.** The vertex class is a *linear space*, so $K=\sqrt{t/2}\,\hat K$ with $\lVert\hat K\rVert_F^2=2$. For $c\le1$ and any zero-sum $v$, $\sum_{k\le j}(cv)^\downarrow_k=c\sum_{k\le j}v^\downarrow_k\le\sum_{k\le j}v^\downarrow_k$ because partial sums of a sorted zero-sum vector are non-negative. So $\{x:x\succ v\}\subseteq\{x:x\succ cv\}$: the feasible set *grows* as $t$ shrinks, and $R$ is non-increasing for free. A sweep can only fail the gate through solver error; passing it says nothing.
- **The gate is one-sided in exactly the wrong direction.** Under-exploration returns spuriously *low* values, which monotonicity tolerates. The published sweep passed the gate while carrying two entries the author already knew were wrong by $1.2$–$1.4$, and four more wrong by $0.14$–$0.29$ that nobody flagged.

**$n=12$ was never run.** My fixed-$K$ lower bounds there ([r103_headtohead.py](../scripts/reviewers/r103/r103_headtohead.py)):

| $t$ | $0.25$ | $0.5$ | $1.0$ | $1.5$ | $1.9$ | $2.0$ |
|---|---|---|---|---|---|---|
| $F(\sqrt{t/2}K_{S^6\times S^6})$ | $3.8319$ | $3.4796$ | $2.6907$ | $1.9109$ | $1.3535$ | $1.2360$ |
| $/\theta_0(12)$ | $3.100$ | $2.815$ | $2.177$ | $1.546$ | $1.095$ | $1.000$ |

## Claim 5, conclusion right, reasons wrong, scope too wide

### The conclusion holds, and needs neither Claim 3 nor Claim 4

Three lines, no numerics:

1. $R(t)$ is **non-increasing** in $t$, proved above, from the vertex class being a linear space.
2. $R(2)$ is the **exact** maximum of $\theta$ over coordinate-diagonal $W$ (Claim 2's forcing), which is $\theta_0(n)$ by Jäger.
3. Therefore $R(t)\ge\theta_0(n)$ for every $t\le2$, and $t=2$ iff $W$ is coordinate-diagonal (Claim 2's iff).

So the relaxation certifies $\theta\le\theta_0$ on the granted locus and on nothing else. The $42$-cell table and the $n=6$ sweep are **inert** for this conclusion, both are consistent with it, neither is needed, and Claim 4's numbers are wrong anyway.

### "The maximum over $t$ sits at $t\to0$" is the wrong quantity, and the right one is stronger

Sweeping $t$ and taking the max is a legitimate way to reach a $t$-free bound, so the sweep is not meaningless. But the headline is a triviality: at $t=0$ we have $K=0$, and every zero-sum vector majorizes the zero vector, so $R(0)$ *is* the unconstrained Okumura value by definition. The informative statement is the opposite end ($R(t)>\theta_0(n)$ for **every** $t<2$) which is what monotonicity gives and what the witness below exhibits.

**And $t$ can be tied to a single $W$, which removes the sweep from the refutation entirely** ([r103_claim5.py](../scripts/reviewers/r103/r103_claim5.py)). Take $W'$, a unit Weyl tensor whose vertex matrix vanishes identically, found in the null space of the vertex map over a spanning sample, $\max\lvert K(W')\rvert\le8.5\times10^{-17}$ at $n=6,8,12$. Then

$$W_c\ =\ c\,W_{S^{m}\times S^{m}}+\sqrt{1-c^2}\,W'$$

is a genuine unit-norm algebraic Weyl tensor with $K(W_c)=c\,K_{S^m\times S^m}$ exactly (residual $\le5.6\times10^{-17}$, $\lVert M\rVert=1$ to $10^{-15}$). At $n=6$, $c=0.95$: $\theta(W_c)=0.90995$, $t=1.805$, $\kappa^2(W_c)=1.8688$ by frame ascent, and the relaxation evaluated **at that tensor's own best frame** returns $1.2306>\theta_0(6)=1.054093$. One tensor, its own $t$, no sweep. This also settles the realisability question left open under Claim 1: the vertex class with $t\le2$ is exactly attained.

### "Tight only at $t\to2$" is right, and the tightness has a measurable modulus that nobody has claimed

The granted diagonal case covers **only the point** $t=2$ (Jäger's theorem is a statement about $W\in\langle W\rangle_d$) and by monotonicity no value below $\theta_0$ is available at any $t<2$. But the degradation is **linear**, not square-root: at $n=12$, $F(c\,K_{S^6\times S^6})-\theta_0$ is $0.0042$, $0.0445$, $0.2405$ at $2-t=0.0040$, $0.0398$, $0.1950$, slope $1.05$ to $1.23$. So the route does produce one positive statement, and it is not in the record:

$$\theta(W)\ \le\ \theta_0(n)+O\!\big(2-\kappa^2(W)\big),$$

with an $O(1)$ constant, strictly better than the unconstrained $4.0129$ in a band below $t=2$. That is more than Jäger gives, it is a stability statement rather than a bound, and it closes nothing. Recording it stops the next cycle from re-deriving it.

### Two corrections to the evidence base, one of them serious

**Every number in Claim 4 is at $n=6$, where Conjecture A is false.** The zero-padded $W_{\mathbb{CP}^2}$ is a genuine algebraic Weyl tensor at every $n$ (Weyl residual $0.0$ in my implementation) with $\theta=\sqrt{3/2}=1.224745$ and $t=1.0000$ exactly. That exceeds $\theta_0(6)=1.054093$, $\theta_0(8)=1.145644$ and $\theta_0(10)=1.200000$. So at $n=6,8,10$ **no correct upper bound can be $\le\theta_0(n)$**, and the "$/\theta_0(6)$" column measures the relaxation against a target unattainable by construction. Read honestly, the looseness at $n=6$, $t=1.0$ is at most $2.8097/1.224745=2.29$ against the true maximum, not $2.39$ against a false threshold, and the "$3.4\times$ at $t=0.25$" headline is a number about the wrong dimension. The conclusion survives (it is analytic, and I checked $n=12$ separately), but the evidence offered does not carry it.

**"The case Jäger's theorem already grants" is granted only for even $n\ge16$.** Per [findings/problem.md](../findings/problem.md), Theorem A requires $n\ge16$ even, and $n=12,14$ are open *in the diagonal case*. So at exactly the dimensions where the conjecture first bites, $R(2)$ is not known to equal $\theta_0$ either. The sharper statement is that the relaxation **reduces exactly to the open diagonal problem** at $t=2$, and is strictly weaker everywhere else.

### The scope correction: what the negative does and does not close

The mechanism is not about Schur–Horn or Okumura at all. It is:

> Any bound that is (i) exact at $t=2$ and (ii) monotone in the amount of diagonal information is $\ge\theta_0$ at every $t<2$.

That is worth a fence post in its own right, because it retires a whole family in one line and is reusable. What it leaves open, and what "the route is circular" wrongly forecloses:

- **Several frames at once, as the brief suspects.** The single-frame relaxation consumes one $K$. Since $K(F)_{ab}=W(Fe_a,Fe_b,Fe_a,Fe_b)$ is the sectional-curvature function of $W$ on $2$-planes, and a curvature tensor obeying the first Bianchi identity is determined by its sectional curvatures, the family $\{K(F)\}_F$ determines $W$ outright. The multi-frame constraint system is therefore not a relaxation with fixed looseness, in the limit it is the original problem. One frame's worth of Schur–Horn is closed; any finitely-many-frames or averaged version is untouched. (The cheap multi-frame move (taking the *minimum over frames* of the single-frame bound), does **not** help: over $40$ frames of the $c=0.95$ witness the minimum is $1.3900$, attained at the identity frame, and the $\kappa$-maximising frame gives $1.2306$; both exceed $\theta_0(6)=1.054093$, and $\theta(W)$ itself is $0.90995$. See [r103_frames.py](../scripts/reviewers/r103/r103_frames.py).)
- **Any use of $K$ that is not monotone under scaling.** The obstruction above bites only on functionals inheriting monotonicity from the majorization constraint.
- **The stability statement** $\theta\le\theta_0+O(2-\kappa^2)$, which is the route's one piece of positive output.

One quantitative note against "$t$ can be pushed to $0$": the relaxation is never *literally* vacuous for a real tensor. $\mathbb E_F\lVert K(F)\rVert_F^2=12/((n+1)(n+2))$, confirmed numerically at $n=5,6,7,8$ ($0.281/0.219/0.168/0.132$ against $0.286/0.214/0.167/0.133$), so $\kappa^2\ge12/((n+1)(n+2))$, which is $0.2143$ at $n=6$ and $0.0659$ at $n=12$, in both cases above the $\omega$-side threshold $t^\ast$ of $0.1579$ and $0.0564$. Narrowly, but the Okumura extremiser is always infeasible for a real Weyl tensor.

## Summary for the record

- Claims 1 and 2 are right and should be restated as identities with two-line proofs rather than measurements; the sentence "Ricci-flatness is exactly the vanishing of $K$'s row sums" needs "in every frame" or it is false.
- Claim 3 is right and should be replaced by the threshold $t>12(n-2)/((n+2)(n^2+n-4))$, which makes the sample-size question moot. The $\mu$ side is not part of the result.
- Claim 4's six numbers are all too low and should be replaced; the monotonicity gate should be demoted from "validity gate" to what it is, a check that cannot detect the failure mode it was aimed at.
- Claim 5's conclusion stands, on a three-line argument, and should be recorded with the scope correction and the stability statement, not as "Schur–Horn is circular", but as "monotone plus exact at the granted end implies useless off it, and one frame is not enough frames".
