# REVIEW r501, Lemma L69

**Target.** Lemma L69, `findings/graded-half.md` (heading `#### Lemma L69`, line 327) through the next heading: *"above $\sqrt{3/2}$ the only equivariant graded points are sphere products with both factors $\ge 5$, and all of them are nondegenerate"*. Cited 17 times; cites no numbered result.

**Reviewer.** r501, independent, cold. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts; screening of a claim about to be recorded is permitted and is labelled as a screen.

**Phase plan.**

1. P1, read `findings/conventions.md`, then L69 verbatim.
2. P2, the classification appeal ("Weyl operator of a compact symmetric space").
3. P3, the irreducible branch and the cited $\lVert W\rVert^2 \ge \tfrac16$ theorem.
4. P4, the reducible branch: derive $f(p)+f(q)-\tfrac{n}{8(n-1)} \le \tfrac16$ and check the integer boundary at $p=4$ vs $p=5$.
5. P5, exclusion of three or more factors.
6. P6, the nondegeneracy half against Lemma L24.
7. P7, consistency of the threshold $\sqrt{3/2}$ and the range $n\ge12$.
8. P8, grep `findings/` for passages contradicting the block.

VERDICT: **PLAUSIBLE**, statement true in both halves and re-derived independently; the classification appeal is not proved where cited and its substitute is measured at $n=8,10$, outside the lemma's range. Gaps named and closed below.

---

## F1, the arithmetic core is CORRECT, and I re-derived it from scratch

*Recorded before reading the rest of the record, from the definitions plus the record's own exact rationals.*

**The family formula.** Fitting the record's four exact $n=12$ values ($\theta^2=\tfrac{176}{135},\tfrac{231}{160},\tfrac{264}{175},\tfrac{55}{36}$ for the splits $3{+}9,\dots,6{+}6$) gives

$$\theta^2(S^p\times S^q)=\frac{2(n-1)(p-1)(q-1)}{(n-2)\,pq},\qquad n=p+q.$$

It reproduces $\theta_0(n)^2=2(n-1)(n-2)/n^2$ at $p=q$ and $\theta(S^3\times S^5)=1.115547$ at $n=8$, two anchors the fit did not use.

**The norm formula, derived independently.** For a product of Einstein factors with $\mathrm{Ric}=\lambda g$, block-diagonality of $R$ on $\Lambda^2$ gives $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$, and $\lVert W\rVert^2=\lVert R\rVert^2-(\mathop{\mathrm{tr}}R)^2/N$ with $\mathop{\mathrm{tr}}R=\lambda n/2$, $N=\binom n2$. Expanding each factor's own Einstein splitting,

$$\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+\frac{\lambda^2}2\Bigl[\sum_a\frac{n_a}{n_a-1}-\frac n{n-1}\Bigr],$$

which at $\lambda=\tfrac12$ is exactly the block's $\sum_a\lVert W_a\rVert^2+B$ with $f(m)=\frac m{8(m-1)}$. **The block's $B$ is right, and the hidden normalisation is $\mathrm{Ric}=\tfrac12g$.**

**The reduction to the $\tfrac13$ inequality is exact.** $f(p)+f(q)-\frac n{8(n-1)}=\frac18\bigl[1+\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\bigr]$, so $\lVert W\rVert^2\le\tfrac16$ $\iff$ $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\tfrac13$. *The block's phrase "the $\tfrac18$ cancels" understates it (a $1$ is also absorbed on the right) but the displayed inequality is correct.*

**And it agrees with $\theta$, identically.** Writing $u=p-1,v=q-1,s=u+v=n-2,m=uv$: the $\tfrac13$ inequality is $m\ge\frac{3s(s+1)}{s+4}$, and $\theta^2=\frac{2(s+1)m}{s(m+s+1)}\ge\tfrac32$ is *the same inequality*. So the translation $\theta\ge\sqrt{3/2}\iff\lVert W\rVert^2\le\tfrac16$ is exact on this family, not merely monotone.

**The endpoints, both checked.**

