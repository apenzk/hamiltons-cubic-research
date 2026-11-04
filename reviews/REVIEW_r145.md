# Gate 2 review r145, the $n^2$ fence post and the falsification

Cold adversarial review of commits `6fecf17`, `cd2cd1a`, `c96d9c0`, `0a5ea55`, `92f0ead`, `88ab8de` against [findings/second-order.md](../findings/second-order.md), [findings/fence-posts.md](../findings/fence-posts.md), [findings/target.md](../findings/target.md), [findings/nondegeneracy.md](../findings/nondegeneracy.md) and [plan.md](../plan.md). Everything below is derived on paper from the definitions and from numbers already in the record; nothing was recomputed.

## Verdicts

| claim | commit | verdict |
|---|---|---|
| 1. $n^2$ fence post, all localizing orders | `6fecf17`, `cd2cd1a` | algebra correct, **inference not**; heuristic, and a re-encoding of the record's own directional obstruction. "Every localizing order" does no work |
| 2. gap theorem falsified at $n=5$ | `c96d9c0` | **true but already on record**, and the scoping is wrong in both directions |
| 3. fusion-rule tension resolved | `0a5ea55`, `92f0ead` | **relabelled, not resolved**; the resolution is a non sequitur and its corroborating claim is refuted by the record's own table |
| 4. third moment gives a constraint on $b$ | `88ab8de` | constraint **follows**, and is **strictly weaker than a one-line bound**, vacuous as information |

---

## 1. The fence post

### The algebra is right

I re-derived the corrected bracket of `cd2cd1a` independently. With $S_2=\kappa_n/\theta^2$, $\kappa_n=(n-1)(2n-1)/4$ and $S_3=\big((n^2-1)b-(5n-1)\theta\big)/(8\theta^3)$,

$$\tfrac12 S_2-S_3=\frac{\theta(n-1)(2n-1)+(5n-1)\theta-(n^2-1)b}{8\theta^3}=\frac{(n+1)\big[2n\theta-(n-1)b\big]}{8\theta^3},$$

because $(n-1)(2n-1)+(5n-1)=2n(n+1)$. That is the commit's bracket exactly, and with $b=\theta-a$ it is $\sim n^2(\theta+a)/(8\theta^3)$, giving $\mathrm{LHS}/\mathrm{RHS}\sim n^2\theta(\theta+a)/48$ as claimed. **The correction is correct.**

I also confirmed $\theta_0$ and $\kappa_n$ are mutually consistent, with no numerics: the four recorded values $\theta_0^2=10/9,\,21/16,\,36/25,\,55/36$ at $n=6,8,10,12$ fit $\theta_0(n)^2=2(n-1)(n-2)/n^2$ exactly, whence $\kappa_n/\theta_0^2=n^2(2n-1)/\big(8(n-2)\big)$, which is precisely the record's displayed $R(n)\big/\!\big(n(n-1)/8\big)=n(2n-1)/\big((n-2)(n-1)\big)$. The crossover follows as $n^2-12n+8=0$, i.e. $n=6+2\sqrt7$. Three separate recorded quantities are therefore mutually consistent.

### The counting is the wrong measure, and the record already owns the right one

The brief asks whether $n^4$ degrees of freedom is the right measure of what a moment method must separate. **It is not, and the record contains its own refutation of the heuristic.**

- A moment method here does not have to determine the spectrum. It has to bound one scalar. And **one moment already determines $\theta$ exactly**: $\mathop{\mathrm{tr}}(L_e^2)=\kappa_n/\theta^2$. By the fence post's own logic that identity "constrains a vanishing fraction of the spectrum" and should be useless; it is instead the identity the whole route is built on. A heuristic that would have predicted the impossibility of the programme's most-used identity is not measuring the right thing.
- The correct obstruction is **directional, not dimensional**, and [second-order.md](../findings/second-order.md) states it four paragraphs above the fence post: every maximiser condition supplies a *lower* bound $L\le\mathop{\mathrm{tr}}(L_e^2)$, while a counterexample needs $\mathop{\mathrm{tr}}(L_e^2)<R(n)$, so no contradiction is reachable. That argument is two lines, dimension-free, and neither implies nor is implied by the $n^4$-vs-$n^2$ count.
- The $n^2$ slack has a one-line cause and it is not information-theoretic. The determinant condition is Cauchy–Schwarz on the residual spectral measure with total mass $m_0=N-1\sim n^4/12$, of which $\sim n^4$ eigenvalues sit at $O(n^{-1})$ and contribute nothing to $m_{j\ge2}$. **The slack grows like $n^2$ because $m_0$ grows like $n^4$ while every other moment grows like $n^2$, it is the near-zero bulk, not the method, that is widening.** Rescaling removes it: impose the localizing condition on the sub-measure of eigenvalues of size $\Omega(1)$ and $m_0$ drops to $\Theta(n^2)$ and the $n^2$ disappears, at the cost of needing that sub-measure's mass, which is a lower bound on $\mathop{\mathrm{mult}}(\tfrac12)$. So **the fence post's $n^2$ is the record's already-known obstruction ("what the method would need is a lower bound on $\mathop{\mathrm{mult}}(\tfrac12)$") re-expressed in a non-scale-invariant inequality.** It is a restatement.

