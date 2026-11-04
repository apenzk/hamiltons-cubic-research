# Review r500, Lemma L57, "the diagonal theorem, all $n$, both parities"

**Target:** `findings/problem.md`, `#### Lemma L57` block (around line 499) down to the next heading.
**Reviewer:** r500, cold read, independent of r499 (parallel audit of the same target).
**Footing:** analysis only. No searches, sweeps, censuses or falsifier hunts. Screening only where it settles a claim I am about to record, and labelled as screening.

## Phase plan

1. Locate the L57 block and the "What remains owed: steps 1 and 3 as proofs" section; settle whether a complete proof of L57 exists anywhere in the record.
2. Cross-check both $\Theta_n^2$ formulas against `findings/conventions.md`, including the square-root trap.
3. Evaluate at $n=4,5,6$ by hand; check the claimed maximisers attain the claimed values.
4. Audit the domain $\mathcal D_n$ against the claimed correspondence with coordinate-diagonal Weyl operators; check normalisation and homogeneity.
5. Audit the uniqueness claim and the symmetry group quotiented by.
6. Consistency across `findings/` and `results.md`, including the word "proven" at `results.md` line 12.

VERDICT: CONFIRMED, see the verdict section at the foot of this file.

---

## Finding 1 (the risk in the brief), the pointer is stale, but a proof does exist; it is scattered across four sections and the L57 block names only one

The brief's worry is that "What remains owed: steps 1 and 3 as proofs" is where an argument is owed. **On this record it is not.** That section was written when the two steps were open and has since been overwritten in place with the closure of step 3, keeping its old title. `findings/problem.md` is chronological, so the discharge of step 1 sits *after* it, under a different heading.

Where each step actually lives in [problem.md](../findings/problem.md):

| step | statement | where its proof is | status |
| --- | --- | --- | --- |
| chain setup, steps 1–3 stated | line 232, "CANDIDATE: an elementary diagonal theorem…" |, | statement + screens only |
| **step 2** ($Z(v)$ is the orthogonal projection of $(v_iv_j)$ onto $\mathcal D_n$, and its norm) | line 244, "Step 2 is now PROVED here, both halves" | **proved**, and I reproduced both halves | proved |
| **step 3** (the parity-sensitive fourth-moment bound) | line 299, the misleadingly-titled "What remains owed" section | **proved twice** (Gate 2, reviewers 123 and 124); I reproduced Proof I in full | proved |
| **step 1** ($\lambda\le\frac{n-1}{n}\mu$) | line 343, "Step 1 is PROVED, and it IS the record's own Dirichlet inequality" | **proved**; I reproduced it | proved |
| even equality case | line 244 (c) | proved structurally at line 336, bullet 3 | proved |
| odd equality case | line 287, "(d) The ODD equality case…" | proved (three-value ratio identity), plus the 1-dimensionality argument at line 336 | proved |
| the criticality equation itself, $S^{\circ2}+S^2=\lambda S+D$ | [diagonal-half.md](../findings/diagonal-half.md) lines 69–78 | **proved**, the Ricci-flatness multiplier $v_i+v_j$ is shown to vanish | proved |

**So: nothing is owed as a proof.** The answer to the brief's first question is that the pointer is wrong, not that the argument is missing. But the pointer is wrong in a way that would defeat a reader: it sends them to the one section that carries step 3 and calls itself "what remains owed", and it never names the sections holding steps 1 and 2 or the criticality equation.

**Repair (one sentence):** replace the pointer with "the argument is in this file under *Step 2 is now PROVED here*, *What remains owed: steps 1 and 3 as proofs* (which now closes step 3), *(d) The ODD equality case*, and *Step 1 is PROVED*; the criticality equation it starts from is proved in [diagonal-half.md](diagonal-half.md)". And retitle the line-299 section, whose title is now false.

## Finding 2, I re-derived the whole chain cold. The mathematics is correct.

Working only from the definitions, at a maximiser $S$ of $P$ on the unit sphere of $\mathcal D_n$:

