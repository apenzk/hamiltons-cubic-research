### Reviewer 318: the three senses of "graded", the labelling claim, and C2's residual ambiguity

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **O1** | (C) $\subsetneq$ (A) $\subsetneq$ (B), with (C)$\Rightarrow$(A) "because the pair's $\mathfrak p$ and $\mathfrak m$ are exactly $E_\pm$ with no kernel" and (A)$\Rightarrow$(B) "because a sign-graded $W$ is $\pm$-diagonal for the involution its own splitting defines" | **BOTH IMPLICATIONS REFUTED.** (C)$\Rightarrow$(A) fails at $W_{\mathbb{CP}^2}$ on $n=4$, the unique $\mathrm{ad}(\mathfrak u(2))$-invariant Weyl tensor of the symmetric pair $(\mathfrak{so}(4),\mathfrak u(2))$, critical at $\theta=\sqrt{3/2}$, whose kernel carries $3$ of $6$ dimensions. (A)$\Rightarrow$(B) fails under the orthogonal-involution reading, the one the C3 route actually uses, with an explicit $n=8$ witness. Under the Lie-algebra-involution reading (A)$\Rightarrow$(B) is true but vacuous, and the stated *reason* is still false. The two separating witnesses in the table are **confirmed** |
| **O2** | each result's sense is fixed by its own proof; Lemma L69 and Lemma L8 are (C), the defect screen is (A), the C3 route is (B) | **CONFIRMED for Lemma L69's own steps, REFUTED for the assembly around it.** Every step of Lemma L69 is a (C) step and none needs a weaker sense. But the classification the record uses to make (C) finite ("Cartan leaves only $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$"), is **incomplete at $n=8$**: $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ is a $\mathbb Z_2$-grading of $\mathfrak{so}(8)$ acting *irreducibly* on $\mathbb R^8$, so it is not conjugate to $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, and it carries a (C) critical point at $\theta=1.115546702$ missing from the $n=8$ census. And the **successor statement is FALSE** |
| **O3** | padded $W_{\mathbb{CP}^2}$ is critical at $\theta=\sqrt{3/2}$ with $S_{\mathfrak{mmm}}=0$; C2's premise is refuted under (A) and survives under (B) | **Measurements CONFIRMED to $10^{-16}$ at $n=4,8,10,12$. The dichotomy is REFUTED as stated and replaced by a sharper one.** The premise is refuted under **both** (A) and (C); under (B) it survives the point but step 1 of the chain loses its entire justification. **A reading exists under which the chain survives and stays useful, and it is not a change of sense at all, it is the threshold**: read (C) and take $t=\theta_0(n)$ rather than $\sqrt{3/2}$. For $n\ge12$, $\theta_0(n)>\sqrt{3/2}$ strictly, padded $W_{\mathbb{CP}^2}$ leaves the set, and no known critical point outside (C) with $\theta\ge\theta_0(n)$ has $S=0$ |

**The one-line summary.** The nesting is not a nesting. Neither inclusion is a theorem, both stated reasons are false, and the sense the record most wants (the finite one), is the sense that makes C2's positivity premise *fail*. The repair is to stop arguing about which sense "ungraded" means and to raise the threshold to the one the conjecture is actually about.

---

#### What was built

Everything below is re-derived in [scripts/reviewers/r318/](../scripts/reviewers/r318/) from the definitions alone; nothing is imported from the repository and no repository number was consulted before the corresponding quantity was computed.

$\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ via $e_i\wedge e_j\mapsto A_{ij}=E_{ij}-E_{ji}$ with $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^TB)$, so the $A_{ij}$ are orthonormal; structure constants $c_{\alpha\beta\gamma}=\langle[A_\alpha,A_\beta],A_\gamma\rangle$ built from real matrix brackets; $W^\#(A_\alpha)=\tfrac12\sum_{\gamma\delta}c_{\gamma\delta\alpha}[WA_\gamma,WA_\delta]$; $Q=W^2+W^\#$, $P=\langle W,Q(W)\rangle$, $\theta=P$ at $\lVert W\rVert=1$. $\mathcal W_n$ is the joint kernel of first Bianchi (the $\Lambda^4$ component) and Ricci, giving $\dim=10,84,300,770$ at $n=4,6,8,10$ and the $(3,5)$ slice inside $\mathcal W_8$ at $155$, the record's counts. The normalisation was fixed independently: on the coordinate-diagonal locus my $W^\#$ has vertex matrix $\Lambda^2$, so $\langle W^\#,W\rangle=\tfrac12\operatorname{tr}(\Lambda^3)$, the identity [problem.md](../findings/problem.md) records.

