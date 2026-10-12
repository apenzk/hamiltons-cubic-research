# Gate 2 review r949, Lemma L226 (the cubic on the block subalgebra S_J)

Brief: [BRIEF_L226.md](BRIEF_L226.md). Log: [agent_logs/review-r949.log](../agent_logs/review-r949.log). Claim: [findings/second-order.md](../findings/second-order.md) lines 953-975.

**Verdict: every step CONFIRMED. The mathematics of items 1 to 3 is right at every $k\ge2$ and every $n$, and no counterexample exists. The written chain has four small gaps of justification (C2 to C5), a definitional mismatch with the block note over what $\mathcal S_J$ is (C1), and two overclaims in prose outside the proof (C6 in the Lean paragraph, C7 in "What it gives").**

| Item | Verdict | Reason |
|---|---|---|
| 1. Step 1 | CONFIRMED | In an orthonormal eigenbasis $W_{\gamma\epsilon}=\lambda_\gamma\delta_{\gamma\epsilon}$, so $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma,\delta}c_{\alpha\gamma\delta}^2\lambda_\gamma\lambda_\delta$ and the pairing is $\tfrac12\sum$ over ordered triples. At $\mathrm{id}$ each $\sum_{\gamma\delta}c_{\alpha\gamma\delta}^2=\lvert\operatorname{ad}v_\alpha\rvert^2=2(n-2)$, matching $\mathrm{id}^\#=(n-2)\mathrm{id}$. |
| 2. Step 2 brackets | CONFIRMED, gap C2 | All six listed brackets and the commuting claim follow from the quoted formula (checked index by index, and $[\varphi_{12},\varphi_{13}]=\varphi_{23}$ checked against $\varphi_{ij}=E_{ji}-E_{ij}$). The containment $[\Lambda^2\mathbb R^J,V_a]\subseteq V_a$ uses a bracket the list omits. |
| 3. Step 2 exhaustiveness | CONFIRMED | All block multisets enumerated below. Every one outside the four listed has a zero structure constant. |
| 4. Step 3 | CONFIRMED, gap C3 | Counts $3$ and $6$, the factor $2$, the $\operatorname{tr}(M_aM_b)$ sum and the $\mathfrak{so}(k)$ term are right. Orthogonality of distinct $v_\beta\wedge v_\gamma$ is used and left unstated. |
| 5. Step 4 and item 2 | CONFIRMED, correction C1 | Entry shapes, the repeated-index Bianchi case, the Ricci entries and both directions of "exactly when" check. Read against the block note, whose $\mathcal S_J$ lies inside $\mathcal W_n$, item 2 is vacuous, so the lemma needs its own definition of $\mathcal S_J$. |
| 6. Step 5 and item 3 | CONFIRMED, gap C4 | Frame, $x\wedge y\mapsto x\times y$, $3\det S$, the cofactor identity, every entry of $\rho$ and the inversion check. "So the bracket becomes the cross product" does not follow from the wedge map, and "Bianchi holds automatically" is asserted without its one-line reason. |
| 7. Gate 1 | CONFIRMED, wording C5 | (a) is true as a polynomial identity in $m$ but is item 1 at $k=3$ only. (b) is true: each triangle type arises once with coefficient $3$. (d) is true and matches L224's coordinates. |
| 8. Lean | CONFIRMED, correction C6 | `blockCoeff` is item 3's operator in every case, the $\tfrac14$ is right, the hypotheses are sufficient and satisfiable, the four proved lemmas are what the paragraph says, and the axioms are as stated. The paragraph overclaims what the four `sorry` statements cover. |
| 9. Scope and counterexamples | CONFIRMED, correction C7 | Holds at $k\ge2$, every $n$, $m=0$ and $m=1$. No $W$ violates item 1 or 3. "Two ways only" in "What it gives" omits the frame coupling carried by $\operatorname{tr}S^3+3\det S$ and $\lvert S\rvert^2$. |

