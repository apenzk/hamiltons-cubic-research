# The block structure of $\mathrm{Sym}^3(\mathcal W_5)$

The certificate route at $n=5$ asks whether $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ is a sum of squares on $\mathcal W_5$. Because $O(5)$ acts, the Gram matrix of such a certificate is block-diagonal over the isotypic components of $\mathrm{Sym}^3(\mathcal W_5)$, and this file holds that decomposition together with the objects it needs.

## The Weyl module and the group action

$\mathcal W_5$ is the $O(5)$-irreducible $[2,2]$, of dimension $35$, realised as $\Lambda^2\mathbb R^5\to\mathrm{Sym}^2(\Lambda^2)\to$ first Bianchi $\to$ Ricci-traceless. **The highest weight is $4\omega_2$ rather than $2\omega_2$**: in $B_2=\mathfrak{so}(5)$ the fundamental weight $\omega_2$ is the *spin* weight, so $[2,2]=2e_1+2e_2$ solves to $4\omega_2$. A dimension check cannot separate this from $\omega_1+2\omega_2=[2,1]$, which also has dimension $35$; the Casimir does, at $16$ against $12$.

$\mathfrak{so}(5)$ acts by derivation, and the action is exact over $\mathbb Q$ in [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py): the homomorphism holds on all $45$ generator pairs with residual $0$, and the Casimir is $16\cdot\mathrm{Id}$ with every off-diagonal entry exactly zero.

**The Casimir value alone does not establish that the action is an action, and there is a proof rather than an anecdote.** *Reviewer 177.* **$C=-\sum_a\rho(A_a)^2$ depends only on the squares, so negating a single generator leaves $C=16\cdot\mathrm{Id}$ exactly while breaking $12$ of the $45$ Lie relations**, a two-line construction, reproduced in [negated_generator.py](../scripts/reviewers/r177/negated_generator.py). **The bracket check is what tests the action.** The eigenvalue is a similarity invariant and survives a change of basis, so it likewise carries no information about orthonormality.

The normalisation is $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$, which is *positive* definite on the compact real form ($\operatorname{tr}(X^2)=-2$ for $X=E_{12}-E_{21}$) so $\{E_{ij}-E_{ji}\}$ is $B$-orthonormal and self-dual, each $\rho(X_a)$ is skew, and $\rho(X_a)^2$ is negative semi-definite. **The minus in $C=-\sum_a\rho(A_a)^2$ is what makes $\langle\lambda,\lambda+2\rho\rangle=+16$ come out positive.** Neighbouring conventions give $32$, $8$, $8/3$ and $4$; the $8/3$ is [Killing](conventions.md), since $B_K=(N-2)\operatorname{tr}=3\operatorname{tr}=-6B$ and the Casimir scales inversely.

#### Observation L83, the $24$-block table, with one external closure ($7770$)

*Audited in [ROUND_L83](../verification/ROUND_L83.md): `HYPOTHESIS-DEBT`, relabelled.*

**The table below is an `Observation` at $n=5$, and its arithmetic is proved.** The twenty-four highest weights and their multiplicities in $\mathrm{Sym}^3(\mathcal W_5)$ come from the character computation in [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), and no argument on file derives them. **Proved by hand from the labels**: every dimension from Weyl's $B_2$ formula $\dim V_{(a,b)}=\tfrac16(2a+3)(2b+1)(a-b+1)(a+b+2)$ in the basis $\lambda=ae_1+be_2$, the Casimir $c_2(\lambda)=a(a+3)+b(b+1)$ at $\rho=(\tfrac32,\tfrac12)$, and the sums $24$, $\sum m_\lambda d_\lambda=7770=\binom{37}3$, $\sum m_\lambda=41$, $\sum\binom{m_\lambda+1}2=65$ and $4125$.

**Only $7770$ checks the table against anything outside it.** $24$, $41$ and $65$ are moments of the multiplicity column, and exchanging the multiplicities of the two dimension-$35$ blocks, $(2,2)$ and $(2,1)$, leaves all four sums unchanged. *Reading $SO(5)$ labels as the $O(5)$ block table uses that $-I$ acts trivially on $\mathcal W_5\subset(\mathbb R^5)^{\otimes4}$, and the unknowns column uses that every block is of real type.*

## The 24 blocks

The dimension and Casimir columns are arithmetic on the highest weights: the Weyl dimension formula for $B_2$ is a product of four linear factors, and $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$. The weight list and the multiplicities come from the character computation. [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py).

| mult | blocks (highest weight, dimension) | unknowns |
|---|---|---|
| $4$ | $(4,2)_{220}$, $(2,2)_{35}$ | $20$ |
| $3$ | $(3,2)_{105}$ | $6$ |
| $2$ | $(5,2)_{390}$, $(4,3)_{231}$, $(4,4)_{165}$, $(4,1)_{154}$, $(3,1)_{81}$, $(4,0)_{55}$, $(2,1)_{35}$, $(3,0)_{30}$, $(2,0)_{14}$ | $27$ |
| $1$ | $(6,6)_{455}$, $(6,4)_{810}$, $(6,3)_{770}$, $(6,2)_{625}$, $(6,0)_{140}$, $(5,4)_{429}$, $(5,3)_{455}$, $(5,1)_{260}$, $(5,0)_{91}$, $(3,3)_{84}$, $(1,0)_{5}$, $(0,0)_{1}$ | $12$ |

The table has $24$ blocks, $\sum m_\lambda d_\lambda=7770=\binom{37}3$ exactly, multiplicities summing to $41$ and unknowns to $65$, of which only $7770$ is an external check. The twelve multiplicity-$1$ dimensions sum to $4125$.

**The trivial multiplicity is $1$ here**, which agrees with the Lovelock relation $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ on $\mathcal W_5$ ([bispectral.md](bispectral.md)): the cubic invariants are then spanned by $\operatorname{tr}(W^3)$ once the two contractions span them. *That spanning, and $\operatorname{tr}(W^3)\not\equiv0$ on $\mathcal W_5$, are owed.*

#### Lemma L84, Casimir separation is forced, the pair $(C_2,C_4)$ with $C_4$ a quartic generator separates all $24$

*Audited in [ROUND_L84](../verification/ROUND_L84.md): `PROVEN, hypotheses corrected`.*

**Statement.** Let $C_2$ be the quadratic Casimir of $\mathfrak{so}(5)$ and $C_4$ a central element of degree four in $U(\mathfrak{so}(5))$ with $C_4\notin\mathbb R[C_2]$. Then the pair of eigenvalues $\big(\chi_\lambda(C_2),\chi_\lambda(C_4)\big)$ determines every dominant $B_2$ weight $\lambda$, and in particular separates the $24$ labels of Observation L83. *It is an $SO(5)$ statement about labels, and it does not depend on that table's multiplicities.*

## Separation of the blocks, which is a theorem

The degree-two Casimir takes **$21$** distinct values across the $24$ blocks, $24$ less the three colliding pairs: $(4,1)$ with $(3,3)$ at $30$, $(4,3)$ with $(5,0)$ at $40$, and $(5,4)$ with $(6,2)$ at $60$.

