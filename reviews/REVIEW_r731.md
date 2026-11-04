# Review r731, Lemma L161, $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2$ with $\kappa_n=\frac{(n-1)(2n-1)}4$

Gate 2, cold brief. Target: [Lemma L161](../findings/curvature-invariants.md). Conventions quoted from [conventions.md](../findings/conventions.md). Fox read at source in [fox-1901.04012.txt](https://arxiv.org/abs/1901.04012), not through [notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md).

**Verdict: CONFIRMED.** The value holds and the chain holds link by link. Three defects, all in the citation apparatus and none touching the constant: the theorem number is wrong, the $n=6$ case cites a lemma whose stated hypothesis it violates, and the record carries a $\kappa_5$ this lemma does not reach.

## Claim table

| # | claim under test | verdict |
| --- | --- | --- |
| 1 | Fox Thm 1.3 says what L161 quotes | **REFUTED as a citation**, the quoted words are Theorem 3.2's; Theorem 1.3 is the *direct* statement about $(\mathrm{MC}_W(V^*),*)$ and is a stronger citation |
| 2 | commutative | CONFIRMED, by construction |
| 3 | Euclidean metrized ($\langle X\circ Y,Z\rangle$ totally symmetric) | CONFIRMED, derived here from the definitions |
| 4 | $\mathcal W_n$ closed under $\circ$ | CONFIRMED (Fox Lemma 5.7; conventions' $Q:\mathcal W_n\to\mathcal W_n$) |
| 5 | a unit is needed somewhere | **REFUTED**, Theorem 3.2's proof uses none, and Fox states *"an exact algebra is nonunital"*, so the conclusion is incompatible with a unit |
| 6 | irreducibility, and $O(n)$ against $SO(n)$ | CONFIRMED and **not load-bearing**, Thm 3.2 asks only for *a real Lie group*; $O(n)$ serves at every $n\ge4$ |
| 7 | a normalisation factor goes missing | **REFUTED**, no constant of Fox's is imported; the conclusion imported is proportionality, which is invariant under rescaling either the metric or the product |
| 8 | the ten $L_e$-eigenvalues, complete, with four genuine zeros | CONFIRMED on three independent checks |
| 9 | $\langle W\rangle$ carries $1$, not $\theta$ or $1/\theta$ | CONFIRMED, $e\circ e=Q(W)/\theta^2=W/\theta=e$ |
| 10 | $\theta^2\mathop{\mathrm{tr}}(L_e^2)=\frac{(n-1)(2n-1)}4$ | CONFIRMED as a rational-function identity in $p,q$ |
| 11 | $n\ge6$ is the right range | CONFIRMED, but the $n=6$ instance is $(3,3)$, which [L27](../findings/nondegeneracy.md)'s **statement** excludes |
| 12 | nothing on the record consumes $\kappa_5$ | CONFIRMED for load-bearing use; but [second-order.md](../findings/second-order.md) prints $\kappa_5=9$ as a fitted value |
| 13 | *"the step the record was missing"* | **overstated**, [second-order.md](../findings/second-order.md) already records the trace identities as Fox's; what L161 adds is the odd-$n$ evaluation |

## 1. The citation is to the wrong theorem, and the right one is better

L161 writes: *"[Fox](../references/fox-2019-nonassociative-curvature-algebra/notes.md) Theorem 1.3 gives it: a nontrivial finite-dimensional Euclidean metrized commutative algebra on which a real Lie group acts irreducibly by isometric automorphisms is exact and Killing metrized…"*

That sentence is **Theorem 3.2**, at line 440 of the source dump. Fox's Theorem 1.3, at line 159, reads instead:

> Let $(V,h)$ be a Euclidean vector space of dimension at least 4. The algebra $(\mathrm{MC}_W(V^*),*)$ is exact and Killing metrized. Moreover: (1) The Killing form $\tau_*(X,Y)=\mathop{\mathrm{tr}}L_*(X)L_*(Y)$ is a nonzero multiple of $\langle\cdot,\cdot\rangle$. (2) If $\dim V>4$, then $(\mathrm{MC}_W(V^*),*)$ is simple.

So Theorem 1.3 is a statement about **this algebra**, at **every $n\ge4$**, with the hypotheses already discharged inside Fox's own proof. Citing it removes the hypothesis-checking step entirely rather than adding one. [notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md) has this right, *"Theorem 1.3 states both conclusions for this algebra directly and is the right citation"*, and the lemma block lost it while keeping the number.

**Repair:** cite Theorem 1.3 for the conclusion and Theorem 3.2 for the mechanism, and drop *"Both hypotheses were already checked against this algebra in the reference notes"*, which describes work Fox did.

## 2. Every hypothesis, checked against $(\mathcal W_n,\circ,\langle\cdot,\cdot\rangle)$ from the definitions

Taking the harder road anyway, since Theorem 3.2 is what the argument as written invokes. The product is [conventions.md](../findings/conventions.md)'s $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ with $Q(W)=W^2+W^\#$.

- **Commutative.** A polarisation is symmetric in its two arguments. Holds by construction.
- **Euclidean.** $\langle\cdot,\cdot\rangle$ is positive definite on $\mathcal W_n$.
- **Metrized**, i.e. $\langle X\circ Y,Z\rangle$ totally symmetric. Derived here rather than taken from the record. On the $W^2$ half the trilinear form is $\tfrac12\big(\mathop{\mathrm{tr}}(XYZ)+\mathop{\mathrm{tr}}(XZY)\big)$, the sum of the two cyclic classes, hence $S_3$-invariant. On the $\#$ half, evaluate on the rank-one elements $v\otimes v$ that span $S^2(\mathfrak{so}(n))$: conventions' $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ gives $\langle (v\otimes v)\#(w\otimes w),u\otimes u\rangle=\tfrac12\langle[v,w],u\rangle^2$, and $\langle[v,w],u\rangle$ is conventions' totally antisymmetric $c_{abc}$, whose **square is totally symmetric**. Polarising off the rank-ones extends it. So the algebra is metrized, and the reason is the same one conventions' third sense of $T$ gives.
- **A subalgebra at all.** $Q$ maps $\mathcal W_n$ to itself (Böhm–Wilking's $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(Q(W))=0$; Fox's own Lemma 5.7), and $\mathcal W_n$ is a linear subspace, so $\circ$ closes.
- **Nontrivial.** $\circ$ is not identically zero: any critical point supplies an idempotent, and Fox's Lemma 10.1 supplies one unconditionally.
- **Isometric automorphisms.** $O(n)$ acts on $\Lambda^2$ by $\Lambda^2g$, preserving both operator composition and the Lie bracket, hence both halves of $Q$; the action is orthogonal for the pair-Frobenius metric.
- **Irreducibly.** Fox asserts it inside the proof of 1.3 (*"The group $O(n)=O(V,h)$ acts on $\mathrm{MC}_W(V^*)$ isometrically and irreducibly"*), at every $n\ge4$.

### The unit question, which is where the earlier route died

**No unit is required, and the conclusion actively forbids one.** Fox's own definitions, at line 152 of the dump: an algebra is *exact* if $\mathop{\mathrm{tr}}L_\circ(x)=0$ for all $x$, and *"an exact algebra is nonunital"*. Theorem 3.2 concludes exactness, so any algebra it applies to has no unit, $\mathcal W_n$'s unitlessness is a consequence, not an obstruction.

Reading Theorem 3.2's proof line by line: $x\mapsto\mathop{\mathrm{tr}}L_\circ(x)$ is $G$-invariant, so its kernel is everything by irreducibility; $\tau_\circ$ is $G$-invariant; the endomorphism $A$ with $\tau_\circ(x,y)=h(Ax,y)$ is $G$-invariant and $h$-self-adjoint; Schur gives $A=\kappa\,\mathrm{Id}$. Nothing unital enters. The **only** appearance of an idempotent is in the *alternative* argument for $\kappa\ne0$, where it is **produced** (as an extremum of $h(x\circ x,x)$ on the unit sphere), never assumed, and $\kappa\ne0$ is not consumed by L161 in any case, which computes $\kappa$ outright.

### $O(n)$ against $SO(n)$, not load-bearing here

Theorem 3.2 asks for *"a real Lie group $G$"*: connectedness and simplicity appear nowhere in its hypotheses or its proof. Fox needs *connected simple* only for **Theorem 3.1**, the simplicity statement, which is why his proof of 1.3 switches to $SO(n)$ for clause (2) and why clause (2) is restricted to $\dim V>4$. **L161 consumes clause (1) only.** So $O(n)$ suffices at every $n\ge4$; $SO(n)$ also suffices at every $n\ge5$; and the record's remark that the $SO(4)$-invariant symmetric forms are two-dimensional at $n=4$ costs nothing, because $O(4)$ is available and Theorem 1.3 is stated at $n\ge4$ for exactly that reason.

*Consequence the block understates:* L161's scope note says *"$n=4$ is Fox's own Theorem 1.5(2)"*. Theorem **1.3** already gives $W$-independence at $n=4$; 1.5(2) supplies the value.

## 3. The normalisation, no factor can go missing

What L161 imports from Fox is **proportionality**, and proportionality survives every rescaling in sight:

- rescale the metric, $h\mapsto ch$: $\tau_\circ=\kappa h$ becomes $\tau_\circ=(\kappa/c)(ch)$;
- rescale the product, $\circ\mapsto c'\circ$: $L\mapsto c'L$, so $\tau\mapsto c'^2\tau$, still a multiple of $h$;
- and the *two* invariant inner products on an $O(n)$-irreducible space are proportional by Schur regardless.

The constant itself is never taken from Fox, Remark 1.4 says explicitly that Theorem 1.3 *does not give* $\kappa$ above $\dim V=4$, but computed in the record's own normalisation at $W_{p,q}$. So the notes' *"Fox's metric is the complete contraction, exactly $4\times$ the Frobenius metric"* is a remark for comparing values, not an input to the chain, and its absence from L161 costs nothing.

## 4. The evaluation, and three checks on the spectrum

With $d_m=\tfrac{m(m+1)}2-1$, $e_m=\tfrac{m(m-1)}2$, $\lambda_m=\tfrac{m-2}{2(m-1)}$, $\mu=\tfrac{n-2}{2(p-1)(q-1)}$ and $\theta^2=\tfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, exact symbolic arithmetic gives

$$\theta^2\Big(1+\tfrac{pq}4+d_p\lambda_p^2+d_q\lambda_q^2+(d_pd_q+e_pe_q)\mu^2\Big)\;=\;\frac{(p+q-1)\big(2(p+q)-1\big)}4$$

**identically in $p$ and $q$**, the difference from $\frac{(n-1)(2n-1)}4$ simplifies to $0$, not to zero at sampled splits. Three further checks, all identities in $p,q$:

1. **The ten dimensions sum to $\dim\mathcal W_n$**, $1+\dim\mathrm{Weyl}_p+\dim\mathrm{Weyl}_q+pq+d_p+d_q+d_pd_q+e_pe_q+q\dim X_p+p\dim X_q-\tfrac{n(n-3)(n+1)(n+2)}{12}=0$. The list is complete as a decomposition of the space.
2. **$\mathop{\mathrm{tr}}(L_e)=0$** on the ten values, identically, the constraint L27 uses to force $-\mu$ on $S^2_0\otimes S^2_0$, and the one that would catch a wrong zero. Reversing the two tensor summands leaves $30,30,48,70$ at $(3,5),(4,4),(5,5),(5,7)$, reproducing L27's own discriminator.
3. **The eigenvalue on $\langle W\rangle$ is $1$**, and it is not a convention: $e\circ e=Q(W)/\theta^2=\theta W/\theta^2=e$, so $e$ is the idempotent and $L_ee=e$.

*Note in passing:* $\mathop{\mathrm{tr}}(L_e^2)$ is unchanged by swapping the signs on $S^2_0\otimes S^2_0$ and $\Lambda^2\otimes\Lambda^2$, since both enter as $\mu^2$. So L161 is insensitive to the one assignment L27 had to argue for.

**Identity or coincidence?** Identity, and the direction matters. That the answer depends on $(p,q)$ only through $n$ is *forced* by Fox before any split is chosen, so the $p,q$-independence is a **consistency check that both Fox's theorem and L27's spectrum pass**, not a coincidence of dimensions. The value $\frac{(n-1)(2n-1)}4$ is the part genuinely supplied by the evaluation.

## 5. Two independent corroborations, neither of them a second route to the same constant

### (a) $n=4$ against Fox's explicit Jordan model, free of both normalisations

At an idempotent $e$, the number $\nu:=\mathop{\mathrm{tr}}(L_\circ(e)^2)$ is **invariant under rescaling the product** (if $*=c\circ$ then $e_*=e_\circ/c$ and $L_*(e_*)=L_\circ(e_\circ)$) and involves no metric at all. And $\kappa/\theta^2=\nu$ is invariant under rescaling the metric as well, since $\kappa$ and $\theta^2$ carry the same weight. So $\nu$ can be transported between Fox's conventions and the record's with nothing to track.

Fox Theorem 1.5(1) gives an isometric algebra isomorphism $\mathrm{MC}^\pm_W(V^*)\cong(\mathrm{Sym}_0(\mathbb R^3),\times,\tfrac43G)$ at $\dim V=4$, with $\times$ the trace-free part of the Jordan product and $G(A,B)=\tfrac13\mathop{\mathrm{tr}}(AB)$. Solving $A\times A=A$ over diagonal traceless $A$ gives roots of one quadratic, so the entries take two values in a $2{+}1$ pattern: the idempotents are exactly the $O(3)$-orbit of $A=\mathop{\mathrm{diag}}(-1,-1,2)$. The spectrum of $L_\times(A)$ on the five-dimensional $\mathrm{Sym}_0(\mathbb R^3)$ is $\{1,-1,-1,\tfrac12,\tfrac12\}$, so

$$\nu=\mathop{\mathrm{tr}}\big(L_\times(A)^2\big)=\tfrac72,\qquad \frac{\nu}{\tfrac43G(A,A)}=\frac{7/2}{8/3}=\frac{21}{16},$$

**reproducing Fox's Theorem 1.5(2) exactly.** Transporting $\nu$ to the record: Fox's Lemma 9.7 makes $\mathrm{MC}^\pm_W$ *orthogonal ideals*, so $L(e)$ annihilates the other half and the half-algebra trace is the full-algebra trace; $\mathbb{CP}^2$'s Weyl tensor is self-dual, so the record's $W_{\mathbb{CP}^2}$ is one of these idempotents; and the record has $\theta(W_{\mathbb{CP}^2})^2=\tfrac32$. Hence

$$\kappa_4=\nu\,\theta^2=\tfrac72\cdot\tfrac32=\tfrac{21}4=\frac{(n-1)(2n-1)}4\Big|_{n=4}.$$

An external check of the *formula's* $n=4$ instance, from Fox's own computation, with every normalisation cancelled. It also confirms the notes' $\kappa_{\mathrm{Fox}}=\tfrac14\kappa_{\mathrm{Frob}}$ as a by-product.

### (b) The third moment, a different symmetric function of the same operator

[second-order.md](../findings/second-order.md) carries an independent closed form $\mathop{\mathrm{tr}}(L_x^3)=-\tfrac{5n-1}8\langle x^2,x\rangle+\tfrac{n(n-5)}8\langle x^\#x,x\rangle$. Feeding L27's ten eigenvalues into $\mathop{\mathrm{tr}}(L_e^3)$ and inverting that form backs out $\mathop{\mathrm{tr}}(W^3)$ at $W_{p,q}$. Against it, compute $\mathop{\mathrm{tr}}(W^3)$ directly and with no reference to $L_e$: on the diagonal locus the $\Lambda^2$ spectrum is the multiset of entries of the sectional matrix $K$, which for a two-block product is hollow, block-constant and row-sum-zero, hence one-dimensional; normalising $\sum_{a<b}K_{ab}^2=1$ and summing cubes gives $\mathop{\mathrm{tr}}(W^3)$ outright.

**The two agree exactly at fourteen splits**, $(3,3)$, $(3,4)$, $(3,5)$, $(4,4)$, $(3,6)$, $(4,5)$, $(5,5)$, $(3,9)$, $(4,8)$, $(5,7)$, $(6,6)$, $(7,9)$, $(3,13)$, $(8,8)$, spanning $n=6$ to $16$ and both parities, as surds and not as decimals. At $(3,3)$ the pair comes out $\big(\mathop{\mathrm{tr}}W^3,\langle W,W^\#\rangle\big)=\big(\tfrac{\sqrt{10}}{30},\tfrac{3\sqrt{10}}{10}\big)=(0.10541,0.94868)$, which is exactly the $(0.105,0.949)$ that [curvature-invariants.md](../findings/curvature-invariants.md)'s post F19 records from an unrelated computation, and their sum is $\theta=\sqrt{10}/3$.

This tests the eigenvalue list through the **third** power sum, where L161 uses only the second, and against a quantity the record obtained without $L_e$. It is the strongest evidence the ten values have.

## 6. The defects

### D1, the $n=6$ case cites a lemma whose stated hypothesis it violates

L161 needs a split with $p,q\ge3$ at each $n\ge6$. At $n=6$ the **only** such split is $(3,3)$, and [L27](../findings/nondegeneracy.md)'s statement opens *"Let $p,q\ge3$ with $(p,q)\ne(3,3)$"*.

The content L161 needs does survive there: L27's own text says *"at $(3,3)$ the decomposition holds and two scalars collide, $\mu=\tfrac12$"*, so it is the nondegeneracy conclusion that fails and not the decomposition or the eigenvalues. Reading the values at $(3,3)$ gives $\{1,\tfrac12,\tfrac14,0,-\tfrac12\}$, which is the spectrum [L13](../findings/curvature-invariants.md) independently records for $S^3\times S^3$. But **as written, the $n=6$ instance of L161 quotes a lemma outside its stated range**, and the record's own habit is that a stated range is the thing a consumer may use.

**Repair:** one sentence in L161 saying that $(3,3)$ is used for the decomposition and the ten values only, both of which L27 establishes there, and that the $(3,3)$ exclusion concerns the $\tfrac12$-multiplicity alone. *Nothing is lost either way at $n=6$: even $n$ was already proved.*

### D2, $\kappa_5$ is on the record as a fitted value, and L161 says it is unsettled

L161's scope reads *"$n=5$ admits no such split and is not settled here"*. Meanwhile [second-order.md](../findings/second-order.md) displays $\kappa_n=\tfrac{(n-1)(2n-1)}4$ *"giving $9,\ 13.75,\ 19.5,\ 26.25$ at $n=5,\dots,8$"* (that is $\kappa_5=9$), over a provenance sentence saying the constant *"was first fitted to those four points and then checked at them, which is no derivation"*, with the repair supplied *"at every even $n$"*. So $\kappa_5=9$ stands on the record with no derivation behind it and L161 does not reach it.

Checked: **nothing load-bearing consumes $\kappa_5$.** [L13](../findings/curvature-invariants.md)'s margin runs at $n=12$, [L133](../findings/second-order.md) at $n\ge12$, and second-order.md's moment-method slack table starts at $n=6$. So this is a record hygiene defect, not a live error, but the two blocks contradict each other about whether $\kappa_5$ is known.

*And Fox's Lemma at line 838 closes the obvious escape*: $\mathcal W_5$ does embed in $\mathcal W_6$ as a subalgebra under padding, but $\mathop{\mathrm{tr}}(L^2_W)$ is a trace over the **whole** algebra, so the constant does not descend. $n=5$ is genuinely open by this route.

### D3, *"the step the record was missing"* is overstated

L161 opens *"The step the record was missing is that $\kappa_n$ does not depend on $W$."* [second-order.md](../findings/second-order.md) already says *"The trace identities are Fox's Theorem 1.3 … $\mathop{\mathrm{tr}}(L_x)=0$ and $\mathop{\mathrm{tr}}(L_xL_y)=\kappa_n\langle x,y\rangle$. They have now been re-derived unwittingly three times in this project."* So $W$-independence was on the record with the same citation.

What L161 genuinely contributes is the **evaluation at a split that exists at odd $n$**, the earlier derivation ran at the balanced sphere product, which needs $n$ even. That is the real content and it is real: it retires the odd $n\ge15$ gap. The block should claim it rather than the citation.

## 7. What would falsify the lemma

Not a numerical disagreement at some tensor, Schur forbids one once $\mathcal W_n$ is $O(n)$-irreducible. The falsifiers are structural, in order of reachability:

1. **A proper nonzero $O(n)$-submodule of $\mathcal W_n$ at some $n\ge6$.** This is the single hypothesis on which the whole $W$-independence rests, and it is the one Fox asserts rather than proves in the paragraph L161 leans on. It would make the space of invariant symmetric forms multi-dimensional and $\kappa_n$ a function of $W$, exactly the $SO(4)$ situation at $n=4$, transplanted upward. *Classical representation theory says no: the Weyl module is the $O(n)$-irreducible of Young label $[2,2]$, and $[2,2]$ has fewer than $n/2$ rows for every $n\ge5$.*
2. **A second sphere product at the same $n$ returning a different $\theta^2\mathop{\mathrm{tr}}(L_e^2)$.** Checked and none exists: the identity is in $p,q$ separately, so every split at a given $n$ returns $\frac{(n-1)(2n-1)}4$. Had one disagreed, either Fox's step or L27's spectrum would be broken, and the check does not say which.
3. **A wrong eigenvalue in L27's ten, arranged so that both $\mathop{\mathrm{tr}}(L_e)=0$ and the dimension sum still close.** The third-moment check of §5(b) is aimed exactly here and finds nothing at fourteen splits.

## 8. Method note

Exact rational and symbolic arithmetic throughout; no floating point except where quoting the record's own decimals back at it. The computations are screens on objects constructed for the purpose, the rational function in $p,q$, the $5\times5$ matrix of $L_\times(\mathop{\mathrm{diag}}(-1,-1,2))$, and the sectional matrix of $W_{p,q}$, seconds each, and no sweep, search or census was run.