## Item 1, step 1

- $\langle W,W^\#\rangle=\sum_\alpha\lambda_\alpha(W^\#)_{\alpha\alpha}$ in an orthonormal eigenbasis, and $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma,\delta,\epsilon,\zeta}c_{\alpha\gamma\delta}c_{\alpha\epsilon\zeta}\lambda_\gamma\delta_{\gamma\epsilon}\lambda_\delta\delta_{\delta\zeta}=\tfrac12\sum_{\gamma,\delta}c_{\alpha\gamma\delta}^2\lambda_\gamma\lambda_\delta$. The result is the displayed ordered-triple sum with its $\tfrac12$.
- Total antisymmetry of $c$ in any orthonormal basis holds because `inner2` is ad-invariant, so choosing the eigenbasis block by block is legitimate.
- Identity check: for $\varphi_{12}$, $\operatorname{ad}$ swaps $\varphi_{1a}$ and $\varphi_{2a}$ up to sign for the $n-2$ indices $a\ge3$ and kills the rest, so $\sum_{\gamma\delta}c_{\alpha\gamma\delta}^2=2(n-2)$, and by $O(n)$-invariance this holds for every unit $v_\alpha$. The sum is $\tfrac12\cdot2(n-2)\dim\Lambda^2=\langle\mathrm{id},(n-2)\mathrm{id}\rangle$, as written.

## Item 2, step 2

- Substituting into $[\varphi_{ab},\varphi_{cd}]=\delta_{ac}\varphi_{bd}+\delta_{bd}\varphi_{ac}-\delta_{ad}\varphi_{bc}-\delta_{bc}\varphi_{ad}$: $[\varphi_{pa},\varphi_{qa}]$ keeps only $\delta_{aa}\varphi_{pq}$. $[\varphi_{pa},\varphi_{pb}]$ keeps only $\delta_{pp}\varphi_{ab}$. $[\varphi_{pa},\varphi_{qb}]$ has no surviving delta. $[\varphi_{pa},\varphi_{ab}]$ keeps only $-\delta_{aa}\varphi_{pb}$. $[\varphi_{pa},\varphi_{bc}]=0$. $[\varphi_{ab},\varphi_{ac}]=\varphi_{bc}$. Disjoint index sets commute. All as written.
- $[x,y]=\sum_{p,q}x_py_q[\varphi_{pa},\varphi_{qa}]=\sum_{p\ne q}x_py_q\varphi_{pq}=x\wedge y$, the $p=q$ terms vanishing on both sides. $[x,y]=\sum_px_py_p\varphi_{ab}$ for $a\ne b$. Both as written.
- **Gap (C2).** $[\Lambda^2\mathbb R^J,V_a]\subseteq V_a$ and "$\Lambda^2\mathbb R^J$ is a subalgebra" rest on $[\varphi_{pq},\varphi_{ra}]=\delta_{pr}\varphi_{qa}-\delta_{qr}\varphi_{pa}$ and $[\varphi_{pq},\varphi_{rs}]\in\Lambda^2\mathbb R^J$, neither of which is in the list. Both are immediate from the formula, and both containments are true.

## Item 3, exhaustiveness

Blocks are $L=\Lambda^2\mathbb R^J$, each $V_a$, and each line $\mathbb R\varphi_{ab}$ (a block because $W\varphi_{ab}=K_{ab}\varphi_{ab}$). With $c(u,v,w)=\langle[u,v],w\rangle$ totally antisymmetric:

