# VERIFY v132, L36: the isotropy cap $\lfloor n^2/4\rfloor$, its Killing/Casimir sandwich, the mixed-plane maximiser at both parities, and the $S=0$ premise clause

**Verifier v132, cold brief.** No numerical work was performed and no script was run; every value below is an exact hand evaluation, and the Casimir eigenvalues are recomputed from $\langle\lambda,\lambda+2\rho\rangle$ rather than taken from the block. The programme is on an [analysis-only footing](../.claude/rules/analysis-only.md), which this round respected in full. Log: [agent_logs/verify-L36-v132.log](../agent_logs/verify-L36-v132.log). Sources checked: [findings/isotropy-cap.md](../findings/isotropy-cap.md):17–, [results.md](../results.md):158 and :489, [findings/bounds.md](../findings/bounds.md):311 (L153), [findings/isotropy-cap.md](../findings/isotropy-cap.md):270 (L79), [findings/ungraded-slack.md](../findings/ungraded-slack.md):333, [findings/nondegeneracy.md](../findings/nondegeneracy.md):135, [findings/conventions.md](../findings/conventions.md):38, [findings/INDEX-traps.md](../findings/INDEX-traps.md):22 (W4), [findings/INDEX-results.md](../findings/INDEX-results.md):51, [lean/INDEX.md](../lean/INDEX.md):267, [lean/HamiltonsCubic/Results/L36.lean](../lean/HamiltonsCubic/Results/L36.lean), [ATTEMPTS.md](../ATTEMPTS.md):2208 and :2610.

## Claim table

| # | Claim, as the record states it | Verdict |
|---|---|---|
| **C1** | Isotropic $\mathfrak m\subseteq\mathfrak{so}(n)\Rightarrow\dim\mathfrak m\le\lfloor n^2/4\rfloor$ | **PROVEN** at $n\ge4$ as written; true at $n=3$ by a different eigenvalue |
| **C2** | Killing block identity $2\mu+\gamma=2(n-2)d$ under isotropy, with $\gamma\ge0$ a sum of squares | **PROVEN** |
| **C3** | $\mu=\langle T(P),P\rangle$ with $T(A)=-\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ | **PROVEN** |
| **C4** | $T$'s spectrum on $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ is $2n-4,\ n-4,\ -2,\ 4$ | **PROVEN**, all four recomputed exactly |
| **C5** | **Every** $d$-dimensional subspace satisfies $\mu\ge4d^2/n-2d$ | **PROVEN** at $n\ge4$; the written proof does not reach $n=3$ |
| **C6** | Chaining gives $d\le n^2/4$, hence $d\le\lfloor n^2/4\rfloor$ | **PROVEN**, with an unstated division by $d$ that is harmless |
| **C7** | The maximiser is the mixed planes $\mathbb R^p\otimes\mathbb R^q$, $p=\lceil n/2\rceil$; it is isotropic and has dimension $\lfloor n^2/4\rfloor$ | **PROVEN**, and **equality really holds at both parities** |
| **C8** | "$-2$ is $T$'s only negative eigenvalue" | **GAP**, false at $n=3$; the repair sits eight lines below the sentence |
| **C9** | The premise clause "isotropic, which the negative eigenspace of a Weyl operator with $S=0$ is" | **HYPOTHESIS-DEBT at the point of citation**, $S$ names two different objects on this record |
| **C10** | [results.md](../results.md):158 "attained by the balanced symmetric pair" | **GAP**, the named trap; the correction is at :489, not here |
| **C11** | The converse fails, and no consumer needs it | **PROVEN**, every consumer traced uses the forward direction only |
| **C12** | Lean coverage | **No Lean proof of the cap exists**; [lean/INDEX.md](../lean/INDEX.md):267 says so and is accurate |

**Verdict: `PROVEN, hypotheses corrected`.** The cap, its two-step proof, and the sharpness of the mixed-plane maximiser at both parities are correct and I rebuilt every constant by hand. Three corrections are owed to the *statement*, none to the mathematics: the proof as written needs $n\ge4$, the symbol $S$ in the heading must be read as the structural slack $S_{\mathfrak{mmm}}$ rather than [conventions.md](../findings/conventions.md)'s $S(W)$, and [results.md](../results.md):158's "balanced symmetric pair" must be read as that pair's odd part.

## 0. Conventions, fixed once

Everything below runs in the record's default pairing, the half-trace $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(n)=\Lambda^2\mathbb R^n$, under which the coordinate bivectors $\varphi_{ij}=E_{ij}-E_{ji}$, $i<j$, form an orthonormal basis and $N:=\dim\mathfrak{so}(n)=\binom n2$. [Lemma L79](../findings/isotropy-cap.md):270 records that this choice is load-bearing ("under plain Frobenius every one of them halves") and L36's block never names it. Sums over pairs and triples are **ordered** unless stated, which is [conventions.md](../findings/conventions.md)'s standing default and is the convention in which $\mu(\mathfrak m)=\sum_{a,b}\lVert[e_a,e_b]\rVert^2$ and $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ are both written.

The structure constants I use throughout are $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ for distinct $a,b,c$, and $[\varphi_{ab},\varphi_{cd}]=0$ when $\{a,b\}\cap\{c,d\}=\emptyset$. I derive the first once, in §5, because the whole "isotropy is triangle-freeness" reading and the refutation of the first maximiser both turn on it.

$\mathfrak m$ is a $d$-dimensional subspace with orthonormal basis $\{e_a\}$, $\mathfrak h:=\mathfrak m^\perp$ with orthonormal basis $\{h_i\}$, $P$ the orthogonal projection onto $\mathfrak m$ regarded as a symmetric endomorphism of $\mathfrak{so}(n)$, and $P_0:=P-\tfrac dN\mathrm{Id}$ its traceless part. Note that [conventions.md](../findings/conventions.md):28 warns that $\mathfrak m$ "carries three incompatible senses across the record" and names L36's (the **whole negative eigenspace**) as one of them. That is the sense used here.

## 1. The hypothesis inventory

A pass without one is not a pass, so here is every hypothesis the block carries or imports, checked against the object it applies to, with the ones the written proof actually uses marked.

### 1a. Hypotheses the block states

| | Hypothesis | Holds of the object? | Used by the written proof? |
|---|---|---|---|
| H1 | $\mathfrak m\subseteq\mathfrak{so}(n)$ is a **linear subspace** | yes, by construction | **yes**, $P$ is an orthogonal projection only for a subspace, and $\mathop{\mathrm{tr}}(P^2)=\mathop{\mathrm{tr}}P=d$ in §3 needs idempotence |
| H2 | **Isotropy**: $\langle[u,v],w\rangle=0$ for all $u,v,w\in\mathfrak m$ | hypothesis | **yes, in Step 1 only**, §2 shows exactly where |
| H3 | "no genericity hypothesis" |, | correct: nothing in either step asks $\mathfrak m$ to be generic, in general position, or a subalgebra |

### 1b. Hypotheses the block uses and does not state

