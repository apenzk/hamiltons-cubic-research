# Review r847: I36's $\Lambda^4$ family, its witness, and the two conclusions drawn from it

*Cold Gate 2 brief. Every claim below was argued from the definitions quoted in the brief and from the block text read off disk at [diagonal-half.md:1082-1099](../findings/diagonal-half.md#L1082), with no access to the author's reasoning. Every constant was checked against [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean) rather than against a display. Two independent derivations of the $\Lambda^4$ normalisation are given in section 2 and they agree. The programme is on an analysis-only footing, so the one machine run here is a screen of claims already derived by hand, reported as a screen and load-bearing for nothing.*

## Claim table

| # | claim | verdict | reason |
|---|---|---|---|
| 1a | a coordinate-diagonal $W$ has $W_{abcd}=0$ at four distinct indices | CONFIRMED | four distinct indices force $\{i,j\}\ne\{k,l\}$, which is the definition |
| 1b | "so every power $W^k$ has too" | REFUTED AS STATED | the no-four-distinct class is not closed under powers, and the closed-form $M$ of section 1 has $M_{1234}=0$ against $(M^2)_{1234}=1$. The true reason is diagonality in a fixed basis |
| 1c | a $\Lambda^4$ element with no four-distinct entry is zero | CONFIRMED | total antisymmetry kills every repeated-index component, and $\mathrm{Alt}(R)_{ijij}=0$ falls out directly |
| 1d | $\mathrm{Alt}(W^k)=0$ at every coordinate-diagonal $W$ | CONFIRMED, and GAP on provenance | true, and one line shorter through $\mathfrak b$. [bounds.md:333](../findings/bounds.md#L333) already carries this sentence for $W^2$ under [L199](../findings/bounds.md#L319), uncited here |
| 2a | the Vandermonde matrix on distinct nonzero $\mu$ is invertible | CONFIRMED | $\det=\prod_j\mu_j\prod_{i<j}(\mu_j-\mu_i)$, so both hypotheses are consumed and the block names both |
| 2b | "for every $k\ge1$" | CONFIRMED AS ALGEBRA, overstated | $k=1,\dots,m$ suffices, $m$ the number of distinct nonzero eigenvalues, at most $\binom n2$ |
| 2c | the equivalence is two-directional | CONFIRMED | the reverse direction is termwise, the forward one is the inversion |
| 3 | $\mathfrak b(P_\mu)$ is basis-independent inside a degenerate eigenspace | CONFIRMED | $P_\mu$ is a basis-free element of $S^2\Lambda^2$ and $\mathfrak b$ is linear on it. One line, and the block gives none |
| 4 | $\mathfrak b(\mathrm{Id})=0$, and $\mathfrak b(P_0)$ is forced | CONFIRMED | $\mathrm{Id}=\sum_{a<b}\varphi_{ab}\odot\varphi_{ab}$ with every $\varphi_{ab}$ decomposable, and $\sum_\mu P_\mu=\mathrm{Id}$ |
| 5 | the six forms are an orthonormal basis of $\Lambda^2\mathbb R^4$ | CONFIRMED | fifteen Gram determinants vanish, six norms are $1$, and the span is all six $e_{ab}$ |
| 6 | each of the six is decomposable | CONFIRMED | each is a literal $u\wedge v$, and $\mathrm{Pf}^2=\det=0$ at matrix rank two |
| 7 | the witness is not coordinate-diagonal | CONFIRMED, argument GAP | $\langle e_4\rangle$ also lies in three of the six planes, so "the three forms sharing a line force $f_1=\pm e_1$" skips a branch. A complete two-line argument is supplied, and it also covers every $n\ge4$ after padding |
| 8 | first Bianchi is free on the all-decomposable set | CONFIRMED | $\mathfrak b$ vanishes termwise at every eigenvalue vector, and the block claims no converse |
| 9a | any proof of the characterisation inside $\mathcal W_n$ must consume Ricci-flatness | CONFIRMED AS ALGEBRA | valid, because every other defining condition of $\mathcal W_n$ holds at the witness. The licensed form is narrower than the printed one and section 9 states it |
| 9b | "a route through $\mathfrak b$ alone cannot work" | REFUTED AS STATED | at $n=4$ the $\mathfrak b$ family together with Ricci-flatness IS a characterisation of the locus, derived in section 10.5 from the record's own formula |
| 9c | $\lvert\mathrm{Ric}(W)\rvert=10$ at the screened point | GAP | a positive claim resting on compute. The closed form is two lines: $\star$ sends $e_1\wedge g_2$ to $g_3\wedge e_4$, which is not an eigenform, so the witness fails Weyl at every admissible eigenvalue choice |
| 10a | a Weyl tensor at $n=4$ commutes with $\star$ | CONFIRMED, theorem | Singer-Thorpe block form. The vanishing of the traceless Ricci block alone is what does it, which sharpens the block's own point |
| 10b | $\omega\wedge\omega\ne0$ for nonzero $\omega\in\Lambda^\pm$ | CONFIRMED | $\omega\wedge\omega=\pm\lVert\omega\rVert^2\mathrm{vol}$ on $\Lambda^\pm$ |
| 10c | the four-cycle has spectrum $\{1,1,-1,-1,0,0\}$ with $E_1=\mathrm{span}\{\varphi_{12},\varphi_{34}\}$, Ricci-flat and Bianchi | CONFIRMED | four row sums vanish, the eigenbasis is the $\varphi$ basis, and $\mathfrak b$ vanishes termwise |
| 11a | $\omega_1\pm\omega_2$ are decomposable with mutually orthogonal planes | CONFIRMED | the two wedges are exhibited and all four inner products vanish |
| 11b | $\mathrm{Pf}(\omega_1)+\mathrm{Pf}(\omega_2)=\tfrac12-\tfrac12=0$, $\omega_2$ anti-self-dual | CONFIRMED | $\star(e_{13}+e_{24})=-(e_{13}+e_{24})$, and both Pfaffians come out as printed |
| 11c | a witness must defeat "their planes can be made mutually orthogonal across the whole spectrum at once" | REFUTED | six planes of one frame at $n=4$ are never pairwise orthogonal. The condition is "spanned by the lines of one orthonormal frame" |
| 12a | [F37](../findings/fence-posts.md#L299) and [F6](../findings/fence-posts.md#L164) are cleared | CONFIRMED, vacuously | neither post governs a witness construction, so clearing them costs nothing and evidences nothing |
| 12b | "[F44] asks for a frame variation or a character mix, which is exactly what (iii) is" | REFUTED AS STATED | F44 lives in [second-order.md:845](../findings/second-order.md#L845), not in fence-posts.md, and it governs single-character Rayleigh quotients. The witness is one fixed operator, not a variation |
| 12c | "it also needs no value hypothesis, so if it closes it proves more than I36 asks" | REFUTED | padded $W_{\mathbb{CP}^2}$ is a local maximum at $\theta=\sqrt{3/2}$ exactly and is not coordinate-diagonal, so a value-free I36 is false, as this same file says fifteen lines above |
| 13 | is any of it on the record | GAP, three sites | [bounds.md:333](../findings/bounds.md#L333) for (i) and for the $n=4$ formula that settles (iii)'s open question, [bounds.md:167](../findings/bounds.md#L167) for the simple-eigenvalue certificate, [diagonality.md:19](../findings/diagonality.md#L19) for the Plücker criterion that (iv)'s collapse re-derives |

## The one line that matters

Keep the witness and rewrite both conclusions: (i) is [bounds.md:333](../findings/bounds.md#L333) re-derived with an invalid middle step, "a route through $\mathfrak b$ alone cannot work" is false at $n=4$ where that same recorded formula turns the test into $\mathrm{spec}(W^+)=\mathrm{spec}(W^-)$ and hence into coordinate-diagonality outright, and "needs no value hypothesis" contradicts padded $W_{\mathbb{CP}^2}$ fifteen lines above it.

## Conventions, quoted from the brief

- **$\mathrm{Alt}$** is the projection onto the $\Lambda^4$ summand of $S^2\Lambda^2$, in components $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, and the base layer proves $\mathrm{Alt}=\tfrac13\,\mathrm{bianchi}$ where bianchi is the undivided cyclic sum.
- **$\mathfrak b:S^2\Lambda^2\to\Lambda^4$** is the Bianchi obstruction map, $\omega\odot\eta\mapsto\omega\wedge\eta$, from [L179](../lean/HamiltonsCubic/Results/L179Statement.lean)(b): "first Bianchi $\iff\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0\in\Lambda^4$. The zero eigenvalues drop out."
- **$\mathrm{Alt}(A)=\tfrac16\,\mathfrak b(A)$**, machine-checked. **The record's wedge is TWICE the Pfaffian**, fixed at [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean): `wedgeSelf X a b c d = 2*(X a b * X c d - X a c * X b d + X a d * X b c)`.
- **"Diagonal" means diagonal in the coordinate 2-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$**, from [conventions.md](../findings/conventions.md), which adds: "A generic spectral eigenbasis is essentially never of that form, and conflating the two is what makes the diagonal case look liftable."
- The inner product on $\Lambda^2$ is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, making $\{\varphi_{ab}\}_{a<b}$ orthonormal, and $\varphi_{ab}=E_{ba}-E_{ab}$.
- A $2$-form satisfies $\omega\wedge\omega=0$ **exactly when it is decomposable**, $\omega=u\wedge v$, and its support is then the plane $\langle u,v\rangle$.
- [L176](../findings/diagonal-half.md#L568): the coordinate-diagonal locus inside $\mathcal W_n$ has $\Lambda^2$-rank at least four. [L177](../findings/diagonal-half.md#L592): every edge-carrying component of the support graph has at least four edges, the minimum being $C_4$ with weight $(1,-1,1,-1)$.
- **I36**: if $W$ is a local maximiser of $P$ on the unit sphere with $\theta>\sqrt{3/2}$ then $W$ is diagonal in some coordinate frame.

## Hypothesis inventory, checked against the objects

| object | pair antisymmetry | pair symmetry | first Bianchi | Ricci-flat | criticality | value hypothesis |
|---|---|---|---|---|---|---|
| coordinate-diagonal $W$ of (i) | yes, by construction on $\Lambda^2$ | yes, $W$ symmetric | holds, and (i) never uses it | not assumed and not needed | not used | not used |
| every power $W^k$ of it | yes | yes, powers of a symmetric operator | **fails in general**, which is the whole point of the family | not inherited | not used | not used |
| $P_\mu$ and $\mathrm{Id}$ of (ii) and (iv) | yes | yes | $\mathfrak b(\mathrm{Id})=0$, so $\mathrm{Id}$ satisfies it | $\mathrm{Ric}(\mathrm{Id})\ne0$, and nothing needs it | not used | not used |
| the witness $W$ of (iii) | yes | yes | **holds**, every eigenform decomposable | **fails**, derived in section 9.2 without compute | not claimed | not claimed |
| the four-cycle of the $\mathcal W_4$ corollary | yes | yes | holds | **holds**, all four row sums zero | not claimed, and not needed | not used |
| padded $W_{\mathbb{CP}^2}$, the object 12c collides with | yes | yes | holds | holds | local maximum, [r316](REVIEW_r316.md) | $\theta=\sqrt{3/2}$ **exactly**, which is what breaks 12c |

Two hypotheses are named nowhere in the block and are load-bearing somewhere in it. The first is orthogonality of the frame in "coordinate-diagonal", without which section 7's argument has no contradiction to reach. The second is that $\{\omega_\alpha\}$ in (ii) is an orthonormal eigenbasis rather than any spanning set, without which $\mathrm{Alt}(A)=\tfrac16\sum\mu_\alpha\omega_\alpha\wedge\omega_\alpha$ is not the spectral decomposition of $A$.

## 1. (i)'s three steps

**1a holds by definition.** Coordinate-diagonal means $W_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$, so $W_{ijij}=w_{ij}$, $W_{ijji}=-w_{ij}$ and nothing else survives. Four distinct indices give $\{i,j\}\cap\{k,l\}=\emptyset$, so the entry vanishes.

**1b is invalid as an inference.** The stated premise is the property "no four-distinct entry", and that class is strictly larger than the coordinate-diagonal one and is not closed under operator composition. In the orthonormal basis $\{\varphi_{ab}\}$ of $\Lambda^2\mathbb R^4$ let $u,v,w$ be the coordinate vectors of $\varphi_{12},\varphi_{13},\varphi_{34}$ and put

$$M=uv^{\mathsf T}+vu^{\mathsf T}+vw^{\mathsf T}+wv^{\mathsf T}.$$

Every nonzero component of $M$ sits at an index-pair pair $(\{1,2\},\{1,3\})$ or $(\{1,3\},\{3,4\})$, each of which shares an index, so $M$ has no four-distinct entry. Its square carries $uv^{\mathsf T}vw^{\mathsf T}=uw^{\mathsf T}$, so $(M^2)_{(12),(34)}=1$ and $(M^2)_{1234}=1$, a four-distinct entry. The repair is one clause: a coordinate-diagonal $W$ is diagonal in the fixed basis $\{\varphi_{ab}\}$, every power is diagonal in that same basis, and hence every power is coordinate-diagonal and inherits 1a. The same slip sits at [bounds.md:333](../findings/bounds.md#L333), where the identical sentence is used for $W^2$, so the repair is owed at two sites.

**1c holds, and the direct check the brief asks for confirms it.** $\mathrm{Alt}$ lands in $\Lambda^4\subset S^2\Lambda^2$, so its image is totally antisymmetric and every component with a repeated index vanishes identically. Reading the formula rather than the projection property gives the same answer at the asked-for slot: with $(k,l)=(i,j)$,

$$\mathrm{Alt}(R)_{ijij}=\tfrac13\big(R_{ijij}+R_{iijj}+R_{ijji}\big)=\tfrac13\big(w_{ij}+0-w_{ij}\big)=0,$$

the middle term dying on antisymmetry in the first pair. So "$\mathrm{Alt}(W^k)=0$" means the full tensor vanishes, with no residue at repeated indices, and the claim ignores nothing.

**1d is true and is two steps shorter through $\mathfrak b$.** A coordinate-diagonal $W$ has the $\varphi_{ab}$ as an eigenbasis, so does every power, and $\mathfrak b(W^k)=\sum_{a<b}w_{ab}^k\,\varphi_{ab}\wedge\varphi_{ab}=0$ because each $\varphi_{ab}$ is decomposable. That route needs neither 1a nor 1c, which makes (i) a special case of (ii) plus decomposability rather than an independent derivation. Recording it as "DERIVED, and it is one line" is right about the length and wrong about which line.

## 2. (ii)'s Vandermonde step, and the normalisation

Write the distinct nonzero eigenvalues as $\mu_1,\dots,\mu_m$ and put $v_j=\mathfrak b(P_{\mu_j})\in\Lambda^4$. For $k\ge1$ the zero eigenvalue contributes $0^k=0$, so $\mathrm{Alt}(W^k)=\tfrac16\sum_{j}\mu_j^kv_j$. Taking $k=1,\dots,m$ gives the matrix $M_{kj}=\mu_j^k$ with

$$\det M=\Big(\prod_j\mu_j\Big)\prod_{i<j}(\mu_j-\mu_i).$$

**Both hypotheses are consumed and the block uses the right one.** Distinctness supplies the Vandermonde product, and nonzeroness supplies the extra $\prod_j\mu_j$ that the shift from $k=0$ to $k=1$ costs. Either hypothesis alone leaves the matrix singular.

**The quantifier is larger than the argument.** Only $k=1,\dots,m$ is used, with $m\le\binom n2$, so the left side may be replaced by a finite conjunction. That makes the equivalence stronger rather than weaker, so it is an overstatement with no cost, and the block's own word "finite" is the accurate one.

**The equivalence is genuinely two-directional.** Forward is the inversion above. Backward is termwise: if every $\mathfrak b(P_\mu)=0$ at $\mu\ne0$ then every $\mathrm{Alt}(W^k)$ is a combination of zeros.

**The $\tfrac16$ checks against the definition rather than against a display.** With $A_{ijkl}=\sum_\alpha\mu_\alpha(\omega_\alpha)_{ij}(\omega_\alpha)_{kl}$,

$$\mathrm{Alt}(A)_{ijkl}=\tfrac13\sum_\alpha\mu_\alpha\big[\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk}\big]=\tfrac13\sum_\alpha\mu_\alpha\cdot\tfrac12(\omega_\alpha\wedge\omega_\alpha)_{ijkl}=\tfrac16\,\mathfrak b(A)_{ijkl},$$

the middle equality being exactly the factor two in [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean). The spectral reading is consistent with the record's inner product: with $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ and the action $(AX)_{ij}=\tfrac12A_{ijkl}X_{kl}$, that same $A$ satisfies $A\omega_\beta=\mu_\beta\omega_\beta$ for an orthonormal $\{\omega_\alpha\}$. A second, independent pin at $n=4$ is in section 10.5, and it agrees with the record's own $\Lambda^4$ value.

## 3. (ii)'s basis-independence claim

**Confirmed, and the argument is shorter than the sentence claiming it needs one.** $P_\mu$ is the orthogonal projector onto $E_\mu$, an element of $S^2\Lambda^2$ defined without reference to any basis, and $\mathfrak b$ is linear on $S^2\Lambda^2$, so $\mathfrak b(P_\mu)$ is basis-free. Reading it through a basis gives the same answer directly: if $\omega'_\beta=\sum_\alpha O_{\beta\alpha}\omega_\alpha$ with $O^{\mathsf T}O=\mathrm{Id}$ then

$$\sum_\beta\omega'_\beta\wedge\omega'_\beta=\sum_{\alpha\gamma}\Big(\sum_\beta O_{\beta\alpha}O_{\beta\gamma}\Big)\,\omega_\alpha\wedge\omega_\gamma=\sum_\alpha\omega_\alpha\wedge\omega_\alpha.$$

**What the block gets right and states loosely.** It is the *per-eigenform* reading that is basis-dependent, and the block says so. The dependence is real: inside $E=\mathrm{span}\{\varphi_{12},(e_{13}+e_{24})/\sqrt2\}$ the individual self-wedges are $0$ and $-\mathrm{vol}$ in one basis and neither in a rotated one, while the sum is $-\mathrm{vol}$ in both.

## 4. (ii)'s zero-eigenvalue clause

**Both halves hold.** $\mathrm{Id}=\sum_{a<b}\varphi_{ab}\odot\varphi_{ab}$ and every $\varphi_{ab}$ is decomposable, so $\mathfrak b(\mathrm{Id})=\sum_{a<b}\varphi_{ab}\wedge\varphi_{ab}=0$. Since $\sum_\mu P_\mu=\mathrm{Id}$ over all distinct eigenvalues including zero, linearity gives $\mathfrak b(P_0)=-\sum_{\mu\ne0}\mathfrak b(P_\mu)$, so $\mathfrak b(P_0)$ is determined by the others and vanishes when they do. Where $0$ is not an eigenvalue the clause reads $P_0=0$ and is empty. The word "forced" is the right one and "drops out" is the right one, in that order.

## 5. (iii)'s six forms are an orthonormal basis

For decomposables the inner product is the Gram determinant, $\langle u\wedge v,x\wedge y\rangle=(u\cdot x)(v\cdot y)-(u\cdot y)(v\cdot x)$, which follows from $\tfrac12\operatorname{tr}$ on $uv^{\mathsf T}-vu^{\mathsf T}$ in one expansion. With $g_2,g_3$ an orthonormal pair inside $\langle e_2,e_3\rangle$ and $e_1,e_4$ orthogonal to both:

- every pair among $e_1\wedge g_2$, $e_1\wedge g_3$, $e_1\wedge e_4$ shares $e_1$ and the second factors are pairwise orthogonal, so all three inner products are $1\cdot0-0\cdot0=0$
- each of those three against each of $e_2\wedge e_3$, $e_2\wedge e_4$, $e_3\wedge e_4$ has every entry of its Gram matrix carrying an $e_1$ factor against a vector orthogonal to $e_1$, so all nine vanish
- the last three are distinct members of $\{e_a\wedge e_b\}$, pairwise orthogonal
- all six norms are $1$, each being a wedge of an orthonormal pair.

**Spanning.** $e_1\wedge g_2=\cos t\,e_{12}+\sin t\,e_{13}$ and $e_1\wedge g_3=-\sin t\,e_{12}+\cos t\,e_{13}$ span $\langle e_{12},e_{13}\rangle$ for every $t$, and the remaining four are $e_{14},e_{23},e_{24},e_{34}$. Six orthonormal elements of a six-dimensional space are a basis, so the eigenbasis is legitimate and the witness does not collapse here.

## 6. (iii)'s six forms are decomposable

Each is written as $u\wedge v$ in the block itself, which is decomposability by the brief's definition, $e_1\wedge g_2$ included: $g_2$ being a rotated vector rather than a frame vector changes nothing, since decomposability asks for two vectors and not for two frame vectors. The wedge vanishes for the stated reason as well: $\mathrm{Pf}(\omega)^2=\det\omega$ and a decomposable $2$-form has matrix rank two, so $\det\omega=0$ at $n=4$ and $\omega\wedge\omega=2\mathrm{Pf}(\omega)\,\mathrm{vol}=0$. Hence $\mathfrak b(P_\mu)=0$ at all six simple eigenvalues, and $\mathrm{Alt}(W^k)=0$ for every $k\ge1$ by section 2.

## 7. (iii)'s non-diagonality, where the argument is incomplete and the claim survives

Since all six eigenvalues are distinct and nonzero, every eigenspace is a line, so a frame witnessing coordinate-diagonality must have each $f_a\wedge f_b$ equal to $\pm$ one of the six listed forms. Equivalently the six *support planes* of the frame must be exactly

$$P_1=\langle e_1,g_2\rangle,\ P_2=\langle e_1,g_3\rangle,\ P_3=\langle e_1,e_4\rangle,\ P_4=\langle e_2,e_3\rangle,\ P_5=\langle e_2,e_4\rangle,\ P_6=\langle e_3,e_4\rangle.$$

**The block's route skips a branch.** Its step is "the three forms sharing a line force $f_1=\pm e_1$". Exactly two lines lie in three of the six planes, $\langle e_1\rangle$ in $P_1,P_2,P_3$ and $\langle e_4\rangle$ in $P_3,P_5,P_6$, so nothing forces the distinguished line to be $e_1$ and the branch $f_1=\pm e_4$ is unexamined. That branch does close, which is why the claim survives: with $f_1=\pm e_4$ the three planes through it are $P_3,P_5,P_6$, so $\{f_2,f_3,f_4\}=\{\pm e_1,\pm e_2,\pm e_3\}$ and the remaining planes are $\langle e_1,e_2\rangle,\langle e_1,e_3\rangle,\langle e_2,e_3\rangle$, of which the first is not $P_1=\langle e_1,g_2\rangle$ for $\sin2t\ne0$.

**A complete argument with no case split, and it is two lines.** Two distinct planes of one frame meet in a frame line or in $0$, since they are $\langle f_a,f_b\rangle$ and $\langle f_c,f_d\rangle$ in a basis. Now $P_4\cap P_5=\langle e_2\rangle$ and $P_1\cap P_4=\langle g_2\rangle$, both nonzero, so $\pm e_2$ and $\pm g_2$ would both be frame vectors. They are distinct lines and $e_2\cdot g_2=\cos t\ne0$, contradicting orthonormality of the frame. Equivalently and just as short: in any frame every plane's orthogonal complement is again one of the six, and $P_1^\perp=\langle g_3,e_4\rangle$ is none of them, since $\sin2t\ne0$ keeps $g_3$ out of $\langle e_2,e_4\rangle$ and out of $\langle e_3,e_4\rangle$.

**And the intersection argument survives padding, which section 9 needs.** Pad $W$ by zeros to any $n\ge4$. The six eigenvalues stay simple and nonzero and their forms stay decomposable, so the test still passes, while the six planes still force $\pm e_2$ and $\pm g_2$ into the frame by the same two intersections. So the witness is a witness at every $n\ge4$, not only at $n=4$.

## 8. Is first Bianchi free on the all-decomposable set

**Confirmed.** If $W=\sum_\alpha\mu_\alpha\,\omega_\alpha\odot\omega_\alpha$ with $\{\omega_\alpha\}$ an orthonormal eigenbasis of decomposables then $\mathfrak b(W)=\sum_\alpha\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ termwise, for every eigenvalue vector, so $\mathrm{Alt}(W)=\tfrac16\mathfrak b(W)=0$ and first Bianchi holds identically on that set. The block's word "free" is exact: the condition costs the eigenvalues nothing.

**The converse the block does not claim is false, so the block does not overreach.** $\mathrm{Alt}(W)=0$ holds at plenty of tensors with non-decomposable eigenforms, (iv)'s own $E$ among them and $W_{\mathbb{CP}^2}$ as well, whose whole nonzero eigenspace consists of non-decomposables ([problem.md:156](../findings/problem.md#L156)). The block asserts the implication in the one direction that holds.

## 9. What the witness licenses, which is the finding the record will carry

### 9.1 The inference is valid, and its licensed form is narrower than the printed one

The witness satisfies pair antisymmetry, pair symmetry and first Bianchi, and fails Ricci-flatness. Those four are the defining conditions of $\mathcal W_n$. Suppose a valid argument establishes "for $W\in\mathcal W_n$, the test implies coordinate-diagonality" while appealing only to properties that hold at the witness. Then the same argument applies to the witness and concludes it is coordinate-diagonal, which section 7 refutes. So every valid argument appeals to some property failing at the witness, and any such property is a consequence of the $\mathcal W_n$ axioms that does not follow from the other three, hence is derived using Ricci-flatness. **So "must consume Ricci-flatness" is licensed**, and the brief's worry that "not implied by the rest" is weaker than "a proof must use it" does not bite here, precisely because the other three axioms are verified at the witness rather than merely not refuted.

**Two scope clauses the printed sentence omits.** The first is the direction: (i) proves the easy half with no Ricci-flatness anywhere, so what must consume it is the half reading "test implies diagonal". The second is the dimension: the argument as printed exhibits a witness at $n=4$, and a per-$n$ claim at $n\ge5$ would need the witness there. Section 7's padding paragraph supplies that, so the conclusion holds at every $n\ge4$ once padding is stated. Neither clause is in the block.

### 9.2 The Ricci claim needs no compute, and the screen should be replaced

The block establishes the failure at the witness by a screened norm, $\lvert\mathrm{Ric}(W)\rvert=10$ at $t=0.7$, which is a positive claim resting on a run and leaves open whether some other admissible eigenvalue choice is Ricci-flat. Two lines settle it for all of them. The frame $(e_1,g_2,g_3,e_4)$ is orthonormal and positively oriented, since $g_2\wedge g_3=e_2\wedge e_3$, so

$$\star(e_1\wedge g_2)=g_3\wedge e_4=-\sin t\,(e_2\wedge e_4)+\cos t\,(e_3\wedge e_4),$$

a nontrivial combination of two eigenforms carrying different eigenvalues, hence not an eigenform. So $\star$ does not preserve the $\mu_1$ eigenline and $W$ does not commute with $\star$. By section 10.1 a Weyl tensor at $n=4$ does commute with $\star$, so the witness is outside $\mathcal W_4$ for **every** choice of six distinct nonzero eigenvalues, and since first Bianchi holds the condition it fails is Ricci-flatness. The block's own $\mathcal W_4$ corollary gives the same conclusion by a second route, simple nonzero eigenvalues being impossible there, so the block already contained the analytic replacement for its screen and cited the screen instead.

### 9.3 "A route through $\mathfrak b$ alone cannot work" is too strong

Read as "no function of the spectral data $\{\mathfrak b(P_\mu)\}$ separates the locus from its complement inside the first-Bianchi symmetric operators", the sentence is exactly right, and it also covers $\mathfrak b(f(W))$ for every function $f$ of $W$, since those are determined by that data. Read as printed it retires the route, and section 10.5 exhibits the route working at $n=4$: the $\mathfrak b$ family together with Ricci-flatness is a characterisation there. The sentence also leaves unquantified what "alone" excludes, since $\mathfrak b$ applied to tensors built from $W$ other than functions of the operator, $W\#W$ and $W^2\#I$ among them, is not touched by the witness at all, and [L199](../findings/bounds.md#L319) is a live example of the record pairing $\mathrm{Alt}(W^2)$ with such objects.

## 10. The $\mathcal W_4$ corollary, and what it settles that the block leaves open

### 10.1 Weyl commutes with $\star$: a theorem, and the sharper form of it

At $n=4$, $\Lambda^2=\Lambda^+\oplus\Lambda^-$ and $S^2\Lambda^2$ splits as $S^2\Lambda^+\oplus S^2\Lambda^-\oplus(\Lambda^+\otimes\Lambda^-)$ of dimensions $6+6+9=21$. The Singer-Thorpe block form of a curvature operator is $\begin{pmatrix}W^++\tfrac s{12}&B\\B^{\mathsf T}&W^-+\tfrac s{12}\end{pmatrix}$, in which the off-diagonal block $B$ is the traceless Ricci tensor under $S^2_0\mathbb R^4\cong\Lambda^+\otimes\Lambda^-$, both nine-dimensional, and the traces carry the scalar curvature and the $\Lambda^4$ part. An operator commutes with $\star$ exactly when it is block-diagonal, so $B=0$ is the condition, and **the traceless Ricci block alone is what must vanish**: the scalar and $\Lambda^4$ parts commute with $\star$ by themselves, $\star$ commuting with $\mathrm{Id}$ and with $\star$. That is a theorem rather than an assumption, it is classical, and the block asserts it with no citation. It also sharpens the block's own headline, since what a proof must consume is the traceless Ricci block rather than all of $\mathrm{Ric}(W)=0$. The record uses the same decomposition already, at [stratum-two-negative.md:31](../findings/stratum-two-negative.md#L31) as $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ and at [nondegeneracy.md:362](../findings/nondegeneracy.md#L362) as $P=9(\det W^++\det W^-)$.

### 10.2 $\omega\wedge\omega\ne0$ on $\Lambda^\pm$

For $\omega=\omega^++\omega^-$ the Pfaffian is $\mathrm{Pf}(\omega)=\tfrac12(\lVert\omega^+\rVert^2-\lVert\omega^-\rVert^2)$, pinned at the unit self-dual $(e_{12}+e_{34})/\sqrt2$, where $\mathrm{Pf}=\tfrac12$, and at the unit anti-self-dual $(e_{13}+e_{24})/\sqrt2$, where $\mathrm{Pf}=-\tfrac12$, the cross terms vanishing because $\omega\wedge\eta=\langle\omega,\star\eta\rangle\,\mathrm{vol}$ and $\Lambda^+\perp\Lambda^-$. So $\omega\wedge\omega=\pm\lVert\omega\rVert^2\,\mathrm{vol}$ on $\Lambda^\pm$, nonzero off zero, and $\pm\mathrm{vol}$ at unit norm as the block says. The corollary follows: a simple nonzero eigenvalue of a $\star$-commuting $W$ has its eigenline inside $\Lambda^+$ or inside $\Lambda^-$, so $\mathfrak b(P_\mu)=\pm\mathrm{vol}\ne0$, and every nonzero eigenvalue of a $W\in\mathcal W_4$ passing the test is degenerate.

### 10.3 The four-cycle is as described, and it is a genuine Weyl tensor

The weight is $w_{12}=1$, $w_{23}=-1$, $w_{34}=1$, $w_{14}=-1$, $w_{13}=w_{24}=0$, so the $\Lambda^2$ spectrum is $\{1,-1,1,-1,0,0\}=\{1,1,-1,-1,0,0\}$ as claimed, and the $\mu=1$ eigenspace is spanned by the two edges of weight $1$, namely $\mathrm{span}\{\varphi_{12},\varphi_{34}\}$, again as claimed. **Bianchi**: the $\varphi_{ab}$ are decomposable, so $\mathfrak b=0$. **Ricci-flat**: for coordinate-diagonal $R$ the off-diagonal Ricci entries vanish, since $R_{ikjk}\ne0$ needs $\{i,k\}=\{j,k\}$, and the diagonal entries are the row sums $\sum_{k\ne i}w_{ik}$, which are $1+0-1$, $1-1+0$, $0-1+1$ and $-1+0+1$. All four vanish, so the consistency check the block runs on its own corollary is sound, and the two nonzero eigenvalues are degenerate exactly as the corollary requires. The block's reason for $\mathfrak b(P_1)=0$, one self-dual against one anti-self-dual direction, agrees with the termwise reason, $(+1)+(-1)=0$ against $0+0$.

### 10.4 A structural fact the block does not state, and it is forced

A coordinate-diagonal Weyl tensor at $n=4$ has **equal weights on opposite edges**. The four vanishing row sums give $p+q+r=0$, $p+r'+q'=0$, $q+r'+p'=0$ and $r+q'+p'=0$ for $p=w_{12}$, $q=w_{13}$, $r=w_{14}$, $p'=w_{34}$, $q'=w_{24}$, $r'=w_{23}$. Subtracting the first two and the last two and adding gives $q=q'$, subtracting gives $r=r'$, and then the third gives $p'=p$. So the locus inside $\mathcal W_4$ is exactly $\{w_{12}=w_{34},\,w_{13}=w_{24},\,w_{14}=w_{23},\ \text{sum}=0\}$, a two-parameter family up to frame, and the four-cycle is its $(1,0,-1)$ member.

### 10.5 The question the block leaves open is closed at $n=4$, from the record's own formula

At $n=4$ the whole family collapses to one scalar per power. Since $\omega\wedge\eta=\langle\omega,\star\eta\rangle\,\mathrm{vol}$,

$$\mathfrak b(A)=\Big(\sum_\alpha\mu_\alpha\langle\omega_\alpha,\star\omega_\alpha\rangle\Big)\mathrm{vol}=\operatorname{tr}(A\star)\,\mathrm{vol},\qquad \mathrm{Alt}(A)=\tfrac16\operatorname{tr}(A\star)\,\star,$$

which is a second and independent pin of the $\tfrac16$, because at $A=W^2$ it reproduces the record's own $\mathrm{Alt}(W^2)=\tfrac{\lVert W^+\rVert^2-\lVert W^-\rVert^2}6\star$ at [bounds.md:333](../findings/bounds.md#L333) exactly. For $W\in\mathcal W_4$, which commutes with $\star$, this gives

$$\mathrm{Alt}(W^k)=0\ \text{for every }k\ge1\iff\operatorname{tr}\big((W^+)^k\big)=\operatorname{tr}\big((W^-)^k\big)\ \text{for }k=1,2,3\iff\mathrm{spec}(W^+)=\mathrm{spec}(W^-),$$

the last step being Newton's identities on two $3\times3$ symmetric matrices. And that condition is coordinate-diagonality. In one direction, section 10.4 says a coordinate-diagonal Weyl tensor is $W^+=W^-=\mathrm{diag}(p,q,r)$ in the aligned bases $\{(e_{12}+e_{34}),(e_{13}-e_{24}),(e_{14}+e_{23})\}/\sqrt2$ and $\{(e_{12}-e_{34}),(e_{13}+e_{24}),(e_{14}-e_{23})\}/\sqrt2$, whose spectra coincide. In the other, $SO(4)\to SO(\Lambda^+)\times SO(\Lambda^-)=SO(3)\times SO(3)$ is surjective, so $W^+$ and $W^-$ may be diagonalised independently, and the eigenvalues may be put in the same order because a permutation matrix times a sign matrix lies in $SO(3)$ and acts on a diagonal matrix as the permutation. The resulting aligned tensor has eigenvalue $p$ on $\mathrm{span}\{e_{12},e_{34}\}$, $q$ on $\mathrm{span}\{e_{13},e_{24}\}$ and $r$ on $\mathrm{span}\{e_{14},e_{23}\}$, which is coordinate-diagonal.

**So on $\mathcal W_4$ the test is a characterisation of the coordinate-diagonal locus**, Ricci-flatness being spent twice, once at $\star$-commutation and once at the row sums. That answers the block's "what remains open is whether Ricci-flatness closes the gap the witness opens" in the affirmative at $n=4$, it subsumes the degeneracy corollary as a consequence ($W^+=W^-$ up to frame makes every eigenvalue even in multiplicity), and it is why 9b's "a route through $\mathfrak b$ alone cannot work" cannot stand as printed. It says nothing about $n\ge5$, where there is no $\star$ on $\Lambda^2$ and the collapse to one scalar per power fails.

## 11. (iv)'s orthogonality claim

$\omega_1=(e_{12}+e_{34})/\sqrt2$ and $\omega_2=(e_{13}+e_{24})/\sqrt2$. Then $(e_2+e_3)\wedge(e_4-e_1)=e_{24}+e_{12}+e_{34}+e_{13}=\sqrt2(\omega_1+\omega_2)$ and $-(e_2-e_3)\wedge(e_1+e_4)=e_{12}-e_{24}-e_{13}+e_{34}=\sqrt2(\omega_1-\omega_2)$, so both are decomposable as printed. The four inner products between the two planes' spanning vectors are

$$(e_2+e_3)\cdot(e_2-e_3)=0,\quad(e_2+e_3)\cdot(e_1+e_4)=0,\quad(e_4-e_1)\cdot(e_2-e_3)=0,\quad(e_4-e_1)\cdot(e_1+e_4)=0,$$

so the planes are mutually orthogonal and the stated frame $\tfrac1{\sqrt2}(e_2+e_3,e_4-e_1,e_2-e_3,e_1+e_4)$ is orthonormal, with $f_1\wedge f_2=(\omega_1+\omega_2)/\sqrt2$ and $f_3\wedge f_4=-(\omega_1-\omega_2)/\sqrt2$, both of unit norm. Since $E=\mathrm{span}\{f_1\wedge f_2,f_3\wedge f_4\}$ and the remaining four $f_a\wedge f_b$ are orthogonal to it, all six are eigenforms and $W=\nu\,\mathrm{Id}+(\mu-\nu)P_E$ is coordinate-diagonal in that frame. The collapse is correctly diagnosed. $\mathrm{Pf}(\omega_1)=\tfrac12$ and $\mathrm{Pf}(\omega_2)=-\tfrac12$ come out as printed, $\omega_2$ is anti-self-dual under $\star e_{13}=-e_{24}$, and $\mathfrak b(P_E)=2(\mathrm{Pf}(\omega_1)+\mathrm{Pf}(\omega_2))\mathrm{vol}=0$, consistent with the factor two in [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean) rather than with a Pfaffian-normalised wedge.

**The joint condition drawn from the collapse is misstated.** The block's box asks a witness to defeat "the decomposable elements of each $E_\mu$ span it AND their planes can be made mutually orthogonal across the whole spectrum at once". Mutual orthogonality across the whole spectrum is not a property of the locus: at $n=4$ a coordinate-diagonal $W$ has six planes and $\langle e_1,e_2\rangle$ meets $\langle e_1,e_3\rangle$ in a line, and three pairwise-orthogonal planes need six dimensions. What is true is the two-dimensional case the block verified, where $f_1\wedge f_2$ and $f_3\wedge f_4$ force orthogonal *complements*. The correct general condition is that the eigenspaces are spanned by the $f_a\wedge f_b$ of ONE orthonormal frame, and the frame is what section 7 argues about. The generalisation from complementary pairs to all pairs is the defect.

## 12. The fence claim

**[F37](../findings/fence-posts.md#L299)** closes the third and fourth-variation calculus on the orbit tangent and asks a successor to consume directions of $A(\tfrac12)$ transverse to it. The block uses no variation of any order, so the post is cleared, and it is cleared vacuously: F37 governs a calculus this route never enters, so clearing it is no evidence for the route.

**[F6](../findings/fence-posts.md#L164)** says spectral moments of $L_W$ are the wrong invariants, with a quantified negative on the Track A value bound. $\mathfrak b$ is a $\Lambda^4$-valued map on $S^2\Lambda^2$ and not a moment of $L_W$, and the family is a diagonality test rather than a value bound, so the post is cleared, again vacuously. Worth naming: the family IS built from moments of $W$ as an operator on $\Lambda^2$, so the honest statement is that F6 concerns a different operator and a different conclusion, not that no moment appears.

**F44 is mis-cited and misdescribed.** It is not in [fence-posts.md](../findings/fence-posts.md) at all, whose post list runs F1 to F64 without it, and it lives at [second-order.md:845](../findings/second-order.md#L845). Its content is that a second-order criterion built from single-character Rayleigh quotients cannot see a frame's off-diagonal part, with the replacement "$L_R$ is exactly the off-block part" and the note that the blindness is per-frame, so a successor may vary the frame. The witness of (iii) is one fixed operator exhibited in a rotated frame, not a criterion and not a variation, so F44 does not govern the route in either direction. "Which is exactly what (iii) is" reads a permission out of a post about a different instrument.

**And the fence the block does not check is the one that bites.** [F36](../findings/fence-posts.md#L287) records that "proving the maximizer diagonalisable is the record's lifting lemma renamed", that padded $W_{\mathbb{CP}^2}$ is a local maximum and Plücker-obstructed, and that "a successor must separate the two by something other than the value". The block's closing sentence, "it also needs no value hypothesis, so if it closes it proves more than [I36] asks and the $\theta>\sqrt{3/2}$ clause is spent elsewhere", is refuted by the same file fifteen lines above it: padded $W_{\mathbb{CP}^2}$ is a local maximum at $\theta=\sqrt{3/2}$ **exactly** ([r316](REVIEW_r316.md)) and is not coordinate-diagonal ([L176](../findings/diagonal-half.md#L568), $\Lambda^2$-rank three against the locus's four), so "every local maximiser is coordinate-diagonal" is FALSE without a value hypothesis and nothing that dispenses with one can close I36. The route's two halves are "test implies diagonal", which needs no value hypothesis, and "a maximiser passes the test", which cannot be proved without one, because padded $W_{\mathbb{CP}^2}$ is a local maximum that fails the test. Its failure is itself closed-form and not a screen: $W^+=\mathrm{diag}(2,-1,-1)/\sqrt6$ with $W^-=0$ gives $\operatorname{tr}(W^2\star)=\lVert W^+\rVert^2=1$, so $\mathrm{Alt}(W^2)=\tfrac16\star\ne0$ by section 10.5, which also identifies the block's screened "$1$ at padded $W_{\mathbb{CP}^2}$" as the trace rather than the norm $1/\sqrt6$, a labelling the block does not state.

## 13. What is already on the record

Three sites, searched by object rather than by vocabulary.

**(i) is a re-derivation, and the earlier statement carries more.** [bounds.md:333](../findings/bounds.md#L333), under [L199](../findings/bounds.md#L319) and credited to [r843](REVIEW_r843.md), reads: "*A coordinate-diagonal $W$ has $W_{abcd}=0$ on every four-index-distinct entry, so $W^2$ has too, and a $\Lambda^4$ element with no four-distinct entries is zero*, hence $\mathrm{Alt}(W^2)=0$ identically there." That is (i) at $k=2$, in the block's own words, with the same invalid middle step, and it continues with the $n=4$ formula from which section 10.5's characterisation follows in a few lines. The block cites neither.

**The simple-eigenvalue certificate is on the record and is sharper than the $\mathcal W_4$ corollary in its own direction.** [bounds.md:167](../findings/bounds.md#L167): "A simple eigenvalue whose eigenvector is not decomposable refutes diagonality on its own, with no plane, no minimisation and no Plücker machinery." The $\mathcal W_4$ corollary is the contrapositive shape of the same instrument specialised to $n=4$, where $\star$ makes decomposability of a simple eigenform impossible outright.

**(iv)'s collapse re-derives the Plücker criterion.** [diagonality.md:19](../findings/diagonality.md#L19): "$W$ is non-diagonalisable when some eigenspace of $W$ contains **no** decomposable bivector." That is exactly the lesson (iv)'s box announces, namely that non-decomposability of a chosen basis of $E$ is not an obstruction while emptiness of $E\cap\{\text{decomposables}\}$ is, and it has been on the record long enough to appear in [F3](../findings/fence-posts.md#L158) and at [problem.md:156](../findings/problem.md#L156). Worth adding where the two instruments stand relative to each other, since neither implies the other: $E=\mathrm{span}\{\varphi_{12},(e_{13}+e_{24})/\sqrt2\}$ contains a decomposable and has $\mathfrak b(P_E)=-\mathrm{vol}\ne0$, while (iii)'s witness passes $\mathfrak b$ at every eigenspace and is not diagonal.

## 14. Arguing the opposite of every defect proposed here

**Against 1b.** One could read "so every power $W^k$ has too" as elliptical for "every power, being coordinate-diagonal, has too", in which case nothing is wrong. Held anyway, because the sentence's only stated premise is the no-four-distinct property, the class it names is not closed under powers, and the same sentence at [bounds.md:333](../findings/bounds.md#L333) will be read by someone who does not supply the missing clause. The defect is one clause of repair and no mathematics.

**Against 7.** One could argue the $f_1=\pm e_4$ branch is symmetric to the $e_1$ branch and so implicitly covered. It is not symmetric: the two branches produce different residual planes, $\langle e_1,e_2\rangle$ against $g_2\wedge e_4$, and the block's stated reason for the contradiction, "$g_2\wedge e_4$ would have to be an eigenform", is a fact about the $e_1$ branch alone. Held, at GAP rather than REFUTED, since the conclusion is true.

**Against 9b.** One could argue that "a route through $\mathfrak b$ alone" already means "with no Ricci-flatness", in which case section 10.5 agrees with it rather than refuting it. That reading is available, and it is not the reading the surrounding sentence supports, since the same box says the finding "retires the shape of the argument rather than the item", and section 10.5 shows the shape survives at $n=4$. Held as REFUTED AS STATED, which asks for a scope clause rather than a retraction.

**Against 11c.** One could argue the box means orthogonality only within each eigenspace's own pair. Even so the printed words are "across the whole spectrum at once", and within a single eigenspace of dimension three or more mutual orthogonality of planes already fails on the locus. Held.

**Against 12c.** One could argue that "it needs no value hypothesis" refers to the characterisation lemma alone, which is true. On that reading the second half of the sentence, "so if it closes it proves more than [I36] asks", does not follow at all, since the characterisation alone implies nothing about maximisers. Both readings fail, so this one is held at REFUTED rather than at REFUTED AS STATED.

**Withdrawn.** One candidate defect is withdrawn: an initial reading had (ii)'s "for every $k\ge1$" as a hidden appeal to infinitely many conditions, which would have made the test non-finite. Since the equivalence's forward direction consumes only $k=1,\dots,m$ and the reverse is termwise, the quantifier costs nothing and the claim is stronger with it than without. A second candidate is withdrawn as well: an initial reading of "$\mathfrak b(P_0)$ is then forced" as claiming $\mathfrak b(P_0)=0$ unconditionally, which the sentence does not say and which the completeness relation supplies anyway under the block's own antecedent.

## 15. What would break this, and what was done to look for it

**What would break the witness**, and hence (iii): a frame in which the six planes of section 7 are realised. Two independent complete arguments are given, one through pairwise intersections forcing both $\pm e_2$ and $\pm g_2$ into the frame, one through orthogonal complements missing $\langle g_3,e_4\rangle$, and the block's own third argument closes after its missing branch is added. All three need only $\sin2t\ne0$. Both of the arguments given survive zero-padding to every $n\ge4$, so the witness cannot be broken by moving dimension either.

**What would break section 10.5**, which is the only positive claim recorded here: a $W\in\mathcal W_4$ with $\mathrm{spec}(W^+)=\mathrm{spec}(W^-)$ outside the locus, which needs the surjectivity of $SO(4)\to SO(3)\times SO(3)$ or the realisability of $S_3$ inside $SO(3)$ to fail. Both were checked by hand. It would also break if $\mathrm{Alt}(A)=\tfrac16\operatorname{tr}(A\star)\star$ carried the wrong constant, which is why it is pinned twice, once from the definition through [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean) and once against the record's own $\mathrm{Alt}(W^2)$ at [bounds.md:333](../findings/bounds.md#L333).

**What would break 12c**: padded $W_{\mathbb{CP}^2}$ failing to be a local maximum, or being coordinate-diagonal after all. The first is [r316](REVIEW_r316.md) on the record and the second is [L176](../findings/diagonal-half.md#L568), Gate 2 landed by [r769](REVIEW_r769.md) and [r770](REVIEW_r770.md). Its failure of the test is derived here rather than screened.

**SCREEN, and it is a screen.** Machine arithmetic in double precision on objects constructed for the purpose, seconds of compute, load-bearing for nothing above: $\mathrm{Alt}=\tfrac16\mathfrak b=\tfrac16\operatorname{tr}(A\star)$ at a random symmetric $A$ on $\Lambda^2\mathbb R^4$ to $10^{-16}$; the six witness forms orthonormal to $10^{-16}$ with all six Pfaffians exactly $0$ and $\mathrm{Alt}(W^k)$ exactly $0$ for $k=1,\dots,7$ at $t=0.7$ with eigenvalues $(1,2,3,5,7,11)$; the witness failing to commute with $\star$ at $\lVert[W,\star]\rVert=15.85$; the aligned $\mathcal W_4$ tensor of section 10.5 coming out diagonal in the $\varphi$ basis with weights $(1,0,-1,-1,0,1)$, which is L177's four-cycle, with all four Ricci rows $0$ and $\mathrm{Alt}(W^k)$ exactly $0$; the $\mathbb{CP}^2$-type tensor at $\mathrm{Alt}(W)=0$, $\mathrm{Alt}(W^2)=\tfrac16$ and $\operatorname{tr}(W^2\star)=1$; and section 1's $M$ at $M_{1234}=0$ against $(M^2)_{1234}=1$. **Every one of these is derived above, and the screen is reported because the derivations are what establish them.**

## Verdict

**The witness stands and both conclusions drawn from it need rewriting.** (i), (ii), (iii)'s construction, (iii)'s non-diagonality, the $\mathcal W_4$ corollary and (iv) are all correct as mathematics, with one invalid inference in (i), one missing branch in (iii)'s frame argument, one misstated joint condition in (iv)'s box, and one positive claim resting on a screen where two lines of $\star$ algebra do the job. What must change in the record: (i) is [bounds.md:333](../findings/bounds.md#L333) re-derived and must cite it; "a route through $\mathfrak b$ alone cannot work" is false as printed, because section 10.5 turns the family into $\mathrm{spec}(W^+)=\mathrm{spec}(W^-)$ on $\mathcal W_4$ and thence into the locus itself, which also answers the block's own open question at $n=4$; and "it also needs no value hypothesis, so if it closes it proves more than I36 asks" collides with padded $W_{\mathbb{CP}^2}$ fifteen lines above it and must go. The F44 citation points at the wrong file and reads a permission out of a post about a different instrument.