| Blocks | Structure constant | Reason |
|---|---|---|
| $L,L,L$ | listed | $\mathfrak{so}(k)$ |
| $L,L,V_a$ and $L,L,\varphi_{ab}$ | $0$ | $[L,L]\subseteq L$ |
| $L,V_a,V_a$ | listed | $[V_a,V_a]\subseteq L$ |
| $L,V_a,V_b$ ($a\ne b$) | $0$ | $[V_a,V_b]\subseteq\mathbb R\varphi_{ab}\perp L$ |
| $L,V_a,\varphi_{bc}$ | $0$ | $[L,V_a]\subseteq V_a$ |
| $L,\varphi,\varphi$ | $0$ | $[L,\Lambda^2\mathbb R^A]=0$ |
| $V_a,V_a,V_a$, $V_a,V_a,V_b$, $V_a,V_a,\varphi_{bc}$ | $0$ | $[V_a,V_a]\subseteq L$ |
| $V_a,V_b,V_c$ distinct | $0$ | $[V_a,V_b]\subseteq\mathbb R\varphi_{ab}$ |
| $V_a,V_b,\varphi_{cd}$ | listed when $\{c,d\}=\{a,b\}$, else $0$ | $[V_a,V_b]=\mathbb R\varphi_{ab}$ |
| $V_a,\varphi,\varphi$ | $0$ | $[V_a,\varphi_{bc}]\subseteq V_b+V_c$ |
| $\varphi,\varphi,\varphi$ | listed for a triangle, else $0$ | $\mathfrak{so}(m)$, and a repeated line is a repeated basis vector |

The four listed types are exhaustive.

## Item 4, step 3

- $L,L,L$: `inner2` restricted to matrices supported on $J\times J$ is `inner2` of $\mathfrak{so}(k)$, so these constants are those of $\mathfrak{so}(k)$ in the same normalisation and the sum is $\langle R_J,R_J^\#\rangle$ computed in $\mathfrak{so}(k)$.
- $L,V_a,V_a$: the $L$ index takes $3$ positions and the other two run over ordered pairs in $V_a$. $c(\omega,v_\beta,v_\gamma)=\langle[v_\beta,v_\gamma],\omega\rangle=\langle v_\beta\wedge v_\gamma,\omega\rangle$. The ordered sum has zero diagonal and equal $(\beta,\gamma)$, $(\gamma,\beta)$ terms, giving the factor $2$. $\Lambda^2M_a(v_\beta\wedge v_\gamma)=\lambda_\beta\lambda_\gamma\,v_\beta\wedge v_\gamma$. The total $\tfrac12\cdot3\cdot2\sum_\omega\mu_\omega\langle\Lambda^2M_a\omega,\omega\rangle=3\operatorname{tr}(R_J\Lambda^2M_a)$ is right.
- **Gap (C3).** The spectral identity $\sum_{\beta<\gamma}\lambda_\beta\lambda_\gamma\langle v_\beta\wedge v_\gamma,\omega\rangle^2=\langle\Lambda^2M_a\omega,\omega\rangle$ needs the $v_\beta\wedge v_\gamma$ to be **orthonormal**, and the text states only unit length and spanning. Eigenvectors of $\Lambda^2M_a$ for a repeated eigenvalue need not be orthogonal, so this does not come for free. It holds: as matrices $x\wedge y=yx^{\mathsf T}-xy^{\mathsf T}$, and `inner2` gives $\langle x\wedge y,u\wedge v\rangle=\langle x,u\rangle\langle y,v\rangle-\langle x,v\rangle\langle y,u\rangle$.
- $V_a,V_b,\varphi_{ab}$: three distinct blocks, $3!=6$ orders (swapping $a$ and $b$ included, so the sum over $a<b$ does not double count), $c=\langle v_\beta,v_\gamma\rangle$, and $\sum_{\beta,\gamma}\lambda_\beta(M_a)\lambda_\gamma(M_b)\langle v_\beta,v_\gamma\rangle^2=\operatorname{tr}(M_aM_b)$. Right.
- Triangles: $c(\varphi_{ab},\varphi_{ac},\varphi_{bc})^2=1$, $6$ orders, coefficient $3$. Right. The $\operatorname{tr}W^3$ split is immediate from block-diagonality.
- **Hand check at general $k$** (arithmetic on the trusted value $P(\mathrm{id})=(n-1)\binom n2$): item 1 at $\mathrm{id}$ reads $(k-1)\binom k2+m\big(k+3\binom k2\big)+\binom m2(1+3k)+3\binom m3$. At $(k,m)=(2,1),(4,1),(4,2),(5,1)$ this is $6,40,75,75$, which is $(n-1)\binom n2$ at $n=3,5,6,6$. The coefficient $3$ is right away from $k=3$ too.