| | Hypothesis | Status |
|---|---|---|
| H4 | The pairing is the **half-trace**, so that $\{\varphi_{ij}\}$ is orthonormal | **unstated.** Every constant ($2(n-2)$, $2n-4$, $-2$, $4d^2/n$), moves under plain Frobenius. [L79](../findings/isotropy-cap.md):270 flags this for its own table and calls the omission load-bearing; L36 inherits it silently |
| H5 | $\{f_k\}$ is an **orthonormal basis of $\mathfrak{so}(n)$**, and the pairing is **ad-invariant** | **unstated.** Both are needed for $\mu=\langle T(P),P\rangle$ (§3) and for [L153](../findings/bounds.md):311, whose own block was repaired on 2026-09-05 for collapsing exactly these two steps into one |
| H6 | $n\ge4$, so that $-2$ is $T$'s least eigenvalue | **unstated in the proof.** This is C8, and it is the round's cleanest instance of the named trap: the sentence "$-2$ is $T$'s only negative eigenvalue" stands unqualified, and the qualification lives eight lines below it |
| H7 | $d\ge1$, for the division by $d$ in the chaining step | **unstated**, and harmless, see §4 |

### 1c. Imported results and their hypotheses

| Import | Its hypotheses | Do they hold here? |
|---|---|---|
| [Lemma L153](../findings/bounds.md):311, the Killing row marginal $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ | an orthonormal basis $\{v_\beta\}$ of $\Lambda^2\mathbb R^n$, **any** $v$, at every $n\ge2$ | **yes.** L36 applies it at basis vectors of $\mathfrak m$, the narrow case, so it is untouched by the quantifier repair L153's own audit recorded, that repair was needed by [L70](../findings/bounds.md) and [L78](../findings/isotropy-cap.md), which apply it at non-basis vectors. L36's use is the safe one |
| The Casimir spectrum, i.e. [Lemma L79](../findings/isotropy-cap.md):270 read as $\mathcal A=-T$ | $\mathcal A$ is $O(m)$-equivariant, so Schur makes it scalar on each summand of $\mathrm{Sym}^2(\Lambda^2)$; the table holds at every $m\ge3$ | **yes**, with one caveat that turns out inert, see §3c. The $m=4$ and $m=8$ eigenvalue collisions L79 records do not touch L36, because L36 consumes only $\lambda_{\min}(T)$ |
| The curvature decomposition $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)=\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ | completeness of the four summands | **yes**, and L79 supplies the check that no summand is missing: the four dimensions sum to $\tfrac{m(m-1)(m^2-m+2)}8$ as a polynomial identity |
| Mantel's theorem |, | **cited only as an interpretation**, never used in the proof. It is not in [references/](../references/), so the analogy rests on an unread source; the cap does not depend on it. The genuinely adjacent literature, [turan-multilinear-2026](../references/turan-multilinear-2026/README.md), **is** in references/ and [ATTEMPTS.md](../ATTEMPTS.md):2208 places L36 against it correctly: the published results bound the *isotropy index*, a minimum over all alternating forms, so they bound L36 from below and cannot give its value |

**What the written proof uses.** H1, H2, H4, H5, H6, H7, L153 and the Casimir spectrum. **H2 is used exactly once**, in Step 1; Step 2 is hypothesis-free over subspaces. That asymmetry is the whole architecture of the lemma and §6 shows it is real, with a witness.

## 2. Step 1, the Killing block identity, and where isotropy enters (C2)

The block writes: *"Isotropy gives $\mu\le(n-2)d$ from the Killing block identity $2\mu+\gamma=2(n-2)d$, which is **[Lemma L153](../findings/bounds.md)** summed over the $d$ rows of $\mathfrak m$."* I rebuilt it.

Fix an orthonormal basis $\{f_k\}$ of $\mathfrak{so}(n)$ and split it as $\{e_a\}\cup\{h_i\}$ along $\mathfrak m\oplus\mathfrak h$. Summing [L153](../findings/bounds.md):311 over the $d$ basis vectors of $\mathfrak m$,

$$\sum_a\sum_k\lVert[e_a,f_k]\rVert^2=2(n-2)d,$$

and splitting the inner sum by the two blocks,

$$\underbrace{\sum_{a,b}\lVert[e_a,e_b]\rVert^2}_{=\ \mu}\ +\ \sum_{a,i}\lVert[e_a,h_i]\rVert^2\ =\ 2(n-2)d .$$

The second sum splits again by projecting the bracket onto $\mathfrak m$ and $\mathfrak h$. By ad-invariance $\langle[e_a,h_i],e_b\rangle=-\langle h_i,[e_a,e_b]\rangle$, so

$$\sum_{a,i}\lVert P[e_a,h_i]\rVert^2=\sum_{a,b,i}\langle h_i,[e_a,e_b]\rangle^2=\sum_{a,b}\lVert P^\perp[e_a,e_b]\rVert^2,$$

and by the same invariance $\langle[e_a,h_i],h_j\rangle=\langle e_a,[h_i,h_j]\rangle$, so

$$\sum_{a,i}\lVert P^\perp[e_a,h_i]\rVert^2=\sum_{i,j}\lVert P[h_i,h_j]\rVert^2\ =:\ \gamma .$$

**This is where H2 enters, and nowhere else.** Isotropy says $[e_a,e_b]\perp\mathfrak m$, so $\lVert P^\perp[e_a,e_b]\rVert^2=\lVert[e_a,e_b]\rVert^2$ and the first of the two sums is a second copy of $\mu$. Hence

$$2\mu+\gamma=2(n-2)d,\qquad \gamma=\sum_{i,j}\lVert P[h_i,h_j]\rVert^2\ \ge\ 0,$$

and $\mu\le(n-2)d$ follows. **C2 holds.** Three observations.

- $\gamma$ is *defined* as the $\mathfrak{hhm}$ mass (a manifest sum of squares, visibly the failure of $\mathfrak m^\perp$ to be a subalgebra) rather than as the residual $2(n-2)d-2\mu$. The block's own italic aside says precisely this and is **correct and well placed**: read the other way the identity is a tautology and $\gamma\ge0$ restates the conclusion. This is the one place in the block where a correction sits *inside* the sentence it corrects rather than beside it.
- The identity is **not** hypothesis-free; the hypothesis-free version replaces the first $\mu$ by $\sum_{a,b}\lVert P^\perp[e_a,e_b]\rVert^2$, i.e. restores the $\mathfrak{mmm}$ term. That restored form is what [L78](../findings/isotropy-cap.md):159 calls "L36's own boxed identity with $\alpha$ put back" and what [L114](../findings/bounds-relaxations.md):138 re-derives as a separate lemma in another file. All three are one statement; I checked they are consistent, and the factor-2 dispute [L77](../findings/isotropy-cap.md):118 records is a live *ordered-versus-unordered* collision in $S_{XYZ}$ and not a defect in L36, L77's own block says L36 "writes $2\mu+\gamma=2(n-2)d$ incompatibly with the factor and **correctly**", and my derivation agrees.
- **No finding on the L153 import.** L36 uses L153 at basis vectors, which is the form L153 stated before its 2026-09-05 quantifier repair, so L36 was never exposed to that defect.

## 3. Step 2, the Casimir operator, its spectrum, and the universal lower bound (C3, C4, C5)

### 3a. $\mu=\langle T(P),P\rangle$ (C3)

With $T(A)=-\sum_k\mathrm{ad}(f_k)\,A\,\mathrm{ad}(f_k)$ and $P=\sum_a e_ae_a^{\mathsf T}$: since each $\mathrm{ad}(f_k)$ is skew-adjoint (H5),

