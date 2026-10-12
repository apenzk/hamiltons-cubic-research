# Review 65, the isotropic-subspace cap

**Headline.** C2 is true and I can prove it. The bound $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ follows from two lemmas, one of which is the Killing-form identity the programme already uses and the other of which is a single eigenvalue statement about an $SO(n)$-equivariant operator on $\mathrm{Sym}(\mathfrak{so}(n))$. The same equality analysis proves C3 for even $n$. Against that, **C5 is refuted**: the claimed gap at $d=8$ does not exist, and the counterexample is the symmetric pair $\mathfrak{so}(2)\oplus\mathfrak{so}(4)$.

| Claim | Verdict |
|---|---|
| C1 $S=0\iff\mathfrak m$ isotropic | **CONFIRMED** (one caveat about eigenvalues at $0$) |
| C2 $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ | **CONFIRMED, proved**, all $n\ge3$, no dimension restriction |
| C3 rigidity at the cap | **CONFIRMED for even $n$ (proved)**; **PLAUSIBLE for odd $n$** (80/80 numerically, one gap in the argument) |
| C4 maximality $=$ rank identity | **CONFIRMED**, and strengthened |
| C5 spectrum $\{5,6,7,9\}$, gap at 8 | **REFUTED**, the true $n=6$ spectrum contains $\{5,6,7,8,9\}$ |
| C6(a) $S=0$ invisible to the LP | **CONFIRMED** independently (40/40 spectra) |
| C6(b) $6S_{mmm}+4S_{mmh}+2S_{mhh}=2d(n-2)$ | **CONFIRMED**, multiplicities correct |

Everything below is from my own implementation ([review_r65_lib.py](../scripts/review_r65_lib.py) and siblings); no `b0_*`/`b_*` script was read or run.

---

## C2, PROVED

Write $\mathfrak g=\mathfrak{so}(n)$, $N=\dim\mathfrak g$, $\{f_i\}$ an orthonormal basis, $c_{ijk}=\langle[f_i,f_j],f_k\rangle$ (totally antisymmetric). For a subspace $\mathfrak m$ of dimension $d$ with orthonormal basis $\{e_a\}$ and orthoprojector $P$, define the **bracket mass**
$$\mu(\mathfrak m)\;=\;\sum_{a,b}\bigl|[e_a,e_b]\bigr|^2 .$$

### Lemma L1 (isotropy caps the bracket mass). If $\mathfrak m$ is isotropic then $\mu(\mathfrak m)\le(n-2)\,d$.

Isotropy says $P\,\mathrm{ad}(X)\,P=0$ for $X\in\mathfrak m$, so in the block form for $\mathfrak g=\mathfrak m\oplus\mathfrak h$, $\mathfrak h=\mathfrak m^\perp$,
$$\mathrm{ad}(X)=\begin{pmatrix}0&-B_X^{\!\top}\\ B_X&C_X\end{pmatrix},\qquad \mathrm{tr}\,\mathrm{ad}(X)^2=-2\|B_X\|_F^2-\|C_X\|_F^2 .$$
The Killing form of $\mathfrak{so}(n)$ is $\mathrm{tr}(\mathrm{ad}X\,\mathrm{ad}Y)=(n-2)\mathrm{tr}(XY)=-2(n-2)\langle X,Y\rangle$, so $2\|B_X\|_F^2+\|C_X\|_F^2=2(n-2)|X|^2$. Summing over $\{e_a\}$ and using $[e_a,e_b]\in\mathfrak h$ automatically,
$$\boxed{\,2\mu(\mathfrak m)+\gamma=2(n-2)d\,},\qquad \gamma:=\sum_a\|C_{e_a}\|_F^2\ \ge 0. $$
This is the same identity as C6(b) with $\alpha=0$; the programme already has it.

### Lemma L2 (every subspace has bracket mass at least $4d^2/n-2d$).

