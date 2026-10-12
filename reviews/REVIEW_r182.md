# Gate 2 review 182, the n=5 certificate pipeline and the O(12)=89 recovery

| # | claim | verdict |
|---|---|---|
| 1 | O(12) degree-6 count = 89 by the coset method | **method correct, re-derived; the n=8 validation was NOT adequate, and I supplied one that is** |
| 2a | every adapted basis vector has a definite weight | upheld |
| 2b | pairing metric block-diagonal by weight, "blocks at most 14 x 4" | orthogonality upheld *for the Hermitian form only*; the size "14 x 4" is a conflation of two different blocks, the true bound is 14 x 14 |
| 2c | copies **must** be built by the SAME lowering words, else `<v_i,v_j>` is undefined | **mechanism sound, both stated reasons wrong**; the annihilator worry is impossible; "must" is too strong |
| 3 | echelon fix; over-counting diagnosis; all 24 blocks | diagnosis correct with a proof, fix correct, 24/24 reproduced, with two caveats |
| 4 | exact rational LDL^T PSD verifier | **REFUTED with a witness** against the version reviewed; since fixed in [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py) |
| 5 | the dictionary needs the copies | **REFUTED, and there is a cheaper route**, the dictionary is a pairing of products of the 41 highest-weight cubics, no copy is ever built |

Scripts: [scripts/reviewers/r182/](../scripts/reviewers/r182/). Run logs live under agent_logs/, which is git-ignored.

---

## Claim 5, there is a cheaper route, and it deletes stage 1 and stage 2 outright

This is the finding. **The dictionary can be read off the 41 highest-weight vectors alone. No copy is generated, no adapted basis of 7770 vectors exists, no per-weight square solve is performed, and the whole of claim 2c becomes moot.**

### The record's argument is a non sequitur

The record observes that for copies chosen orthogonal, `<P_i x, P_j x> = 0` identically, and concludes the Gram off-diagonals are unreachable from highest-weight vectors. The observation is true and the conclusion does not follow. What the off-diagonal is, is the **pullback** pairing into a common model,

$$B_{ij}(W)=\big\langle \varphi_i^{-1}P_i x,\ \varphi_j^{-1}P_j x\big\rangle_{V_\lambda},\qquad x=W^{3},$$

where $\varphi_i:V_\lambda\to \mathrm{Sym}^3(\mathcal W_5)$ is the $G$-map carrying a fixed $v_\lambda$ to the $i$-th highest-weight vector $u_i$. That one particular expression built from the copies degenerates says nothing about what other expressions exist.

### The identity

Write $P_i(W):=\langle W^{3},u_i\rangle$, the **cubic form of the $i$-th highest-weight vector**, a polynomial with at most 234 monomials, since $u_i$ is supported in a single weight space of $\mathrm{Sym}^3$. Put

$$A_{ij}(W):=\int_G P_i(gW)\,\overline{P_j(gW)}\,dg ,\qquad N_{ij}:=\langle u_i,u_j\rangle .$$

Then, with $d_\lambda=\dim V_\lambda$,

$$\boxed{\,A=\tfrac{1}{d_\lambda\lVert v_\lambda\rVert^{2}}\;N^{\mathsf T}\,B\,\overline N\,}$$

