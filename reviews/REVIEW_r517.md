# REVIEW r517, Lemma L36

**Target.** [Lemma L36](../findings/isotropy-cap.md), "$S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$", at the `#### Lemma L36` heading (line 17 of [isotropy-cap.md](../findings/isotropy-cap.md)), down to the next heading. Duplicated verbatim at [results.md:464](../results.md#L464).

**Reviewer.** r517, cold, adversarial. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts were run. One screen was run on objects I constructed, to check two claims before recording them; it is reported as a screen below and carries no positive claim on its own.

---

## VERDICT: REFUTED

***as stated*, and the scope matters.** Two clauses of the Statement are false, each with an explicit witness. The headline cap is **not** one of them.

| clause of the Statement | verdict |
| --- | --- |
| $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ for $\mathfrak m\subseteq\mathfrak{so}(n)$ isotropic for the Cartan 3-form | **CONFIRMED**, re-derived from scratch below, every step checked, tight at $n=6$ |
| the floor $\lfloor\cdot\rfloor$ | **CONFIRMED**, free from integrality; the one line is omitted from the proof |
| "no genericity hypothesis" | **CONFIRMED**, Schur, Cauchy–Schwarz and the Killing marginal, nothing else |
| "Sharp, every $n\ge3$" | **CONFIRMED on the Lie-algebra side**; false on the Weyl side at $n=3$, see the next row |
| "equivalently, let $\mathfrak m$ be the negative eigenspace of a Weyl operator with $S=0$" | **FALSE at $n=3$**, and the forward direction is unproved at every $n$ |
| "with equality attained by $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ at $p=q=n/2$" | **FALSE**, that subspace is $\mathfrak m^\perp$, has dimension $\tfrac{n(n-2)}4$, and is not isotropic for $n\ge6$ |

**The repair, in one sentence.** *With equality attained by the isotropy complement $\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$ of the symmetric pair $\big(\mathfrak{so}(n),\mathfrak{so}(p)\oplus\mathfrak{so}(q)\big)$, of dimension $pq$, at $p=\lceil n/2\rceil$, $q=\lfloor n/2\rfloor$.*

---

## Conventions fixed first, against the record's anchors

Inner product $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on $\mathfrak{so}(n)$, per [conventions.md](../findings/conventions.md). Then $\{\varphi_{ij}\}_{i<j}$ is **orthonormal** ($\lVert\varphi_{ij}\rVert^2=1$), $[\varphi_{12},\varphi_{23}]=\varphi_{13}$, and the Killing marginal is $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ for unit $v_\alpha$, which is [conventions.md](../findings/conventions.md)'s "$\kappa=2(n-2)$ in an orthonormal basis", re-derived here as $-B_K(v,v)$ with $B_K(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ and $\mathop{\mathrm{tr}}(v^2)=-2$. Sums over pairs are **ordered** unless said otherwise. $N=\binom n2$, $d=\dim\mathfrak m$.

> **A convention collision I hit immediately and note for the record.** [conventions.md](../findings/conventions.md) states both "$\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$" and "a bivector's norm: $\lVert\varphi_{ab}\rVert^2=2$" in adjacent bullets. Under the first, $\lVert\varphi_{ab}\rVert^2=1$. They are the two pairings the same file says "differ by a factor $2$", but a reader taking the second while using the first's marginal $2(n-2)$ is off by exactly the factor that decides this lemma. **The $2(n-2)$ marginal belongs to the $\tfrac12$-trace pairing**, which is the one I use throughout and the one L36's proof needs.

---

## 1. The bound. CONFIRMED, re-derived from scratch

Write $P$ for the orthogonal projection of $\Lambda^2\mathbb R^n$ onto $\mathfrak m$ and $\mu=\sum_{a,b}\lVert[e_a,e_b]\rVert^2$ over an orthonormal basis of $\mathfrak m$, **ordered**.

**Step L2 (holds for every subspace).** With $T(A)=-\sum_k\mathop{\mathrm{ad}}(f_k)A\mathop{\mathrm{ad}}(f_k)$ over an orthonormal basis of $\mathfrak{so}(n)$,

$$\langle T(P),P\rangle=-\sum_k\mathop{\mathrm{tr}}(\mathop{\mathrm{ad}}_kP\mathop{\mathrm{ad}}_kP)=\sum_{a,b}\sum_k\langle f_k,[e_a,e_b]\rangle^2=\mu,$$

using ad-invariance $\langle[f_k,e_a],e_b\rangle=\langle f_k,[e_a,e_b]\rangle$. **This fixes $\mu$ as the ordered sum**, the file's $\sum_{a,b}$ is right and matches [conventions.md](../findings/conventions.md)'s default.

$T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ is correct: expanding $\mathrm{Cas}(A)=-\sum_k[\![f_k,[\![f_k,A]\!]]\!]=-\sum_k(\mathop{\mathrm{ad}}_k^2A-2\mathop{\mathrm{ad}}_kA\mathop{\mathrm{ad}}_k+A\mathop{\mathrm{ad}}_k^2)$ and using $-\sum_k\mathop{\mathrm{ad}}_k^2=2(n-2)\mathrm{Id}$ gives $\mathrm{Cas}=4(n-2)-2T$.

**The four eigenvalues, computed independently** from $\mathrm{Cas}=\langle\lambda,\lambda+2\rho\rangle$ normalised so the adjoint ($\lambda=e_1+e_2$) carries $2n-4$:

| summand | highest weight | $\mathrm{Cas}$ | $T$ | block says |
| --- | --- | --- | --- | --- |
| $\mathbb R\cdot\mathrm{Id}$ | $0$ | $0$ | $2n-4$ | $2n-4$ ✓ |
| $\mathrm{Sym}^2_0$ | $2e_1$ | $2n$ | $n-4$ | $n-4$ ✓ |
| $\mathrm{Weyl}_n$ | $2e_1+2e_2$ | $4n-4$ | $-2$ | $-2$ ✓ |
| $\Lambda^4$ | $e_1+e_2+e_3+e_4$ | $4n-16$ | $4$ | $4$ ✓ |

Cross-check against a different block of the same file: [Lemma L79](../findings/isotropy-cap.md)'s $\mathcal A$ carries $+2,\,-(m-4),\,-2(m-2),\,-4$ on the same four summands. **$T=-\mathcal A$ exactly, entry for entry**, an independent confirmation, and [r411](REVIEW_r411.md)'s identification $T=2(\#I)$ ties it to Böhm–Wilking.

Splitting $P=\tfrac dN\mathrm{Id}+P_0$ with $\langle\mathrm{Id},P_0\rangle=0$, $\lVert P_0\rVert^2=d-\tfrac{d^2}N$, and $\lambda_{\min}(T)\ge-2$:

$$\mu\ \ge\ (2n-4)\tfrac{d^2}N-2\Big(d-\tfrac{d^2}N\Big)=\tfrac{(2n-2)d^2}{N}-2d=\tfrac{4d^2}n-2d,$$

since $\tfrac{2n-2}{N}=\tfrac4n$. ✓ **Sanity: equality at $P=\mathrm{Id}$**, where $\mu=2(n-2)N=n(n-1)(n-2)$ and the bound reads $n(n-1)^2-n(n-1)=n(n-1)(n-2)$. The record's own $\lVert P_0\rVert^2$ column at [isotropy-cap.md:120–125](../findings/isotropy-cap.md) ($2.4,\,3.6,\,5.1429,\,8.8889$ at $(n,d)=(5,6),(6,9),(7,12),(9,20)$) reproduces $d-d^2/N$ to the digit, confirming the same normalisation.

**Step L1 (this is where isotropy enters, and the block does not say so).** Marginal summed over $\mathfrak m$: $\sum_a\lVert\mathop{\mathrm{ad}}_{e_a}\rVert_{HS}^2=2(n-2)d$. Isotropy is $P\mathop{\mathrm{ad}}_XP=0$ for $X\in\mathfrak m$, so $\mathop{\mathrm{ad}}_{e_a}$ has three surviving blocks, and by skew-adjointness the $\mathfrak m\!\to\!\mathfrak h$ and $\mathfrak h\!\to\!\mathfrak m$ blocks carry **equal** mass, each $=\mu$:

$$2\mu+\gamma=2(n-2)d,\qquad \gamma:=\sum_a\big\lVert(I-P)\mathop{\mathrm{ad}}_{e_a}(I-P)\big\rVert^2=\sum_{h,h'\in\mathfrak h}\big\lVert P_{\mathfrak m}[h,h']\big\rVert^2\ \ge\ 0.$$

So $\mu\le(n-2)d$, and chaining, $\tfrac{4d^2}n-2d\le(n-2)d$ gives $\tfrac{4d}n\le n$, i.e. $d\le\tfrac{n^2}4$; $d$ integral gives $d\le\lfloor n^2/4\rfloor$. $\square$

### The one real gap in the proof: $\gamma$ is never defined, and the obvious reading is vacuous

**$\gamma$ appears in the block only inside the phrase "the Killing block identity $2\mu+\gamma=2(n-2)d$ with $\gamma\ge0$", and is defined nowhere in the file.** A reader who takes the obvious reading ($\gamma$ = the $\mathfrak m$–$\mathfrak h$ bracket mass), gets $\mu+\gamma=2(n-2)d$, hence $\mu\le2(n-2)d$, which holds for **every** subspace and chains to $d\le N$: **vacuous**. Under that reading the sentence "Isotropy gives $\mu\le(n-2)d$" is also false, since nothing in it uses isotropy.

The identity is nonetheless **correct**, and the record confirms which $\gamma$ is meant in three separate places:

- [isotropy-cap.md](../findings/isotropy-cap.md)'s own "What it does not reach": *"Equality forces $\gamma=0$, hence $\mathfrak m^\perp$ a subalgebra"*, which is exactly $\sum_{h,h'}\lVert P_{\mathfrak m}[h,h']\rVert^2=0$.
- [ungraded-slack.md:126](../findings/ungraded-slack.md#L126) derives the same marginal split in structure-constant form: $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$ *given* $S_{\mathfrak{hhm}}=0$. Restoring that term gives $2\mu+S_{\mathfrak{hhm}}=2(n-2)d$ under isotropy. **So $\gamma=S_{\mathfrak{hhm}}$.**
- [bounds-relaxations.md:142](../findings/bounds-relaxations.md#L142) quotes the chain as $4d^2/n-2d\le2S_{\mathfrak{mmh}}\le(n-2)d$, i.e. with $\mu=2S_{\mathfrak{mmh}}$, the same ordered convention.

**Recommended fix: one clause.** Write "$\gamma:=\sum_{h,h'\in\mathfrak m^\perp}\lVert P_{\mathfrak m}[h,h']\rVert^2\ge0$, the failure of $\mathfrak m^\perp$ to be a subalgebra; the factor $2$ on $\mu$ is isotropy, which makes the two off-diagonal blocks of $\mathop{\mathrm{ad}}_{e_a}$ carry equal mass."

### Two smaller imprecisions in the same block

- **"$-2$ is $T$'s only negative eigenvalue" fails at $n=3$**, where $\mathrm{Weyl}_3=\Lambda^4\mathbb R^3=0$ and $\mathop{\mathrm{spec}}T=\{2,-1\}$, the $-1$ on $\mathrm{Sym}^2_0$. Harmless ($-2\le-1$, so the bound still holds) but "**the whole content is one eigenvalue**, and it is the Weyl space's" is untrue at the smallest $n$ the Statement claims. At $n=3$ the sharp constant comes from $\mathrm{Sym}^2_0$ and gives $d^2-d\le d$, i.e. $d\le2=\lfloor 9/4\rfloor$, sharp by a different route.
- **The integrality step is missing.** The proof ends at $d\le n^2/4$; the Statement claims $\lfloor n^2/4\rfloor$. One line, but it is the whole of the odd-$n$ statement.

---

## 2. Sharpness and the equality case. REFUTED, with a witness

**The Statement names the wrong subspace.** $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is $\mathfrak h=\mathfrak m^\perp$, the isotropy **subalgebra**, not $\mathfrak m$.

**Witness, $n=6$, $p=q=3$.** $\mathfrak h=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ has $\dim\mathfrak h=2\binom32=6=\tfrac{n(n-2)}4$, against $\lfloor 36/4\rfloor=9$, short by $n/2=3$. Worse, **$\mathfrak h$ does not satisfy the hypothesis**: $\varphi_{12},\varphi_{23},\varphi_{13}$ all lie in the first $\mathfrak{so}(3)$ and $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=\langle\varphi_{13},\varphi_{13}\rangle=1\ne0$. So for every $n\ge6$ the named object is not even admissible, and at $n=4$ it is $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$, abelian and admissible but of dimension $2$ against a cap of $4$. **It attains equality at no $n$ whatever.**

**What does attain it.** $\mathfrak m=\mathbb R^p\otimes\mathbb R^q$, the off-diagonal block $\begin{psmallmatrix}0&A\\-A^{\mathsf T}&0\end{psmallmatrix}$, $\dim=pq$: brackets land in the block-diagonal part $=\mathfrak m^\perp$, so it is isotropic, and $\max\{pq:p+q=n\}=\lfloor n^2/4\rfloor$ at $p=\lceil n/2\rceil$. Directly, $\mu=pq(p+q-2)=(n-2)d$, so the chain is equality throughout. **The cap is therefore sharp at every $n\ge3$, including odd $n$**, the odd maximiser is the *unbalanced* split $\big(\tfrac{n-1}2,\tfrac{n+1}2\big)$, whose $pq=\tfrac{n^2-1}4=\lfloor n^2/4\rfloor$. So of the brief's three options (*maximiser wrong, cap wrong, or $\mathfrak m$ misread*), the answer is **the maximiser is wrong**, and specifically it names $\mathfrak m^\perp$ where $\mathfrak m$ was meant, and pins $p=q$ where $p=\lceil n/2\rceil$ was meant.

**"$p=q=n/2$" also contradicts "every $n\ge3$"** in the same sentence: at odd $n$ there is no such $p$. The two halves of the sentence cannot both be read literally.

### The block's own file contradicts its Statement, 190 lines below

[isotropy-cap.md:216](../findings/isotropy-cap.md): *"the balanced sphere product's $\mathfrak m$ **is** the symmetric-pair subspace of $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, of dimension exactly $(n/2)^2=\lfloor n^2/4\rfloor$"*, the correct object, correctly named, with the correct dimension. Three further places agree and none agrees with the Statement:

| site | $\dim\mathfrak h$ | $\dim\mathfrak m$ |
| --- | --- | --- |
| [ungraded-slack.md:126](../findings/ungraded-slack.md#L126) | $r=\tfrac{n(n-2)}4$ | $N-r=\tfrac{n^2}4$ |
| [bounds.md:448,460](../findings/bounds.md#L448) | $\tfrac{n(n-2)}4$ | $\tfrac{n^2}4$ |
| [bounds-relaxations.md:341](../findings/bounds-relaxations.md#L341) | $r=\tfrac{n(n-2)}4$ | $N-r=\tfrac{n^2}4$ |

and $\tfrac{n(n-2)}4+\tfrac{n^2}4=\tfrac{n(n-1)}2=N$ ✓. **The number $\tfrac{n(n-2)}4$ that the Statement's named object carries is, everywhere else on the record, the dimension of the complement.**

### Screen

A screen, on objects I constructed for it, of the two claims above before recording them ([screen.py](file:///private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/screen.py), seconds of compute, no search). At $n=6$: $\mathbb R^3\otimes\mathbb R^3$ has $\dim 9$, 3-form sup $0.0$, $\mu=36=(n-2)d$; $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ has $\dim 6$, 3-form sup $1.0$; and $(2n-4)d^2/N-2\lVert P_0\rVert^2=36=4d^2/n-2d$, the chain tight at both ends. **Reported as a screen; the derivations above stand on their own.**

---

## 3. The "equivalently". FALSE at $n=3$; the forward direction is unproved everywhere

The two sides are not equivalent, and the clause is doing the work of a theorem in one direction and of a conditional lemma in the other.

**($\Leftarrow$) $S=0\Rightarrow$ isotropy: conditional, not definitional.** $S$ is defined at [ungraded-slack.md:286](../findings/ungraded-slack.md#L286) as $S(W)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)$. That is not a bracket quantity. The bridge to isotropy is the *next* display, $S=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$, and the same block says it in as many words: **"the identity itself is conditional on those conditions, not universal, an independent audit found generic critical points violating them, including one already in my own catalogue, where the ratio is $11.5$ rather than $\tfrac12$."** Two further conditions ride along: $\mu_i>0$ strictly, so a kernel eigenvalue assigned to $E_-$ drops out of the sum and $S=0$ constrains nothing along it, which is trap [W3](../findings/INDEX-traps.md), *"the screen is vacuous when $\ker W\ne0$"*, and it is not carried into L36's Statement.

**($\Rightarrow$) every isotropic $\mathfrak m$ is such an eigenspace: unproved, and false at $n=3$.** **Witness: $n=3$.** $\dim\mathcal W_3=\tfrac{3\cdot0\cdot4\cdot5}{12}=0$, so the only Weyl operator on $\mathbb R^3$ is $0$ and no Weyl operator has a nonzero negative eigenspace at all. Yet $\mathfrak m=\mathop{\mathrm{span}}\{\varphi_{12},\varphi_{13}\}\subseteq\mathfrak{so}(3)$ is isotropic (a 3-form vanishes on any 2-plane) and has $\dim=2=\lfloor 9/4\rfloor$. **So at $n=3$ the left side has a 2-dimensional example and the right side has none.** The Statement's own lower endpoint is the $n$ at which its "equivalently" breaks.

**What survives.** The cap is proved for the *Lie-algebra* hypothesis, which is the weaker one to assume, so **everything downstream that uses the cap is safe**; the equivalence would only be needed to transport an example *from* the algebra side *to* the Weyl side. Where that transport is actually needed it happens to hold and is checked case by case: at $n=6$ [r172](REVIEW_r172.md) exhibits an exact critical Weyl tensor with $S=0$ and $d=9$; at $n=4$ the diagonal $W$ with $\lambda_{12}=\lambda_{34}=-2b>0$ and $\lambda_{13}=\lambda_{14}=\lambda_{23}=\lambda_{24}=b<0$ is traceless, Ricci-flat ($a+2b=0$) and Bianchi-flat, with negative eigenspace exactly $\mathbb R^2\otimes\mathbb R^2$ of dimension $4=\lfloor 16/4\rfloor$; for $n\ge4$ generally the two-block sphere product $S^p\times S^q$ is graded ($k\le2\Rightarrow e_3=0\Rightarrow S=0$, [ungraded-slack.md:53](../findings/ungraded-slack.md#L53)) with $\dim\mathfrak m=pq$. **The general statement "every isotropic subspace is realised" is asserted by the word "equivalently" and proved nowhere.**

**Recommended fix.** Split the Statement: state the lemma for $\mathfrak m\subseteq\mathfrak{so}(n)$ isotropic, and add a separate sentence, *"the negative eigenspace of a Weyl operator with $S=0$ is such an $\mathfrak m$, by the bracket form of $S$ ([ungraded-slack.md](../findings/ungraded-slack.md)), under that form's two bracket conditions and $\ker W=0$"*, with the converse dropped, since it is false at $n=3$ and unproved above it.

---

## 4. "No genericity hypothesis", and "every $n\ge3$"

- **"No genericity hypothesis": CONFIRMED.** The proof consumes Schur's lemma on $\mathrm{Sym}(\mathfrak{so}(n))$, one Cauchy–Schwarz split of $P$, and the Killing marginal. No frame, no eigenvalue separation, no dimension threshold. Nothing in it degenerates.
- **"Every $n\ge3$": CONFIRMED for the cap, on the algebra side.** $n=3$ is not vacuous and not false: cap $2$, attained by any 2-plane in $\mathfrak{so}(3)$ and not by $\mathfrak{so}(3)$ itself, whose 3-form is the volume form. $n=4$: cap $4$, and independently maximal, under $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ the 3-form splits as $c_1\oplus c_2$, so an isotropic subspace meets each factor in at most a 2-plane, giving $4$ exactly. **On the Weyl side the range is $n\ge4$**, since $\mathcal W_3=0$.

---

## 5. The citations

| site | what it takes | verdict |
| --- | --- | --- |
| [results.md:40](../results.md#L40) | the cap | safe |
| [results.md:158](../results.md#L158) | cap + *"attained by the balanced symmetric pair"* | **safe, and better worded than the canonical block**, it names the pair, not $\mathfrak h$ |
| [results.md:462–466](../results.md#L462) | the duplicated canonical Statement | **carries the identical defect; fix both copies** |
| [routes.md:31](../routes.md#L31) (R13) | the cap, as "the already-proved Mantel cap" | safe; the route is closed for unrelated reasons |
| [plan.md:96](../plan.md#L96) | the range "L29–L36" for the $\le2$-negative stratum | not L36's content; already checked by [r514](REVIEW_r514.md) |
| [findings/INDEX.md:26](../findings/INDEX.md#L26) | cap **and** equality, *"$\dim\mathfrak m=\lfloor n^2/4\rfloor$ closed at both ends"* | safe; it names the dimension, not the subspace |
| [bounds.md:173](../findings/bounds.md#L173) | cap, with the LP optimum at $\dim\mathfrak m=\lfloor n^2/4\rfloor$ | safe |
| [bounds-relaxations.md:142](../findings/bounds-relaxations.md#L142) | the proof's **internal** chain $4d^2/n-2d\le2S_{\mathfrak{mmh}}\le(n-2)d$ | safe, and it independently pins $\mu=2S_{\mathfrak{mmh}}$ and $\gamma=S_{\mathfrak{hhm}}$ |
| [isotropy-cap.md:306](../findings/isotropy-cap.md#L306) | $\mu(\mathfrak m)=2\mathop{\mathrm{tr}}(\Pi_{\mathfrak m}^{\#})$ | safe; agrees with [r411](REVIEW_r411.md) |
| [ATTEMPTS.md:2208](../ATTEMPTS.md), [:2610](../ATTEMPTS.md) | literature placement; R13's closure | safe |
| [REVIEW_r321.md:118,126](REVIEW_r321.md) | the cap as an LP constraint | safe |
| [REVIEW_r411.md:114–115](REVIEW_r411.md) | the $-2$ eigenvalue, and $T=2(\#I)$ | safe, and an independent confirmation of the $T$-spectrum |
| [REVIEW_r172.md:69](REVIEW_r172.md) | **the "equivalently"**, quoted verbatim as the definition of $\mathfrak m$ | **the one citation resting on the defective clause**, sound in fact, because r172 exhibits an actual $n=6$ Weyl tensor rather than invoking the equivalence, but the sentence it quotes is not a definition |
| [ELIM-canon.md:128](ELIM-canon.md#L128) | *"Lemma L36 itself claims only the dimension cap and is correctly stated"* | **wrong on the second half**, the Statement also claims an equality case, and that clause is false |
| [ELIM-canon.md:148](ELIM-canon.md#L148) | *"the two-lemma chain $4d^2/n-2d\le\mu\le(n-2)d$ verifies by hand"* | agreed, and re-verified here |

**No citation is damaged by the refuted clauses.** Every consumer takes the cap or the *dimension* $\lfloor n^2/4\rfloor$; none constructs anything from $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ as an isotropic subspace, and the one that quotes the "equivalently" supplies its own witness.

---

## What to change

1. **[isotropy-cap.md:29](../findings/isotropy-cap.md#L29) and [results.md:464](../results.md#L464), the equality clause**, replace *"with equality attained by $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ at $p=q=n/2$"* with *"with equality attained by the isotropy complement $\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$ of the symmetric pair $(\mathfrak{so}(n),\mathfrak{so}(p)\oplus\mathfrak{so}(q))$, of dimension $pq$, at $p=\lceil n/2\rceil$"*. Both copies.
2. **The "equivalently"**, split into a hypothesis and a separate transport sentence carrying the bracket-form conditions and $\ker W=0$; drop the converse.
3. **Define $\gamma$** in the proof, and say in the same breath that the factor $2$ on $\mu$ is where isotropy is spent.
4. **Add the integrality line** that takes $d\le n^2/4$ to $d\le\lfloor n^2/4\rfloor$.
5. **Qualify "the whole content is one eigenvalue"** to $n\ge4$.

---

## Phases run

1. Conventions fixed against the record's anchors. 2. Block read verbatim. 3. "Equivalently" attacked both directions. 4. Cap re-derived; floor checked. 5. Killing identity re-derived; $\gamma$ identified; normalisation checked three ways. 6. Sharpness arithmetic settled. 7. $n=3$, $n=4$ and genericity checked. 8. Citations graded. 9. Later sections of the target's own file read for contradiction.

**VERDICT: REFUTED**, as stated, on the equality clause and the "equivalently". The cap $\dim\mathfrak m\le\lfloor n^2/4\rfloor$, its floor, its sharpness at every $n\ge3$ and its freedom from genericity are **CONFIRMED**, and the repair is five lines.