### The inference "slack grows, therefore no method can work" does not follow

Two independent gaps.

- **A valid necessary condition is never violated at feasible points.** The ratios $1.93,\dots,7.12$ are evaluated at sphere products, where the conjecture holds. What has to be shown is failure to exclude the *hypothetical* region $\theta>\theta_0(n)$, and there the free variable is $b$ (equivalently $S_3$), whose realizable range is unknown. The $\theta$-scan treats $b$ as free; the maximiser conditions do not. The exclusion claim is therefore over a box strictly containing the realizable moment region, and "excludes nothing" is proved for the box, not for the region.
- **The slack of an inhomogeneous inequality is not a measure of its strength.** $A_n\ge B_n$ with $\deg A>\deg B$ has growing ratio for free. The invariant question is whether the feasible set of $\theta$ shrinks, and the record's own scan answers it: the condition is vacuous *already at $n=6$*. So the honest statement is "vacuous at every $n$ tested", not "weakens as $n$ grows". Dressing a uniform vacuity as a trend makes the fence look like a theorem about the limit when it is an observation at every finite point.

### "Every localizing order" is doing no work

Three reasons, in increasing order of severity.

1. **The scaling argument at order $k$ bounds the wrong object.** PSD-ness of the order-$k$ localizing matrix $M_k=(c\,m_{i+j}-m_{i+j+1})_{i,j=0}^{k}$ is $k+1$ nested minor conditions. The commit shows only that $\det M_k$'s leading term ($A_{00}$ times the trailing $k\times k$ minor, $\sim n^{4}\cdot n^{2k}$) dominates the terms avoiding $A_{00}$ ($\sim n^{2k+2}$). That is a statement about which term of one determinant dominates, not that any constraint in the family is slack, and not that the family excludes nothing. In a PSD constraint the binding condition is typically a *small* minor, which the argument never touches.
2. **The leading $k\times k$ minor is assumed nonsingular and that assumption is exactly the interesting case.** Writing $m_j\approx n^2\mu_j$ for $j\ge2$, the trailing minor's leading coefficient matrix is $\big(\tfrac12\mu_{i+j}-\mu_{i+j+1}\big)_{i,j\ge1}$, the order-$(k-1)$ localizing matrix of the limit measure $\mu$ for the same polynomial $(\tfrac12-\lambda)$. It **degenerates as the limit measure concentrates at $\lambda=\tfrac12$**, because $(\tfrac12-\lambda)$ vanishes there. Concentration at $\tfrac12$ is precisely the regime in which a moment argument would bite (large $\mathop{\mathrm{mult}}(\tfrac12)$). So the scaling is proved off the only regime that matters. At the sphere-product asymptotics it is fine ($\mu_2=1/4$, $\mu_3=1/16$, against $1/4$ and $1/8$ for a pure $\tfrac12$-atom), but that is again evaluation at a feasible point.
3. **Orders $k\ge2$ were never available.** $M_k$ needs $m_4,\dots,m_{2k+1}$. The record holds three moments and states in the same file that no fourth universal identity exists ("the moment method stops at two"; $\mathop{\mathrm{tr}}(L_xL_yL_z)$ is a second independent invariant). **You cannot fence off a method you cannot form.** And the limit $k\to\infty$ is the full moment problem with all moments, which is not a relaxation at all (it determines the spectrum) so "the whole hierarchy" cannot be closed by an argument of this shape. Every statement proved is "for each fixed $k$, as $n\to\infty$", with a constant $C_k$ that decays like $4^{-k^2}$-ish from the geometric decay of $\mu_j$; nothing is said about $k$ growing with $n$, which is the only version that could matter at a single finite dimension like $n=12$.