**Proof.** By the Harish-Chandra isomorphism a central element $z$ acts on $V_\lambda$ by $\gamma(z)(\ell)$, $\ell=\lambda+\rho$, $\rho=(\tfrac32,\tfrac12)$, where $\gamma(z)$ is a $W(B_2)$-invariant polynomial, $\gamma$ is injective, and the $W(B_2)$-invariants are $\mathbb R[p_2,p_4]$ with $p_{2k}(\ell)=\ell_1^{2k}+\ell_2^{2k}$. So $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$, and $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ with $a\ne0$, since $a=0$ would put $\gamma(C_4)$ in $\gamma(\mathbb R[C_2])$ and, $\gamma$ being injective, $C_4$ in $\mathbb R[C_2]$. Hence $\big(\chi_\lambda(C_2),\chi_\lambda(C_4)\big)$ determines $\big(p_2(\ell),p_4(\ell)\big)$. For a dominant weight $\ell_1>\ell_2>0$, so $e_1=p_2$ and $e_2=(p_2^2-p_4)/2$ recover $\{\ell_1^2,\ell_2^2\}$ as a multiset, hence $\ell$ and $\lambda$. $\square$ **No quartic generator is distinguished, and every one serves.** On the three pairs $p_4$ reads $7361/8$ against $4481/8$, $8521/8$ against $14281/8$, and $17561/8$ against $25625/8$.

**The generator condition is needed.** $C_2^2$ is a central element of degree four lying in $\mathbb R[C_2]$, and it separates none of the three colliding pairs, reading $(30,900)$ on both $(4,1)$ and $(3,3)$.

#### Observation L85, $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, a machine count

*Audited in [ROUND_L85](../verification/ROUND_L85.md): `HYPOTHESIS-DEBT`, relabelled.*

**The count is an `Observation`.** $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ is the output of [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), and no argument on file derives it or the degree-$3$ to degree-$5$ values beside it. **Only degree $2$ is argued**: $\mathcal W_n$ is an absolutely irreducible real $O(n)$-module, so $\dim(\mathrm{Sym}^2\mathcal W_n)^{O(n)}=1$ at every $n\ge4$.

## The constraint count

An SOS certificate faces one equation per basis invariant sextic, so the constraint count is $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$. By Weyl integration in exact Laurent polynomials, $\dim V^G=\tfrac1{|W|}\mathrm{CT}\big[\chi\prod_\alpha(1-t^\alpha)\big]$, with $\mathrm{Sym}^k$ characters from the power sums $p_j(t)=\chi(t^j)$ by Newton, the script returns **$14$** for the connected group $SO(5)$ ([run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py)). The $O(5)$ count is the same at every degree, since $O(5)=SO(5)\times\{\pm I\}$ and $-I$ acts on $\mathcal W_5\subset(\mathbb R^5)^{\otimes4}$ by $(-1)^4=1$.

The script's sequence at $n=5$ is $1,1,4,5,14$ for degrees $2$ through $6$, against stable-range values $1,2,7,19,89$ that carry no source on file. At degree $2$ the two agree, both being $1$; from degree $3$ on the $n=5$ values are the smaller. The degree-$3$ value $1$ agrees with the Lovelock relation $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ at $n\le5$.

## The 41 highest-weight vectors

Built over $\mathbb Q(i)$, every block matching the table, in $86$ seconds. [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) complexifies, splits $\mathcal W_5$ into its $35$ joint Cartan eigenspaces, finds the two simple root vectors by diagonalising the adjoint action on $\mathfrak{so}(5)\otimes\mathbb C$, and intersects the kernels of both raising operators on each block's weight space.

**The largest weight space is $234$, at weight $(0,0)$**, that, rather than the $7770$ basis vectors or the largest multiplicity, is what prices the projection.

#### Lemma L86, the parity rule $\dim V_\lambda^H=1\iff\lambda_2$ even, and the $\ge36$ unknowns it leaves

*Audited in [ROUND_L86](../verification/ROUND_L86.md): `HYPOTHESIS-DEBT`, narrowed.*

**Statement.** Let $W_0\in\mathcal W_5$ be the padded Weyl tensor of $\mathbb{CP}^2$ and $H=\mathrm{Stab}_{O(5)}(W_0)$, and let $V_\lambda$ be an $O(5)$-module with highest weight $\lambda=(\lambda_1,\lambda_2)$ **on which $-I$ acts trivially**, as it does on every constituent of $\mathrm{Sym}^3(\mathcal W_5)$. Granting the stabiliser described below, $\dim V_\lambda^H=1$ if $\lambda_2$ is even and $0$ if $\lambda_2$ is odd. On the blocks of Observation L83 an orbit-vanishing certificate therefore loses at most one multiplicity in each of the sixteen $\lambda_2$-even blocks, and has **at least $36$ unknowns**. *Exactly $36$ needs every one of those sixteen ranks to be $1$, which rests on the measured $3570$ below. **Owed**: a derivation of the stabiliser, a source for $F_5(W_0)=0$, the certificate model the reduction assumes, and the rank-one step.*

## The orbit constraint

$F_5$ vanishes on the whole $O(5)$-orbit of the padded $W_{\mathbb{CP}^2}$, so every covariant entering a certificate vanishes there, and by equivariance that is the single condition $\sigma_\lambda(W_0)=0$. $\mathrm{Stab}_{O(5)}(W_0)$ has identity component $U(2)\subset SO(4)$, two components, times the reflection on the padding axis; and the rule has a mechanism rather than a bracket. *Reviewer 178, deriving it independently of 174.*

**Branching $\mathfrak{so}(5)\to\mathfrak{so}(4)=\mathfrak{su}(2)_L\oplus\mathfrak{su}(2)_R$ leaves exactly one constituent with $j_L=0$, namely $(\mu_1,\mu_2)=(\lambda_2,-\lambda_2)$, so $j_R=\lambda_2$.** The $U(2)$-invariants are therefore *always* one-dimensional, and what decides is the extra component: $\sigma$ is the $\mathfrak{su}(2)_R$ Weyl element, which acts on the $m=0$ vector of spin $j$ by $(-1)^j$. **Hence $\dim V_\lambda^H=1$ iff $\lambda_2$ is even.** *Hand-checks: $(1,0)\mapsto1$, realised by $e_5$ in $\mathbb R^5\otimes\det$, where $-I$ acts trivially; $(1,1)\mapsto0$, the complex structure flipping sign; $(2,0)\mapsto1$; $(2,2)\mapsto1$.*

**The reflection $\varepsilon=\mathrm{diag}(1,1,1,1,-1)$ is redundant**, every constituent of $\mathrm{Sym}^3(\mathcal W_5)$ has $-\mathrm{Id}$ acting trivially, so $\varepsilon$ acts as $\mathrm{diag}(-1,-1,-1,-1,1)\in SO(5)$, which is already the scalar $-1$ in $U(2)$.

