# Reviewer 332, the invariant census, post F42, and the Cauchy–Schwarz bound on $G_2$

**Cold brief, independent build.** Everything below is computed from $\mathfrak{so}(n)$, the structure constants, $\#$ and $\mathcal W_n$ rebuilt from their definitions in [scripts/reviewers/r332/](../scripts/reviewers/r332/); no script of the record was read or run, and [scripts/reviewers/r331/](../scripts/reviewers/r331/) was not opened. Build validation: $\dim\mathcal W_6=84$ from the constraint nullspace; $S^3\times S^3$, $S^4\times S^4$, $S^3\times S^5$ and padded $W_{\mathbb{CP}^2}$ reproduce $\theta=1.054092553$, $1.145643924$, $\sqrt{56/45}=1.115546702$, $\sqrt{3/2}=1.224744871$ with criticality residuals $\le3\times10^{-16}$, and (A), (B), (C) hold at every one of them to $\le2\times10^{-14}$. Conventions: $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$, $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ in $W$'s eigenbasis, $T=c^2$, all contractions $\sum_{abc}$ over ordered index triples.

| claim | verdict |
| --- | --- |
| **Q1** (A),(B),(C) is all the per-index linear data | **CONFIRMED for every mechanism the brief names**, Bianchi, Jacobi, off-diagonal criticality and the Casimirs each yield nothing linear in $T$ beyond the three. **But the census question itself is ill-posed as stated**: what is pinned depends on the spectrum's value structure, and at every catalogued point above $\sqrt{3/2}$ the "free" invariant is in fact determined |
| **Q2(i)** the pinned reductions | **CONFIRMED**, $\{3,1,0\}$ and $\{2,1,1\}$ written out below |
| **Q2(ii)** "$\{2,2,0\}$ is the first free pattern" | **REFUTED AS STATED, repaired**, true in the weight-span sense for value-generic spectra (exact rank certificates); false at every $\le2$-value spectrum, where a fourth per-index relation follows from (A),(B) by the minimal polynomial; and the operationally pinned set (with $T\ge0$) is wider still |
| **Q3** post F42's empirical premise | **REFUTED AS STATED**, r324 measured a one-row sub-relaxation, not "the full pinned relaxation", and a looser LP's high ceiling cannot establish that the tighter full LP fails |
| **Q4** freeness of $\{2,2,0\}$ | **PROVED at the formal level**, an exact rational pair $T\ne T'$, same $(\lambda,\theta)$, all rows of (A),(B),(C), $S_{22}=11480/17$ against $18592/23$. Realizability-level freeness **UNDECIDED**, and the catalogue cannot decide it: its only same-$(\lambda,\theta)$ pairs are triality pairs, which are bracket-isomorphic and agree on every $T$-functional |
| **Q5(i)** $S_{22}$ basis-free | **CONFIRMED**, proof supplied: the sum is $\lVert C\circ(W\otimes W)\rVert_{HS}^2$ for the bracket $C$ |
| **Q5(ii)** equality iff $\lambda_k^2$ constant on $\operatorname{supp}(g)$ | **REFUTED AS STATED, repaired**, equality iff $\lambda_k$ is constant on $\operatorname{supp}(g)$; the $\lambda^2$ version admits mixed-sign support and is false there |
| **Q5(iii)** exact at the balanced product | **CONFIRMED in substance, deflated**, the cited support fact needs Lemma L71's symmetric-pair structure for the $E_{\max}$ rows, and the exactness is *forced*: at any two-value spectrum (A),(B),(C) pin $G_2=4\theta^2/(n-1)$ identically, so the bound is an identity there and discriminates nothing |
| **Q5(iv)** the padded-$W_{\mathbb{CP}^2}$ refutation | **CONFIRMED and STRENGTHENED**, the arithmetic checks ($4\theta\sqrt6=12$, target $8(n-2)/n^2$), $\Delta=0$ is recorded on the $\{\lambda>0\}$ branch ([bounds.md](../findings/bounds.md), the padding-artefact paragraph), and the true statement is stronger: $G_2=2$ **exactly**, pinned by (A),(B),(C) alone, every padding, no $\Delta$, no support argument |