## Item 5, step 4 and item 2

- Entry shapes: nonzero $W_{ij,kl}$ needs multiset in $J$, $\{p,q,a,a\}$ ($p=q$ allowed), or $\{a,b,a,b\}$. This is the block form.
- Repeated index: with `bianchi` $=W_{ij,kl}+W_{ik,lj}+W_{il,jk}$ and the pair symmetries, $i=j$ gives $W_{ik,li}+W_{il,ik}=W_{ik,li}-W_{ik,li}=0$, $j=k$ gives $W_{ij,jl}+W_{ij,lj}=0$, $i=k$ gives $W_{ij,il}-W_{il,ij}=0$, and the other coincidences are the same computation. The claim holds.
- Four distinct indices not all in $J$: no entry of any of the three shapes has four distinct indices outside the all-$J$ case, so every term vanishes. Bianchi therefore reduces to $R_J$'s, in both directions.
- Ricci with `Ric a b` $=\sum_c\langle W\varphi_{ac},\varphi_{bc}\rangle$: $\operatorname{Ric}_{pq}=\sum_{r\in J}W_{pr,qr}+\sum_aW_{pa,qa}$. $\operatorname{Ric}_{aa}=\sum_pW_{ap,ap}+\sum_bW_{ab,ab}=\operatorname{tr}M_a+\sum_{b\ne a}K_{ab}$. For $\operatorname{Ric}_{pa}$ the pairs are $(\varphi_{pr},\varphi_{ar})\in L\times V_a$ and $(\varphi_{pb},\varphi_{ab})\in V_b\times\Lambda^2\mathbb R^A$. For $\operatorname{Ric}_{ab}$ they are $(\varphi_{ap},\varphi_{bp})\in V_a\times V_b$ and $(\varphi_{ac},\varphi_{bc})$, two distinct eigenlines. All vanish, as written.
- "Exactly when" holds in both directions **for operators that are symmetric and preserve $\Lambda^2$ but are not assumed Weyl**.
- **Definitional finding (C1).** The block note defines $\mathcal S_J$ as the $H_J$-fixed space and states $\mathcal S_{[n]}=\mathcal W_n$ and $\mathcal S_{\{i\}}=\mathcal D_n$. So its $\mathcal S_J$ lies inside $\mathcal W_n$, and so do [plan.md](../plan.md)'s line 26 and L224's $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$. Under that definition item 2 ("$W\in\mathcal S_J$ lies in $\mathcal W_n$ exactly when") is vacuous, item 3's "$\mathcal S_J\cap\mathcal W_n$" is $\mathcal S_J$, and Gate 1 (a)'s "$W=\mathrm{id}$, not Weyl" is outside $\mathcal S_J$. The lemma actually uses the $H_J$-fixed symmetric operators on $\Lambda^2\mathbb R^n$. The block note's character argument uses no Weyl condition, so that space has the same block form (checked: $R_{pq,ra}$, $R_{pa,qb}$, $R_{pq,ab}$, $R_{pa,ab}$, $R_{ab,ac}$ all carry a character nontrivial on $H_J$). The mathematics is right once the definition is stated.

## Item 6, step 5 and item 3