That rule selects **exactly $16$** blocks, whose dimensions sum to **$3570$**. Each loses one multiplicity, leaving **$25$ surviving multiplicities and $36$ unknowns**, shaped as **two $3\times3$, five $2\times2$ and nine scalars**. Eight of the twelve multiplicity-$1$ blocks die outright: $(0,0)$, $(1,0)$, $(5,0)$, $(5,4)$, $(6,0)$, $(6,2)$, $(6,4)$, $(6,6)$. *The counting is kernel-checked on L83's table: `card_even`, `cap_even`, `surviving_25`, `surviving_shape`, `dead_blocks` and `unknowns_36` in [L83.lean](../lean/HamiltonsCubic/Results/L83.lean).*

**THE RANK-ONE STEP IS AN INEQUALITY, AND WHAT PROMOTES IT TO AN IDENTITY IS A MEASUREMENT.** *Reviewer 177.* Frobenius reciprocity bounds the evaluation map $M_\lambda\to V_\lambda^H$ by $\dim V_\lambda^H=1$; **it does not force rank $1$ rather than rank $0$.** Taken alone, "each block loses one multiplicity" makes $36$ a *lower* bound on the unknowns, and the eight block deaths ($(5,0)$, $(5,4)$ and $(6,2)$ among them, which is where "only one pair needs the quartic" rests), become conditional.

**The record answers it, and the answer had never been stated as a dependency.** $\sum_\lambda(\mathrm{rank}_\lambda\cdot d_\lambda)$ is the dimension of the $O(5)$-submodule generated by $W_0^3$, which [r170](../reviews/REVIEW_r170.md) *measured* at $3570$ and [r178](../reviews/REVIEW_r178.md) recomputed exactly over $\mathbb F_{46337}$; the derived upper bound, [r174](../reviews/REVIEW_r174.md)'s, is the same $3570$. **The two ends are ranks of different objects, and what joins them is owed, see [L87](sym3-blocks.md).** **An upper bound attained forces every one of the sixteen ranks to be exactly $1$, so no block has rank $0$ and $36$ is exact.** *Everything downstream, the shape, the eight deaths, the two vanishing collisions, rests on that single measured number.*

**The check that would remove the dependency, now that the $41$ vectors exist:** a block has rank $1$ exactly when its highest-weight vector, read as a cubic polynomial, fails to vanish somewhere on the orbit of $W_0$. *Evaluating the $41$ at a handful of points $g\cdot W_0$ settles all sixteen at once, and needs only the inner product on $\mathcal W_5$ in the weight basis.*

#### Lemma L87, the rank-one step, the orbit Gram meets the cap, so every even block loses exactly one multiplicity

*Round [L87](../verification/ROUND_L87.md): `GAP`. The cap is a theorem, the attainment is one exact finite computation, and the argument joining them is on the record owing two steps.*

**The cap, derived.** Over the sixteen $\lambda_2$-even blocks $\sum_\lambda d_\lambda=3570$, using [L83](sym3-blocks.md)'s table, $\dim V_\lambda^H\le1$, **and [L86](sym3-blocks.md)'s odd-block vanishing**. *Both hypotheses are load-bearing*: over all $24$ blocks the first alone gives $5640$, at which the squeeze does not close, and it forces nothing even at $3570$, since $r_\lambda=1$ on the eight odd blocks together with $(6,4)$, $(6,2)$, $(2,2)$ and $(3,0)$ also sums to $3570$ with **twelve** of the sixteen evaluation maps at rank $0$.

**The attainment, computed.** The rank of the Gram matrix $\langle g_a W_0, g_b W_0\rangle^3$ over $3700$ orbit points is exactly $3570$ over $\mathbb F_{46337}$ ([orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage), [r178](../reviews/REVIEW_r178.md)), **one prime, no floating point, no tolerance chosen**, which is the run's real contribution. *The first determination is [r170](../reviews/REVIEW_r170.md)'s, at $5200$ points over $\mathbb R$ against three tolerances, confirmed by [r173](../reviews/REVIEW_r173.md); [r174](../reviews/REVIEW_r174.md) derived the cap and measured nothing; r178 supplied an independent construction of $W_0$ and exact arithmetic, having read the target number first.*

**What joins them, and the two steps it owes.** The sampled elements are Cayley transforms of skew matrices drawn **inside** $\mathbb F_p$, so they reduce from nothing and a matrix-reduction warrant has nothing to reduce. [r682](../reviews/REVIEW_r682.md) supplies the replacement: $W_0$ is integral, $SO_5$ is smooth over $\mathbb Z[\tfrac12]$, and with $\Lambda\colon f\mapsto(g\mapsto f(gW_0))$ the matrix $L$ depends on the group scheme and $W_0$ alone (**never on a sampled element**) so one matrix reduces both ways and $\operatorname{rank}(L_{\mathbb F_p})\le\operatorname{rank}(L_{\mathbb Q})=\dim U$. **Owed: a finitely generated free $M$ with $\operatorname{im}\Lambda\subseteq M\subseteq\mathbb Z[\tfrac12][SO_5]$**, the coordinate ring being neither finitely generated nor graded; **and Zariski density of $SO(5,\mathbb R)$ in $SO_{5,\mathbb C}$**, which is what the $k=\mathbb Q$ end actually consumes where reducedness is written. *[r681](../reviews/REVIEW_r681.md) gives a second route, by an integral Cayley lift.* The sample lies in $SO_5(\mathbb F_p)$, the Cayley transform forcing $\det g=1$ in every characteristic.

**Open, and it would replace the rank entirely.** The check [L86](sym3-blocks.md) names, evaluating the $41$ highest-weight vectors of [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) as cubics at orbit points **over $\mathbb Q$**, settles each even block by itself, **sixteen small independent facts in place of one $3700\times3700$ rank**, with no cap and no attainment needed. *It is a run, and it is named rather than made.*

**The chain carries two measured links**, this one and [L59](../results.md)'s, through [L62](sym3-blocks.md), and every number downstream stands as written: $3570$, the $25$ multiplicities, the $36$ unknowns, the $29$, the shape, the eight block deaths and the surviving collision.

#### Lemma L88, $\dim\mathrm{Sym}^2=65$, $\dim\Lambda^2=24$, and the $24$ are gauge

*Audited in [ROUND_L88](../verification/ROUND_L88.md): `HYPOTHESIS-DEBT`, narrowed.*