**The one-sentence summary.** The three relations are the complete list of *independent* linear per-index constraints, but "pinned" is not a property of a weight pattern alone, it is a property of the pattern *and the spectrum's value structure, and the positivity $T\ge0$*, and by that corrected criterion the record's showcase quantity $S_{22}$ is determined at the balanced products, at padded $W_{\mathbb{CP}^2}$, at $S^3\times S^5$ and at $\mathbb{HP}^2$, i.e. at every catalogued point at or above $\sqrt{3/2}$ that was tested, and genuinely free at generic low-$\theta$ critical points. Post F42's elimination test ("name the weight pattern, two exponents $\le1$ closes it") is therefore unsound in both directions.

---

## 0. The frame all five questions share

Every per-index quantity linear in $T$ with polynomial $\lambda$-weights is one of $m_{ij}(k):=\sum_{\beta\gamma}\lambda_\beta^i\lambda_\gamma^jT_{k\beta\gamma}=\pm\operatorname{tr}\!\big(\mathrm{ad}(\varphi_k)W^i\,\mathrm{ad}(\varphi_k)W^j\big)$, symmetric in $(i,j)$. The record's three are $m_{00}$ (Killing), $m_{10}$ (Bianchi + Ricci-flat), $m_{11}$ (criticality). A fourth relation means: some $m_{ij}$ with $\max(i,j)\ge2$ is a function of $(\lambda_k,\lambda,\theta)$. The smallest candidate is $m_{20}=R_k=\sum\lambda_\beta^2T_{k\beta\gamma}$, and pinning it pins every $\{p,2,0\}$ pattern including $\{2,2,0\}$, since $S_{22}=\sum_k\lambda_k^2R_k$.

## 1. Q1, the hunt for a fourth relation, mechanism by mechanism

### 1.1 First Bianchi: fully consumed by one operator identity, whose linear-in-$T$ content is exactly (B)

Let $\Phi(X):=\sum_a\mathrm{ad}(\varphi_a)\,X\,\mathrm{ad}(\varphi_a)$ over any orthonormal basis of $\mathfrak{so}(n)$, basis-independent and $O(n)$-equivariant. Writing the Casimir on $\mathrm{Hom}(\Lambda^2,\Lambda^2)$ as $C(X)=\sum_a[\mathrm{ad}_a,[\mathrm{ad}_a,X]]=-4(n-2)X-2\Phi(X)$ and using $c_2(\mu)=\sum_i\mu_i(\mu_i+n-2i)$, $\Phi$ acts on the four $O(n)$-components of the symmetric operators on $\Lambda^2$ by the scalars

| component | $\mu$ | $c_2$ | $\Phi$-scalar $\tfrac12c_2-2(n-2)$ |
| --- | --- | --- | --- |
| Weyl | $(2,2)$ | $4(n-1)$ | $\mathbf{2}$ |
| $\Lambda^4$ | $(1,1,1,1)$ | $4(n-4)$ | $-4$ |
| Ricci-type | $(2)$ | $2n$ | $4-n$ |
| scalar | $0$ | $0$ | $-2(n-2)$ |

Screened at $n=6$: residuals $\le7\times10^{-16}$ on all four components ([t_screen1.py](../scripts/reviewers/r332/t_screen1.py), with the Weyl case retested on Kulkarni–Nomizu-built elements). Since $2$ differs from the other three scalars for $n\ge5$, **first Bianchi plus Ricci-flatness is equivalent to the single matrix identity $\Phi(W)=2W$**. Its diagonal in $W$'s eigenbasis is $-\sum_{a\beta}\lambda_\beta T_{ka\beta}=2\lambda_k$, relation (B), so (B) uses Bianchi as well as Ricci-flatness, as [r324's §5.1 derivation](REVIEW_r324.md) already shows. Its off-diagonal entries are $\sum_{a\beta}\lambda_\beta c_{ka\beta}c_{la\beta}=0$ for $k\ne l$, cross-products, not functions of $T$. By Schur, any *linear* universal identity evaluated on the irreducible Weyl component returns a multiple of $W$, so no linear-in-$W$ mechanism can produce anything beyond (B). **Nothing further from Bianchi.**