| step | claim in the block | my check |
| --- | --- | --- |
| $p=2$ | LHS $>\tfrac13$ | LHS $>1$. Correct |
| $p=3$ | LHS $>\tfrac13$ | LHS $>\tfrac12$, since $\frac1{q-1}=\frac1{n-4}>\frac1{n-1}$. Correct |
| $p=4$ | reduces to $q\ge n$, impossible | exact: $\tfrac13+\frac1{q-1}-\frac1{n-1}\le\tfrac13\iff q-1\ge n-1$. Correct at every $n$ |
| $p=5$ | $\frac5{(n-6)(n-1)}\le\frac1{12}$, i.e. $n^2-7n-54\ge0$, i.e. $n\ge12$ | exact; larger root $\frac{7+\sqrt{265}}2=11.6394$. Correct |

**Verified at the two dimensions asked for.** $n=12$: $p=4$ gives $\lVert W\rVert^2=\tfrac{231}{1280}\cdot\ldots=0.17316>\tfrac16$ (equivalently $\theta^2=\tfrac{231}{160}=1.44375<\tfrac32$) (fails; $p=5$ gives $\tfrac{175}{1056}<\tfrac16=\tfrac{176}{1056}$, by exactly $\tfrac1{1056}$), passes, and this is the record's own value at [graded-half.md](../findings/graded-half.md) line 166. $n=100$: $p=4$ gives $m=285$ against the threshold $\frac{3\cdot98\cdot99}{102}=285.35$ (fails; $p=5$ gives $m=376$), passes. **So $\ge5$ is the correct integer boundary, and it is tight at $p=5$ in both directions.**

**Verdict on this half: the two-factor arithmetic is confirmed.**

---

## F2, the hidden normalisation, and the identity the block never states

**The step "the condition $\lVert W\rVert^2\le\tfrac16$" is a translation of $\theta\ge\sqrt{3/2}$, and neither the translation nor its warrant appears in the block.** The warrant exists, one file-section above: [Lemma L46](../findings/problem.md), stated at [graded-half.md](../findings/graded-half.md) as $Q(W)=\lambda W$ for a locally symmetric **Einstein** space with $\mathrm{Ric}=\lambda g$, $\lambda\ne0$, giving $\theta=\lambda/\lVert W\rVert$. At $\lambda=\tfrac12$ that is $\theta=\frac1{2\lVert W\rVert}$, so

$$\theta\ge\sqrt{3/2}\iff\lVert W\rVert^2\le\frac{\lambda^2}{3/2}=\frac16 .$$

*I found this before reading it: fitting $P(W)=\theta\lVert W\rVert^3$ across the four $n=12$ splits gives slope $0.49943$–$0.50161$ against $\lVert W\rVert^2$ and intercept $-1.2\times10^{-6}$, i.e. $P=\tfrac12\lVert W\rVert^2$, which is $Q(W)=\tfrac12W$ read off the values.*

**Three things the block therefore leaves unsaid, all true and none stated:**

1. The normalisation is $\mathrm{Ric}=\tfrac12g$. Without it the number $\tfrac16$ is meaningless, $\lVert W\rVert^2$ is not scale-invariant while $\theta$ is.
2. The Einstein hypothesis of L46 is doing real work, and a reducible symmetric space is Einstein only at one ratio of factor scales.
3. **The one-line closure of (2), which the block owes and does not give:** the Weyl tensor of $S^p(r)\times S^q(s)$ is $\mathrm{ad}(\mathfrak p)$-invariant for *every* $(r,s)$, and the $\mathrm{ad}(\mathfrak p)$-commutant inside $\mathcal W_n$ is one-dimensional, so all of them are proportional, $\theta$ does not depend on the ratio, and the Einstein representative is not a restriction. **Without this the reducible branch has a free parameter it never mentions.**

## F3, the classification appeal: NOT proved where cited, and the record's substitute is measured OUTSIDE the lemma's range

**The sentence.** *"An equivariant graded point is the Weyl operator of a compact symmetric space, so the recorded classification applies."*

**Where it is said to come from.** The block's own "What it inherits" paragraph: *"The one hypothesis that is this project's own rather than the literature's is the correspondence equivariant graded critical point $\leftrightarrow$ compact symmetric space; [Lemma L8](../findings/graded-half.md) supplies it."* **Lemma L8 does not supply it.** L8's argument, read in full at [graded-half.md](../findings/graded-half.md), takes a graded critical point on a pair as *given* and derives $\theta$ from $\dim\mathfrak k,\dim\mathfrak m$ and a Casimir ratio. It never proves that an equivariant graded point arises from a symmetric space. And L8 carries a **SCOPE REFUTED** banner of its own.