- Frame: $\varphi_{23},\varphi_{31},\varphi_{12}$ are orthonormal. $x\wedge y=\sum_{p<q}(x_py_q-x_qy_p)\varphi_{pq}$ has $\varphi_{23}$-coefficient $x_2y_3-x_3y_2$, $\varphi_{31}$-coefficient $x_3y_1-x_1y_3$ (sign from $\varphi_{31}=-\varphi_{13}$), $\varphi_{12}$-coefficient $x_1y_2-x_2y_1$. That is $x\times y$.
- **Gap (C4a).** The wedge map $\mathbb R^J\times\mathbb R^J\to\Lambda^2\mathbb R^J$ and the bracket on $\Lambda^2\mathbb R^J$ are different maps, so "carries $x\wedge y$ to $x\times y$, so the bracket becomes the cross product" is a non sequitur. The conclusion is true: the formula gives $[\varphi_{23},\varphi_{31}]=-\delta_{33}\varphi_{21}=\varphi_{12}$ and $[\varphi_{31},\varphi_{12}]=-\delta_{11}\varphi_{32}=\varphi_{23}$, with the third following in the same way.
- $c(u,v,w)=\det(u,v,w)=\pm1$ on distinct members of an orthonormal basis, so $\langle R_J,R_J^\#\rangle=\tfrac12\cdot6\,\mu_1\mu_2\mu_3=3\det S$. At $S=I$, $P=6=2\cdot3=P(\mathrm{id})$ at $n=3$.
- $Mx\times My=\operatorname{cof}(M)(x\times y)$ with $\operatorname{cof}M=(\operatorname{adj}M)^{\mathsf T}$, equal to $\operatorname{adj}M$ for symmetric $M$. Since $V_a$ and the frame use the same coordinates, $\Lambda^2M_a$ has matrix $\operatorname{adj}M_a$ and $\operatorname{tr}(R_J\Lambda^2M_a)=\operatorname{tr}(S\operatorname{adj}M_a)$.
- $\rho$ entry by entry: $\rho_{11}=\langle R\varphi_{12},\varphi_{12}\rangle+\langle R\varphi_{13},\varphi_{13}\rangle=S_{33}+S_{22}$. $\rho_{12}=\langle R\varphi_{13},\varphi_{23}\rangle=\langle R(-e_2),e_1\rangle=-S_{12}$. $\rho_{13}=\langle R\varphi_{12},\varphi_{32}\rangle=-S_{13}$. $\rho_{23}=\langle R\varphi_{21},\varphi_{31}\rangle=-S_{23}$. $\rho_{22}=S_{11}+S_{33}$, $\rho_{33}=S_{11}+S_{22}$. So $\rho(S)=(\operatorname{tr}S)I-S$.
- **Gap (C4b).** "Every symmetric operator on $\Lambda^2\mathbb R^3$ satisfies Bianchi" is given no reason in step 5. The reason is that four indices from a set of three repeat one, so step 4's repeated-index case applies.
- Inversion: the trace of $(\operatorname{tr}S)I-S=-N$ is $2\operatorname{tr}S=-\operatorname{tr}N$, so $S=(\operatorname{tr}S)I+N=N-\tfrac12(\operatorname{tr}N)I$. Right, and `ricciJ_inverse` proves both directions.

## Item 7, Gate 1