**Answer to (b): the fence post is a heuristic, and the part of it that is sharp is a restatement.** The derivation in `cd2cd1a` is a correct algebraic identity; the conclusion drawn from it is not a theorem, and the extension to every order changes nothing because higher orders were never reachable and the argument at each order bounds a term rather than a constraint.

---

## 2. The falsification

### It is correct, it is not new, and it is not $n=5$

The statement falsified is the gap theorem, *$W$ ungraded and critical $\Rightarrow\lambda_{\max}(L_e|_{W^\perp})\ge c>\tfrac12$*. The witness is padded $W_{\mathbb{CP}^2}$.

**Both conjuncts were already in [findings/](../findings/) before `c96d9c0`, at $n$ up to and including $12$.**

- Ungradedness: [nondegeneracy.md](../findings/nondegeneracy.md), "padded $W_{\mathbb{CP}^2}$ has $S=0$ exactly, **is ungraded** (leaks $16/24/32$), and sits at $0.9909\,\theta_0(12)$". The $16/24/32$ are the squares of second-order.md's $4.0$ and $4.899$ at $n=8,10$, so the two files agree and cover $n=8,10,12$.
- Attainment of the floor: [target.md](../findings/target.md), "**Lemma L24 is exactly tight there**", and separately "Lemma L24's $0.500000$ is shared with **six other points**".

Ungraded, critical, and $\lambda_{\max}=\tfrac12$ exactly. **The record already contained the refutation, in two files, and at $n=12$.** *This is the fourth unwitting re-derivation the brief asks about, not of Fox's Theorem 1.3, but of a refutation the programme already owned.*

### No computation was needed, and the mechanism is $n=4$

The witness follows from three recorded facts with no numerics:

1. At $n=4$, $P=9(\det W^++\det W^-)$ on $\mathrm{Weyl}_4$ and $\max P=\sqrt{3/2}$ **exactly**, attained at $W_{\mathbb{CP}^2}$, a proved statement in [nondegeneracy.md](../findings/nondegeneracy.md).
2. A local maximiser satisfies $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ (the Hessian is $6\theta(L_e-\tfrac12\mathrm{Id})$, $\theta=\sqrt{3/2}>0$).
3. At every critical point the orbit tangent is an exact $\tfrac12$-eigenvector in $W^\perp$, so $\lambda_{\max}\ge\tfrac12$, a theorem in the record, proved by differentiating $Q(gW)=gQ(W)$.

(1)+(2)+(3) give $\lambda_{\max}=\tfrac12$ **exactly at $W_{\mathbb{CP}^2}$ at $n=4$, as a consequence of a closed form.** Padding preserves $\theta$ and criticality; the only thing padding can add is a padding-leaving eigenvalue above $\tfrac12$, and the record measured that it does not (Lemma L24 tight at every padding). Gradedness, by contrast, is *destroyed* by padding: at $n=4$ the isotropy is $\mathfrak u(2)$, a genuine symmetric subalgebra of $\mathfrak{so}(4)$, so $W_{\mathbb{CP}^2}$ **is graded at $n=4$**; at $n\ge5$ the isotropy $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ is on neither branch of Cartan's list.

**So the falsification is a padding artefact, and that is its real content:** the second-order spectrum is padding-stable and gradedness is not. That is worth recording; "an ungraded critical point attains the floor" is not, because it was already recorded twice.

### The scoping is wrong in both directions

**Disagreement with the record, stated explicitly.**