**Statement, on Observation L83's multiplicities.** Write $U=\mathrm{Sym}^3(\mathcal W_5)=\bigoplus_\lambda V_\lambda\otimes M_\lambda$ under $O(5)$, with $m_\lambda=\dim M_\lambda$. Every $V_\lambda$ here is of real type: it is self-dual, $-1$ lying in the Weyl group of $B_2$, which excludes complex type, and a quaternionic $\mathfrak{so}(5)$-module has half-integral coordinates in the $e$-basis, none of which occur. So Schur's lemma gives $\mathrm{Sym}^2(U)^{O(5)}=\bigoplus_\lambda\mathrm{Sym}^2M_\lambda$ and $\Lambda^2(U)^{O(5)}=\bigoplus_\lambda\Lambda^2M_\lambda$, of dimensions $\sum_\lambda\binom{m_\lambda+1}2$ and $\sum_\lambda\binom{m_\lambda}2$, which on L83's table are $65$ and $24$. **An antisymmetric form vanishes on the diagonal, so the $24$ change no sextic.** *$65+24=89=\sum m_\lambda^2$ holds for every multiplicity list and checks nothing; the two numbers inherit L83's standing as an Observation.*

## The unknown count is real symmetric, and a Hermitian ansatz over $\mathbb Q(i)$ inflates it

An SOS Gram is an invariant **quadratic form** on $\mathrm{Sym}^3(\mathcal W_5)$, so the unknowns are $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$, a dimension rather than a basis convention. Weyl integration computes it in [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py), touching none of the certificate machinery: no adapted basis, no cache, no prime, no highest-weight vectors.

$$\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}=65,\qquad \dim\Lambda^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}=24,\qquad 65+24=89,$$

and those are exactly $\sum m(m+1)/2$, $\sum m(m-1)/2$ and $\sum m^2$ on Observation L83's multiplicities, twelve blocks with $m=1$, nine with $m=2$, one with $m=3$, two with $m=4$. **The $24$ directions a Hermitian ansatz offers beyond the $65$ are the antisymmetric invariants**: an invariant Hermitian form restricted to real vectors splits uniquely as $S+iA$ with $S$ real symmetric and $A$ real antisymmetric, both invariant, so the $89$ Hermitian directions are the $65$ symmetric ones and $i$ times the $24$ antisymmetric ones. An antisymmetric form contributes nothing to a quadratic, hence nothing to the sextic, so those $24$ are gauge for the map from Gram to sextic. *They are not free inside the positive semidefinite cone: $I+2iJ$ with $J=\begin{psmallmatrix}0&1\\-1&0\end{psmallmatrix}$ gives the sextic of $I$ and has eigenvalue $-1$.*

**THE DIMENSION IS RIGHT AND THE COORDINATES ARE NOT.** *Reviewer 204, refuting the labelling rather than the count.* That $24$ of the $89$ directions are gauge is a theorem. That they are the *imaginary* coordinates of the $\mathbb Q(i)$ highest-weight basis is **false**: the identification holds only in a basis real for the real structure $\sigma$, and such a basis forces $h$ real symmetric, while $h$ is *measured* non-real on $\lambda=(2,0)$. On a multiplicity-$2$ block the kernel direction is the imaginary coordinate only if $\operatorname{Im}h=0$, and over $4000$ bases consistent with the measured $h$ the relative distance never fell below $0.541$. **The converse fails too**: $Q=\mathrm{diag}(1,i)$ gives $h=I$ with a real symmetric kernel direction, which the split would have kept among the $65$. Rephasing one copy by $i$ moves the split while passing the Hermitian assert, $\det h\ne0$ and the multi-probe test. *Identifying the actual $24$ needs the real structure computed on each $M_\lambda$.*

**They appear because the $41$ highest-weight vectors were built over $\mathbb Q(i)$ and are not a real basis of $M_\lambda$.** Every one of the $24$ weights is *integral* for $B_2$, hence of real type, the quaternionic representations of $\mathfrak{so}(5)\cong\mathfrak{sp}(4)$ are the half-integral spin ones, and none occur, so each multiplicity space carries a real structure and the invariant form is real symmetric in a real basis. **That $h$ is measured Hermitian with nonzero imaginary off-diagonals is the evidence that the basis in hand is not that one**, and it is not a contradiction: reviewer 192's $h=\begin{psmallmatrix}1&55i/37\\-55i/37&5075/1628\end{psmallmatrix}$ on $(2,0)$ is reproduced exactly by reviewers 201 and 202.

#### Lemma L89, $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$, nullity $51$, by exactness of the invariants functor

*Audited in [ROUND_L89](../verification/ROUND_L89.md): `HYPOTHESIS-DEBT`, narrowed.*

**Statement.** Let $\mu:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ be multiplication. Then $\mu$ restricted to $O(5)$-invariants is onto $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, so its rank is $\dim(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ and its nullity is $\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}$ less that rank. **With Observation L85's $14$ and L88's $65$, which rests on Observation L83's table, these are $14$ and $51$**, and the two values carry those Observations' standing.

## The rank of multiplication on invariants is the invariant sextic dimension

**Proof.** $\mu$ is onto: a degree-$6$ monomial $x^a$, $\lvert a\rvert=6$, is a product $x^bx^c$ of two degree-$3$ monomials, taking any three of its six variable slots for $b$, so every monomial is in the image. $\mu$ is $O(5)$-equivariant, being multiplication of polynomials. $O(5)$ is compact, so averaging over it, the Reynolds operator $R$, is an equivariant projection onto invariants on both sides, and for an invariant $f$ in the target, $f=\mu(g)$ gives $f=R f=R\mu(g)=\mu(Rg)$ with $Rg$ invariant. So $\mu$ restricted to invariants is onto, and rank and nullity follow. $\square$

$$\operatorname{rank}(\mu|_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)},\qquad\text{which is }14\text{ with nullity }65-14=51\text{ on the two Observations.}$$

**The sampled coefficient matrix $A$ of the pipeline is a different object.** Evaluating at a finite set of points gives $\operatorname{rank}(A)\le\operatorname{rank}(\mu|_{\mathrm{inv}})$, with equality exactly when the points separate the invariant sextics, and a degenerate sample makes it smaller: at the single point $0$ every sextic vanishes and $A=0$. So the sampled rank check stays: the theorem says what its answer must be when the sample separates.

## $M(5)=\sqrt{3/2}$, an exact rational SOS certificate

$F_5=(3/2)\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ is a sum of squares of cubics vanishing on the orbit of $W_0$, exhibited by a Gram with **rational** entries in [n5_certificate.json](../scripts/runs/n5_certificate.json), whose denominators reach $5\times10^{16}$, the file's `denominator` field names the rounding imposed on the kernel coefficients, not the point. The positive-definiteness is exact over $\mathbb Q$; the identity rests on an exact mod-$p$ rank of the evaluation matrix at the same $40$ points, **not** on the float singular-value rank the pipeline prints beside it.

| step | how it is exact |
|---|---|
| the rows | lifted from **four** primes near $2^{40}$, $164$ bits, CRT and rational reconstruction, reviewer 211 verified uniqueness with margin $2.26\times10^{-14}$ |
| the family | exact particular solution plus an exact $34$-dimensional kernel, each checked against all $40$ equations |
| membership | **by construction**, being a rational combination of exact generators, rather than approximately |
| positive definiteness | two routes sharing no code, Sylvester minors, and characteristic polynomials with alternating coefficients in [run_n5_verify.py](../scripts/runs/run_n5_verify.py) |

#### Lemma L90, evaluation is injective on the image