$\mu(\mathfrak m)=\langle T(P),P\rangle$ where $T(A)=-\sum_k \mathrm{ad}(f_k)\,A\,\mathrm{ad}(f_k)$ on $\mathrm{Sym}(\mathfrak g)$. With $\rho(X)A=[\mathrm{ad}X,A]$ and $\sum_k\mathrm{ad}(f_k)^2=-2(n-2)\mathrm{Id}$,
$$T \;=\; 2(n-2)\,\mathrm{Id}-\tfrac12\,\mathrm{Cas},$$
so $T$ acts on each irreducible summand of $\mathrm{Sym}(\mathfrak g)$ by $2(n-2)-c_\lambda/2$. As an $SO(n)$-module
$$\mathrm{Sym}\bigl(\Lambda^2\mathbb R^n\bigr)=\mathbb R\cdot\mathrm{Id}\ \oplus\ \mathrm{Sym}^2_0(\mathbb R^n)\ \oplus\ \mathcal W\ \oplus\ \Lambda^4\mathbb R^n,$$
with Casimirs $0,\;2n,\;4n-4,\;4n-16$ in the normalisation $c(\Lambda^2)=2(n-2)$, hence $T$-eigenvalues
$$2n-4\ \ (\mathrm{Id}),\qquad n-4\ \ (\mathrm{Sym}^2_0),\qquad -2\ \ (\text{Weyl}),\qquad 4\ \ (\Lambda^4).$$
So $T(\mathrm{Id})=(2n-4)\mathrm{Id}$ and $T\succeq-2$ on $\mathrm{Id}^\perp$ for $n\ge4$. Splitting $P=(d/N)\mathrm{Id}+P_0$,
$$\mu(\mathfrak m)\;\ge\;(2n-4)\frac{d^2}{N}-2\Bigl(d-\frac{d^2}{N}\Bigr)\;=\;\frac{(2n-2)d^2}{N}-2d\;=\;\frac{4d^2}{n}-2d .$$

### Theorem. An isotropic subspace of $\mathfrak{so}(n)$ has $\dim\mathfrak m\le n^2/4$.

$\dfrac{4d^2}{n}-2d\le(n-2)d\iff \dfrac{4d}{n}\le n\iff d\le\dfrac{n^2}{4}$. $\blacksquare$

Attained by $\mathfrak{so}(\lfloor n/2\rfloor)\oplus\mathfrak{so}(\lceil n/2\rceil)$, so the bound is $\lfloor n^2/4\rfloor$ and is sharp.

### Why this is the right proof: it is Mantel's theorem

On a *monomial* subspace (the span of $\{\varphi_e\}$ for an edge set $S\subseteq K_n$), the 3-form is supported on triangles, so isotropic $=$ triangle-free, and $\mu=\sum_v d_v(d_v-1)$. Lemma L1 becomes $\sum_v d_v(d_v-1)\le(n-2)|S|$ and Lemma L2 becomes Cauchy–Schwarz $\sum_v d_v^2\ge 4|S|^2/n$. Together: $|S|\le n^2/4$, which is Mantel's theorem, with the extremal graph $K_{n/2,n/2}$ matching the extremal symmetric pair. **C2 is the exact continuous analogue of Mantel's theorem, and Lemma L2 is what replaces Cauchy–Schwarz.** Its whole content is the single eigenvalue $-2$.

### Verification

[review_r65_c2_operator.py](../scripts/review_r65_c2_operator.py) builds $T$ and diagonalises it; the spectrum matches the prediction **exactly**, multiplicities included, for $n=3,\dots,12$:

| $n$ | $\dim\mathrm{Sym}$ | eigenvalues $\times$ multiplicity | $\lambda_{\min}$ |
|---|---|---|---|
| 4 | 21 | $-2\times10,\;0\times9,\;4\times2$ | $-2$ |
| 6 | 120 | $-2\times84,\;2\times20,\;4\times15,\;8\times1$ | $-2$ |
| 7 | 231 | $-2\times168,\;3\times27,\;4\times35,\;10\times1$ | $-2$ |
| 9 | 666 | $-2\times495,\;4\times126,\;5\times44,\;14\times1$ | $-2$ |
| 10 | 1035 | $-2\times770,\;4\times210,\;6\times54,\;16\times1$ | $-2$ |

($n=3$ has no Weyl summand and gives $\lambda_{\min}=-1$; the resulting bound is $d\le2=\lfloor9/4\rfloor$, still correct.) [review_r65_c2_proof.py](../scripts/reviewers/r65/review_r65_c2_proof.py) then checks, for $n=3..8$: $\mu=\langle T(P),P\rangle$ to $10^{-13}$; Lemma L2 on every dimension with random subspaces (minimum slack $-10^{-13}$, i.e. zero); Lemma L1 on all symmetric pairs (equality, $\gamma=0$); and prints the bound the chain yields, $2.000,\,4.000,\,6.250,\,9.000,\,12.250,\,16.000$ at $n=3..8$, whose floors are exactly $\lfloor n^2/4\rfloor$.

### A quantitative by-product: how badly the search at $\lfloor n^2/4\rfloor+1$ must fail