$$\mathrm{ad}(f_k)\,P\,\mathrm{ad}(f_k)=\sum_a\big(\mathrm{ad}(f_k)e_a\big)\big(e_a^{\mathsf T}\mathrm{ad}(f_k)\big)=-\sum_a v_{ka}v_{ka}^{\mathsf T},\qquad v_{ka}:=[f_k,e_a],$$

so $T(P)=\sum_{k,a}v_{ka}v_{ka}^{\mathsf T}$ and $\langle T(P),P\rangle=\sum_{k,a}\lVert Pv_{ka}\rVert^2$. Expanding the projection and using ad-invariance once more,

$$\sum_k\lVert P[f_k,e_a]\rVert^2=\sum_{k,b}\langle f_k,[e_a,e_b]\rangle^2=\sum_b\lVert[e_a,e_b]\rVert^2 .$$

Summing over $a$ gives $\langle T(P),P\rangle=\mu$ exactly, on ordered pairs. **C3 holds**, and note it holds for **every** subspace, no isotropy anywhere.

### 3b. $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ (C3, second half)

$\mathfrak{so}(n)$ acts on $\mathrm{End}(\mathfrak{so}(n))$ by $X\cdot A=\mathrm{ad}(X)A-A\,\mathrm{ad}(X)$, so

$$\sum_k(X_k\cdot)^2A=\Big(\sum_k\mathrm{ad}(f_k)^2\Big)A-2\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)+A\Big(\sum_k\mathrm{ad}(f_k)^2\Big).$$

With $\mathrm{Cas}:=-\sum_k(X_k\cdot)^2$ and $\sum_k\mathrm{ad}(f_k)^2=-c\,\mathrm{Id}$ on $\mathfrak{so}(n)$, this rearranges to $T=c\,\mathrm{Id}-\tfrac12\mathrm{Cas}$. The constant $c$ is the adjoint Casimir. Computed directly on $e_1\wedge e_2$: with $\varphi_{ij}e_k=\delta_{jk}e_i-\delta_{ik}e_j$, the only $\{i,j\}$ contributing to $\sum_{i<j}\varphi_{ij}e_1\wedge\varphi_{ij}e_2$ is $\{1,2\}$, giving $(-e_2)\wedge e_1=e_1\wedge e_2$; and $\sum_{i<j}\varphi_{ij}^2=-(n-1)\mathrm{Id}$ on $\mathbb R^n$. Hence

$$\sum_k\mathrm{ad}(f_k)^2(e_1\wedge e_2)=\big(-2(n-1)+2\big)e_1\wedge e_2=-(2n-4)\,e_1\wedge e_2,$$

so $c=2(n-2)$ and $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ exactly as written.

### 3c. The four eigenvalues (C4)

Normalise the Cartan pairing by $\mathrm{Cas}(V)=n-1$ on the vector representation, which fixes $(\varepsilon_i,\varepsilon_j)=\delta_{ij}$ against $\rho=\sum_i\tfrac{n-2i}2\varepsilon_i$; then $\mathrm{Cas}(\lambda)=(\lambda,\lambda+2\rho)$ and $\lambda_T=2(n-2)-\tfrac12\mathrm{Cas}$.

| summand | highest weight | $\mathrm{Cas}=(\lambda,\lambda+2\rho)$ | $\lambda_T$ | block's value |
|---|---|---|---|---|
| $\mathbb R\cdot\mathrm{Id}$ | $0$ | $0$ | $2n-4$ | $2n-4$ ✔ |
| $\mathrm{Sym}^2_0\mathbb R^n$ | $2\varepsilon_1$ | $2(2+n-2)=2n$ | $n-4$ | $n-4$ ✔ |
| $\mathrm{Weyl}_n$ | $2\varepsilon_1+2\varepsilon_2$ | $2(2+n-2)+2(2+n-4)=4n-4$ | $-2$ | $-2$ ✔ |
| $\Lambda^4\mathbb R^n$ | $\varepsilon_1+\dots+\varepsilon_4$ | $(1+n-2)+(1+n-4)+(1+n-6)+(1+n-8)=4n-16$ | $4$ | $4$ ✔ |

Two independent cross-checks, both exact. **The consistency check against the adjoint:** $\Lambda^2$ has $\lambda=\varepsilon_1+\varepsilon_2$ and $(\lambda,\lambda+2\rho)=(n-1)+(n-3)=2n-4$, reproducing §3b's $c$ by a different route. **The check against [L79](../findings/isotropy-cap.md):270:** L79 tabulates $\mathcal A$ at $+2,\ -(m-4),\ -2(m-2),\ -4$ on $\mathrm{Weyl}_m,\ S^2_0,\ \mathbb R\cdot\mathrm{Id},\ \Lambda^4$, and $\mathcal A=-T$ turns those into $-2,\ m-4,\ 2(m-2),\ 4$, the same four. The Weyl multiplicities the block prints, $10,35,84,168$ at $n=4,\dots,7$, agree with $\tfrac{n(n+1)(n+2)(n-3)}{12}$ at each: $\tfrac{4\cdot5\cdot6\cdot1}{12}=10$, $\tfrac{5\cdot6\cdot7\cdot2}{12}=35$, $\tfrac{6\cdot7\cdot8\cdot3}{12}=84$, $\tfrac{7\cdot8\cdot9\cdot4}{12}=168$. **C4 holds.**

**The collisions L79 records are inert here, and I checked rather than assumed it.** At $n=4$ the trivial and $\Lambda^4$ rows meet ($2n-4=4$ and $4$) and L79 notes they are isomorphic as $SO(4)$-representations, so $SO(4)$-Schur licenses *mixing* rather than merely a repeated scalar. But they carry the **same** $T$-eigenvalue $4$ at $n=4$, so mixing changes nothing: $T$ is still $4$ on their span. At $n=8$ the $\mathrm{Sym}^2_0$ and $\Lambda^4$ rows meet at $4$, likewise harmlessly. In both cases the colliding value is positive, and L36 consumes only $\lambda_{\min}$. **No finding.**

### 3d. The universal bound (C5)

Write $P=\tfrac dN\mathrm{Id}+P_0$. Then $T(\mathrm{Id})=-\sum_k\mathrm{ad}(f_k)^2=2(n-2)\mathrm{Id}$, so $\langle T(\mathrm{Id}),P_0\rangle=(2n-4)\mathop{\mathrm{tr}}P_0=0$ and the cross term dies. With $\lVert\mathrm{Id}\rVert^2=N$ and $\lVert P_0\rVert^2=\mathop{\mathrm{tr}}(P^2)-\tfrac{d^2}N=d-\tfrac{d^2}N$,

$$\mu=\frac{d^2}{N^2}(2n-4)N+\langle T(P_0),P_0\rangle\ \ge\ \frac{d^2(2n-4)}{N}-2\Big(d-\frac{d^2}N\Big)=\frac{d^2(2n-2)}{N}-2d .$$

Since $N=\tfrac{n(n-1)}2$, the first term is $\frac{2d^2(n-1)\cdot2}{n(n-1)}=\frac{4d^2}{n}$, giving

$$\boxed{\ \mu\ \ge\ \frac{4d^2}{n}-2d\ }$$

for **every** $d$-dimensional subspace, isotropic or not. **C5 holds at $n\ge4$**, the single inequality being $\langle T(P_0),P_0\rangle\ge\lambda_{\min}\lVert P_0\rVert^2$ with $\lambda_{\min}=-2$.

## 4. The chain, and every edge of every range (C6, C8)