a **congruence by the highest-weight Gram matrix $N$**, hence $A\succeq0\iff B\succeq0$, and $\sum_{ij}(G_\lambda)_{ij}B_{ij}=\sum_{ij}(G'_\lambda)_{ij}A_{ij}$ with $G'=d_\lambda\lVert v_\lambda\rVert^{2}\,\overline N^{-1}G\,(N^{\mathsf T})^{-1}$. **$A$ is therefore a dictionary in its own right, and its definition never mentions a copy.**

*Derivation.* $\varphi_i^*\varphi_k=c_{ik}\,\mathrm{Id}$ by Schur, and $N_{ik}=\langle\varphi_i v,\varphi_k v\rangle=c_{ki}\lVert v\rVert^{2}$. Writing $P_\lambda x=\sum_k\varphi_k(y_k)$ gives $\langle gx,u_i\rangle=\lVert v\rVert^{-2}\sum_k N_{ki}\langle g y_k,v\rangle$. Schur orthogonality of matrix coefficients, $\int_G\langle\pi(g)a,b\rangle\overline{\langle\pi(g)c,d\rangle}\,dg=d^{-1}\langle a,c\rangle\overline{\langle b,d\rangle}$, then collapses the integral to $B_{kl}=\langle y_k,y_l\rangle$. The specialisation to $x=W^3$ uses only $g\cdot W^{3}=(gW)^{3}$, so $\langle gx,u_i\rangle=P_i(gW)$. $\square$

### The integral never has to be performed

$A_{ij}$ is the Reynolds average of the sextic $P_i\overline{P_j}$, and Reynolds is the orthogonal projection onto the invariants. The dictionary is only ever paired against invariant sextics, and $\langle \mathrm{Reyn}(q),J\rangle=\langle q,J\rangle$ for invariant $J$. So the 14 x 36 system is literally

$$\sum_{\lambda}\sum_{ij}(G'_\lambda)_{ij}\,\big\langle P_i\overline{P_j},\,J_b\big\rangle=\langle F_5,J_b\rangle,\qquad b=1,\dots,14,$$

an apolarity pairing of a product of two explicit cubics against an explicit invariant sextic. Both routes need the 14 invariant sextics and the invariant metric on $\mathcal W_5$; **neither is a differentiator, and neither exists in the pipeline yet** (see the gap noted under claim 2).

### Cost

| | record's route | this route |
|---|---|---|
| vectors built | $\sum_\lambda m_\lambda d_\lambda=7770$ adapted basis vectors | the 41 highest-weight vectors, already built |
| linear algebra | 24 per-weight square solves, largest 234 x 234, plus per-copy Gram | 36 cubic x cubic products (each factor at most 234 terms) and 36 x 14 pairings |
| depends on | word lists, transport, echelon completeness | nothing beyond the highest-weight vectors |

The certificate that comes out is a genuine real SOS: $\sum_{ij}G'_{ij}P_i\overline{P_j}$ is a Hermitian PSD form in $(P_1(W),\dots,P_m(W))$, hence $\sum_k\lvert L_k(W)\rvert^{2}=\sum_k(\mathrm{Re}\,L_k)^2+(\mathrm{Im}\,L_k)^2$; and the equivariant average of a PSD Gram is a PSD Gram, so passing to $A$ keeps it one.

### Validation

[cheap_dictionary.py](../scripts/reviewers/r182/cheap_dictionary.py):

- **exact, over $\mathbb Q$**, the rotation group of the cube on $\mathrm{Sym}^3(\mathbb R^3)$, where the standard 3-dimensional irreducible occurs **with multiplicity 2** (once in $H_1$, once in $H_3$). $\dim\mathrm{Hom}_G=2$ confirmed against all 24 elements; the identity holds as an exact rational equality at every sample, both in the natural basis of $\mathrm{Hom}_G$ ($N=\mathrm{diag}(2/3,1)$) and in a **mixed basis** where $N=\begin{pmatrix}14/3&-4/3\\-4/3&5/3\end{pmatrix}$ is not diagonal, so the congruence is doing real work; the control $A=B$ never holds.
- **complex**, $\mathbb Z/7$ on $\mathbb C^4$ with a character of multiplicity 2, pinning the conjugation convention: residual $2.8\times10^{-14}$.

---

## Claim 2c, the mechanism is sound and both stated reasons are wrong

### The brief's worry cannot occur, and there is a theorem

> *What happens when a word annihilates one copy's vector but not another's?*

**It cannot happen.** For a highest-weight vector $u$ of weight $\lambda$ in a finite-dimensional module, $U(\mathfrak g)u$ is a highest-weight module inside a completely reducible module, so it is a sum of irreducibles; a highest-weight module has a unique maximal proper submodule, hence a unique irreducible quotient; therefore $U(\mathfrak g)u\cong L(\lambda)$. The map $U(\mathfrak n^-)\to L(\lambda)$, $X\mapsto X.u$, is then surjective with kernel the preimage of the maximal submodule $N(\lambda)\subset M(\lambda)$ under the $U(\mathfrak n^-)$-module isomorphism $U(\mathfrak n^-)\cong M(\lambda)$. **That kernel $J(\lambda)$ is a function of $\lambda$ alone.** So $\mathrm{Ann}(u_i)=\mathrm{Ann}(u_j)$, the assignment $X.u_i\mapsto X.u_j$ is well defined and equivariant, and a word kills every copy of a block or none.

Confirmed in the live n=5 data by [word_transport.py](../scripts/reviewers/r182/word_transport.py), on the three smallest multiplicity-$\ge2$ blocks:

| block | dim | mult | words from copy 1 | transported list is a basis of every copy | words of length $\le7$ swept | annihilation patterns that differ |
|---|---|---|---|---|---|---|
| $(2,0)$ | 14 | 2 | 14 | yes, rank 14 in both | 255 | **0** |
| $(3,0)$ | 30 | 2 | 30 | yes, rank 30 in both | 255 | **0** |
| $(2,1)$ | 35 | 2 | 35 | yes, rank 35 in both | 255 | **0** |

### "Without it `<v_i,v_j>` is not even defined" is false

`<v_i,v_j>` is the ambient inner product on $\mathrm{Sym}^3(\mathcal W_5)$ and is always defined. When the copies are chosen orthogonal it is identically zero, which is why it is the wrong object, not an undefined one. The object that needs an identification is the pullback pairing $\langle\varphi_i^{-1}P_ix,\varphi_j^{-1}P_jx\rangle_{V_\lambda}$. Saying "undefined" where the truth is "defined and uninformative" is exactly what produced claim 5's non sequitur.

### "Must be built by the SAME lowering words" is sufficient, not necessary

The identification is the **unique** $G$-map sending $u_i\mapsto u_j$ (Schur), and it is determined by the two highest-weight vectors. The word list is one implementation of it and carries no extra information; any other construction realising $u_i\mapsto u_j$ gives the identical map. What *is* true, and is what the docstring should say:

- **one word list, chosen once, reused for every copy of the block.** [words_from](../scripts/runs/run_n5_dictionary.py) runs its own echelon selection inside the call, so invoking it once per copy produces per-copy lists and silently breaks the identification. The function as written gives no signal that this is forbidden.
- `reduce_against` is a free parameter of [words_from](../scripts/runs/run_n5_dictionary.py). If it is a single-pass reduction, the function reproduces claim 3's over-count exactly, in a file whose whole point is claim 3's fix.
- **normalisation.** If $M_\lambda$ is taken to be the ambient Gram of copy 1's transported basis, it equals $c_{11}$ times the abstract $V_\lambda$ Gram. That is a per-block scalar and is absorbed into $G_\lambda$, harmless, *provided the same reference copy is used for every pair $(i,j)$ of the block*. Nothing in the docstring records this.

---

## Claim 2a, 2b, one upheld, one imprecise, and a missing prerequisite

**2a upheld.** The lowering operators shift weights by a fixed root, checked in-script over all 35 x 35 entries, so a word applied to a weight vector lands in a definite weight space. The 234 that prices the largest solve is the weight-$(0,0)$ space of $\mathrm{Sym}^3$.

**2b: orthogonality holds only for the Hermitian form.** Under the invariant *bilinear* form, weight $\mu$ pairs with weight $-\mu$, so vectors of different weight are **not** orthogonal, and the Gram of weight-$\lambda$ vectors with $\lambda\ne0$ (the matrix $N$ above), vanishes identically. Every statement in claim 2b, and the invertibility of $N$ in claim 5, presuppose the Hermitian form. This is worth stating because of the next point.

**The invariant inner product on $\mathcal W_5$ does not exist anywhere in the pipeline.** [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py) builds the module and the action; nothing builds an $O(5)$-invariant metric, and the weight basis is nowhere shown to be orthogonal for one. Claim 2b, the metric $M_\lambda$, the SDP, and claim 5's route all consume it.

**"Blocks at most 14 x 4" is a conflation.** By Freudenthal, exactly, all 24 blocks reproducing the Weyl dimension ([weight_mults.py](../scripts/reviewers/r182/weight_mults.py)):

- the largest weight multiplicity is **14**, attained in $V(6,3)$ and $V(6,4)$, and **both have block multiplicity 1**;
- block multiplicity 4 occurs at $(4,2)$, whose largest weight multiplicity is 8, and at $(2,2)$, whose largest is 3.

So the 14 and the 4 never co-occur. The correct bounds: a per-weight metric block inside one copy is at most **14 x 14**; stacking the copies of a block makes it at most **32 x 32**, at $(4,2)$ where $8\times4=32$. No block is 14 x 4.

---

## Claim 3, diagnosis right, fix right, 24/24 reproduced, two caveats

**The diagnosis is correct and admits a proof, not just an anecdote.** Let $S$ be the list of residuals added. (i) The span is monotone and always inside $U(\mathfrak n^-)u$. (ii) At termination every queued $F_a w$ reduced to empty, and a partial reduction returning empty *implies* membership in the span, so $\mathrm{span}(S)$ is $F$-stable and equals the copy. (iii) Hence $\dim=\dim\mathrm{span}(S)$ is right and `total`, which counts additions, satisfies $\texttt{total}\ge\dim$ with equality exactly when the reduction is complete. **Incomplete reduction can only over-count.** Symmetrically, the fixed version's repeated leading-term reduction is the correct membership test for a set in echelon form, since any nonzero combination of the stored vectors has its leading term at one of the stored pivots.

**Fix correct, all 24 blocks match**, I ran it end to end in 101 s, $(0,0)$ through $(6,4)_{810}$, 24 OK and 0 mismatches.

Two caveats the record should carry:

- **the $(3,1)$ reading of 86 is a censored number, not a measurement.** The cap is `want + 5`, and $81+5=86$. That run was aborted at the cap; the true over-count was $\ge86$. The $(4,0)$ 56-against-55 and $(5,0)$ 92-against-91 are genuine.
- **only one copy per block is ever generated.** [run_n5_copies.py](../scripts/runs/run_n5_copies.py) takes `ns[0]`, so 17 of the 41 copies are never built and never checked against the dimension formula. My word-transport run covers three of them.

---

## Claim 4, REFUTED with a witness

Against the version I read, [the verifier](../scripts/runs/run_n5_sdp.py) returned **`True` on $\begin{pmatrix}-1&0\\0&0\end{pmatrix}$**, which is negative semidefinite and manifestly not PSD.

*Mechanism.* When the largest remaining diagonal is $0$ at index $p>k$, the branch checked only row $p$, appended a zero pivot and `continue`d **without swapping $p$ into position $k$**. Index $k$ (carrying the negative diagonal) then fell outside `range(k+1, n)` and was never examined again. A random sweep put the rate at **255 of 20000** symmetric matrices of size 2–4 with entries in $\{-2,\dots,2\}$, every one of them in the dangerous direction: an indefinite matrix certified PSD. [ldl_witness.py](../scripts/reviewers/r182/ldl_witness.py) carries the witnesses and an independent ground truth by exact principal minors.

[The file](../scripts/runs/run_n5_sdp.py) has since been fixed in commit d4f6c66; the fixed branch (reject on any negative remaining diagonal, then require the whole remaining submatrix to vanish), agrees with the minor-based truth on all 20000.

---

## Claim 1, the coset method is right, and the n=8 validation was not adequate

### Re-derivation

$O(2r)=SO(2r)\sqcup SO(2r)\tau$ with each component of Haar mass $\tfrac12$, so $\dim V^{O}=\tfrac12\big(\dim V^{SO}+\int_{\text{coset}}\chi\big)$, the halving is right. For the density: $g\in O(2r)^-$ has eigenvalues $\{t_j^{\pm1}\}_{j<r}$ together with $+1$ and $-1$, and $\mathrm{Ad}(g)$ on $\mathfrak{so}(2r)=\Lambda^2$ of that has eigenvalues

- $t_i^{\pm1}t_j^{\pm1}$ for $i<j$, the $D_{r-1}$ roots;
- $t_j^{\pm1}\cdot 1$ and $t_j^{\pm1}\cdot(-1)$, whose factors multiply to $\prod_j(1-t_j^{2})(1-t_j^{-2})$, the $C_{r-1}$ **long** roots $\pm2e_j$;
- $1\cdot(-1)=-1$, contributing the constant $2$.

$D_{r-1}\cup\{\pm2e_j\}=C_{r-1}$, so the twisted density **is** a Weyl integration for $C_{r-1}$, as claimed, and $W(C_m)=W(B_m)$ is what [coset_o.py](../scripts/reviewers/r180/coset_o.py) uses.

### The n=8 validation was not adequate

Two reasons. It exercises $C_3$ at $k=4$, while the O(12) number needs **$C_5$ at $k=6$**, a different rank and a different degree. And it compares against the *stable-range table*, which is the same quantity the method is being asked to produce, rather than against an independently known count at $n=8$.

### The validation that is adequate

[coset_check.py](../scripts/reviewers/r182/coset_check.py) pushes the coset integral to $r=2,\dots,6$ ($C_1$ through **$C_5$**), at $k$ up to **6**, on two families whose $O(n)$-invariant counts are known outright:

| family | prediction | $n=4$ | $6$ | $8$ | $10$ | $12$ |
|---|---|---|---|---|---|---|
| defining $V$ | $1$ for $k$ even, $0$ odd | OK | OK | OK | OK | OK |
| $\Lambda^2V$ | partitions of $k$ into even parts $\le n$ | OK | OK | OK | OK | OK |

All ten pass, including the exact rank and degree the O(12) run uses.

### Independent corroboration of 89 itself

At **odd** $n$ no coset is needed at all: $O(n)=SO(n)\times\{\pm I\}$ and $-I$ acts trivially in even degree, so $O(n)$-invariants are $SO(n)$-invariants. Running the coset-free path:

| $n$ | 7 | 8 | 9 | 10 | 11 | 12 | 13 |
|---|---|---|---|---|---|---|---|
| $k=4$ | 6 | **7** | 7 | 7 | 7 | 7 | 7 |
| $k=5$ | 16 | 18 | 18 | **19** | 19 | 19 | 19 |
| $k=6$ | 67 | 82 | 86 | 88 | 88 | **89** | 89 |

Three consistent readings. The count reaches its stable value **exactly at $n=2k$**, verified at $k=4$ ($n=7$ gives 6, $n=8$ gives the stable 7) and at $k=5$ ($n=9$ gives 18, $n=10$ gives the stable 19). The stable degree-6 value is **89**, obtained at $n=13$ with no coset machinery whatever, and $n=11$ gives 88; monotonicity in $n$ then brackets $n=12$ between 88 and 89, and the $n=2k$ rule picks 89. The coset method's answer sits exactly where two coset-free computations and a rule verified at two other degrees put it.

**A fourth reading, structural.** The chiral (det-twisted) multiplicities the method reports first switch on at $k=n/2$ ($[0,0,0,2,7,40]$ at $n=8$, $[0,0,0,0,0,3]$ at $n=12$) which is the $\varepsilon$-tensor degree threshold, six Weyl tensors supplying just enough indices to fill $\varepsilon_{i_1\dots i_{12}}$. And at $n=10$ the method reports $[0,0,0,0,0,0]$, i.e. **no** chiral invariants at $k=n/2$: for $n\equiv2\bmod4$ the Hodge star on $\Lambda^{n/2}$ squares to $-1$, so there is no real self-dual splitting to support one. The method reproduces a mod-4 phenomenon nobody fed it.

**Verdict.** The coset method is correct and O(12)=89 stands. The licence for it comes from the validation above, not from the n=8 run.

---

## What I would change in the record

1. **Take claim 5's route.** Stage 1 (copies) and stage 2 (adapted-basis expansion) are not needed; the dictionary is $\langle P_i\overline{P_j},J_b\rangle$ on the highest-weight cubics. This also retires every hazard in claim 2c.
2. **Build the invariant metric on $\mathcal W_5$ and the 14 invariant sextics.** Both routes stall without them, and neither exists.
3. Restate 2c as "one word list, chosen once, reused across the block", and drop "not even defined".
4. Correct "14 x 4" to 14 x 14 per weight inside a copy, 32 x 32 across the copies of $(4,2)$.
5. Record that $(3,1)$'s 86 was the cap, and that only one copy per block has been dimension-checked.