### 1.2 Jacobi: the contractions that close onto squares are identities $0=0$

Jacobi is $\sum_d(c_{abd}c_{dce}+c_{bcd}c_{dae}+c_{cad}c_{dbe})=0$. A consequence linear in $T$ requires each product $c_Xc_Y$ to survive contraction with $X=Y$ as index sets. The two ways to arrange that both die:

- Setting $(c,e)=(a,b)$: the three terms give $\sum_dT_{abd}-\sum_dT_{abd}+0=0$ identically, by $c_{dab}=c_{abd}$, $c_{bad}=-c_{abd}$.
- Setting $e=b$, summing over $b$ with any weight $u(\lambda_b)$ or $u(\lambda_d)$: the first two terms cancel pairwise after $c_{dcb}=-c_{bcd}$, again identically.

The residual force of Jacobi is sign-sensitive (it constrains the signed $c$, and $T=c^2$ forgets exactly the signs) so its consequences on $T$ are the *nonlinear* realizability constraints, which is where [the record's own moment-problem paragraph](../findings/bounds.md) now locates the open door. **No linear fourth from Jacobi.**

### 1.3 Off-diagonal criticality: no linear-in-$T$ content, before or after averaging

Criticality's off-diagonal part is $M_{kl}=\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ for $k\ne l$. Every entry is bilinear in two *different* rows of $c$; no linear functional of the off-diagonal entries is a function of $T$. Averaging over an eigenspace's orthonormal frames sends $c_{k\alpha\beta}c_{l\alpha\beta}\mapsto\delta_{kl}\cdot(\text{average})$, i.e. the off-diagonal averages to zero, which it already is. The diagonal is (C). **Nothing new.**

### 1.4 Higher Casimirs: the $\lambda^2$-weighted row is the diagonal of $\Phi(W^2)$, and that is free tensor data

$R_k=-\langle\varphi_k,\Phi(W^2)\varphi_k\rangle$. $\Phi$ acts by the scalars above, but $W^2$ is not in one component: it carries scalar, Ricci-type, Weyl and $\Lambda^4$ parts, and the last three are full tensors that no spectral datum determines. At criticality $W^2=\theta W-W^\#$, so $\Phi(W^2)=2\theta W-\Phi(W^\#)$, and pinning $R_k$ is equivalent to a universal reduction of $\Phi(W^\#)$, no such identity exists among the equivariant quadratics available, and the quartic Casimir proper produces $W$-independent identities *quartic* in $c$ (four $\mathrm{ad}$'s), never linear in $T$. **The quartic Casimir does not pin $\{p,2,0\}$, and the census's headline survives this attack.**

### 1.5 The caveat that reframes the whole question

A "fourth relation" need not be independent: at any spectrum with two distinct values $\{s,-m\}$, $\lambda^2=(s-m)\lambda+sm$ holds *pointwise on the spectrum*, so

$$R_k=(s-m)\underbrace{\textstyle\sum\lambda_\beta T_{k\beta\gamma}}_{-2\lambda_k}+sm\underbrace{\textstyle\sum T_{k\beta\gamma}}_{2(n-2)}=-2(s-m)\lambda_k+2(n-2)sm$$

**is a per-index relation pinning the $\{*,2,0\}$ rows, a consequence of (A) and (B), active at exactly the conjectured extremum's spectrum.** The complete-list claim is true (three independent generators), but its operative reading, "therefore $\{2,2,0\}$ is free", is a spectrum-dependent claim, audited in §2. What would decide absolute completeness at the critical-point level is two critical points sharing $(\lambda,\theta)$ and differing in some $T$-contraction; the catalogue's only same-$(\lambda,\theta)$ pairs ($\mathbb{HP}^2$/$S^3\times S^5$, $\mathbb{CP}^4$/$S^2\times S^6$, per [target.md](../findings/target.md)) are related by the $\mathfrak{so}(8)$ outer automorphism, which preserves brackets and the inner product, so their $T$'s coincide entirely and they can never decide it.

## 2. Q2, the pinned classification, both directions

### 2.1 The reductions (direction i), CONFIRMED

With $T$ totally symmetric, a monomial contraction only sees the symmetrized weight, so the exponent-$\ge2$ slot may be relabelled onto the free index:

- $\{3,1,0\}$: $\sum_{abc}\lambda_a^3\lambda_bT_{abc}=\sum_k\lambda_k^3\big(\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}\big)=\sum_k\lambda_k^3(-2\lambda_k)=-2p_4(\lambda)$, (B) with $f=\lambda^3$.
- $\{2,1,1\}$: $\sum_{abc}\lambda_a^2\lambda_b\lambda_cT_{abc}=\sum_k\lambda_k^2\big(\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}\big)=\sum_k\lambda_k^2\cdot2\lambda_k(\theta-\lambda_k)=2\theta p_3-2p_4$, (C) with $f=\lambda^2$.