*Audited in [ROUND_L90](../verification/ROUND_L90.md): `HYPOTHESIS-DEBT`, narrowed.*

**Statement, conditional on one measured rank.** Let $K$ be the cubics with $\sigma_\lambda(W_0)=0$, $\mu_K$ the map from invariant Grams on $K$ to sextics, and $\mathrm{ev}$ evaluation at a finite point set $S$. Then $\ker(\mathrm{ev}\circ\mu_K)\supseteq\ker\mu_K$, so $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=\mathrm{rank}\,\mu_K$ makes $\mathrm{ev}$ injective on $\operatorname{im}\mu_K$, and a sextic in the image agreeing with $F_5$ on $S$ is then $F_5$. **The cap $\mathrm{rank}\,\mu_K\le13$ is proved**: a product of two cubics of $K$ vanishes at $W_0$, and evaluation at $W_0$ is a nonzero functional on the invariant sextics. **The lower bound $\mathrm{rank}(\mathrm{ev}\circ\mu_K)\ge13$ at the certificate's $40$ points is a rank computed modulo a prime**, and reading it as the rational rank needs three hypotheses on file nowhere: that the restricted space modulo $p$ is the reduction of the rational one, that every denominator is invertible modulo $p$, and that the sampled points are the certificate's. Granting it, $13\le\mathrm{rank}(\mathrm{ev}\circ\mu_K)\le\mathrm{rank}\,\mu_K\le13$, both ranks equal $13$, and the conclusion holds.

**Why $40$ equations give an identity, which is the load-bearing step.** Satisfying the map's equations at $40$ points is agreement of polynomials at $40$ places, not equality, unless evaluation is injective on the image. Writing $\mu$ for the Gram-to-sextic map and $\mathrm{ev}$ for evaluation, $\ker(\mathrm{ev}\circ\mu)\supseteq\ker\mu$ always, while the cap gives $\mathrm{rank}(\mathrm{ev}\circ\mu)\le\mathrm{rank}\,\mu\le13$ and the rank measured at those points gives $13$. Equal dimensions force equal kernels, so $\mathrm{ev}$ is injective on the image and a sextic there is pinned by those $40$ values. $F_5$ lies in the image, so the unique element agreeing with it at those points **is** $F_5$.

**Two audits of the certificate's positive semidefinite point found real errors.** Reviewers 211 and 212, independently and two minutes apart, refuted the first point: the dump ordered blocks by $\lambda$ while the consumer ordered them by $(-m,\lambda)$, so the $47$ columns were partitioned wrongly and the reported point had minimum eigenvalue $-1440$. Corrected, the optimum is $t=2.34\times10^{-2}$, strictly positive and interior. **And the first acceptance test was itself wrong**: an inline LDL passed the denominator-$10^4$ point, whose second block has third leading minor $-3.47\times10^{-4}$, the same defect reviewers 181 and 182 had found in [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py)'s `ldl_psd`, reintroduced. *A false certificate is the one error here that would not announce itself, which is why the accepted point is verified by a file that shares no code with the one producing it.*

**THE RESTRICTED RANK IS MEASURED AT $13$, AND THE NECESSARY CONDITION FOLLOWS FROM IT.** The restricted sampled rank attains the derived cap: $13$ at $40$ points mod $1000033$, and reviewer 209 reproduced it independently at $p=1000003$ (which is $3\bmod4$, so $\mathbb F_p[i]$ is a field rather than a split algebra), with its own code, its own points, and $T$ rebuilt from three different positions. Sampling only loses rank, so a rational rank of $13$ at the points forces equality with the cap; reading the modular rank as that rational rank needs the restricted space modulo $p$ to be the reduction of the rational one.

$$\mathrm{rank}=13,\qquad \dim\mathrm{ANN}=1,\qquad \mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6),\qquad \boxed{F_5\ \text{lies in the image}}$$

since $F_5\perp\mathcal A(W_0^6)$ because $F_5(W_0)=0$, exact over $\mathbb Z$ in both normalisations. **The affine family is $36-13=23$ dimensional**, on L86's $36$, and reviewer 208's numerical determination (gap $425$–$458$, kernel at $0.02°$) is confirmed by exact arithmetic.

**Three things the cap argument needs, each found by an audit rather than stated in advance.**

- **The rank cap is conditional on equivariance.** The sampled row is $\mu^*(\mathrm{ev}_W)$ only when the copies are identified equivariantly; reviewer 209 exhibited $S_3$ on $\mathbb R^3$ where giving one copy its own position list yields sampled rank $10$ against a cap of $7$. **What guards it is the multi-probe Schur test**, which is therefore load-bearing for the rank argument and was not described as such.
- **Vanishing at $W_0$ suffices for vanishing on the orbit**, because the restriction cuts the *copy* index and leaves $V_\lambda$ whole, so the restricted cubics form an $O(5)$-submodule, and a submodule vanishing at $W_0$ vanishes at every $gW_0$. *Reviewer 210; the record had asserted the equivalence without argument.* Restricting positions instead would break it.
- **Attainment is not self-validating.** A defect landing the rank exactly *on* the cap is invisible. The three wrong restrictions were caught only by coming out *above* it, the correct condition is $Ta=0$ for the **expansion** vector $a$, **unconjugated**; the two wrong ones each carried one half, and the vectors differ by the multiplicity Gram.

**On the restricted space surjectivity does not carry, so argument alone gives $1\le\mathrm{rank}\le13$**, the measured value being $13$. The certificate ranges over the cubics $K$ satisfying $\sigma_\lambda(W_0)=0$, which do **not** span $\mathrm{Sym}^3$, so $\mu$ restricted to them need not stay onto.

- **Upper bound $13$, and it comes from order $1$.** *Reviewer 203.* A product of two cubics of $K$ already vanishes at $W_0$, and evaluation there is a nonzero functional on the $14$. What order-$2$ vanishing shows is that the bound **cannot be sharpened** by demanding more vanishing at the point, the extra condition being free.

#### Lemma L91, the identity Gram on $K$ gives $\mathrm{rank}\,\mu_K\ge1$

*Audited in [ROUND_L91](../verification/ROUND_L91.md): `HYPOTHESIS-DEBT`, narrowed.*

**Statement.** The rank of $\mu_K$, the map from the $36$ invariant Grams on $K$ to the $14$ invariant sextics, is at least $1$. *Given L90's measured rank it adds no bound, and it is kept for its witness $\Delta$.*