$\Delta(W)=\sum_{\lambda_\gamma>0}\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ over unit eigenvectors; $S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}c_{abc}^2$; $L_e=DQ(W)/(2\theta)$, whose $\tfrac12$-eigenspace contains the orbit tangent by equivariance of $Q$ alone.

**Gate before any claim.** Sphere products come back critical at residual $\le2\times10^{-16}$ with $\theta(S^3\times S^5)=1.115546702$, $\theta(S^4\times S^4)=1.145643924$, $\theta(S^5\times S^7)=1.228239158$, $\theta(S^6\times S^6)=1.236033081$. The $\mathbb{CP}^m$ family, built from Petersen–Stanfield's block description and solved for the Einstein normalisation, returns $\lambda_{\text{centre}}=\tfrac12$ and $\lambda_{\mathfrak{su}}=\tfrac1{2(m+1)}$ exactly and $\theta^2=\tfrac32,\ \tfrac{10}9,\ \tfrac{35}{36},\ \tfrac9{10}$ at $m=2,3,4,5$, the record's closed form. $\mathrm{Gr}_{\mathbb C}(2,3)$ and $\mathbb{HP}^3$ at $n=12$, built from their isotropy blocks, return $\theta=0.596068081$ and $0.852943860$ with block values $(0.54188,0.30345,0.18424)$ and $(0.43423,0.09305)$, [Lemma L10](../findings/graded-half.md)'s table to every digit printed. The $n=8$ witness [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy) reads back as $\theta=1.088948053$, $\Delta=1.512231$, $S_{\mathfrak{mmm}}=1.4\times10^{-28}$, $(\dim\mathfrak p,\dim\mathfrak m,\dim\ker)=(13,15,0)$. So the conventions coincide and the refutations below are not convention artefacts.

---

#### O1a, (C) $\Rightarrow$ (A) is FALSE, and the witness is the rival maximiser itself

**The statement fails at $n=4$.** Take the symmetric pair $(\mathfrak{so}(4),\mathfrak u(2))$. The $\mathrm{ad}(\mathfrak u(2))$-commutant inside $\mathcal W_4$ is **exactly one-dimensional** (measured, against $\dim\mathcal W_4=10$), so its generator *is* the pair-graded tensor in the sense (C) defines, uniquely up to scale. That generator is $W_{\mathbb{CP}^2}$: $\max_{x\in\mathfrak u(2)}\lVert[\mathrm{ad}\,x,W]\rVert=1.8\times10^{-16}$, it is critical at $\theta=\sqrt{3/2}$ to $2\times10^{-16}$ with residual $6.4\times10^{-16}$, and $\lVert W\rVert^2=\tfrac16$ exactly before normalising.

Its spectrum is

$$\mathrm{spec}(W_{\mathbb{CP}^2})=\{+0.816496581^{\,\times1},\ 0^{\,\times3},\ -0.408248290^{\,\times2}\},$$

so $\dim E_+=1$, $\dim E_-=2$, $\dim\ker=3$ against $\dim\mathfrak{so}(4)=6$. **The pair's $\mathfrak p=\mathfrak u(2)$ is four-dimensional and $E_+$ is one-dimensional**: the record's stated reason ("the pair's $\mathfrak p$ and $\mathfrak m$ are exactly $E_\pm$ with no kernel"), is false at this pair, and the conclusion is false with it. The kernel is precisely $\mathfrak{su}(2)\subset\mathfrak u(2)$, and the mechanism is exact: $R$'s eigenvalue on $\mathfrak{su}(m)$ is $\tfrac1{2(m+1)}$ and the Weyl shift is $c=\tfrac1{2(n-1)}=\tfrac1{2(2m-1)}$, so $\lambda_{\mathfrak{su}}=c$ **iff $m=2$**.