### 2.2 The freeness direction (ii), REFUTED AS STATED; the correct statement is a stratification

The span question is finite: on a spectrum with distinct values $v_1,\dots,v_r$, a functional is in the (A),(B),(C) span iff its symmetrized weight, *restricted to the value-triples realizable by distinct indices*, equals $\mathrm{Sym}[f(x)]+\mathrm{Sym}[g(x)(y+z)]+\mathrm{Sym}[h(x)yz]$ for some functions $f,g,h$ on the values. Exact rank computations (rational arithmetic, [the log](../agent_logs/r332-census.log) and §2.3's scripts) give:

| spectrum class | $\mathrm{Sym}[x^2y^2]$ in the span? | consequence |
| --- | --- | --- |
| $2$ distinct values | **yes** (rank $4=4$; also directly by §1.5's minimal-polynomial relation) | *everything* is pinned at the balanced products, $G_2=(s-m)(-4\theta)+4(n-1)sm$, which at the balanced point equals $4\theta^2/(n-1)$ exactly |
| $\{s^1,m^2,0^K\}$, $\mathrm{mult}(s)=1$ (padded $W_{\mathbb{CP}^2}$) | **yes on the realizable triples**, $\mathrm{mult}(s)=1$ removes the $(s,s,\cdot)$ triples and the remaining six value-triples admit the explicit solution $g(s)=2sm(s-m)$-type, $h(s)=m^2+2sm$, $h(0)=m^2$, rest zero | $S_{22}=1$ and $G_2=2$ **exactly, pinned, at every padding**, screened to $10^{-9}$ displayed digits at $n=4,5,6$ |
| $3$ distinct values, all triples realizable | **no** (rank $7$ against $8$, at five rational instances including a zero value, a sign-symmetric triple and $S^3\times S^5$'s value ratios) | the span does not pin it, but see §2.3 |
| $4$, $5$ distinct values | **no** (rank $10$ vs $11$, $13$ vs $14$) | free in the span sense |

So "pinned exactly when two exponents $\le1$" holds for value-generic spectra and **fails at the two spectra the record leans on hardest**: the conjectured extremum (2 values) and its threshold witness ($\{s,m,0\}$ with $\mathrm{mult}(s)=1$).

### 2.3 The second failure mode: $T\ge0$ pins what the span does not

"Pinned" for any route through relaxations means: determined over *nonnegative* $T$ satisfying the rows. That set can be strictly smaller than the affine span. Measured with an exact-constraint LP over all $\binom{N}{3}$ unordered triples ([t_freeness.py](../scripts/reviewers/r332/t_freeness.py)):

| spectrum $(\lambda,\theta)$ | distinct values | $S_{22}$ range over $\{(A),(B),(C),\,T\ge0\}$ | true $S_{22}$ |
| --- | --- | --- | --- |
| padded $W_{\mathbb{CP}^2}$, $n=5$ | $3$ | $[1.000000000,\,1.000000000]$, width $0$ | $1.000000000$ |
| $S^3\times S^5$, $n=8$ | $3$ (mults $15,10,3$) | $[0.506878307,\,0.506878307]$, width $\mathbf{0}$ | $0.506878307$ |
| Newton point, $n=6$, $\theta=0.386912$ | $15$ | $[0.481845,\,0.606825]$, width $0.125$ | $0.518194$, interior |
| Newton point, $n=6$, $\theta=0.274854$ | $11$ | $[0.496026,\,0.575888]$, width $0.080$ | $0.521088$, interior |
| Newton point, $n=6$, $\theta=0.400544$ | $11$ | $[0.480212,\,0.575929]$, width $0.096$ | $0.502228$, interior |

The $S^3\times S^5$ row is the surprise: its weight is *not* in the span (rank certificate above), yet the polytope determines $S_{22}$, positivity collapses the feasible support (the graded structure leaves only four value-classes with mass) until the functional is constant. Since $\mathbb{HP}^2$ is bracket-isomorphic to $S^3\times S^5$, the same number and the same pinning hold there. The three Newton points (built by an independent solver on $Q(V)=V$ over $\mathcal W_6$, criticality residuals $\le8\times10^{-16}$, [t_newton.py](../scripts/reviewers/r332/t_newton.py), saved in [newton_points.npy](../scripts/reviewers/r332/newton_points.npy)) show the freeness is real at value-rich spectra. *These LP runs are screens of the specific pinning/freeness claims stated here, on objects constructed for the purpose.*

**Repair of the census.** The correct statement is three-layered: (1) the three relations are the complete independent linear list (§1); (2) their span pins a monomial pattern iff its symmetrized weight lies in the $(f,g,h)$-span *on the realizable value-triples*, which "two exponents $\le1$" guarantees, and which for $\{2,2,0\}$ holds or fails with the spectrum; (3) the operational pinned set, the one every LP-shaped route actually faces, adds $T\ge0$ and is wider still. Post F42's no-computation elimination test ("if two exponents are $\le1$ the route is closed"), remains sound as a *sufficient* condition for pinnedness; its converse use, "a $\{2,2,0\}$ lever escapes the pinned class", is unsound: at every catalogued spectrum above $\sqrt{3/2}$ that was tested, it does not escape.

## 3. Q3, post F42's empirical premise. REFUTED AS STATED

[Post F42](../findings/fence-posts.md) asserts: *"the full pinned relaxation ((A), (B), (C), the proved row cap and $T\ge0$), was measured by Reviewer 324: it ceilings at 1.5–3.7×$\theta_0(n)$."* [Reviewer 324's own §1.2](REVIEW_r324.md) describes what was solved: variables are **one row** $t_{ab}=c_{vab}^2$ of the bracket tensor for $v\in E_{\min}$, with the mass $\sum t=2(n-2)$ ((A) for that row), the first moment $\sum\lambda_at_{ab}=-2\lambda_{\min}$ ((B) for that row), the row cap, and the objective through the $\lambda_{\min}$ row's deficiency identity ((C) for that row). That is a **one-row sub-relaxation**: none of the other $N-1$ indices' rows, no total symmetry of $T$, no cross-row coupling. The full pinned relaxation of post F42's own definition (all $N$ rows of all three relations on a totally symmetric $T\ge0$), was measured by nobody: [Reviewer 326](REVIEW_r326.md) maximised (A)+(C)-all-rows over spectra (reaching $3.674$ at $n=12$, without (B)) and evaluated the (B)-repaired *marginal* LP only at fixed catalogued spectra.

Two consequences, and the second is the sharp one:

1. The attribution is wrong: the cited numbers belong to a much weaker object.
2. **The inference is backwards.** The full relaxation is *tighter* than the measured one, so its ceiling is $\le$ the measured $1.5$–$3.7\times\theta_0$, the measurement is an upper bound on the full LP's ceiling, not a lower bound, and therefore *cannot* establish that the full pinned class fails. Nothing on the record excludes the full pinned LP ceilinging at $\theta_0(n)$ for $n\ge12$, which would *prove* Conjecture A; §2.3 even shows the full system is drastically stronger than any one-row system at value-poor spectra (width $0$ against r324's fat one-row polytopes). Post F42's headline "no route through the pinned data can close the conjecture" is unestablished, and its instruction "a successor must use a $\{2,2,0\}$ moment or higher" doubles the error: by §2 that moment is itself pinned at the flagship spectra. **What the post actually needs, and the record does not have, is the full pinned LP maximised over spectra at $n=12$.**

## 4. Q4, freeness of $\{2,2,0\}$: proved formally, open at realizability, undecidable from the catalogue

**Formal freeness is proved by an exact witness.** At $n=6$, spectrum $\lambda=(2,2,2,1,1,1,1,0,-1,-1,-1,-1,-2,-2,-2)$ (integer-scaled; unit-normalising divides $\lambda$ and $\theta$ by $\sqrt{32}$) and $\theta=1$, two totally symmetric hollow $T,T'\ge0$ satisfy **every** row of (A), (B), (C) exactly (residuals identically zero in rational arithmetic), with

$$S_{22}(T)=\frac{11480}{17}=675.294\ldots,\qquad S_{22}(T')=\frac{18592}{23}=808.348\ldots$$

The pair is stored with exact fractional entries in [witness.json](../scripts/reviewers/r332/witness.json), generated and re-verified by [t_exact_witness.py](../scripts/reviewers/r332/t_exact_witness.py) (float LP locates the two vertices; the vertex supports are re-solved and checked over $\mathbb Q$). **This settles the linear-system question the brief poses: (A),(B),(C) with $T\ge0$ do not determine $S_{22}$.** The three genuine critical points of §2.3, whose true $S_{22}$ sits strictly inside a width-$0.1$ interval, show the same at realizable spectra.

**What this does not settle, said plainly: realizability.** Whether two *actual critical points* can share $(\lambda,\theta)$ and differ in $S_{22}$ is open. The brief's suggested route through the catalogue cannot work even in principle: the $\theta$-catalogue's isospectral pairs are triality pairs, and an automorphism that preserves the bracket and the inner product transports the entire eigenbasis, so every squared structure constant (hence every contraction of $T$), is equal across the pair. Equality there is evidence of isomorphism, not of pinning. Deciding realizability-level freeness needs either a same-spectrum pair of genuinely non-isomorphic critical points (none is catalogued) or an analytic argument on the fibres of $(\lambda,\theta)$, and Morse–Bott nondegeneracy ([nondegeneracy.md](../findings/nondegeneracy.md)) suggests those fibres are unions of isolated orbits, on which "function of $(\lambda,\theta)$" is set-theoretically vacuous, which is exactly why the census's operative content is the formal question, and the formal question is now closed in freeness's favour for value-rich spectra and against it for the flagship ones.

## 5. Q5, the Cauchy–Schwarz bound, step by step

### 5.1 (i) The basis-free identity, CONFIRMED, with the proof the record omits

For any linear $A$ on $\mathfrak{so}(n)$ and the bracket $C:\mathfrak{so}(n)\otimes\mathfrak{so}(n)\to\mathfrak{so}(n)$, $\sum_{k,\alpha}\lVert[Ae_k,Ae_\alpha]\rVert^2=\lVert C\circ(A\otimes A)\rVert_{HS}^2$, and a Hilbert–Schmidt norm is orthonormal-basis-independent, no orthogonality or symmetry of $A$ enters. The eigenbasis is used only to *evaluate*: there $[We_k,We_\alpha]=\lambda_k\lambda_\alpha[e_k,e_\alpha]$, giving $\sum\lambda_k^2\lambda_\alpha^2T_{k\alpha c}=S_{22}$. Screened: coordinate-basis evaluation at $S^3\times S^5$ agrees with the eigenbasis value to $10^{-16}$. The bridge $S_{22}=2\theta p_3-2p_4+\tfrac12G_2$ is (C) applied per-index inside $g_k=2R_k-4\lambda_k(\theta-\lambda_k)$, so it holds at critical points exactly, re-derived and screened at two generic Newton points to all displayed digits. The equivalent form $\sum_k\lVert\mathrm{ad}(We_k)W\rVert_{HS}^2$ also checks.

### 5.2 (ii) The equality case, REFUTED AS STATED

Cauchy–Schwarz on $u_k=\lambda_k\sqrt{g_k}$, $v_k=\sqrt{g_k}$ has equality iff $u\propto v$, i.e. iff $\lambda_k$ **itself** is constant on $\operatorname{supp}(g)$. "$\lambda_k^2$ constant" admits support meeting both $\pm c$: there $(\sum\lambda g)^2=c^2(\sum\pm g)^2<c^2(\sum g)^2=(\sum\lambda^2g)(\sum g)$ whenever both signs carry mass, so the stated criterion is necessary but not sufficient. The repair costs nothing downstream: at the balanced product $\operatorname{supp}(g)=E_{\min}$ carries the single value $\lambda_{\min}$, so equality genuinely holds.

### 5.3 (iii) Exactness at the balanced product, CONFIRMED in substance, with a provenance gap and a deflation

The support fact needs two inputs, and Π-saturation is only one of them. Lemma L70's saturation ([bounds.md](../findings/bounds.md)) governs the rows of $v\in E_{\min}$ only. The vanishing of $g$ on $E_{\max}$ is the symmetric-pair structure: with $E_{\max}=\mathfrak h$ a subalgebra and $E_{\min}=\mathfrak m$, a row of $k\in\mathfrak h$ pairs $(\mathfrak h,\mathfrak h)$ or $(\mathfrak m,\mathfrak m)$, both with $\lambda_\alpha-\lambda_\beta=0$, so $g_k=0$, that is [Lemma L71](../findings/bounds.md)'s conclusion doing the work, and the citation should say so. Screened: $g\equiv0$ on $E_{\max}$ to $10^{-32}$ at $S^3\times S^3$ and $S^4\times S^4$. **The deflation:** by §2.2, at any two-value spectrum $G_2$ is pinned at $(s-m)(-4\theta)+4(n-1)sm$, which at the balanced data ($s=nm/(n-2)$, $\theta=-m+(n-2)s$) telescopes to $4(n-1)m^2=4\theta^2/(n-1)$, the equality value. So "exact at the extremum" is an arithmetic consequence of (A),(B),(C) at that spectrum, in the same sense in which [Reviewer 326](REVIEW_r326.md) found the sharpness table "a definition restated": the bound cannot distinguish any two $T$'s there, because there are no two values to distinguish. The sentence *"the first bound … built from a quantity the spectrum does not determine"* is false at the very point where its sharpness is claimed, and false again at padded $W_{\mathbb{CP}^2}$ (§5.4).

### 5.4 (iv) The padded refutation, arithmetic CONFIRMED, statement STRENGTHENED

$4\theta\sqrt6=4\sqrt{3/2}\cdot\sqrt6=4\cdot3=12$; $\lambda_{\min}^2\cdot12=12/6=2$; the target $4\theta_0^2/(n-1)=8(n-2)/n^2=0.5\overline5$ at $n=12$; $\tfrac12\sqrt{11\cdot2}=2.345$, all check. $\Delta=0$ for the padded points is recorded on the $\{\lambda>0\}$ branch ([bounds.md](../findings/bounds.md): "Under $\{\lambda>0\}$ every padded point returns $0$"), where the record itself flags it as an embedding artefact; the argument survives that flag because the operative fact, $g\equiv0$ on $E_{\max}$, is direct: $\mathrm{ad}(\omega)$ maps $E_{\min}$ into $E_{\min}$ inside $\mathfrak{su}(2)_+$, so the top row's $\lambda$-differences vanish. **But the record's inequality is the weak form of an exact pinned value.** By §2.2's explicit span solution on the $\{s^1,m^2,0^K\}$ triple set, (A),(B),(C) alone force $S_{22}=1$ and hence $G_2=2S_{22}-4\theta p_3+4p_4=2-2+2=2$ **exactly, at every padding**, screened by direct evaluation at $n=4,5,6$ and by the width-$0$ LP interval at $n=5$. The section's closing question, "what does realizability forbid for the pair $(G_2,\theta)$ jointly", therefore has a sharper answer than it expects at both of its own test points: *the three linear relations plus positivity already fix $G_2$ outright.*

### 5.5 The coordinator's conditional, what a fourth relation would do

No universal fourth relation exists (§1), so the bound survives as a true inequality. What §2 does to it is conditional pinning: the lever $G_2$ is a function of $(\lambda,\theta)$ at the balanced spectra, at padded-$W_{\mathbb{CP}^2}$ spectra, and (operationally) at $S^3\times S^5$/$\mathbb{HP}^2$ (every catalogued point at or above $\sqrt{3/2}$ that was tested) so on that stratum the bound is a pinned-class statement and [post F42](../findings/fence-posts.md)'s own logic would close it. Its genuine content lives on value-rich spectra, where §2.3 shows $G_2$ is free with room $\sim0.1$ and the true point interior.

## 6. What I would put in the record

1. **The stratification theorem of §2**: pinnedness = weight pattern × spectrum value structure × positivity; the "two exponents $\le1$" criterion is sufficient, never necessary; $\{2,2,0\}$ is pinned at every $\le2$-value spectrum, at $\{s^1,m^2,0^K\}$ spectra (explicit weights), and operationally at $S^3\times S^5$/$\mathbb{HP}^2$; free at value-generic spectra by the exact witness of §4.
2. **Rewrite post F42.** Its premise misattributes a one-row LP as the full pinned relaxation, its inference runs the wrong way, and its successor instruction points at a lever that is dead exactly where the record tests levers. The honest replacement: *the full pinned LP over spectra at $n=12$ is unmeasured and is the route's next question; if it ceilings above $\theta_0$, then a successor needs realizability (Jacobi/Bianchi on the signed $c$), not a higher moment.*
3. **Correct the Cauchy–Schwarz section**: equality case $\lambda$-constant (not $\lambda^2$); cite Lemma L71 for the $E_{\max}$ rows; replace "$G_2\ge2$" by "$G_2=2$ pinned"; withdraw "a quantity the spectrum does not determine" or scope it to value-generic spectra.
4. **Record the triality obstruction** (§4): isospectral catalogue pairs are bracket-isomorphic and can never witness freeness or a fourth relation.
5. **A cheap decisive experiment the record can run**: the full pinned LP (all rows, symmetric $T\ge0$, caps) maximised over spectra at $n=12$, post F42 stands or falls with it.

**Scripts:** [scripts/reviewers/r332/](../scripts/reviewers/r332/), [core.py](../scripts/reviewers/r332/core.py), [t_screen1.py](../scripts/reviewers/r332/t_screen1.py), [t_freeness.py](../scripts/reviewers/r332/t_freeness.py), [t_newton.py](../scripts/reviewers/r332/t_newton.py), [t_exact_witness.py](../scripts/reviewers/r332/t_exact_witness.py), [witness.json](../scripts/reviewers/r332/witness.json), [newton_points.npy](../scripts/reviewers/r332/newton_points.npy). Every LP and every numerical evaluation above is a screen of a specific stated claim on constructed objects; the positive claims rest on the derivations and the exact rational certificates. Log: [agent_logs/r332-census.log](../agent_logs/r332-census.log).
