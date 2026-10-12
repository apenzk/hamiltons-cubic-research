# r981: Gate 2 on the first-order condition on $O(k)$

Reviewer **r981**, working from [BRIEF_R28_first_order.md](BRIEF_R28_first_order.md) alone. The working note the block was drawn from, the other reviewers' reports and the scripts were not read. Claim 1 was derived from scratch before the block's form was compared against it.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | Criticality on $O(k)$ is exactly $(a_i-a_j)\tilde U_{ij}+(b_i-b_j)\tilde C_{ij}=0$ for all $i\ne j$ | **CONFIRMED**, exactly as stated, no factor, no sign, no symmetrisation |
| 2 | Equivalent to $(\nu_i-\nu_j)[\beta(\nu_i+\nu_j)\tilde U_{ij}+\tilde C_{ij}]=0$ | **CONFIRMED**, a ring identity |
| 3 | Holds at every critical point, not only at maxima, and is $\lvert J\rvert$-free | **CONFIRMED**, and understated: it is a characterisation of criticality, not a consequence of it |
| 4 | $\nu$ pairwise distinct and $\tilde U$ diagonal give $\tilde C$ diagonal | **CONFIRMED**, with criticality named as the third hypothesis and the sharp per-pair form recorded below |
| 5 | Hence $[\hat U,C]=0$ | **CONFIRMED**, and orthogonality of $P$ is load-bearing rather than incidental |
| 6 | $\tilde U$ block diagonal gives simultaneous block diagonalisation, which does not imply commuting | **CONFIRMED**, and strengthened: the witness below is a GLOBAL MAXIMISER, not merely a critical point |
| 7 | The distinctness hypothesis is necessary | **CONFIRMED**, and the hypothesis is a restriction rather than free |