Chaining §2 and §3d: $\tfrac{4d^2}n-2d\le\mu\le(n-2)d$, so $\tfrac{4d^2}n\le nd$. For $d\ge1$ divide by $d$: $d\le\tfrac{n^2}4$, and $d$ integral gives $d\le\lfloor n^2/4\rfloor$. **C6 holds.**

### 4a. $d=0$ and $d=1$

The division by $d$ is unstated (H7). At $d=0$ the conclusion is trivial and the chain reads $0\le0$; at $d=1$, $\mu=\lVert[e_1,e_1]\rVert^2=0$ while the lower bound is $\tfrac4n-2<0$, so Step 2 is vacuous and Step 1 gives $0\le n-2$. Neither edge breaks anything. **No finding: the missing $d\ge1$ is a writing gap with no consequence.**

### 4b. $d$ at the cap, both parities

At even $n$ with $d=\tfrac{n^2}4$: Step 2's floor is $\tfrac4n\cdot\tfrac{n^4}{16}-\tfrac{n^2}2=\tfrac{n^3}4-\tfrac{n^2}2$, and Step 1's ceiling is $(n-2)\tfrac{n^2}4=\tfrac{n^3}4-\tfrac{n^2}2$. **They coincide exactly**, so at the even cap the sandwich closes, $\mu=(n-2)d$ and $\gamma=0$ is *forced*. That is the mechanism behind the block's "what it does not reach" paragraph, and it is correct.

At odd $n$ with $d=\tfrac{n^2-1}4$: floor $=\tfrac4n\cdot\tfrac{(n^2-1)^2}{16}-\tfrac{n^2-1}2$, ceiling $=(n-2)\tfrac{n^2-1}4$, and the ceiling exceeds the floor by

$$\frac{n^2-1}{4}\Big[(n-2)+2-\frac{n^2-1}{n}\Big]=\frac{n^2-1}{4}\cdot\frac{1}{n}=\frac{n^2-1}{4n},$$

so $\gamma=2(\text{ceiling}-\text{floor})\le\tfrac{n^2-1}{2n}$, exactly the allowance the file's odd-$n$ paragraph records, $2.4$ at $n=5$ and $\tfrac{24}7=3.4285714\ldots$ at $n=7$. I confirm the arithmetic and confirm the block's own statement that **$\gamma=0$ is not forced at odd $n$ by this chain**. The block says so and does not overclaim. **No finding.**

### 4c. $n=4$

$N=6$, cap $4$. The spectrum is $4,\ 0,\ -2,\ 4$ on summands of dimensions $1,9,10,1$, summing to $21=\binom72=\dim\mathrm{Sym}^2(\Lambda^2\mathbb R^4)$ ✔. $\lambda_{\min}=-2$ on $\mathrm{Weyl}_4$, so Step 2 is exactly as written. **No finding.**

### 4d. $n=3$, DISCREPANCY, and it is C8

**Locate it exactly.** [findings/isotropy-cap.md](../findings/isotropy-cap.md):17– : *"**The whole content is one eigenvalue**, and it is the Weyl space's: $-2$ is $T$'s only negative eigenvalue, and its eigenspace is exactly $\mathrm{Weyl}_n$."* And the Statement two paragraphs above says *"Sharp, every $n\ge3$."*

**Exhibit the failure concretely.** At $n=3$, $\mathrm{Weyl}_3=0$ and $\Lambda^4\mathbb R^3=0$; the four dimensions read $1,5,0,0$ and sum to $6=\dim\mathrm{Sym}^2(\mathbb R^3)$, so the decomposition is $\mathbb R\oplus\mathrm{Sym}^2_0$ alone. The eigenvalues are $2n-4=2$ and $n-4=-1$. **$-2$ is not an eigenvalue of $T$ at all at $n=3$**, so the sentence quoted is false at the smallest $n$ the statement claims, and the single inequality Step 2 rests on is unavailable as written.

**Argue the opposite, the most charitable reading.** The *conclusion* survives, and by a stronger route. With $\lambda_{\min}=-1$ and $N=3$, §3d's computation gives $\mu\ge\tfrac{2d^2}3-(d-\tfrac{d^2}3)=d^2-d$, and chaining against Step 1's $\mu\le(n-2)d=d$ gives $d^2\le2d$, i.e. $d\le2=\lfloor 9/4\rfloor$. The displayed bound $\tfrac{4d^2}3-2d$ is *weaker* than $d^2-d$ for $d\le2$ (at $d=2$ they read $\tfrac43$ against $2$) so the printed inequality is **true** at $n=3$ even though the printed reason for it is not. The block's own next paragraph carries exactly this repair, and so does [LEDGER.md](../findings/LEDGER.md):1572.

**Verdict: `GAP`, not `BROKEN`.** The mathematics is intact at every $n\ge3$; what is defective is that the proof block's Step 2 is an $n\ge4$ argument presented without its range, and the repair lands eight lines below the sentence it repairs rather than inside it. **This is the record's signature failure exactly as the brief describes it**: read the proof block alone, as a consumer would, and you get a false lemma about $T$'s spectrum together with a bound whose stated justification does not exist at $n=3$.

**A note on the claim that this was already repaired.** [INDEX-results.md](../findings/INDEX-results.md):94 says [L79](../findings/isotropy-cap.md) "Repairs [L131](../findings/isotropy-cap.md)(ii)'s sign and [L36](../findings/isotropy-cap.md)'s $n\ge4$." I checked and **it does not.** L79's table holds at every $m\ge3$ in the sense that the $\mathrm{Weyl}_m$ and $\Lambda^4$ rows have dimension zero there ($\tfrac{3\cdot4\cdot5\cdot0}{12}=0$ and $\binom34=0$) so L79 is consistent with $n=3$ and says nothing about which eigenvalue is least. The fact L36 needs at $n=3$, that $\lambda_{\min}(T)=n-4=-1$ because the $-2$ eigenspace is empty, is a statement about a **missing** summand, and no eigenvalue table supplies it. **What would have to be shown, for the record to carry the repair inside the statement:** that $\lambda_{\min}(T)=\min\{n-4,-2\cdot[\mathrm{Weyl}_n\neq0],4\cdot[\Lambda^4\neq0]\}$, i.e. that the minimum is taken over the summands that are actually nonzero, which is $-1$ at $n=3$ and $-2$ at every $n\ge4$.

### 4e. Odd $n$ generally

Sharpness at odd $n$ is settled in §5 and is **not** in doubt. What is open, and what the block correctly labels open, is *rigidity* at the odd cap: forcing $\gamma=0$ at $d=\tfrac{n^2-1}4$ where §4b leaves it an allowance of $\tfrac{n^2-1}{2n}$. The block says this in the sentence "that argument is complete only for **even** $n$", which is accurate. **No finding.**

## 5. The maximiser, and sharpness at both parities (C7)

**The structure constant, derived once.** With $\varphi_{ij}=E_{ij}-E_{ji}$ and $E_{ab}E_{cd}=\delta_{bc}E_{ad}$, take distinct $a,b,c$:

$$\varphi_{ab}\varphi_{bc}=(E_{ab}-E_{ba})(E_{bc}-E_{cb})=E_{ac},\qquad \varphi_{bc}\varphi_{ab}=(E_{bc}-E_{cb})(E_{ab}-E_{ba})=E_{ca},$$

