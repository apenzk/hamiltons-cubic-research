# Nondegeneracy, connected components, and the refutations that cost the route

The second-order form in structure constants, the Morse-Bott results, the crux the component argument turns on, and the corrections Gate 2 forced on it.

Part of [findings/INDEX.md](INDEX.md), the index that says which file to open.

---

#### The second-order form, explicit in the structure constants

For **any** symmetric $v$ written in an orthonormal basis $\{b_i\}$ of $\Lambda^2$, no Weyl restriction, no block restriction,

$$\langle v,e^\#v\rangle=\tfrac12\sum_{ijkl}v_{ij}v_{kl}\,\big\langle[b_i,b_k],\,e[b_j,b_l]\big\rangle,$$

exact to $10^{-14}$ on random Weyl and random symmetric directions alike. With the commutator part this gives the whole second-order form,

$$\langle v,L_ev\rangle=\big\langle v,\tfrac12(ev+ve)\big\rangle+\tfrac12\sum_{ijkl}v_{ij}v_{kl}\,\big\langle[b_i,b_k],\,e[b_j,b_l]\big\rangle,$$

so **gate G is an explicit finite-dimensional variational statement**: maximise this over unit $v\perp W$ inside $\mathrm{Weyl}_n$, and show the maximum exceeds $\tfrac12$ whenever the point is ungraded. Everything in it is structure constants and the eigen-decomposition of $e$; nothing is measured. The block decomposition below is this identity restricted to $\mathrm{Sym}^2(\mathfrak m)$, where the bracket splits into its $\mathfrak h$- and $\mathfrak m$-parts. **Gate 2 pending.**

#### The second-order form, split exactly, with the ungradedness isolated

For $C$ symmetric and supported on $\mathfrak m$, with $H_{ik}=\Pi_{\mathfrak h}[m_i,m_k]$ and $M_{ik}=\Pi_{\mathfrak m}[m_i,m_k]$,

$$\langle C,e^\#C\rangle=\tfrac12\Big[\beta\sum C_{ij}C_{kl}\langle H_{ik},H_{jl}\rangle+\alpha\sum C_{ij}C_{kl}\langle M_{ik},M_{jl}\rangle\Big],$$

exact to $10^{-14}$. **$M$ is precisely the ungradedness**, it vanishes identically at a graded point, where the $\alpha$-term is then zero to machine precision, while at ungraded points it contributes $+1.92$ and $+0.77$ in the sampled cases. Since $\alpha<0$, ungradedness enters the second-order form with a **favourable sign wherever the $M$-form is negative**.

**That sign is not automatic.** The quadratic form $F(C)=\sum C_{ij}C_{kl}\langle M_{ik},M_{jl}\rangle$ on $\mathrm{Sym}^2(\mathfrak m)$ is indefinite, in an orthonormal basis its range is $[-2.000,\,4.000]$ at the $\mathfrak{su}(3)$ bi-invariant and $[-0.200,\,1.200]$ at $\mathfrak{so}(3)\subset\mathfrak{so}(5)$, so ungradedness helps only for $C$ in the negative cone.

**The witness is not determined by that form, and the appearance that it was came from a homogeneous sample.** At the two highly symmetric points just named, the violating eigenvector's $\mathfrak m$-part attains $\lambda_{\min}(F)$ exactly, which suggested a construction. It does not survive the generic population: at a symmetry-free critical point at $n=6$, $\theta=0.128$, slack $1.633$, $\lambda_{\max}=4.962$, the witness gives $F/\|C\|^2=-0.017$ against a minimum of $-0.480$, with the $\mathfrak m$-part carrying only $16\%$ of the norm. Since the symmetry-free points are the population that decides the conjecture, the construction does not generalise and no witness formula is available. $\mathrm{Sym}^2(\mathfrak m)$ alone does not suffice either, the commutator part contributes $\alpha<0$ there, which is why the witness carries mass in $\mathrm{Sym}^2(\mathfrak h)$ as well, where the commutator part contributes $\beta>0$. **Gate G is therefore a variational problem on $\mathrm{Sym}^2(\mathfrak h)\oplus\mathrm{Sym}^2(\mathfrak m)$ with an explicit objective, rather than a search for a witness.**

#### The graded enumeration's residue closes structurally

**The slack is the third grading condition, measured.** On the subalgebra family the other two hold identically ($\le10^{-14}$ across every catalogued point), and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ is precisely $S$: it vanishes at the graded points and is large elsewhere, $8.94$ at the $\mathfrak{su}(3)$ bi-invariant, $16.7$ at the $\mathfrak{so}(5)$ adjoint.

**The alternative-embedding residue is empty.** The densely-appearing candidates that widened it, subalgebras acting on $\mathbb R^n$ through non-vector representations, $\mathfrak{so}(10)\oplus\mathfrak{so}(20)$ at $n=200$ and its relatives, are not fixed subalgebras of any involution, so they carry no graded critical point and need no case analysis. Checked directly on the worrying shape: the tensor embedding $\mathfrak{so}(3)\otimes\mathfrak{so}(3)\subset\mathfrak{so}(9)$ is ungraded, with slack $0.722$ and leakage $16.1$ ([h_graded_residue.py](../scripts/misc/h_graded_residue.py)).

**The witness of ungradedness cannot be $K$-invariant.** Every $K$-invariant Weyl operator is a multiple of $W$ on this family, so the canonical invariant candidates (the $\mathfrak m$-Casimir $\sum_{a\in\mathfrak m}\mathrm{ad}(m_a)^2$ among them), project to zero in $W^\perp$. The second-order violating direction therefore transforms in a nontrivial $K$-module, which is what the measured eigenspaces are: the adjoint at $\mathfrak{su}(3)$, the vector at $\mathfrak{so}(5)$, spin-2 at $\mathfrak{so}(3)\subset\mathfrak{so}(5)$, identified by their $\mathfrak h$-Casimir values $2$, $4/3$ and $6$.

#### The diagonal case is spectral, which closes the graphon route

The diagonal functional is $\sum_{i<j<k}\lambda_{ij}\lambda_{ik}\lambda_{jk}=\tfrac16\mathop{\mathrm{tr}}(\Lambda^3)=\tfrac16\sum\mu_i^3$ for hollow $\Lambda$, verified to $10^{-16}$. Its relaxation (drop hollowness, keep $\mathop{\mathrm{tr}}\Lambda=0$, $\|\Lambda\|=1$ and $\Lambda\mathbf1=0$), is already sharp: Huisken's cap $(m-2)/\sqrt{m(m-1)}$ on $\sum\mu_i^3$ is **saturated exactly** by the sphere product's vertex matrix at $n=6,8,12,20$. So flag-algebra or graphon machinery would certify the half that is already settled, while the difficulty sits in the hollowness constraint, which is not a density statement. Recorded as a closed route rather than an untried one.

### The crux: is the graded set a union of connected components?

#### Morse–Bott nondegeneracy at the sphere products

**Why nondegeneracy is the target.** A critical point is *Morse–Bott nondegenerate* when $\ker(\mathrm{Hess})$ equals the tangent space to the critical orbit through it, the standard definition. If every graded critical point is nondegenerate, each graded orbit is **isolated** in $\mathrm{Crit}(P)$: no other critical point lies nearby. Then the graded set is a union of connected components, the remaining components are compact with $S>0$, so $S\ge c>0$ there, and the exact $\theta$ formula converts that into $\theta$ below the graded ceiling. **No estimate at any step**, which is why this route can succeed where three sharp inequalities failed.

**Literature first, and it supplied the decomposition.** Nienhaus (arXiv:2311.02404) Chapter 4.2 decomposes $\mathrm{Weyl}_n$ for $k+l=n$ and identifies the orbit tangent space in closed form. **Two statements sit there with different ranges, and the wider one is the one this file uses.** Proposition 4.6 itself decomposes $S^2(\mathfrak{so}(n))$ and carries *"$k,l\ge5$, $k,l\ne6$"*; the ten-summand $\mathrm{Weyl}_n$ display summarising it closes with *"orthogonal and irreducible under the $SO(k)\times SO(l)$-action for any $k,l\ge5$. Furthermore, it is irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$"*, no exclusion at $6$, and $O$ rather than $SO$. The decomposition is:

$$T_{W_{S^k\times S^l}}\,SO(n).W_{S^k\times S^l}\;\cong\;\mathbb R^k\otimes\mathbb R^l,\qquad \dim=k\,l.$$

His Chapter 4.4 computes the Hessian only at $W_{\mathbb{CP}^2}$; there is no sphere-product analogue of Theorem 4.14 in the thesis. So the decomposition is published and the eigenvalue computation is the gap, which is the open item P4(ii), now revealed as load-bearing for the crux rather than a loose end.

**Result** ([p3b_morse_bott_spheres.py](../scripts/lib/p3b_morse_bott_spheres.py)). $F_W$ commutes with $SO(k)\times SO(l)$ to $3\times10^{-15}$, so $F_W=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}$ with no multiplicity-free hypothesis, the same mechanism that closed the Fox case.

| point | $\theta$ | $E(\tfrac12\theta)$ | $\ker(\mathrm{Hess}\,P)$ | orbit | $k\,l$ |
| --- | --- | --- | --- | --- | --- |
| $S^4\times S^4$, $n=8$ | $1.145643924$ | $16$ | $16$ | $16$ | $16$ |
| $S^5\times S^5$, $n=10$ | $1.200000000$ | $25$ | $25$ | $25$ | $25$ |
| $S^6\times S^6$, $n=12$ | $1.236033081$ | $36$ | $36$ | $36$ | $36$ |
| $S^5\times S^7$, $n=12$ | $1.228239158$ | $35$ | $35$ | $35$ | $35$ |

All four quantities coincide in every case, and the $\tfrac12\theta$-eigenspace lands exactly on $k\,l$, Nienhaus's $\mathbb R^k\otimes\mathbb R^l$. The general shape is

$$\ker(\mathrm{Hess}\,P)\;=\;E(\tfrac12\theta)\;=\;T(\text{orbit})\;=\;\mathbb R^k\otimes\mathbb R^l .$$

**The unbalanced case is included and behaves identically.** $S^5\times S^7$ matters because Reviewer 15 showed unbalanced products are structurally different (three distinct isotropy values rather than two) and it is nondegenerate all the same.

**This mirrors the Fox result exactly.** At $W_{\mathbb{CP}^2}$ the same identity holds with $\ker=E(\tfrac12\theta)=T(\text{orbit})$ of dimension $4n-14$. So both named competitors are Morse–Bott nondegenerate by the same mechanism, and the $\tfrac12\theta$ eigenvalue is in both cases exactly the orbit's.

**The exception is $n=6$.** $S^3\times S^3$ has $\ker(\mathrm{Hess}\,P)=18$ against an orbit of $9$, genuinely degenerate. It sits below the crossover $6+2\sqrt7$, so the statement to prove is *"for $n\ge8$, every graded critical point is Morse–Bott nondegenerate"*, with $n=6$ a known and harmless exception.

**What remains for the crux.** Nondegeneracy is verified at the sphere products and at Fox. To close P3b it must hold at **every** graded critical point (the remaining symmetric pairs, which the enumeration lists) and the isotypic argument that worked for Fox and for $SO(k)\times SO(l)$ should apply to each, since every graded point has a compact stabilizer with a published decomposition.

#### Lemma L26, the dangerous eigenvalue of the two-block spectrum, in closed form, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: [fence-posts.md](fence-posts.md) already carried this argument.*

Needed because Observation L3's nondegeneracy claim at $S^p\times S^q$ rested on a scan: the eigenvalue that
threatens to reach $\tfrac12$ had been measured split by split, so nothing covered all $n$ at once.

**Statement.** Let $n=p+q$ with $p,q\ge2$, let $\pi$ be a coordinate $2$-plane inside the $p$-block and $\rho$ one
inside the $q$-block, and let $X$ be $\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ component removed. Then
$X\in\mathrm{Weyl}_n$, and for the sphere product's $e$,
$$e\circ X=\mu X,\qquad \mu=\frac{n-2}{2(p-1)(q-1)},\qquad \mu\ge\tfrac12\iff(p-2)(q-2)\le1 .$$
So the criterion $\mu\ge\tfrac12$ binds at exactly two places, **and they are different places**: at $p=2$, where $\mu$ **exceeds** $\tfrac12$ by $\tfrac1{2(n-3)}$, and at $(p,q)=(3,3)$, where it **equals** it. *Only the equality is degeneracy, [L24](second-order.md)'s kernel is an eigenspace at $\tfrac12$, so the two cases must never be collapsed into a word like "reaches", which reads as attainment once quoted away from this display and inverted [L11](#lemma-l11-the-two-block-sphere-products-that-are-morsebott-nondegenerate-and-the-two-families-that-are-not) for two revisions.* For $p,q\ge3$ other than $(3,3)$ **and $(3,4)$** the gap is $1/(2\max(p,q)-2)$, where the eigenvalue being cleared is $\lambda_m=\frac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$ at $m=\max(p,q)$. **That clause is an upper bound on the whole spectrum, which the exhibited eigenvector below cannot give: it is [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof)'s, and is stated only inside L27's range $p,q\ge3$, $(p,q)\ne(3,3)$.** **At $(3,4)$ this family's own $\mu=\tfrac5{12}$ overtakes $\lambda_{\max(p,q)}=\tfrac13$**, so the second-largest eigenvalue is $\mu$ and the gap is $\tfrac1{12}$. **And $(3,4)$ is the only such split, by a criterion rather than by a search.** The comparison $\lambda_{\max}<\mu$ clears to $3p+2q-4-pq>0$, which factors as $(p-2)(q-3)<2$; over $q\ge p\ge3$ that admits exactly $(3,3)$ and $(3,4)$, and $(3,3)$ is already an equality case above. So the exception list is closed. **The criterion is written for $q\ge p$ and is order-dependent**: read at $(5,3)$ the product $(p-2)(q-3)$ is $0$ and declares an exception, while $\lambda_5=\tfrac38=\mu$ is a tie, so a consumer quoting the factorisation without the ordering is misled. **And the five splits $(3,5)$, $(4,4)$, $(3,7)$, $(5,5)$, $(4,6)$ missed $(3,4)$ because every one of them has $n\ge8$ and $(3,4)$ has $n=7$**, it lay below the range, not inside a thin region. *Two of the five sit on the equality locus $(p-2)(q-3)=2$*: at $(3,5)$ and $(4,4)$ the second-largest eigenvalue is attained twice, $\mu=\lambda_{\max(p,q)}$ exactly at $\tfrac38$ and $\tfrac13$, which leaves the gap value unchanged and reads as a non-event. *Gate 2, [r527](../reviews/REVIEW_r527.md); the uniqueness is kernel-checked in [L26.lean](../lean/HamiltonsCubic/Results/L26.lean).*

**Argument.** $X$ is supported on the three pairings of four indices, with coefficients $\tfrac23,\tfrac13,-\tfrac13$
and $\|X\|^2=\tfrac43$. In $T_{ab}=\sum_{m,r,t}c_{amr}\varepsilon_r c_{brt}X_{tm}$ the plane $r$ is determined by $a$
and $m$ as the third side of a triangle, so no sum over the ambient index set survives and the verification is
finite. Enumerating every plane type over a universe of the four core indices plus two spare indices in each
block (enough, since a pair of planes spans at most four indices), gives $e\circ X=\mu X$ identically in $p$ and
$q$. Holding the three block values $\varepsilon_{PP},\varepsilon_{QQ},\varepsilon_{PQ}$ as free symbols, the same
computation yields $e\circ X=\lambda X$ for **any** three-block diagonal operator, with
$\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$; criticality enters only through
$Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$, which fixes the three values and collapses $\lambda$ to $\mu$. $\square$

**What it does not reach, and this is the point.** An exhibited eigenvector bounds $\lambda_{\max}$ and one
multiplicity from **below**. The statements nondegeneracy needs, that $(3,3)$ is the *unique* split reaching
$\tfrac12$, and that $\dim E(\tfrac12)=pq$, are upper bounds on the rest of the spectrum, which no eigenvector
supplies. Those rest on the full multiplicity list, which is verified numerically at 44 splits to $n=16$ and
rigorous only at $n\le12$, **which [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof) has since made a theorem at every $p,q\ge3$ with $(p,q)\ne(3,3)$, by the multiplicity-free decomposition rather than by a list**. The bottom-end criterion is **$p,q\ge3$, not $n\ge5$**: the ten dimensions over-count by $2$ at $q=2$ and by $1+p$ at $q=1$, so at $(3,2)$, $n=5$, the sum reads $37$ against $\dim\mathrm{Weyl}_5=35$. Historically: at $(2,2)$ the operator $e$ is non-primitive under the
Hodge splitting of $\Lambda^2(\mathbb R^4)$, the spectrum is $(-1)^4,(\tfrac12)^4,1^2$, and $1$ is not simple.

**Sources.** Derived here; audited by Reviewers 32 and 33 on identical briefs, agreeing on every verdict, each
having rebuilt the algebra from the definitions. The closed form was first found numerically by Reviewers 30
and 31, independently of each other. The $\mathrm{Weyl}_n$ display summarising Nienhaus Proposition 4.6 supplies the decomposition in
which this family is the $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$ summand, irreducible under $O(p)\times O(q)$ for $p,q\ge3$. **Proposition 4.6 proper is the $S^2(\mathfrak{so}(n))$ statement and carries $k,l\ge5$, $k,l\ne6$**, so citing it for a split with a $6$-block, or for $p$ or $q$ below $5$, quotes the wrong one of the two.


#### Gate 2 on the Morse–Bott route (Reviewer 16): the measurement is proven, the conclusion is refuted

Reviewer 16 rebuilt everything from definitions, structure constants, $R^\#$, the polarization $F_W$, **two** independent constructions of $\mathrm{Weyl}_n$ (identical projectors, $\|\Pi_1-\Pi_2\|=0$), $W$ derived from the product metric rather than the closed form, the slack $S$, and an exact integer/$\mathbb F_p$ pipeline. Gatekeepers passed: full symmetry of the trilinear form to $3\times10^{-14}$, the classical diagonal $R^\#$ formula, $\dim\mathrm{Weyl}_n$ at $n=4\ldots14$, and its $S$ matching this project's digit-for-digit. Report in [review_r16_report.md](../agent_logs/review_r16_report.md).

### Upgraded: the kernel identity is now a theorem, not a measurement

Scaling to $W_0=(k-1)(l-1)(n-1)W$ makes $\theta_0$ an **integer** and the kernel an integer linear system; since $W$ is a $\theta$-eigenvector of $F_W$, the $\tfrac\theta2$-eigenspace lies in $W^\perp$ automatically and no restriction step is needed. Every inequality points the safe way,

$$k\,l=\mathrm{rank}_p(\text{orbit})\le\mathrm{rank}_{\mathbb Q}(\text{orbit})\le\mathrm{nullity}_{\mathbb Q}\le\mathrm{nullity}_p=k\,l,$$

giving equality exactly. Established over $\mathbb Q$ at $n=6$ and modulo two primes at $n=8,10,12$, for $(4,4),(3,5),(2,6)$; $(5,5),(3,7)$; $(6,6),(5,7),(3,9)$. **$S^7\times S^7$ at $n=14$ rests on floating point only.**

### Corrected: the exception is $(3,3)$, not $n=6$, and Schur is not the mechanism

At $k=l=3$ the kernel is $18$ against an orbit of $9$. **The isomorphism once given as the reason ($\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$), is not one**: under $O(3)\times O(3)$ the summands are non-isomorphic, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det$ carrying character $+3$ at $-I$ where $\mathbb R^3$ carries $-3$, *and isomorphic summands would not force equal scalars in any case.* **The dimension coincidence it rests on holds at $(2,5)$ too**, where the point is nondegenerate. **What decides the exception is the closed form** $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, which vanishes at $(3,3)$ and nowhere else in the range. *$S^2\times S^4$ at the same $n=6$ is nondegenerate, so the earlier "$n=6$ is the exception" framing is wrong, and the dimension still belongs in the statement, since padding changes the answer at $p=2$.*

**And the Schur argument is not doing the work.** Even under $O(3)\times O(3)$, where the decomposition *is* multiplicity-free, the kernel is still $18$: multiplicity-freeness forces a scalar per piece but never forces the scalars apart. So "no multiplicity-free hypothesis needed" is true and **irrelevant**, the equivariant decomposition organises the computation without proving anything. Claims presenting Schur as the mechanism are withdrawn.

