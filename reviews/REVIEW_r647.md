# Review 647, Lemma L78, the residual floor $\alpha\ge(2d/n)(4d-n^2)$ for the 3-form mass

**Review number: r647.** Reviewer A of a two-reviewer pair on identical cold briefs. Target: [findings/isotropy-cap.md:155](../findings/isotropy-cap.md#L155). Analysis only; the one compute used was screening claims I was about to record, reported as screens and never as evidence for a positive claim. **The gradient search this block reinterprets was not re-run.**

## Verdict

**CONFIRMED, and the load-bearing clause is upgraded from an inference to a theorem, by a witness the record does not have.**

| clause | verdict | correct label |
| --- | --- | --- |
| the floor $\alpha\ge\frac{2d}n(4d-n^2)$ | **CONFIRMED, proved**, every $d$-subspace of $\mathfrak{so}(n)$, $n\ge4$, no isotropy, no genericity | `Lemma` |
| $8.4$ at $n=5$, $d=7$ | **CONFIRMED**, $42/5$ exactly, in the ordered-slot reading only | arithmetic |
| "that search had found the true global minimum" | **CONFIRMED, and now provable**, §3 exhibits the minimiser in closed form | `Lemma`, was an `Observation` |
| symmetric pairs realise $6,9,12,16=\lfloor n^2/4\rfloor$ | **REFUTED as written, true on the intended reading**, three counterexamples sit in this same file | `Lemma` once the word *balanced* is inserted |
| "not marginal", of $8.4$ **and** $16.6$ | **GAP**, $16.6$ sits $24\%$ above its own floor of $13.33$, which the block never says |, |
| the positive control | **GAP** (apt for a claim that is now a theorem, inert for the claim it is cited under |), |

Four defects, all repairable in place, none touching the mathematics: an undefined symbol, a missing range, a false universal quantifier, and a missing proof pointer.

## 0. What I use, and under which reading

Everything below is in the conventions of [findings/conventions.md](../findings/conventions.md), with the readings named because the brief asks for them.

- **The pairing** is the half-trace one, $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal, the [Norms and pairings](../findings/conventions.md) row, "the one every result uses".
- **Structure constants** $c_{ijk}=\langle[f_i,f_j],f_k\rangle$, totally antisymmetric, so $T_{ijk}=c_{ijk}^2$ is totally symmetric, the [Structure constants](../findings/conventions.md) bullet.
- **$S_{XYZ}$ in the ORDERED-slot reading**, as fixed in [conventions.md](../findings/conventions.md) on 2026-09-04: $S_{\mathfrak{mmh}}=\sum_{a,b\in\mathfrak m}\sum_{h\in\mathfrak h}c^2_{abh}$, and so on. I use no other reading anywhere.
- **The Killing marginal** $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, from the [pair cap](../findings/conventions.md) bullet.
- $N=\binom n2$, $\mathfrak h=\mathfrak m^\perp$, $r=\dim\mathfrak h=N-d$.

### $\alpha$ and "3-form mass" are undefined on the record, first defect

[conventions.md](../findings/conventions.md) has **no row for $\alpha$ and no row for "3-form mass"**, and neither appears anywhere in [findings/](../findings/) outside this block. Worse, the letter is already spent: across the record $\alpha$ is a **basis index**, $T_{\alpha\beta\gamma}$, $\epsilon_{\alpha\beta}$, $\lambda_\alpha$ in the same conventions file, so L78 introduces a scalar under a letter the record uses for a subscript. The definition exists in exactly one place, [reviews/REVIEW_r65.md:73](REVIEW_r65.md#L70), which the block never cites:

$$\alpha(\mathfrak m)\;=\;\sum_{a,b,c\in\mathfrak m}c^2_{abc}\;=\;S^{\mathrm{ord}}_{\mathfrak{mmm}},$$

the **ordered-slot** mass, six times the sum over $a<b<c$.

**This is load-bearing, not cosmetic.** The whole force of the block is that a formula produces *the digits* $8.4$. In the ordered reading the floor at $n=5$, $d=7$ is $42/5=8.4$; in the unordered reading, which [bounds-relaxations.md](../findings/bounds-relaxations.md) uses for the same block masses, and which [conventions.md](../findings/conventions.md) records as a live collision, the identical statement reads $\alpha\ge\frac d{3n}(4d-n^2)=7/5=\mathbf{1.4}$. **A reader in the wrong reading finds the coincidence gone by a factor of six.** This is the same failure that produced [L77](../findings/isotropy-cap.md)'s factor-$2$ dispute, in which both reviewers were right; here it would be a factor of six.

*Repair: add an $\alpha$ row to [conventions.md](../findings/conventions.md) giving the display above with the word ORDERED, and state in the heading that $\alpha=S^{\mathrm{ord}}_{\mathfrak{mmm}}$.*

## 1. The floor, derived cold, and it is a theorem

### 1.1 The exact identity the floor is a slackening of

For any subspace $\mathfrak m$ with orthonormal basis $\{e_a\}$, write $\mathop{\mathrm{ad}}(e_a)$ in the block form of $\mathfrak g=\mathfrak m\oplus\mathfrak h$:

$$\mathop{\mathrm{ad}}(e_a)=\begin{pmatrix}A_a&-B_a^{\mathsf T}\\ B_a&C_a\end{pmatrix},$$

skewness fixing the top-right block. Reading off entries, $\sum_a\lVert A_a\rVert^2=S_{\mathfrak{mmm}}=\alpha$, $\sum_a\lVert B_a\rVert^2=S_{\mathfrak{mmh}}$, $\sum_a\lVert C_a\rVert^2=S_{\mathfrak{mhh}}$. The Killing marginal summed over $\{e_a\}$ is $\sum_a\lVert\mathop{\mathrm{ad}}(e_a)\rVert_F^2=2(n-2)d$, so

$$\boxed{\;\alpha+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2(n-2)d\;}$$

**with no hypothesis at all.** This is [L36](../findings/isotropy-cap.md)'s boxed $2\mu+\gamma=2(n-2)d$ with the standing $\alpha=0$ put back, and it agrees with the general law [conventions.md](../findings/conventions.md) now carries, $\gamma=S^{\mathrm{ord}}_{\mathfrak{mhh}}-S^{\mathrm{ord}}_{\mathfrak{mmm}}$: the bracket mass is $\mu=\alpha+S_{\mathfrak{mmh}}$, so $2(n-2)d-2\mu=S_{\mathfrak{mhh}}-\alpha$ exactly. Eliminating $S_{\mathfrak{mmh}}$,

$$\alpha\;=\;2\mu-2(n-2)d+S_{\mathfrak{mhh}},\qquad S_{\mathfrak{mhh}}\ge0\ \text{by inspection.}\tag{1}$$

### 1.2 The lower bound on $\mu$, rebuilt

$\mu=\langle T(P),P\rangle$ with $P$ the orthoprojector onto $\mathfrak m$ and $T(A)=-\sum_k\mathop{\mathrm{ad}}(f_k)A\mathop{\mathrm{ad}}(f_k)$: skewness of $\mathop{\mathrm{ad}}$ turns $-\mathop{\mathrm{tr}}(\mathop{\mathrm{ad}}(f_k)P\mathop{\mathrm{ad}}(f_k)P)$ into $\sum_{a,b}c^2_{kab}$, and summing over $k$ gives $\mu$. Expanding $\rho(X)A=[\mathop{\mathrm{ad}}X,A]$ against $\sum_k\mathop{\mathrm{ad}}(f_k)^2=-2(n-2)\mathrm{Id}$ gives $\mathop{\mathrm{Cas}}(A)=-\sum_k\rho(f_k)^2A=4(n-2)A-2T(A)$, i.e.

$$T=2(n-2)\mathrm{Id}-\tfrac12\mathop{\mathrm{Cas}}.$$

I rebuilt the four Casimir eigenvalues from $\langle\lambda,\lambda+2\rho\rangle$ with $\rho_i=(n-2i)/2$, the normalisation pinned by the adjoint $\lambda=e_1+e_2$ giving $2(n-2)$:

| summand | highest weight | $\mathop{\mathrm{Cas}}$ | $T=2(n-2)-\mathop{\mathrm{Cas}}/2$ |
| --- | --- | --- | --- |
| $\mathbb R\cdot\mathrm{Id}$ | $0$ | $0$ | $2n-4$ |
| $\mathop{\mathrm{Sym}}^2_0\mathbb R^n$ | $2e_1$ | $2n$ | $n-4$ |
| $\mathrm{Weyl}_n$ | $2e_1+2e_2$ | $4n-4$ | $-2$ |
| $\Lambda^4\mathbb R^n$ | $e_1+e_2+e_3+e_4$ | $4n-16$ | $4$ |

All four reproduce [L36](../findings/isotropy-cap.md)'s and [r65](REVIEW_r65.md#L36)'s table. For $n\ge4$ the minimum on $\mathrm{Id}^\perp$ is $-2$, carried by $\mathrm{Weyl}_n$ alone. Splitting $P=\frac dN\mathrm{Id}+P_0$ with $\lVert P\rVert^2=d$ and $\lVert P_0\rVert^2=d-d^2/N$,

$$\mu\;\ge\;(2n-4)\frac{d^2}N-2\Bigl(d-\frac{d^2}N\Bigr)\;=\;\frac{(2n-2)d^2}N-2d\;=\;\frac{4d^2}n-2d.\tag{2}$$

### 1.3 The floor

Substituting (2) into (1) and dropping $S_{\mathfrak{mhh}}\ge0$:

$$\alpha\;\ge\;2\Bigl(\frac{4d^2}n-2d\Bigr)-2(n-2)d\;=\;\frac{8d^2}n-2nd\;=\;\frac{2d}n\bigl(4d-n^2\bigr).\qquad\blacksquare$$

**Confirmed, with the hypotheses named: $n\ge4$, $\mathfrak m$ any $d$-dimensional subspace of $\mathfrak{so}(n)$, $\alpha$ read as $S^{\mathrm{ord}}_{\mathfrak{mmm}}$. No isotropy. No genericity. No dimension restriction beyond $n\ge4$.** At $n=3$ the $\mathrm{Weyl}$ summand is empty and $T\succeq n-4=-1$, which gives the *stronger* $\alpha\ge2d^2-4d$; the block's formula is still true there, merely not sharp.

**Structurally, the floor is twice the failure of [L36](../findings/isotropy-cap.md)'s own sandwich.** L36 chains $\frac{4d^2}n-2d\le\mu\le(n-2)d$ and reads off $d\le n^2/4$. Past the cap the chain inverts, and $\alpha$ is exactly twice how far it inverts by. That is worth one sentence in the block, because it makes the floor obvious rather than surprising.

### 1.4 Arithmetic, and the range where the floor says anything, second defect

$(2\cdot7/5)(4\cdot7-25)=\frac{14}5\cdot3=\frac{42}5=8.4$. Trivially right, and right in the ordered reading only (§0).

**Sign.** $\frac{2d}n(4d-n^2)>0\iff d>n^2/4$, and $\alpha\ge0$ always, so **the floor has content only strictly above the cap $\lfloor n^2/4\rfloor$** and is vacuous at or below it. **The block never says this.** [r65](REVIEW_r65.md#L71) does say something, and what it says is wrong: *"This is $0$ exactly when $d\le n^2/4$"*, it is $0$ only at $d=n^2/4$ and strictly negative below.

**A consequence the block trips over.** Its sentence *"Every catalogued $S=0$ point respects it: $\dim\mathfrak m$ is $9,20,6,12$ … against caps $9,25,9,16$"* is filed as evidence for the floor. Those arithmetic pairs are all correct, $S^3\times S^3$ at $n=6$, the $C_5$ blow-up at $n=10$, $\mathbb{CP}^3$ at $n=6$, $\mathbb{CP}^4$ at $n=8$, but three of the four sit strictly below the cap, where the floor is negative and asserts nothing. **They are evidence for [L36](../findings/isotropy-cap.md), shelved under L78.** The fourth, $S^3\times S^3$ at $d=9=$ cap, is a genuine equality case; see §4.

## 2. Is the floor tight anywhere else? Yes, three families, two of which the record already holds

The brief asks because a floor matched at one point is weak evidence. Equality in the derivation requires exactly two things, and both are readable:

- **(E1)** $S_{\mathfrak{mhh}}=0$, i.e. $\langle[\mathfrak h,\mathfrak h],\mathfrak m\rangle=0$, i.e. **$\mathfrak h=\mathfrak m^\perp$ is a subalgebra**;
- **(E2)** $P_0=P_{\mathfrak m}-\frac dN\mathrm{Id}$ lies **entirely in $\mathrm{Weyl}_n$**, the $-2$ eigenspace.

Given (E1), $P_{\mathfrak h}$ commutes with $\mathop{\mathrm{Ad}}(\mathfrak h)$, so each of its $O(n)$-isotypic components is an $\mathfrak h$-invariant vector of that summand. Hence a clean **sufficient criterion**:

> **Criterion.** If $\mathfrak h\subseteq\mathfrak{so}(n)$ is a subalgebra with $(\mathop{\mathrm{Sym}}^2_0\mathbb R^n)^{\mathfrak h}=0$ and $(\Lambda^4\mathbb R^n)^{\mathfrak h}=0$, then $\mathfrak m=\mathfrak h^\perp$ attains the floor at $d=N-\dim\mathfrak h$.

Three families follow.

| family | $n$, $d$ | why (E1) and (E2) hold | floor $=\alpha$ |
| --- | --- | --- | --- |
| $\mathfrak m=\mathfrak{so}(n)$ | any $n$, $d=N$ | $\mathfrak h=0$, so $P_0=0$ and (2) is an equality | $n(n-1)(n-2)$, and $\alpha=2(n-2)N$ is the same number |
| balanced symmetric pair | even $n$, $d=n^2/4$ | $\mathfrak h=\mathfrak{so}(\frac n2)\oplus\mathfrak{so}(\frac n2)$; the file's own isotypic table gives $\mathop{\mathrm{Sym}}^2_0=\Lambda^4=0$ at $n=6$ | $0$, and $\alpha=0$ by isotropy |
| **principal $\mathfrak{so}(3)$** | $n=5$, $d=7$ | §3 | $42/5=\mathbf{8.4}$ |

The middle row is already in [isotropy-cap.md](../findings/isotropy-cap.md), thirteen lines above L78's heading: the isotypic table records $\lVert P_0\rVert^2=3.6$ with $\mathop{\mathrm{Sym}}^2_0=\mathbf 0$ and $\Lambda^4=0$ at $n=6$, $d=9$, and the block above it calls "at even $n$ the traceless part lies entirely in $\mathrm{Weyl}_n$" a **theorem**. That is (E2), stated as a theorem, one screen above a lemma that needed it and did not look. **The answer to "is it tight anywhere else" was in the same file, sixteen lines up.**

At odd $n$ and $d=\frac{n^2-1}4$ the floor is $-2d/n<0$ while $\alpha=0$, so it is *not* tight, the same parity asymmetry the file's $\mathop{\mathrm{Sym}}^2_0$ row records.

## 3. The reinterpretation, licensed, and provable, though not for the block's reason

### 3.1 What the block's argument actually is

The claim *"that search was not stalling; it had found the true global minimum"* is a **sandwich**: a proved lower bound of $8.4$ against a feasible point valued at $8.4$. That structure is sound, a point the optimiser produces is a genuine upper bound on the minimum, feasibility here being nothing more than "a $7$-plane in $\mathfrak{so}(5)$", automatic on the Stiefel manifold. So this is *not* the forbidden inference from a negative computational result; it is a lower bound meeting an upper bound, with only the upper half numerical.

**But as recorded it is an `Observation` at one point, not a `Lemma`, because attainment is inferred from the coincidence rather than proved.** The brief's discriminating question, is the floor tight, or wrong in a way that coincidentally matches?, is answered decisively below, and the answer is *tight*.

### 3.2 The minimiser, in closed form

**Take $\mathfrak h$ to be the principal $\mathfrak{so}(3)\subset\mathfrak{so}(5)$**, the image of $\mathfrak{so}(3)$ under its irreducible $5$-dimensional representation $V_5\cong\mathop{\mathrm{Sym}}^2_0(\mathbb R^3)$, and $\mathfrak m=\mathfrak h^\perp$, of dimension $10-3=7$. Under this $\mathfrak{so}(3)$, $\Lambda^2V_5=V_7\oplus V_3$ with $V_3=\mathfrak h$, so **$\mathfrak m$ is the $V_7$-isotypic piece of $\mathfrak{so}(5)$**, the spin-$3$ summand.

- **(E1)** holds: $\mathfrak h$ is a subalgebra by construction.
- **(E2)** holds, and needs only two branching rules. $\mathop{\mathrm{Sym}}^2V_5=V_9\oplus V_5\oplus V_1$, so $\mathop{\mathrm{Sym}}^2_0(\mathbb R^5)=V_9\oplus V_5$ carries **no trivial summand**; and $\Lambda^4\mathbb R^5\cong\mathbb R^5=V_5$ carries none either. Both invariant spaces vanish, so both components of $P_{\mathfrak h}$ vanish and $P_0\in\mathrm{Weyl}_5$.

Then (2) is an equality: $\mu=6\cdot\frac{49}{10}-2\bigl(7-\frac{49}{10}\bigr)=29.4-4.2=25.2$, and (1) gives

$$\alpha(\mathfrak m)=2(25.2)-2\cdot3\cdot7+0=50.4-42=\frac{42}5=\mathbf{8.4}\ \text{ exactly.}$$

**Therefore $\min\{\alpha(\mathfrak m):\mathfrak m\subseteq\mathfrak{so}(5),\ \dim\mathfrak m=7\}=42/5$, and the gradient search's $8.4$ was the true global minimum.** The reinterpretation is a `Lemma`, with a named extremiser, not an `Observation` at one point.

*Screened, exactly as the standing rule allows, on objects I built for the purpose: the three conjugacy classes of $3$-dimensional subalgebra of $\mathfrak{so}(5)$, every subalgebra of a compact algebra is reductive, a nonzero centre would force rank $\ge3$ which $\mathfrak{so}(5)$ lacks, so the list is $\mathfrak{su}(2)$ acting as $V_5$, as $V_3\oplus2V_1$, or as $H_2\oplus V_1$, give $\alpha=8.400000$, $18$ and $30$ respectively, with $S_{\mathfrak{mhh}}\le3\times10^{-31}$ in each. Reported as a screen; the derivation above is the claim.*

### 3.3 Why $n=6,7,8$ are slack, which the block does not mention, third defect

[r65](REVIEW_r65.md#L73)'s own table, the source of this block, reads:

| $n$ | search at $\lfloor n^2/4\rfloor+1$ | the floor there | slack |
| --- | --- | --- | --- |
| $5$ | $8.400$ | $8.400$ | **none, attained** |
| $6$ | $16.55$ | $13.33$ | $+24\%$ |
| $7$ | $17.64$ | $11.14$ | $+58\%$ |
| $8$ | $23.94$ | $17.00$ | $+41\%$ |

**The floor is matched at one of four points tested and misses at the other three, and the block reports only the matched one.** It quotes "$8.4$ and $16.6$, not marginal" side by side, as though the pair told one story; $16.6$ is a number that *exceeds* its floor by a quarter, and [r66](REVIEW_r66.md#L106) independently got $18.0$ there, so even the upper half is unsettled at $n=6$. **Whatever the block's $16.6$ is evidence of, it is not that the floor is tight.**

The criterion explains the pattern. Equality at $d=\lfloor n^2/4\rfloor+1$ needs a subalgebra $\mathfrak h$ of dimension $N-d$ with no invariants in $\mathop{\mathrm{Sym}}^2_0\mathbb R^n$, which forces $\mathfrak h$ to act **absolutely irreducibly** on $\mathbb R^n$, hence (Schur) to be **semisimple**, since a nonzero centre would act by skew endomorphisms commuting with $\mathfrak h$ and so by zero.

- $n=6$, $d=10$: $\dim\mathfrak h=5$, and **$5$ is not the dimension of any compact semisimple algebra**.
- $n=7$, $d=13$: $\dim\mathfrak h=8$, forcing $\mathfrak{su}(3)$, which has **no $7$-dimensional real irreducible representation** ($1,6,8,\dots$).
- $n=8$, $d=17$: $\dim\mathfrak h=11$, forcing $\mathfrak{su}(2)\oplus\mathfrak{su}(3)$, whose absolutely irreducible real modules have dimension $a\cdot b$ with $a\in\{1,3,5,7,\dots\}$ and $b\in\{1,6,8,\dots\}$, $8$ only as $1\cdot8$ or $8\cdot1$, neither faithful.

**So the sufficient mechanism is unavailable at all three, and available at $n=5$ precisely because $\mathfrak{so}(5)$ has a principal $\mathfrak{so}(3)$ of the right dimension.** This rules out the criterion's route to equality, not every conceivable equality case ((E2) could in principle hold accidentally) so it is a strong explanation of the measured slack rather than a proof of it. *Screen, on principal $\mathfrak{so}(3)$ at $n=7,9$, where $\Lambda^4\mathbb R^7$ carries the $G_2$-invariant form and (E2) must fail: the gaps come out $18/7$ and $22/5$, nonzero, as the criterion predicts.*

### 3.4 The positive control, what it controls for, and what it does not

The block: *"the same optimiser from random starts finds an isotropic subspace at $\lfloor n^2/4\rfloor$ itself, residual $\sim10^{-11}$, so the negative is informative rather than a blind search."*

**It controls for the optimiser being able to reach a zero of a non-negative objective when one exists at the neighbouring dimension**, it rules out a broken parametrisation, a wrong retraction, a mis-signed gradient. For its stated job, "the failure at cap$+1$ is a fact about the geometry rather than the search", it is the right control, and [r66](REVIEW_r66.md#L106) reports it succeeding on the *first* start at both $n$.

**Two things follow that the block does not draw.**

1. **The job is now done by a theorem.** [L36](../findings/isotropy-cap.md) proves there is no isotropic subspace above $\lfloor n^2/4\rfloor$. The control certifies a fact the same file proves $138$ lines earlier, so it is superseded rather than wrong.
2. **It does nothing for the load-bearing claim.** Finding a zero of a non-negative objective and certifying global optimality of a *positive* value are different problems: in the first, any descent path that reaches $0$ certifies itself; in the second, a local minimum is indistinguishable from a global one from inside the run. The control demonstrates competence at the first and is silent on the second. What licenses the second is the floor, and, now, §3.2's witness. **The control is redundant to the conclusion, not supporting of it**, and the block places it in the sentence immediately after the conclusion, where it reads as support.

## 4. The $\lfloor n^2/4\rfloor$ claim, REFUTED as written, a two-line corollary as intended

*"Symmetric-pair subspaces realise $6,9,12,16$ at $n=5,6,7,8$, exactly $\lfloor n^2/4\rfloor$ each."*

**The arithmetic is right and the universal quantifier is false.** $\lfloor25/4\rfloor=6$, $\lfloor36/4\rfloor=9$, $\lfloor49/4\rfloor=12$, $\lfloor64/4\rfloor=16$. But *symmetric-pair subspaces* do not each realise the cap, and **this file states three counterexamples itself**:

- $\mathfrak{so}(6)/\mathfrak u(3)$, type DIII: $\dim\mathfrak p=6\ne9$ at $n=6$, named in [L75](../findings/isotropy-cap.md)'s repair block, which uses it to close a table row;
- $\mathfrak{so}(8)/\mathfrak u(4)$: $\dim\mathfrak p=k(k-1)=12\ne16$ at $n=8$, the same family, and the $\dim\mathfrak m=7,15\ne16$ remark in [L77](../findings/isotropy-cap.md)'s block turns on knowing it;
- $\mathfrak{so}(2)\oplus\mathfrak{so}(4)\subset\mathfrak{so}(6)$: $\dim\mathfrak p=8\ne9$, the whole point of the **REFUTED: there is no gap at $8$** block, sixty lines below.

**Repair: one word.** *The **balanced** symmetric pair realises $\lfloor n^2/4\rfloor$ at every $n$.*

**And on that reading it is a `Lemma`, not four data points.** The brief's companion result supplies both halves:

- $\mathfrak p=\mathbb R^p\otimes\mathbb R^q$ is isotropic and maximal isotropic, for every symmetric $\mathfrak{so}(n)=\mathfrak k\oplus\mathfrak p$ with $[\mathfrak p,\mathfrak p]=\mathfrak k$, [L76](../findings/isotropy-cap.md), via $K_{p,q}$ triangle-free;
- $\max_{p+q=n}pq=\lfloor n/2\rfloor\lceil n/2\rceil=\lfloor n^2/4\rfloor$, arithmetic, no numerics.

So the family attains the top of the admissible interval $[n-1,\lfloor n^2/4\rfloor]$ that [L76](../findings/isotropy-cap.md) brackets. **The four numbers are a spot check on an identity in $p$ and $q$, exactly as [L76](../findings/isotropy-cap.md) says of its own $n=6,7,8$ verification.** They are also, verbatim, the *sharpness* half of [L36](../findings/isotropy-cap.md)'s statement, *"with equality attained by the mixed planes $\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$ at $p=\lceil n/2\rceil$"*, reprinted as evidence for a different lemma, uncited.

## 5. Provenance, L78 was in the same bulk retrofit as L75, L76 and L77

`git log -S"Lemma L78" -- findings/isotropy-cap.md` returns one commit, and it is the expected one:

- **5b258c14, 2026-09-02, `docs(isotropy-cap): place headings for Lemmas 75-82`**, body: *"eight results that previously sat under narrative headings only are now greppable by number … headings only: no statement, proof or table text is altered"*.

**That is the same commit family the brief names**, the one [L75](../findings/isotropy-cap.md)'s repair calls *"a bulk retrofit"* and [L76](../findings/isotropy-cap.md)'s calls *"a bulk retrofit ten days after the block"*. So L78 shares the provenance. **It shares the structural failure too, in a milder form.**

- **Same shape as [L77](../findings/isotropy-cap.md).** L77's diagnosis was *"L77 has no statement-and-proof block of its own, which is why the hypothesis had nowhere to land"*. **L78 likewise has no statement-and-proof block**: the numbered heading is immediately followed by a second heading, *"A by-product that reinterprets this project's own evidence"*, and the body is three paragraphs of prose. There is no proof of the floor anywhere in [findings/](../findings/).
- **Different casualty.** L75/L76/L77 lost *hypotheses*. The floor has none to lose (it holds for every subspace) so what the retrofit dropped instead is the **definition of $\alpha$** (§0) and the **range where the bound has content** (§1.4). Both live only in [r65](REVIEW_r65.md), which **the block never cites**, although the file's opening line does cite [r65](INDEX.md) for [L36](../findings/isotropy-cap.md).

**Pointers.** Both external links in the block resolve, [arXiv:2007.12820](https://arxiv.org/abs/2007.12820) and [arXiv:2603.00715](https://arxiv.org/abs/2603.00715), HTTP 200 each, and both have entries on the record, at [references/qiao-2020-turan-alternating-multilinear/](../references/qiao-2020-turan-alternating-multilinear/) and [references/turan-multilinear-2026/](../references/turan-multilinear-2026/), which the block passes over in favour of bare arXiv links. Elsewhere in the same file, [isotropy-cap.md:382](../findings/isotropy-cap.md#L382) still carries an empty `[Lemma L36](#)` target, outside this block, but the file-level defect the brief warns about is still live.

**Consumers: none.** `L78` appears nowhere in [findings/](../findings/), [plan.md](../plan.md), [plan-verification.md](../plan-verification.md), [results.md](../results.md) or [report/](../report/) outside its own heading. [INDEX-results.md:93](../findings/INDEX-results.md#L93) carries the row with *"Gate 2: no verdict on the record"*, which this review and its pair are the first to change. **Nothing downstream breaks whichever way the repairs land**, which is also why the block has gone unexamined.

## 6. Label and scope, clause by clause

The record's labels are literal: `Lemma` proven, `Observation` verified numerically at the dimensions named.

| clause | label it should carry |
| --- | --- |
| $\alpha\ge\frac{2d}n(4d-n^2)$, every $d$-subspace, $n\ge4$, $\alpha=S^{\mathrm{ord}}_{\mathfrak{mmm}}$ | **`Lemma`**, §1, and the proof is [L36](../findings/isotropy-cap.md)'s own with $\alpha=0$ removed |
| content only at $d>\lfloor n^2/4\rfloor$ | **`Lemma`**, and currently unstated |
| $8.4$ at $n=5$, $d=7$ is the global minimum, attained at $\mathfrak m=(\text{principal }\mathfrak{so}(3))^\perp$ | **`Lemma`**, §3.2; it was an `Observation` at one dimension and need not stay one |
| the floor is tight at $d=N$, and at $d=n^2/4$ for even $n$ | **`Lemma`**, §2 |
| the **balanced** symmetric pair realises $\lfloor n^2/4\rfloor$ | **`Lemma`**, §4; as written, with no *balanced*, it is **false** |
| slack at $n=6,7,8$, and its cause | **`Observation`** at $n=6,7,8$, §3.3 explains it but does not prove strictness |
| the positive control | not a result; **delete or re-site**, since [L36](../findings/isotropy-cap.md) proves what it controls for |

## 7. What the record should do

1. **Add an $\alpha$ row to [conventions.md](../findings/conventions.md)** with $\alpha=S^{\mathrm{ord}}_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}c^2_{abc}$ and the note that the unordered reading divides it by six, so the block's $8.4$ becomes $1.4$. Note also that $\alpha$ is a basis index elsewhere on the record.
2. **Give L78 a statement-and-proof block**, four lines: identity (1), bound (2), substitute. Cite [r65](REVIEW_r65.md) and [L36](../findings/isotropy-cap.md).
3. **State the range.** "Positive exactly above the cap; vacuous at or below it, where $\alpha\ge0$ is stronger." Move the four $S=0$ points to [L36](../findings/isotropy-cap.md), which is what they test.
4. **Record §3.2 as the attainment lemma**, with the principal $\mathfrak{so}(3)$ named, and demote the reinterpretation's justification from the coincidence to the witness.
5. **Insert *balanced*** in the symmetric-pair sentence, and cite [L76](../findings/isotropy-cap.md) so the four numbers become a corollary.
6. **Report the $n=6,7,8$ slack alongside $8.4$**, with §3.3's dimension count as its cause; the current text quotes $16.6$ without its floor of $13.33$.
7. **Drop or re-site the positive control**, and add §2's two other tightness families, one of which the file already proves thirteen lines above the heading.

---

*Reviewer A, r647. Reviewed cold from the definitions. Compute confined to screening claims recorded above, on objects built for the purpose; the gradient search this block reinterprets was not re-run. Log: [agent_logs/audit-L78-a.log](../agent_logs/audit-L78-a.log).*