so $[\varphi_{ab},\varphi_{bc}]=E_{ac}-E_{ca}=\varphi_{ac}$, and $[\varphi_{ab},\varphi_{cd}]=0$ when the index sets are disjoint. Hence $\langle[\varphi_e,\varphi_f],\varphi_g\rangle\ne0$ **exactly when $\{e,f,g\}$ are the three edges of a triangle in $K_n$**, which is the "Mantel in continuous form" reading and is correct as stated.

**The claimed maximiser is isotropic.** Split $\mathbb R^n=\mathbb R^p\oplus\mathbb R^q$, $p+q=n$, and set $\mathfrak m=\mathbb R^p\otimes\mathbb R^q=\mathop{\mathrm{span}}\{\varphi_{i\alpha}:i\le p<\alpha\}$, the odd part of the symmetric pair $(\mathfrak{so}(n),\mathfrak{so}(p)\oplus\mathfrak{so}(q))$. Every bracket of two mixed planes shares at most one index; sharing none it vanishes, and sharing one it is $\pm\varphi_{\alpha\beta}$ or $\pm\varphi_{ij}$ with both indices on the same side, hence in $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, which is $\mathfrak m^\perp$. So $\langle[\mathfrak m,\mathfrak m],\mathfrak m\rangle=0$. **Isotropic. ✔**

**Its dimension, at both parities.** $\dim\mathfrak m=pq$, and at $p=\lceil n/2\rceil$, $q=\lfloor n/2\rfloor$:

| parity | $p$ | $q$ | $pq$ | $\lfloor n^2/4\rfloor$ | equal? |
|---|---|---|---|---|---|
| $n=2m$ | $m$ | $m$ | $m^2=\tfrac{n^2}4$ | $\tfrac{n^2}4$ | **yes** |
| $n=2m+1$ | $m+1$ | $m$ | $m^2+m=\tfrac{n^2-1}4$ | $\tfrac{n^2-1}4$ | **yes** |

**So equality really holds at both parities**, and it is one family rather than two, the identity $\lceil n/2\rceil\lfloor n/2\rfloor=\lfloor n^2/4\rfloor$, which is what [L36.lean](../lean/HamiltonsCubic/Results/L36.lean)'s `ceil_mul_floor` machine-checks. Edge cases: $n=3$ gives $p,q=2,1$ and $\mathfrak m=\mathop{\mathrm{span}}\{\varphi_{13},\varphi_{23}\}$ of dimension $2=\lfloor9/4\rfloor$, isotropic because the only bracket is $[\varphi_{13},\varphi_{23}]=-\varphi_{12}\perp\mathfrak m$; $n=4$ gives $p=q=2$ and dimension $4=\tfrac{16}4$. **C7 holds, and pre-registered question 1 is answered in the affirmative on every clause.**

**The refuted first maximiser, checked independently.** $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ at $p=q=\tfrac n2$ has dimension $2\binom{n/2}2=\tfrac{n(n-2)}4$, short of $\tfrac{n^2}4$ by exactly $\tfrac n2$, $6$ against $9$ at $n=6$, as the block says. And it is inadmissible: by the structure constant above, $[\varphi_{12},\varphi_{23}]=\varphi_{13}$, so $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=\lVert\varphi_{13}\rVert^2=1\ne0$ already inside one $\mathfrak{so}(3)$. **Both halves of the block's correction are exactly right**, and I reproduce its "$=1$" to the digit. An isotropic subalgebra is indeed abelian: $[\mathfrak a,\mathfrak a]\subseteq\mathfrak a$ plus $\langle[\mathfrak a,\mathfrak a],\mathfrak a\rangle=0$ forces $[\mathfrak a,\mathfrak a]\subseteq\mathfrak a\cap\mathfrak a^\perp=0$.

## 6. The universal claim, tried against every structured family the record names

*"**Every** $d$-dimensional subspace satisfies $\mu\ge4d^2/n-2d$."* A universal claim with no witness in the block. I evaluated it by hand on five families, all exact.

| family | $n,d$ | $\mu$ (hand) | $\tfrac{4d^2}n-2d$ | isotropic? | Step 1 applies? |
|---|---|---|---|---|---|
| Cartan subalgebra $\mathfrak t$ | $n=2m$, $d=m$ | $0$ | $\tfrac{4m^2}{2m}-2m=0$ | yes (abelian) | yes; **Step 2 exactly tight** |
| Cartan subalgebra $\mathfrak t$ | $n=2m+1$, $d=m$ | $0$ | $-\tfrac{n-1}n<0$ | yes | yes; Step 2 vacuous |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(3)\subset\mathfrak{so}(6)$ | $6,6$ | $12$ | $\tfrac{4\cdot36}6-12=12$ | **no** | **no**; Step 2 exactly tight |
| mixed planes $\mathbb R^3\otimes\mathbb R^3$ | $6,9$ | $36$ | $\tfrac{4\cdot81}6-18=36$ | yes | yes; **both steps tight** |
| the whole algebra $\mathfrak{so}(n)$ | $n,N$ | $n(n-1)(n-2)$ | $n(n-1)(n-2)$ | no | no; **Step 2 exactly tight** |

The three nontrivial evaluations, in full.

- **$\mathfrak t$, abelian, so $\mu=0$.** At even $n$ the bound is $0$ too, so a maximal torus sits *on* the Step-2 floor. It is isotropic and its dimension $\tfrac n2$ is far below the cap, which is consistent, the chain bounds $d$ and does not claim the bound is attained by every isotropic subspace.
- **$\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ at $n=6$.** Within one $\mathfrak{so}(3)$ the three unordered basis pairs each bracket to a unit bivector, giving $6$ on ordered pairs; the two blocks have disjoint index sets so cross brackets vanish; $\mu=12$. The floor is $12$. **Equality.** This is the sharpest witness in the round: the subspace is **not** isotropic (§5 exhibits $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1$) yet Step 2 is exactly tight on it, which demonstrates that Step 2 genuinely carries no isotropy hypothesis and that the two steps are independent. Cross-check: $\lVert P_0\rVert^2=6-\tfrac{36}{15}=3.6$ and $\mu=\tfrac{36\cdot8}{15}+\langle T(P_0),P_0\rangle=19.2+\langle T(P_0),P_0\rangle$, so $\langle T(P_0),P_0\rangle=-7.2=-2\lVert P_0\rVert^2$, i.e. $P_0\in\mathrm{Weyl}_6$ entirely, which reproduces the file's own isotypic-table row for $n=6$, $\lVert P_0\rVert^2=3.6$ all in $\mathrm{Weyl}_6$. It must, since $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ and the mixed planes share a $P_0$ up to sign.
- **The mixed planes at $n=6$, $d=9$.** Each $\varphi_{i\alpha}$ has exactly $2+2=4$ partners sharing exactly one index, each bracket a unit bivector; $9\times4=36$ ordered pairs, so $\mu=36$. Step 1's ceiling is $(n-2)d=4\cdot9=36$ and Step 2's floor is $36$. **The sandwich is closed at the cap**, hence $\gamma=0$, hence $\mathfrak m^\perp$ is a subalgebra, which it is.
- **The whole algebra.** $\mu=\sum_a\sum_b\lVert[f_a,f_b]\rVert^2=2(n-2)N$ by [L153](../findings/bounds.md), and $2(n-2)\cdot\tfrac{n(n-1)}2=n(n-1)(n-2)$; the floor is $\tfrac4n N^2-2N=n(n-1)^2-n(n-1)=n(n-1)(n-2)$. **Equality**, at the largest admissible $d$. This is a genuine consistency test the bound could have failed and did not.