- (a) $6+12m+5m(m-1)+\tfrac12m(m-1)(m-2)=\tfrac12m^3+\tfrac72m^2+8m+6=\tfrac12(m+3)(m+2)^2$ identically, and $(n-1)\binom n2$ at $n=m+3$ is this. It is true for all $m$ (and $m=0$ gives $6$). **Wording (C5):** the numbers $6$, $12$, $10$ are item 1 at $k=3$, so "item 1 reads" should say so. The general-$k$ version is in item 4 above.
- (b) At diagonal $S=\operatorname{diag}(K_{23},K_{13},K_{12})$ and $M_a=\operatorname{diag}(K_{1a},K_{2a},K_{3a})$: $\operatorname{tr}S^3+3\det S$ gives the $J$ cubes and the $JJJ$ triangle. $3\operatorname{tr}(S\operatorname{adj}M_a)=3(K_{23}K_{2a}K_{3a}+K_{13}K_{1a}K_{3a}+K_{12}K_{1a}K_{2a})$ gives the $JJA$ triangles. $K_{ab}^3+3K_{ab}\sum_pK_{pa}K_{pb}$ gives the $JAA$ triangles. The last term gives $AAA$. And $\tfrac12\langle K^2,K\rangle=\tfrac12\sum_{i,j,l}K_{ij}K_{jl}K_{li}=3\sum_{i<j<l}K_{ij}K_{il}K_{jl}$. True. "Item 3 becomes" refers to item 3's polynomial with $S$ free, since a diagonal $W$ is generally not Weyl.
- (d) At $J=\{j,k\}$: $\rho_{jj}=\rho_{kk}=K_{jk}$ and $\rho_{jk}=0$ (its only terms carry $\varphi_{jj}$ or $\varphi_{kk}$), so item 2 reads $\sum_aM_a=-K_{jk}I$. In L224's coordinates $W=E+D^-_y+\nu_x$, $E$ is swap-even and contributes to $M_a$ only through its trace. $D^-_y$ gives $\operatorname{diag}(y_a,-y_a)$, and $\nu_x$ gives off-diagonal entries proportional to $x_a$. The traceless part of $\sum_aM_a$ vanishes exactly when $\sum y=\sum x=0$, which is L224's step 1 ($D^-_y\in\mathcal D_n$ exactly when $\sum y=0$, and $x\in\{\sum z=0\}$). True, and only zero sets matter, so the normalisation of $\odot$ plays no role.

## Item 8, Lean

- **`blockCoeff` against item 3, case by case.** $\varphi_{pq}=\sum_x\varepsilon_{pqx}e_x$ in the frame, since $\varepsilon_{120}=\varepsilon_{201}=\varepsilon_{012}=1$ in 0-indexing. So $W_{pq,rs}=\sum\varepsilon_{pqx}\varepsilon_{rsy}S_{xy}$, and `eps` as the determinant of rows $e_p,e_q,e_x$ is the Levi-Civita symbol. The four mixed cases are $W_{pa,qb}=\delta_{ab}M_{pq}$, $W_{ap,qb}=-W_{pa,qb}$, $W_{pa,bq}=-W_{pa,qb}$, $W_{ap,bq}=W_{pa,qb}$, as coded. The outer case gives $K_{ab}$ at $(a,b,a,b)$ and $-K_{ab}$ at $(a,b,b,a)$, with $a\ne b$ guarded. Every other pattern ($R_{pq,ra}$, $R_{pa,bc}$, $R_{ab,pq}$, off-diagonal outer) is $0$. It matches item 3 and the screen script's `hodge` table.
- **The $\tfrac14$.** `inner2 (phi i j) (phi i' j')` $=\delta_{ii'}\delta_{jj'}-\delta_{ij'}\delta_{ji'}$. With antisymmetry of `blockCoeff` in each pair (the first pair needs `hK` in the outer case), `inner2 (blockOp φ_ij) φ_kl` $=$ `blockCoeff i j k l`. This is `skew_expand`'s $\tfrac12$ times the $\tfrac12$ of the ordered-pair expansion of $W\varphi_{ij}$. Right.
- **The `sorry` statements.** They are true and not vacuous: all hypotheses are satisfiable. `hS` is needed in `Ric_blockOp_J` because without it the $J$ contraction gives $(\operatorname{tr}S)\delta_{pq}-S_{qp}$. `hK` is needed in `Pcubic_blockOp` and in `Ric_blockOp_outer`, where the contraction gives $\tfrac12(K_{ab}+K_{ba})$. `hK0` is needed in `Ric_blockOp_outer` because $\sum_b$ includes $b=a$. `hK0` is redundant in `Pcubic_blockOp` and `normSq_blockOp`, which is harmless.
- **Correction (C6).** They do not "state items 1 to 3". `Pcubic_blockOp` is item 1 at $k=3$ in the frame, with item 3's identities for $P(R_J)$ and $\Lambda^2M$, and $S$ free (no substitution). `normSq_blockOp` is the Setting's norm formula. `Ric_blockOp_J` and `Ric_blockOp_outer` are the diagonal Ricci entries of item 2 at $k=3$. Untyped: the Bianchi clause, the vanishing of $\operatorname{Ric}_{pa}$ and $\operatorname{Ric}_{ab}$, the symmetry and $\Lambda^2$-preservation clauses of `IsWeyl`, and every $k\ne3$. Also, the `sorry`s are plain `sorry` inside named theorems.
- **Proved lemmas.** `ricciJ_inverse` is step 5's inversion (both directions). `cubicJ_diagonal` and `coupling_diagonal` are Gate 1 (b)'s $JJJ$ and $JJA$ terms. `blockP_identity` is Gate 1 (a)'s polynomial at $m=3$ evaluating to $75$. The link to $P(\mathrm{id})$ passes through the unproved `Pcubic_blockOp`, which is consistent with the paragraph's wording.
- **Build and axioms.** `lake build HamiltonsCubic.Results.L226Statement` succeeds with exactly four `declaration uses sorry` warnings (lines 68, 75, 83, 90). `#print axioms`: `Pcubic_blockOp`, `normSq_blockOp`, `Ric_blockOp_J`, `Ric_blockOp_outer` depend on `[propext, sorryAx, Classical.choice, Quot.sound]`. `ricciJ_inverse`, `cubicJ_diagonal`, `coupling_diagonal`, `blockP_identity` depend on `[propext, Classical.choice, Quot.sound]`. As stated.
- **Screen, not evidence.** A literal numpy transcription of `blockCoeff`, `blockOp`, `sharpQF`, `sharpBil`, `sharpOp`, `innerOp` and `Ric` (ordered sums, `inner2` with its $\tfrac12$), run on one random symmetric $S$, $M_a$, $K$ at each $m=0,1,2,3$, gave `Pcubic` equal to `blockP` to ten digits. The two Ricci statements and `normSq_blockOp` had residuals below $4\cdot10^{-15}$, and every off-block Ricci entry was $0$. It screens the reading above and establishes nothing by itself.