Dropping the assumption $\alpha=0$, the same two lemmas give $\alpha=2\mu+\gamma-2(n-2)d\ge 2\mu-2(n-2)d$, so **every** $d$-dimensional subspace has 3-form mass
$$\alpha\;=\;\sum_{a,b,c\in\mathfrak m}c'^2_{abc}\;\ge\;\frac{2d}{n}\bigl(4d-n^2\bigr).$$
This is $0$ exactly when $d\le n^2/4$ (it re-proves C2) and positive beyond. At $n=5$, $d=7$ it reads $\alpha\ge 42/5=\mathbf{8.4}$, **exactly the residual the programme reports its optimiser gets stuck at**, so that number is not a numerical artefact: it is the optimum, and the optimiser is converging to the true global minimum. My own independent search agrees, and extends the evidence to $n=7,8$:

| $n$ | $d=\lfloor n^2/4\rfloor$ | $d=\lfloor n^2/4\rfloor+1$ | proof's floor at $d+1$ |
|---|---|---|---|
| 5 | $3.7\times10^{-21}$, 60/60 isotropic | $8.400$, 0/60 | $8.400$ (**attained**) |
| 6 | $5.5\times10^{-21}$, 60/60 | $16.55$, 0/60 | $13.33$ |
| 7 | $7.0\times10^{-21}$, 30/30 | $17.64$, 0/30 | $11.14$ |
| 8 | $8.4\times10^{-21}$, 15/15 | $23.94$, 0/15 | $17.00$ |