**The definition of (C) is internally inconsistent, and this is the point where it shows.** The record writes "(C) pair-graded: $W$ is the $\mathrm{ad}(\mathfrak p)$-invariant Weyl tensor of a symmetric pair, *equivalently* sign-graded with $\Delta=0$". At $W_{\mathbb{CP}^2}$ on $n=4$ the first half holds and the second cannot even be evaluated: $\Delta=2.2\times10^{-32}$ is reported as zero, but it traces over a one-dimensional $E_+$, and the point is not sign-graded at all. The two halves of the definition name different sets.

**How far the failure reaches, stated positively.** Within (C) read literally, $\mathfrak p$ a symmetric subalgebra of $\mathfrak{so}(n)$, i.e. $\mathfrak{so}(k)\oplus\mathfrak{so}(n-k)$, $\mathfrak u(n/2)$, or a triality class at $n=8$, the failure is confined to $n=4$: sphere products have $\lambda_{\mathfrak{so}(p)}=\tfrac1{2(p-1)}=c$ only when the other factor is empty, and the $\mathfrak u(m)$ case is the $m=2$ computation above. Under the broader "pair" usage of [Lemma L8](../findings/graded-half.md) and [Lemma L10](../findings/graded-half.md), where $\mathrm{Gr}_{\mathbb C}(2,3)$ and $\mathbb{HP}^3$ are called pairs, I built both at $n=12$ and both have $\ker W=0$. **So the counterexample is one point, and it happens to be the point the entire programme is organised around.** Every statement of the form "(C) points are sign-graded, so the defect screen applies to them" is sound for $n\ge5$ and unsound at the rival maximiser.

---

#### O1b, (A) $\Rightarrow$ (B) depends entirely on what $\sigma$ is allowed to be, and the brief's suspicion is right

**The record never says, and the C3 route settles it in the narrower direction.** [graded-half.md](../findings/graded-half.md) defines the slice as "the fixed set of conjugation by $\Lambda^2(\mathrm{diag}(I_p,-I_q))$", and [Reviewer 316](REVIEW_r316.md) works with $\sigma=\mathrm{diag}(I_p,-I_q)$ throughout. So the operative reading is **$\sigma$ an orthogonal involution of $\mathbb R^n$**, and (B) is "$W$ lies in some $(p,q)$ slice".

**Under that reading the stated reason is already false, at the equivariant points.** A sign-graded $W$ determines a $\mathbb Z_2$-grading $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$ and hence a grading automorphism $\tau$, but $\tau$ need not be $\Lambda^2$ of anything with $\sigma^2=I$. For $\mathfrak p=\mathfrak u(m)$ the grading automorphism is $\mathrm{Ad}(J)$ with $J^2=-I$, measured: $\lVert\mathrm{Ad}(J)^2-\mathrm{Id}\rVert=0$ on $\mathfrak{so}(8)$ while $\lVert J^2+I\rVert=0$, so $\mathrm{Ad}(J)$ is a genuine involution of $\mathfrak{so}(n)$ and $J$ is not an involution of $\mathbb R^n$. $W_{\mathbb{CP}^m}$ for $m\ge3$ *is* sign-graded ($\dim E_+=m^2=\dim\mathfrak u(m)$, $\ker=0$, all three bracket relations), so it is a point where the record's argument does not apply. **The conclusion happens to survive there for an unrelated reason**: the anti-holomorphic $\sigma=\mathrm{diag}(1,-1,1,-1,\dots)$ satisfies $\sigma J\sigma=-J$ exactly and commutes with $W_{\mathbb{CP}^m}$ to $4\times10^{-17}$, so $W_{\mathbb{CP}^m}$ sits in a balanced $(m,m)$ slice. The record's proof is wrong; its conclusion at this family is not.