## Item 9, scope and counterexamples

- $m=0$ ($J=[n]$): items 1 and 2 reduce to $P(W)=P(R_J)$ and Bianchi with $\rho(R_J)=0$, both trivially true. At $n=k=3$, $N=0$ forces $S=0$, consistent with $\mathcal W_3=0$. At $n=k=2$, $\rho=K_{jk}I=0$.
- $m=1$: no pair or triangle terms, and the outer condition reads $\operatorname{tr}M_a=0$. True.
- $k\ge2$ is used only so that $\Lambda^2\mathbb R^J$ exists. At $k=2$ it is one line with $\langle R_J,R_J^\#\rangle=0$ and $\Lambda^2M=\det M$, and item 1 holds (hand check $(2,1)$ above).
- No $W$ violates item 1 or item 3: every step checks, and so do the hand checks at $\mathrm{id}$ for general $k$ and the diagonal route (b).
- **Correction (C7), "What it gives".** "The blocks meet the frames of the others in two ways only" omits that $S=N-\tfrac12(\operatorname{tr}N)I$ enters $\operatorname{tr}S^3+3\det S$ and the unit-sphere norm $\lvert S\rvert^2$ as well as the adjugate term. $\operatorname{tr}N^3$ contains $\operatorname{tr}(M_aM_bM_c)$ and $\lvert N\rvert^2$ contains $\operatorname{tr}(M_aM_b)$, both frame couplings among blocks.

## Proposed corrections