**What the record actually offers instead.** The paragraph immediately after the proof: *"The assembly's weakest joint is repaired, and it no longer needs the classification"*, the $\mathrm{ad}(\mathfrak p)$-commutant in $\mathcal W_n$ is one-dimensional, so the pair's invariant Weyl tensor is unique up to scale and *is* the sphere product's. **Its warrant, as recorded, is five measurements: $(3,5)$, $(4,4)$, $(2,6)$ at $n=8$ and $(5,5)$, $(4,6)$ at $n=10$.** Both dimensions are **outside the lemma's stated range $n\ge12$**. So the step the whole lemma turns on is, on the record, an extrapolation from two dimensions where the lemma does not apply.

**I close it analytically, for every $(p,q)$ and every $n$.** Count $\mathfrak p$-invariants of the algebraic-curvature space directly. With $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^p\oplus\Lambda^2\mathbb R^q\oplus(\mathbb R^p\otimes\mathbb R^q)$ as $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$-modules:

| step | count, $p,q\ge2$, $p,q\ne4$ | at $p=4$ | at $p=q=4$ |
| --- | --- | --- | --- |
| $\dim(S^2\Lambda^2)^{\mathfrak p}$, Schur, one per irreducible summand, none across | $3$ | $4$ ($\Lambda^2\mathbb R^4$ splits) | $5$ |
| less first Bianchi: $\dim(\Lambda^4)^{\mathfrak p}$ | $0$ | $1$ ($\Lambda^4\mathbb R^4$) | $2$ |
| less Ricci-flatness: $\dim(S^2\mathbb R^n)^{\mathfrak p}=2$, and the map is onto | $2$ | $2$ | $2$ |
| **commutant in $\mathcal W_n$** | $\mathbf 1$ | $\mathbf 1$ | $\mathbf 1$ |

The three generators are the Kulkarni–Nomizu tensors $g_p\owedge g_p,\ g_q\owedge g_q,\ g_p\owedge g_q$; surjectivity of Ricci is immediate since $\mathrm{Ric}(g_p\owedge g_p)\propto g_p$ and $\mathrm{Ric}(g_q\owedge g_q)\propto g_q$. **This reproduces the record's measured $1$ at all five tested pairs, including $(4,4)$ and $(2,6)$, and extends it to every $n$.** The same count at $\mathfrak u(m)$, three summands $\mathbb R\omega,\ \mathfrak{su}(m)$-part, $[\Lambda^{2,0}]_{\mathbb R}$; $\dim(\Lambda^4)^{U(m)}=1$ from $\omega\wedge\omega$; one Ricci condition, also gives $1$, which is the block's $\mathbb{CP}^m$.

**And $p=1$, which the block's inequality cannot even evaluate ($f(1)=\infty$), is genuinely empty:** for $\mathfrak p=\mathfrak{so}(n-1)$ the invariant Bianchi tensors are $\mathrm{span}\{g'\owedge g',\ g_1\owedge g'\}$, and Ricci-flatness forces both coefficients to zero. **The commutant is $0$, so no equivariant point exists there at all**, the flat-factor case is excluded by absence, not by the inequality.