- **The criticality equation.** For $S\in\mathcal D_n$, $Q(S)=S^{\circ2}+S^2$ has $\sum_{j\ne i}Q(S)_{ij}=r_i-r_i=0$ with $r_i=\sum_j s_{ij}^2$, because $S\mathbf1=0$ forces $S^2\mathbf1=0$ and $(S^2)_{ii}=r_i$. So the *hollow* part of $Q(S)$ already lies in $\mathcal D_n$, and the projection onto $\mathcal D_n$ costs only a diagonal. That is why the multiplier for the row-sum constraint is absent, and it is what [diagonal-half.md](../findings/diagonal-half.md) line 75 proves by its own route. **Confirmed.**
- **Step 1.** Pairing with $v\otimes v$ gives $\lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$ exactly as printed; $\sum_{i<j}s_{ij}(v_i-v_j)^2=-\mu$ and $\sum_{i<j}(v_i-v_j)^2=n$ both follow from $S\mathbf1=0$, $\sum v=0$, $\sum v^2=1$; Cauchy–Schwarz gives $\sum_{i<j}s^2(v_i-v_j)^2\ge\mu^2/n$ and hence $\lambda\le\frac{n-1}{n}\mu$. The hypothesis $v\perp\mathbf1$ is free: $S\mathbf1=0$ and $\mu>0$ (trace-free, nonzero), so the top eigenvector is orthogonal to $\mathbf1$. **Confirmed, every line.**
- **Step 2.** $Z(v)\in\mathcal D_n$ and the residual $a_i+a_j+c$ is orthogonal to $\mathcal D_n$: both reproduce. **Confirmed.**
- **The norm formula.** I computed $\sum_{i\ne j}Z_{ij}^2=\frac{n^2-3n+3}{(n-1)(n-2)}-\frac{n\sum v^4}{n-2}$ from scratch. The record's $\lvert Z\rvert^2$ is **exactly half** of this, see Finding 4 on what that means.
- **Step 3.** Lagrange gives at most three values with zero sum; Lemma A ($t_1+t_2+t_3=0\Rightarrow\sum t^4=\tfrac12(\sum t^2)^2$) follows from Newton with $e_1=0$; the circle-replacement argument is valid for $n\ge4$ and forces at most two values; the two-value closed form is $\sum v^4=\frac{n}{pq}-\frac3n$, giving $\frac1n$ at even $n$ and $\frac{n^2+3}{n(n^2-1)}$ at odd $n$. **Confirmed, including the closed form, which I re-derived.**
- **The chain closes on the printed constants.** With $\lvert Z\rvert^2_{\max}=\frac{n-2}{2(n-1)}$ (even) and $\frac{n^2(n-3)}{2(n-2)(n^2-1)}$ (odd), $\big(\frac{n-1}{n}\big)^2\cdot4\lvert Z\rvert^2_{\max}$ gives **exactly** $\frac{2(n-1)(n-2)}{n^2}$ and $\frac{2(n-1)(n-3)}{(n+1)(n-2)}$. **Confirmed symbolically in $n$, both parities.**

## Finding 3, the two formulas agree with `conventions.md`, and the odd numbers reproduce

[conventions.md](../findings/conventions.md) line 18 now reads $\Theta_n=\theta_0(n)$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, the square root is present, and it **agrees with the L57 block**, which states the squares. Squaring is handled consistently in both places.

- $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is the same expression as the even $\Theta_n^2$, so "at even $n$, $\Theta_n=\theta_0(n)$" is an identity of the two printed formulas. **Confirmed.**
- $\Theta_{13}=1.2483756$ against $\theta_0(13)=1.2498521$: reproduces [r474](REVIEW_r474.md)'s gap of $0.0014765$, and $\Theta_n<\theta_0(n)$ at odd $n$, which is the direction the corrected row needs.
- The odd squares at $n=11,13,15$ are $\tfrac{160}{108}=\tfrac{40}{27}$, $\tfrac{240}{154}=\tfrac{120}{77}$, $\tfrac{336}{208}=\tfrac{21}{13}$, the block's claimed agreement with Reviewer 89. **Confirmed.**