### REFUTED: the conclusion the route was built on, at both ends

**The slack is $\binom{\dim\mathfrak m}{3}$ conditions, and gradedness is two conditions, not three.** $\langle[X,Y],Z\rangle$ is totally antisymmetric (residual exactly $0$), so $S=0$ counts triples from $\mathfrak m$, and $S\equiv0$ **identically** whenever $\dim\mathfrak m\le2$, since there are then no triples at all. The same antisymmetry gives $\|\Pi_{\mathfrak m}[\mathfrak h,\mathfrak h]\|^2\equiv\|\Pi_{\mathfrak h}[\mathfrak h,\mathfrak m]\|^2$ identically ($16/16$, $24/24$, $32/32$), so $S_{\mathfrak{hhm}}$ and $S_{\mathfrak{hmh}}$ are the same functional. **The recorded leaks $4.0$ and $4.899$ are that one functional at two different dimensions, not one quantity reported twice**: the closed form below places $\sqrt{16}$ at $n=8$ and $\sqrt{24}$ at $n=10$. *Reviewer 115 caught the misreading.*

#### The leak has a closed form, and it replaces a floating-point control

$$S_{\mathfrak{hhm}}\big(\text{padded }W_{\mathbb{CP}^2}\text{ in }\mathbb R^n\big)=4(n-4)\quad\text{exactly},$$

verified at $n=4,\dots,9$ giving $0,4,8,12,16,20$ with $\dim\mathfrak m=2$ throughout. **Use it as the control** rather than a measured $8.000$: the alternative figure $2.64$ is LAPACK-dependent and not reproducible across routines.

**$\{S=0\}$ is closed under orthogonal direct sums and padding; gradedness is not.** $Q$ is additive over orthogonal blocks and $\mathfrak m=\mathfrak m_A\oplus\mathfrak m_B$ keeps $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, but $\mathfrak h$ contains $e_a\wedge e_z$ and $e_b\wedge e_z$ with $z$ in the other block, and their bracket $\pm e_a\wedge e_b$ lands back in $\mathfrak m$. **So every block sum and every padded critical point is ungraded with $S$ inherited**, eleven such points on record, $\dim\mathfrak m$ from $2$ to $36$, and at $S^6\times S^6$ padded into $n=14$ the condition $S=0$ is $7140$ equations on a $1980$-dimensional Grassmannian, **$\mathrm{Gr}(36,\mathfrak{so}(14))$**, since $\dim\mathfrak{so}(14)=\binom{14}2=91$ and the $\dim\mathfrak m=36$ above give $36\cdot55=1980$, $3.6\times$ overdetermined, exactly $119/33$, leaving $5160$ redundant equations, all satisfied at an ungraded point. **A hypothesis bounding $\dim\mathfrak m$ below therefore cannot recover "$S=0\Rightarrow$ graded".**

**Correcting the counterexample that scoped the graded classification.** $W_{\mathbb{CP}^2}$ is **graded in its native dimension $4$**, $\sigma_1=1.3\times10^{-30}$, $\mathfrak h=\mathfrak u(2)$, and $(\mathfrak{so}(4),\mathfrak u(2))$ is a symmetric pair. Its ungradedness at larger $n$ is manufactured by padding, per the previous paragraph. So the refutation of "$S=0\Rightarrow$ graded" stands, but its witness is a padding artefact rather than evidence about small negative eigenspaces.

**Two-eigenvalue critical points obey a closed-form law**: $\sigma_1=3\sigma_3+\frac{6d}{n}(n^2-4d)$, derived symbolically and verified on six catalogued points and four held-out strongly regular graphs with $\theta$ reproduced to $10^{-17}$. Hence **graded $\iff\dim\mathfrak m=n^2/4$**, and $S=0$ at any other $\dim\mathfrak m$ is always ungraded. The subalgebra-family formula recorded above is its $\sigma_1=0$ slice. Explicit ungraded $S=0$ critical points follow from the triangle-free strongly regular list: Clebsch at $n=16$ has $\dim\mathfrak m=40$, $S=0$ exactly, $\sigma_1=480$, Ricci and Bianchi both $0.0$, criticality residual $3\times10^{-18}$; Petersen and the rest reach $\dim\mathfrak m=1100$.

**$S$ is lower semicontinuous, not continuous, and not locally constant.** It jumps at padded $W_{\mathbb{CP}^2}$: over 200 perturbations at $\varepsilon=10^{-6}$ the *minimum* value of $S$ is $16.5$, **but those perturbations are on the unit sphere, not in $\mathrm{Crit}(P)$**, [review_r52_m5.py](../scripts/reviewers/r52/review_r52_m5.py) forms $W+\varepsilon d$ for a random Weyl direction $d$ and renormalises, with no projection back to the critical set. *So the jump says nothing about the structure of $\mathrm{Crit}(P)$ near $W_{\mathbb{CP}^2}$, and cannot be used to isolate it there.* The figure is against $O(\varepsilon^2)$ at the kernel-free $S^4\times S^4$, so the earlier description of $S$ as a polynomial on $\mathrm{Crit}(P)$ is wrong. Lower semicontinuity is nonetheless all the compactness step needs. And $S$ is not locally constant: two copies of $-W_{\mathrm{Petersen}}$ on disjoint $10$-blocks of $\mathbb R^{20}$ give $Q\equiv0$ on their whole $2$-plane, so the unit circle lies in $\mathrm{Crit}(P)$ while $S$ runs $0.1054\to0.0745$ and the spectrum changes, verified here at $\|Q\|\le3\times10^{-17}$. That circle sits at $\theta=0$, so it never meets the region the crux concerns.

#### What the separation owes, Gate 2, Reviewers 111 and 112

**Both reviewers, independently, on identical briefs. Two results and one refuted shortcut.**

**RESULT 1: $W_{\mathbb{CP}^2}$'s orbit is a union of connected components of $\mathrm{Crit}(P)$, from the Hessian, not from $S$.** Padded $W_{\mathbb{CP}^2}$ is **Morse–Bott nondegenerate**: $\ker\mathrm{Hess}$ equals the orbit exactly at $n=6,8,10$, excess $0$ (both reviewers, separately: $10=10$ at $n=6$, $18=18$ at $n=8$). So $\mathrm{Crit}(P)$ is *locally exactly the orbit* there.

**RESULT 2, and it reverses the recorded statement: $S$ does not jump on $\mathrm{Crit}(P)$, it is identically zero there.** Perturb-and-project gives $S\approx10^{-46}$ after projection against $20.6$–$44.9$ on the sphere, with every point landing on the orbit (orbit distance $\le7.4\times10^{-12}$ against raw distance up to $0.048$). Since $S$ is $O(n)$-invariant and $\mathrm{Crit}(P)$ is locally the orbit, $S$ is *constant* there, necessarily. **The recorded jump is a sphere phenomenon and its mechanism is now known**: $\dim\mathfrak m$ jumps $2\to14$ at $n=8$ because padding contributes $25$ zero eigenvalues. The figure $16.5$ is a random-sample minimum; independent draws give $[8.90,23.17]$.

**REFUTED: the finiteness shortcut, and it is circular.** Under its own openness hypothesis $\mathrm{Crit}(P)/O(n)$ is compact Hausdorff and the graded set is discrete in it, and *a discrete subset of a compact Hausdorff space is finite **iff** closed.* **Finiteness is the conclusion, not an input.** Three further failures:

- **The record does not carry the finiteness.** The graded enumeration is a projector ansatz (scalar on each isotropy factor, from a theorem about *symmetric-space curvature operators*) and [graded-half.md](graded-half.md) **already withdrew its exhaustiveness claim**. Measured: inside one grading at $n=6$, $306$ of $400$ cone starts converge to **61 distinct** critical points, with controls confirming the solver recovers $S^3\times S^3$ and $\mathbb{CP}^3$ when started near them.
- **Gradedness pins the pair, not the point.** Cartan fixes $\sigma$; graded critical points with grading $\sigma$ fill $\mathcal W_n^\sigma$ ($44$–$48$ at $n=6$, $155$–$160$ at $n=8$) while the $H$-invariant slice the enumeration searches is **exactly $1$-dimensional**.
- **Openness is overstated too.** $S^3\times S^3$ is degenerate, excess $9$, measured independently by both.

**THE USABLE REPAIR, reached independently by both reviewers.** Gradedness can fail in a limit only by an **eigenvalue reaching zero**, so

> closedness of the graded set $\iff$ a uniform lower bound on $\min|\lambda|$ over the graded critical set.

That is checkable, needs no enumeration, and is the form the question should have been in. *And closedness may not be on the critical path at all: the compactness step needs only $G$ open.*


#### The repair, scoped: it must be the smallest NONZERO modulus, and it cannot be uniform in $n$

Reviewers 111 and 112 both reduced closedness to "a uniform lower bound on $\min\lvert\lambda\rvert$ over the graded critical set". **As written that bound is false for a trivial reason, and the fix changes what must be proved** ([run_graded_spectral_gap.py](../scripts/runs/run_graded_spectral_gap.py)).

**Padding kills it outright.** A padded graded critical point has $\min\lvert\lambda\rvert=0$ *exactly*: $S^3\times S^3$ padded to $n=8$ and $n=12$ carries $13$ and $51$ zero eigenvalues, $S^4\times S^4$ padded to $n=12$ carries $38$. Since paddings of graded points are graded, the infimum over the set is $0$ and the statement is vacuous.

**But padding leaves the nonzero spectrum untouched**, which is what makes the repair salvageable: the smallest nonzero modulus at $S^3\times S^3$ is $0.210818511$ at $n=6$, $8$ **and** $12$ alike. So the quantity the argument needs is the spectral gap of $W$ on $(\ker W)^\perp$, not on all of $\Lambda^2$, and that is padding-invariant by construction.

**And it cannot be uniform in $n$.** At the balanced sphere product the smallest nonzero modulus is

$$\frac{\sqrt2\,(n-2)}{n\sqrt{(n-1)(n-2)}}\ \sim\ \frac{\sqrt2}{n}\ \longrightarrow\ 0,$$

verified exactly at $n=6,8,10,12,16$ (deviation $\le1.4\times10^{-17}$). **So the graded critical set has no gap uniform in $n$**, the conjectured maximiser itself supplies the shrinking sequence. Any usable statement must be *per $n$*.

**At fixed $n$, among the known graded families, the gap has a floor and it is attained at the most unbalanced product** ([run_graded_gap_at_fixed_n.py](../scripts/runs/run_graded_gap_at_fixed_n.py)):

| $n$ | smallest gap | attained at |
|---|---|---|
| $10$ | $0.062994$ | $S^3\times S^7$ |
| $12$ | $0.038925$ | $S^3\times S^9$ |

with the balanced product (the conjectured maximiser), sitting at the *largest* gap of the family. The mechanism is elementary: the vertex entries of $S^p\times S^q$ are $-q/(p-1)$, $-p/(q-1)$ and $1$, so the smallest modulus is $p/(q-1)$, i.e. $3/(n-4)$ at $p=3$ before normalisation. **Multi-block products interleave** rather than extending the trend, $S^3\times S^3\times S^3\times S^3$ at $0.0580$ sits between $S^3\times S^9$ and $S^4\times S^8$.

**The floor is at $p=2$, not $p=3$, and the closed form below is for $p=3$ only.** *Gate 2, reviewers 155 and 156, agreeing.* $S^2\times S^{n-2}$ is an admissible Weyl vertex matrix, critical by the same projection argument as every other two-block product, graded with $\mathfrak{so}(2)\oplus\mathfrak{so}(n-2)$, and **already tabulated in [graded-half.md](graded-half.md) as a graded critical point at $n=12$, $\theta=0.994987437$.** Its gap is **strictly below** the $p=3$ value at every $n\ge7$ (proved, not sampled) and roughly half of it. *The generating script ranged over `range(3, n//2+1)`, and that cut-off was reported as a structural fact; [fence-posts.md](fence-posts.md) and [target.md](target.md) each already record one instance of a family silently started at index $3$, making this the third.*

**The general gap has a closed form and is monotone in $p$, which settles the attainment point in one line.** For $p<q$,

$$\mathrm{gap}(p,q)=\sqrt{\frac{2p(p-1)}{q(q-1)(n-1)(n-2)}},$$

**strictly increasing in $p$**, so the minimum is at $p=2$ at every $n\ge6$, monotonicity, no sweep. The corrected floor is

$$\boxed{\ \mathrm{floor}(n)=\frac{2}{(n-2)\sqrt{(n-1)(n-3)}}\ }\qquad 0.031497,\ 0.020101\ \text{at}\ n=10,12,$$

against the tabulated $0.062994$ and $0.038925$. At $p=3$ the same formula factorises to $2\sqrt3/\sqrt{(n-1)(n-2)(n-3)(n-4)}\sim2\sqrt3/n^2$, *the recorded $2/n^{3/2}$ agreed to $0.4\%$ at $n=10$ and is off by $5.5\times$ at $n=100$, which is a fit to two check points written in asymptotic notation.*

**The entries themselves are forced rather than fitted** (block-structured hollow symmetric matrices with zero row sums form a one-dimensional space) and the normalisation is confirmed against $\theta=\sqrt{2(p-1)(q-1)(n-1)/\big(pq(n-2)\big)}$ at $S^3\times S^3$ and all five two-block splits at $n=12$, nine digits each. *$\mathbb{CP}^{n/2}$ is named in the record's graded list and is also absent from the floor computation; scope, not refuted.*

#### The shift is legitimate and the constants cancel, what survives is elementary

**The transfer to an algebraic curvature tensor is sound.** *Reviewer 157, reading every step.* Cheng–Wang's Lemma 3.2 is pointwise algebra end to end, eigenvalue ordering, the cone hypothesis, two quadratic facts about $\lvert SW\rvert^2$ that Schur supplies for free since $S\mapsto\lvert SW\rvert^2$ is a pointwise quadratic form on an $O(n)$-irreducible space, and Lemma 3.1, a contraction of the algebraic decomposition. **No Bochner term, no second Bianchi, no integration**; those enter downstream at Lemma 3.3. So setting $R=W+sR_1$ with $\mathring R_1=\mathrm{Id}$ on $S^2_0$ is legitimate, $\lambda_j=\mu_j+s$ on the *same* eigenspaces, and $\lvert S^jW\rvert$ is untouched.

**But $\theta(n)$ cancels identically, so nothing of Cheng–Wang's constants reaches the conclusion.** With $\sum\mu_j^2=\tfrac34\lVert W\rVert^2$ (Lemma 3.1 at $\bar\lambda=0$) and $\sum_j\lvert S^jW\rvert^2=\tfrac{4(N-3)}n\lVert W\rVert^2$, the shifted right-hand side's second term **is its first term times $c$**:

$$\frac{16(N-3)}{3n}\,c\sum_j\mu_j^2=c\sum_j\lvert S^jW\rvert^2 ,$$

so the inequality reads $\sum_j\mu_j\lvert S^jW\rvert^2\ge-(1+c)\,s\sum_j\lvert S^jW\rvert^2$ for **every** $c\ge0$, and at the minimal admissible $s=-(\mu_1+\mu_2)/\big(2(1+c)\big)$ the factor $(1+c)$ cancels. The one-parameter family collapses to

$$\boxed{\ \sum_j\mu_j\lvert S^jW\rvert^2\ \ge\ \frac{\mu_1+\mu_2}2\sum_j\lvert S^jW\rvert^2\ }$$

**no $\theta(n)$, no $s$, no Cheng–Wang**, with a two-line proof: cap each weight at $M_{\max}$, use $T\ge2M_{\max}$ for $n\ge6$, and $\mu_3\ge(\mu_1+\mu_2)/2$. *Verified in exact rationals at $n=6,\dots,12$.*

**And $c=\theta(n)$ is inadmissible where the record works**: $\theta(6)=-8/53$ and $\theta(7)=-1/22$ are **negative**, so the hypothesis $c\ge0$ fails below $n=8$.

