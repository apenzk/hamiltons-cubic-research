# Reviewer 335, Lemma L73 on all of $\mathcal W_n$, the T10 closure, T9's overshoot, the Jacobi fence, and the per-row family

**Cold brief, own implementation.** Everything below is built from the definitions alone, $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $\varphi_{ij}=E_{ij}-E_{ji}$ orthonormal under $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$, $(A\#B)_{ab}=\tfrac12\sum c_{acd}c_{bef}A_{ce}B_{df}$, $Q(W)=W^2+W^\#$, and $\mathcal W_n$ obtained as the nullspace of first Bianchi together with $\operatorname{Ric}=0$ inside $\operatorname{Sym}^2(\Lambda^2)$. The build validates on three independent checks before any claim is tested: $\dim\mathcal W_n=84,168$ at $n=6,7$; $I\#I=(n-2)I$ to $0$ exactly; $\theta_0(6)=1.054092553$ at $S^3\times S^3$ and $\sqrt{3/2}=1.224745$ at padded $W_{\mathbb{CP}^2}$. Code in [scripts/reviewers/r335/](../scripts/reviewers/r335/), log at [agent_logs/r335-lemma73.log](../agent_logs/r335-lemma73.log).

**Compute status.** The analysis-only order reached me mid-audit. Every screen below was already complete when it arrived; each is labelled a screen, and no verdict rests on a screen alone where an argument was available. The one place where the evidence is screened rather than proved (that $n-2$ is *attained* on all of $\mathcal W_n$), is flagged as such, with what a proof would need.

| claim | verdict |
| --- | --- |
| **S1**, Lemma L73's derivation, normalisation, symmetrisation | **CONFIRMED**, line by line |
| **S1**, it needs no criticality | **CONFIRMED, and the reason is stronger than the record's**: (A) needs neither Weyl nor criticality, it is the Killing form in *any* orthonormal basis of $\mathfrak{so}(n)$, and (B) is Weyl-only. Nothing in the derivation reintroduces criticality |
| **S1** (not implied by tracelessness | **CONFIRMED**), $N-1>n-2$ for every $n\ge3$, and the gap is quadratic |
| **S1** (saturated at $\mathbb{CP}^m$ for every $m$ | **CONFIRMED**), ratio exactly $n-2$ at $m=2,3,4,5$, at genuine critical points |
| **S1** (saturated "at every maximal torus" | **REFUTED AS STATED**), true for **even** $n$ only. At odd $n=5,7,9$ the torus Casimir $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ is **not a Weyl tensor** (relative distance $0.41,0.26,0.19$), and its Weyl part is the padded even-$n$ torus with ratio $n-3$, strictly slack |
| **S1** ("slack at every sphere product, so it cuts away from the extremum" | **REFUTED**), $S^2\times S^{n-2}$ **saturates exactly**, ratio $=n-2$ at $n=5,6,8,10,12$. The correct statement is *slack at every sphere product with both factors of dimension $\ge3$* |
| **S1** (the constant $n-2$ cannot be improved | **CONFIRMED, and now also on $\mathcal W_n$**), screened maximum of $\lambda_{\max}/\lvert\lambda_{\min}\rvert$ over all of $\mathcal W_n$ is exactly $n-2$ at $n=5$ (attained at $S^2\times S^3$) and $n=6$ (attained at the maximal torus) |
| **S2** (the T10 closure's two data points | **CONFIRMED, reproduced exactly**), own Newton, own LP: $\theta=0.054718$, $10$ distinct eigenvalues, LP $\max=0.284314$, gap $0.229596$ |
| **S2** (the residue (two gaps agreeing to three digits) | **Coincidence**), my own eight generic points give gaps $0.160,0.230,0.286,0.289,0.296,0.321,0.375,0.423$. Also: the $\theta=0.054718$ point was hit twice from unrelated seeds, so "unrelated points" overstates the independence of the record's sample |
| **S3**, T9's $\max\theta=1.340542$ at $n=6$ | **REFUTED AS STATED**, my own outer search reached **$1.392879$ in eight restarts and was still climbing**. The record's figure is an under-converged *lower* bound, and should be recorded as $\ge$. The conclusion it supports is strengthened, not weakened |
| **S3** (outcome (iv), a realizable overshooting spectrum as a counterexample | **REFUTED AS A DESIGN**), unreachable at $n=6$ for two independent reasons, neither numerical. The realization attempt was cut by the compute order; what it could have returned would not have been a counterexample either |
| **S4** ("no route may propose to reach Jacobi through $T$" | **REFUTED AS STATED, with a repair**), the $\mu_7/\mu_8$ witness proves the wrong thing, and in this record's own setting the algebra is *fixed*, so Jacobi is not the missing constraint at all |
| **S5** (the per-row family from (C) | **CONFIRMED as algebra**), case split right, range right |
| **S5** ("Lemma L70 is the $\lambda_{\min}$ member" | **REFUTED AS STATED**), Lemma L70 is that member *weakened* by dropping the exclusion $b,c\ne a$; the two agree exactly when $\operatorname{mult}(\lambda_{\min})\ge2$ and the row bound is strictly stronger when $\lambda_{\min}$ is simple |
| **S5**, the padded $W_{\mathbb{CP}^2}$ figures $2.041241 / 4.490731 / 2.857738$ | **REFUTED**, the three numbers are mixed across $n$. My values: at $n=6$, row-min $1.632993$, Lemma L70 $2.857738$, $\Pi$-bound $2.041241$; at $n=12$, row-min $2.857738$, Lemma L70 $7.756718$, $\Pi$-bound $4.490731$ |
| **S5** ("coinciding with both at the balanced products and at the tori" | **Half REFUTED**), true at the balanced product, false at the maximal torus, where the $\Pi$-bound is *exact* ($0.645497$) and the row family's minimum is $1.936492$ |

---

## 1. Conventions and the validated build

$W\in\mathcal W_n$ of unit Frobenius norm on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=n(n-1)/2$, eigenbasis $v_1,\dots,v_N$, eigenvalues $\lambda_a$, $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric, $T_{abc}=c_{abc}^2$ totally symmetric and **zero whenever two indices coincide**. Sums $\sum_{b,c}$ run over ordered pairs. Tracelessness holds because $\operatorname{tr}_{\Lambda^2}W=\tfrac12\operatorname{scal}=0$, so $\lambda_{\min}<0<\lambda_{\max}$ for $W\ne0$.

Three build checks, run before anything was audited: $\dim\mathcal W_6=84$ and $\dim\mathcal W_7=168$ against $n(n+1)(n+2)(n-3)/12$; $I\#I-(n-2)I=0$ to machine zero; $\sum_{b,c}T_{abc}=2(n-2)$ on the nose. The catalogue then reproduces the record's own anchors: $\theta_0(6)=1.054092553$ at $S^3\times S^3$, $\sqrt{3/2}=1.224745$ at $W_{\mathbb{CP}^2}$ padded to $n=6$ and to $n=12$, and $\theta=0.645497$ at the $n=6$ maximal torus, every one at criticality residual $\le5\times10^{-15}$.

---

## 2. S1, Lemma L73

### 2.1 The derivation is correct, and the normalisation and symmetrisation are correct

Row $a$ of (A) is $\sum_{b,c}T_{abc}=2(n-2)$, so $\mu_a:=T_{a\bullet\bullet}/2(n-2)$ is a probability measure on ordered pairs. Row $a$ of (B) is $\sum_{b,c}\lambda_bT_{abc}=-2\lambda_a$, so $\mathbb E_{\mu_a}[\lambda_b]=-\lambda_a/(n-2)$. Total symmetry of $T$ in $(b,c)$ makes $\mathbb E[\lambda_b]=\mathbb E[\lambda_c]=\mathbb E[(\lambda_b+\lambda_c)/2]$, so the symmetrisation is free and correct. Since $\lambda_b\in[\lambda_{\min},\lambda_{\max}]$ pointwise,

$$\lambda_{\min}\;\le\;\frac{-\lambda_a}{n-2}\;\le\;\lambda_{\max}\qquad\text{for every }a,$$

and multiplying through by $-(n-2)<0$ gives the recorded $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$. At $a=\arg\max$ the left inequality is $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$; at $a=\arg\min$ the right one is $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$. **CONFIRMED.**

Two remarks on the statement rather than the proof. First, the "for every $a$" form carries nothing beyond the two extreme rows, since $\lvert\lambda_a\rvert\le\max(\lambda_{\max},\lvert\lambda_{\min}\rvert)$ makes every intermediate row implied. Second, the mirror inequality needs no separate argument: $\mathcal W_n$ is a linear subspace, so $W\mapsto-W$ maps it to itself and exchanges the two inequalities (and maps a critical point with constant $\theta$ to one with $-\theta$). Any saturating example for one gives one for the other by a sign flip, and the record's two-family sharpness argument is doing the mirror twice over.

### 2.2 Criticality is not used, and (A) is even freer than the record now says

The strengthened statement survives the attack. **(A) requires neither criticality nor the Weyl condition, nor even a $W$.** It is $\sum_{b,c}c_{abc}^2=-B(v_a,v_a)=2(n-2)\lVert v_a\rVert^2$, the Killing form of $\mathfrak{so}(n)$ evaluated on a unit vector, so it holds in *any* orthonormal basis. Screened in a random $SO(15)$-rotated basis of $\mathfrak{so}(6)$: row masses $8.000000$ across the board, with $T$ vanishing on repeated indices to $4\times10^{-32}$. So $\mu_a$ is a probability measure with no input whatever, which answers the first sub-question outright.

**(B) is where the hypotheses live, and both of them are genuinely consumed.** $W\#I=-W$ is [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 with the Ricci and scalar pieces killed. Screened at random Weyl tensors: $\max\lvert W\#I+W\rvert$ is $4.2\times10^{-16}$, $4.4\times10^{-16}$, $6.5\times10^{-16}$ at $n=5,6,7$, at points whose criticality residual is order $1$. Two controls show the hypotheses are not decoration: at random *algebraic curvature operators* (first Bianchi, $\operatorname{Ric}\ne0$, the $105$-dimensional space at $n=6$) the error is $0.20$ to $0.28$, and at random symmetric traceless operators it is $0.13$ to $0.22$. So the derivation uses first Bianchi and Ricci-flatness and nothing else, and **the strengthening to all of $\mathcal W_n$ is correct.**

### 2.3 It is not implied by tracelessness

Tracelessness alone gives $\lambda_{\max}=-\sum_{a\ne\arg\max}\lambda_a\le(N-1)\lvert\lambda_{\min}\rvert$, and $N-1>n-2\iff n(n-1)/2-1>n-2\iff(n-1)(n-2)>0$, which holds for every $n\ge3$. The gap $N-1-(n-2)=\tfrac12(n-2)(n-3)$ grows quadratically, so the two conditions are far apart at every dimension the programme cares about. **CONFIRMED**, and the record's phrasing is exactly right.

### 2.4 Sharpness, one family confirmed, one over-claimed, one refuted

**$\mathbb{CP}^m$: CONFIRMED.** Built independently from the Fubini–Study tensor $R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$ (first Bianchi residual exactly $0$), projected onto $\mathcal W_n$ and normalised:

| $m$ | $n$ | $\lambda_{\max}$ | $\lambda_{\min}$ | ratio | $n-2$ | criticality residual |
|---|---|---|---|---|---|---|
| $2$ | $4$ | $0.816497$ | $-0.408248$ | $2.000000$ | $2$ | $2.1\times10^{-15}$ |
| $3$ | $6$ | $0.843274$ | $-0.210819$ | $4.000000$ | $4$ | $2.0\times10^{-15}$ |
| $4$ | $8$ | $0.845154$ | $-0.140859$ | $6.000000$ | $6$ | $2.8\times10^{-15}$ |
| $5$ | $10$ | $0.843274$ | $-0.105409$ | $8.000000$ | $8$ | $3.4\times10^{-15}$ |

**The maximal tori: REFUTED AS STATED, the family is the even-$n$ one only.** For even $n$ the torus Casimir $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ with $r=n/2$ lies in $\mathcal W_n$ (relative distance $\le2.6\times10^{-15}$ at $n=6,8,10$) and saturates, and the saturation is arithmetic rather than delicate: its spectrum is $1-r/N$ with multiplicity $r$ and $-r/N$ with multiplicity $N-r$, so the ratio is $(N-r)/r=2m-2=n-2$ at $n=2m$. **For odd $n$ the same construction leaves $\mathcal W_n$**, relative distance $0.408$, $0.258$, $0.189$ at $n=5,7,9$, and its Weyl part is the padded even-$n$ torus, ratio $n-3$, strictly slack. So "at every maximal torus" should read "at every maximal torus in even $n$", and the equality reading $[\mathfrak h,\mathfrak h]=0$ is a check on the even case only.

That mattered, because with $\mathbb{CP}^m$ also needing $n$ even, the record's two cited families left **odd $n$ with no witness at all**. It has one, see §2.5.

**"Slack at every sphere product": REFUTED.** Building $S^p\times S^{n-p}$ as $\Pi_{\Lambda^2V_p}+\Pi_{\Lambda^2V_{n-p}}$ projected onto $\mathcal W_n$ (criticality residual $\le5.7\times10^{-15}$ throughout):

| $n$ | $S^2\times S^{n-2}$ | $S^3\times S^{n-3}$ | $S^4\times S^{n-4}$ | $S^5\times S^{n-5}$ | balanced | $n-2$ |
|---|---|---|---|---|---|---|
| $6$ | $4.000000$ | (|), |, | $1.500000$ | $4$ |
| $8$ | $6.000000$ | $2.500000$ | (|), | $1.333333$ | $6$ |
| $10$ | $8.000000$ | $3.500000$ | $2.000000$ |, | $1.250000$ | $8$ |
| $12$ | $10.000000$ | $4.500000$ | $2.666667$ | $1.750000$ | $1.200000$ | $10$ |

The $S^2\times S^{n-2}$ column is $n-2$ exactly, at every $n$ tested. So the sentence "**it is slack at every sphere product**, so it cuts *away* from the extremum" is false as written; the true statement is that it is slack at every sphere product with **both factors of dimension $\ge3$**, which is what the record actually wants, since $S^2\times S^{n-2}$ is not a candidate maximiser. The correction is small in consequence and large in kind: a sharpness claim quantified over a family was checked on the balanced member only.

### 2.5 The constant is unimprovable on all of $\mathcal W_n$, and the extremisers are critical, screened

Maximising $\lambda_{\max}/\lvert\lambda_{\min}\rvert$ over $\mathcal W_n$ by the natural convex-maximisation iteration (linearise $\lambda_{\max}$ at the current top eigenvector, maximise the resulting linear functional over $\{W\in\mathcal W_n:W\succeq-I\}$ by SDP, repeat; ten restarts each) returns **exactly $n-2$**:

- $n=5$: maximum $3.000000$, attained at spectrum $\{0.70711,\,0.2357^{\times3},\,-0.2357^{\times6}\}$, criticality residual $0$, which is the Weyl tensor of $\mathbf{S^2\times S^3}$, and so supplies the odd-$n$ witness the two recorded families could not.
- $n=6$: maximum $4.000000$, attained at spectrum $\{0.516398^{\times3},\,-0.129099^{\times12}\}$, criticality residual $0$, the maximal torus.

Three things follow. **The constant is unimprovable off the critical set too**, which is what the strengthening needed. **The extremisers are nevertheless critical points**, so the strengthened lemma has exactly the same equality set as the critical version; the strengthening buys provenance and a development path, not a new tight case. And on the coordinator's nonvacuity question: at random Weyl tensors of $\mathcal W_6$ the ratio has median $0.998$, $99$th percentile $1.344$ and sample maximum $1.511$ against a bound of $4$, so **the condition never binds at a generic Weyl tensor**, but it does not bind at a generic critical point either (§3 gives ratios $1.08$ to $1.16$ there), so this is not a defect introduced by dropping criticality. The honest reading is that Lemma L73 is an *extremal* condition on both sets, and the record's "matters for I24 rather than being a technicality" is defensible only in the sense that the (A)+(B) row family can now be developed without carrying the critical equation, which is a real convenience and not a new bite.

**What an analytical proof of attainment would need**, since the above is a screen: exhibit for each $n$ a $W\in\mathcal W_n$ whose $\mu_{\arg\max}$ is supported on pairs $(b,c)$ with $\lambda_b=\lambda_c=\lambda_{\min}$. That is exactly the condition $[E_{\max},E_{\max}]=0$ together with $[E_{\max},\cdot]\subseteq E_{\min}$ that the record already reads off, and $S^2\times S^{n-2}$ satisfies it for every $n$ by inspection: $E_{\max}=\Lambda^2V_2$ is one-dimensional hence abelian, and $[\Lambda^2V_2,\Lambda^2V_2\oplus\Lambda^2V_{n-2}]=0$ with $[\Lambda^2V_2,V_2\otimes V_{n-2}]\subseteq V_2\otimes V_{n-2}$, the mixed block being $E_{\min}$. **So a proof for every $n$, even and odd, is available from the $S^2\times S^{n-2}$ family alone and does not need the screen**, and it is a better witness than either recorded family, being one family rather than two and covering odd $n$.

### 2.6 A strengthening the record leaves on the table

$T$ vanishes on repeated indices, so $\mu_a$ is supported on pairs with $b\ne c$ and both $\ne a$. Writing $\lambda_{(1)}\le\lambda_{(2)}$ for the two smallest eigenvalues among indices $\ne a$, the symmetrised expectation obeys $\mathbb E_{\mu_a}[(\lambda_b+\lambda_c)/2]\ge\tfrac12(\lambda_{(1)}+\lambda_{(2)})$, giving at $a=\arg\max$

$$\lambda_{\max}\;\le\;-\frac{n-2}{2}\big(\lambda_{(1)}+\lambda_{(2)}\big),$$

strictly stronger than Lemma L73 whenever $\lambda_{\min}$ is simple, and identical to it whenever $\operatorname{mult}(\lambda_{\min})\ge2$. Every saturating example above has $\operatorname{mult}(\lambda_{\min})\ge2$, so **the strengthened form is still sharp**, screened slack $0.000000$ at $\mathbb{CP}^m$ for $m=2,3,4,5$ and at the even-$n$ tori. The record symmetrises and then throws the symmetrisation away by bounding both halves at $\lambda_{\min}$; keeping it costs nothing.

---

## 3. S2, the T10 closure

**Reproduced exactly, by a route sharing nothing with the record's.** Critical points found by Newton on $\Pi_{x^\perp}\big(\nabla P-\theta W\big)=0$ on the unit sphere of $\mathcal W_6$ from random seeds; the LP built independently from the ordered-pair identities, $\binom{15}{3}=455$ variables plus $\theta$, $45$ equality rows, HiGHS. Two anchors first: at the balanced $S^3\times S^3$ spectrum the LP returns $1.0540925533894583$ against $\theta_0(6)=1.0540925533894598$, and at the $n=6$ maximal torus it returns $0.6454972243679011$ against the true $\theta=0.645497224367903$, the fixed-spectrum exactness at catalogued spectra, independently confirmed.

Then the closure's own point. One of my Newton solutions has $\theta=0.054718$, $10$ distinct eigenvalues, LP maximum $0.284314$ and gap $0.229596$, **the record's first generic point to six digits**, from an independent solver, an independent basis and an independent LP. The T10 closure's data is real.

**Attacking the closure.** Eight generic critical points give gaps

$$0.160214,\quad 0.229596,\quad 0.286222,\quad 0.288945,\quad 0.295476,\quad 0.320538,\quad 0.375345,\quad 0.423270,$$

spread over a factor of $2.6$. **The residue is a coincidence**, which agrees with the partner reviewer's independent finding, reached from a different sample. One point of caution the record should carry forward: the $\theta=0.054718$ point came up **twice from unrelated seeds** in my forty attempts, so random Newton in $\mathcal W_6$ has strong attractors and "two unrelated points" overstates the independence of a two-point sample. The closure is right; the sample that closed it was thinner than it looked.

**Is the sharpness confined to degenerate spectra?** The evidence says the split is degenerate-versus-generic rather than symmetric-versus-not: every generic point I found has all $15$ or $10$–$11$ distinct eigenvalues and a gap of order $0.2$–$0.4$, while every catalogued spectrum tested is exact. I have no identifiable larger class, and one observation worth a line rather than a claim: at the two points where I also computed the LP *minimum*, the true $\theta$ sits at fraction $0.2727$ and $0.2709$ of the feasible interval. Two points is exactly the sample size that produced the residue the record is now discarding, so I record it as a curiosity and nothing more.

One further correction the run produced. At generic critical points the full LP is far stronger than any single-row bound: at $\theta=0.054718$ the LP gives $0.284314$ where Lemma L70 gives $1.041826$, the $\Pi$-bound $1.472778$ and the per-row family $1.041826$. So the hypothesis that the LP maximum *is* Lemma L70's cap (true at the balanced spectrum by the recorded ablation), **fails off the catalogue by a factor of nearly four**, and the ablation must not be quoted as a general description of what the LP is doing.

---

## 4. S3, T9, the overshoot and the realization attempt

**The number is under-converged, and the record should say $\ge$.** My own outer search, Nelder–Mead over trace-free unit spectra in $\mathbb R^{15}$, exact inner LP over $T\ge0$ with all three relations, reached **$1.392879$** within eight restarts and was still improving ($1.360865\to1.392879$). The record's $1.340542$ is a lower bound on a supremum, not the supremum, exactly as the record itself flagged for the superseded $1.590427$ run and then did not flag here. The direction of the error is harmless: it makes the overshoot larger, so **"the pinned class does not close the conjecture" is strengthened**. Sanity check at the returned spectrum: dropping (B) raises the value to $1.396990$, dropping (C) makes the system infeasible, both the right way round.

The near-optimal spectra are the same shape at both restarts: four eigenvalues near $-0.3$, three near $+0.45$, and eight clustered within $10^{-2}$ of zero. That an optimiser drives eight of fifteen eigenvalues to a near-kernel is the informative part, and it is what a realization attempt would have to confront.

**On the realization attempt, and why the outcome taxonomy cannot get what it wants at $n=6$.** The attempt was cut by the analysis-only order before it ran; the route prepared was alternating projection between $\mathcal W_6$ and the isospectral orbit, with the dimension count $\dim\mathcal W_6+\dim\mathcal O_\lambda=84+105=189$ against an ambient $120$ suggesting the intersection is generically nonempty. I report it as not attempted. But two analytical points make the attempt's outcome unable to deliver what outcome (iv) promises, and both are worth more than the run would have been.

- **At $n=6$ a spectrum overshooting $\theta_0(6)$ is not a counterexample to anything.** Conjecture A is asserted for even $n\ge12$, and at $n=6$ the true maximum $\sqrt{3/2}=1.224745$ already exceeds $\theta_0(6)=1.054093$, the record's own padded $W_{\mathbb{CP}^2}$, which I reproduce at criticality residual $2.1\times10^{-15}$. So outcome (iv) is *already realised* at $n=6$ by a point the record has held for months, and realising it again at a new spectrum would add nothing. The taxonomy's fourth cell is well posed only at $n\ge12$.
- **Realizability of the spectrum is not the property outcome (iv) needs.** LP feasibility produces *some* nonnegative $T$ satisfying (A), (B), (C) at that spectrum. Realising the spectrum in $\mathcal W_n$ produces a Weyl tensor $W$ whose *own* $T$ need not satisfy (C), (C) is criticality, and a Weyl tensor with a prescribed spectrum is not a critical point. A counterexample needs a critical $W$ with $\theta>\theta_0(n)$, which is strictly more than "the spectrum is realizable". So outcome (iv) as written conflates two conditions, and no realization run of the kind the record asks for could have decided it.

The repair is one sentence: **outcome (iv) should read "feasible above $\theta_0$ at a spectrum realized by an actual critical point", and the run that would test it must be at $n\ge12$.** Reviewer 334 caught the missing cell; the cell as added is still not testable by the run it was added to.

---

## 5. S4, the Jacobi fence

Read against [the Payne notes](../references/payne-2010-soliton-metrics/notes.md), the fence is **stated at the wrong strength and rests on a witness that proves something else.**

**The witness proves non-injectivity, not non-determination.** $\mu_7$ and $\mu_8$ are *both* Lie algebras (both satisfy Jacobi), with the same structure vector. That shows $[\alpha^2]\mapsto\mu$ is not injective, so no function of $T$ recovers the *algebra*. It does not show that the *predicate* "some signing of this $[\alpha^2]$ satisfies Jacobi" fails to be a function of $T$; that predicate is a function of $T$ by construction, and both $\mu_7$ and $\mu_8$ lie in its "yes" set. The notes' own step 3 makes this inference ("$T$ does not determine the algebra, so no function of $T$ can be equivalent to Jacobi") and it is a non sequitur. A witness for the intended claim would be two $\mu$'s with the *same* $[\alpha^2]$, one a Lie algebra and one not; Payne's sign discussion says such things exist in principle, but $\mu_7/\mu_8$ is not one of them.

**What the notes actually establish, and it is enough for a fence with the wording changed.** Realizability *is* a condition on $T$ (Payne's Theorems 3 and 13 describe it exactly) but it is (i) **support-dependent before it is value-dependent**, since Corollary 14 gives supports on which Jacobi is automatic and therefore constrains no value of $T$, and (ii) where it does bite, it is Equation (8), a *signed* sum whose elimination over signs is $\prod_{\varepsilon}(\sum_i\varepsilon_ix_i)=0$, a union of hyperplane pieces of degree $2^{m-1}$, not a linear relation. So the defensible fence is:

> **No route may add a Jacobi-derived *linear row* to the pinned system**, because Jacobi's shadow on $T$ is a support-dependent union of pieces rather than an equation on values.

That is strictly weaker than "not expressible in $T$ at all", and it is the version the evidence carries.

**And there is a bigger problem with importing Payne here at all.** In Payne's setting the Lie algebra varies, that is the moduli problem, and Jacobi is the constraint that says a candidate $\mu$ is an algebra. **In this record's setting the algebra is fixed: it is always $\mathfrak{so}(n)$, and the variable is the orthonormal basis** (the eigenbasis of $W$). Jacobi is therefore satisfied automatically and is not a constraint to be imposed at all. The record's missing constraint is much stronger than Jacobi: $T$ must be the squared structure tensor of **one specific semisimple algebra in an orthonormal frame**, i.e. $T$ must lie in the image of the $O(N)$-orbit of a single fixed 3-tensor. Calling that gap "Jacobi" understates it and points successors at the wrong object. The fence as written would also, read literally, forbid the correct route, an argument that constrains $T$ by the $\mathfrak{so}(n)$-orbit condition is not a route "through Jacobi", but a reader would not know that from the sentence.

---

## 6. S5, the per-row bound family

**The case split is right.** Row $a$ of (C) gives $m_a\le\lambda_a(\theta-\lambda_a)/(n-2)\le M_a$. For $\lambda_a>0$, the upper half divides directly to $\theta\le\lambda_a+(n-2)M_a/\lambda_a$. For $\lambda_a<0$, it is the *lower* half that is used and division by $\lambda_a<0$ flips it to $\theta\le\lambda_a+(n-2)m_a/\lambda_a$. Both assignments as recorded. **CONFIRMED.**

**The range is right, and the exclusion is the whole content.** $T_{abc}$ vanishes unless $a,b,c$ are pairwise distinct, so $m_a$ and $M_a$ must be extrema of $\lambda_b\lambda_c$ over $b\ne c$ with both $\ne a$. Both exclusions are as recorded. **CONFIRMED.**

**Lemma L70 is not the $\lambda_{\min}$ member; it is that member weakened.** The record's Lemma L70 derivation bounds $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_{\max}$ over *all* pairs, so it uses $\lambda_{\min}\lambda_{\max}\le m_{\arg\min}$; dividing by $\lambda_{\min}<0$ reverses this to $m_{\arg\min}/\lambda_{\min}\le\lambda_{\max}$, hence

$$\underbrace{\lambda_{\min}+(n-2)\frac{m_{\arg\min}}{\lambda_{\min}}}_{\text{row member}}\;\le\;\underbrace{\lambda_{\min}+(n-2)\lambda_{\max}}_{\text{Lemma L70}} .$$

The two coincide exactly when $m_{\arg\min}=\lambda_{\min}\lambda_{\max}$, i.e. when $\operatorname{mult}(\lambda_{\min})\ge2$ so that a second $\lambda_{\min}$ index survives the exclusion, which holds at every catalogued point and fails at generic ones. **So the row member is strictly stronger whenever $\lambda_{\min}$ is simple, and Lemma L70 as recorded is the weaker of the two.** This matches the record's own restatement as reported to me; I reached it independently and it is the correct reading.

**The padded $W_{\mathbb{CP}^2}$ figures do not check out.** That point has $\lambda_{\max}=2/\sqrt6=0.816497$ simple and $\lambda_{\min}=-1/\sqrt6=-0.408248$ of multiplicity $2$, the rest kernel, at every padding dimension. By hand:

| quantity | $n=6$ | $n=12$ |
|---|---|---|
| $\Pi$-bound $(n-1)\lvert\lambda_{\min}\rvert$ | $5/\sqrt6=2.041241$ | $11/\sqrt6=4.490731$ |
| Lemma L70 $\lambda_{\min}+(n-2)\lambda_{\max}$ | $7/\sqrt6=2.857738$ | $19/\sqrt6=7.756718$ |
| row family, minimum over rows | $1.632993$ | $2.857738$ |
| true $\theta$ | $1.224745$ | $1.224745$ |

The record's reported triple, row-min $2.041241$ against Lemma L70's $4.490731$ and the $\Pi$-bound's $2.857738$, matches **no single $n$**: $2.041241$ is the $\Pi$-bound at $n=6$, $4.490731$ is the $\Pi$-bound at $n=12$, and $2.857738$ is Lemma L70 at $n=6$ and the row-min at $n=12$. The three numbers are individually real and collectively mixed across dimension and across bound. The qualitative claim survives, the row family does beat both standing bounds at this point, by $1.63$ against $2.04$ and $2.86$ at $n=6$, but the figures need rerunning at one $n$ before anything cites them.

**"Coinciding with both at the balanced products and at the tori" is half false.** At $S^3\times S^3$ all three equal $\theta_0(6)=1.054093$ and are exact. At the $n=6$ maximal torus the $\Pi$-bound is **exact** at $0.645497$ while the row family's minimum is $1.936492$, three times larger, because the $\Pi$-bound is not a member of this family at all: it is derived from the (B) and (C) rows *together* with $\lambda_b\lambda_c\le\big(\tfrac{\lambda_b+\lambda_c}2\big)^2$, and the family here uses (C) rows alone. **The family does not contain the $\Pi$-bound and does not dominate it.**

**On which positive row is strongest, I get the opposite of what the record now says.** On the positive branch the bound is $f(\lambda_a)=\lambda_a+(n-2)M_a/\lambda_a$. $M_a$ depends on $a$ only through the exclusion of index $a$, so it is essentially constant across rows, and $f$ is decreasing on $\lambda_a<\sqrt{(n-2)M_a}$, a range that contains every eigenvalue whenever $M_a\ge\lambda_{\max}^2/(n-2)$, which is the normal case. So **the largest positive eigenvalue gives the strongest bound**, not the smallest; and $\arg\max$ gains twice over when $\lambda_{\max}$ is simple, since excluding it also drops $M_a$. My padded $W_{\mathbb{CP}^2}$ minimum is attained at the $\lambda_{\max}$ row at both $n=6$ and $n=12$, and at the $n=8$ spectrum of $S^3\times S^5$ ($\lambda=0.39841,0.11952,-0.15936$) the $\lambda_{\max}$ row gives $2.789$ against the small-positive row's $8.09$. If the record has a point where the smallest positive row wins, it needs the mechanism named, because the monotonicity runs the other way.

**The balanced-product slack of exactly $n/(n-2)$ is right, and here is the derivation.** At $S^m\times S^m$, $n=2m$, tracelessness gives $\lambda_-=-\tfrac{m-1}m\lambda_+$. The negative row has $m_a=\lambda_+\lambda_-$ and returns $\lambda_-+(n-2)\lambda_+=\theta_0(n)$, tight. The positive row has $M_a=\lambda_+^2$, since $\lambda_+>\lvert\lambda_-\rvert$, and returns $(n-1)\lambda_+$. The ratio is

$$\frac{(2m-1)\lambda_+}{\lambda_+(m-1)(2m-1)/m}=\frac m{m-1}=\frac n{n-2},$$

**exactly as reported. CONFIRMED by hand.**

---

## 7. What I would have the record change

1. **Lemma L73's sharpness sentence.** Replace the two families by one: $S^2\times S^{n-2}$ saturates at every $n$, even and odd, with the mechanism visible by inspection ($E_{\max}=\Lambda^2V_2$ one-dimensional). Keep $\mathbb{CP}^m$ as a second family, restrict the torus claim to even $n$, and change "slack at every sphere product" to "slack at every sphere product with both factors of dimension $\ge3$".
2. **Add the two-smallest strengthening** of §2.6, which is free, strictly stronger at simple $\lambda_{\min}$, and still sharp.
3. **T9's headline becomes $\ge1.392879$**, with the note that the outer search is still climbing.
4. **Outcome (iv) is not testable at $n=6$** and conflates spectrum-realizability with critical-point-realizability; restate it and move the run to $n\ge12$.
5. **Reword the Jacobi fence** to forbid a linear Jacobi row rather than any use of $T$, and record that in this setting the algebra is fixed, so the missing constraint is the $\mathfrak{so}(n)$-orbit condition and is strictly stronger than Jacobi.
6. **Rerun the padded $W_{\mathbb{CP}^2}$ comparison at one $n$** before the row family's figures are cited, and drop "coinciding at the tori".