**And one family the cap predicts must fail.** [L78](../findings/isotropy-cap.md):159 names the orthocomplement of the principal $\mathfrak{so}(3)\subset\mathfrak{so}(5)$, of dimension $7$, as the minimiser of the 3-form mass at $n=5$, $d=7$, with $\alpha=\tfrac{42}5$. Since $7>6=\lfloor25/4\rfloor$, L36 forces that subspace to be **non**-isotropic, and $\alpha=\tfrac{42}5>0$ says exactly that. The two results agree where they meet.

**No falsifier found, and here is what one would have to be.** A counterexample to Step 2 is a $d$-dimensional subspace whose $P_0$ has a component in a $T$-eigenspace of eigenvalue below $-2$. No such eigenspace exists at $n\ge4$: the four Casimir values in §3c are exact, and L79's polynomial dimension identity certifies that the four summands exhaust $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$, so there is nowhere for a fifth eigenvalue to live. **How I looked:** by recomputing all four highest-weight Casimirs independently of the block, by the two cross-checks in §3c, and by evaluating $\mu$ against the floor on the five families above (including the two extremes $d=\lfloor n/2\rfloor$ and $d=N$) where equality holds three times and would have exposed any sign or normalisation error immediately. **Pre-registered question 2 is answered: the spectrum is right, the bound holds for every subspace at $n\ge4$, it is vacuous at $d\le1$, and it is exactly tight at $d=N$ and at the even cap.**

## 7. Which direction is used, and the premise clause (C9, C11)

### 7a. The two implications, separated

The block's Statement contains one clause that is not part of the theorem it proves: *"isotropic, which the negative eigenspace of a Weyl operator with $S=0$ **is**."* Call the two directions

- **(→)** $S=0$ at a Weyl operator $\Rightarrow$ its negative eigenspace $E_-$ is isotropic for the Cartan 3-form;
- **(←)** an isotropic subspace of $\mathfrak{so}(n)$ arises as the negative eigenspace of some Weyl operator with $S=0$.

**Every consumer needs (→) and only (→).** I traced all of them:

| consumer | what it takes from L36 | direction |
|---|---|---|
| [bounds.md](../findings/bounds.md):204, the LP relaxation | the cap as an upper bound on $\dim\mathfrak m$ over $\{S=0\}$ | (→) |
| [bounds-relaxations.md](../findings/bounds-relaxations.md):166 | the two-sided mass sandwich $\tfrac{4d^2}n-2d\le2S_{\mathfrak{mmh}}\le(n-2)d$ | proof internals only |
| [L78](../findings/isotropy-cap.md):159, the residual floor | the block identity with $\alpha$ restored, plus $\mu\ge\tfrac{4d^2}n-2d$ | proof internals only, hypothesis-free |
| [L114](../findings/bounds-relaxations.md):138 | the Killing identity, re-derived | proof internals only |
| [target.md](../findings/target.md):526, the $SO(2m)/U(m)$ family | checks $3\le m(m-1)<m^2=\lfloor(2m)^2/4\rfloor$, i.e. that a named point respects the cap | (→) |
| [ATTEMPTS.md](../ATTEMPTS.md):2610, route R13 | L36 as "the already-proved Mantel cap" in the spectral-Mantel reading | (→) |
| [L76](../findings/isotropy-cap.md):232, [L77](../findings/isotropy-cap.md), the rigidity chain | isotropy $\Rightarrow$ the cap $\Rightarrow$ $\gamma=0$ | (→) |

**Nothing on the record uses (←).** [INDEX-results.md](../findings/INDEX-results.md):51 says the same in its own words ("**No citation is damaged**), all take the cap or the proof internals", and my independent trace agrees with it. **Pre-registered question 3 is answered: the consumers need (→); (←) is used nowhere.**

**(←) is genuinely false**, and the block's $n=3$ witness is correct: $\mathcal W_3=0$, so no Weyl operator on $\mathbb R^3$ has a negative eigenspace at all, while §5 exhibits an isotropic $2$-plane in $\mathfrak{so}(3)$ meeting the cap. The refutation is vacuity of the source, which is the weakest kind of counterexample but a valid one; a stronger witness at $n\ge4$ would be worth having and the record does not carry one.

### 7b. DISCREPANCY, the premise clause names no determinate hypothesis at the point of citation (C9)

**Locate it exactly.** [results.md](../results.md):158: *"Slack zero says the negative eigenspace is isotropic for the Cartan 3-form $\langle[x,y],z\rangle$."* And [results.md](../results.md):489 and the block both carry the unsubscripted "$S=0$" in the heading. [conventions.md](../findings/conventions.md):38 tables the unsubscripted symbol once: *"$S(W)$ | the gradedness slack. **Read [W4](../findings/INDEX-traps.md) before using it**: the screen is vacuous when $\ker W\ne0$."*

**Exhibit the failure concretely.** The record carries **two** objects under the letter $S$, both tabled in [conventions.md](../findings/conventions.md), $S_{XYZ}$ at line 20, the block-restricted contraction over ordered slots, and $S(W)$ at line 38, the analytic gradedness slack $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)$, and it records that they **disagree at named objects**. [nondegeneracy.md](../findings/nondegeneracy.md):383: of 3767 multi-block critical points scanned, "**41 are indecomposable with $S_{\mathrm{struct}}=0$**, all at $k=5$, all of $C_5$ blow-up type, and **all exactly where the two slack conventions disagree**." And [trap W4](../findings/INDEX-traps.md):22 records padded $W_{\mathbb{CP}^2}$ at $n=12$, kernel $63$ of $66$, reporting $S(W)=0$ "while admitting no grading", so at that point the analytic reading of the premise is vacuous rather than informative. A consumer citing [results.md](../results.md):158 and resolving "$S$" through the record's own symbol table therefore imports a hypothesis whose implication to isotropy is **conditional**: [ungraded-slack.md](../findings/ungraded-slack.md):333 derives $S=\mathop{\mathrm{tr}}(P_{E_-}W_-^\#P_{E_-})=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$ only "under two bracket conditions", names them as **(F1)** $[E_+,E_+]\perp E_-$ and **(F2)** $[E_+,E_-]\subseteq E_-$, and states that "an independent audit found generic critical points violating them, including one already in my own catalogue, where the ratio is $11.5$ rather than $\tfrac12$."

**Argue the opposite, the most charitable reading, and it is the right one.** [isotropy-cap.md](../findings/isotropy-cap.md):11, six lines above the block, pins the reading: *"$S=0$ says exactly that $\langle[u,v],w\rangle=0$ for all $u,v,w$ in the negative eigenspace."* [nondegeneracy.md](../findings/nondegeneracy.md):135 pins it again from the other side: *"$S=0$ counts triples from $\mathfrak m$, and $S\equiv0$ identically whenever $\dim\mathfrak m\le2$."* So the intended $S$ is $S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2$ with $\mathfrak m=E_-$, and under that reading (→) is a **one-line tautology**: a finite sum of squares vanishes iff every summand does, so $S_{\mathfrak{mmm}}=0$ iff $E_-$ is isotropic. Nothing needs proving, no bracket condition is required, and the clause is discharged.