- **Lower bound $1$.** The identity Gram on $K$ is one of the $36$ invariant forms, the apolar product being $O(5)$-invariant and $K$ an $O(5)$-submodule, and it maps to $\Delta=\sum_aq_a^2$ over an apolar-orthonormal basis $\{q_a\}$ of $K$: a psd sum of squares of cubics of $K$, invariant and vanishing on the orbit. **$\Delta\ne0$**: $K\ne0$, its codimension in $\mathrm{Sym}^3$ being at most $3570<7770$ by L86 on Observation L83's table, so some $q_a\ne0$, and at a real $W$ with $q_a(W)\ne0$, $\Delta(W)\ge q_a(W)^2>0$. So $\mathrm{rank}\,\mu_K\ge1$. *The argument from $K\ne0$ to $\Delta\ne0$ is machine-checked as `L91_witness` in [L91.lean](../lean/HamiltonsCubic/Results/L91.lean), which uses only that the $q_a$ span $K$.*
- **$36-\mathrm{rank}$ is the dimension of the solution set only when the system is consistent**, and consistency is exactly the open necessary condition: $F_5$ must lie in the image, or the route dies.
- **Tightness reduces to one question:** $\mathrm{rank}\,\mu_K=14-\dim\{F\in(\mathrm{Sym}^6\mathcal W_5)^{O(5)}:\mathrm{Cat}_F(K,K)=0\}$, the invariant sextics annihilating $K\odot K$, a space containing the invariant average of $\mathcal A(W_0^6)$. *The derivation of that identity is owed. Given L90's measured rank $13$, the image is the hyperplane of invariant sextics vanishing at $W_0$, so consistency is the single condition $F_5(W_0)=0$, which holds.*

**$\Delta$ is a live lead for the search.** It is psd, invariant and a sum of squares of cubics of $K$ by construction. *Measured, not argued*: it appears to vanish exactly on the orbit cone, the zero set $F_5$ is conjectured to have, and $F_5/\Delta$ ranges over $[2.50,3.15]$ across twelve random unit points, so $F_5$ is not proportional to it and $F_5-\lambda\Delta$ with $\lambda\approx2.5$ is the natural recentring for a search over the $36$.

**Two of the three Casimir collisions vanish with them.** Among labels with first entry at most $6$, $c_2$ repeats only at $30$, $40$ and $60$. By L86's parity rule a $\lambda_2$-even block loses one multiplicity, so a multiplicity-$1$ $\lambda_2$-even block dies: at $c=60$ both $(5,4)$ and $(6,2)$ die, at $c=40$ the block $(5,0)$ dies and leaves $(4,3)$ alone. **Only $c=30$ survives, the pair $(4,1)$ and $(3,3)$, both with odd second label.**

#### Lemma L92, the highest-weight route needs no Casimir separation

*Gate 2, [r691](../reviews/REVIEW_r691.md) and [r692](../reviews/REVIEW_r692.md) on identical briefs, **both CONFIRMED, and both say plainly that this is one of the few blocks in the file exactly as strong as it claims**.*

> **THE ARGUMENT IS SHORT, COMPLETE, AND CONFIRMED TWICE OVER.** The simple roots are $\alpha_1=(1,-1)$ and $\alpha_2=(0,1)$ in the $e$-basis (**roots, not fundamental weights**), the surviving collision is $(4,1)$ against $(3,3)$ re-derived from scratch, and both differences carry a $-1$, so neither weight lies in the other's module. *A second, disjoint confirmation comes from the Weyl-orbit convex hull: $\lVert(3,3)\rVert^2=18>17$ kills one direction and $\lvert\mu_1\rvert\le3<4$ the other.*

> **THE BLOCK UNDERSTATES ITS OWN SUPPORT.** What proves the heading is not the root-lattice computation (which concerns two weights, where the heading concerns the construction) but **the italic aside: a weight-$\lambda$ vector killed by the raising operators generates $V_\lambda$. That argument is universal, uses nothing about $B_2$, and depends on none of [L84](sym3-blocks.md), [L87](sym3-blocks.md) or [L91](sym3-blocks.md)**, so it applies verbatim to [L63](sym3-stability.md)'s $n=12$ table. *It owes one line of complete reducibility, being a Verma-quotient argument rather than a definition.*

> **THE BASIS IS UNNAMED AND THE ONE AVAILABLE MISREADING FLIPS THE CONCLUSION**, in $\omega$-coordinates the printed difference **is** $\alpha_2$, so a reader there concludes the opposite. *It does not bite, because the block's own $\alpha$'s pin the $e$-basis, strictly better than [L83](sym3-blocks.md)'s table, whose prose eight lines above is in the other basis.*

> **THIS RETIRES [L84](sym3-blocks.md) AS A DEPENDENCY WHILE LEAVING IT UNTOUCHED AS A THEOREM.** L84 needs all $24$ separated, [L87](sym3-blocks.md) leaves one pair, and this leaves none, *though a Casimir-projector method would still need L84 in full.* **And this file settles its own question ninety-five lines above**, where the construction is described with no Casimir in it.

*The counts are misattributed to the wrong reviewer, and "non-colliding" is lossy, four of the thirteen blocks **are** colliding blocks. "Even that one" has no antecedent inside the block, its premise sitting under [L91](sym3-blocks.md)'s heading. **L92 is used nowhere**, and [routes.md](../routes.md) has no row for the $n=5$ certificate route at all, leaving twelve numbered results in no route. **Provenance clean, and better: the current text repairs a real error the origin commit made.***

**And the highest-weight route never meets even that one.** A weight $\mu$ of $V_\lambda$ satisfies $\lambda-\mu\in\mathbb Z_{\ge0}\alpha_1+\mathbb Z_{\ge0}\alpha_2$, and with $\alpha_1=(1,-1)$, $\alpha_2=(0,1)$ neither difference qualifies: $(4,1)-(3,3)=(1,-2)=\alpha_1-\alpha_2$ and $(3,3)-(4,1)=(-1,2)=-\alpha_1+\alpha_2$. **So $(3,3)$ is not a weight of $V_{(4,1)}$ and $(4,1)$ is not a weight of $V_{(3,3)}$.** *The step needs the expansion to be unique, which it is: $\alpha_1$ and $\alpha_2$ are independent, so $a=v_1$ and $b=v_1+v_2$ are forced, otherwise a difference with one negative expansion might still admit a nonnegative one. Checked in [L92.lean](../lean/HamiltonsCubic/Results/L92.lean).* *Reviewer 179 corrects two things here: the modules are not weight-disjoint, they share $45$ weights, and $44$ of the $46$ dimensions at weight $(4,1)$ come from thirteen other, non-colliding blocks, and the argument is a special case of a universal one, since a weight-$\lambda$ vector killed by the raising operators generates $V_\lambda$ by definition.* **The highest-weight construction therefore needs no Casimir to separate any block, colliding or not.**

## What the certificate would establish

**$M(5)=\sqrt{3/2}$, DECIDED, and the certificate proves it** (r279). $F_5\equiv\tfrac32\lVert W\rVert^6-P(W)^2$ **identically on $\mathrm{Weyl}_5$**, because $\langle W,W^\#\rangle=2\operatorname{tr}(W^3)$ holds at $n=4,5$ and fails from $n=6$, the Lovelock syzygy. So $F_5\ge0$, which is all the SOS gives, yields $P(W)^2\le\tfrac32$ at unit norm directly. **Degree-$3$ adequacy governs the converse and nothing needs it.** *Confirmed at $200$ ascents: $\max P=1.22474487139159$, excess $1.1\times10^{-15}$, at spectrum $(2,-1,-1,0^7)/\sqrt6$.*