**But the conclusion itself is false, and the witness is a Weyl tensor at $n=8$.** Sign-gradedness constrains only the *eigenspaces* of $W$, not $W$ itself, so take the $\mathfrak u(4)$-graded Weyl subspace at $n=8$, the Weyl tensors commuting with $\mathrm{Ad}(J)$, of dimension **160** against $\dim\mathcal W_8=300$, and move inside it away from the equivariant point. The witness ([W_A_not_B_n8.npy](../scripts/reviewers/r318/W_A_not_B_n8.npy), built by [r318_o1d.py](../scripts/reviewers/r318/r318_o1d.py)):

| quantity | value |
| --- | --- |
| Weyl residual (Bianchi, Ricci, trace) | $4.4\times10^{-16}$, $1.7\times10^{-16}$, $3.9\times10^{-16}$ |
| $(\dim E_+,\dim E_-,\dim\ker)$ | $(16,12,0)$, i.e. $E_+=\mathfrak u(4)$ exactly |
| bracket leaks $[\mathfrak p,\mathfrak p]\!\to\!\mathfrak m$, $[\mathfrak p,\mathfrak m]\!\to\!\mathfrak p$, $[\mathfrak m,\mathfrak m]\!\to\!\mathfrak m$ | $5.9\times10^{-29}$, $5.8\times10^{-29}$, $2.3\times10^{-29}$ |
| **sign-graded (A)** | **yes** |
| $\Delta$ | $0.495501$, so not equivariant, not (C) |
| $\dim\mathfrak k(W)$ | $0$, no infinitesimal symmetry at all |
| spectrum on $\mathfrak u(4)$ | $16$ distinct positive values, minimum gap $4.97\times10^{-3}$ |

**No orthogonal involution fixes it, and the check is exhaustive rather than a search.** Suppose $\sigma\in O(8)$, $\sigma^2=I$, and $\Lambda^2(\sigma)$ commutes with $W$. Then $\Lambda^2(\sigma)=\mathrm{Ad}(\sigma)$ preserves $E_+=\mathfrak u(4)$, and since $W\vert_{\mathfrak u(4)}$ has simple spectrum it acts on the eigenbasis by signs $\varepsilon_i=\pm1$. $\mathrm{Ad}(\sigma)\vert_{\mathfrak u(4)}$ is a Lie-algebra automorphism, so $\varepsilon_i\varepsilon_j\varepsilon_k=+1$ wherever $c_{ijk}\ne0$ in that eigenbasis. Enumerating **all $2^{16}$ sign patterns** leaves exactly one (the identity) and the answer is stable across thresholds $10^{-3}$, $10^{-5}$, $10^{-8}$, $10^{-10}$ on $|c_{ijk}|$ (the largest structure constant is $0.6165$ and the largest below $10^{-3}$ is $8.5\times10^{-4}$, so no threshold sits inside a cluster). Hence $\mathrm{Ad}(\sigma)=\mathrm{id}$ on $\mathfrak u(4)$, so $\sigma$ centralises $\mathfrak u(4)$ in $O(8)$; $\mathfrak u(4)$ acts irreducibly on $\mathbb R^8$ so its commutant is $\mathrm{span}\{I,J\}$, whose orthogonal involutions are $\pm I$, giving $\Lambda^2(\sigma)=\mathrm{Id}$, not a grading.

> **So (A) $\not\subseteq$ (B) under the orthogonal-involution reading.** A direct minimisation of $\lVert[\Lambda^2(\sigma),W]\rVert^2$ over each signature corroborates it, stalling at $1.238$, $0.033$, $1.241$, $0.032$ across signatures $(1,7),(2,6),(3,5),(4,4)$ over $12$ starts of $500$ steps each, rather than descending to zero.