**Verdict: `HYPOTHESIS-DEBT` on the headline form, discharged on the file form.** The debt is not a missing derivation, under the correct reading there is nothing to derive. It is that **the sentence a consumer cites does not carry the reading, and the record's own symbol table points the other way.** *What would have to be shown, exactly, if the tabled reading were meant:* that $S(W)=0$ implies $E_-$ isotropic, which needs (F1), (F2) and $\ker W=0$, all three of which the record documents as failing somewhere. *What would close the debt at the citation:* writing $S_{\mathfrak{mmm}}$, or "the $\mathfrak{mmm}$ block mass on $E_-$", in the L36 heading and in [results.md](../results.md):158 and :489, and adding an unsubscripted-$S$ row to [conventions.md](../findings/conventions.md) that says which of the two it resolves to.

**One consequence worth recording.** Since $S_{\mathfrak{mmm}}\equiv0$ whenever $\dim E_-\le2$, the premise (→) is **automatic** at $d\le2$ and the cap is vacuous there for every $n\ge3$. So L36 carries content only from $\dim E_-\ge3$ on, which is exactly the band [isotropy-cap.md](../findings/isotropy-cap.md) elsewhere calls the open half.

## 8. The forms compared, read one at a time as a consumer would (C10, C12)

| where | what it says about the maximiser | what it says about $n=3$ | carries the converse note? |
|---|---|---|---|
| [findings/isotropy-cap.md](../findings/isotropy-cap.md):17–, the canonical block | mixed planes $\mathbb R^p\otimes\mathbb R^q$, $p=\lceil n/2\rceil$, and a boxed correction naming $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ false twice over | claims "every $n\ge3$"; the $n=3$ spectral repair is **eight lines below the block** | **yes**, in the boxed correction |
| [results.md](../results.md):489, the canonical statement | mixed planes, with the full correction folded into the statement's own italic tail | claims "every $n\ge3$"; **no $n=3$ spectral note at all**, it points to the finding for the proof | **yes** |
| [results.md](../results.md):158, the landscape row | *"attained by the **balanced symmetric pair**"*, and nothing else | silent | **no** |
| [lean/INDEX.md](../lean/INDEX.md):267 + [L36.lean](../lean/HamiltonsCubic/Results/L36.lean) | `⌈n/2⌉·⌊n/2⌋ = ⌊n²/4⌋`, the shortfall `n/2`, and `⟨[φ₀₁,φ₁₂],φ₀₂⟩ ≠ 0` | silent | n/a |
| [findings/INDEX-results.md](../findings/INDEX-results.md):51 | mixed planes, correction stated, "No citation is damaged" | silent | **yes** |

**The Lean row is accurate and I state what it does and does not claim.** [L36.lean](../lean/HamiltonsCubic/Results/L36.lean) proves three things: `ceil_mul_floor`, the parity identity `((n+1)/2)*(n/2) = n^2/4` over `ℕ`; `so_sum_falls_short`, the shortfall written as `(k+1)*k + (k+1) = (k+1)^2` so no truncated subtraction enters; and `so_three_not_isotropic`, that `⟨[φ₀₁,φ₁₂],φ₀₂⟩ ≠ 0`, this last by `native_decide`, so it is not kernel-checked. The row says "**The cap itself is owed**", and that is correct: **no Lean artefact proves $\dim\mathfrak m\le\lfloor n^2/4\rfloor$.** *What the row would have to claim for the cap to be covered:* the Killing block identity of §2, the operator identity $\mu=\langle T(P),P\rangle$ of §3a, and the eigenvalue bound $\lambda_{\min}(T)=-2$ at $n\ge4$, the third being the representation-theoretic step and the only one that is not elementary. **No finding against the Lean row; it accurately reports its own scope.**

### 8a. DISCREPANCY, [results.md](../results.md):158 still names the refuted object (C10)

**Locate it exactly.** [results.md](../results.md):158: *"such a subspace of $\mathfrak{so}(n)$ has dimension at most $\lfloor n^2/4\rfloor$, **attained by the balanced symmetric pair**."*

**Exhibit the failure concretely.** Read "the balanced symmetric pair" as the pair's *subalgebra* $\mathfrak k$, the reading the phrase most naturally invites, and the one the first version of L36 actually made, and at $n=6$ it is $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$: dimension $\tfrac{6\cdot4}4=6$ against the cap $9$, and **not isotropic**, since §5 gives $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1\ne0$ inside one $\mathfrak{so}(3)$. Under that reading the clause is false twice over (wrong dimension and inadmissible object) which is exactly the correction [r517](../reviews/REVIEW_r517.md) and [r518](../reviews/REVIEW_r518.md) landed, recorded at :489 and in the finding, and **not propagated to :158**.

**Argue the opposite.** "Symmetric pair" can be read as shorthand for the pair's **odd part** $\mathfrak m=\mathbb R^p\otimes\mathbb R^q$, which is the correct maximiser, and [results.md](../results.md):489 six pages later says exactly that with the refutation attached. So :158 is compressed rather than wrong, recoverable, but **only by reading a different line in the same file**.

**Verdict: `GAP`, and it is this record's named trap.** The correction landed **beside** the statement it corrects: :489 was repaired, :158 was not, and a consumer citing the landscape row inherits the defect with no marker that a correction exists. The same pattern already cost this file once, [INDEX-results.md](../findings/INDEX-results.md):91 records L76's heading naming the subalgebra when "**the file already carried the correction 169 lines above, in [L36](../findings/isotropy-cap.md), applied the same day and never propagated**." **The repair here is three words**: ":158 should read *attained by the odd part of the balanced symmetric pair*", or simply *by the mixed planes $\mathbb R^{\lceil n/2\rceil}\otimes\mathbb R^{\lfloor n/2\rfloor}$*.

## 9. The gap between what is proven and what is used, and what a consumer may cite

**Proven, unconditionally, and rebuilt here from scratch:**

1. For **every** subspace $\mathfrak m\subseteq\mathfrak{so}(n)$ of dimension $d$, at every $n\ge4$: $\mu(\mathfrak m)\ge\tfrac{4d^2}n-2d$. No isotropy, no genericity, no criticality, no Weyl operator anywhere in the statement.
2. For every **isotropic** $\mathfrak m$: $2\mu+\gamma=2(n-2)d$ with $\gamma\ge0$ the $\mathfrak{hhm}$ mass, hence $\mu\le(n-2)d$.
3. Therefore, for every isotropic $\mathfrak m$ at $n\ge4$: $d\le\lfloor n^2/4\rfloor$. At $n=3$ the same conclusion holds by $\lambda_{\min}(T)=-1$, which is on the record but outside the block.
4. The cap is **attained at both parities** by $\mathbb R^{\lceil n/2\rceil}\otimes\mathbb R^{\lfloor n/2\rfloor}$, which is isotropic and of dimension $\lfloor n^2/4\rfloor$.

**Used but not proven inside the block:** the passage from "$S=0$ at a Weyl operator" to "$E_-$ is isotropic". Under the intended reading $S=S_{\mathfrak{mmm}}$ this is a tautology (§7b) and the gap is one of wording; under the tabled reading $S=S(W)$ it is conditional on (F1), (F2) and $\ker W=0$ and is **not** established.

**Open and correctly labelled open:** rigidity at the **odd** cap. Equality forces $\gamma=0$ only at even $n$, where §4b shows the sandwich closes exactly; at odd $n$ the chain leaves $\gamma\le\tfrac{n^2-1}{2n}$ and the block says so.