## Finding 4, the normalisation is right, but the block states it in a form the record's own conventions read the wrong way

The chain reproduces the printed constants **only** under $\lvert S\rvert^2:=\sum_{i<j}S_{ij}^2=1$, equivalently $\mathop{\mathrm{tr}}S^2=2$. That is the record's normalisation, [diagonal-half.md](../findings/diagonal-half.md) line 27 fixes $\mathop{\mathrm{tr}}M^2=2$, and its line 71 contraction $2\theta=\langle M^{\circ2}+M^2,M\rangle$ is consistent with it only at $\mathop{\mathrm{tr}}M^2=2$. So **the theorem's constants are correct**.

The defect is in how the block says it. The line-232 block writes only "**with $\lvert S\rvert=1$**", and $S$ there is the $n\times n$ matrix. [conventions.md](../findings/conventions.md) fixes "plain Frobenius on the pair matrix" and "sums over pairs are over **ordered** pairs unless the line says otherwise", read that way, $\lvert S\rvert=1$ means $\mathop{\mathrm{tr}}S^2=1$ and **the chain then delivers $\Theta_n/\sqrt2$**. This is precisely the $\sqrt2$ trap conventions.md says "has cost a cycle", and [post 53](../findings/INDEX-traps.md) names the same $\sum\lambda^2=2$ versus $1$ collision as having already produced one false claim.

**Repair:** write $\mathop{\mathrm{tr}}S^2=2$, or $\sum_{i<j}S_{ij}^2=1$, in the line-232 block. The [results.md](../results.md) version of L57 is better (it says "$\lVert M\rVert$ normalised to $\lVert W\rVert=1$") and the L57 block in [problem.md](../findings/problem.md) states no normalisation on $\mathcal D_n$ at all, relying on the $\lVert W\rVert^3$ on the right.

**Homogeneity: correct as written.** $Q$ is quadratic, so $\langle Q(W),W\rangle$ is homogeneous of degree $3$, matching $\Theta_n\lVert W\rVert^3$. The inequality is therefore scale-free and the unit-norm reduction is legitimate.

## Finding 5, the domain claim is true, and its proof is nowhere in the record

"$\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf1=0\}$ **are** the vertex matrices of coordinate-diagonal Weyl operators" is a **bijection**, and I verified it from the definitions:

- **Every hollow symmetric $w$ gives an algebraic curvature operator.** For $W(e_a\wedge e_b)=w_{ab}\,e_a\wedge e_b$, $R_{abcd}$ is nonzero only when $\{a,b\}=\{c,d\}$. First Bianchi $R_{abcd}+R_{acdb}+R_{adbc}=0$ then holds term-by-term: with four distinct indices every term vanishes, and with three distinct indices each term needs a repeated pair that the distinctness forbids. **So Bianchi is automatic on the coordinate-diagonal locus**, which is exactly why this locus is elementary.
- **Weyl $\iff$ zero row sums.** $\mathop{\mathrm{Ric}}_{ac}=\sum_bR_{abcb}$ vanishes off-diagonal automatically and equals $\sum_{b\ne a}w_{ab}$ on the diagonal. Ricci-flat is the row-sum condition, as [diagonal-half.md](../findings/diagonal-half.md) line 15 says.
- Conversely a coordinate-diagonal Weyl operator has a hollow symmetric zero-row-sum $w$ by construction.

**So the theorem is about the right set.** But the Bianchi half is asserted in the record and proved nowhere I can find, it is the step that makes the whole locus admissible, and it costs two lines. **Owed: write it down.**

## Finding 6, the equality cases attain the claimed values, checked by hand at $n=4,5,6$, and I can give the record a closed form it does not have