**What I could NOT upgrade it to: a critical point.** The witness is a Weyl tensor, which is what (A), (B) and (C) quantify over (the record's three definitions are conditions on $W$, not on $\mathrm{Crit}(P)$) but a critical witness would be stronger. $30$ ascents inside the $160$-dimensional $\mathfrak u(4)$ slice at $n=8$, each polished by Newton to residual $\le3.4\times10^{-15}$, return exactly **two** distinct critical points: padded $W_{\mathbb{CP}^2}$ at $\theta=\sqrt{3/2}$ (dims $(1,2,25)$, $\Delta=0$) and $S^4\times S^4$ at $\theta=1.145643924$ (dims $(12,16,0)$, $\Delta=0$, $\dim\mathfrak k=12$). Both are equivariant, so **no non-equivariant sign-graded critical point on the $\mathfrak u(4)$ pair surfaced at $n=8$**, in contrast to the $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ pair, where the record's own census finds fifteen. Whether (A)$\setminus$(B) meets $\mathrm{Crit}(P)$ is open and is the natural follow-up.

**Under the Lie-algebra-involution reading the implication is true and empty.** If $\sigma$ may be any involutive automorphism of $\mathfrak{so}(n)$, then (A)$\Rightarrow$(B) holds trivially ($W$ is $\pm$-diagonal for its own $\tau$ by construction) but $\Lambda^2(\sigma)$ is then the wrong notation, and, more importantly, **the C3 route's slices are no longer the class (B) names.** The route restricts $P$ to $V=\mathrm{fix}(\Lambda^2(\mathrm{diag}(I_p,-I_q)))$; a point graded only by $\mathrm{Ad}(J)$ or by a triality automorphism lies in no such $V$, so the route cannot see it.

**The two strictness witnesses are confirmed.** The $n=8$ witness is (A) and not (C), $\Delta=1.512231>0$, and its $\mathfrak p$ has a two-dimensional commutant in $\mathrm{Sym}^2(\mathbb R^8)$, so $\mathbb R^8=\mathbb R^3\oplus\mathbb R^5$ and $\mathfrak p$ is $O(8)$-conjugate to $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$; it is therefore in (B) under either reading. Padded $W_{\mathbb{CP}^2}$ is in (B) and not in (A), see O3.

---

#### O2, Lemma L69's own steps are all (C), and the assembly around it is where the labelling breaks

**Step by step.**

| step of [Lemma L69](../findings/graded-half.md) | sense it needs | verdict |
| --- | --- | --- |
| "an equivariant graded critical point is the Weyl operator of a compact symmetric space" | (C) | sound, and *stronger than needed*: under (C) read literally the class is already tiny, so the appeal to the full symmetric-space classification is decoration |
| irreducible half ($\lVert W\rVert^2\ge\tfrac16$) and reducible half (the partition argument) | (C) | sound; both are statements about symmetric spaces |
| $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\le\tfrac13$ forcing $p,q\ge5$ at $n\ge12$ | none, pure arithmetic | sound |
| nondegeneracy of the surviving splits | none beyond the sphere-product family | sound |
| the $\mathrm{ad}(\mathfrak p)$-commutant being one-dimensional | (C) | **true but under-tested by the record**, see below |

**No step of Lemma L69 needs (A) or (B).** The one place (A) leaks in is through *how equivariance is certified*: the record's route to "equivariant" is the equivalence "on a graded point $\Delta=0$ iff $W$ is $\mathrm{ad}(\mathfrak p)$-equivariant", and $\Delta$ traces over $E_+$, so that certificate is an (A) instrument. **At $n\ge12$ this is harmless** (I found no (C) point with a kernel above $n=4$) but it is exactly the inclusion O1a refutes, so the lemma should be stated with (C) read as "$\mathrm{ad}(\mathfrak p)$-invariant for a symmetric pair" and never as "sign-graded with $\Delta=0$".

**The commutant step: confirmed, and the record's evidence had a hole.** The record measures $\dim=1$ at $(3,5),(4,4),(2,6)$ on $n=8$ and $(5,5),(4,6)$ on $n=10$, **all of them $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ pairs, none of them $\mathfrak u(m)$**, although $\mathfrak u(m)$ is the other half of the class the step quantifies over. Filled here: $\dim=1$ at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\mathfrak u(3)\subset\mathfrak{so}(6)$, $\mathfrak u(4)\subset\mathfrak{so}(8)$, and the generator is $W_{\mathbb{CP}^m}$ in each case. Agreement, but the record was asserting it over a class it had not sampled.

**The finiteness claim behind the (C) label is INCOMPLETE at $n=8$.** [fence-posts.md](../findings/fence-posts.md) reads "since gradedness forces $\mathfrak h$ symmetric and Cartan leaves only $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$, the graded set at each $n$ is the two-block sphere products together with $\mathbb{CP}^{n/2}$, a finite list", and the $n=8$ row of the census that follows lists exactly four points. I built $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)\subset\mathfrak{so}(8)$ from the quaternionic structure on $\mathbb H^2$:

- it is a $\mathbb Z_2$-grading: $\dim\mathfrak p=13$, $\dim\mathfrak m=15$, leaks $[\mathfrak p,\mathfrak p]\!\to\!\mathfrak m$, $[\mathfrak p,\mathfrak m]\!\to\!\mathfrak p$, $[\mathfrak m,\mathfrak m]\!\to\!\mathfrak m$ all $\le2.6\times10^{-29}$;
- it acts **irreducibly** on $\mathbb R^8$, its commutant in $\mathrm{Sym}^2(\mathbb R^8)$ is one-dimensional, against two for $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, so it is **not $O(8)$-conjugate** to $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ despite the matching dimension;
- its $\mathrm{ad}(\mathfrak p)$-commutant in $\mathcal W_8$ is one-dimensional, and the generator is critical at $\theta=1.115546702$, sign-graded with $\ker=0$ and $\Delta=5.5\times10^{-29}$, i.e. a **(C) point**;
- it is Morse–Bott nondegenerate: $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ with $\mathrm{mult}(\tfrac12)=15=\dim(\text{orbit})=28-13$;
- its Bianchi defect is $\lVert\mathrm{Alt}(W_-)\rVert^2=\tfrac4{21}$, which in the record's normalisation is $\tfrac2{63}=0.031746$, the value recorded for $\mathbb{HP}^2=\tau(S^3\times S^5)$.

So the census's $n=8$ row is missing a fifth graded point (and, by triality, $\mathfrak{spin}(7)$ gives a sixth grading class). The *reason* is structural and the record never states it: $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$, $n\ne8$, so involutive automorphisms are $\mathrm{Ad}(g)$ with $g^2=\pm I$ giving exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$, but at $n=8$ triality enlarges $\mathrm{Out}$ to $S_3$. **The conclusion is safe at $n\ge12$ and the argument as written is not, and $n=8$ is where every witness in this programme lives.**

**The successor statement is REFUTED.** The record offers, as the replacement for the false uniqueness premise, *"every local maximum of $P\vert_{S(V)}$ is equivariant for some grading it carries"*, and says this closes the graded half through Lemma L69. Padded $W_{\mathbb{CP}^2}$ at $n=8$ kills it:

- it lies in $V=\mathrm{fix}(\Lambda^2(\mathrm{diag}(I_4,-I_4)))$ exactly ($\lVert[\Lambda^2\sigma,W]\rVert=0.0$);
- it is a local maximum of $P$ on the **full** sphere, hence on $S(V)$: $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ to twelve digits with $\mathrm{mult}(\tfrac12)=18=\dim(\text{orbit})$, so the Hessian is strictly negative transverse to the orbit;
- $\dim\mathfrak k(W)=10$ (it is $\mathfrak u(2)\oplus\mathfrak{so}(4)$) while **every** $\mathbb Z_2$-grading subalgebra of $\mathfrak{so}(8)$ has dimension $12,13,16$ or $21$ ($\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $\mathfrak u(4)$, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, $\mathfrak{spin}(7)$).

$\mathfrak p\subseteq\mathfrak k(W)$ is necessary for equivariance and $10<12$, so padded $W_{\mathbb{CP}^2}$ is $\mathrm{ad}(\mathfrak p)$-equivariant for **no grading whatsoever**, in any of the three senses. The same count holds at $n=10$ ($\dim\mathfrak k=19$ against a minimum grading dimension of $20$) and at $n=12$ the count alone is not decisive ($\dim\mathfrak k=32$ against $30$ for $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$), but the structure is: $\mathfrak k(W)=\mathfrak u(2)\oplus\mathfrak{so}(8)$ contains neither $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ nor $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$, a $15$-dimensional simple ideal cannot embed in $\mathfrak u(2)$, so both ideals of the first would have to land in $\mathfrak{so}(8)$ and commute there ($15+15>28$), and the $\mathfrak{so}(5)$ of the second would have to centralise an $\mathfrak{so}(7)\subset\mathfrak{so}(8)$, whose centraliser is $0$; $\mathfrak u(6)$ at $36$ and the remaining splits at $34$ and above exceed $32$ outright.