- *"The witness stands at $n=5$ alone" is false.* The record itself has padded $W_{\mathbb{CP}^2}$ critical at $n=6,8,10,12$, the $\dim\mathfrak m\le2$ stratum maximisation returns $1.224745$ at all four, with the $n=6$ spectrum matched to $(2,-1,-1)/\sqrt6$ to $10^{-5}$; the $\circ$-indecomposability table lists it at $n=12$; ascent captures $95$–$100\%$ of starts onto it. The $n=6,7$ "residual $2\times10^{-1}$" reported in `c96d9c0` is a **defect in that reviewer's padding construction**, which the commit itself half-concedes ("the record's padded construction must differ"). It is not evidence about $n=6,7$.
- *"The target survives if restricted to $n\ge12$" is false.* The witness exists at $n=12$: ungraded (nondegeneracy.md, leak $32$), critical, and Lemma L24 tight there (target.md). The rescue would need padded $W_{\mathbb{CP}^2}$ to stop attaining $\tfrac12$ at $n=12$, and the only reason offered anywhere for a change at $n\approx11.29$ is the *global* value crossover $\theta_0(n)>\sqrt{3/2}$, which is irrelevant, because $\lambda_{\max}\le\tfrac12$ is a **local** condition. **This is the same global-for-local substitution the record already caught and corrected in the fusion-rule item, made a second time in the same file.**
- *"$n=5$ is an exceptional dimension" does not scope it either.* The record's exceptional dimensions are $n=6$ (the $(3,3)$ anomaly, the $\tfrac14$/$\tfrac12$ collision) and $n=8$ (triality). Nothing in the record makes $n=5$ exceptional, and the mechanism above is dimension-free.

### The correct repair, and the answer to (a)

The gap theorem fails because it quantifies over **all** critical points, which includes points supported on a proper subspace. The repair is not a dimension restriction but a support restriction: *ungraded, critical, and **not padded** (support not contained in a proper coordinate subspace) $\Rightarrow\lambda_{\max}>\tfrac12$*. Under that hypothesis the witness disappears, since padded $W_{\mathbb{CP}^2}$ is graded in its effective dimension $4$.

**Item 1 survives the falsification untouched.** Its statement (G) is about a **global maximiser**, and padded points cannot be global maximisers at $n\ge12$: padding leaves $\theta$ unchanged, so a point padded from $n_0$ has $\theta\le M(n_0)$, and $M(n_0)\le\sqrt{3/2}<\theta_0(12)=1.236033$ for $n_0\le11$, with induction above. So the witness never reaches (G). What died is a route that proved something strictly stronger than (G) needs, a defect the plan already names ("Item 1's own target is a supremum over the whole critical set, so it discards this and proves something strictly harder than the theorem needs"). **The falsification is a correct refutation of an over-strong lemma whose over-strength was already documented; it costs item 1 nothing, and the plan's banner is right.**

Load-bearing for item 1, in order: claim 2 (kills the named route), claim 1 (kills the moment family), claim 3 (the only instrument the plan lists as untried), claim 4 (contributes nothing).

---

## 3. The Peirce table and the fusion rule

### The table passes an audit it was not given

The recorded gate ("$e\circ x=\lambda x$ returns each block to itself at $100\%$"), **validates the eigendecomposition of $L_e$ and nothing else**. Every row of the table except the $e$-row evaluates $\circ$ at two non-$e$ arguments, which that gate never exercises. The record's own fact that $\langle x\circ y,z\rangle$ is totally symmetric (it polarises $P$) is the gate that would have worked and was not used.

I applied it on paper. Total symmetry forces the support pattern of the table to be symmetric under permuting $(\lambda,\mu,\nu)$, and **all thirty off-diagonal incidences check out**: $\tfrac12\!\times\!\tfrac14\!\to\!\tfrac12$ against $\tfrac12\!\times\!\tfrac12\!\to\!\tfrac14$; $\tfrac14\!\times\!0\!\to\!\tfrac12$ against $\tfrac12\!\times\!\tfrac14\!\to\!0$; $\tfrac14\!\times\!\tfrac14\!\to\!-\tfrac12$ against $\tfrac14\!\times\!(-\tfrac12)\!\to\!\tfrac14$; $0\!\times\!0\!\to\!-\tfrac12$ against $0\!\times\!(-\tfrac12)\!\to\!0$; and every zero entry is matched by a zero in its two transposes. **The table is consistent with the algebra's one structural identity**, which is materially stronger evidence than the gate that was run.

One column of it is forced and carries no information: for $x,y\in A(\lambda)$, $\langle x\circ y,e\rangle=\langle x,y\circ e\rangle=\lambda\langle x,y\rangle$, so the mass sent into $A(1)$ is pure Cauchy–Schwarz overhead scaling as $\lambda^2$, consistent with the reported $15\%$, $14\%$, $5\%$ at $\lambda=\tfrac12,-\tfrac12,\tfrac14$. Those three entries should be struck from the table as identities rather than data.

### The tension is relabelled, not resolved