**The bound has genuine content, and the named follow-up does not.** *Reviewer 158, agreeing with 157 throughout and adding both halves.* Against the trivial $\sum\mu_jt_j\ge\mu_1T$ the collapsed bound is **stronger by exactly $\tfrac{\mu_2-\mu_1}2T\ge0$**, with equality when the bottom eigenvalue is degenerate, so it is not vacuous. **But "identify the coefficients and the inequality becomes a bound on $\theta$" is unsupported**: it silently assumes the combination $\alpha\mathop{\mathrm{tr}}(W^3)+\beta\langle W^{\#},W\rangle$ comes out with $\alpha=\beta<0$, which is what would be needed for it to control $\theta=\langle W^2,W\rangle+\langle W^{\#},W\rangle$. *The identification is well posed; what it delivers is a different cubic unless those coefficients happen to align, and nothing argues that they do.*

**And Cheng–Wang's own (3.7) defect is real but harmless here.** *Both reviewers.* The paper proves a **lower** bound on $A=\sum_j\lvert S^jW\rvert^2-2\lvert S^\alpha W\rvert^2$ and then multiplies it by $\lambda_3$, which is valid only for $\lambda_3\ge0$ while the hypothesis permits $\lambda_3<0$. It does not propagate into the one instance carrying content, since that instance never uses the step.

**THE FREE UPGRADE: applying the same bound to $-W$ gives the other side.** *Reviewer 158.* $\mu_j\mapsto-\mu_j$ reverses the ordering while $\lvert S^jW\rvert$ is even in $W$, so

$$\boxed{\ \sum_j\mu_j\lvert S^jW\rvert^2\ \le\ \frac{\mu_{N-1}+\mu_N}2\sum_j\lvert S^jW\rvert^2\ }$$

**and this is the side that could ever bound $\theta$**, the lower bound controls a cubic from below, which is useless against a supremum. *Nobody had written it down.*

**And $c>0$ is strictly worse once the source's own defect is repaired.** With r155's (3.7) repair the bound degrades by $1+\tfrac{c}{1+c}\cdot\tfrac\delta\kappa$, which is $1.142$ at $n=12$: **the optimal choice of Cheng–Wang's parameter is to discard it.** *Lemma 3.2 is, stripped, just $\sum_j\lambda_j\lvert S^jW\rvert^2\ge-\theta\bar\lambda\sum_j\lvert S^jW\rvert^2$; the published constants are artefacts of expanding that through two identities, $\sum_j\lvert S^jW\rvert^2=\kappa\lVert W\rVert^2$ with $\kappa=2(n^2+n-8)/n$, and $\sum_j\mu_j^2=\tfrac34\lVert W\rVert^2$, which sit twenty lines apart in the stored source as (4.1) of [9] and (3.8).*

#### $C$ in closed form, and the route is NOT closed

**$C$ is an explicit combination of the two cubics, with no $n$ in it.** *Reviewer 160, recovering the coefficients from three evaluations with one degree of overdetermination (all three pairwise slopes $-48.00000$, all three intercepts $8.00000$).*

$$C(W)=\sum_j\mu_j\lvert S^jW\rvert^2=-40\mathop{\mathrm{tr}}(W^3)+8\langle W^{\#},W\rangle,\qquad\text{hence}\qquad \boxed{\ \theta=6\mathop{\mathrm{tr}}(W^3)+\tfrac18C\ }$$

exact, checked at four points. *On the $\Lambda^2$-diagonal tensors $C=4\mathop{\mathrm{tr}}(M^3)-40\sum_{i<j}M_{ij}^3$, from $\lvert E_{pq}W\rvert^2=4\sum_{x\ne p,q}(M_{px}+M_{qx})^2$ and $\lvert DW\rvert^2=16\,d^{\mathsf T}(\mathrm{diag}(r)+A)d$. The same derivation reproduces $\kappa=2(n^2+n-8)/n$, which pins the $(0,4)$ reconstruction, the slot count and the absence of a factor on $S$.*

**Non-proportionality closes nothing, and the route never needed it.** $\theta$ has only to lie in the **span** of the two cubics, which it does. *An earlier reading here treated $C\not\propto\theta$ as a closure; that is a non sequitur.* **And [fence post F2g](fence-posts.md) does not obstruct it either**, 2g forbids reaching $\theta$ through the $\Lambda^2$ spectrum *alone*, while $C$ carries the **second-kind** spectrum. *That post has now been misused this way twice in consecutive commits; it closes with "it fences off nothing about inequalities".*

**The operative side is the UPPER bound.** The coefficient of $C$ in $\theta$ is $+\tfrac18$, so bounding $\theta$ above needs $C$ bounded **above**, which is the $W\mapsto-W$ side. *Two readings here had this backwards, both traceable to the withdrawn sign.*

**THE TIGHT-AT-THE-EXTREMUM TEST, which decides the route and which was never run.** The conjecture asserts $\theta\le\theta_0(n)$ **with equality at the balanced product**. A bound that is loose at the extremiser can never prove an equality case, whatever else is sharpened, so evaluating it there settles the route before any input is bounded. With exact inputs at $n=12$:

| point | true $\theta$ | bound $6\mathop{\mathrm{tr}}(W^3)+\tfrac18\cdot\tfrac{\mu_{N-1}+\mu_N}2T$ | loss |
|---|---|---|---|
| $S^6\times S^6$ | $1.236033$ | $1.79781$ | $1.45\times$ |
| $S^5\times S^7$ | $1.228239$ | $2.66678$ | $2.17\times$ |

**Loose at the conjectured maximiser, so the route cannot reach an equality case.** *The figures $9.142899$ and $9.208072$ recorded here came from feeding the bottom pair $\{-12,-1\}$ into the negated identity, the wrong spectral tail, not a sign on $C$. Reviewer 164 supplies $2.66678$ at $S^5\times S^7$, which was on no record.*

**THE SCRIPT IS RIGHT, AND THE SIGN RUNS THE OTHER WAY.** *Inverting it claimed the script was wrong; **it was not, and the check that appeared to settle it was blind to the sign.** $\theta=6\mathop{\mathrm{tr}}(W^3)-\tfrac18C$ is the coefficient identity *rearranged*, and the $C$ column tabulated was that formula **evaluated**, not $C$ measured, so both signs reproduce $\theta$ to six digits and the agreement confirmed nothing.

**The source's own definition settles it.** $\mathring R(\varphi)_{ij}=R_{iklj}\varphi_{kl}$, which [run_second_kind_cubic.py](../scripts/runs/run_second_kind_cubic.py) implements, gives $+M_{pq}$ on $E_{pq}$ and $+\mathrm{Id}$ on the round sphere; the operator used to derive the coefficients is its exact negative. So

$$C=-40\mathop{\mathrm{tr}}(W^3)+8\langle W^{\#},W\rangle,\qquad \theta=6\mathop{\mathrm{tr}}(W^3)+\tfrac18C,\qquad C(S^6{\times}S^6)=+8.809545 .$$

**And the factor of $5$ is the wrong spectral tail, not a sign on $C$.** *Figures that disagree come from feeding the **bottom** pair $\mu_1+\mu_2=-1.46076$ into the **negated** identity, where the correct evaluation uses the **top** pair; the consistent evaluation gives $1.79781$ at $S^6\times S^6$ ($1.45\times$) and $2.66678$ at $S^5\times S^7$ ($2.17\times$). **So the tight-at-extremum loss is $1.45\times$**, and the operative side is the **upper** bound.

**And the two reviewers who supplied the coefficients DISAGREED, where the record said they agreed.** Reviewer 160's $(-48,+8)$ is the *corrected* $C$; 159's is its negative. *That mis-attribution is what let the inversion stand for three commits, recording two reviewers as agreeing when they differ removes exactly the signal Gate 2 exists to produce.*

#### The cubic ratio in closed form, which makes the bottleneck a theorem

$$\boxed{\ \frac{\mathop{\mathrm{tr}}(W^3)}{\theta}=\frac2{(n-1)(n-2)}\ }$$

exactly at the **balanced** product, $10\%$, $4.76\%$, $2.78\%$, $1.8182\%$, $0.585\%$, $0.021\%$ at $n=6,8,10,12,20,100$, decaying like $2/n^2$. **The quantifier is balanced-only and an earlier reading here said "every sphere product", which is false**: at $n=12$ the ratio is $1/55$ balanced but $23/660$ at $S^5\times S^7$, $109/1155$ at $S^4\times S^8$ and $107/440$ at $S^3\times S^9$, a factor $13.4$ out at the last. *The downstream conclusion survives, since the maximiser is the balanced point.* *The same two lines recover $\theta_0(n)^2=2(n-1)(n-2)/n^2$ and the record's own $n^2-12n+8$ criterion, which is an unforgiving check on the derivation.* **The check is a cancellation, and it has a value**: the boxed ratio and $\theta_0(n)^2$ multiply to $4/n^2=(2/n)^2$ identically, so the cubic ratio is $4/(n^2\theta_0^2)$, at $n=12$, $\tfrac1{55}\cdot\tfrac{55}{36}=\tfrac1{36}$. **And the six percentages are the boxed formula rather than independent measurements**, being $1/\binom{n-1}2$; *"decaying like $2/n^2$"* is the asymptotic, loose by nearly a factor of two at $n=6$ where the exact form gives $\tfrac1{10}$ against $\tfrac1{18}$. The three unbalanced splits stand to the balanced one at $23/12$, $109/21$ and $107/8$, the last being the factor $13.4$ exactly. *Checked in [CubicRatio.lean](../lean/HamiltonsCubic/Results/CubicRatio.lean).*

**So [problem.md](problem.md) item 5 is a theorem rather than an observation at one point**: the cubic that existing estimates bound sharply carries $2/\big((n-1)(n-2)\big)$ of $\theta$ and vanishes quadratically, while $\langle W^{\#},W\rangle$ (which depends on eigenspace alignment rather than spectrum), carries the rest.



**What the route actually costs.**

*A sign convention differs between the $C$ column and the $\theta$ column; magnitudes and ratios are unaffected, and this is the sign trap already documented in this file, recurring.* Computed by [run_second_kind_cubic.py](../scripts/runs/run_second_kind_cubic.py), which reproduces $C(S^3\times S^9)=-4.19351$, reviewer 160's falsifiable prediction, and a **sign change** across the family, which refutes proportionality far more forcefully than three ratios.

**What this leaves.** The lower bound's direction is the wrong one for branch 1:

*What this settles and what it does not.* The quantity and the quantifier are now right, and among the **named** families at fixed $n$ there is a floor with a closed form. **Whether the full graded critical set respects it is untouched**, and the reason to doubt it is on record: Reviewer 112 found $61$ distinct critical points inside a *single* grading at $n=6$, against a $1$-dimensional invariant slice, so the graded critical set is far larger than the named list and nothing here constrains its unnamed members. *Falsifier unchanged:* a sequence of graded critical points at fixed $n$ whose smallest nonzero eigenvalue modulus tends to zero.


**Hunted inside a single grading at $n=6$: the candidate falsifier is DEAD, killed by a sign convention** ([run_graded_gap_hunt.py](../scripts/runs/run_graded_gap_hunt.py), audited by [run_grading_test.py](../scripts/runs/run_grading_test.py)). Fixing $\sigma=\mathrm{diag}(1,1,1,-1,-1,-1)$ gives a $\sigma$-invariant subspace of $\mathrm{Weyl}_6$ of dimension **45**, and solving criticality inside it converges from $355$ of $400$ random starts at residual $\le2\times10^{-16}$. Those two facts stand. **Every $S$ value the hunt reported does not.**

#### The sign of $W$ is part of the definition of $S$

$\theta$ is cubic, so $W$ and $-W$ are both critical with opposite $\theta$; under the flip $\mathfrak h$ and $\mathfrak m$ exchange and **every block mass changes**. The hunt reported $\lvert\theta\rvert$ while computing $S$ on whichever sign the solver happened to land on, so its $\theta$ column and its $S$ column were in different conventions. At the balanced product this is visible in one line: sign $+1$ gives $\theta=-1.054093$ with $S_{\mathfrak{mmm}}=12$, sign $-1$ gives $\theta=+1.054093$ with $S_{\mathfrak{mmm}}=S_{\mathfrak{hhm}}=0$. **The record's convention is $\theta>0$**, and a hunt must normalise to it before measuring anything.

#### The candidate falsifier, at the correct sign

| $\theta$ | gap | $S_{\mathfrak{mmm}}$ | $S_{\mathfrak{hhm}}$ | $\dim\mathfrak m$ | graded |
|---|---|---|---|---|---|
| $0.418198$ | $2.1748\times10^{-3}$ | $\mathbf{21.5213}$ | $7.1738$ | $10$ | **no** |

Its recorded $S=0.0000$ was $S$ measured on $-W$. **It fails the first condition outright and never needed the second**, and *the diagnosis is sharper than that*: on the flipped sign $S_{\mathfrak{mmm}}=0$ but $S_{\mathfrak{hhm}}=25.6525$, so the recorded value was a one-condition test applied to the wrong sign, **two compounding errors, either of which alone would have caught it. Neither sign is graded.** The point carries no kernel, so it is immune to the tolerance trap below: its split is identical for every tolerance in $[0,10^{-3}]$, so the reading that a low-gap $S=0$ critical point sits a hundredfold below $S^3\times S^3$ is withdrawn. Reviewer 113 reached the same row independently before being stopped, $S=21.5213$, leak $=7.17377$, $\dim\mathfrak m=10$, and the two implementations agree to every digit printed.

#### And **no** point in this cone is graded: $0$ of $355$

So the cone constrains the floor in neither direction. What it does supply is a witness for the two-condition test doing real work: **three points at $\theta=0.104886$ have $S_{\mathfrak{mmm}}=7\times10^{-30}$ and $S_{\mathfrak{hhm}}=17.0000$**, genuinely $S=0$, genuinely ungraded, and a one-condition test would accept all three. That is the padded-$W_{\mathbb{CP}^2}$ phenomenon reproduced at a point with **no kernel and no padding**, which is what it was missing.

#### A second convention trap, in the $\mathfrak h/\mathfrak m$ split itself

A padded operator has a large exact kernel and `eigh` returns those eigenvalues at $\pm10^{-17}$, so a bare $\lambda<0$ test scatters half the kernel into $\mathfrak m$. Padded $W_{\mathbb{CP}^2}$ at $n=6$ then comes out with $\dim\mathfrak m=5$ and $S_{\mathfrak{mmm}}=2.64$ against the true $\dim\mathfrak m=2$ and $S_{\mathfrak{mmm}}=3\times10^{-64}$. **Zeros belong to $\mathfrak h$, and the split needs a tolerance to put them there.**

*And those two numbers understate the hazard.* They are specific to one routine: on the same matrix `eigvalsh` reports **four** negative eigenvalues where `eigh` reports five, and across implementations the untolerated split gives $\dim\mathfrak m$ anywhere in $\{3,\dots,9\}$ with $S_{\mathfrak{mmm}}$ ranging over $[0,19.0]$ (Reviewer 116). **The quantity is not merely wrong without a tolerance; it is not even reproducible.**

#### The controls that caught both

[run_grading_test.py](../scripts/runs/run_grading_test.py) computes every block mass as a **matrix commutator** in $\mathfrak{so}(n)$ under $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$, sharing no machinery with the hunt, and runs two controls plus a sum rule every time:

- $S^3\times S^3$ must be **graded**, $S_{\mathfrak{mmm}}=S_{\mathfrak{hhm}}=0$ exactly, $\dim\mathfrak m=9$;
- padded $W_{\mathbb{CP}^2}$ must be **ungraded at $\theta=\sqrt{3/2}$** with $S_{\mathfrak{mmm}}\approx0$, $S_{\mathfrak{hhm}}=8$, $\dim\mathfrak m=2$;
- and $S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2N(n-2)$, derived from total antisymmetry and the row marginal $2(n-2)$, which checks the projector bookkeeping without leaning on any one block. Residual $\le2\times10^{-13}$ at all $355$ points.

**Both controls failed on the first build and that is how both bugs were found.** A grading test with no control passes silently in either convention.

#### Across four gradings at $n=6$, random-start search finds no graded point at all, and that is a fact about the search

([run_graded_cone_sweep.py](../scripts/runs/run_graded_cone_sweep.py), $400$ starts in each of $\sigma(1,5)$, $\sigma(2,4)$, $\sigma(3,3)$ and the complex structure $J$; invariant subspaces of dimension $49$, $44$, $45$, $48$; $1493$ converged critical points at residual $\le10^{-12}$.)

| cone | converged | passing the full test | $S_{\mathfrak{mmm}}\approx0$ yet ungraded |
|---|---|---|---|
| $\sigma(1,5)$ | $358$ | $0$ | $18$ |
| $\sigma(2,4)$ | $383$ | $0$ | $5$ |
| $\sigma(3,3)$ | $372$ | $0$ | $1$ |
| $J$ | $380$ | $0$ | $0$ |

**The zero is FORCED, not sampled, and the reason is degeneracy, not basin size.** *Reviewer 115, and confirmed here independently.* Inside $\sigma(3,3)$ the criticality map's Jacobian has

| point | $\ker J$ | orbit | **excess** |
|---|---|---|---|
| $S^3\times S^3$, graded | $9$ | $0$ | $\mathbf 9$ |
| every random-start point found, ungraded | $6$ | $6$ | $\mathbf 0$ |

**Every graded point at $n=6$ is a degenerate zero of the criticality equation, and every ungraded one found is nondegenerate.** A residual-cutoff root-finder converges to nondegenerate zeros, so $0$ of $1205$ is *structurally forced*, **no amount of compute changes it**, and the basin-size reading is a symptom rather than the cause.

#### This rescopes fence post F13 rather than repeating it

Random starts reach the top of $\theta$ perfectly well: under gradient **ascent** they reach $\theta_{\max}=\sqrt{3/2}$ from $100$ of $100$ starts in full $\mathrm{Weyl}_6$, and $59$–$60$ of $60$ per cone. What fails is **root-finding on the criticality equation**, which is blind to degenerate zeros by construction. *The post's statement ("random-start Newton does not reach the high-$\theta$ basin"), is right about Newton and wrong about random starts.*

#### And it makes isotropy enumeration necessary rather than convenient

$S^3\times S^3$ is a **degenerate saddle, not a local maximum**: zero positive Hessian directions, but $\theta$ takes both signs at cubic order on the $9$ null directions transverse to the orbit. **So ascent misses it too**, and neither of the two general-purpose methods can reach it. A search over isotropy subalgebras reaches graded points by construction, and nothing else on offer does.

*The recovery rates the two reviewers measured disagree, $95/95/78/52/18/2.5/0\%$ against $68/48/22/32/10/12/0\%$ at relative radii $10^{-3}$ to $1$, which 115 attributes to Levenberg–Marquardt step control rather than to the basin. **They agree on the only figure that was load-bearing, $0$ at relative radius $1$**, and the degeneracy mechanism above supersedes the argument either rate was serving.*

**Therefore the sweep constrains the floor in neither direction.** Zero graded points found is a statement about the sampler's reach, and **the statement is stronger than one witness in one cone**: the sweep misses a *known* critical point in **every** cone that contains one. Padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ lies in $\sigma(2,4)$ and in $J$, and $S^3\times S^3$ at $\theta_0(6)$ in three of the four, and no random start reached any of them. The cone ceilings are $0.8811$, $0.8811$, $0.7599$, $0.7921$ against known points at $1.054093$ and $1.224745$ sitting inside those same subspaces (Reviewer 116). This is [fence post F13](fence-posts.md) (random-start Newton does not reach the high-$\theta$ basin), recurring in the $\sigma$-cone setting, where it is sharper: the highest $\theta$ any random start reached inside $\sigma(3,3)$ is $0.661148$, against $\theta_0(6)=1.054093$ sitting in the same subspace.

**What the sweep does establish, and it is worth having.** Twenty-four points across three cones have $S_{\mathfrak{mmm}}$ at $10^{-30}$ and $S_{\mathfrak{hhm}}$ nonzero, $17.0000$ at the smallest-gap one, $\theta=0.104886$. They are slack-zero, ungraded, and carry **no kernel and no padding**. The record's only prior witness for "$S=0$ does not imply graded" was padded $W_{\mathbb{CP}^2}$, which both Gate 2 reviewers called fragile precisely because its ungradedness is manufactured by padding. *That objection is now answered.*

**So a census of the graded critical set needs a method that is not random-start Newton.** Naming what would work is the open item: the graded points are the ones with symmetry, so a search over isotropy subalgebras reaches them by construction where a random start cannot.

**Block sums over disjoint index blocks obey a harmonic-square law.** $Q$ is quadratic and additive over **disjoint coordinate blocks**, orthogonality as operators is *not* enough, since $\langle W_{S^3\times S^3},W_{\mathbb{CP}^2}\rangle=0$ at $n=6$ while the cross term is $0.2152$; the $c_{anm}$ triangle condition forces overlapping indices for a nonvanishing cross term. Coordinate-disjointness is sufficient but not necessary: the real condition is $W_A\circ W_B=0$, which a $\Lambda^+/\Lambda^-$ pair on the *same* four coordinates also satisfies. Where it applies, criticality forces $\theta=a\theta_A=b\theta_B$ and with $a^2+b^2=1$,

$$\frac1{\theta^2}=\sum_i\frac1{\theta_i^2},$$

verified at twenty-five held-out block sums to $9\times10^{-16}$, three and four blocks, unequal dimensions, decomposable blocks, scattered coordinates, ambient padding, with criticality residuals as low as exactly $0$. Hence $|\theta|<\min_i|\theta_i|$; the absolute values are needed, since $(+\mathrm{Fox})\oplus(-\mathrm{Fox})$ at $n=8$ gives $\theta=+0.866$ against $\min_i\theta_i=-1.2247$. Equal blocks give $\theta_1/\sqrt k$, checked at $k=2,3,4$.

**The bound this was pursued for is refuted, and the replacement is weaker in hypothesis and stronger in reach.** "Every decomposable critical point has $\theta\le\sqrt3/2$" fails twice over. Its hypothesis, $\theta_i\le\sqrt{3/2}$ for $n_i\le11$, **is the open low-dimensional half of Conjecture A**, proved outright only at $n_i=4$, where $P=9(\det W^++\det W^-)$ on $\mathrm{Weyl}_4$ gives $\max P=\sqrt{3/2}$ exactly; for $5\le n_i\le11$ the record's own word is "presumed", the only unconditional statement being a dichotomy at $8\le n\le11$. And the constant is false from $n=16$: $S^6\times S^6$ on twelve coordinates plus $W_{\mathbb{CP}^2}$ on four gives $\theta=0.869988927484$, residual $2.7\times10^{-16}$, with a second witness at $n=20$ reaching $0.885202$. **What survives is $|\theta|\le\max_iM(n_i)/\sqrt2<1<\theta_0(n)$ for every $n\ge12$, with $\theta/\theta_0\le0.706$, requiring only $\theta_i<\sqrt2$**, an induction on $n$. The agreement with the Fox plateau's $0.866025$ is a tautology, since the plateau is defined as two $W_{\mathbb{CP}^2}$ blocks.

**Padding is not covered by any of this, and the recorded cap is wrong.** Padding leaves $\theta$ unchanged, so it is the $b=0$ degenerate case and the law says nothing about it. The claim that ungraded $S=0$ points sit at $\theta/\theta_0\le0.53$, capped at $0.89$, is **false**: padded $W_{\mathbb{CP}^2}$ has $S=0$ exactly, is ungraded (leaks $16/24/32$), and sits at $0.9909\,\theta_0(12)$, above $\theta_0$ at $n=8$ and $n=10$. Padded Fox, $S^4\times S^4$ and $S^3\times S^3$ give $0.9909$, $0.9269$, $0.8528$. The $0.89$ figure belongs to the separate degenerate-point statement; the block-sum law's own cap at $n=12$ is $0.7006$.

**Padding does not carry degeneracy into the danger zone.** The padded points that sit closest to the top stay nondegenerate: $S^4\times S^4$ padded $8\to10$ at $0.9547\,\theta_0$ has $\dim E(\tfrac12)=\text{orbit}=32$, and $S^5\times S^5$ padded $10\to12$ at $0.9708\,\theta_0$ has $45=45$. The degenerate padded points are those degenerate at their own dimension, $S^3\times S^3$ padded $6\to10$ gives $42$ against orbit $33$, at $0.8784\,\theta_0$. Since padding freezes $\theta$ while $\theta_0(n)$ rises, an inherited degeneracy falls further behind the top value at every step, and the balanced products that would sit closest do not acquire one.

**Padded points at the top of the range are nondegenerate, certified by exact eigensolve.** $E(\tfrac12)$ is **equal** to the orbit tangent (not merely equidimensional), at $S^6\times S^6$ padded $12\to14$ ($60=60$) and $S^5\times S^5$ padded $10\to12$ ($45=45$), with principal cosines $1.000000000000$ and deflation leak $8.5\times10^{-16}$. The highest ratios available are $S^6\times S^7$ padded $13\to14$ at $0.9895\,\theta_0$ and $W_{\mathbb{CP}^2}$ at $n=12$ at $0.9909$, both nondegenerate; roughly thirty-five padded points above $0.9269$ are all clean, while every degenerate point found sits at $\theta/\theta_0\le0.8355$.

**The gap obeys a rational law, and it shrinks.** Any padding of a seed from $n_0$ gives $\min|\lambda-\tfrac12|=\frac1{2(n_0-1)}$, **independent of the target dimension**, agreed to seven digits by full eigensolve, deflated eigensolve and matrix-free Lanczos ($1/22$ for $n_0=12$, $1/18$ for $n_0=10$). Padding the *balanced* product freezes $\theta$ at $\theta_0(n_0)$ while the ambient bound rises, so as $n_0$ grows both tend to $\sqrt2$ and $\theta/\theta_0(n)\to1$ while the gap $\to0$, at $n_0=1000$, $0.999997$ against $0.0005$. **This costs less than it appears.** Conjecture A is a per-dimension statement; at fixed $n$ only the finitely many seeds $n_0\le n$ contribute, all with gap $\ge\frac1{2(n-1)}$, and compactness supplies a constant $c_n>0$ that may depend on $n$. What it rules out is narrower: no argument may rest on a spectral gap or a $\theta$-margin **uniform in $n$**, which matches the obstruction already recorded for two-block nondegeneracy. It constrains the shape of the argument, not its conclusion.

**Two facts about what is computable here.** First, **the full operator at $n=14$ is feasible**, vectorised it costs about ten seconds end to end, and the nine-minute timeout on record measured a Python-loop implementation plus [weyl_basis](../scripts/lib/review_r30_core.py) materialising a $277$ MB dense array. Building the nullspace in symmetric coordinates removes it, giving the $3080$-dimensional basis in $1.5$ seconds. Second, **a power iteration on a Rayleigh quotient produces an upper bound on the minimum and therefore can never certify a spectral gap**; the figures $1.9\times10^{-2}$ and $2.9\times10^{-2}$ once recorded here were that iteration stalling a decade above the true $2.07\times10^{-3}$ and $3.09\times10^{-3}$.

**A basis-free projection onto $\mathrm{Weyl}_n$, verified as a genuine orthogonal projection.** $P(X)=Y-\frac2{n-2}\mathrm{KN}(\rho_0)-\frac1{n(n-1)}s\,\mathrm{KN}(g)$ with $Y=X-\mathrm{Alt}(X)$, correct at $n=4,5,7,9,11,12,13,14$ to $1.1\times10^{-15}$, self-adjoint to $8\times10^{-17}$, with $\mathop{\mathrm{tr}}P=\dim\mathrm{Weyl}_n$ exactly. Both coefficients are pinned independently (inputs annihilating each term in turn, and separate regressions) so no compensating pair of errors can hide, and the classical curvature decomposition derives them once $\mathrm{KN}(h)=\tfrac12(h\owedge g)$. Halving either alone still fixes $\mathrm{Weyl}_n$ to $3\times10^{-16}$ while being $13.1\%$ or $2.6\%$ wrong off it, which is why the check must be run off the subspace. It is **not needed for $L_e$**, which already preserves $\mathrm{Weyl}_n$ to $1.8\times10^{-15}$.

**Padding creates degeneracy rather than only inheriting it, and the earlier sentence claiming otherwise is withdrawn.** The whole $S^2\times S^k$ family for $k=2,\ldots,8$ is nondegenerate at its own dimension and degenerate at **every** padding, eighteen cases, with excess $q\,(n-n_0)$ for $S^2\times S^q$, doubled when both factors are $2$-spheres, generalising the $4(n-4)$ recorded below. That family can never threaten the top of the range, since $\theta(S^2\times S^q)\uparrow1$ while $\theta_0\uparrow\sqrt2$, capping its ratio at $1/\theta_0(n)\to0.707$. **Scope**: the sweep covers two-block products and $W_{\mathbb{CP}^2}$; three-block products and the subalgebra family are untested.

**Multi-block products are excluded from the crux by their value.** The fully block-symmetric $(S^3)^3$ at $n=9$ is exactly critical (residual $8\times10^{-17}$) at $\theta=0.769800359=0.6547\,\theta_0(9)$, degenerate with orbit $27$ against $\dim E(\tfrac12)=81$, and a **saddle**: $\lambda_{\max}(L_e|_{W^\perp})=1$, not $\tfrac12$; indeed $L_e=1$ on the *whole* invariant space, making it a strict local minimum within its own symmetry class. Degeneracy is generic at $k\ge3$, excess $24$–$162$ across seven products, rather than an analogue of the $(3,3)$ anomaly. **What excludes it is $\theta$**: $P$ is constant on connected components of $\mathrm{Crit}(P)$, and $\sup\theta/\theta_0$ over $k$-block products is $1/\sqrt{k-1}$, putting every three-block product below $0.7071\,\theta_0$ (largest found $0.6804$). A slack of $3.97\times10^3$ was recorded here and is **withdrawn**: the natural value is $81$, $0.75$ in the $\theta$-identity convention and $12.73$ on the convention this file uses for its $8.94$ and $16.7$ figures, the inflation coming from a helper that brackets in the adjoint representation and so carries $(n-2)^2$. **And the argument was a non sequitur regardless, $S$ is not a distance to $\{S=0\}$**: perturbing padded $W_{\mathbb{CP}^2}$, an exact $S=0$ point, by $10^{-6}$ gives $S\in[11.3,22.2]$. Openness fails through a sequence, so the value of $S$ at one point carries no topological information.

**The two slack conventions coincide exactly where $\mathfrak h$ is a subalgebra, and part company where it is not.** $S_\theta=v^2S_{\mathrm{struct}}$ at nine tested points to $1.3\times10^{-9}$. The separating witness is the **$C_5$ blow-up** at $n=10$, blocks $(2,2,2,2,2)$ with ratios $4:-2:+1$: exactly critical at residual $1.3\times10^{-16}$, with $S_{\mathrm{struct}}=0$ and $S_\theta=10/9$. **The crux needs the structural one.** Also $S_\theta$ is not bounded below, along $(2,2,m)$ it decays to $0.165$ at $n=34$ while $S_{\mathrm{struct}}=12m$ diverges.

**Indecomposable $S=0$ critical points exist, and they are $C_5$ blow-ups.** Of 3767 multi-block criticals scanned at $n=9\ldots16$ and $k=3,4,5$, **41 are indecomposable with $S_{\mathrm{struct}}=0$**, all at $k=5$, all of $C_5$ blow-up type, and all exactly where the two slack conventions disagree. None occur at $k=3$ or $k=4$, for a structural reason: the negative block graph must be connected, triangle-free and non-bipartite, and $C_5$ is the smallest such graph. The mechanism is combinatorial: $S_{\mathrm{struct}}=3\sum_{a<b<c}n_an_bn_c=3\times(\text{triangles of the negative block graph})$, exact on all 437 products with $n\le20$ and on 62 partitions to $n=34$. **So $S=0$ exactly when that graph is triangle-free**, which is why multi-block sphere products, whose negative graphs are complete, never achieve it, and why $C_5$ does. Combined with the requirement that the graph be connected and non-bipartite, $C_5$ is forced as the smallest example, so $S>0$ for $k\ge3$ sphere products is a theorem rather than a measurement. Reproduced independently: the blow-up at $n=10$, blocks $(2,2,2,2,2)$ with entries $4:-2:+1$, is exactly critical (residual $1.3\times10^{-16}$), Ricci-flat, with $S=0$ **exactly**, at $\theta=0.670820393=0.5590\,\theta_0(10)$. **Note this exceeds $1/\sqrt{k-1}=0.5$**, so the $k$-block value bound covers sphere products and not this class, the exclusion here is the measured value, not that bound.

**Blow-ups fall inside the granted diagonal case, which closes the class outright.** Every blow-up is constant on coordinate $2$-planes, hence **exactly coordinate-diagonal**, off-diagonal mass $0.000$ in the $\phi$ basis at the $C_5$ point, with Ricci $5.6\times10^{-17}$ and Bianchi exactly $0$. The diagonal case is granted in this project, so $P\le\theta_0$ holds for the whole class with equality only at the balanced two-block product: **a blow-up reaching $\theta_0$ would be the conjectured maximiser.** This needs no sweep and no limit computation, and it subsumes the measured $\sup=1/\sqrt2$ below.

**The $C_5$ family's ratio has a closed form.** $(\theta/\theta_0)^2=\frac{5(m-1)}{2(5m-2)}$ for equal blocks of size $m$, increasing in $m$ with derivative $\frac{15}{2(5m-2)^2}$, so $\sup=1/\sqrt2$, **never attained**; $\theta<1$ always, since $5m^2-(m-1)(5m-1)=6m-1$. Verified against the full operator at $n=10,15,20$. Over the whole indecomposable class (triangle-free, connected, non-bipartite negative graph), the supremum is exactly $0.7071068$, attained in the limit at $k=5,6,7$ and unchanged under unequal block weights; $C_7$, $C_9$, $K(7,3)$ and $K(9,4)$ admit **no** $S=0$ blow-up at all, while $C_{11}$ and Petersen cap at $0.5$. A finite sweep over 197 five-block size vectors to $n=22$ gives a best of $0.6535535$. **The question must be stratified**: unrestricted, every two-block sphere product has ratio $\to1$, so an unstratified supremum is $1$ trivially.

**The subalgebra family is closed for the crux, and splits at the cap.** Lemma L23 caps $r=\dim\mathfrak h$ at $n(n-2)/4$, and the family divides cleanly around it. **At the cap** ($n=10$, $r=20=\dim(\mathfrak{so}(5)\oplus\mathfrak{so}(5))$), the point is critical at residual $2.2\times10^{-16}$ with $\theta=\theta_0(10)$ exactly, $S=0$, and **nondegenerate** (orbit $25=\dim E(\tfrac12)$); its overlap with the balanced sphere product is $1.000000000$, so it **is** that point and Lemma L27 already covers it. **Below the cap** the members are not graded: $\mathfrak{so}(5)$ acting on $\mathbb R^{10}$ by its adjoint, $r=10$, is critical at $8.4\times10^{-17}$ and **degenerate** with excess $35$ (orbit $35$, $\dim E(\tfrac12)=70$), but its slack is $140$, so it lies outside $\{S=0\}$ and cannot bear on openness. **Above the cap**, $\mathfrak{so}(4)\oplus\mathfrak{so}(6)$ at $r=21$ is not critical at all, residual $6.8\times10^{-2}$. So every degenerate member found is excluded by its slack and the only $S=0$ member is the balanced product, the same shape as the multi-block products.

**The $C_5$ blow-up is degenerate and $\{S=0\}$ is open there.** *Corrector evidence is blind to it by construction.** The point has orbit $40$ against $\dim E(\tfrac12)=60$ and $\lambda_{\max}(L_e|_{W^\perp})=1.206011$. **$S>0$ critical points do sit nearby**, a shell of eight, residuals $4\times10^{-15}$ to $10^{-13}$, $\theta$ within $0.16\%$ of $0.670820$, $S\in[0.041,0.102]$, at orbit distance $0.10$ to $0.22$, so the earlier claim that none exist is **withdrawn**. The corrector sweep that appeared to show it could not have: the symmetric three-tensor $\langle F_i,F_j\circ F_k\rangle$ vanishes **identically** on $E(\tfrac12)$ at this point ($3.9\times10^{-17}$, against $6.6\times10^{-2}$ at $(3,3)$), so every $E(\tfrac12)$ start begins with residual $O(t^3)$ whatever lies nearby, and the returns measured the base point's attractiveness rather than the absence of a neighbour.

**What settles it is the third-order obstruction.** With $\Psi(v)=\Pi_{E(1/2)}\big(v\circ(2L_e-1)^+(v\circ v)\big)$: $\Psi$ vanishes on the whole orbit subspace and satisfies $\Psi(o+x)=\Psi(x)$, so the tangent cone is sixty homogeneous cubics in twenty unknowns. Its minimum over the excess unit sphere is $6.06\times10^{-4}$ and $9.03\times10^{-4}$ by two independent implementations, with **zero of thousands of starts below $10^{-6}$**, and $12000$ uniform samples give $0.219$. Tangent-cone invariance under the orbit tangent then forces **cone $=$ orbit tangent**, so $\mathrm{Crit}(P)$ near the point is exactly the orbit. Cross-checked by Lyapunov–Schmidt over 709 complementary dimensions and by a gauge-frozen corrector whose residual floor is $2\|\Psi(v)\|t^3$ to three digits. Two structural notes: $W$ has **no zero eigenvalue** on $\Lambda^2$, so $\dim\mathfrak m$ is stable and $S$ is locally continuous here, unlike padded $W_{\mathbb{CP}^2}$; and the twenty excess directions carry **zero mass on the diagonal**, so the degeneracy is entirely transverse to the diagonal locus.

**The climb has a closed form and a supremum.** For the equal-block $C_5$ blow-up at $n=5m$, $\theta/\theta_0=\tfrac12\sqrt{10(m-1)/(5m-2)}$, strictly increasing with **supremum $1/\sqrt2$, never attained**, reproducing $0.5590$, $0.6202$ and $0.6455$ exactly. In the limit the vertex system collapses to $K^2=\tau K$, giving $\theta/\theta_0\to1/\sqrt r$, and $r=1$ forces a complete-bipartite negative graph, the two-block sphere product. Larger triangle-free graphs do **worse**, not better: $1/2$ for Petersen, $1/\sqrt5$ for Clebsch, about $0.21$ for Higman–Sims. Correction to an earlier figure: the $0.5960$ recorded at $(2,2,2,3,3)$ has $S=54$, not $S=0$, and the $S=0$ maximum there is $0.580508$.

**A trap in enumerating them.** Solving the $k$-block vertex system and taking the largest $\theta$ does **not** give the largest blow-up: that system contains every coarser partition as a degenerate solution with several blocks carrying identical rows. Doing so returns $\theta/\theta_0=0.9882$, $0.9931$, and exactly $1.0000$ at $(2,2,2,2,4)$, apparent $S=0$ points at the conjectured maximum, all of which collapse to **two** effective blocks; the $n=12$ case groups as $\{0,1,2\}$ and $\{3,4\}$ and is $S^6\times S^6$ wearing five labels. Count distinct rows of $w$ before believing a $k$-block solution is $k$-block, **but that filter alone is insufficient**, with two holes: a **singleton block has no diagonal entry** to compare, so at sizes $(2,2,1,1,1)$ a solution with five distinct rows, $S=0$ and ratio $0.989949$ is really $S^3\times S^4$; and a **null block** passes too, giving padded $S^3\times S^3$ at $0.952579$. The correct test is a merge test together with a null-block check.

**A completeness proof at $k=3$.** The block-symmetric locus is three-dimensional and criticality is three quadrics, so over $\mathbb Q$ there are exactly seven nonzero rays (the Bézout bound of eight less the origin) and the solver misses nothing. Note the vertex-solver driver's zero-entry filter discards genuine $S=0$ critical points, so it must not be used to enumerate them.

**A third class of ungraded $S=0$ point.****A third class of ungraded $S=0$ point.** "Block sum or padding" is not exhaustive. At $n=8$, $228$ of $300$ Levenberg–Marquardt starts found critical companions of padded $W_{\mathbb{CP}^2}$ carrying $12$–$73\%$ of their mass on **cross-block** planes, one of which obeys the harmonic-square law exactly; $\ker L_X$ runs $148$–$285$ dimensions where the coordinate picture predicts $0$–$15$. The classifying condition is $W_A\circ W_B=0$, not disjointness of support.

**What the decomposable case already gives unconditionally.** The direct-sum saddle lemma on record is correct ($\mathrm{Hess}=+3\theta\|H\|^2$, verified) so decomposable **maximizers** are already excluded with no hypothesis at all. The harmonic-square law's distinct contribution is over the whole decomposable *critical set*, not over maximizers.

**Where this leaves the repair.** Every ungraded $S=0$ point found sits low, $\theta/\theta_0\le0.53$ measured and capped at $0.89$ for $n=12$ by the law above, because block sums strictly lower $\theta$. **A $\theta$-localised hypothesis is untouched; a $\dim\mathfrak m$-localised one is dead.**

**A tooling flag, checked and withdrawn.** An audit reported that the repository's `slack(...)` helpers evaluate a different function from the structural slack away from the subalgebra family, returning negative values at every $\mathbb{CP}^m$. **They do not.** [delta2_and_grad](../scripts/lib/run_bianchi_defect_highp_seed.py) takes $W$ and internally builds $W_-$, returning $\|\mathrm{Alt}(W_-)\|^2$, so the $6\delta^2$ term is neither evaluated at $W$ nor vanishing. With it included, $\|\mathrm{Ric}(W_-)\|^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)$ returns exactly $0$ at $\mathbb{CP}^3$, $\mathbb{CP}^4$ and $\mathbb{CP}^5$, agreeing with the direct bracket leakage. The negative sequence $-\tfrac{2m+2}{3(2m-1)}$ is what the formula gives **with the defect term dropped**, and no repair is needed.

**Padding is a critical-point-preserving operation, exactly.** For any critical $W$ on $\Lambda^2\mathbb R^{n_0}$, the zero-padded operator on $\Lambda^2\mathbb R^n$ is **already in $\mathrm{Weyl}_n$** (first Bianchi exactly $0$, Ricci $\sim10^{-17}$) and $Q$ commutes with padding bit for bit, $\max|Q_n(\mathrm{pad}\,W)-\mathrm{pad}\,Q_{n_0}(W)|=0.0$ at $n=8,10,12,14$, because $[\Lambda^2\mathbb R^{n_0},\Lambda^2\mathbb R^{n_0}]\subseteq\Lambda^2\mathbb R^{n_0}$ forces $W^\#$ back into the block. **So every critical point pads to a critical point with the same $\theta$ and the same $S$**, and $\theta$ is frozen while $\theta_0(n)\uparrow\sqrt2$. Padding does **not** preserve nondegeneracy: $S^3\times S^3$ keeps excess $9$ at $n=6\ldots14$ including odd $n$, lying wholly inside the padded block as the Weyl projection of $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)$, and the whole $S^2\times S^k$ family is nondegenerate natively but degenerate at every larger $n$ with excess growing linearly, $4(n-4)$ for $S^2\times S^2$. Block mass separates the two mechanisms: the $(3,3)$ excess is $100\%$ inside the block, the $S^2\times S^k$ excess $100\%$ outside. Balanced products with $k\ge4$ are unaffected, which is what keeps $\theta_0(n-2)$ from sitting degenerately just under $\theta_0(n)$.

**Degeneracy does not break openness, which is what the component route actually needs.** A degenerate orbit can still be isolated at third order, and here it is: $\Psi_1=-0.592927061$, the same nonzero constant at $n=6,8,10$, with gauge-free correctors from $48$ and $262$ transverse starts all returning to the starting orbit at $S\le2.4\times10^{-23}$ and $\theta$ unchanged to twelve digits. So $\{S=0\}$ is **open** at every degenerate point tested. Two consequences for route R2: the clean "nondegenerate $\Rightarrow$ open" mechanism is unavailable, but the conclusion it was serving is not refuted; and since $P$ is constant on connected components of $\mathrm{Crit}(P)$, the set $\{\theta\ge t\}\cap\mathrm{Crit}(P)$ is automatically a union of components, so the value localization costs nothing structurally. Every degenerate $S=0$ point on record sits at $\theta\le\sqrt{6/5}=1.095445$, giving a safe margin of $0.050$, $0.105$, $0.141$ at $n=8,10,12$ that widens with $n$.

**The hypothesis is false at real points, and this is now proven over $\mathbb Q$.** "Every graded critical point is Morse–Bott nondegenerate" fails. With the integer-scaled operator, $\theta_0$ comes out an **integer** ($24,10,20,6,60,42,6,6$) and the criticality residual is **literally zero**, not $10^{-16}$; the kernel is then settled by integer-preserving elimination over $\mathbb Q$ with per-row gcd normalisation, fast because the system is sparse.

| graded point | $n$ | $\theta$ | nullity / orbit over $\mathbb Q$ | excess |
| --- | --- | --- | --- | --- |
| $\mathfrak{su}(3)$ Kähler | 6 | $1.095445$ | $16/11$ | $5$ |
| $\mathfrak{su}(4)$ Kähler | 8 | $1.054093$ | $30/21$ | $9$ |
| $\mathfrak{su}(5)$ Kähler | 10 | $1.035098$ | $48/34$ | $14$ |
| $\mathfrak{su}(6)$ Kähler | 12 | $1.024695$ | $70/50$ | $20$ |
| Fox plateau | 8/10/12 | $0.866025$ | $36/20$, $52/36$, $68/52$ | $16$ each |

The Fox plateau is $(W_1+W_2)/\sqrt2$ with $W_i$ a Fox operator on each of the disjoint $4$-blocks $\{0,1,2,3\}$ and $\{4,5,6,7\}$, **not** a padded $S^2\times S^2$. Its isotropy is $U(2)\times U(2)$ together with $\mathfrak{so}(n-8)$, so the orbit is $\binom n2-8-\binom{n-8}2=20,36,52$, measured and matching the column above. A padded $S^2\times S^2$ shares the nullity column ($8n-28$) but has orbit $\binom n2-2-\binom{n-4}2=20,28,36$ and is a different point; the coincidence in nullity misled one audit into reading the orbit column as an error.
| $S^3\times S^3$ (control) | 6 | $1.054093$ | $18/9$ | $9$ |

Two primes agree with the $\mathbb Q$ answer in every case, and a second independent exact implementation (Fraction elimination) reproduces $S^3\times S^3$.

**Why exactness was needed here specifically.** Rank over $\mathbb F_p$ is at most rank over $\mathbb Q$, so $\mathrm{nullity}_p\ge\mathrm{nullity}_{\mathbb Q}$: **mod-$p$ bounds the kernel from above.** That settles *nondegeneracy* and is useless for *degeneracy*, which is exactly why the earlier Result 12(a) had to report the $n=6$ $(3,3)$ case as "inconclusive". The gap was structural rather than an oversight, and it is now closed. At the plateau the second-order branching obstruction $\Pi_{\ker}Q(v)=0$ vanishes on **all 16** transverse directions (minimum $1.0\times10^{-31}$, median $4.6\times10^{-31}$). That is consistent with a genuine critical manifold but does not establish one: the obstruction is one-sided, proving no branch when it *fails* rather than a branch when it vanishes, and the slice-constrained corrector that would settle it did not converge. This corroborates this project's own earlier Result 12(a), which the Morse–Bott measurement appeared to contradict.

**The final step is a tautology.** $S$ is *defined* as $\|\mathrm{Ric}(W_-)\|^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)$, so the "exact $\theta$ formula" is that definition rearranged. It cannot convert $S\ge c$ into a bound on $\theta$: doing so silently assumes $A/t\le\theta_0$ for the remaining terms, which is **strictly stronger than the target**. Reviewer 12 already refuted the assembled version of exactly this step. **The repeated claim that the route needs "no estimate at any step" is withdrawn.**

**One worry cleared.** $S$ is locally Lipschitz across eigenvalue crossings, measured jumps scale as $2.7\times10^{-3},2.3\times10^{-4},\ldots,2.3\times10^{-7}$ as $h$ shrinks, so $\{S=0\}$ is closed in $\mathrm{Crit}(P)$. Continuity, not smoothness, is what closedness requires.

#### Lemma L11, the two-block sphere products that are Morse–Bott nondegenerate, and the two families that are not

> **STATEMENT.** *At the unpadded dimension $n=p+q$, for $p,q\ge3$ with $(p,q)\ne(3,3)$, $S^p\times S^q$ is Morse–Bott nondegenerate: the Hessian kernel is exactly the orbit tangent, of dimension $pq$.* **The one degenerate case in that range is $(3,3)$**, and **$\min(p,q)=2$ is nondegenerate but not a maximum**, which is a different failure. *Three verifiers, unanimous.*

> **THE TWO FAILURES ARE DIFFERENT.** By [Lemma L24](second-order.md), $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$, so the kernel is an eigenspace **at** $\tfrac12$: degeneracy needs the value itself. At $p=2$, $\mu=\frac{n-2}{2(n-3)}=\tfrac12+\frac1{2(n-3)}$ is **strictly above** $\tfrac12$, an ascent direction, which costs maximality and contributes nothing to the kernel. **The seed of the error is one word in [Lemma L26](#lemma-l26-the-dangerous-eigenvalue-of-the-two-block-spectrum-in-closed-form-canonical-statement-and-proof)'s prose**, *"the family reaches $\tfrac12$ exactly at $p=2$"*, which is loose for its own displayed criterion $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$. **Quoted without the display, "reaches" reads as "attains", and $\mu\ge\tfrac12$ failing becomes $\mu=\tfrac12$ holding.** *A paragraph that stood here drew exactly that inference and refuted itself in its own sentence, an excess $\frac1{2(n-3)}>0$ being precisely the statement $\mu\ne\tfrac12$.*

> **A CLOSED-FORM WITNESS THE RECORD ALREADY HELD.** At $(2,2)$, [Lemma L26](#lemma-l26-the-dangerous-eigenvalue-of-the-two-block-spectrum-in-closed-form-canonical-statement-and-proof)'s own recorded spectrum $(-1)^4,(\tfrac12)^4,1^2$ sums to $10=\dim\mathcal W_4$, with $\dim E(\tfrac12)=4=pq$ and $\mu_{2,2}=1$ supplying the non-simple $1$: **non-maximal and nondegenerate at once.** One member settles the universal clause.

> **WHAT IS OWED: NONDEGENERACY AT $\min(p,q)=2$ HAS NO ARGUMENT ON FILE.** [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof) excludes $q\le2$ by name, saying *"the decomposition itself is false"* there; [L126](second-order.md) and [L127](second-order.md) both record that the summand route does not reach it; and **[L128](second-order.md) cites L11 for $S^2\times S^4$ while this block cites L128, a two-step circle.** *The single missing statement is that the $L_e$-spectrum of $\mathcal D_n\cap W^\perp$ at $S^2\times S^q$ omits $\tfrac12$, which [L127](second-order.md) already flags as unrepaired.*

> **AND THE $S^2\times S^4$ WITNESS IS RIGHT BY A ROUTE ITS OWN SOURCE DISCLAIMS.** The values $1,\tfrac12,0,\tfrac13,\pm\tfrac23$ are correct, but they are read off a decomposition whose genuine dimensions sum to **$86$ against $\dim\mathcal W_6=84$**. *The over-count is exactly one summand, $S^2_0(\mathbb R^2)$, of dimension $2$ at value $0$, the only dimension-$2$ summand present.* Deleting it gives $84$, $\mathop{\mathrm{tr}}L_e=0$, and $\tfrac12$ at multiplicity $8=pq$; **the same repair at $(2,2)$ reproduces the recorded spectrum verbatim.** *The trace check passed on the uncorrected decomposition because the fictitious summand carries $L_e=0$, so it could not have caught this.* **The multiplicity-$8$ claim is a lower bound presented as an equality.**

> **THE DIMENSION IS PART OF THE STATEMENT, AND OMITTING IT IS WHAT MADE THE TWO READINGS LOOK CONTRADICTORY.** Everything above is at $n=p+q$. **At a padded dimension the $p=2$ family IS degenerate**: [L126](second-order.md)'s padded four-set carries $\frac1{2(p-1)}$, which is exactly $\tfrac12$ at $p=2$, and counting those orbit-free blocks gives $q(n-n_0)$ at $S^2\times S^q$, doubled when both factors are $2$-spheres, *so $4(n-4)$ at $S^2\times S^2$, reproducing the recorded excesses exactly.* **So the refuted paragraph was true of the padded family and false of the native one**, and neither paragraph named a dimension. *Padded $(3,q)$ with $q\ge4$ is untested.*

> **PROOF, REPLACING THE REFUTED MECHANISM.** [Lemma L26](#lemma-l26-the-dangerous-eigenvalue-of-the-two-block-spectrum-in-closed-form-canonical-statement-and-proof) gives the closed form
> $$\mu=\frac{n-2}{2(p-1)(q-1)},\qquad \tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)},$$
> so $\mu<\tfrac12$ **exactly when $(p-2)(q-2)>1$**, which among $p,q\ge2$ fails only at $\min(p,q)=2$ and at $(3,3)$, **and the two failures are different failures**: at $(3,3)$, $\mu=\tfrac12$ and the point is degenerate; at $\min(p,q)=2$, $\mu>\tfrac12$ and the point is nondegenerate but not a maximiser. [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof) then shows that in the remaining range $\tfrac12$ is attained on the orbit tangent alone, so $\dim E(\tfrac12)=pq$ and the point is nondegenerate. $\square$

> **WHAT THE CLAIM REDUCES TO.** *[r461](../reviews/REVIEW_r461.md) and [r462](../reviews/REVIEW_r462.md), independently.* The block explained the $(3,3)$ exception by $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$. **That isomorphism is true and computes nothing**, it is a coincidence of dimension in three variables, and it identifies neither the eigenvalue nor the second exceptional family. *The closed form above finds both.*

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result.*

At each such point the kernel of the Hessian equals the tangent space to the critical orbit exactly, no flat direction beyond the orbit, along which the potential is constant anyway. For $S^k\times S^l$ the common value is $k\,l$, matching the orbit tangent space $\mathbb{R}^k\otimes\mathbb{R}^l$ that Nienhaus identifies in closed form. Measured at all $36$ splits with $k,l\ge2$ up to $n=14$ (*a set that includes $(3,3)$, which the paragraph below calls the exception*) and established in **exact arithmetic** at eight, over $\mathbb Q$ at $n=6$ and modulo two primes at $n=8,10,12$: $(4,4)$, $(3,5)$, $(5,5)$, $(3,7)$, $(6,6)$, $(5,7)$, $(3,9)$ **and $(2,6)$**. *Seven were named and the eighth is the only $\min(p,q)=2$ entry, which is the family the dispute above turned on.* Clearing the denominators makes the eigenvalue an integer and the kernel an integer linear system, so no numerical threshold enters. **$S^7\times S^7$ needs no arithmetic at all**: $\tfrac12-\mu=\tfrac13$ there by the closed form.

**The exception is $(3,3)$, and the isomorphism once offered as its mechanism is not one.** The kernel is $18$ against an orbit of $9$; what was said to force that is $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$. **Under $O(3)\times O(3)$, the group [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof)'s multiplicity-freeness lives in, those summands are not isomorphic**: $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det$, with character $+3$ at $-I$ against $\mathbb R^3$'s $-3$. *And isomorphic summands would not force equal scalars in any case.* **The dimension coincidence occurs elsewhere without degeneracy**: $\binom k2\binom l2=kl$ is $(k-1)(l-1)=4$, which holds at $(3,3)$ **and at $(2,5)$**, where $\mu=\tfrac58$ and the point is nondegenerate. *So the coincidence is a fact about dimensions and the exception is not explained by it.*

**Schur is not the mechanism either.** Even under $O(3)\times O(3)$, where the isotypic decomposition *is* multiplicity-free, the kernel is still $18$: multiplicity-freeness forces one scalar per piece and never forces the scalars apart. **So the equivariant decomposition organises the computation and proves nothing**, and what remains is the closed form $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, which vanishes at $(3,3)$ and nowhere else in the range.

**What it does and does not give.** Such an orbit is isolated in the critical set. The use intended for it, that *every* graded critical point is nondegenerate, hence the graded set is a union of connected components, **is false**: the Kähler family $\mathfrak{su}(m)$ and the two-block plateau at the rival maximizer are graded and Morse–Bott degenerate, with kernel excesses of $5$, $9$, $14$, $20$ and $16$ at the dimensions tested, established in **exact arithmetic over $\mathbb Q$**, with the criticality residual literally zero rather than $10^{-16}$. At the plateau the second-order branching obstruction vanishes in all $16$ transverse directions, which is consistent with a genuine critical manifold though it does not establish one, the obstruction proves no branch when it fails, rather than a branch when it vanishes. Every known exception sits at value at most $1.054$, below the rival maximizer's $\sqrt{3/2}$, so a **value-localised** version survives: on $\{\,\theta\ge t\,\}\cap\mathrm{Crit}$, which is compact, the exceptions are excluded by fiat.


#### Lemma L207, the complete $L_e$ spectrum at a two-factor sphere product, and the excess at every split

**The $\tfrac12$-eigenspace is the cross-pair sector, so the excess is zero at every two-factor sphere product except $S^3\times S^3$.** *Derived 2026-09-12 by [r887](../reviews/REVIEW_r887.md) and [r888](../reviews/REVIEW_r888.md), independently, on identical briefs, each computing the whole spectrum in closed form and agreeing on every value. It supersedes the scope of [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof) below, which reached $p,q\ge3$ apart from $(3,3)$.*

**Statement.** Let $n=p+q$ with $p,q\ge2$ and let $e=W/\theta$ for the Weyl tensor of $S^p\times S^q$, so $e=-M/(n-1)$ with $M$ the sectional matrix. Then

$$\dim E_{1/2}(L_e)\;=\;pq\;+\;\binom p2\binom q2\cdot\big[\,\mu=\tfrac12\,\big],\qquad \mu=\frac{n-2}{2(p-1)(q-1)},$$

*and $\mu=\tfrac12$ exactly when $(p-2)(q-2)=1$, which is $p=q=3$ alone.* **Since the orbit dimension is $\binom n2-\binom p2-\binom q2=pq$, the excess is $0$ at every split except $S^3\times S^3$, where it is $\binom32^2=9$.**

**And the mechanism is that the cross-pair $\tfrac12$-eigenvector IS the orbit direction, so nothing is being avoided.** *For a pair with one index in each factor the block has two eigenvalues, $0$ with multiplicity $n-4$ and $\tfrac12$ exactly once. The orbit direction $[e_j\wedge e_k,W]$ has $f_i$-component $M_{ki}-M_{ji}$, which at $p=2$ is the ratio $1:-\tfrac1{n-3}$, and that is the $\tfrac12$-eigenvector* ([r888](../reviews/REVIEW_r888.md)). **So $E_{1/2}$ equals the orbit tangent because the inclusion of [Lemma L120](second-order.md)'s orbit clause is an equality of multiplicity one per cross pair**, not because $\tfrac12$ is hard to reach. *The excess vanishes for a structural reason and the earlier straddling account had the logic inverted: the $\tfrac12$ is present by construction, and the only question is whether any other sector meets it.*

**Why the block list is closed, which is the step the record lacked.** $L_e$ commutes with the diagonal sign group $(\mathbb Z_2)^n$, which fixes every coordinate-diagonal $e$, and the isotypic components are exactly the coordinate-diagonal sector, the $\binom n2$ pair blocks of [Lemma L122](second-order.md) and the $\binom n4$ four-set blocks of [Lemma L121](second-order.md). *The count closes:* $\tfrac{n(n-3)}2+\binom n2(n-3)+2\binom n4=\dim\mathcal W_n$ identically. **The two sectors the record had never named are the cross pairs, which carry the $\tfrac12$, and the coordinate-diagonal sector.**

**At $p=2$, where [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof) does not reach, the spectrum is explicit.** In units of $\tfrac1{2(n-3)}$ it is $\{-(n-2),\,0,\,n-4,\,n-3,\,n-2\}$, with multiplicities $n(n-3)$, $\tfrac{n(n-2)(n^2+2n-27)}{12}$, $\tfrac{n(n-3)}2$, $2n-4$ and $\binom{n-2}2$, summing to $\dim\mathcal W_n-1$. *Screened against an independent Hessian pipeline at $n=8,10,12,14$, all five values and all five multiplicities exact, and the conversion $L_e=\mathrm{Hess}/(6\theta)+\tfrac12$ validated at $S^6\times S^6$ against the record's own Casimir-derived block table.* **The scale-sensitive detector for that conversion is $\mathop{\mathrm{tr}}L_e=0$, which the closed forms satisfy identically in $n$** ([r888](../reviews/REVIEW_r888.md)).

> **THE WITHIN-FACTOR PAIR FORM OF [LEMMA L122](second-order.md) HOLDS ONLY FOR $p\ge3$.** *At $p=2$ the pair block of the two $p$-indices has dimension $n-3$ and is the scalar $-\mu\,\mathrm{Id}$, so its top is $-\tfrac{n-2}{2(n-3)}$ rather than the $\tfrac{p-2}{2(p-1)}=0$ the general form predicts* ([r887](../reviews/REVIEW_r887.md), [r888](../reviews/REVIEW_r888.md), independently). **The conclusion is unaffected, since $-\mu<\tfrac12$.**

> **AND $S^2\times S^{n-2}$ IS A SADDLE, NOT A MAXIMISER**, carrying $\binom{n-2}2$ strictly positive Hessian directions at every $n\ge4$: $\mu>\tfrac12>\theta/2$ there, against [Lemma L24](second-order.md)'s cap at a maximiser. *That is what qualifies it as [post F65](fence-posts.md)'s witness and disqualifies it as a competitor.*

**Gate 2 PASSED**, both reviewers confirming the conclusion and each refuting the parent's stated route to it: the straddling interlacing first recorded is a corollary of this spectrum rather than a reason for it, since the cross-pair family sits exactly at $\tfrac12$. *The $(3,3)$ value $9$ is reproduced by the formula without being fitted to it, which is the check that distinguishes this from a pattern.*


**Corollary, the Fox algebra is not isospectral (R23's root).** *An algebra is isospectral in the sense of [krasnov-tkachev-2022](../references/krasnov-tkachev-2022-medial-isospectral/notes.md) when all its idempotents share one spectrum, and the idempotents here are the critical points $e=W/\theta$.* **They do not**: $\dim E_{1/2}(L_e)=pq$ at $S^p\times S^q$ away from the $(3,3)$ split, so $S^2\times S^{n-2}$ has $2(n-2)$ and, for $n\ge7$, $S^3\times S^{n-3}$ has $3(n-3)$, unequal since equality forces $n=5$. At $n=6$ the split $S^3\times S^{n-3}$ IS $S^3\times S^3$, where $\mu=\tfrac12$ adds the four-set blocks, so its multiplicity is $9+\binom32^2=18$ against $S^2\times S^4$'s $8$, and the algebra is not isospectral at every $n\ge6$. *These are two idempotents of the one algebra $\mathcal W_n$ with different spectra.* *Typed as `foxAlgebra_not_isospectral` ($n\ge7$) and `foxAlgebra_not_isospectral_six` (the $n=6$ witness carrying the excess) in [L207SphereExcess.lean](../lean/HamiltonsCubic/Results/L207SphereExcess.lean).* **So the $L_e$ spectrum IS a separating invariant among critical points, which is what R23 needs and what an isospectral algebra would have denied.** **And the Fox algebra is NOT medial (I88), so Krasnov--Tkachev's classification does not apply off the shelf.** *A medial algebra makes $L_e$ an algebra endomorphism ([krasnov-tkachev-2022](../references/krasnov-tkachev-2022-medial-isospectral/notes.md) Prop 3.6a), so for a $\tfrac12$-eigenvector $u$ the product $u\circ u=Q(u)$ would lie in $E_{1/4}$. But $\mathop{\mathrm{spec}}L_e=\{1,\tfrac12,-1\}$ at $S^2\times S^2$ has no $\tfrac14$ and $u\circ u\ne0$ there (norm $0.866$, screened at $n=4$ on the record's `Q_full`), so the medial identity fails. The classification that would have pinned the maximiser assumes mediality, so [I89](../plan.md) loses its off-the-shelf method; the route is not dead, the spectrum does separate, but its engine is gone.* *What is NOT yet shown, and is [I89](../plan.md): that the spectrum separates the balanced MAXIMISER from a low-moment rival such as padded $W_{\mathbb{CP}^2}$, and that the separation is analytical rather than a finer numerical check past [F65](fence-posts.md)'s two-moment bar.* **Gate 2 PASSED** ([r910](../reviews/REVIEW_r910.md), [r911](../reviews/REVIEW_r911.md)), both confirming I87 and I88 on identical cold briefs. Each verified at $n=4$ that $u\circ u\ne0$ for every $\tfrac12$-eigenvector (norm $\sqrt3/2$, the vacuity crux) and that $\tfrac14\notin\mathop{\mathrm{spec}}L_e=\{1,\tfrac12,-1\}$, and [r911](../reviews/REVIEW_r911.md) caught that the $S^3\times S^3$ multiplicity is $18$ not $3(n-3)$, folded into the $n=6$ clause above.
#### Lemma L27, sphere products are Morse–Bott nondegenerate, canonical statement and proof

*The spectral bound is proved on the operators by the sign group, with no $O(p)\times O(q)$ representation theory: `L27_half` in [L27Main.lean](../lean/HamiltonsCubic/Results/L27Main.lean), every $L_e$-eigenvalue on a nonzero Weyl $H\perp e$ is at most $\tfrac12$ at $p,q\ge3$, $(p,q)\ne(3,3)$, and at $\tfrac12$ every isotypic component sits on a cross pair, through `comp_eigen`, `dn_sphere`, `pair_sphere` and `four_sphere_lt` ([L27Sector.lean](../lean/HamiltonsCubic/Results/L27Sector.lean), [L27Dn.lean](../lean/HamiltonsCubic/Results/L27Dn.lean), [L27Pair.lean](../lean/HamiltonsCubic/Results/L27Pair.lean), [L27Four.lean](../lean/HamiltonsCubic/Results/L27Four.lean)), Gate 2 [r1844](../reviews/REVIEW_r1844.md) and [r1845](../reviews/REVIEW_r1845.md), both CONFIRMED WITH OBSERVATIONS. $E(\tfrac12)\cap W^\perp$ is exactly the span of the cross orbit tangents (`L27_half_span` in [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean)), with $\tfrac12$ attained (`orbitOp_props`), $\dim E(\tfrac12)=pq$ through the independence of the cross tangents (`finrank_half`, `crossOrbit_indep`), and the Morse–Bott link as `L27_kernel` in [L27Close.lean](../lean/HamiltonsCubic/Results/L27Close.lean), so **every clause is proved on the operators**, with no appeal to Nienhaus 4.6 (Gate 2 [r1854](../reviews/REVIEW_r1854.md), CONFIRMED WITH OBSERVATIONS).*

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

Needed because Lemma L26 closes only the half that runs the wrong way. An exhibited eigenvector bounds
$\lambda_{\max}$ from below; nondegeneracy needs an upper bound on the whole spectrum, and nothing in this
programme supplied one until the representation theory was brought in.

**Statement.** Let $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$. **The two exclusions fail differently**: at $(3,3)$ the decomposition holds and two scalars collide, $\mu=\tfrac12$ giving $\dim E(\tfrac12)=18$ against an orbit of $9$, forced by the object; at $q\le2$ **the decomposition itself is false**, the ten dimensions over-counting by $2$ at $q=2$ and by $1+p$ at $q=1$, at every $n$. *So the bottom-end criterion is $p,q\ge3$, not a bound on $n$.* Then $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at
$W_{p,q}$, attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$
is Morse–Bott nondegenerate.

**Argument.** Nienhaus Proposition 4.6 and the summary display following it give
**The maximum is over $W^\perp$ and the restriction is load-bearing**: $L_e$ carries $1$ on $\langle W\rangle$ itself. Off that line, $\tfrac12-\lambda_m=\tfrac1{2(m-1)}>0$ always and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, zero over integers $\ge3$ only at $(3,3)$, which is the exclusion, in one inequality.

$$\mathrm{Weyl}_n=\langle W\rangle\oplus\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus(\mathbb R^p\!\otimes\!\mathbb R^q)
\oplus S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)\oplus(S^2_0\!\otimes\!S^2_0)\oplus(\Lambda^2\!\otimes\!\Lambda^2)
\oplus(X_p\!\otimes\!\mathbb R^q)\oplus(X_q\!\otimes\!\mathbb R^p),$$
with $X_m$ the $O(m)$-irreducible of Young label $[2,1]$ and $\dim X_m=m(m^2-4)/3$; the ten dimensions sum to
$\dim\mathrm{Weyl}_n$ identically in $p,q$. **Each summand is irreducible under $O(p)\times O(q)$ for every $p,q\ge3$**, [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md)'s, and the input the next step needs, and the Young labels are pairwise distinct, so the summands are pairwise non-isomorphic and the decomposition is multiplicity-free. *Distinctness alone would give only non-isomorphism; irreducibility is what the source supplies and what this sentence must name.* Since $e$ is $O(p)\times O(q)$-invariant, $L_e$ is equivariant, and **a symmetric
element of a real division algebra of operators has a real eigenvalue and is therefore a real scalar**, which
covers $\mathbb R$, $\mathbb C$ and $\mathbb H$ alike, *though the generality is not needed here: every $O(m)$-irreducible is of real type, so the commutant is $\mathbb R$ throughout and only "has a real eigenvalue" is used*, so $L_e$ acts as a **scalar** on each summand and each
summand's value is its eigenvalue. *Symmetry is what does this work, and it cannot
change a representation's type.* The ten values: $1$ on $\langle W\rangle$; $\tfrac12$ on
$\mathbb R^p\otimes\mathbb R^q$, since differentiating $Q(W_t)=\theta W_t$ along the orbit gives
$e\circ\dot W=\tfrac12\dot W$; $\lambda_m=(m-2)/(2(m-1))<\tfrac12$ on $S^2_0(\mathbb R^m)$, derived at [second-order.md](second-order.md);
$+\mu$ on $\Lambda^2\otimes\Lambda^2$ by [Lemma L26](#lemma-l26-the-dangerous-eigenvalue-of-the-two-block-spectrum-in-closed-form-canonical-statement-and-proof),
**and $-\mu$ on $S^2_0\otimes S^2_0$ by the trace identity below**, L26 supplying only the first of the two;
and $0$ on the remaining four. Then
$$\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0\quad\text{for }p,q\ge3,\ (p,q)\ne(3,3),$$
so $\tfrac12$ is attained on the orbit summand alone. $\square$

**The list checks itself, and the check is not in the argument that produced it.** $\mathcal W_n$ is $O(n)$-irreducible and non-trivial, so $\sum_iQ(V_i)$ is an invariant vector in it and vanishes; hence $\mathop{\mathrm{tr}}_{\mathcal W_n}L_e=0$ unconditionally. **The ten values satisfy that identically in $p,q$**, and given the other nine it **forces $-\mu$ on $S^2_0\otimes S^2_0$ uniquely.** It also discriminates the assignment: reversing the two tensor summands leaves a trace of $30$ at $(3,5)$ and $(4,4)$, $48$ at $(5,5)$, $70$ at $(5,7)$, never zero. *Derived independently and concurrently by [r529](../reviews/REVIEW_r529.md) and [r530](../reviews/REVIEW_r530.md), whose briefs were identical and neither of which read the other.*

**Both former grants are now discharged.** $L_e$ vanishes on $\mathrm{Weyl}_p$ and $\mathrm{Weyl}_q$ by two independent proofs. On $X_p\otimes\mathbb R^q$ it vanishes by an index computation uniform in $p,q,n$: writing $\mathrm{sharp\_bilin}(X,Y)=\mathrm{Sym}_{\text{pair}}\mathrm{Alt}_{ij}H$ and specialising $X=I_p$, Ricci-flatness enters exactly once to force the partial trace $\rho$ to vanish, and a six-case exhaustion leaves one live case in which Bianchi is used twice to give $-V/2$; the companion $X_q\otimes\mathbb R^p$ follows. The multiplicity-freeness at $p,q\le4$, asserted rather than proved in the source, is supplied by exact $O(m)$-commutant computation at $m=3,4$: every $\mathrm{End}=1$ and every cross-$\mathrm{Hom}=0$, including $\mathbb R^3$ against $\Lambda^2(\mathbb R^3)$ and $S^2_0$ against $X_3$, which share dimensions; $\mathrm{Weyl}_4$ is $O(4)$-irreducible although it splits under $SO(4)$. The $p,q\ge5$ case is proved in the source.

**The excluded case is a theorem, not an observation.** At $(3,3)$, $\mu=\tfrac12$ exactly and
$\dim E(\tfrac12)=18$ against orbit dimension $9$. This is an **eigenvalue coincidence, not representation
mixing**: under $O(3)$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$, measured as
$\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$, so Schur permits no mixing and the two
summands carry $\tfrac12$ separately. A symbolic solve over all $45$ summand pairs finds it the only such
coincidence with $p,q\ge3$, over all $p,q$ rather than a tested range.

**Sources.** [Nienhaus, arXiv:2311.02404](https://arxiv.org/abs/2311.02404), Proposition 4.6 and Remark 4.7(ii).
Audited by Reviewers 34 and 35 on identical briefs, agreeing on every verdict; both proved the $\mathrm{Weyl}_p$
vanishing independently, and both refuted the mechanism first proposed for the $(3,3)$ exception.


#### Lemma L28, the $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

Needed because route R2 closes only if **every** graded critical point is nondegenerate: a nondegenerate orbit is
open in $\mathrm{Crit}(P)$ and $S=0$ is closed, so the graded set would then be a union of connected components
and $S\ge c>0$ on the rest by compactness. Lemma L27 settles the two-block sphere products; the graded
classification leaves the $\mathbb{CP}^m$ family, which is this entry.

**Statement.** For every $m\ge3$, the $\mathfrak u(m)$-invariant line in $\mathrm{Weyl}_{2m}$ is spanned by a critical
$W_{\mathbb{CP}^m}$ with $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, and
$$\dim E(\tfrac12)=\dim(\text{orbit})=m(m-1),\qquad \lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)}=\tfrac12+\frac1{2(m+1)} .$$
So $\mathbb{CP}^m$ is Morse–Bott nondegenerate and, since $\lambda_{\max}>\tfrac12$, is not a maximiser.

**Argument.** $\mathrm{Weyl}_{2m}\otimes\mathbb C$ is $U(m)$-multiplicity-free with **ten** summands (the $GL_m\subset O_{2m}$ branching rule at $\lambda=(2,2)$), falling into **seven** classes over $\mathbb R$, three of them conjugate pairs. Since $e$ is $U(m)$-invariant, $L_e$ is equivariant and Schur makes it a **scalar** on each summand, so each value is an eigenvalue and not merely a Rayleigh lower bound.

**Multiplicity-freeness is load-bearing twice (for that scalar step and for identifying the orbit) and the stable rule does not supply it at $m=3$.** [Howe–Tan–Willenbring](../references/howe-tan-willenbring-2005-stable-branching/notes.md)'s rule applies once $\lfloor m/2\rfloor\ge2$, that is **$m\ge4$**, *and $m=3$ is exactly where this lemma's "with no exception" is decided.* **The case closes by hand and the proof is [LEDGER.md](LEDGER.md)'s**: at $m=3$ every mixed piece is a standard $\mathfrak{su}(3)$ tensor product, and $\bar{\mathbf3}\otimes\mathbf3=\mathbf1\oplus\mathbf8$ produces **no** $V_{(1,1);(1,1)}$, which is why the coincidence at $\tfrac2{m+1}=\tfrac12$ is vacuous there. *The summand is **absent**, not zero-dimensional.*

| $GL(m)$ highest weight | real dimension | $L_e$ | $c_S+q_S^2$ |
|---|---|---|---|
| $(0^m)$, the line $\langle W\rangle$ | $1$ | $1$ | $0$ |
| $(1,0^{m-2},-1)$, the $\mathfrak{su}(m)$ adjoint | $m^2-1$ | $\frac{m+2}{2(m+1)}$ | $2m$ |
| $(1,1,0^{m-2})\oplus$ dual, $\Lambda^2E\oplus\Lambda^2\bar E$, the orbit tangent | $m(m-1)$ | $\tfrac12$ | $2(m+1)$ |
| $(1,1,0^{m-4},-1,-1)$, $V_{(1,1);(1,1)}$, **absent at $m=3$** | $\frac{m^2(m+1)(m-3)}4$ | $\frac2{m+1}$ | $4(m-1)$ |
| $(2,1,0^{m-3},-1)\oplus$ dual | $\frac{2m^2(m^2-4)}3$ | $0$ | $4(m+1)$ |
| $(2,0^{m-2},-2)$, $V_{(2);(2)}$, Bochner | $\frac{m^2(m-1)(m+3)}4$ | $0$ | $4(m+1)$ |
| $(2,2,0^{m-2})\oplus$ dual | $\frac{m^2(m^2-1)}6$ | $-\frac3{m+1}$ | $4(m+4)$ |

The seven real dimensions sum to $\dim\mathcal W_{2m}=\frac{m(m+1)(2m+1)(2m-3)}3$ identically in $m$. **The same table stands at [second-order.md](second-order.md), with the explicit $c_S=\sum_i\nu_i(\nu_i+m+1-2i)$ and $q_S=\sum_i\nu_i$ and the $\sharp$ closed forms behind it.**

**Nondegeneracy is arithmetic**: $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ equals $\tfrac12$ exactly when $c_S+q_S^2=2(m+1)$. That holds identically on the orbit, and among the rest only $4(m-1)$ can meet it, at $m=3$ alone, **where that summand is absent.** It needs four rows of a Young diagram against the $m=3$ available, so the branching rule does not produce it, and $\frac{m^2(m+1)(m-3)}4$ vanishing there is the analytic continuation agreeing with the absence rather than the reason for it. **Hence $E(\tfrac12)$ is the orbit tangent at every $m\ge3$**, and *equals* it rather than merely containing it, since multiplicity-freeness makes $E(\tfrac12)$ a sum of whole summands. With **no exception**, unlike the sphere products. $\square$

**Two identities check the list's arithmetic, and neither checks the decomposition.** Fox's Theorem 1.3, at [algebra.md](algebra.md), gives $\mathop{\mathrm{tr}}L(x)=0$ and $\mathop{\mathrm{tr}}(L(x)L(y))=\kappa_F\langle x,y\rangle$. The seven rows satisfy both identically in $m$: $\mathop{\mathrm{tr}}L_e=0$, and $\mathop{\mathrm{tr}}(L_e^2)=\frac{3m(m-1)(4m-1)}{4(m+1)}=\kappa_F(2m)\lVert e\rVert^2$, **all four quantities re-derived independently by three verifiers.**

> **WHAT THE TWO IDENTITIES ARE WORTH, WHICH IS LESS THAN THE BLOCK CLAIMED.** *They are polynomial identities in $m$ and **both pass at $m=2$, where the row list carries a negative dimension of $-3$ and is known refuted.*** So they certify the list's internal arithmetic and **say nothing about whether it is the right decomposition**. **And $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ is not Fox's**: his Remark 1.4 leaves $\kappa$ uncomputed above $\dim V=4$, and the closed form is a fit, *so the second identity **derives** $\kappa_F$ at even $n$ rather than testing the table against it.* **The block presented these as two independent confirmations of the eigenvalue list and they are neither independent of it nor confirmations of the decomposition.**

**And the trace identity derives the row the conclusion rests on.** Only $\lambda=1$ on $\langle W\rangle$ and $\lambda=\tfrac12$ on the orbit are structural, $Q(e)=e$ gives the first, and $O(n)$-equivariance of $Q$ differentiated along the orbit gives the second. The other five are computed, and the one carrying "not a maximiser" is $\lambda_{\max}$ on the $\mathfrak{su}(m)$ adjoint. Holding the rest fixed and solving $\mathop{\mathrm{tr}}L_e=0$ for the unknown $y$ there,
$$1+(m^2-1)y+\frac{m(m-1)}2+\frac{m^2(m-3)}2-\frac{m^2(m-1)}2=0,\qquad (m^2-1)y=\frac{(m+2)(m-1)}2,\qquad y=\frac{m+2}{2(m+1)} .$$
The same solve returns $\frac2{m+1}$, $-\frac3{m+1}$ and $0$ on each remaining class, **each uniquely from the other four**. **That solve is not independent of the charge formula**: five of its six inputs are charge-formula outputs, so perturbing one row moves $\lambda_{\max}$, *by $-\tfrac{m^2}6\epsilon(m)$ at row $7$.* **What it does give is a second route to the value from the other rows**, which is worth stating and is not the independence the block claimed. *And "each uniquely from the other four" fails vacuously at $m=3$ for $V_{(1,1);(1,1)}$, where the coefficient degenerates to $0\cdot z=0$ and the summand is absent anyway.*

**Three hypotheses the argument uses and does not state**: the **native** dimension, so no padded $\mathbb{CP}^m$ is in scope; $\lVert W\rVert=1$; and [Lemma L24](second-order.md) behind the closing *"not a maximiser"*. **And the norm is the unhalved $\mathop{\mathrm{tr}}(X^2)$** where [conventions.md](conventions.md) tables the halved $\mathfrak{so}(n)$ norm, *the halved reading breaks the Fox check by a factor $2$.*

**The eigenvalues come from a closed form for $e$.** $W_{\mathbb{CP}^m}$ is rational in the three $U(m)$-isotypic projectors of $\Lambda^2\mathbb R^{2m}$, the surd in $\theta$ cancelling: $e=-\frac{1}{2m-1}P_{\mathfrak m}+\frac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\frac{2(m-1)}{2m-1}P_\omega$. It is traceless exactly, satisfies $\lVert e\rVert^2=1/\theta^2$ exactly, which checks the projector coefficients and the closed form for $\theta$ at once. **It does NOT saturate [Lemma L70](bounds.md)**, and the claim that it did stood here for one revision. **The closed form above is for $e=W/\theta$**, so $W$ has $\lambda_{\max}=\theta\frac{2(m-1)}{2m-1}$ and $\lambda_{\min}=-\frac\theta{2m-1}$, and L70's saturation value at $n=2m$ is $$\lambda_{\min}+(n-2)\lambda_{\max}=\theta\,\frac{4(m-1)^2-1}{2m-1}=\theta\big(1+2(m-2)\big).$$ **So the slack is exactly $2(m-2)\theta$**, since $\frac{4(m-1)^2-1}{2m-1}-1=\frac{2(2m-1)(m-2)}{2m-1}=2(m-2)$, vanishing only at $m=2$, outside this lemma's range, and growing linearly in $m$. *Equivalently the ratio $\lambda_{\max}/\lvert\lambda_{\min}\rvert=2(m-1)$ meets saturation's requirement only there.* Closed forms for $\sharp(P_\omega,\cdot)$ and $\sharp(P_{\mathfrak u},\cdot)$ then make every block value depend only on the $U(1)$ charge, so no mixing angle enters.

**At $m=3$ the branching rule is out of range, and the decomposition is filled by hand.** [Howe–Tan–Willenbring](https://arxiv.org/abs/math/0311159) admits partitions with at most $\lfloor m/2\rfloor$ parts, so at $\lambda=(2,2)$ it applies from $m\ge4$, and $m=3$ is the case the whole argument turns on. Every mixed piece there is a standard $\mathfrak{su}(3)$ tensor product: $\mathbf8\otimes\bar{\mathbf3}=\bar{\mathbf3}\oplus\mathbf6\oplus\mathbf{15}$, $\mathbf6\otimes\bar{\mathbf6}=\mathbf1\oplus\mathbf8\oplus\mathbf{27}$, and $\bar{\mathbf3}\otimes\mathbf3=\mathbf1\oplus\mathbf8$, the last producing **no** $V_{(1,1);(1,1)}$. Removing $S^2_0$ and one trivial from $\dim\mathbb S_{(2,2)}(\mathbb C^6)=105$ leaves nine complex summands of dimensions $6,6,15,15,3,3,27,8,1$, summing to $84=\dim\mathcal W_6$. **So multiplicity-freeness is a theorem at every $m\ge3$**, rather than a citation valid from $m\ge4$.

**Criticality and $\theta^2$ come from elsewhere on the record.** $\dim\mathrm{Weyl}_{2m}^{U(m)}=1$ ([target.md](target.md)), so $Q(W)$ is again $U(m)$-invariant and hence a multiple of $W$, which is criticality, and is independently the confirmation that the trivial summand occurs exactly once. The closed form $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ is derived at [algebra.md](algebra.md) from Fox's Lemma 10.1 and (10.4), holding for every even $r=2m$ with $2\le r\le n$.

**$\mathbb{CP}^3$ sits exactly at $\Theta_6$, and that costs nothing.** $\theta^2=\frac{10}9=\theta_0(6)^2$ at $m=3$, while $\lambda_{\max}=\tfrac58>\tfrac12$ says it is no local maximiser. $\Theta_n$ is the **diagonal** maximum: padded $W_{\mathbb{CP}^2}$ puts $\sqrt{3/2}=1.2247$ into $\mathcal W_6$ by [Lemma L29](stratum-two-negative.md), and $(\mathfrak{su}(3),\mathfrak{so}(3))$ reaches $1.0954$ there, so the maximum at $n=6$ strictly exceeds $\Theta_6$ and [Lemma L24](../results.md) is untouched. **The other point at that value is $S^3\times S^3$**, which is [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof)'s excluded $(3,3)$: degenerate, with nine Hessian null directions transverse to its orbit, so the second-order test decides nothing there ([Lemma L3](../results.md)) and whether it is a local maximum is a third-order question. $\mathbb{CP}^3$ fails to be a maximiser through a Hessian direction above $\tfrac12$, and $S^3\times S^3$ is undecided at second order.

**What is not proved.** The affine dependence of $\lambda_S$ on $c_S+q_S^2$ is asserted rather than derived; **given** it, the two constants are forced by $L_ee=e$ and by the orbit's $\tfrac12$. The $\sharp$ closed forms behind it are exact in $\mathrm{GF}(p)$ at $m=3\ldots20$ rather than proved symbolically, and $\sharp(P_{\mathfrak u},\cdot)$ is a compression rather than an identity, $28$–$46\%$ of its image leaves $\mathrm{Weyl}_n$, so per-summand values of the individual pieces are exact only where the caveat at [second-order.md](second-order.md) allows.

**Sources.** The decomposition is [Howe–Tan–Willenbring §2.3.1](https://arxiv.org/abs/math/0311159); the count
agrees with [Tricerri–Vanhecke, Trans. AMS 267 (1981)](https://www.ams.org/journals/tran/1981-267-02/S0002-9947-1981-0626479-0/)
after removing the three Ricci-and-scalar modules. The $L_e$ eigenvalues and the identification of the orbit
summand are new here. Audited by Reviewers 40 and 41 on identical briefs, agreeing on every verdict, each
locating one of the two sources independently.

### What survives, and what to do

A **value-localised** hypothesis is still viable: every known degenerate graded point sits at $\theta\le1.054<\sqrt{3/2}$, and $\{\theta\ge t\}\cap\mathrm{Crit}$ is compact, so restricting attention to high-value critical points excludes all present counterexamples. That is the form the route must take, and it is weaker than what was claimed.

Two concrete fixes to [p3b_morse_bott_spheres.py](../scripts/lib/p3b_morse_bott_spheres.py): the equivariance check tests only 5 of the group's $12$–$20$ generators (the claim is right, the evidence covers a third), and its docstring misquotes Nienhaus, $\Lambda^2_\pm(\mathbb R^k)$ should be $\Lambda^2(\mathbb R^k)\otimes\Lambda^2(\mathbb R^l)$, since the $\pm$ split exists only at $k=4$, and "for any $k+l=n$" needs his $k,l\ge5$ / $k,l\ge3$ qualifiers.

**A second tool worth adopting: a degeneracy-side exact certifier.** The existing mod-$p$ machinery can only ever mark a degenerate point "inconclusive", for the reason above. Integer-preserving elimination over $\mathbb Q$ settles all eight points here in under a second each, so the catalogue's degenerate half need not stay numerical.

**A new tool worth adopting.** The exact second-order obstruction $\Pi_{\ker}Q(v)=0$ (one symmetric cubic tensor), *proves* that no branch of critical points leaves a given point when it fails, and it settles $\mathfrak{su}(3)$ outright. Also flagged: at $n=6$, $S^3\times S^3$ and $\mathbb{CP}^3$ share $\theta=\sqrt{10/9}$ and are both graded, and a slice corrector was recorded as driving the criticality residual to $1.9\times10^{-13}$ at transverse distance $0.2$ with $\theta$ unchanged to nine digits. **That citation is retracted below in this same file**: it has no script in the tree, and every corrector flagged as moving off the orbit was within $3.8\times10^{-3}$ of it once the distance was gauge-fixed as $\min_g\lVert gW'g^{\mathsf T}-W_0\rVert$. **So it carries no evidence against an isolated orbit**, and it never says which orbit it started from, from $S^3\times S^3$ there was no tension to begin with, that orbit being degenerate.

#### The second-order obstruction, corrected by Gate 2

Two tests the plan called for, at $n=6$ ([p3b_obstruction_and_path.py](../scripts/lib/p3b_obstruction_and_path.py)), both substantially corrected by Reviewer 17 ([review_r17_report.md](../agent_logs/review_r17_report.md)).

### The formula is right; the certificate built from it was not

A branch of critical points leaving $W_0$ in a kernel direction $v$ must satisfy $\Phi(v):=\Pi_K\pi Q(v)=0$ to second order. **Reviewer 17 rederived this from scratch and confirmed it**, and validated it against a positive control that the original script never ran.

The certificate drawn from it was nonetheless worthless. **$\Phi$ is quadratic in $v$**, so evaluating it on nine SVD basis vectors of a nine-dimensional space proves nothing about the other directions. At $S^3\times S^3$ a global minimisation finds zeros from **400 of 400 random starts** (best $9.4\times10^{-16}$ against a typical basis value of $0.32$), and $\mathop{\mathrm{rank}}\mathrm d\Phi=4$ at every zero, so the zero set is a **five-dimensional cone** inside the nine-dimensional transverse kernel. The 18 components of $\Phi$ span exactly nine quadrics valued in the transverse part, the Segre rank-one cone of $T\cong\mathbb R^3\otimes\mathbb R^3$, the same isomorphism responsible for the excess kernel in the first place. An explicit counterexample lies inside the original script's own code path: the unit combination $(-0.298272,-0.173431,-0.731874,-0.330905,0.064618,0.266950,-0.041017,-0.167083,0.361635)$ of its basis vectors returns $1.4\times10^{-15}$.

**So the claim "the obstruction is nonzero in every transverse direction, hence no branch" is withdrawn.** Testing a quadratic form on a basis is not a proof; it needs a global argument on $\mathbb P(T)$.

### The conclusion survives, by a third-order argument the script never computed

At $S^3\times S^3$, since $A_vv=\Phi(v)=0$ on the cone, one scalar component of the third-order condition is free of the undetermined second-order constant: $\Psi_1(v)=\langle\pi Q(v),L^{+}\pi Q(v)\rangle$. On the zero cone $\Psi_1=-0.5929271$, **constant** across 300 samples and 120 constrained restarts, while on orbit directions it is $10^{-16}$, as a genuine branch requires. So no branch emanates, but for a third-order reason.

At $\mathfrak{su}(3)$ Kähler the situation is cleaner and different from the one claimed: $|\Phi(v)|^2=c\,|v|^4$ **exactly**, with $c=0.447813411$ and tensor residual $2.8\times10^{-15}$, so the obstruction really is nonzero on all of $T$.

Remaining gap: Puiseux arcs with leading exponent $\ge2$ contribute order-three cross terms that were not excluded.

### The predictor–corrector, and what the distance measure has to be

**Every corrected point lies on the orbit.** Measuring $\|W'-W_0\|$ is meaningless here, the orbit is $9$- ($11$-) dimensional and an ungauged corrector simply slides along it. Re-measured properly as $\min_g\|gW'g^{\mathsf T}-W_0\|$, every point flagged "moved off" is within $3.8\times10^{-3}$ of the orbit, and the one flagged as a genuine branch is $1.1\times10^{-6}$ from it.

The spectrum comparison used to repair the first error was **also wrong**: spectral differences track orbit distance at a ratio of $\approx0.58$ (Weyl's inequality, saturated), so they measured the same artefact. A damped Gauss–Newton with an analytic Jacobian reaches residual $3$–$7\times10^{-16}$ while the orbit distance falls to $10^{-6}$ and $10^{-8}$; the earlier points were a **stalled solver**, not a solution.

**A cross-validation worth keeping.** The residual obeys $\|F\|\approx d^3$ at $S^3\times S^3$ and $d^2$ at $\mathfrak{su}(3)$, exactly the cubic and quadratic valleys the third- and second-order obstructions predict. The two halves of the audit independently confirm each other.

### Lessons recorded

**Testing a quadratic form on a basis proves nothing about the form.** This is the second time a certificate here has failed by sampling where a global statement was needed.

**Distance to a critical point is not distance to its orbit.** Any continuation test in this problem must gauge-fix, $\min_g\|gW'g^{\mathsf T}-W_0\|$; both $\|W'-W_0\|$ and the spectrum are contaminated by orbit motion. Recorded as a standing rule.

**One citation is unverifiable.** Reviewer 16's "slice corrector reached residual $1.9\times10^{-13}$ at transverse distance $0.2$ with $\theta$ unchanged" has no script in the tree; given the above it was almost certainly measuring orbit motion, and it must be re-measured against the orbit before being reused.

## The graded classification, checked at once, moved here 2026-09-02

*Moved from [fence-posts.md](fence-posts.md), which is the register of proven negatives and was carrying 29 KB of this file's subject. Conventions: [conventions.md](conventions.md).*

#### Every graded critical point tested is nondegenerate, which is the component route's mechanism

#### The whole graded classification, checked at once

Since gradedness forces $\mathfrak h$ symmetric and Cartan leaves only $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$, the graded set at each $n$ is the two-block sphere products together with $\mathbb{CP}^{n/2}$, a finite list. Reading nondegeneracy off the $L_e$ spectrum as $\dim E(\tfrac12)=\dim(\text{orbit})$:

| $n$ | points | result |
| --- | --- | --- |
| 8 | $S^2\times S^6$, $S^3\times S^5$, $S^4\times S^4$, $\mathbb{CP}^4$ | all nondegenerate, $12,15,16,12$ matching exactly |
| 10 | $S^2\times S^8$, $S^3\times S^7$, $S^4\times S^6$, $S^5\times S^5$, $\mathbb{CP}^5$ | all nondegenerate, $16,21,24,25,20$ matching exactly |
| 12 | all five two-block splits | all nondegenerate, $20,27,32,35,36$ matching $pq$ exactly |

$\mathbb{CP}^m$ had not been checked before; it is nondegenerate too. The $n=6$ exception ($S^3\times S^3$, kernel $18$ against orbit $9$) remains the only failure on record, and it sits below the crossover.

#### Why this is the mechanism, not another measurement

If every graded critical point with $\theta\ge t$ is Morse–Bott nondegenerate, each graded orbit is isolated (open and closed in $\mathrm{Crit}(P)$) so the ungraded part of the compact set $\{\theta\ge t\}\cap\mathrm{Crit}$ is itself compact, and the continuous $S>0$ attains a minimum $c>0$ there.

**THE POSITIVITY STEP IS BROKEN, AND THE ONLY QUESTION LEFT IS HOW BADLY.** The chain needs $S>0$ at every *ungraded* critical point of the compact set. Three things are settled and one is not.

*Settled.* $S_{\mathfrak{mmm}}$ is an $O(n)$-invariant, so the $SO(10)$-conjugate of the $C_5$ blow-up once offered here as the counterexample was **decorative**: the bare diagonal blow-up already carries $S_{\mathfrak{mmm}}=0$ with $S_{\mathfrak{mpp}}=80$, and conjugating changes neither ([Reviewer 313](../reviews/REVIEW_r313.md), confirmed against the measurement that produced it, three conjugating elements gave three identical triples, which is what invariance predicts and what should have been read from them at the time). *Settled.* $S_{\mathfrak{mmm}}$ is **not continuous** across an eigenvalue zero-crossing, and the step also needs continuity to extract a minimum. *Settled.* **Padded $W_{\mathbb{CP}^2}$ is critical at $\theta=\sqrt{3/2}$ exactly** (twelve digits, residual $3\times10^{-16}$, at every $n=4,8,10,12,14$), **with $S_{\mathfrak{mmm}}=0$.** It sits precisely at the threshold the restricted premise quantifies over.

**RESOLVED, and the resolution is the kernel.** [Reviewer 313](../reviews/REVIEW_r313.md) called padded $W_{\mathbb{CP}^2}$ ungraded via $S_{\mathfrak{hhm}}=4(n-4)\ne0$ on the isotropy splitting; [Reviewer 314](../reviews/REVIEW_r314.md) left the restricted statement open; this record's own screen returned $S_{\mathfrak{mpp}}=0$ and called it graded. **All three are reading the same object through different splittings, and only one of them is a grading.** A $\mathbb Z_2$-grading requires $\mathfrak p\oplus\mathfrak m=\mathfrak{so}(n)$, and at padded $W_{\mathbb{CP}^2}$ the sign splitting does not span: $\dim E_+=1$, $\dim E_-=2$, **kernel $63$** of $\dim\mathfrak{so}(12)=66$, and $25$ of $28$ at $n=8$. So the screen's zeros there are **vacuous**, and the point is not graded by the sign splitting at all.

> **The record's gradedness screen is unreliable wherever $\ker W\neq0$**, because it traces only over $E_\pm$ and reports $0$ when the kernel carries almost everything. It is trustworthy exactly where $\ker W=0$, at the $n=8$ witness and at $S^3\times S^5$, both with kernel $0$ out of $28$, where the sign splitting genuinely is a grading.

**So padded $W_{\mathbb{CP}^2}$ is a counterexample only in the SIGN sense of graded, and it is not one in the SLICE sense.** *[Reviewer 316](../reviews/REVIEW_r316.md), which finds it fully graded in the slice sense (it commutes with a coordinate grading involution) while this record calls it ungraded in the sign sense, its kernel carrying $63$ of $66$ dimensions.* **The two senses diverge exactly at this point, which is where the whole dispute has been living.** So the positivity premise is refuted if the chain means the sign sense and survives this point if it means the slice sense, and **the chain has never said which**, which is the defect to fix before the premise can be called true or false. *r316 adds that padded $W_{\mathbb{CP}^2}$ is a Morse–Bott nondegenerate **local maximum** at $\theta=\sqrt{3/2}$ exactly, at $n=8,10,12$, with $\mathrm{mult}(\tfrac12)=\dim(\text{orbit})$ and no increase over $1600$ probes, so $\{\theta\ge\sqrt{3/2}\}\cap\mathrm{Crit}$ carries a non-sphere-product member at its boundary.*

**AND ON THE SUBALGEBRA FAMILY THE CLASS $\{S=0\}$ COLLAPSES TO THE CAP.** *Derived from [Lemma L23](../results.md), whose equality case the record already carries.* There $\theta=\frac2n\sqrt{rN/(N-r)}$ with $r=\dim\mathfrak h$ and $N=\binom n2$, the cap is $r\le n(n-2)/4$, and **equality in either place holds exactly when $S_{\mathfrak{mmm}}=0$**. So on that family

$$S_{\mathfrak{mmm}}=0\iff r=\frac{n(n-2)}4\iff\theta=\theta_0(n),$$

and $\{S=0\}$ is *not* a broad class at all: it is exactly the cap-saturating points, which are $\mathbb Z_2$-graded by the same equality, sitting at $\theta_0(n)$ precisely. Solving $\theta\ge\sqrt{3/2}$ for $r$ shows how tight this is, $r\ge29.70$ against a cap of $30$ at $n=12$, so the threshold alone nearly forces saturation there, while the window widens to $121.17$ against $132$ at $n=24$. **The window is irrelevant, because every point strictly inside it has $S_{\mathfrak{mmm}}>0$ and so leaves $\{S=0\}$ by definition.**

**AND THE CAP IS TWO INEQUALITIES PINCHING, WHICH IS CLEANER THAN THE ROOT ARGUMENT.** *[Reviewer 320](../reviews/REVIEW_r320.md), verified for all even $n\le20$.* $S_{\mathfrak{mmm}}=0$ characterises symmetric pairs, and **every** symmetric subalgebra sits at or above the cap: $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ has $r-\mathrm{cap}=(p-q)^2/4$, and $\mathfrak u(m)\subset\mathfrak{so}(2m)$ has $r-\mathrm{cap}=m$. So the cap is not one root of an affine function but *two opposite inequalities meeting*, and the balanced-split result below is exactly the case $(p-q)^2=0$, with $\mathfrak u(m)$ excluded outright since $m>0$ always.

**AND THE BALANCED SPLIT IS THE ONLY SYMMETRIC PAIR IN THE FAMILY AT ALL, one line of algebra.** *Prompted by [Reviewer 320](../reviews/REVIEW_r320.md)'s log observation that symmetric subalgebras overshoot the cap; derived and checked here.* Lemma L23 needs $W_{\mathfrak h}=\Pi_{\mathfrak h}-\frac rN\mathrm{Id}$ to *be* a Weyl tensor, and its own formula $S_{\mathfrak{mmm}}=(N-r)\bigl[2(n-2)-\tfrac{4(n-1)r}N\bigr]$ must therefore be $\ge0$. For a symmetric pair $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$,

$$r=\binom p2+\binom q2=\frac{p^2+q^2-n}2,\qquad r=\frac{n(n-2)}4\iff(2p-n)^2=0\iff p=q=\frac n2 .$$

**Every unbalanced pair overshoots**, and the formula returns a *negative* $S_{\mathfrak{mmm}}$ (impossible for a sum of squares) so $W_{\mathfrak h}$ is not a Weyl tensor there at all. Measured: $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ gives $-15$ at $n=8$, $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ gives $-23.33$ at $n=12$, worsening as the split unbalances; only $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ returns exactly $0$.

> **So the conjectured maximiser is distinguished inside Lemma L23 before any optimisation happens**: it is the unique symmetric pair whose projector-form tensor is admissible, and it saturates the bound at $\theta_0(n)$. *This is a statement about why the balanced split is special that costs one line, and the record did not have it.*

*What this gives C2 and what it does not, stated at its true reach.**What this gives C2 and what it does not, stated at its true reach.* **The subalgebra family is exactly the two-eigenvalue points**, $W_{\mathfrak h}\propto\Pi_{\mathfrak h}-\frac rN\mathrm{Id}$ has one eigenvalue on $\mathfrak h$ and one on $\mathfrak m$, and that is a **much smaller class than "the graded points"**. Measured at $n=8$: $S^4\times S^4$ has two eigenvalues and saturates Lemma L23 exactly ($1.145644=\theta_0(8)$), while $S^3\times S^5$ and $S^2\times S^6$ have **three** and sit outside, carrying $S_{\mathfrak{mmm}}=0$ with $\theta=1.115547$ and $0.986013$, strictly below $\theta_0$. *So "on the subalgebra family $S=0$ forces $\theta=\theta_0$" is true and is nearly a tautology: within two-eigenvalue points, only the balanced one has $S=0$.*

**What C2 actually gains** is therefore modest and worth stating as such: the chain's first step holds on the family where $W$ is projector-like, which contains the conjectured maximiser and little else. **Every unbalanced sphere product lies outside it with $S=0$**, so the class $\{S=0\}\cap\{\theta\ge t\}$ is not collapsed in general, and the complement, where $W$ has three or more distinct eigenvalues, is where C2's work remains. *The record's own note that the subalgebra family is where senses (C) and (A) coincide says the same thing from the other side: this is the region built to be easy.*

**A READING UNDER WHICH THE CHAIN SURVIVES, raise the threshold, do not argue about the sense.** *[Reviewer 318](../reviews/REVIEW_r318.md); arithmetic checked here.* Keep sense **(C)** and take the threshold at $t=\theta_0(n)$ rather than $\sqrt{3/2}$. For $n\ge12$, $\theta_0(n)^2\ge55/36>3/2$, $1.527778$ at $n=12$, rising, so **padded $W_{\mathbb{CP}^2}$ leaves the set strictly**, sitting at exactly $\sqrt{3/2}=1.224745$ against $\theta_0(12)=1.236033$. Step 1 then holds with the balanced sphere product alone, which is nondegenerate, and step 2 has no counterexample on the catalogue. *This is the repair the sense-argument was never going to produce: the counterexample is excluded by where the threshold sits, not by how "graded" is read.*

**Two breaks survive the repair and are what a successor must clear**: $S_{\mathfrak{mmm}}$ is **discontinuous** at an eigenvalue zero-crossing, which the minimum-extraction step needs; and step 1 rests on the $\mathbb Z_2$-grading classification, which is **incomplete at $n=8$** and correct at $n\ge12$ only for a reason the record now states ($\mathrm{Out}(\mathfrak{so}(8))=S_3$).

**So the chain does not stand as written**

#### The owed statement was ALREADY PROVED in this file, and the commit that claimed to prove it added a change of variable

*Gate 2, [Reviewer 83](../reviews/REVIEW_r83.md) and [Reviewer 84](../reviews/REVIEW_r84.md), independently; confirmed here against `d1427f6^`.* Three paragraphs below, predating the commit, stands the unconditional statement (*"for $p,q\ge3$ with $(p,q)\ne(3,3)$ … $S^p\times S^q$ is Morse–Bott nondegenerate"*), backed by Nienhaus Prop 4.6's ten-summand decomposition, multiplicity-freeness, Schur, and index proofs. **The ledger line claiming this was newly proved is withdrawn.**

#### What the re-derivation is actually worth: corroboration by a second route, and one genuine gap it exposed

With $c=6\lambda-3$, *an identity, since $P$ is cubic so $\mathrm{Hess}\,P=6F_W$ and the constrained Hessian is $6F_W-3\theta$; it is already written in the project's own code, and reading it off a table row was fitting something free*, the five families are

$$c_{A_m}=\frac{-3}{m-1}\ (m=p,q),\qquad c_B=-3+\frac3{p-1}+\frac3{q-1},\qquad c_C=-3,\qquad c_D=-3-\frac3{p-1}-\frac3{q-1},$$

and Reviewer 84 **derived** them rather than fitting, from the master formula

$$\lambda=1-\frac{\mathrm{Cas}_p}{4(p-1)}-\frac{\mathrm{Cas}_q}{4(q-1)},$$

obtained by splitting $B(W,X)=-\tfrac12\sum_cw_cA_cXA_c$ by block; the three block constants collapse to a common $1-\tfrac1{n-1}$, so **every dependence on which block a vector sits in cancels**. That derives the standing assertion that each Casimir block carries exactly one Hessian eigenvalue (a cancellation, not an observation) and makes $c=0$ on the orbit tangent an identity, $\frac{\mathrm{Cas}_p(V_1)}{p-1}+\frac{\mathrm{Cas}_q(V_2)}{q-1}=2$.

#### The gap a fit cannot see

In the ambient $S^2\Lambda^2V$ two further families have vanishing $c$: $\Lambda^4V_1$ at $c=3(7-p)/(p-1)$, zero at $\mathbf{p=7}$, and $\Lambda^3V_1\otimes V_2$ at $c=3(4-p)/(p-1)$, zero at $\mathbf{p=4}$. **Both are killed by the first Bianchi identity**, each occurring once in $S^2\Lambda^2V$ and once in $\Lambda^4V$. Had either survived, $S^7\times S^q$ and $S^4\times S^q$ would be degenerate and the theorem false. *A family list obtained by fitting recorded rows cannot know what is missing from the rows*, so the fitted version never ruled them out.

#### Two scope corrections

*(i)* The commit stated the analysis over "integers $p,q\ge2$". At $p=2$ the summand $S^2_0(\mathbb R^p)$ **drops out of $\mathrm{Weyl}_n$ entirely**, which is exactly why the ten dimensions overshoot $\dim\mathrm{Weyl}_n$ by $2$ there ($W(2)=-2$ against $\dim\mathrm{Weyl}_2=0$); with it removed they match identically in $q$. $S^2\times S^q$ is nondegenerate, but $c_B=3/(q-1)>0$ means it is **not a local maximum**, a live exception the blanket sentence hid. *(ii)* $c=0$ characterises the criterion, not degeneracy: $\ker\mathrm{Hess}=\text{orbit tangent}\Rightarrow$ nondegenerate is the direction the isolation argument uses; the converse fails, so calling $S^3\times S^3$ "the failure" overstates, there the *criterion* fails, with kernel $18$ against orbit $9$.

#### What stands

for $p,q\ge3$, every $S^p\times S^q$ other than $S^3\times S^3$ is Morse–Bott nondegenerate, $\dim E(\tfrac12)=pq$, and the exception is the identity $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ with $(p-2)(q-2)=1$ forcing $p=q=3$.

#### The spectra, exact

$L_e$ at $S^p\times S^q$ carries few families, all rational:

| split | spectrum with multiplicities |
| --- | --- |
| $3{+}5$ | $-\tfrac38^{70},\ 0^{165},\ \tfrac14^{5},\ \tfrac38^{44},\ \tfrac12^{15},\ 1^{1}$ |
| $4{+}4$ | $-\tfrac13^{81},\ 0^{148},\ \tfrac13^{54},\ \tfrac12^{16},\ 1^{1}$ |
| $3{+}7$ | $-\tfrac13^{135},\ 0^{518},\ \tfrac14^{5},\ \tfrac13^{63},\ \tfrac5{12}^{27},\ \tfrac12^{21},\ 1^{1}$ |
| $4{+}6$ | $-\tfrac4{15}^{180},\ 0^{446},\ \tfrac4{15}^{90},\ \tfrac13^{9},\ \tfrac25^{20},\ \tfrac12^{24},\ 1^{1}$ |
| $5{+}5$ | $-\tfrac14^{196},\ 0^{420},\ \tfrac14^{100},\ \tfrac38^{28},\ \tfrac12^{25},\ 1^{1}$ |

In every case $\tfrac12$ has multiplicity exactly $pq$, $1$ is simple, and every other eigenvalue is strictly below $\tfrac12$, the largest competitors being $\tfrac5{12}$, $\tfrac25$ and $\tfrac38$. The signed pair follows $(n-2)/D$ with $D=16,18,24,30,32$ respectively. **The dangerous family's eigenvalue is proven in closed form** (Reviewers 30 and 31 derived it independently; proved symbolically here, and audited by Reviewers 32 and 33 on identical briefs). The whole $L_e$ spectrum at $S^p\times S^q$ is rational: with $s_m=(m+2)(m-1)/2$ and $c_m=m(m-1)/2$, the eigenvalues are $\pm\mu$ at multiplicities $s_ps_q$ and $c_pc_q$, $\lambda_m=(m-2)/(2(m-1))$ at multiplicity $s_m$ for $m=p,q$, then $\tfrac12$ at multiplicity $pq$ and $1$ simple, where

$$\mu(p,q)=\frac{n-2}{2(p-1)(q-1)},\qquad \mu\ge\tfrac12\iff (p-1)+(q-1)\ge(p-1)(q-1)\iff (p-2)(q-2)\le1 .$$

So the only solutions are $p=2$, which is the exception already on record at $\lambda_{\max}=\tfrac12+\tfrac1{2(n-3)}$, and $(p,q)=(3,3)$, which gives equality. Both are now **proved at every $n$**, not scanned: the eigenvector is exhibited and $e\circ X=\mu X$ verified symbolically in $p,q$ over every plane type ([b_twoblock_symbolic.py](../scripts/lib/b_twoblock_symbolic.py), [b_twoblock_exhaustive.py](../scripts/route-b/b_twoblock_exhaustive.py)). The proof is cheaper than the route taken to it: holding the three block values $\varepsilon_{PP},\varepsilon_{QQ},\varepsilon_{PQ}$ as free symbols, $e\circ X=\lambda X$ for **any** three-block diagonal $e$ with

$$\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ},$$

so criticality is never used, it only fixes the number. Substituting $\varepsilon_{PP}=q/((p-1)(n-1))$, $\varepsilon_{QQ}=p/((q-1)(n-1))$, $\varepsilon_{PQ}=-1/(n-1)$, which follow from $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$, collapses it to $\mu$.

#### What this proves is one direction only, and the other direction is what nondegeneracy needs

An exhibited eigenvector bounds $\lambda_{\max}$ from **below** and bounds one multiplicity from below. The statements "$(3,3)$ is the *unique* split reaching $\tfrac12$" and "$\dim E(\tfrac12)=pq$" are upper bounds on the rest of the spectrum, and no exhibited eigenvector supplies those. So this closes the $p=2$ violation and the $(3,3)$ degeneracy at every $n$, and **nondegeneracy for $p,q\ge3$ rests entirely on the multiplicity list below**, which remains numerical.

#### The multiplicity list is the isotypic decomposition, and it is nearly proved

Nienhaus's Proposition 4.6 and the summary display after it give

$$\mathrm{Weyl}_n=\langle W\rangle\oplus\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus(\mathbb R^p\!\otimes\!\mathbb R^q)\oplus S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)\oplus(S^2_0\!\otimes\!S^2_0)\oplus(\Lambda^2\!\otimes\!\Lambda^2)\oplus(X_p\!\otimes\!\mathbb R^q)\oplus(X_q\!\otimes\!\mathbb R^p),$$

orthogonal and irreducible under $O(p)\times O(q)$, with $X_m$ the $O(m)$-irreducible of Young label $[2,1]$ and $\dim X_m=m(m^2-4)/3$; the ten dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$. Since $e$ is $O(p)\times O(q)$-invariant, $L_e$ is equivariant, and the decomposition is **multiplicity-free for every $p,q\ge3$** by Young labels, so Schur makes $L_e$ a **scalar** on each summand. Absolute irreducibility is what Schur needs, and a symmetric element of a real division algebra has a real eigenvalue and is therefore a real scalar, **this covers $\mathbb C$ and $\mathbb H$ rather than ruling them out**, and the earlier phrasing in this file is retracted at the canonical block. **This is what turns each summand's value into an eigenvalue rather than a lower bound**, which is the direction nondegeneracy requires.

#### Six of the ten values are known and two more are proved zero

$1$ on $\langle W\rangle$; $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$, which needs no computation since differentiating $Q(W_t)=\theta W_t$ along the orbit gives $e\circ\dot W=\tfrac12\dot W$ at every critical point; $\lambda_m$ on $S^2_0(\mathbb R^m)$; $-\mu$ on $S^2_0\otimes S^2_0$; $+\mu$ on $\Lambda^2\otimes\Lambda^2$, which is the family proved above. $L_e$ vanishes on $\mathrm{Weyl}_p$ and $\mathrm{Weyl}_q$ for all $p,q$, proved two ways, via $\Phi(V)=2V$ on $\mathrm{Weyl}_n$, and via $e=\eta I_n+(A-\eta)I_p+(B-\eta)I_q$ with $L_{I_n}\equiv0$ on $\mathrm{Weyl}_n$ from $\mathrm{Ric}=0$. $\ker L_e$ is exactly the four block-support subspaces $(pp,pp)$, $(qq,qq)$, $(pp,\mathrm{mix})$, $(qq,\mathrm{mix})$, of dimensions $W(p),W(q),X(p)q,X(q)p$.

#### Both debts are discharged, and the result is unconditional

(Reviewers 38 and 39, identical briefs, agreeing; each supplied the proof independently).

#### The constant, proved uniformly in $p,q,n$

Write $\mathrm{sharp\_bilin}(X,Y)=\mathrm{Sym}_{\text{pair}}\mathrm{Alt}_{ij}H$ with $H(X,Y)_{ijkl}=\sum_{ab}(X_{iakb}Y_{jalb}-X_{ialb}Y_{jakb})$, an identity carrying no hypotheses. Specialising $X=I_p$,

$$H(I_p,V)=\pi_{ik}\rho_{jl}-\pi_{il}\rho_{jk}-\chi_i\chi_kV_{jkli}+\chi_i\chi_lV_{jlki},\qquad \rho_{jl}=\sum_{a\in P}V_{jala}.$$

**Ricci-flatness enters exactly once**, to force $\rho=0$: on the support the $Q$-block partial trace $\sigma$ vanishes identically, so $\mathrm{Ric}=\rho+\sigma=0$ gives $\rho=0$. A six-case exhaustion by block type kills five cases on support or on the $\chi$ factors, and the single live $(PP,MX)$ case uses **Bianchi twice** to return exactly $-V_{ijkl}/2$. No Schur, no irreducibility, no $p,q\ge3$. The same formula gives $\Phi_p=-\tfrac12$, $\Phi_q=0$, $\Phi_{\mathrm{mix}}=-\tfrac12$, yields $\mathrm{sharp\_bilin}(\mathrm{Id},V)=-V$ on $\mathrm{Weyl}_n$, re-derives the raw-block eigenvalues $1,-\tfrac12,\tfrac{p-2}{2}$, and disposes of the companion $X_q\otimes\mathbb R^p$ for free. Verified exhaustively over all $N^2$ entries of every basis vector in exact integer arithmetic at 24 splits, one reaching $18.9$M entries at $(11,4)$, with negative controls firing.

#### The irreducibility at $p,q\le4$, computed rather than cited

Nienhaus proves the $k,l\ge5$ case; the closing sentence of Proposition 4.6's summary display asserts $O(k)\times O(l)$ irreducibility for $k,l\ge3$, and Remark 4.7(ii) notes a similar decomposition for $k,l\le4$ with $\Lambda^2(\mathbb R^4)$, $\mathrm{Weyl}_4$ and $X_4$ each splitting into $\pm$ at $k=4$. Exact commutant computation supplies the small cases: at $m=3$ and $m=4$, each of $\mathbb R^m$, $\Lambda^2$, $S^2_0$ and $X_m$ has $\mathrm{End}=1$ with every cross-$\mathrm{Hom}$ zero under the full $O(m)$ including the reflection, including the two coincidences that would break it, $\mathbb R^3$ against $\Lambda^2(\mathbb R^3)$ at dimension $3$ and $S^2_0$ against $X_3$ at dimension $5$. $\mathrm{Weyl}_4$ has $O(4)$-commutant $1$, irreducible under $O(4)$ though it splits into $\mathrm{Weyl}_4^\pm$ under $SO(4)$; $\mathrm{Weyl}_5$ likewise. **Under $SO(4)\times SO(q)$ Schur would return two constants $a_\pm$; the $O(4)$ statement forces $a_+=a_-$, and the index proof supplies $-\tfrac12$ for both regardless.**

#### One scope correction

The identity does not characterise the summand inside $\mathrm{Weyl}_n$: its $-\tfrac12$ eigenspace there is two to three times larger ($45$ against $15$ at $(3,3)$, $145$ against $64$ at $(4,4)$), the excess being the Kulkarni–Nomizu tensors spanning $S^2_0\otimes S^2_0$, joined at $p=3$ by $S^2_0(\mathbb R^p)$ since $\mathrm{sharp\_bilin}(I_p,\cdot)$ is $\tfrac{p-4}{2}$ on its $(pp,pp)$ part. Inside the raw $(pp,\mathrm{mix})$ block the eigenspace **is** the summand, and both Weyl conditions are load-bearing: dropping either makes every extra basis vector fail, at nine splits.

#### Two facts that simplify the summand

$X_p\otimes\mathbb R^q=\{V\in\mathrm{Weyl}_n:\mathop{\mathrm{supp}}V\subseteq(pp,\mathrm{mix})\}$ at all twelve splits to $n=15$, a description with no representation theory and no kernel in it. And the Weyl conditions cut the ambient block exactly along its isotypic split, $\Lambda^3\otimes\mathbb R^q$ carrying all the Bianchi obstruction, $\mathbb R^p\otimes\mathbb R^q$ all the Ricci obstruction, and $X_p\otimes\mathbb R^q$ their intersection. On it $\Phi_p=-\tfrac12$, $\Phi_q=0$, $\Phi_{\mathrm{mix}}=-\tfrac12$, so $L_{e'}V=0$ for any three-block diagonal $e'$ and criticality is never used. Separately, $X_p\otimes\mathbb R^q$ is $O(p)\times O(q)$-irreducible but $SO(4)\times SO(q)$-**reducible**, commutant $1$ against $2$ at $p=4$, which re-derives the $p=4$ half of Remark 4.7(ii) for this summand and shows the $O$-versus-$SO$ distinction is load-bearing.

#### Hence, unconditionally: for $p,q\ge3$ with $(p,q)\ne(3,3)$, $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$, attained exactly on the orbit tangent, and $S^p\times S^q$ is Morse–Bott nondegenerate

**THE MARGIN QUOTED HERE IS THE WRONG QUANTITY, and the true one decays like $1/n$.** *[Reviewer 314](../reviews/REVIEW_r314.md), confirmed here at five splits.* $\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ is the gap to the *family-B* block, not to the spectrum. The **second-largest** eigenvalue of $L_e$ below $\tfrac12$ is

$$\lambda_2=\frac{M-2}{2(M-1)},\qquad M=\max(p,q),\qquad\text{so the real gap is }\ \tfrac12-\lambda_2=\frac1{2(M-1)} .$$

**This needs $(p,q)\ne(3,4)$**, the one split below $p,q\ge5$ where the family-B eigenvalue $\mu=\tfrac5{12}$ overtakes $\lambda_2=\tfrac13$ and the gap is $\tfrac1{12}$ instead. *The five splits checked here ($(3,5)$, $(4,4)$, $(3,7)$, $(5,5)$, $(4,6)$), all miss it.*

Measured against the formula at $(3,5)$, $(4,4)$, $(3,7)$, $(5,5)$, $(4,6)$: exact every time. The two agree only at $(3,5)$ and $(4,4)$, at $(5,5)$ the advertised gap is $0.250$ against a true $0.125$, and at $S^5\times S^7$ it is $0.292$ against $1/12$. **Nondegeneracy is unaffected**, since $1/(2(M-1))>0$ for every $M\ge3$; what is affected is every argument that spends the margin, because it shrinks like $1/n$ rather than staying at a quarter. The exception at $(3,3)$ is still exact and still the only one.

The family-B statement, correct as such: $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, so $\mu=\tfrac12$ iff $p=q=3$, and a symbolic solve over all $45$ summand pairs finds that the only coincidence with $p,q\ge3$, over all $p,q$. At $(3,3)$ the resulting $\dim E(\tfrac12)=18$ against orbit $9$ is an **eigenvalue coincidence, not representation mixing**: under $O(3)$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$, measured as $\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$, so Schur permits no mixing and each summand carries $\tfrac12$ separately.

#### Scope at the bottom end

The list needs $p,q\ge2$ for the summands to exist and $n\ge5$ for the count: at $(2,2)$ the named multiplicities sum to $14$ against $\dim\mathrm{Weyl}_4=10$ and $1$ is not simple, the exact spectrum being $(-1)^4,(\tfrac12)^4,1^2$, since $\mu=1$ there and $e=e^++e^-$ is non-primitive under the Hodge splitting of $\Lambda^2(\mathbb R^4)$. Verified numerically at 25 splits to $n=16$ before the structural argument existed, and $P(W_{p,q})$ agrees with Nienhaus Proposition 2.25 exactly, so no convention factor separates this record from his.

#### What is owed

Nondegeneracy is verified at $n=8,10$ across the full classification and at $n=12$ across every two-block split, the first dimension where the conjecture bites and at the balanced product for all even $n\ge8$ in closed form; it is proven for **every** $p,q\ge3$ with $(p,q)\ne(3,3)$ by [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof) above, whose $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ is symbolic in $p$ and $q$; $\mathbb{CP}^m$ at general $n$ remains open.

> **THIS PARAGRAPH READ "it is not proven for the unbalanced splits" AND THAT OBLIGATION WAS DISCHARGED BY [LEMMA L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof), 300 LINES ABOVE IT IN THIS FILE.** The stale sentence made a proved result read as owed, and [Lemma L69](graded-half.md)'s headline example $S^5\times S^7$ is unbalanced, so the two pages of the record disagreed about its own flagship case. *Found at Gate 2 on L69, [r501](../reviews/REVIEW_r501.md) raising the contradiction and [r502](../reviews/REVIEW_r502.md) deciding it.* That closed form is the target, and the $L_e$ spectrum is the tool, Reviewer 26 already produced the six-family closed form at the balanced point.

## Post F27, no spectral gap uniform in $n$ exists on the graded critical set

**No spectral gap uniform in $n$ exists on the graded critical set**, the balanced product's own smallest nonzero modulus is $\sim\sqrt2/n\to0$, so any usable statement is per $n$

*Moved here 2026-09-02: the post existed only as a row in [INDEX-traps.md](INDEX-traps.md), which named this file as its home while this file did not carry it. The index now summarises and this block states it.*