> **Verdict on O2.** The labelling *is* forced by the proofs, exactly as the record says, and for Lemma L69 the label (C) is the right one. What the labelling pass does not fix, and what B3 still owes, is that **the (C) class is not the finite list the record believes it to be at $n=8$**, and that the statement built to close the graded half over slices is false.

---

#### O3, padded $W_{\mathbb{CP}^2}$, and the reading under which C2 survives

**Every measurement confirmed, independently.** Built by padding the $n=4$ Fubini–Study Weyl operator into $\mathcal W_n$:

| $n$ | $\theta$ | $\theta-\sqrt{3/2}$ | $\lVert Q(W)-\theta W\rVert$ | $(\dim E_+,\dim E_-,\dim\ker)$ | $S_{\mathfrak{mmm}}$ | $\Delta$ | $\dim\mathfrak k(W)$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| $4$ | $1.224744871392$ | $2.2\times10^{-16}$ | $6.4\times10^{-16}$ | $(1,2,3)$ | $0$ | $2.2\times10^{-32}$ | $4$ |
| $8$ | $1.224744871392$ | $2.2\times10^{-16}$ | $6.4\times10^{-16}$ | $(1,2,25)$ | $0$ | $1.8\times10^{-32}$ | $10$ |
| $10$ | $1.224744871392$ | $4.4\times10^{-16}$ | $7.4\times10^{-16}$ | $(1,2,42)$ | $0$ | $1.8\times10^{-32}$ | $19$ |
| $12$ | $1.224744871392$ | $2.2\times10^{-16}$ | $6.4\times10^{-16}$ | $(1,2,63)$ | $5.4\times10^{-66}$ | $1.8\times10^{-32}$ | $32$ |

Critical at $\theta=\sqrt{3/2}$ exactly, with $S_{\mathfrak{mmm}}=0$, and the kernel carrying $25$ of $28$ at $n=8$ and $63$ of $66$ at $n=12$, the record's figures.

**Its status in each sense.**

| sense | status | certificate |
| --- | --- | --- |
| **(C) pair-graded** | **no** | $\dim\mathfrak k(W)$ admits no grading subalgebra (above); independently, its spectrum $\{0.816497^{\times1},0^{\times25},-0.408248^{\times2}\}$ at $n=8$ matches no member of the (C) census ($S^2\times S^6$, $S^3\times S^5$, $S^4\times S^4$, $\mathbb{CP}^4$, $\mathbb{HP}^2$) and the spectrum is an $O(n)$-invariant |
| **(A) sign-graded** | **no** | $\ker W\ne0$; the sign splitting spans a $3$-dimensional subalgebra of a $28$-dimensional $\mathfrak{so}(8)$, so $S_{\mathfrak{mmm}}=S_{\mathfrak{mpp}}=0$ are vacuous |
| **(B) slice-graded** | **yes**, under both readings | $\lVert[\Lambda^2(\mathrm{diag}(I_4,-I_{n-4})),W]\rVert=0.0$ exactly at $n=8,10,12$ |

**The record's dichotomy is too coarse: the premise is refuted under (C) as well as under (A).** The chain's positivity step needs $S>0$ at every critical point of $\{\theta\ge t\}\cap\mathrm{Crit}$ outside the graded class. Padded $W_{\mathbb{CP}^2}$ is outside (C) *and* outside (A), sits at $\theta=t=\sqrt{3/2}$ on the nose, and has $S=0$. So of the three senses only (B) rescues the premise, and it does so at a price the record does not price.