**Consequence.** With the commutant fact proved, the correspondence follows and the symmetric-space classification is unnecessary: the $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ for $n\ge9$ are exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$ (the block's own table, with $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$, $n\ne8$), each carries a one-dimensional commutant, and $Q$ preserves it, so **every equivariant graded point is automatically critical, and is $S^p\times S^q$ or $\mathbb{CP}^{n/2}$.** *The gap is closable and I have closed it; what stands is that the block does not close it and cites a lemma that does not.*

## F4, the irreducible branch is sound, with one fencepost worth naming

The cited theorem exists and says what is claimed: [graded-half.md](../findings/graded-half.md) line 90, *"On every compact irreducible symmetric space, $\lVert W\rVert^2\ge\tfrac16$, with equality exactly at $\mathbb{CP}^2$. Equivalently $\theta\le\sqrt{3/2}$"*, this is [Lemma L47](../findings/problem.md). I checked its own derivation:

- $\lVert W\rVert^2=\lVert R\rVert^2-(\mathop{\mathrm{tr}}R)^2/N$ with $\mathop{\mathrm{tr}}R=n/4$, $N=\binom n2$ gives the subtracted constant $\frac n{8(n-1)}$, **correct**.
- Cauchy–Schwarz $\sum_id_i\lambda_i^2\ge(n/4)^2/\dim\mathfrak h$ then yields $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\tfrac16$, I re-derived the threshold and it is **exact**.
- The residue is the compact rank-one spaces, and that list ($S^n$, $\mathbb{RP}^n$, $\mathbb{CP}^m$, $\mathbb{HP}^m$, $\mathbb{OP}^2$) is **complete**; each is disposed of.

**The fencepost.** L69's hypothesis is $\theta\ge\sqrt{3/2}$, non-strict, and the proof discharges it with *"no irreducible space **exceeds** the threshold"*, the wrong relation. The equality case $\mathbb{CP}^2$ satisfies $\theta\ge\sqrt{3/2}$ and is irreducible, so the sentence as written admits it. **It is harmless only because $\mathbb{CP}^2$ has $n=4$**, outside the range. *The block should say "equality only at $n=4$", not "exceeds".*

**Equality is proved, not observed.** The certificates are named, all-nonnegative-coefficient polynomial certificates with strictly positive constant terms ($616,48,7200,114,3696,2192,236,84$), *"which is what rules out a second equality case"*, so the "only at $\mathbb{CP}^2$" is earned rather than tabulated.

## F5, three or more factors ARE excluded, but NOT by the reason the proof gives

**The proof's reason is a non-sequitur.** It says $B$ is *"minimised at $k=2$ balanced"*, and concludes *"so above the threshold every factor is a sphere and $k=2$"*. **A global minimum at $k=2$ says nothing about whether some $k=3$ partition also sits below $\tfrac16$.** The premise and the conclusion are about different things.

**The true reason is the additive $k$, and it is decisive.** Since $f(m)=\tfrac18(1+\frac1{m-1})$,

$$\lVert W\rVert^2=\frac18\Bigl[k+\sum_a\frac1{n_a-1}-\frac n{n-1}\Bigr]>\frac18\Bigl[k-1-\frac1{n-1}\Bigr],$$

so at $k=3$ and $n\ge12$, $\lVert W\rVert^2>\frac18(2-\tfrac1{11})=0.2386>\tfrac16$, and it only grows with $k$. **Screened** over every partition with $k\ge3$ and $12\le n<60$: the minimum is $\tfrac{5315}{19836}=0.2679$ at $(19,20,20)$, against $\tfrac16=0.1667$, a factor of $1.6$, never close. *The conclusion stands; the sentence that reaches it does not.*

## F6, the nondegeneracy half: correct, cited to the WRONG FILE, and contradicted 20 lines from its own proof

**The theorem is not in [fence-posts.md](../findings/fence-posts.md).** L69 cites *"the unconditional nondegeneracy theorem of [fence-posts.md]"* and, in the same sentence, attributes the $\tfrac1{2(M-1)}$ gap and the $0.292$ family-B figure to that file too. Grepping [fence-posts.md](../findings/fence-posts.md) for "Morse" returns three hits, none of them a theorem, two are the excess-$0$ fence post, one a routing remark. **The theorem is [Lemma L11](../findings/nondegeneracy.md) / [L26](../findings/nondegeneracy.md) / [L27](../findings/nondegeneracy.md) in [nondegeneracy.md](../findings/nondegeneracy.md)**, and the $\tfrac1{2(M-1)}$ correction is at [nondegeneracy.md](../findings/nondegeneracy.md) under the "Hence, unconditionally" heading. **Three misdirected references in one sentence.**

**A fourth misdescription.** "What it inherits" says *"the nondegeneracy theorem is unconditional, by a symbolic solve over all $45$ summand pairs."* The 45-pair symbolic solve is the **family-B** statement, that $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ has $(3,3)$ as its only $p,q\ge3$ coincidence. **The nondegeneracy theorem rests on something else**: Nienhaus Prop 4.6's ten-summand isotypic decomposition, multiplicity-freeness, Schur making $L_e$ scalar on each summand, and index proofs for the individual values. That distinction matters, because [nondegeneracy.md](../findings/nondegeneracy.md) itself warns that *"an exhibited eigenvector bounds $\lambda_{\max}$ from below … the statements nondegeneracy needs are upper bounds on the rest of the spectrum, and no exhibited eigenvector supplies those."*

**The mathematics itself is right, and it is the right shape for L69's claim.** The brief is correct that $\lambda_{\max}\le\tfrac12$ and the orbit directions being $\tfrac12$-eigenvectors are both automatic ([Lemma L24](../findings/second-order.md)), so the content is *exactly*. That is what the isotypic route proves: $L_e$ is a scalar on each of the ten summands, the values are $1$ on $\langle W\rangle$, $0$ on $\mathrm{Weyl}_p,\mathrm{Weyl}_q,X_p\otimes\mathbb R^q,X_q\otimes\mathbb R^p$, $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ (the orbit tangent, $\dim=pq=\binom n2-\binom p2-\binom q2$), $\pm\mu$ on $\Lambda^2\otimes\Lambda^2$ and $S^2_0\otimes S^2_0$, and $\frac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$. Since $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ off $(3,3)$ and $\frac{m-2}{2(m-1)}<\tfrac12$ always, **$\tfrac12$ is attained on the orbit tangent alone**, an upper bound on the whole spectrum, which is what "exactly" needs. And $p,q\ge5$ clears both exceptional families ($(3,3)$ and $\min(p,q)=2$). **The gap figure is right too**: $\tfrac12-\lambda_2=\frac1{2(M-1)}$ is $\tfrac1{12}$ at $M=7$, i.e. at $S^5\times S^7$.

> ### F6a, A LIVE UNRECONCILED CONTRADICTION, on exactly the case L69 needs
>
> [nondegeneracy.md](../findings/nondegeneracy.md)'s section **"What is owed"**, roughly twenty lines below the heading *"Hence, unconditionally: for $p,q\ge3$ with $(p,q)\ne(3,3)$ … $S^p\times S^q$ is Morse–Bott nondegenerate"*, reads:
>
> > *"Nondegeneracy is verified at $n=8,10$ across the full classification and at $n=12$ across every two-block split … **it is not proven for the unbalanced splits** or for $\mathbb{CP}^m$ at general $n$."*
>
> **$S^5\times S^7$ is an unbalanced split, and it is L69's own headline example**, the point the block quotes for the $\tfrac1{12}$ gap and the point [graded-half.md](../findings/graded-half.md) line 289 uses to refute the C3 uniqueness premise. So the record simultaneously asserts and denies the case L69 consumes. **On my reading the "unconditionally" heading is right and "What is owed" is stale** (the isotypic argument is uniform in $p,q$ and never restricts to balanced splits), **but the record does not say so, and a reader following the citation lands on the denial.**

## F7, the threshold and the range

**No parity is needed anywhere.** $\mathfrak u(n/2)$ exists only at even $n$ and is excluded by value there ($\theta(\mathbb{CP}^m)=0.924962$ at $m=6$, strictly decreasing to $\sqrt{2/3}$); at odd $n$ the enumeration is only $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$. The two-factor arithmetic, the $k\ge3$ exclusion and the nondegeneracy theorem are all parity-blind. **Checked and clean.**

**$n\ge12$ is NOT what the argument needs.** Tracing each dimension hypothesis:

| step | what it actually needs |
| --- | --- |
| $p,q\ge5$ from the $\tfrac13$ inequality | nothing, $p\le4$ fails at **every** $n$ |
| exclude irreducible spaces | $n\ne4$, so that $\mathbb{CP}^2$ is out of range |
| completeness of the $\mathbb Z_2$-grading list | $n\ge5$ and $n\ne8$ (triality) |
| nondegeneracy | $p,q\ge3$, $(p,q)\ne(3,3)$, implied by $p,q\ge5$ |

**So $n\ge9$ suffices, and at $n=9,10,11$ the lemma is vacuously true** (no split with $p,q\ge5$ clears the threshold: at $(5,5)$, $n=10$, the LHS is $0.3889>\tfrac13$). The stated $n\ge12$ is a safe over-restriction. *What $n\ge12$ is genuinely the threshold for is **non-emptiness** (that some split clears at all) which is the block's own $n^2-7n-54\ge0$ and is a different statement from the lemma's.*

**One bookkeeping slip.** The block calls $n^2-7n-54\ge0$ *"the threshold dimension of the conjecture itself, appearing here for the fourth independent time"*. The polynomial that appears elsewhere in this file three and four times is $n^2-12n+8$, with root $6+2\sqrt7=11.2915$; $n^2-7n-54$ has root $\frac{7+\sqrt{265}}2=11.6394$. **Different polynomials, same integer floor.** The coincidence is in the ceiling of the root, not in the algebra, and the sentence reads as if it were the same object.

## F8, a second live contradiction, this one inside [graded-half.md](../findings/graded-half.md) itself

| line | says |
| --- | --- |
| [graded-half.md](../findings/graded-half.md) line 303 | *"on a graded point $\Delta=0$ **iff** $W$ is $\mathrm{ad}(\mathfrak p)$-equivariant. So every graded critical point is either equivariant, where Lemma L69 applies …"* |
| [graded-half.md](../findings/graded-half.md) line 353 | *"$\Delta=0\Rightarrow$ Lemma L69 applies", **UNSOUND off $\ker W=0$***, because $\Delta$ is traced over $\{\lambda>0\}$ only and padded $W_{\mathbb{CP}^2}$ has $\Delta=0$ vacuously while being equivariant for no symmetric subalgebra |

**Fifty lines apart, in one file, and the second is the audit of the first.** L69 itself is untouched (it takes equivariance as a hypothesis, not $\Delta=0$) but **the C3 split at line 303 is the record's main consumer of L69, and it reaches L69 through the inference line 353 rejects.** The repair is one clause: line 303's dichotomy needs $\ker W=0$ attached, which is [conventions.md](../findings/conventions.md)'s [W3](../findings/INDEX-traps.md) trap restated.


## F9, two consumer readings, both checked, both licensed

- **[graded-half.md](../findings/graded-half.md) line 289: *"Lemma L69 makes each sphere product with both factors $\ge5$ a local maximum."*** L69 says *nondegenerate*, not *local maximum*, so this is an upgrade, **and it is licensed.** By [Lemma L24](../findings/second-order.md) the Hessian on the sphere is $6\theta(L_e-\tfrac12\mathrm{Id})$; with $\tfrac12$ attained on the orbit tangent alone, every transverse direction has $\lambda<\tfrac12$ and strictly negative second variation, so the point is a strict local maximum modulo the orbit. *No third-order argument is needed, and the C3 warning that "a $\tfrac12$-direction leaves the sign to third order" does not bite, because there are no $\tfrac12$-directions off the orbit.*
- **[graded-half.md](../findings/graded-half.md) line 303 states the classification as an *"exactly"*, where L69's own statement is only one direction.** The converse holds: **screened over every split at every $12\le n\le300$, $\theta\ge\sqrt{3/2}\iff p,q\ge5$, with no exception.** *(Analytically: for $n\ge12$ and $p,q\ge5$ the worst case is $(5,7)$ at $0.32576<\tfrac13$; $(5,5)$ would need $n=10$.)* So the stronger reading is correct and L69 could be stated as a biconditional.

---

## Screens run

*Permitted screening only, seconds of exact rational arithmetic on objects I constructed, reported as screens and never as evidence for a positive claim. The positive claims above are the derivations; these confirm I did not slip.*

| screen | result |
| --- | --- |
| $\theta^2(p,q)$ formula against the record's four exact $n=12$ rationals | all four reproduced exactly |
| against $\theta_0(n)^2$ at $n=8,12,14$ and $\theta(S^3\times S^5)$ | $\tfrac{21}{16},\tfrac{55}{36},\tfrac{78}{49}$ and $1.1155467020$, exact |
| $\theta^2\ge\tfrac32\iff\lVert W\rVert^2\le\tfrac16$, all splits, $5\le n<200$ | $0$ disagreements |
| $\theta^2\ge\tfrac32\iff p,q\ge5$, all splits, $12\le n\le300$ | $0$ disagreements |
| $\min\lVert W\rVert^2$ over all $k\ge3$ partitions, $12\le n<60$ | $\tfrac{5315}{19836}=0.2679$ at $(19,20,20)$, against $\tfrac16$ |

## What would settle what is left open

Nothing here needs a computation. **The three repairs are all one to three lines of prose**, and I have supplied the mathematics for each above: the commutant count (F3), the $k\ge3$ inequality (F5), and the four corrected citations (F6). The two contradictions (F6a, F8) are decisions the record's owner must make, not calculations.

---

## VERDICT: PLAUSIBLE

**The statement is true in both halves, and I believe it is proved, but not by the proof as recorded.** I re-derived every quantitative step independently and found no error in any of them; what fails is the warrant behind three of the proof's sentences.

**What is confirmed.**

- The two-factor arithmetic, endpoint for endpoint. $p\le4$ fails at every $n$; $p=5$ survives exactly when $n^2-7n-54\ge0$, i.e. $n\ge12$. The reduction of $\lVert W\rVert^2\le\tfrac16$ to $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\tfrac13$ is exact, and so is its equivalence to $\theta\ge\sqrt{3/2}$, the same inequality $uv\ge\frac{3s(s+1)}{s+4}$ twice. **(F1)**
- The irreducible branch. The cited $\lVert W\rVert^2\ge\tfrac16$ theorem exists, says what is claimed, covers every compact irreducible symmetric space at every $n$, and its equality case is proved rather than tabulated. **(F4)**
- The nondegeneracy half. $\lambda_{\max}=\tfrac12$ attained **exactly** on the orbit tangent is what the isotypic-decomposition argument proves (an upper bound on the whole spectrum, which is the direction the word "exactly" needs) and $p,q\ge5$ clears both exceptional families. The $\tfrac1{2(M-1)}$ gap is right. **(F6)**
- Threshold and range are used consistently, no parity is smuggled in, and the conclusion in fact holds from $n\ge9$. **(F7)**

**The gaps, in descending order of weight.**

1. **The load-bearing opening sentence is not proved where it is cited.** [Lemma L8](../findings/graded-half.md) does not supply the correspondence "equivariant graded point $\Rightarrow$ Weyl operator of a compact symmetric space", and carries a scope refutation of its own. The record's substitute (the one-dimensional $\mathrm{ad}(\mathfrak p)$-commutant), is warranted by **five measurements at $n=8$ and $n=10$, both outside the lemma's range $n\ge12$**. *I close it analytically for every $(p,q)$ and every $n$ by a $3-0-2$ invariant count, and separately show $p=1$ carries no equivariant point at all.* **(F3)**
2. **"$B$ minimised at $k=2$ balanced, so $k=2$" is a non-sequitur.** The correct exclusion is $\lVert W\rVert^2>\frac18(k-1-\frac1{n-1})>\tfrac16$ for $k\ge3$, which the block never writes. **(F5)**
3. **Four misdirected or misdescribed citations in the nondegeneracy paragraph**, three of them pointing at [fence-posts.md](../findings/fence-posts.md) for a theorem that lives in [nondegeneracy.md](../findings/nondegeneracy.md), and one attributing the theorem to a $45$-pair symbolic solve that establishes a different statement. **(F6)**
4. **The Einstein normalisation $\mathrm{Ric}=\tfrac12g$ and the identity $\theta=\lambda/\lVert W\rVert$ are both unstated**, and without them the constant $\tfrac16$ has no meaning. **(F2)**
5. **Two live unreconciled contradictions in the record**, one against the exact case L69 needs. **(F6a, F8)**
6. **One fencepost**: the proof discharges a non-strict hypothesis with a strict inequality, saved only by $\mathbb{CP}^2$ having $n=4$. **(F4)**

*Not REFUTED: I found no false claim in the block and no witness against it. Not CONFIRMED: the sentence the brief correctly identifies as load-bearing is asserted, its stated source does not prove it, and its substitute is measured at dimensions the lemma excludes.*