I computed $\theta$ at $S^p\times S^q$ **symbolically in $n,p,q$**, from the criticality equation rather than numerically. With $V$ the block-constant vertex matrix (cross value $1$, within-block values $-q/(p-1)$ and $-p/(q-1)$ forced by zero row sums):

$$\lambda_V=1-n\ \text{(independent of the split)},\qquad \textstyle\sum_{i<j}V_{ij}^2=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)},$$

$$\boxed{\;\theta\big(S^p\times S^q\big)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)\,pq}\;}$$

- $p=q=n/2$ gives $\frac{2(n-1)(n-2)}{n^2}$, **the even $\Theta_n^2$, exactly.**
- $p=\frac{n-1}2,\ q=\frac{n+1}2$ gives $\frac{2(n-1)(n-3)}{(n-2)(n+1)}$, **the odd $\Theta_n^2$, exactly.**
- $(1-\tfrac1p)(1-\tfrac1q)$ is maximised at the balanced split, so the *claimed* maximiser is the best sphere product at every $n$, which the record had only as "unbalanced products fall short monotonically toward balance", measured.

**This replaces the record's numerical attainment check ("checked at ten products", "verified as $-1.5,-4/3,-1.25,-1.2$ at $n=6,8,10,12$") with a proof, at every $n$ and both parities.** It is a derivation, not a computation, and the record should carry it.

Spot checks I did independently of that formula:

| $n$ | route | value | $\Theta_n$ | agrees |
| --- | --- | --- | --- | --- |
| $4$ | the raw graph functional: $\mathcal D_4$ is $2$-dimensional in the matching basis $(a,b,c)$, $a+b+c=0$, $2(a^2+b^2+c^2)=1$, and $\theta=6(a^3+b^3+c^3)+12abc=18abc$; maximised at a double root, $abc=\frac1{12\sqrt3}$ | $\frac{\sqrt3}2=0.8660254$ | $\sqrt{3/4}$ | yes, and the maximiser is $b=c$, i.e. **$S^2\times S^2$, unique up to permutation** |
| $5$ | criticality of the three-value $V=(-3,-1,1)$ for $S^2\times S^3$; verified at all three pair types | $\frac{2\sqrt2}3=0.9428090$ | $\sqrt{8/9}$ | yes; top eigenvector $\propto(3,3,-2,-2,-2)$ has $\sum v^4=\frac7{30}=\frac{n^2+3}{n(n^2-1)}$ **exactly**, so step 3 is tight there |
| $6$ | the raw graph functional at $S^3\times S^3$ ($w=\frac16$ within, $-\frac19$ across, renormalised): $\theta=c^3\cdot\frac{25}{162}$, $c=\sqrt{18/5}$ | $\frac{\sqrt{10}}3=1.0540926$ | $\sqrt{10/9}$ | yes; and $\frac{n-1}{n}\mu_1=\frac56\cdot1.2649111=1.0540926$, so **step 1 is an equality there** |

**The $n=6$ row also confirms the normalisation independently**, since it runs from the curvature-side functional $\theta=\sum_{a<b}w^3+3\sum_{a<b<c}w\,w\,w$ with $\sum_{a<b}w^2=1$ and never touches the chain.

## Finding 7, the sign of the maximiser, and a uniqueness range that contradicts the block

**The sign.** L57 says equality "at $S^{n/2}\times S^{n/2}$". The file's own corrections section says the equality case is $S=-V/\lVert V\rVert$, because $Z(v)$ is a **negative** multiple of the vertex matrix and $P$ is an odd cubic. My computations agree and extend it to even $n$: with the record's parametrisation of $V$ (cross value $+1$), $\lambda_V=1-n<0$, so $+V$ sits at $-\Theta_n$ and the maximiser is $-V$, the weight positive *within* blocks and negative *across*, which is the sign [diagonal-half.md](../findings/diagonal-half.md) line 19 already uses. **No mathematical error, but the L57 block names a matrix whose stated sign is the minimiser under the record's own $V$ convention.** One clause fixes it.