**The chain's other steps do constrain the sense, and they pull the other way.** Step 1 is *"if every graded critical point with $\theta\ge t$ is Morse–Bott nondegenerate, each graded orbit is isolated"*, and the justification given for it is the census, which is exactly the argument that (C) is a finite list. Under (B) that justification evaporates: the (B)-graded critical points with $\theta\ge t$ are every critical point lying in any $(p,q)$ slice, an unclassified set, and the record's own C3 work shows it is large, the $(6,6)$ slice at $n=12$ contains four sphere products, $60$ ascents on it find five distinct limits, and an unidentified $\theta=\tfrac{5\sqrt3}8$ point at $n=8$ sits on a $14$-dimensional support. **So the two steps want opposite senses**: step 1 wants the class small, step 2 wants it large, and no single choice among (A), (B), (C) serves both. That is a sharper defect than "the chain has never said which".

> **The reading under which the chain survives and stays useful is not a sense at all, it is the threshold.** Read the graded class as (C) and take $t=\theta_0(n)$ instead of $\sqrt{3/2}$. For $n\ge12$, $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}\ge\frac{55}{36}>\frac32$, so padded $W_{\mathbb{CP}^2}$ at $\theta=\sqrt{3/2}$ **leaves the set strictly**, by $\frac1{36}$ in $\theta^2$ at $n=12$. Step 1 then holds by the record's own results: the (C) critical points with $\theta\ge\theta_0(n)$ at $n\ge12$ are the balanced sphere product alone, and it is Morse–Bott nondegenerate. Step 2 has no known counterexample, on the record's own catalogue rather than by proof: every catalogued critical point with $S=0$ outside (C), the $n=8$ witness at $\theta=1.088948$, the $C_5$ blow-up at $0.670820$, the $n=9$ point at $0.641091$, sits **below** $\theta_0(n)$ for every $n\ge12$, and padding preserves $\theta$. And $t=\theta_0(n)$ is the threshold the conjecture is actually about, so nothing is given up by raising it.

**Two things the repair does not fix, and both are sense-independent.**

- **$S_{\mathfrak{mmm}}$ is still discontinuous.** The step needs a *continuous* positive function on a compact set to extract a minimum, and $S$ jumps when an eigenvalue crosses zero. The repair moves the kernel-carrying witness out of the set but says nothing about kernel-carrying points near the boundary, and the boundary is where the argument is thinnest.
- **Step 1 still needs the $\mathbb Z_2$-grading classification of $\mathfrak{so}(n)$.** That classification is correct at $n\ge12$ and the record's stated reason for it is incomplete, as O2 shows. The gap is in the write-up rather than the fact, but it is load-bearing for exactly this step.

---

#### Found without being asked

- **$S^2\times S^6$ and $\mathbb{CP}^4$ are isospectral at $n=8$.** Both have $\theta=0.986013297$ and spectrum $\{0.845154^{\times1},0.056344^{\times15},-0.140859^{\times12}\}$. They are distinct points of the (C) class with the same $O(8)$-invariant spectrum, which is a second isospectral coincidence at $n=8$ alongside the recorded $S^3\times S^5$ / $\mathbb{HP}^2$ pair. Any argument that identifies a (C) point from its spectrum alone is unsound at $n=8$.
- **The $\mathfrak u(4)$-graded Weyl subspace at $n=8$ has dimension $160$**, against $155$ for the $(3,5)$ slice, so the $\mathfrak u(m)$ gradings are not a small corner of the graded picture; they carry more Weyl directions than the split the C3 route was tested on, and the route cannot restrict to them.
- **Padded $W_{\mathbb{CP}^2}$ is the attractor of the $\mathfrak u(4)$ slice at $n=8$**, reached by ascent from random starts inside it, and it is $\mathrm{Ad}(J)$-graded as well as orthogonally slice-graded. So the point that separates (B) from (A) is graded in *every* available sense except the two the record's own instruments test.
- **The record's Bianchi-defect normalisation is a factor of $6$ from the raw $\Lambda^4$ contraction.** My $\lVert\mathrm{Alt}(W_-)\rVert^2$ at $\mathbb{HP}^2$ is $\tfrac4{21}=0.190476$ against the recorded $0.031746=\tfrac2{63}$. Not an error anywhere, but the record never states the normalisation, and a reviewer comparing defect values across files will not be able to tell agreement from a factor of six.