(The programme's reported $8.4$ and $16.6$ at $n=5,6$ are reproduced to three digits by an independently written optimiser; the $n=7,8$ rows are new.)

### What I attacked and failed to break

Before finding the proof I looked for a counterexample at $\lfloor n^2/4\rfloor+1$: Adam-on-Stiefel with QR retraction from many random starts ([review_r65_c2_search.py](../scripts/review_r65_c2_search.py)), symmetric pairs enlarged by elements of $\mathfrak h$ (impossible whenever $[\mathfrak m,\mathfrak m]=\mathfrak h$, which holds for every symmetric pair, checked at $n=6,7,8$), abelian subalgebras (dead end: in a *compact* Lie algebra every maximal abelian subalgebra is a maximal torus, so $\dim\le\lfloor n/2\rfloor$), and subalgebra-based constructions (dead end: an isotropic subalgebra is abelian, since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m\cap\mathfrak m^\perp=0$). All failed, and now provably had to.

A weaker bound also drops out of the block identities alone and is worth recording as a cross-check: $\alpha+2\beta+\gamma=2(n-2)d$ and $\beta+2\gamma+\delta=2(n-2)(N-d)$ with $\alpha=0$ give $\delta=3\beta+2(n-2)(N-3d)$, so $\delta\ge0$ and $\beta\le(n-2)d$ force $d\le 2N/3=n(n-1)/3$. That is strictly weaker than $n^2/4$ for $n\ge7$; the representation-theoretic Lemma L2 is what closes the gap.

---

## C3, proved for even $n$, one gap at odd $n$

The chain of C2 gives, for any isotropic $\mathfrak m$,
$$\tfrac{\gamma}{2}\;\le\;nd-\tfrac{4d^2}{n}\;=\;\tfrac{d}{n}\,(n^2-4d).$$

**Even $n$, $d=n^2/4$:** the right-hand side is $0$, so $\gamma=0$, i.e. $\langle[\mathfrak h,\mathfrak h],\mathfrak m\rangle=0$, i.e. $\mathfrak h$ is a subalgebra; invariance of $\langle\cdot,\cdot\rangle$ then gives $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, so $(\mathfrak h,\mathfrak m)$ is a symmetric pair and $\mathfrak m$ is the $(-1)$-eigenspace of an involution $\sigma\in\mathrm{Aut}(\mathfrak{so}(n))$. Cartan's classification leaves $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ ($\dim\mathfrak m=pq$) and $\mathfrak u(k)\subset\mathfrak{so}(2k)$ ($\dim\mathfrak m=k(k-1)$); only $p=q=n/2$ reaches $n^2/4$. For $n=8$ the triality-outer involutions have $(-1)$-eigenspace of dimension $7$ or $15$, never $16$, so $\sigma$ is inner there too. $O(n)$-conjugacy upgrades to $SO(n)$-conjugacy because $O(p)\times O(q)$ contains orientation-reversing elements preserving $\mathfrak m$. **This is exactly C3, for even $n$, the case their $n=6$ and $n=8$ numerics tested.**

**Odd $n$:** the cap is $(n^2-1)/4$ and the inequality only gives $\gamma\le 2d/n$, positive. So the argument does not close, and C3 at odd $n$ is *not* proved here. I tested it instead: [review_r65_c3_odd.py](../scripts/reviewers/r65/review_r65_c3_odd.py) polished 40 isotropic subspaces at the cap for each of $n=5$ and $n=7$; **every one has $\gamma$ within $6\times10^{-14}$ of $0$**, hence is a symmetric pair, hence (since $6=2\cdot3$ and $12=3\cdot4$ are each realised by one $p$ only) conjugate to the standard one. So C3 holds at odd $n$ empirically, and the missing step is precisely "$\gamma=0$ is forced at $d=(n^2-1)/4$".

I did **not** find two inequivalent isotropic subspaces at the cap, and for even $n$ none exist.

---

## C5, REFUTED, and C4 confirmed and strengthened

**C4 is right, including the part flagged as doubtful.** Enlarging isotropic $\mathfrak m$ by $w$ needs $\omega$ to vanish on all triples from $\mathfrak m+\mathbb Rw$; a triple containing $w$ twice vanishes by antisymmetry, so **the new vector's own brackets impose no extra condition** and the extension condition is exactly the linear system $w\perp[\mathfrak m,\mathfrak m]$. Since isotropy already gives $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp$, $\mathrm{rank}[\mathfrak m,\mathfrak m]\le N-d$ holds automatically, and maximal $\iff$ $\mathrm{rank}[\mathfrak m,\mathfrak m]=N-d$. Confirmed.

**Strengthening they missed:** $\mathrm{rank}[\mathfrak m,\mathfrak m]\le\binom d2$, so maximality *forces* $d(d+1)/2\ge N$. At $n=6$ that rules out $d\le4$ outright, the $d=2,3,4$ rows are a theorem, not a 14/14 statistic, and no amount of extra search effort can change them.

**The gap at $d=8$ does not exist.** The symmetric pair $\mathfrak{so}(2)\oplus\mathfrak{so}(4)\subset\mathfrak{so}(6)$ has off-block part of dimension $2\cdot4=8$, is isotropic (residual $0$ exactly, it is a monomial subspace), and has $\mathrm{rank}[\mathfrak m,\mathfrak m]=7=N-d$, **maximal**. So $8$ is in the spectrum and the claimed gap is false. More generally *every* symmetric pair gives a maximal isotropic subspace, verified at $n=6,7,8$:

| $n$ | maximal isotropic dimensions from symmetric pairs |
|---|---|
| 6 | $5,\;6\;(\mathfrak u(3)),\;8,\;9$ |
| 7 | $6,\;10,\;12$ |
| 8 | $7,\;12\;(\mathfrak u(4)),\;12,\;15,\;16$ |

**Why the census missed it.** My run of the same experiment reproduces their table exactly, at $d=8$, 20/20 polished random draws give $\mathrm{rank}[\mathfrak m,\mathfrak m]=6$, not $7$, so all of them extend. Generic $8$-dimensional isotropic subspaces are hyperplanes inside $9$-dimensional cap subspaces, and the maximal ones at $d=8$ form a positive-codimension set that random polishing never lands on. **The census method systematically under-reports the spectrum**; a row reading "EXTENDS $k/k$" is evidence about the generic stratum only, never about the spectrum. The $n=6$ spectrum contains at least $\{5,6,7,8,9\}$ and the burden is now on showing that any $d$ is *absent*.

The same correction applies to the $d=7$ row: "maximal 13/14" is a statement about the generic stratum, and it happens to be the one row where the generic answer and the spectrum agree.

---

## C1 and C6

**C1, CONFIRMED.** $S=\sum c'^2$ over triples of negative indices is a sum of squares, so $S=0$ iff every $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ with all three indices negative vanishes, which is exactly $\omega|_{\mathfrak m}=0$. Ordered versus unordered triples changes only a factor $6$. It is also basis-independent inside $\mathfrak m$ ($S$ is $\|\omega|_{\mathfrak m}\|^2$) so eigenvalue degeneracies are harmless. **The one caveat:** "negative eigenspace" is a strict inequality, so $S$ jumps discontinuously when an eigenvalue crosses $0$ and $\mathfrak m$ changes dimension. Any argument that uses $S$ across a compactness or continuity step has to handle the zero-eigenvalue boundary explicitly.

**C6(b), CONFIRMED, multiplicities right.** With $S_{mmm},S_{mmh},S_{mhh}$ read as sums over *unordered* triples, $6S_{mmm}=\alpha$, $4S_{mmh}=2\beta$, $2S_{mhh}=\gamma$, and the identity is exactly $\alpha+2\beta+\gamma=2(n-2)d$, the row-marginal identity, which holds for *every* subspace, isotropic or not. [review_r65_c1c6.py](../scripts/reviewers/r65/review_r65_c1c6.py) verifies it and its partner $\beta+2\gamma+\delta=2(n-2)(N-d)$ to $10^{-14}$ at $n=4..7$ on random and structured subspaces. The qualitative rider (deleting the $(---)$ mass pushes it into $(+--)$, which raises $\theta$), is right *for the relaxation*; it is a statement about the LP optimum, not about genuine Weyl tensors, and should be phrased that way.

**C6(a), CONFIRMED independently.** [review_r65_c6_lp.py](../scripts/reviewers/r65/review_r65_c6_lp.py) rebuilds the transportation LP from scratch (nonnegative totally symmetric $T$, row marginal $n-2$ per index, pair cap $2$) and solves it with and without $T=0$ on all-negative triples, for 40 spectra at $n=6,7$ with $3$ to $8$ negatives. In **every** case the $(---)$ mass at the optimum is exactly $0$ and the two optima agree to $<10^{-7}$. So $S=0$ really is invisible to the relaxation.

*One correction to the stated reasoning.* "Those triples carry $\lambda_\alpha\lambda_\beta\lambda_\gamma<0$, so a maximiser empties them anyway" is not forced by the sign pattern alone: for a negative index $\alpha$ the row marginal is an *equality* and, once $2(k-1)<n-2$ (e.g. $n=7$ with $k=3$ negatives), every cell left in that row also has negative cost, so mass has to sit somewhere unprofitable. The reason it lands on $(-++)$ rather than $(---)$ is a magnitude comparison, not a sign count. The conclusion survives (I measured it) but the one-line justification does not.

---

## Summary for the programme

1. **C2 is a theorem.** Two lemmas, both short; the only non-elementary input is the branching of $\mathrm{Sym}(\Lambda^2\mathbb R^n)$ and the resulting eigenvalue $-2$, and that is a finite check at every $n$ one cares about (done here to $n=12$). No dimension restriction, no genericity hypothesis, sharp at the symmetric pair.
2. **C3 falls out of the same computation for even $n$**, which covers both $n$ they tested. Odd $n$ needs "$\gamma=0$ at $d=(n^2-1)/4$" and I could not prove it; 80/80 numerical draws say it is true.
3. **C5 is wrong at $d=8$** and its method is unsound for spectrum claims. Rewrite the row as "generic isotropic subspaces of dimension $d$ extend", and take the spectrum from symmetric pairs plus whatever else can be exhibited.
4. **Gap I believe but did not prove:** the identification of $\mathrm{Sym}(\mathfrak{so}(n))$'s four summands and their Casimirs is standard, but I verified it numerically rather than deriving the branching. If C2 is to be written up, that decomposition should be quoted from a reference (or the inequality $T\succeq-2$ on $\mathrm{Id}^\perp$ proved directly).


---

## Synthesis carried in REVIEW.md

### Reviewer 65: the isotropy cap, proved

Full report in [reviews/REVIEW_r65.md](reviews/REVIEW_r65.md).

**Proved C2**, the load-bearing conjecture, for all $n\ge3$, sharp and with no genericity hypothesis. Two lemmas: isotropy gives $\mu(\mathfrak m)=\sum\|[e_a,e_b]\|^2\le(n-2)d$ from the Killing block identity $2\mu+\gamma=2(n-2)d$; and **every** $d$-dimensional subspace has $\mu\ge4d^2/n-2d$, since $\mu=\langle T(P),P\rangle$ for $T(A)=-\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$. Chaining gives $d\le n^2/4$. **The whole content is one eigenvalue**: $T$ acts on $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ by $2n-4$, $n-4$, $-2$, $4$, so the Weyl tensors are exactly its $-2$ eigenspace, verified here with multiplicities matching to the digit at $n=4,\dots,7$.

**Rigidity for even $n$ falls out**: equality forces $\gamma=0$, so $\mathfrak m^\perp$ is a subalgebra, hence a symmetric pair, and Cartan leaves only $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$. Triality at $n=8$ is handled, outer involutions give $\dim\mathfrak m\in\{7,15\}$, never $16$. Odd $n$ remains open, needing $\gamma=0$ forced at $d=(n^2-1)/4$.

**A by-product that reinterprets this project's own evidence.** The proof yields a floor $\alpha\ge(2d/n)(4d-n^2)$ on the 3-form mass, which at $n=5$, $d=7$ is exactly $8.4$, the value an earlier gradient search stalled at. That search had found the true global minimum, so the negative evidence was stronger than it was recorded as being.

**Named gaps**: the branching of $\mathrm{Sym}(\Lambda^2\mathbb R^n)$ and its Casimir values were verified numerically rather than derived, and $T\succeq-2$ on $\mathrm{Id}^\perp$ should be proved directly in a write-up.