**One correction and two additions**, all in [Corrections](#corrections). The block states one degeneracy of the criticality relation and there are two. The second, $\nu_i+\nu_j=0$, is what the claim 6 witness runs on.

## Claim 1, derived from scratch

Write $A=\operatorname{diag}(a)$, $B=\operatorname{diag}(b)$, $\tilde U=P^{\mathsf T}\hat UP$, $\tilde C=P^{\mathsf T}CP$, so the value is $f(P)=\operatorname{tr}(A\tilde U)+\operatorname{tr}(B\tilde C)$.

The tangent space to $O(k)$ at $P$ is $\{P\Omega:\Omega^{\mathsf T}=-\Omega\}$, swept by the curves $P(t)=P\exp(t\Omega)$. Along one of them $\exp(t\Omega)^{\mathsf T}=\exp(-t\Omega)$, so $\tilde U(t)=\exp(-t\Omega)\tilde U\exp(t\Omega)$ and

$$\left.\frac{d}{dt}\right|_{0}\tilde U(t)=\tilde U\Omega-\Omega\tilde U=[\tilde U,\Omega],$$

and likewise for $\tilde C$. By cyclicity $\operatorname{tr}(A[\tilde U,\Omega])=\operatorname{tr}(A\tilde U\Omega)-\operatorname{tr}(\tilde UA\Omega)=\operatorname{tr}([A,\tilde U]\Omega)$, so

$$\left.\frac{d}{dt}\right|_{0}f(P\exp(t\Omega))=\operatorname{tr}(M\Omega),\qquad M:=[A,\tilde U]+[B,\tilde C].$$

Entrywise $M_{ij}=(a_i-a_j)\tilde U_{ij}+(b_i-b_j)\tilde C_{ij}$, which is the block's left-hand side verbatim.

**$M$ is antisymmetric.** $\tilde U$ and $\tilde C$ are symmetric, so $M_{ji}=(a_j-a_i)\tilde U_{ij}+(b_j-b_i)\tilde C_{ij}=-M_{ij}$, and the diagonal vanishes identically.

**Criticality is $M=0$, with nothing lost in either direction.** Under $\langle X,Y\rangle=\operatorname{tr}(X^{\mathsf T}Y)$ the identity $\operatorname{tr}(M\Omega)=\langle M^{\mathsf T},\Omega\rangle$ holds, and the skew matrices are the orthogonal complement of the symmetric ones. So $\operatorname{tr}(M\Omega)=0$ for every skew $\Omega$ says exactly that $M^{\mathsf T}$ is symmetric, that is, that $M$ is symmetric. Being already antisymmetric, $M=0$. **There is no residual symmetrisation to take, because the object paired against $\Omega$ is antisymmetric before any projection.** A reader who expected a $\tfrac12(M-M^{\mathsf T})$ to appear is expecting a step that the symmetry of $\hat U$ and $C$ has already done.

**"For all $i\ne j$" or only $i<j$.** The two are the same condition, since $M_{ji}=-M_{ij}$, so the $\binom k2$ equations indexed by $i<j$ carry the whole of it. **It does not matter, and the count is a control on the derivation**: $\binom k2=\dim O(k)$, one equation per tangent direction, which is what a gradient on a $\binom k2$-dimensional manifold must produce. Writing "for all $i\ne j$" is therefore correct and merely redundant, and a reader must not count $k(k-1)$ independent conditions from it.

**No factor and no sign are missing.** The condition is homogeneous, so the left-versus-right translation convention ($P\exp(t\Omega)$ against $\exp(t\Omega)P$) and the sign convention on $\Omega$ can at worst flip $M$, which the equation $M=0$ does not see. Screened by central finite differences against the closed form over 400 draws at $2\le k\le6$, agreeing to $10^{-5}$ relative, with the antisymmetry of $M$ and both entrywise forms asserted at $10^{-10}$, and the gradient in the skew basis asserted equal to $-2M_{ij}$.

**Verdict: CONFIRMED.** The block's displayed condition is exact.

## Claims 2 and 3

**Claim 2.** $a_i-a_j=\beta(\nu_i^2-\nu_j^2)=\beta(\nu_i-\nu_j)(\nu_i+\nu_j)$ and $b_i-b_j=\nu_i-\nu_j$, so $M_{ij}=(\nu_i-\nu_j)\big[\beta(\nu_i+\nu_j)\tilde U_{ij}+\tilde C_{ij}\big]$ identically, over any commutative ring. **CONFIRMED.** The brief's Lean row is right that this is `ring`-typeable and right that it is not typed.

**Claim 3, and the word "exactly".** The derivation used smoothness, the symmetry of $\hat U$ and $C$, and the fact that $\hat U$, $C$ and $\nu$ do not depend on $P$. It used no maximality, no $k$, and no $\lvert J\rvert$. So the condition holds at every critical point at every $k$, as claimed.

**The block understates itself.** The brief asks whether the equation is equivalent to criticality or merely implied by it, and the answer is that it is equivalent, because $M$ is already antisymmetric and so the pairing loses nothing. **A necessary condition would be the weaker reading and the block is entitled to the stronger one.** That matters downstream: claims 4 to 6 consume the equation as a hypothesis at a point already known to be critical, which only needs necessity, but any future use that tries to certify a point AS critical needs the converse, and the converse is available.

**Two scope notes that the block does not owe but a successor does.** $SO(k)$ and $O(k)$ give the same condition, having the same Lie algebra, so restricting the frame to a rotation changes nothing. And $O(k)$ is a closed manifold without boundary, so a global maximum over frames is automatically critical and no boundary case is being skipped. What the condition characterises is criticality **in the frame direction only**: a point of the node's full problem that also varies $\hat U$, $C$ or the spectrum satisfies this as one block of its own first-order system, and satisfying this alone certifies nothing about the full problem.

**Verdict: CONFIRMED**, with "necessary at every critical point" replaceable by "equivalent to criticality".

## Claim 4, and whether it is vacuous

From claim 2, at a critical point with $\nu_i\ne\nu_j$ the bracket vanishes, so

$$\tilde C_{ij}=-\beta(\nu_i+\nu_j)\,\tilde U_{ij}\qquad\text{for every pair with }\nu_i\ne\nu_j. \tag{$\star$}$$

With $\tilde U$ diagonal, $\tilde U_{ij}=0$ for every $i\ne j$, so $(\star)$ gives $\tilde C_{ij}=0$ on every pair with $\nu_i\ne\nu_j$, and pairwise distinctness makes that every pair. **CONFIRMED, for ALL $i\ne j$.**

**The hypothesis the block actually needs is per-pair and slightly weaker than what it states.** What is used is $\nu_i\ne\nu_j$ on each pair whose $\tilde C_{ij}$ is wanted to vanish. Pairwise distinctness is exactly the hypothesis that delivers all of them, so the block's statement is correct and not wasteful. **What the block's sentence does omit is criticality itself.** As written, "with $\nu$ pairwise distinct and $\tilde U$ diagonal, $\tilde C$ is diagonal" names two hypotheses, and the true hypothesis set is three: critical, $\nu$ pairwise distinct, $\tilde U$ diagonal. The context supplies the third, and a reader quoting the sentence out of the lemma would not have it.

**Is it vacuous?** The brief asks whether $\tilde U$ diagonal already forces $P$ to be the eigenframe of $\hat U$, making the claim a restatement. **It does force exactly that, and the claim is a deduction anyway.** For orthogonal $P$, $\tilde U=P^{\mathsf T}\hat UP$ diagonal says precisely that the columns of $P$ are an orthonormal eigenbasis of $\hat U$, so the hypothesis IS "$P$ diagonalises $\hat U$" in other words. The content lies entirely in the conclusion, which is about $C$: the same frame diagonalises $C$ too. That is not a restatement of anything.

**The non-vacuity that does need naming is the hypothesis set, not the hypothesis.** The conjunction "critical AND $\tilde U$ diagonal" is non-empty whenever $[\hat U,C]=0$, since a shared eigenframe makes both $\tilde U$ and $\tilde C$ diagonal and hence $M=0$. Off the commuting stratum it is empty, and that is the whole point: **the useful reading of claims 4 and 5 together is the contrapositive, that when $[\hat U,C]\ne0$ and $\nu$ is pairwise distinct, NO eigenframe of $\hat U$ is a critical point.** Read forwards the pair looks like a route to $[\hat U,C]=0$, and it only delivers that if something else supplies an eigenframe of $\hat U$ at the maximiser. Nothing in the block supplies it, and [claim 6](#claim-6-and-the-witness-that-strengthens-it) below exhibits a global maximiser where it fails.

## Claim 5, and the frame it crosses

Diagonal matrices commute, so $[\tilde U,\tilde C]=0$. For orthogonal $P$, $\hat U=P\tilde UP^{\mathsf T}$ and $C=P\tilde CP^{\mathsf T}$, hence $[\hat U,C]=P[\tilde U,\tilde C]P^{\mathsf T}=0$. **CONFIRMED.**

**Orthogonality is load-bearing.** The map $X\mapsto P^{\mathsf T}XP$ is a congruence, and congruence does not transport a commutator. It transports one only when it coincides with the similarity $X\mapsto P^{-1}XP$, which is exactly the condition $P^{\mathsf T}=P^{-1}$. For a merely invertible $P$ the step fails, and it fails on a two-by-two example: with $P=\begin{pmatrix}1&1\\0&1\end{pmatrix}$, $\hat U=P^{-\mathsf T}\operatorname{diag}(1,0)P^{-1}=\begin{pmatrix}1&-1\\-1&1\end{pmatrix}$ and $C=P^{-\mathsf T}\operatorname{diag}(0,1)P^{-1}=\operatorname{diag}(0,1)$ are congruent by $P$ to two diagonal matrices simultaneously, and $[\hat U,C]=\begin{pmatrix}0&-1\\1&0\end{pmatrix}\ne0$. So the block's one-line inference is sound and its soundness is an orthogonality fact, worth stating where the block leaves it implicit.

## Claim 6, and the witness that strengthens it

**The block structure does transfer, and criticality gives strictly more than the block says.** Let $\tilde U$ be block diagonal for a partition of the index set and let $\nu$ be pairwise distinct. On an off-block pair $\tilde U_{ij}=0$, so $(\star)$ gives $\tilde C_{ij}=0$, and $\tilde C$ carries the same block structure. **What $(\star)$ additionally gives, and the block does not record, is that inside each block $\tilde C$ is PINNED to $\tilde U$ entrywise**, $\tilde C_{ij}=-\beta(\nu_i+\nu_j)\tilde U_{ij}$, a Hadamard relation rather than a free simultaneous block form. Criticality is therefore a stronger statement than "simultaneously block diagonal", and a successor that reads it as the weaker one is discarding information.

**Even so, it does not imply commuting.** On a $2\times2$ block on indices $\{i,j\}$ with $\tilde U=\begin{pmatrix}u_i&w\\w&u_j\end{pmatrix}$ and $\tilde C=\begin{pmatrix}c_i&z\\z&c_j\end{pmatrix}$, the commutator has single entry $z(u_i-u_j)-w(c_i-c_j)$, which under the pinning $z=-\beta s w$, $s=\nu_i+\nu_j$, is

$$[\tilde U,\tilde C]_{ij}=-w\big[\beta s(u_i-u_j)+(c_i-c_j)\big],$$

nonzero on an open set of the block's parameters. **CONFIRMED.**

**An explicit witness, and it is a GLOBAL MAXIMISER rather than merely a critical point.** Take $k=3$, $P=I$, and

$$\nu=(1,-1,0),\qquad \hat U=\begin{pmatrix}\tfrac{10}3&1&0\\[2pt]1&\tfrac{10}3&0\\[2pt]0&0&-\tfrac{20}3\end{pmatrix},\qquad C=\operatorname{diag}(1,-1,0).$$

$\nu$ is pairwise distinct, $\hat U$ and $C$ are symmetric and traceless, $\nu$ is traceless, $\tilde U=\hat U$ is block diagonal on $\{1,2\}\mid\{3\}$ and is NOT diagonal, $\tilde C=C$ is diagonal, and $[\hat U,C]=\begin{pmatrix}0&-2&0\\2&0&0\\0&0&0\end{pmatrix}\ne0$.

*Criticality.* $\nu_1+\nu_2=0$ kills the $(1,2)$ bracket whatever $\tilde U_{12}$ is, and the $(1,3)$ and $(2,3)$ entries of both matrices vanish, so $M=0$ exactly.

*Global maximality, by hand.* With $a=\beta\nu^{\circ2}=(\tfrac94,\tfrac94,0)$ and $b=\nu$,

$$f(P)=\tfrac94\big(\operatorname{tr}\hat U-p_3^{\mathsf T}\hat Up_3\big)+\big(p_1^{\mathsf T}Cp_1-p_2^{\mathsf T}Cp_2\big).$$

$\operatorname{tr}\hat U=0$ and $\hat U$ has spectrum $\{\tfrac{13}3,\tfrac73,-\tfrac{20}3\}$, so $p_3^{\mathsf T}\hat Up_3\ge-\tfrac{20}3$ with equality only at $p_3=\pm e_3$, and the first term is $-\tfrac94p_3^{\mathsf T}\hat Up_3\le\tfrac94\cdot\tfrac{20}3=15$, attained exactly there. $C$ has spectrum $\{1,0,-1\}$, so $p_1^{\mathsf T}Cp_1\le1$ and $p_2^{\mathsf T}Cp_2\ge-1$, making the second term at most $2$, attained at $p_1=e_1$ and $p_2=e_2$, which are orthogonal to $e_3$ and so compatible with the first bound. Hence $f\le17$ everywhere, and $f(I)=15+2=17$. **$P=I$ is a global maximiser.** Screened over $3\cdot10^5$ Haar frames with the maximum asserted at or below $f(I)$.

**Why the block's own reading makes this reachable, and what it costs the node.** The trick is $\nu_1+\nu_2=0$, which empties the $(1,2)$ bracket exactly as a repeat would, without repeating. **So there is a global maximiser, with $\nu$ pairwise distinct, at which $\tilde U$ and $\tilde C$ are simultaneously block diagonal and $[\hat U,C]\ne0$.** Claim 6's negative half is not a caution about a corner case, it is realised at the maximum.

## Claim 7, and whether $\nu$ can repeat in the node

**The invariance is real.** With $\nu_i=\nu_j$ both $a_i=a_j$ and $b_i=b_j$, so $M_{ij}=0$ identically and the pair is unconstrained. Equivalently, $a_i\tilde U_{ii}+a_j\tilde U_{jj}=a_i(\tilde U_{ii}+\tilde U_{jj})$ is the trace of $\tilde U$ on the $(p_i,p_j)$ plane, invariant under rotation of that plane, and the same for $\tilde C$.

**The converse fails, with an explicit point.** Take $k=2$, $\nu=(1,1)$, $\hat U=\begin{pmatrix}0&1\\1&0\end{pmatrix}$, $C=\operatorname{diag}(1,-1)$. The value is constant on $O(2)$, so every frame is critical. At the eigenframe $P=\tfrac1{\sqrt2}\begin{pmatrix}1&1\\1&-1\end{pmatrix}$ of $\hat U$, $\tilde U=\operatorname{diag}(1,-1)$ is diagonal while $\tilde C=\begin{pmatrix}0&1\\1&0\end{pmatrix}$ is not, and $[\hat U,C]\ne0$. So claims 4 and 5 both fail without distinctness. **CONFIRMED: the hypothesis is necessary and not decorative.**

**Can $\nu$ repeat in the node's own setting?** From the register and [fence-posts.md](../findings/fence-posts.md)'s post F69, $\nu$ is the spectrum of $V$, the difference of two traceless symmetric blocks, with $\hat U$, $C$ and $V$'s spectrum held fixed while the frame $P$ carrying $V$'s eigenvectors varies. **Nothing constrains that spectrum to be simple**, so a repeat is a codimension-one but perfectly reachable configuration and the hypothesis is a genuine restriction rather than free. A successor that wants the block's conclusion at the node owes either an argument that the maximiser has simple $\nu$ or a separate treatment of the degenerate locus.

## Corrections

**1. The block names one degeneracy of the criticality relation and there are two.** It records $\nu_i=\nu_j$, the vanishing of the outer factor. The inner bracket $\beta(\nu_i+\nu_j)\tilde U_{ij}+\tilde C_{ij}$ carries a second, $\nu_i+\nu_j=0$, at which the relation reduces to $\tilde C_{ij}=0$ and places NO constraint on $\tilde U_{ij}$. **This is the one that matters for the node**, because it is exactly what the claim 6 maximiser above runs on, and because it breaks the converse of claim 4: $\tilde C$ diagonal with $\nu$ pairwise distinct forces $\tilde U_{ij}=0$ only where $\nu_i+\nu_j\ne0$. Claims 1 to 5 as stated are unaffected, the block having stated claim 4 in the safe direction. **Any use of the reverse direction is not covered.**

**2. The $\lvert J\rvert=3$ specialisation is cleaner than the general form and is not on the record.** Where $\nu$ is the spectrum of a traceless $V$ at $k=3$, $\nu_i+\nu_j=-\nu_l$ with $l$ the third index, so criticality reads

$$(\nu_i-\nu_j)\big[\tilde C_{ij}-\beta\nu_l\,\tilde U_{ij}\big]=0\qquad\text{for the three pairs},$$

and the second degeneracy is exactly $\nu_l=0$, one vanishing eigenvalue of $V$. That is a condition on a single number per pair, and it is more checkable than $\nu_i+\nu_j=0$.

**3. Criticality gives more than simultaneous block diagonality.** Claim 6's phrasing, "it yields simultaneous BLOCK diagonalisation", is true but lossy. The full content on pairs with $\nu_i\ne\nu_j$ is the entrywise pinning $\tilde C_{ij}=-\beta(\nu_i+\nu_j)\tilde U_{ij}$, which is what makes the block structure transfer in the first place and which constrains the interior of each block as well as its exterior. A successor attacking the node should consume $(\star)$ rather than the block-diagonality shadow of it.

**4. Two wordings to tighten, neither a defect.** Claim 3's "holds at every critical point" is weaker than what the derivation supports, which is equivalence. Claim 4's sentence omits criticality from its hypothesis list, which the surrounding lemma supplies and a quotation would not.

## Screens

Both are assertion-only. [Screen 1](#claim-1-derived-from-scratch): the finite-difference check of the derivative identity, the antisymmetry of $M$, both entrywise forms, and the skew-basis gradient, over 400 draws at $2\le k\le6$ plus 50 gradient draws. [Screen 2](#claim-6-and-the-witness-that-strengthens-it): the traceless witness in exact rationals, its global maximality over $3\cdot10^5$ Haar frames, the congruence example of claim 5, and 2000 draws confirming that every $\nu_1+\nu_2=0$ configuration with $\tilde C$ diagonal is critical whatever $\tilde U_{12}$ is. Both are screens on objects constructed for the purpose and neither is offered as evidence for a positive claim: every verdict above rests on the derivation.

## Summary for the node

**The object is sound.** Claim 1 is exact, and every other claim follows from it as the block says. The load-bearing correction is that the block reads its own relation as having one degeneracy when it has two, and the second one, $\nu_i+\nu_j=0$, supports a global maximiser with pairwise distinct $\nu$, simultaneous block diagonality and $[\hat U,C]\ne0$. **So the route from `Splits` to commuting stays closed, and it is closed at the maximum rather than only at critical points.** What claims 4 and 5 give the node is the contrapositive: off the commuting stratum no eigenframe of $\hat U$ is critical, so a successor must supply diagonality of $\tilde U$ at the maximiser from somewhere, and `Splits` does not supply it.