**What a consumer may cite, stated so it can be pasted:**

> Let $\mathfrak m\subseteq\mathfrak{so}(n)$, $n\ge4$, satisfy $\langle[u,v],w\rangle=0$ for all $u,v,w\in\mathfrak m$. Then $\dim\mathfrak m\le\lfloor n^2/4\rfloor$, with equality attained by the odd part $\mathbb R^p\otimes\mathbb R^q$ of the balanced symmetric pair, $p=\lceil n/2\rceil$, at both parities. At $n=3$ the cap reads $\dim\mathfrak m\le2$ and holds by the same chain with $\lambda_{\min}(T)=-1$. *(Lemma L36, [findings/isotropy-cap.md](../findings/isotropy-cap.md).)*

**What a consumer may not cite without adding a hypothesis:** the heading form "$S=0$ caps the negative eigenspace", unless $S$ is spelled out as the $\mathfrak{mmm}$ block mass on $E_-$; and [results.md](../results.md):158's "attained by the balanced symmetric pair", which must be read as that pair's odd part.

## 10. The named trap, each citable claim read alone

The instruction was to read each citable claim as a consumer would, in isolation, and say what it delivers on its own.

| read alone | delivers | inherits a defect? |
|---|---|---|
| The Statement paragraph of the block | the cap, the maximiser, both parities, and "every $n\ge3$" | **yes**, the proof beneath it is an $n\ge4$ argument, and the sentence "$-2$ is $T$'s only negative eigenvalue" that follows is false at $n=3$ |
| The Proof paragraph of the block | the full chain, correctly, with $\gamma$ properly defined | **yes**, the spectrum is stated as though $\mathrm{Weyl}_n$ and $\Lambda^4$ are always present; they are not at $n=3$ |
| The boxed correction | the mixed planes, the shortfall $n/2$, the inadmissibility, the failure of the converse | **no**, this box is correct and complete on every clause I checked |
| "**The whole content is one eigenvalue**" | a false universal | **yes**, C8, repaired eight lines below |
| "**It is Mantel's theorem in continuous form**" | the triangle-free reading, which §5 confirms exactly | **no**, but Mantel is not in [references/](../references/), so this claim rests on an unread source. It is interpretation, not proof, and nothing depends on it |
| "**What it does not reach**" | the even/odd asymmetry in rigidity, stated honestly | **no** |
| [results.md](../results.md):489 | statement, maximiser, both parities, converse note | **no**, apart from the $S$ ambiguity of §7b |
| [results.md](../results.md):158 | the cap, "attained by the balanced symmetric pair" | **yes**, C10, §8a |
| [conventions.md](../findings/conventions.md):38's $S(W)$ row | resolves the heading's "$S$" to the wrong object | **yes**, C9, §7b |

**Three claims fail when read alone, and all three fail the same way**: a correction exists on the record and sits *beside* the sentence rather than inside it, eight lines below for C8, six pages away for C10, in a different file for C9.

## 11. What would falsify the lemma, and what I did to look for it

**The object that would break the cap** is a subspace $\mathfrak m\subseteq\mathfrak{so}(n)$, isotropic for the Cartan 3-form, with $\dim\mathfrak m>\lfloor n^2/4\rfloor$. By §2 and §3d it would need either $\mu>(n-2)d$ under isotropy (impossible, since $\gamma\ge0$ is a manifest sum of squares) or $\mu<\tfrac{4d^2}n-2d$, which needs a $T$-eigenvalue below $-2$.

**How I looked.** I recomputed all four eigenvalues from $(\lambda,\lambda+2\rho)$ independently of the block (§3c); cross-checked the adjoint value $2n-4$ by two routes; checked the four Weyl multiplicities $10,35,84,168$ against the closed form; confirmed the four summands exhaust $\mathrm{Sym}^2(\Lambda^2)$ via L79's polynomial dimension identity, so no fifth eigenvalue can hide; and evaluated $\mu$ against the floor by hand on five structured families spanning the whole admissible range, from $d=\lfloor n/2\rfloor$ to $d=N$, where equality holds three times (at the maximal torus, at $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, and at the whole algebra) and would have exposed any normalisation or sign error at once. **I found no falsifier, and the search space for one is closed by the completeness of the curvature decomposition rather than by sampling.**

**The object that would break sharpness** is an $n$ at which $\lceil n/2\rceil\lfloor n/2\rfloor<\lfloor n^2/4\rfloor$. §5's two-row parity table shows there is none, and [L36.lean](../lean/HamiltonsCubic/Results/L36.lean)'s `ceil_mul_floor` machine-checks the same identity over `ℕ`.

**The object that would break the converse (←)** already exists and is on the record: any isotropic subspace of $\mathfrak{so}(3)$ of dimension $2$, since $\mathcal W_3=0$. §5 exhibits one explicitly.

## Verdict

**`PROVEN, hypotheses corrected`.**

The cap $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ for subspaces isotropic under the Cartan 3-form is **correct**, its two-step proof is **correct**, and I rebuilt every constant in it by hand: the Killing block identity, the operator identity $\mu=\langle T(P),P\rangle$, the reduction $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$, all four Casimir eigenvalues, the chain, and the maximiser at both parities. **Sharpness holds at both parities and the mixed planes are the right object**, exactly as the block's boxed correction says.

Three corrections are owed to the **statement**, none to the mathematics:

1. **§4d**, the proof as written is an $n\ge4$ argument, and the sentence "$-2$ is $T$'s only negative eigenvalue" is false at $n=3$. The conclusion survives at $n=3$ by $\lambda_{\min}(T)=n-4=-1$, which gives the *stronger* bound $\mu\ge d^2-d$ and hence $d\le2$. [INDEX-results.md](../findings/INDEX-results.md):94's claim that [L79](../findings/isotropy-cap.md) "repairs L36's $n\ge4$" **does not hold**: L79 is an eigenvalue table, and the fact needed at $n=3$ is about a *missing* summand.
2. **§7b**, the heading's unsubscripted "$S$" must be read as $S_{\mathfrak{mmm}}$ on $E_-$, under which the premise clause is a one-line tautology. [conventions.md](../findings/conventions.md):38 resolves the same symbol to the analytic gradedness slack $S(W)$ instead, for which the implication to isotropy is conditional on (F1), (F2) and $\ker W=0$, conditions the record documents as failing at named points. **`HYPOTHESIS-DEBT` on the headline form as cited**, discharged on the file form.
3. **§8a**, [results.md](../results.md):158 still reads "attained by the balanced symmetric pair", the refuted object under its natural reading; the correction lives at :489 and was not propagated.

**On the three pre-registered questions.** (1) The cap is right, the claimed maximiser is isotropic, its dimension is $\lfloor n^2/4\rfloor$ at both parities, and equality really holds at both. (2) The Casimir spectrum is right and the bound holds for **every** $d$-dimensional subspace at $n\ge4$; it is vacuous at $d\le1$, exactly tight at $d=N$ and at the even cap, and it is the step that carries no isotropy hypothesis. (3) Consumers need $S=0\Rightarrow$ isotropic; **nothing on the record uses the failing direction**, confirming [INDEX-results.md](../findings/INDEX-results.md):51's "no citation is damaged" by an independent trace.

*No computation of any kind was performed in this round.*