`92f0ead` resolves the fusion-rule failure by declaring $S^3\times S^3$ non-extremal because *padded $W_{\mathbb{CP}^2}$ beats it globally at $n=6$*. **This is a non sequitur.** Krasnov–Tkachev Prop 6.7 is a third-and-fourth-variation condition at a **local** maximum; a competitor with a larger global value says nothing about it. The record has since flagged exactly this ("Prop 6.7 uses only local maximality ... so the global crossover is irrelevant") but the commit's reasoning is still what stands in the file's resolution paragraph.

**And the commit's corroborating claim is refuted by the record's own table.** It says the failure "matches the record's verdict that it tracks primitivity". [fence-posts.md](../findings/fence-posts.md) says the rule detects primitivity and that non-primitivity already forces $\lambda_{\max}=1$. Resolve the three-way contradiction analytically:

- Non-primitivity $\Rightarrow\lambda_{\max}=1$ is **true**: if $e=e_1+e_2$ with $e_1\circ e_2=0$ then $e\circ e_1=e_1$, so $\dim E(1)\ge2$, so $E(1)$ meets $W^\perp$ and $\lambda_{\max}=1$.
- $S^3\times S^3$ has $\dim E(1)=1$, the record's own $\circ$-indecomposability table, "indecomposable, **proved**". By the same lemma ("every $\circ$-summand lies in $E(1)$"), **$e$ is primitive at $S^3\times S^3$**.
- The fusion rule fails there, at $31.9\%$.

**Therefore the fusion rule fails at a primitive idempotent, and "the fusion rule tracks primitivity" is false.** That is the resolution of the contradiction the record flagged as unresolved: the false member of the triple is fence-posts.md's primitivity reading, not the $\lambda_{\max}=1$ statement and not the measurement. `92f0ead` cites as support the one statement its own datum kills.

What the failure does say, reading Prop 6.7 as the third-order test at the Hessian null directions, which is what it is, is that **$S^3\times S^3$ is not a local maximum at $n=6$**. That is a real conclusion and it is consistent: $\lambda_{\max}=\tfrac12$ there with $\dim E(\tfrac12)=18$ against an orbit of $9$, so second order is inconclusive at nine directions and the decision must be made at third order, which is what the rule tests. This also explains why the rule holds at $S^4\times S^4$ and $S^2\times S^4$: it is an $m=3$ anomaly, matching the record's "$(3,3)$ is a genuine exception".

**Verdict: relabelled.** The tension's stated resolution is wrong, its supporting claim is wrong, and the correct resolution (available from the record without any computation), points the other way, at fence-posts.md.

---

## 4. The third moment

### The constraint follows

$\lambda^3\le\tfrac12\lambda^2\iff\lambda^2(\lambda-\tfrac12)\le0\iff\lambda\le\tfrac12$, valid for negative $\lambda$ as well, so summing over the spectrum with the eigenvalue $1$ peeled off gives $S_3-1\le\tfrac12(S_2-1)$. The hypothesis needed is $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, i.e. local maximality, which also makes the peeled eigenvalue $1$ simple automatically (a second $1$ would sit in $W^\perp$). **Derivation sound.** The rearrangement is right too, and simplifies:

$$b\ \le\ \frac{\theta\big[4\theta^2+2n(n+1)\big]}{(n-1)(n+1)}\;=\;\frac{2n\theta}{n-1}+\frac{4\theta^3}{n^2-1},$$

using $4\kappa_n+(5n-1)=2n(n+1)$. At $n=12$, $\theta=\theta_0(12)$ this is $2.6968+0.0528=2.7496$, reproducing the recorded $2.75$.

### It is vacuous, a one-line bound beats it at every $n\ge6$

$\theta=a+b$ with $a=\langle W^2,W\rangle=\sum_\alpha\lambda_\alpha^3$ and $\sum_\alpha\lambda_\alpha^2=\|W\|^2=1$, so $|a|\le\|\lambda\|_\infty\le1$ and

$$b=\theta-a\ \le\ \theta+1 .$$

Compare: the three-moment cap is at least $2n\theta/(n-1)>2\theta$, and $2\theta>\theta+1$ whenever $\theta>1$, which holds at every $\theta$ of interest, since $\theta_0(n)>1$ for $n\ge6$. **The cap the third moment buys is strictly weaker than one line of Cauchy–Schwarz, at every $n\ge6$.** At $n=12$: $2.75$ against $2.24$, and against $2.13$ using the record's own Weyl eigenvalue ceiling $\approx0.89$.