**It does not lift.** Trace-word transfer needs the stable range, and $n=5$ carries the Lovelock syzygy; the cubic invariant dimension is $1$ here against $2$ from $n\ge6$.

#### Lemma L59, the certificate's linear condition, $F_5\perp\mathrm{ANN}$, and when a count decides it

*Verified `HYPOTHESIS-DEBT`, narrowed, [ROUND_L59](../verification/ROUND_L59.md); the linear algebra is machine-checked in [L59Statement.lean](../lean/HamiltonsCubic/Results/L59Statement.lean).*

**Statement.** Let $V$ be the $14$-dimensional space of $O(5)$-invariant sextics on $\mathcal W_5$ ([L85](#observation-l85-dimmathrmsym6mathcal-w_5o514-a-machine-count)) with an inner product, $B_K$ an inner product space, $\mu_K:B_K\to V$ linear, and $\mathrm{Cat}:V\to B_K$ its adjoint, $\langle F,\mu_K(b)\rangle=\langle\mathrm{Cat}\,F,b\rangle$. With $\mathrm{ANN}=\ker\mathrm{Cat}$,
\[
\mathrm{rank}(\mu_K)=14-\dim\mathrm{ANN},\qquad F_5\in\mathrm{image}(\mu_K)\iff F_5\perp\mathrm{ANN},
\]
since $\ker\mathrm{Cat}=\mathrm{image}(\mu_K)^\perp$. **The condition is $F_5\perp\mathrm{ANN}$; the dimension count decides it only when $\dim\mathrm{ANN}=0$.** The adjoint of a surjection is injective.

**The block count.** Over [L83](#observation-l83-the-24-block-table-with-one-external-closure-7770)'s multiplicities, the $\lambda_2$-even blocks carry $29$ and the odd ones $12$ of the $41$, and the forms supported on the orbit-constrained span $K$ of the orbit constraint number $36=20+16$, so $65=36+29$. *The identity holds block by block for any multiplicities, so it checks the addition and not the table.*

**Owed, and not established here.** *(i)* The concrete objects: the pairing on the sextics, the map $\mu$ from invariant symmetric forms on $\mathrm{Sym}^3$ to sextics, its restriction $\mu_K$, and $\mathrm{Cat}_F$ as a bilinear form. *(ii)* That $\ker\mathrm{Cat}$ is the set of invariant sextics $F$ with $\mathrm{Cat}_F(K,K)=0$, which needs $K$ to be $O(5)$-stable, the pairing invariant, and an averaging step from invariant forms on $K$ to all of $K\times K$. *(iii)* That the unrestricted $\mu$ is surjective onto the $14$, and that a positive semidefinite certificate forces $F_5\in\mathrm{image}(\mu_K)$, which needs its Gram form averaged to an invariant one; the positive semidefinite cone itself is a further constraint neither display touches. [L62](#lemma-l62-dimmathrmann1-so-the-rank-is-13) consumes this lemma in the abstract form stated.

#### Lemma L61, $M(5)=\sqrt{3/2}$, the global maximum on $\mathcal W_5$

*Gate 2, [r597](../reviews/REVIEW_r597.md) and [r598](../reviews/REVIEW_r598.md) on identical briefs, **both GAP and agreeing on every part**. The bound holds; its support is a machine certificate, its equality clause is unproven, and its constant is named for the wrong object.*

> **THE OBJECT PROVED IS $M(5)$, THE GLOBAL MAXIMUM, NOT $\Theta_5$, WHICH IS $2\sqrt2/3=0.9428$.** So *"$\Theta_5=\sqrt{3/2}$"* is false wherever it appears, and the heading's $\theta_5$ names nothing the record defines. This is warning **W5** (the diagonal maximum read as the global one), on its third sighting; [r474](../reviews/REVIEW_r474.md) and [r499](../reviews/REVIEW_r499.md) filed it and only the heading was changed. **[LEDGER.md](LEDGER.md) closed it as a benign collision and both reviewers argue it should reopen**, since one object is in play and six sites carry the wrong name, including [results.md](../results.md) and four report files.

> **THE IMPLICATION IS SOUND, REBUILT COLD TWICE.** $(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ is one-dimensional, so $\langle W,W^\#\rangle=c\operatorname{tr}(W^3)$; the anchor $\theta(W_0)=3/\sqrt6$ against $\operatorname{tr}(W_0^3)=1/\sqrt6$ pins $c=2$, giving $F_5=\tfrac32\lVert W\rVert^6-P^2$ and hence the bound. **[Lemma L50](bispectral.md) proves it.**

> **$F_5\ge0$ RESTS ON A CERTIFICATE, NOT AN ARGUMENT.** It is an SDP point lifted to $\mathbb Q$, 47 Hermitian parameters in a $\mathbb Q(i)$ highest-weight basis a reader must rebuild by machine before checking anything, against the file's stated 36 real-symmetric unknowns. *Exact, and unverifiable by hand even in principle.* **The same statement at $n=4$ has a five-line proof**, rigidity included: self-dual split, $\max\det$ at $(2,-1,-1)$, convexity of $s^{3/2}+(1-s)^{3/2}$. *The recorded "rational entries at denominator $10^5$" is false, 13 of 47 coordinates reach $5\times10^{16}$, as the verifying script's own header says.*

> **"EQUALITY EXACTLY ON THE ORBIT" IS ASSERTED, AND THE SOS ROUTE CANNOT SUPPLY IT.** Cubics are odd, so $F_5$ is even and its zero set always contains the orbit of $-W_0$, a different $O(5)$-orbit. **This file calls that zero set *conjectured* 29 lines above the block that states it as theorem.** A reduction to two named steps exists, the maximiser has at most two negative eigenvalues, then the equality case of [L29](bounds.md)/[L35](bounds.md), after which [L30](stratum-two-negative.md) pushes it into $n=4$ where it closes.

> **THE POINTER IS FALSE, AND THE REPAIR IS WHAT MADE IT FALSE.** The named section is a four-row table about a JSON file and contains no $\theta$, no $P$ and no syzygy; the transfer step sits 49 lines lower, and the equality clause in no section at all. *The note's first form said "the surrounding material" (vague and true) and a later commit narrowed it into a precise falsehood.* The only place the proof is composed is [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), the LaTeX rather than the block the record designates canonical.

> **SCOPE RUNS BOTH WAYS AND THE BLOCK STATES NEITHER.** Padding preserves $\theta$ since $\Lambda^2U=\mathfrak{so}(U)$ is a subalgebra, so the *witness* transfers **up**: $M(n)\ge\sqrt{3/2}$ at every $n\ge5$. The *bound* transfers **down** only, it is false at $n\ge12$, witness $\theta_0(12)=1.23604>1.224745$. What L61 licenses at $n\ge12$ is that no maximiser has $5$-dimensional support, **a statement the record does not make**. Meanwhile [report/sections/09-status.tex](../report/sections/09-status.tex) claims *"Conjecture A holds at $n=5$"*, which is outside the conjecture's $n\ge12$ clause and false under it.

$F_5=\tfrac32\|W\|^6-9\operatorname{tr}(W^3)^2$ is a sum of squares of cubics vanishing on the $O(5)$-orbit of $W_0$, the padded $W_{\CP^2}$. Hence $\lvert\theta\rvert\le\sqrt{3/2}$ on $\Weyl_5$, with equality on that orbit. *The bound is two-sided because $F_5$ is even; the equality set is not identified, a sum of squares fixing only $Z(F_5)\supseteq O(5)\cdot W_0$ and $Z(F_5)$ being a cone closed under negation. Round [L61](../verification/ROUND_L61.md).*


#### Lemma L62, $\dim\mathrm{ann}=1$, so the rank is $13$

*Round [L62](../verification/ROUND_L62.md): `PROVEN, hypotheses corrected`. Both halves stand (the cap by derivation, the value by an exact rank under that cap) and the hypotheses the chain uses are now written into the statement.*

> **THE CAP $\operatorname{rank}\le13$ IS A THEOREM, IN SIX LINES, AND BOTH REVIEWERS PROVED IT.** $\lVert W\rVert^6$ is an invariant sextic with $\lVert W_0\rVert^6=1$, so evaluation at $W_0$ is a **nonzero** functional on [L85](sym3-blocks.md)'s $14$; every product of two cubics of $K$ vanishes at $W_0$, so the image lies in its kernel, of dimension $13$. *One reviewer also proves the cap is unimprovable by higher vanishing*: $\mathcal W_5=V_{(2,2)}$ has $\lambda_2$ even, so [L86](sym3-blocks.md) gives $\dim\mathcal W_5^H=1$ and Euler forces $dF(W_0)=0$ automatically, **which the record only asserts.**

> **THE VALUE RESTS ON AN EXACT RANK UNDER A DERIVED CAP, WHICH IS A PROOF.** The rank of the sampled matrix is $13$ over $\mathbb Q$ exactly, and the chain that carries it to $\operatorname{rank}(\mu_K)$ moves the right way at every link: $\operatorname{rank}_{\mathbb F_p}\le\operatorname{rank}_{\mathbb Q}\le\operatorname{rank}(\mathrm{ev}_{40}\circ\mu_K)\le\operatorname{rank}(\mu_K)\le13$. **Attaining the cap collapses it**, so $\dim\mathrm{ANN}=1$ and $F_5\in\operatorname{image}$ follow. *The proved cap alone yields only $F_5\perp\mathcal A(W_0^6)$, which restates $F_5(W_0)=0$; the value is what gives the block its content.*

> **THE HYPOTHESES THE CHAIN USES, NAMED.** The sample points are exact rationals fixed before any prime, so the reduced matrix is the reduction of a rational one; the equivariant copies are identified by the multi-probe Schur test, *a non-equivariant build sampling **above** its own rank*; and the columns are $47$ Hermitian coordinates where the unknowns are $36$ real ones. **The first two are stated above and in [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex). The third is a `HYPOTHESIS-DEBT`**: what is owed is that $\mathrm{image}(\tilde\mu_K)=\mathrm{image}(\mu_K)$, the $11$ extra Hermitian directions costing no rank, the record carries this only in its unrestricted form $89=65+24$. *This file also notes at line 131 that a defect landing exactly on the cap is invisible; the run's own $\operatorname{rank}[A\mid F_5]=13$ against an independent evaluator is a $27$-codimension coincidence against that.*

> **THE PRIMES ARE ON FILE, AND THE PLURAL IS REDUNDANCY.** Six support the rank: $1000033$ from the pipeline, $1000003$ from an independent reviewer's own points and own code, and the four near $2^{40}$ whose stored $40\times47$ dumps each exist only because that run's rank-$13$ assertion passed first, the row lift consumes those same files, which is what made the four look migrated. **The dumps are gitignored, so the citable witness is [r214](../reviews/REVIEW_r214.md)'s own elimination, tabulating $13$ at all four**, and [r211](../scripts/reviewers/r211/check_exact_rank.py)'s exact rank over $\mathbb Q$. **One prime already closes the squeeze**, a mod-$p$ rank of $13$ forcing $\ge13$ over $\mathbb Q$ against the derived cap of $\le13$; the four share one seed, one point set and one code path, so they add no inequality. *The rank is $13$ exactly over $\mathbb Q$ as well, which retires the reduction argument outright.* **Every citing site leaves the prime unnamed**, at six sites. Round [L62](../verification/ROUND_L62.md), adjudicated v73 and v74.

> **THE FILE CONTRADICTS THIS BLOCK, FIFTY-FOUR LINES ABOVE**, where the rank is called *"open in $[1,13]$"* and *"tightness is open"*, three unreconciled strata, of which the block quotes only the newest.

> **THE TWO REVIEWERS DISAGREE ON WHETHER THE POINTER RESOLVES, AND THE DISAGREEMENT IS STRUCTURAL RATHER THAN MATHEMATICAL.** [r633](../reviews/REVIEW_r633.md) calls it **false**, the argument sits under **[Lemma L90](sym3-blocks.md)'s** heading, not the named one, while [r634](../reviews/REVIEW_r634.md) calls it **resolved**, on the reading that a `##` section contains its subordinate `####` blocks. *`git show` establishes that one commit narrowed [L61](sym3-blocks.md)'s and L62's notes identically, manufacturing a falsehood only on L61, whose argument is absent under either reading.* **The record does not say what a `##` section contains, and two audits today read that boundary two ways**, until it does, every pointer verdict inherits the ambiguity.

*$\dim\mathrm{ann}=1$ and $\operatorname{rank}=13$ are one claim, by [L59](sym3-blocks.md)'s apolarity adjunction (ANN is the adjoint's kernel, not the map's) and the block consumes [L59](sym3-blocks.md), [L85](sym3-blocks.md) and [L86](sym3-blocks.md) while citing none of them. Its proof also lives inside [L90](sym3-blocks.md)'s block, which **consumes L62's conclusion**, so the dependency runs backwards from where a reader lands. W5 costs the numbers nothing here (the $14$ is a Weyl-integration dimension and the $13$ is $14-1$) but a reader trusting the section title would pick a different point and a different $K$.*
Order-$1$ vanishing at $W_0$ caps the restricted rank at $13$: a product of two cubics of $K$ vanishes at $W_0$, and evaluation there is a nonzero functional on the $14$. A sampled rank is bounded above by the true one, and reducing modulo $p$ can only lower it further --- the $40$ evaluation points being exact rationals fixed before any prime is chosen, so what is reduced is the reduction of a rational matrix --- so a sampled rank *attaining* $13$ forces equality. It attains it, at four primes, and exactly over $\mathbb Q$. Hence $\dim\mathrm{ANN}=1$, spanned by $A(W_0^6)$, and $F_5\perp\mathrm{ANN}$.