**Uniqueness.** L57's "with equality exactly at" quotes no symmetry group. The completion sentence at [problem.md](../findings/problem.md) line 376 does: "**up to sign and permutation, uniquely for $n\ge5$**". Two problems.

- The group is **sign $\times$ coordinate permutation** ($\pm1\times S_n$, the symmetries of the functional on $\mathcal D_n$), and the L57 block should say so, "exactly at" without a quotient is literally false, since permuting the two blocks gives a different matrix.
- **"uniquely for $n\ge5$" excludes $n=4$, which is in L57's range, and uniqueness does hold at $n=4$.** The $n\ge5$ restriction comes from the corrections' note "*Odd uniqueness needs $n\ge5$*", whose real content is that $n=3$ fails; it was then applied to all parities. My $n=4$ computation above settles it: the maximiser of $18abc$ on $\{a+b+c=0,\ a^2+b^2+c^2=\frac12\}$ is the double root, unique up to which of the three perfect matchings is the odd one, and that is exactly the three ways to split $4$ into $2+2$, i.e. uniqueness up to permutation. **So L57's range $n\ge4$ is right and line 376's $n\ge5$ is needlessly weak; the two lines disagree and one of them is wrong.**

**Does the record *prove* uniqueness or only exhibit the maximiser?** It proves it, and by a good argument: equality forces the $4$th-moment minimiser $v$ (two-valued with balanced multiplicities, by step 3's Proof I, which rules out three-valued minimisers) and $S\parallel Z(v)$; and block-constant elements of $\mathcal D_n$ form a **one-dimensional** space, so $Z(v)$ *must* be proportional to the sphere product's vertex matrix. That last step, at [problem.md](../findings/problem.md) line 336 bullet 3, is the one that turns "exhibits" into "proves", and it is correct. **Confirmed.**

## Finding 8, the one link the chain never states: from "at a critical point" to "for every diagonal $W$"

L57 is a bound at **every** diagonal $W$. The chain bounds $\lambda$, the multiplier at a critical point of $P$ restricted to $\mathcal D_n$. The bridge is: $P$ is continuous on the compact unit sphere of $\mathcal D_n$, so its maximum is attained; a maximiser satisfies the constrained Euler–Lagrange equation; and contracting that equation with $S$ gives $\lambda=P(S)$, so the largest critical value **is** the maximum. Homogeneity then gives the $\lVert W\rVert^3$ form.

**Every ingredient is somewhere in the record, and the chain assembles none of them.** [diagonal-half.md](../findings/diagonal-half.md) line 64 derives the constrained Euler–Lagrange equation and line 71 contracts it to $2\theta=\langle M^{\circ2}+M^2,M\rangle$, which is $\lambda=\theta$ at $\mathop{\mathrm{tr}}M^2=2$; [problem.md](../findings/problem.md) line 21 states "every maximizer is critical", but about Jäger's theorem, seventy lines before the chain and never referred back to. **Owed: one sentence in the L57 block.** This is the difference between a bound on a critical value and the bound L57 states, and a cold reader is entitled to see it.

## Finding 9, consistency, and the two labelling questions

**Consistency across the record: clean.** I grepped [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md) and [routes.md](../routes.md) for the two formulas.

- Nothing states a different $\Theta_n$. [bispectral.md](../findings/bispectral.md) line 287's table, $0.9428090,\ 1.0954451,\ 1.1710801,\ 1.2171612,\ 1.2483756,\ 1.3288665$, is the odd formula at $n=5,7,9,11,13,25$; I checked every entry.
- Nothing states a different equality case or a different range. [results.md](../results.md) line 268's block and the L57 block agree; results.md's is the better-stated of the two (it names the frame, the normalisation, and the scope limit "it does not reach any $W$ that is diagonal in no frame").
- The **one** disagreement is the uniqueness range, [INDEX.md](../findings/INDEX.md) line 28 and [problem.md](../findings/problem.md) line 376 both say "uniquely for $n\ge5$" against L57's range $n\ge4$. See Finding 7; uniqueness holds at $n=4$.

**On "Proven" at [results.md](../results.md) line 12.** The word is entitled *as to the mathematics* (I reconstructed the whole proof cold and it holds), with two links that the record asserts and does not prove, both supplied in this review: the first-Bianchi half of the domain correspondence (Finding 5), and the attainment of $\Theta_n$ at general $n$, which the record carries as a screen at ten products and which Finding 6 now proves in closed form. **Until those two are written in, "Proven" is running slightly ahead of the record's own text.** After them it is correct.

**On the label `Lemma`.** The record's convention ([INDEX-results.md](../findings/INDEX-results.md) line 5) is "**Lemma** is proven, Gate 1 and Gate 2 passed". Two things say L57 had not passed Gate 2 before today:

- Its source section is headed "**CANDIDATE**: an elementary diagonal theorem at every $n\ge4$, odd $n$ included, **Gate 2 owed**", and its first line reads "every step below was rebuilt and screened here (Gate 1 (a)–(d)), **none audited**".
- Its row in [INDEX-results.md](../findings/INDEX-results.md) is `| **57** | Lemma | the diagonal theorem, all $n$, both parities |`, **the only row in the table with no Gate 2 field at all.** Every other row carries one, even if only "Gate 2: no verdict on the record".

Only step 3 had been through Gate 2, by reviewers 123 and 124. **So the label was ahead of the record until this audit, which is that Gate 2** (with r499). It is entitled now, on the mathematics; the six repairs below are what the *block* still owes.

---

## VERDICT: CONFIRMED

**The theorem is true as stated, at every $n\ge4$ and both parities, and I rebuilt the whole argument cold from the definitions without using the record's prose.** Both $\Theta_n$ formulas are correct and agree with [conventions.md](../findings/conventions.md); both equality cases attain them; the uniqueness claim is proved, not merely exhibited.

**The brief's specific risk does not land.** "What remains owed: steps 1 and 3 as proofs" is a section whose *title* is stale: it now carries step 3's closure, and step 1's proof sits further down under its own heading. Nothing is owed as a proof. But the pointer in the L57 block names that one section and nothing else, so a reader following it lands on a heading that says the argument is owed and finds two thirds of the argument elsewhere.

**Six repairs owed, none of them mathematical:**

1. **The pointer.** Replace "the argument is in this file under *What remains owed: steps 1 and 3 as proofs*" with the four sections that actually hold it (Finding 1's table), and add the criticality equation's home in [diagonal-half.md](../findings/diagonal-half.md).
2. **Retitle** the line-299 section; its title has been false since step 3 closed.
3. **The normalisation.** The line-232 block's "$\lvert S\rvert=1$" must read $\mathop{\mathrm{tr}}S^2=2$, or $\sum_{i<j}S_{ij}^2=1$. Read under [conventions.md](../findings/conventions.md)'s default it gives $\Theta_n/\sqrt2$, the $\sqrt2$ trap that file says has already cost a cycle.
4. **The domain.** Write the two-line first-Bianchi argument (Finding 5); it is what makes $\mathcal D_n$ the right set and it appears nowhere.
5. **The equality clause.** Add the quotient (sign and coordinate permutation) and reconcile the sign with the file's own correction that the maximiser is $-V/\lVert V\rVert$. Then fix "uniquely for $n\ge5$" at [problem.md](../findings/problem.md) line 376 and [INDEX.md](../findings/INDEX.md) line 28: uniqueness holds at $n=4$ too (Finding 7).
6. **The bridge sentence** from critical values to every diagonal $W$ (Finding 8).

**And one addition the record should take, since it upgrades a screen to a theorem:** the closed form $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)\,pq}$ of Finding 6, which proves attainment at every $n$ and both parities, and shows the balanced split is the best sphere product, all of which the record currently holds as measurements at ten products.

**No computation was run for this review.** Every number above is exact arithmetic on closed forms I derived by hand.