So the commit's headline ("**This is real and it is new to the record), it constrains $b$, which the first two moments never touch**", is true about *which symbol appears* and false about *information added*. Nothing downstream can use a bound dominated by $\|\lambda\|_2=1$.

**Second disagreement:** this thread also re-derives a verdict the same file already carried. The section "The moment method stops at two" concludes "any sharpening must come from structure that pins eigenvalues, not from further moments", and three commits (`88ab8de`, `6fecf17`, `cd2cd1a`) then pursue further moments and rediscover that they do not bite. The out-of-sample check of $\mathop{\mathrm{tr}}(L_x^3)$ at $n=5$ is genuinely worth having; the constraint built on it is not.

---

## Answers to the brief's questions

**(a) Which is load-bearing for item 1, and does item 1 survive?** Claim 2 is load-bearing, it kills the item's named lever. **Item 1 survives intact**: (G) is a statement about global maximisers, and padded points are excluded from that population at $n\ge12$ by the padding value argument ($\theta$ invariant under padding, $\sqrt{3/2}<\theta_0(12)$). Claim 1 closes the moment family, which the plan already lists as closed by a shorter argument. Claim 3 is the only one pointing at live instrument, and its stated resolution is wrong. Claim 4 contributes nothing.

**(b) Is the fence post a theorem, a heuristic, or a restatement?** A heuristic whose sharp part is a restatement. The identity in `cd2cd1a` is correct; the inference from it is not a proof, the $n^2$ growth is an artefact of the $\sim n^4$ near-zero eigenvalues rather than a property of moment methods, and it re-encodes the record's own "needs a lower bound on $\mathop{\mathrm{mult}}(\tfrac12)$". "Every localizing order" adds nothing: orders $k\ge2$ need moments the programme does not have and argues do not exist, and the argument bounds one term of one determinant rather than any constraint.

**(c) Anything recorded as new that the record already held.** Yes, a fourth. **The gap-theorem falsification of `c96d9c0` was already in [target.md](../findings/target.md) ("Lemma L24 is exactly tight there") and [nondegeneracy.md](../findings/nondegeneracy.md) ("padded $W_{\mathbb{CP}^2}$ ... is ungraded"), covering $n=8,10,12$**, a strictly stronger scope than the $n=5$ the commit claims. Two smaller ones: the third-moment thread re-derives the file's own "the moment method stops at two" verdict; and the localizing-matrix construction is the classical truncated moment problem (Curto–Fialkow), presented without citation as a bespoke device.

## Recommended edits to the record

1. [second-order.md](../findings/second-order.md), the falsification paragraph, replace "the witness stands at $n=5$ alone" and "survives only if restricted to $n\ge12$". The witness is on record at $n=8,10,12$; the $n\ge12$ restriction does not rescue the target; the correct repair is a *support* restriction (unpadded points), and the mechanism is that gradedness is not padding-stable while the second-order spectrum is.
2. Same file, the fence post, demote to a heuristic, state the $m_0\sim n^4$ near-zero-bulk cause of the $n^2$, and delete "extended to EVERY order" or restate it as "for each fixed $k$, as $n\to\infty$, conditional on a nondegenerate limit measure and on moments $m_4,\dots,m_{2k+1}$ that are not available".
3. Same file, the third moment, record that $b\le\theta+1$ from $\|\lambda\|_2=1$ dominates the moment cap at every $n\ge6$, so the constraint is vacuous.
4. [fence-posts.md:299](../findings/fence-posts.md), "what the rule detects is primitivity of the idempotent" is **false**: $S^3\times S^3$ has $\dim E(1)=1$ hence is primitive, and the rule fails there at $31.9\%$. This is the resolution of the internal contradiction the record flags as unresolved. Correspondingly, `92f0ead`'s resolution paragraph should be rewritten: the failure certifies non-*local*-maximality at third order, and the global crossover plays no part.
5. [second-order.md](../findings/second-order.md), Peirce table, strike the $\to A(1)$ column as a forced identity $\langle x\circ y,e\rangle=\lambda\langle x,y\rangle$, and record the total-symmetry support check (which the table passes) as the gate, in place of the $L_e$ gate (which tests only the eigendecomposition).