**C1 (Setting, definition of $\mathcal S_J$).** Before "By the block note, $W\in\mathcal S_J$ is block-diagonal", insert: "Here $\mathcal S_J$ is the fixed space of $H_J$ in the symmetric operators on $\Lambda^2\mathbb R^n$. The block note's character argument uses no Weyl condition and gives the same block form on it, and the block note's $\mathcal S_J$ is $\mathcal S_J\cap\mathcal W_n$ in this notation."

**C2 (step 2).** After "$[\varphi_{ab},\varphi_{ac}]=\varphi_{bc}$," insert "$[\varphi_{pq},\varphi_{ra}]=\delta_{pr}\varphi_{qa}-\delta_{qr}\varphi_{pa}$, $[\varphi_{pq},\varphi_{rs}]\in\Lambda^2\mathbb R^J$,".

**C3 (step 3).** Replace "$v_\beta\wedge v_\gamma$ is a unit eigenvector of $\Lambda^2M_a$ with eigenvalue $\lambda_\beta\lambda_\gamma$, and these span $\Lambda^2\mathbb R^J$ over $\beta<\gamma$" with "$v_\beta\wedge v_\gamma$ is an eigenvector of $\Lambda^2M_a$ with eigenvalue $\lambda_\beta\lambda_\gamma$, and since $\langle x\wedge y,u\wedge v\rangle=\langle x,u\rangle\langle y,v\rangle-\langle x,v\rangle\langle y,u\rangle$ these form an orthonormal basis of $\Lambda^2\mathbb R^J$ over $\beta<\gamma$".

**C4 (step 5).** (a) Replace "carries $x\wedge y$ to $x\times y$, so the bracket of $\Lambda^2\mathbb R^J$ becomes the cross product" with "carries $x\wedge y$ to $x\times y$, and the bracket formula gives $[\varphi_{23},\varphi_{31}]=\varphi_{12}$ and its cyclic images, so the bracket of $\Lambda^2\mathbb R^J$ becomes the cross product". (b) Replace "Every symmetric operator on $\Lambda^2\mathbb R^3$ satisfies Bianchi." with "Every symmetric operator on $\Lambda^2\mathbb R^3$ satisfies Bianchi, since four indices from a set of three repeat one and step 4's repeated-index case applies."

**C5 (Gate 1 (a)).** Replace "item 1 reads" with "item 1 at $k=3$ reads".

**C6 (Lean paragraph).** Replace "`Pcubic_blockOp`, `normSq_blockOp`, `Ric_blockOp_J` and `Ric_blockOp_outer` state items 1 to 3 against the base layer and carry named `sorry`s, the bracket computation of steps 2 to 5." with "`Pcubic_blockOp` states items 1 and 3 at $k=3$ with $S$ free, `normSq_blockOp` the Setting's norm, and `Ric_blockOp_J` and `Ric_blockOp_outer` the diagonal Ricci entries of item 2 at $k=3$, each against the base layer and each closed by `sorry`, the bracket computation of steps 2 to 5. Out of scope of the file: the Bianchi clause, the vanishing of $\operatorname{Ric}_{pa}$ and $\operatorname{Ric}_{ab}$, and $k\ne3$."

**C7 ("What it gives").** Replace "The blocks meet the frames of the others in two ways only: through $3\operatorname{tr}(S\operatorname{adj}M_a)$ with $S$ fixed by $\sum_bM_b$, and through $3K_{ab}\operatorname{tr}(M_aM_b)$." with "The blocks meet the frames of the others in two ways: through $S=N-\tfrac12(\operatorname{tr}N)I$, which enters $\operatorname{tr}S^3+3\det S$, every $3\operatorname{tr}(S\operatorname{adj}M_a)$ and the norm $\lvert S\rvert^2$, and through $3K_{ab}\operatorname{tr}(M_aM_b)$."

## Process note

The skeleton commit 7b058ed2 also carried `plan.md`, which another session had staged before this reviewer's `git add`. It was not amended. The coordinator confirmed it needs no action, and later commits of this report are by pathspec.
