# I14, steps 1–2, the sign-flip decomposition of $\mathcal W_n$, and why $L_e$ respects it

**Record search first, by mechanism.** Grepped [findings/](../findings/) for the sign-flip group, $(\mathbb Z/2)$ characters and $4$-set blocks. The record holds the diagonal block of $L_e$ and numerical spectra of the full operator ([diagonal-half.md](../findings/diagonal-half.md), [nondegeneracy.md](../findings/nondegeneracy.md)), and [problem.md](../findings/problem.md) notes that sign-flip *averaging* is norm-decreasing, a different use. **It holds no decomposition of the non-diagonal directions**, which is what this note supplies. No outward search: the object is $\Gamma$-representation theory on this programme's own space.

## Setting

$\Gamma=\{\mathop{\mathrm{diag}}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$, **the full sign group**, acting through $\mathrm{Ad}$ with kernel $\{\pm\mathrm{Id}\}$.

> **THE DETERMINANT-ONE VERSION OF THIS GROUP DOES NOT WORK, AND THAT WAS THIS NOTE'S ERROR** ([r346](REVIEW_r346.md)). On $\{\det=1\}$ the character $\chi_{[n]}$ is trivial, so $\chi_S\chi_{S^{\mathsf c}}=\chi_{[n]}=1$ and **$\chi_S=\chi_{S^{\mathsf c}}$**: complementary subsets carry the same character and their blocks fuse. With $\lvert S\rvert\in\{0,2,4\}$ a fusion needs $\lvert S^{\mathsf c}\rvert\in\{0,2,4\}$ too, hence $n\le8$, and it happens at exactly $n=4$ (a $4$-set with the trivial block), $n=6$ (a $4$-set with a pair block) and $n=8$ (two complementary $4$-sets, giving a block of size $4$ rather than two of size $2$). *Verified independently by listing the complementary pairs at each $n$.* **The repair costs nothing**: $\circ$ is $O(n)$-equivariant, not merely $SO(n)$-equivariant, so the full sign group may be used, its even-subset characters are pairwise distinct at every $n$, and the proposition below then holds for all $n\ge4$. The conjecture's regime $n\ge12$ was never at risk, but the statement was wrong at three dimensions.

The group acts on $\Lambda^2\mathbb R^n$ by $e_i\wedge e_j\mapsto\varepsilon_i\varepsilon_j\,e_i\wedge e_j$, so every $e_{ij}:=e_i\wedge e_j$ spans a character line with character $\chi_{ij}=\varepsilon_i\varepsilon_j$. Write $M$ for a diagonal critical point (one whose eigenbivectors are the coordinate bivectors) and $e=M/\theta$, $L_e=e\circ(\cdot)$ with $\circ$ the Weyl-algebra product, so that [Lemma L24](../findings/second-order.md)'s criterion is $L_e\le\tfrac12$ off the orbit.

## Step 1, the character decomposition, and it is three blocks

On $\mathrm{Sym}^2(\Lambda^2)$ the basis element $e_{ij}\odot e_{kl}$ carries the character $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$, which depends only on the multiset $\{i,j,k,l\}$ reduced modulo repeated indices. Three cases, and they exhaust:

| overlap of $\{i,j\}$ and $\{k,l\}$ | character | the space it spans | count |
|---|---|---|---|
| equal | trivial | $e_{ij}\odot e_{ij}$, the **diagonal** entries | $\binom n2$ |
| one index shared, say $i$ | $\varepsilon_j\varepsilon_k$, depending only on the pair $\{j,k\}$ | $e_{ij}\odot e_{ik}$ over $i\notin\{j,k\}$, the **pair block** of $\{j,k\}$ | $\binom n2$ blocks of size $n-2$ |
| disjoint | $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$, four distinct indices | the three pairings $e_{ij}\odot e_{kl},\,e_{ik}\odot e_{jl},\,e_{il}\odot e_{jk}$, the **$4$-set block** | $\binom n4$ blocks of size $3$ |

*Nothing else occurs*: a character $\varepsilon_j\varepsilon_k$ arises only from a one-index overlap, since $\{i,j\},\{k,l\}$ equal would give the trivial character and disjoint would give four distinct indices. **Screen** (seconds, on the closed forms above): $\binom n2+(n-2)\binom n2+3\binom n4=\tfrac{N(N+1)}2$ with $N=\binom n2$, at $n=4,\dots,8$.

**Now impose the Weyl conditions, and each block loses exactly what its symmetry allows.**

- **Diagonal block.** The trivial character space is the space of symmetric $n\times n$ arrays $M_{ij}$, hollow, and Ricci-flatness is the $n$ row-sum conditions $\sum_jM_{ij}=0$. Dimension $\binom n2-n=\tfrac{n(n-3)}2$, **the diagonal locus $D_n$**, which is also $\Gamma$'s fixed set in $\mathcal W_n$, recovering the symmetric-criticality direction the record already has.
- **$4$-set block.** First Bianchi on four distinct indices is the single relation $\alpha-\beta+\gamma=0$ among the three pairings, so the block drops from $3$ to **$2$**. Ricci-flatness is empty here: a trace pairs indices, and there are none to pair.
- **Pair block $\{j,k\}$.** The $n-2$ coordinates $x_i$ carry one Ricci relation (the $(j,k)$ entry of the Ricci trace) so the block drops from $n-2$ to **$n-3$**. First Bianchi is empty here, needing four distinct indices.

> **PROPOSITION (the decomposition).** *As a $\Gamma$-representation,*
> $$\mathcal W_n\;=\;\underbrace{D_n}_{\tfrac{n(n-3)}2}\ \oplus\ \bigoplus_{\{i,j,k,l\}}\underbrace{V_{ijkl}}_{2}\ \oplus\ \bigoplus_{\{j,k\}}\underbrace{V_{jk}}_{n-3},$$
> *the summands being the isotypic components of the trivial character, the four-index characters and the two-index characters respectively.*

**The dimensions close, but this is much weaker evidence than it looks, and [r346](REVIEW_r346.md) says why.** The identity factors as $\tfrac{n(n-3)}2\big[1+\tfrac{(n-1)(n-2)}6+(n-1)\big]$, so it tests the three block *totals* and is blind to which relation cut each block; it closes unchanged at $n=8$, where the block structure above is wrong. *It is transcription insurance, not a check on the mathematics.* The identity itself,
$$\frac{n(n-3)}2+2\binom n4+(n-3)\binom n2\;=\;\frac{n(n+1)(n+2)(n-3)}{12}\;=\;\dim\mathcal W_n,$$
holds at $n=4,\dots,12$ as screened, and would still hold with the block structure wrong, which is exactly the point.

## Step 2, $L_e$ preserves each block

The Weyl-algebra product $\circ$ is $O(n)$-equivariant ([conventions.md](../findings/conventions.md)), so for $g\in\Gamma$, $g\cdot(e\circ X)=(g\cdot e)\circ(g\cdot X)$. At a **diagonal** critical point $e=M/\theta$ is $\Gamma$-fixed, so $g\cdot(e\circ X)=e\circ(g\cdot X)$: $L_e$ is $\Gamma$-equivariant. An equivariant operator preserves each isotypic component, and here every component above is a distinct character, so:

> **PROPOSITION (block-diagonality).** *At every diagonal critical point, $L_e$ is block-diagonal for the decomposition above: one block of size $\tfrac{n(n-3)}2$, $\binom n4$ blocks of size $2$, and $\binom n2$ blocks of size $n-3$. Hence the Hessian of $P$ on the sphere, which is $6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, is block-diagonal in the same way, and [Lemma L24](../findings/second-order.md)'s criterion $L_e\le\tfrac12$ is checkable block by block.* **The largest block a non-diagonal direction can live in has size $n-3$, and most have size $2$.**

**Domain.** Diagonal critical points with $\theta>0$, which is [Lemma L24](../findings/second-order.md)'s hypothesis; at $\theta<0$ the criterion reverses. *The record's screen at $S^3\times S^3$ measured the cross-block leak of $L_e$ at $9\times10^{-16}$, consistent with equivariance and not evidence for it, the proof is the equivariance, and the screen is transcription insurance.*

## What is owed

**Steps 3–7 of the route**, none of which this note attempts: the closed form of the $2\times2$ $4$-set block in the six entries $M_{ij}$ of its $4$-set; the closed form of the $(n-3)$ pair block and the proof that the orbit direction $x_i=\sigma_i(M_{ji}-M_{ki})$ is an eigenvector with eigenvalue $\tfrac12$; the recovery of the recorded nondegeneracy gap $\tfrac1{2(M-1)}$ as $\tfrac12$ minus the block maximum; and the branching corollary naming the locus where a $\Gamma$-nontrivial block hits exactly $\tfrac12$.

**A caution the route's own target lines carry.** The plan item predicts the within-factor pair block at $S^p\times S^q$ has top eigenvalue $(p-2)/(2(p-1))$; [plan-diagfam](plan-diagfam.md) flags that the record attributes that value to the *diagonal* restriction while a screen found it in a non-diagonal pair block. **That attribution is a live verification-loop candidate and this note does not settle it**; the decomposition above is what would let it be settled, since it says exactly which block the value belongs to.

---

# DF1b, step 4 begun, the pair block

**Part one is diagonal and falls out.** With $\circ$ defined by $X\circ Y=\tfrac12(XY+YX)+X\#Y$ ([conventions.md](../findings/conventions.md)) and $M$ diagonal, $M(e_{ab})=M_{ab}e_{ab}$, take the pair block $\{j,k\}$ with basis $f_i=e_{ji}\odot e_{ki}$, $i\notin\{j,k\}$. Then $f_i$ sends $e_{ki}\mapsto e_{ji}$ and $e_{ji}\mapsto e_{ki}$, so
$$\tfrac12(Mf_i+f_iM)=\tfrac12\big(M_{ji}+M_{ki}\big)f_i:$$
**the symmetrised-product half of $L_M$ is diagonal on the pair block, with entries $\tfrac12(M_{ji}+M_{ki})$.** *This is where the route's predicted $(M_{ji}+M_{ki})x_i$ comes from; the factor $\tfrac12$ is the one carried by $\circ$, and $L_e=L_M/\theta$ carries it too.*

**Part two is the whole difficulty, and the definition of record is the implementation.** [Q_full](../scripts/lib/adversarial_check1.py) fixes $(W^\#)_{ab}=-\tfrac12\mathop{\mathrm{tr}}(A_aWA_bW)$ with $(A_a)_{bg}=c_{abg}$, i.e. $A_a=\mathrm{ad}(v_a)$ acting on $\Lambda^2$. Polarising,
$$(M\#X)_{ab}=-\tfrac14\big[\mathop{\mathrm{tr}}(A_aMA_bX)+\mathop{\mathrm{tr}}(A_aXA_bM)\big],$$
and evaluating this on $X=\sum_ix_if_i$ is what couples $x_i$ to $x_m$ through $M_{jm}$ and $M_{km}$. **Not attempted here.**

**What remains, in order, and none of it needs approval.** *(i)* $M\#$ on the pair block in the entries of $M$, giving the $(n-3)\times(n-3)$ matrix. *(ii)* The proof that the orbit direction $x_i=\sigma_i(M_{ji}-M_{ki})$ is an eigenvector with eigenvalue $\tfrac12$, forced, since it is the tangent to the $SO(n)$-orbit in the $(j,k)$ rotation, and it fixes the normalisation. *(iii)* The nondegeneracy gap $\tfrac1{2(M-1)}$ recovered as $\tfrac12$ minus the larger of the two block maxima, checked against the recorded values at $(4,4)$, $(5,5)$ and $(3,5)$. *(iv)* The branching corollary: the locus of diagonal critical points where a $\Gamma$-nontrivial block reaches exactly $\tfrac12$, which by [Lemma L121](../findings/second-order.md) already contains $S^3\times S^3$ at $n=6$ through its nine $4$-set blocks.

**A prediction the record can already contradict, and it should be checked first.** [Lemma L121](../findings/second-order.md) makes the $4$-set contribution vanish off $(2,2)$ splits at sphere products, so at $S^p\times S^q$ the *pair* block must carry the within-factor value $(p-2)/(2(p-1))$ that both reviewers located there. **If step (i) does not reproduce that number, the error is in step (i) and not in the record.**

## DF1b, step 4(ii), the orbit direction inside the pair block, identified

**The $(j,k)$ rotation generator acts on the pair block and on nothing else.** Let $E_{jk}=e_j\otimes e_k-e_k\otimes e_j$ and $\rho$ its action on $\Lambda^2$. Then $\rho(E_{jk})$ sends $e_{ki}\mapsto e_{ji}$ and $e_{ji}\mapsto-e_{ki}$ for every $i\notin\{j,k\}$, and annihilates every bivector on neither of those lists. So the orbit tangent at $M$ in this direction,
$$X_{\mathrm{orb}}=[\rho(E_{jk}),M],\qquad X_{\mathrm{orb}}(e_{ki})=(M_{ki}-M_{ji})\,e_{ji},$$
**lies entirely inside the pair block $\{j,k\}$, with coordinates $x_i=M_{ki}-M_{ji}$** in the basis $f_i=e_{ji}\odot e_{ki}$. *This is the route's predicted $x_i=\sigma_i(M_{ji}-M_{ki})$, derived, with the sign fixed and the $\sigma_i$ absorbed into the basis orientation.*

**Its eigenvalue is $\tfrac12$ and that is already on the record**, not something this note needs to prove: it is the content of [Lemma L101](../findings/route-a.md), the $SO(n)$-invariance identity, together with [Lemma L24](../findings/second-order.md)'s statement that $L_e$ carries $1$ simply on $W$ and $\tfrac12$ along the orbit. **Agreement, not discovery**, what is new here is only that the orbit direction of the $(j,k)$ rotation is *confined to the $\{j,k\}$ pair block*, which is what makes the block decomposition usable: **each pair block contains exactly one orbit direction, so the criterion on that block is $L_e\le\tfrac12$ on the complement of its orbit direction, of dimension $n-4$ where that direction is nonzero, and $n-3$ where it vanishes.**

**Consequence for the count, the counting argument first given here was WRONG.** *[r347](REVIEW_r347.md) and [r348](REVIEW_r348.md), independently.* It read "$\binom n2$ pair blocks and $\binom n2$ orbit directions, one per block", which **conflates $\dim\mathfrak{so}(n)$ with the dimension of the orbit**. The orbit is $\dim\mathfrak{so}(n)-\dim\mathfrak k(W)$, and the isotropy is not zero at a symmetric point: at $S^3\times S^3$ it is $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, so the orbit is $15-6=9$-dimensional, which [second-order.md](../findings/second-order.md) records, and **six of the fifteen pair blocks carry no orbit direction at all.**

**The conclusion survives by linearity, which is the argument that should have been given.** Every orbit direction is $[\rho(A),M]$ for $A\in\mathfrak{so}(n)$; writing $A=\sum_{j<k}a_{jk}E_{jk}$ and using linearity, $[\rho(A),M]=\sum_{j<k}a_{jk}[\rho(E_{jk}),M]$, and each summand lies in its own pair block. **So the whole orbit lies in the sum of the pair blocks**, and the $4$-set and diagonal blocks contain no orbit direction, no counting needed, and the statement holds whatever the isotropy is. *A corollary worth keeping ([r347](REVIEW_r347.md)): the isotropy algebra of a diagonal critical point is spanned by coordinate rotations $E_{jk}$.* *At $S^3\times S^3$ that is the check: the nine $\tfrac12$-eigenvectors [Lemma L121](../findings/second-order.md) locates in the $(2,2)$ $4$-set blocks are therefore genuinely off the orbit, which is why they were a puzzle and why they are not spurious.*

**Still owed, and it is the whole of the pair block's spectrum**: $M\#$ on the block, giving the $(n-3)\times(n-3)$ matrix whose top eigenvalue must reproduce $(p-2)/(2(p-1))$ at $S^p\times S^q$.

## DF1b, step 4(i), the pair block, REFUTED as first recorded and now proved

**The closed form recorded here was wrong by a factor of two on the sharp half.** *Gate 2, [r351](REVIEW_r351.md) and [r352](REVIEW_r352.md) on identical briefs, each proving the correct form from the structure constants and each refuting the recorded one three independent ways.*

> **CORRECTED FORM, proved.** *For a coordinate-diagonal $M$ with sectional matrix $M_{ab}$, the pair block $\{j,k\}$ of $L_M$ in the basis $f_i=e_{ji}\odot e_{ki}$ is*
> $$L\big|_{\{j,k\}}=\tfrac12\Big[\mathop{\mathrm{diag}}(M_{ji}+M_{ki})-M_{jk}\,\mathrm{Id}+M^{(jk)}\Big],\qquad L[i,i]=\tfrac12(M_{ji}+M_{ki})-\tfrac12M_{jk},\quad L[i,m]=\tfrac12M_{im},$$
> *with $M^{(jk)}$ the hollow submatrix of $M$ on the indices other than $j,k$. **It needs diagonality only**, not criticality, not $\theta>0$, not Ricci-flatness.*

**The error.** In $(M\#X)_{\alpha\beta}=-\tfrac14[\mathop{\mathrm{tr}}(A_\alpha MA_\beta X)+\mathop{\mathrm{tr}}(A_\alpha XA_\beta M)]$ the two traces are **equal**, so the $-\tfrac14$ collapses to $-\tfrac12$. The recorded entries are the symmetrised half plus exactly *one half* of the true sharp half.

**And the $\sigma_i$ were an artefact of the wrong basis** ([r352](REVIEW_r352.md)): no sign appears in the unsorted basis $f_i=e_{ji}\odot e_{ki}$ as defined; the $\sigma_i\sigma_m$ belongs to the *sorted* basis. It is spectrum-neutral, being a $\mathop{\mathrm{diag}}(\pm1)$ conjugation, so it costs no result, but the $16\%$ failure that first exposed it was the screening code using sorted bivectors while the text described unsorted ones.

**Three independent refutations of the recorded form, any one decisive.**

- **It does not preserve the Weyl subspace.** Its row sums are $\tfrac14(M_{ji}+M_{ki}-M_{jk})$, which vary with $i$, so $\mathbf 1$ is not an eigenvector and the Ricci cut is not preserved, contradicting [Lemma L120](../findings/second-order.md), an indexed result. The corrected form has constant row sums $-\tfrac12M_{jk}$. *Verified in this session by hand, from Ricci-flatness alone: it uses no normalisation convention, which is what makes it decisive.*
- **The orbit test.** The corrected block sends $x_i=M_{ki}-M_{ji}$ to exactly $\tfrac\theta2x$, all $M$-dependence cancelling against criticality; the recorded form leaves a residue.
- **The sphere-product test.** The corrected block's top eigenvalue is $(p-2)/(2(p-1))$ at every $(p,q)$; the recorded form gives $0.2276$ against $\tfrac13$ at $S^4\times S^4$.

**Why the screen did not catch it.** The $222$ blocks were checked against *the implementation that produced the formula*, on **random diagonal matrices that are not Weyl tensors**, no Ricci-flatness, no Bianchi. Two objects sharing a convention error agree perfectly, and the one structural test that would have exposed it, preservation of the Ricci cut, is invisible on inputs that do not satisfy Ricci-flatness. *Both reviewers checked against [Q_full](../scripts/lib/adversarial_check1.py), the definition of record, and found the discrepancy at the same $222$ blocks.*

## What the corrected block is: a graph Laplacian

**With $\Delta^{(jk)}$ the weighted graph Laplacian of $M$ with rows and columns $j,k$ deleted** ([r352](REVIEW_r352.md)),
$$L\big|_{\{j,k\}}=-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\,\mathrm{Id},$$
**and the Ricci cut is exactly $\sum_ix_i=0$, the Laplacian's own $\mathbf 1^\perp$.** So [Lemma L24](../findings/second-order.md) on a pair block reads
$$\lambda_{\min}\big(\Delta^{(jk)}\big|_{\mathbf 1^\perp}\big)\ \ge\ -\big(\theta+M_{jk}\big)\qquad\text{for every pair }\{j,k\}.$$
*The second-order criterion on the non-diagonal directions is a spectral condition on graph Laplacians of the sectional matrix, one per pair, each of size $n-2$ cut to $n-3$.*

**And an open attribution closes.** $(p-2)/(2(p-1))$ is now **proved** to top the within-factor pair block, settling the verification-loop candidate [plan-diagfam](plan-diagfam.md) raised. Within-factor blocks at a sphere product carry **no** orbit direction, since $M_{ji}=M_{ki}$ there, which is why six of fifteen blocks at $S^3\times S^3$ are orbit-free.

**Containment.** The wrong form lived only in this file and never reached [findings/](../findings/); [Lemma L120](../findings/second-order.md) and [Lemma L121](../findings/second-order.md) are undisturbed, and L120's block-diagonality was confirmed incidentally at a leak of $3\times10^{-16}$.
