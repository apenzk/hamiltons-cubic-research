### Reviewer 314: Lemma L69's assembly, the B1 compression, the off-locus cushion, and a grading that is not unique

Every number below comes from a library built in this cycle from the definitions alone ([r314lib.py](../scripts/reviewers/r314/r314lib.py)), no repository script is imported anywhere in the chain. The library was calibrated and then validated before use: the sharp product is fixed by requiring Hamilton's diagonal formula $(R\#S)_{ij,ij}=\tfrac12\sum_k(r_{ik}s_{jk}+r_{jk}s_{ik})$, which it reproduces at residual $2\times10^{-16}$ with the constant coming out $\tfrac12$ at every $n$; $\dim\mathcal W_n$ comes out $n(n+1)(n+2)(n-3)/12$ at $n=5,6,7,8$; $W\#I=-W$ holds to $2\times10^{-15}$; $\sum_\gamma g_\gamma=4(n-1)$ holds to $10^{-14}$; and the sphere-product values $1.201561484$, $1.228239158$, $1.236033081$ at $n=12$ are reproduced to nine digits from the independent build.

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **M1** | Lemma L69, arithmetic and assembly | **CONFIRMED as a statement, its stated proof NOT ESTABLISHED as cited**, the arithmetic is exactly right and the conclusion is right, but the correspondence it leans on is asserted rather than proved; a stronger and shorter proof is given below, and the "room to spare" margin is the wrong quantity |
| **M2** | the B1 resolution, parts (a)(b)(c) | **CONFIRMED**, all three, with the table reproduced digit for digit, plus two corrections: the ten zeros are not annihilation, and [bounds.md:135](../findings/bounds.md#L135) still carries the "one eigenvalue per isotype" statement that [bounds.md:131](../findings/bounds.md#L131) retracts |
| **M3** | the off-locus cushion, $1.1070\times$ | **CONFIRMED**, and the record's "provisional until polished" caveat is **discharged**, both points polish to residual $2\times10^{-16}$ with $\theta$ and $\lambda_{\max}$ unchanged to eleven digits |
| **M4** | the positivity step's counterexample | **CONFIRMED**, and the $SO(10)$ conjugation is mathematically inert; the restricted statement is **OPEN**, and empty if the conjecture holds |
| **M5** | two closed routes | **both CONFIRMED**, every number reproduced, but (i) is scoped too widely and should be reopened for the canonical $\mathfrak p=E_+$, where the bound holds at every point tested; one sub-claim used to argue it is refuted |
| **M6** | where the violation lives | **CONFIRMED as computed, and extended to three points, but the shares are grading-dependent and reverse under the canonical grading, so the routing conclusion drawn from them is NOT SUPPORTED** |

---

## M1, Lemma L69

### The new step: derived independently, and it is exactly right

I built the two-factor idempotent from scratch. For $S^p\times S^q$ the vertex matrix solving $Q(W)=W$ is

$$\gamma=-\frac1{n-1},\qquad \alpha=\frac q{(n-1)(p-1)},\qquad \beta=\frac p{(n-1)(q-1)},$$

verified as an exact idempotent by substitution in both block types. Its Frobenius norm is

$$\lVert W\rVert_F^2=\binom p2\alpha^2+\binom q2\beta^2+pq\gamma^2=\frac{pq}{2(n-1)}\Big(\frac1{p-1}+\frac1{q-1}\Big),$$

and this equals $4\big(f(p)+f(q)-f(n)\big)$ with $f(m)=m/(8(m-1))$ **identically**, I checked the algebra, not just samples: both sides reduce to $(n-2)pq/\big((p-1)(q-1)\big)$ after clearing. That is what reconciles the record's $\lVert W\rVert^2\le\tfrac16$ with the Frobenius $\lVert W\rVert^2\le\tfrac23$ that $\theta=1/\lVert W\rVert_F\ge\sqrt{3/2}$ demands: the record's norm is a quarter of the Frobenius one, exactly and at every split.

The reduction then goes through verbatim, and I get the same chain by a second route:

$$\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13\iff pq(n+2)\ge4(n-1)^2 .$$

- $p=2$: the left side is $1+\frac1{n-3}-\frac1{n-1}>\tfrac13$ for every $n$. Fails.
- $p=3$: it is $\tfrac12+\frac1{n-4}-\frac1{n-1}$, and $\frac1{n-4}>\frac1{n-1}$, so it exceeds $\tfrac12>\tfrac13$. Fails.
- $p=4$: it reads $\frac1{q-1}\le\frac1{n-1}$, i.e. $q\ge n$, impossible at **every** $n$ since $q=n-4$. Confirmed exactly as stated.
- $p=5$: $\frac1{n-6}-\frac1{n-1}\le\frac1{12}$, i.e. $\frac5{(n-6)(n-1)}\le\frac1{12}$, i.e. $n^2-7n-54\ge0$, whose positive root is $(7+\sqrt{265})/2=11.6394\ldots$, so $n\ge12$.

**All of M1's arithmetic is CONFIRMED.** Two remarks the record does not make. The equivalent form $pq(n+2)\ge4(n-1)^2$ is worth carrying, because it shows the criterion is a statement about the *product* $pq$ alone at fixed $n$, so admissibility is an interval of splits around the balanced one, no case analysis on $p$ is needed once that is seen. And at $n=12$, $p=5$ the margin is one unit of $pq$: $35\cdot14=490$ against $4\cdot121=484$.

### The assembly: the correspondence is asserted, not established

The proof's first sentence is *"An equivariant graded point is the Weyl operator of a compact symmetric space, so the recorded classification applies."* The lemma's own "What it inherits" paragraph names [Lemma L8](../findings/graded-half.md) as the supplier. **It is not there.** Lemma L8, as it now stands in [graded-half.md](../findings/graded-half.md), opens with its own headline **SCOPE REFUTED**, and what survives of it is a $\theta$ formula for the equivariant point of a *given* symmetric pair plus a finite check over the classical families. That presupposes the pair; it does not derive it. Nothing else in the record derives it either. So Lemma L69 as written rests on an unproved step, and the step is doing real work: the classification it invokes is a classification of $n$-dimensional symmetric spaces, whereas gradedness is a statement about $\mathfrak{so}(n)$, and the two index sets are not the same object. The record itself shows they part company, $\mathrm{Gr}_{\mathbb C}(2,3)$ is a $12$-dimensional symmetric space whose Weyl operator is **ungraded** ($S=+0.9631$).

**The conclusion is nevertheless right, and there is a shorter proof that never mentions a symmetric space.** A symmetric-pair grading of $\mathfrak{so}(n)$ is the fixed-point algebra of an involutive automorphism. For $n\ge9$ every automorphism of $\mathfrak{so}(n)$ is conjugation by an element of $O(n)$, so an involution is conjugation by $g$ with $g^2=\pm I$, and the fixed algebra is $\mathfrak{so}(k)\oplus\mathfrak{so}(n-k)$ or $\mathfrak u(n/2)$, Cartan's types BDI and DIII, and the only two families. Equivariance means $W$ lies in the commutant of $\mathrm{ad}(\mathfrak p)$. So I computed, for every grading and with no ansatz, the dimension of

$$\mathrm{Comm}\big(\mathrm{ad}\,\mathfrak p\big)\cap\mathcal W_n$$

as the kernel of $\Phi=-\sum_X[\mathrm{ad}X,[\mathrm{ad}X,\cdot\,]]$ restricted to $\mathcal W_n$, verifying each kernel vector against **all** generators of $\mathfrak p$ afterwards ([m1_gradings.py](../scripts/reviewers/r314/m1_gradings.py)):

| grading | $n=12$ | $n=13$ | $n=14$ |
|---|---|---|---|
| $\mathfrak{so}(1)\oplus\mathfrak{so}(n-1)$ | $\dim 0$, **no equivariant Weyl operator exists** | $\dim 0$ | $\dim 0$ |
| $\mathfrak{so}(2)\oplus\mathfrak{so}(n-2)$ | $\dim 1$, $\theta=0.994987437$ | $\dim1$, $0.995859195$ | $\dim1$, $0.996521729$ |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(n-3)$ | $\dim1$, $1.141798451$ | $\dim1$, $1.144155107$ | $\dim1$, $1.145919418$ |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(n-4)$ | $\dim1$, $1.201561484$ | $\dim1$, $1.206045378$ | $\dim1$, $1.209338662$ |
| $\mathfrak{so}(5)\oplus\mathfrak{so}(n-5)$ | $\dim1$, $\mathbf{1.228239158}$ | $\dim1$, $\mathbf{1.235828761}$ | $\dim1$, $\mathbf{1.241265782}$ |
| $\mathfrak{so}(6)\oplus\mathfrak{so}(n-6)$ | $\dim1$, $\mathbf{1.236033081}$ | $\dim1$, $\mathbf{1.248375568}$ | $\dim1$, $\mathbf{1.256925261}$ |
| $\mathfrak{so}(7)\oplus\mathfrak{so}(7)$ | (|), | $\dim1$, $\mathbf{1.261680124}$ |
| $\mathfrak u(n/2)$ | $\dim1$, $0.924962462$ | *(none, $n$ odd)* | $\dim1$, $0.908513525$ |

Commutation was checked against every generator at $\le6\times10^{-15}$, and every listed point is critical in the **full** $\mathcal W_n$ at residual $\le7\times10^{-15}$. The structure is the whole argument: **the commutant is at most one-dimensional at every grading**, so $Q$ maps a line to itself, criticality is automatic, and the equivariant graded critical point of a grading is *unique up to sign* and therefore is the known one. Bold entries are those clearing $\sqrt{3/2}=1.224744871$, and they are exactly the splits with $p,q\ge5$.

This settles the four sub-questions the brief raises, without a classification of symmetric spaces:

- **Multi-factor products** cannot arise: $\mathfrak{so}(n)$ has no three-factor symmetric grading, so $S^a\times S^b\times S^c$ is not a graded point of this kind at all. The record's Jensen argument over partitions is needed for the symmetric-space census, not for this lemma.
- **Non-sphere factors** cannot arise: at a $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ grading the admissible space is one-dimensional and the sphere product already occupies it.
- **Exceptional pairs** cannot arise: they are gradings of exceptional algebras, not of $\mathfrak{so}(n)$. They enter the record only through the symmetric-space census, which this route does not use.
- **Odd $n$** is not a special case. At $n=13$ the enumeration is complete with five gradings and no $\mathfrak u$ family, and the two above threshold are $S^5\times S^8$ and $S^6\times S^7$, both with $p,q\ge5$. What changes at odd $n$ is only that $\theta_0(n)$ is not attained; Lemma L69 claims no attainment, so it holds verbatim.

*The grading multiplicity found in M5 does not disturb this.* The enumeration is indexed by gradings, not by points, so a $W$ that is equivariant for two gradings simply appears in two rows; completeness is unaffected, and the union over all rows is still bounded by one point per grading.

One incidental result worth keeping: $\mathfrak{so}(1)\oplus\mathfrak{so}(n-1)$ admits **no** equivariant Weyl operator at all, at any of $n=12,13,14$. That is the "no flat factors" conclusion the record reaches through the Einstein normalisation, obtained here as a dimension count with no geometry in it.

### Nondegeneracy: confirmed, but the quoted margin is the wrong quantity

I built $L_e$ on all of $\mathcal W_n$ at six splits and diagonalised on $W^\perp$:

| point | $\lambda_{\max}(L_e|_{W^\perp})$ | multiplicity | $pq$ | second eigenvalue |
|---|---|---|---|---|
| $S^3\times S^9$ | $0.5000000000000020$ | $27$ | $27$ | $7/16=0.4375$ |
| $S^4\times S^8$ | $0.5000000000000034$ | $32$ | $32$ | $3/7=0.428571$ |
| $S^5\times S^7$ | $0.5000000000000027$ | $35$ | $35$ | $5/12=0.416667$ |
| $S^6\times S^6$ | $0.5000000000000027$ | $36$ | $36$ | $2/5=0.4$ |
| $S^3\times S^{10}$ ($n=13$) | $0.5000000000000024$ | $30$ | $30$ | $4/9=0.444444$ |
| $S^4\times S^9$ ($n=13$) | $0.5000000000000031$ | $36$ | $36$ | $7/16=0.4375$ |
| $S^5\times S^8$ ($n=13$) | $0.5000000000000018$ | $40$ | $40$ | $3/7$ |
| $S^6\times S^7$ ($n=13$) | $0.5000000000000028$ | $42$ | $42$ | $5/12$ |

So $\lambda_{\max}=\tfrac12$ attained exactly on the orbit tangent, at every split, **CONFIRMED**, and it holds at $p=3$ and $p=4$ too, which the lemma does not need.

**But the margin the lemma quotes is not the spectral gap.** The value $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ lands on the *largest* isotypic block, $\mu=5/24$ at $S^5\times S^7$, $1/5$ at $S^6\times S^6$, $11/56$ at $S^5\times S^8$, $11/60$ at $S^6\times S^7$, matching the blocks of dimension $210$, $225$, $280$, $315$ above. The second-largest eigenvalue lives elsewhere. Reading it off the table,

$$\lambda_{2}=\frac{M-2}{2(M-1)},\qquad M=\max(p,q),$$

carried on a block of dimension $(M-1)(M+2)/2$ (matched at all eight splits above), the traceless symmetric $2$-tensors of the larger factor, which is family $A$ of [algebra.md](../findings/algebra.md) with $c_A=-3/(k-1)$ and $\lambda=(c_A+3)/6$. The true gap is therefore

$$\tfrac12-\lambda_2=\frac1{2(M-1)}\longrightarrow0 .$$

It is $1/12$ at $S^5\times S^7$ and $1/10$ at $S^6\times S^6$, against the $7/24=0.292$ the lemma advertises, a factor of three and a half out, and shrinking like $1/n$. Nondegeneracy survives, because $\lambda_2<\tfrac12$ strictly for every finite $M$; what does not survive is "with room to spare". Any argument that spends the margin quantitatively is spending three times what is there, and asymptotically it is spending everything.

**Verdict M1: CONFIRMED as a statement.** The arithmetic is exact, the conclusion holds at every $n\ge12$ including odd $n$, and nondegeneracy is real. The proof as written is not established at its first step, and the fix is to replace the symmetric-space detour by the one-dimensional-commutant argument above, which is shorter, unconditional, and does not import a classification. The stated margin should be corrected to $1/(2\max(p,q)-2)$.

---

## M2, the B1 resolution

Rebuilt from scratch: the $C_5$ blow-up as blocks $(2,2,2,2,2)$ at $n=10$ with entries $4:-2:+1$ on within-block, $C_5$-edge and non-edge pairs. It comes out $\theta=0.670820393$ at criticality residual $8.3\times10^{-17}$, exactly Ricci-flat, $\ker W=0$, and $\lambda_{\max}(L_e|_{W^\perp})=1.2060113295833$ against the record's $1.20601133$.

**(a) CONFIRMED.** With $D_A$ the derivation of a symmetric $A$ on $\Lambda^2$ and $H_A=D_AW+WD_A$, every one of the $54$ directions leaves $\mathcal W_{10}$. In the natural basis (the $45$ matrices $E_{ab}+E_{ba}$ plus $9$ traceless diagonals), the leak runs $\mathbf{7.62\%}$ to $\mathbf{47.60\%}$ with median $\mathbf{31.62\%}$, reproducing the record's "$7.6\%$ to $50\%$, median $32\%$". *One caveat the record does not attach:* those percentiles are basis-dependent, not invariants. In the orthonormal basis my SVD produced they read $8.77\%$ / $23.26\%$ / $51.51\%$ instead. The invariant content is "all $54$ leave, none by less than $7.6\%$".

**(b) CONFIRMED exactly.** Projecting each $H_A$ back into $\mathcal W_{10}$ and taking the eigenvalues of the compression of $L_e$ to the image:

$$0^{\times10},\quad 0.412281^{\times20},\quad 0.441754^{\times2},\quad \tfrac23^{\times20},\quad 0.820541^{\times2}$$

the recorded table, digit for digit, with no fitting. The torus-invariant part of $\mathrm{Sym}_0$ is four-dimensional (the block scalars $\mathrm{diag}(a_1I_2,\dots,a_5I_2)$, traceless) and its compression spectrum is exactly $\{0.441754^{\times2},\,0.820541^{\times2}\}$. And $A=I$ gives $H_I=4W$ **identically** ($\max|H_I-4W|=0.0$, since $D_I=2\,\mathrm{Id}$ on $\Lambda^2$), with Rayleigh quotient $1.0000000000$, the radial direction, exactly as stated.

**(c) CONFIRMED.** The projected image is not $L_e$-invariant: $\lVert(1-P_V)L_eP_V\rVert_F=\mathbf{1.2447}$ against the record's $1.245$, with the worst single direction at $0.3292$. Block by block, the four nonzero values are **not** eigenvalues, $\max\lVert(L_e-\lambda)v\rVert$ is $0.099$, $0.111$, $0.236$ and $0.329$ on the $0.412281$, $0.441754$, $\tfrac23$ and $0.820541$ blocks respectively. They are compression values.

**Does a Rayleigh quotient above $\tfrac12$ still bound $\lambda_{\max}$ from below? Yes, and the certificate is sound as used.** $L_e$ is self-adjoint on $\mathcal W_n$ (symmetry error $3.9\times10^{-16}$ in my build), so $\langle L_ev,v\rangle/\lVert v\rVert^2\le\lambda_{\max}$ for any $v$, and Cauchy interlacing gives the same for every eigenvalue of a compression. The one thing that has to be checked separately is that the test vector is orthogonal to $W$, since Lemma L24 bounds $\lambda_{\max}$ on $W^\perp$ rather than on $\mathcal W_n$, and it is: the four torus-invariant certificate directions have $|\langle v,W\rangle|\le6\times10^{-16}$. So $0.820541>\tfrac12$ genuinely closes the blow-up. The implication is one-directional, which the record states correctly: a compression value *below* $\tfrac12$ certifies nothing.

**Two corrections.**

1. **The $0^{\times10}$ is not annihilation.** [bounds.md:162](../findings/bounds.md#L162) reads the ten zeros as the $p=2$ block value showing up "as annihilation". They are not annihilated: the projected images $P_{\mathcal W}H_A$ spanning that block have norms between $0.316$ and $0.867$, none near zero, and the image is a full $54$ dimensions. What is true, and is the better statement, is that those ten vectors lie in $\ker L_e$, $\lVert L_ez\rVert\le7.9\times10^{-16}$, inside a kernel of total dimension $111$ on $\mathcal W_{10}$. So they are honest eigenvectors with eigenvalue $0$, which is why they are the only block of the five that *is* exact.
2. **[bounds.md:135](../findings/bounds.md#L135) still asserts the retracted claim.** Four lines after [bounds.md:131](../findings/bounds.md#L131) retracts "$L_e$ acts as a scalar on each isotypic component" and [bounds.md:133](../findings/bounds.md#L133) records that the image is not invariant, the file says *"$L_e$ acts as a scalar on each isotypic component, which is why the $C_5$-edge family came out an exact eigenspace rather than merely a subspace with a large average."* Both halves are false, and the second contradicts [bounds.md:122](../findings/bounds.md#L122) in the same file, which says the family is **not** an eigenspace. My measurement settles it: constant compression at $0.666666667$ across the whole $20$-dimensional span, residual $0.236$, so a constant-Rayleigh subspace and not an eigenspace. The brief's guess is right, **every unqualified "one eigenvalue per isotype" sentence in the record is wrong as stated**, and this one is still standing.

**The invariance failure is point-dependent, and the table's other two rows are not compression values.** Running the same construction at $S^3\times S^5$ reproduces that row of the record's table exactly ($\tfrac14^{\times5}$, $\tfrac38^{\times14}$, $\tfrac12^{\times15}$ on a $35$-dimensional image) and there the projected image **is** $L_e$-invariant, residual $5.7\times10^{-15}$. So at the equivariant point those numbers are honest eigenvalues; only at the ungraded blow-up does the image break. The record's blanket "these are compression values rather than eigenvalues" is right where it is stated and over-general as a reading of the table. One correction to that row: the trivial isotype of $\mathrm{Sym}_0$ does not "contribute nothing", its image is the radial direction $W$ with eigenvalue $1.0000000000$, which is the same $A=I$ phenomenon seen at the blow-up and is excluded by Lemma L24 rather than absent. The row's "the max is exactly $\tfrac12$" is therefore a statement about $W^\perp$, and should say so.

**Two controls and one exact constant, added while checking (c).** The orbit tangent at the blow-up is $40$-dimensional and $L_e$ equals $\tfrac12$ on it to $1.2\times10^{-15}$, so the instrument passes the control the record demands. And the $C_5$-edge family (the twenty directions $A=E_{ab}+E_{ba}$ with $a,b$ in blocks joined by an edge of $C_5$), spans exactly twenty dimensions, has $L_e$-compression constant at $0.666666667$ on every one of them, and is orthogonal to $W$ at $4\times10^{-17}$ and to the orbit tangent at $3.7\times10^{-16}$. Its non-invariance residual has Gram exactly $\tfrac1{18}\,\mathrm{Id}$ on the whole span, I get eigenvalues $1.000000$ after scaling by $18$, all twenty, confirming Reviewer 305's K2 to the constant, and settling that this family is a constant-Rayleigh subspace rather than an eigenspace.

**Verdict M2: CONFIRMED (a), (b), (c).** The numbers are citable. The correct general statement is that the compression $P_VL_eP_V$ is $\mathfrak k(W)$-equivariant, hence block-scalar with one $m\times m$ block per isotype of multiplicity $m$, the repaired form the record already has at [bounds.md:131](../findings/bounds.md#L131), which should replace the surviving copy of the refuted one.

---

## M3, the off-locus cushion

**Both points are genuine, and the record's caveat is discharged.** Loaded from [r305_n8_seed9018.npy](../scripts/reviewers/r305/out/r305_n8_seed9018.npy) and [r305_n8_seed9033.npy](../scripts/reviewers/r305/out/r305_n8_seed9033.npy):

| | $\theta$ | $\Delta$ | $\lambda_{\max}(L_e|_{W^\perp})$ | margin over $\tfrac12$ | residual as loaded | after polish |
|---|---|---|---|---|---|---|
| seed 9018 | $1.081549248013368$ | $2.400930266$ | $0.562754631715$ | $1.125509\times$ | $1.54\times10^{-12}$ | $\mathbf{2.1\times10^{-16}}$ |
| seed 9033 | $1.079758865610485$ | $2.762849577$ | $0.553480567236$ | $\mathbf{1.106961\times}$ | $1.36\times10^{-12}$ | $\mathbf{1.9\times10^{-16}}$ |

Both are exactly symmetric, exactly unit-norm, inside $\mathcal W_8$ to $9.7\times10^{-17}$, Ricci-flat to $2.7\times10^{-16}$, and have $\ker W=0$. I polished each with a hand-written Gauss–Newton on the criticality map $F(x)=q(x)-\theta(x)x$ with exact Jacobian $2L_W-\theta-3\,x\,q^{\mathsf T}$, using a truncated SVD pseudo-inverse to absorb the orbit kernel; $\theta$ and $\lambda_{\max}$ move in the twelfth digit or later. **So the record's note at [diagonal-half.md:191](../findings/diagonal-half.md#L191) that "their $\lambda_{\max}$ is provisional until polished" can be struck, they are exact critical points and the $1.1070\times$ stands.**

**The frame-independent certificate.** A coordinate test (looking for zero rows in whatever frame the tensor was stored in), is worthless, because padding is an $O(n)$-orbit property. The certificate I use is the symmetric $n\times n$ form

$$G(W)_{ik}=\mathrm{Ric}(W^2)_{ik}=\sum_j\langle W^2(e_i\wedge e_j),e_k\wedge e_j\rangle,\qquad u^{\mathsf T}Gu=\sum_j\lVert W(u\wedge e_j)\rVert^2 .$$

It is $O(n)$-covariant, positive semidefinite, has trace $2\lVert W\rVert^2$, and $Gu=0$ exactly when $W$ annihilates $u\wedge\mathbb R^n$, that is, exactly when $W$ is supported on $\Lambda^2(u^\perp)$. So $W$ is a padding of a lower-dimensional point in *some* frame if and only if $G$ is singular, and $\mathrm{rank}\,G$ is the true ambient dimension. Applied:

| point | eigenvalues of $\mathrm{Ric}(W^2)$ | rank | verdict |
|---|---|---|---|
| seed 9018 | $0.03341138^{\times2},\,0.20769,\,0.26052^{\times2},\,0.36135,\,0.42155^{\times2}$ | $8$ | **not a padding** |
| seed 9033 | $0.00916545,\,0.14044^{\times2},\,0.25968^{\times2},\,0.33272,\,0.42894^{\times2}$ | $8$ | **not a padding** |
| seed 9003 | $\mathbf{0},\,0.11044,\,0.18838,\,0.27433^{\times2},\,0.32612,\,0.41320^{\times2}$ | $\mathbf 7$ | an $n=7$ point in a rotated frame |

The third row is the one [diagonal-half.md:191](../findings/diagonal-half.md#L191) already excludes, and my certificate independently returns the same verdict with the same $\dim\ker W=7$, so the record's exclusion is right and its rank certificate and mine agree. The margin at seed 9033 is thin ($0.00917$ against a trace of $2$, i.e. $3.7\%$ of the isotropic value $2/n$) but unambiguous at machine precision.

**An unrequested finding at seed 9033.** Its $L_e$ spectrum on $W^\perp$, at criticality residual $1.9\times10^{-16}$, is $\{0.553481,\ 0.525040,\ 0.500284^{\times2},\ \tfrac12^{\times26},\ \dots\}$. The multiplicity-$26$ block is the orbit tangent; the pair at $0.500284$ is a *separate* eigenvalue above $\tfrac12$ that survives polishing. So the point clears $\tfrac12$ in four directions, not one, and the thinnest of them is $2.8\times10^{-4}$ above the bound, the same order as the $2.5\times10^{-4}$ thin margin [bounds.md:129](../findings/bounds.md#L129) records elsewhere.

---

## M4, the endgame's positivity step

**Built and confirmed.** The $C_5$ blow-up in its own coordinate frame gives, from my library:

$$\theta=0.670820393,\quad\text{residual }8.3\times10^{-17},\quad \dim\mathfrak p=25,\ \dim\mathfrak m=20,\ \dim\ker W=0,$$
$$S_{\mathfrak{mmm}}=0\ \text{exactly},\qquad S_{\mathfrak{mpp}}=80.000000,\qquad S_{\mathfrak{ppp}}=120,\qquad \Delta=12.000000 .$$

Three independent random $SO(10)$ conjugates reproduce it: criticality $5.6$–$6.2\times10^{-17}$, $S_{\mathfrak{mmm}}=6.7\times10^{-29}$, $5.8\times10^{-29}$, $7.0\times10^{-29}$, $S_{\mathfrak{mpp}}=80.000000$ at all three, $\dim\mathfrak m=20$ against the cap $\lfloor n^2/4\rfloor=25$. Every recorded figure at [fence-posts.md:181](../findings/fence-posts.md#L181) is reproduced. Controls behave: $S^3\times S^5$, $S^5\times S^5$ and $S^5\times S^7$ all give $S_{\mathfrak{mmm}}=S_{\mathfrak{mpp}}=0$.

**So the ruling is: the counterexample is real, and "ungraded $\Rightarrow S>0$" is FALSE.** The unrestricted positivity step does not hold, exactly as the record says.

**But the conjugation is doing no work, and the record should say so.** $Q$ is $SO(n)$-equivariant, so conjugation carries the eigenspace decomposition, the bracket, $\theta$, $\Delta$, $S_{\mathfrak{mmm}}$ and $S_{\mathfrak{mpp}}$ along unchanged, which is precisely what my three conjugates show, to $10^{-29}$. The witness is therefore the $C_5$ blow-up itself, and the record already carried it, with these same numbers, at [bounds.md:216](../findings/bounds.md#L216): *"trivial kernel, $S_{\mathfrak{mmm}}=0$ exactly, $\theta=0.670820$, $\langle[\mathfrak p,\mathfrak p],\mathfrak m\rangle^2=80$, $\Delta=12$."* The conjugation removes the *appearance* of coordinate-diagonality and nothing else. Presenting "a generic $SO(10)$-conjugate" as the object that breaks the step overstates the novelty and, worse, invites the reading that gradedness is frame-dependent. It is not.

**Is "every ungraded critical point with $\theta\ge\sqrt{3/2}$ has $S>0$" true, false or open? OPEN, and empty if the conjecture is true, which is the problem with it.**

- Nothing on the record refutes it, and I found nothing either. The counterexample above sits at $\theta=0.670820$, roughly $0.55$ of the threshold.
- The only known family of ungraded $S=0$ critical points is the $C_5$ blow-up family, and it cannot reach the threshold. I verified its climb independently, solving the block-constant vertex system at $m=2,3,4,8,20$ (i.e. $n=10,15,20,40,100$) at criticality residuals $\le7\times10^{-17}$: $\theta/\theta_0=0.559016994$, $0.620173673$, $0.645497224$, $0.678620893$, $0.696199596$, matching $\tfrac12\sqrt{10(m-1)/(5m-2)}$ to nine digits, with supremum $1/\sqrt2$. Since $\theta_0(n)\to\sqrt2$, the family's $\theta$ has supremum $1$, against $\sqrt{3/2}=1.2247$. It never gets there.
- The recorded ungraded ceiling across every census is $0.900828$ (moved to $0.9067$ under a second audit). So the set $\{\text{ungraded critical},\ \theta\ge\sqrt{3/2}\}$ has **never been shown to be non-empty at any $n$**.

That is the difficulty. The premise is a statement about a set the programme believes is empty, and any proof that it is empty is a proof of the conjecture on the ungraded half. The record's own phrasing (*"assuming it does is close to assuming the conclusion"*), is right, and I would sharpen it: the restricted positivity step is not a lemma with a gap, it is the ungraded half of the conjecture wearing a different hypothesis. The route's value is as a reduction, not as something a cycle can be sent to prove.

**Verdict M4: the counterexample is CONFIRMED; the restricted statement is OPEN and is not a smaller problem than the one it is meant to serve.**

---

## M5, two closed routes

**This is where I was wrong first and had to reverse.** Reading the witness's *positive eigenspace*, the natural splitting, and the one the record's own $\Delta=0\iff\mathrm{ad}(\mathfrak p)$-equivariance equivalence is stated over, I found bracket closure to $10^{-14}$ and concluded that the record's $\mathfrak p$-block numbers came from a non-grading split. They do not. A search over $\mathrm{Gr}(3,\mathbb R^8)$, minimising the cross-block norm of $W$, turns up a **second** orthogonal $3+5$ splitting that $W$ also preserves, and every one of the record's numbers falls out of it. Both splittings are genuine symmetric-pair gradings. What follows is the corrected picture.

### The witness carries two $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ gradings, and they disagree about everything

At [r305_n8_seed9015.npy](../scripts/reviewers/r305/out/r305_n8_seed9015.npy), $\theta=1.088948052505$ at polished residual $3.6\times10^{-16}$:

| | $G_1$: $\mathfrak p=E_+$, the spectral splitting | $G_2$: the second splitting |
|---|---|---|
| cross-block $\lVert W_{[\mathfrak p,\mathfrak m]}\rVert$ | $1.0\times10^{-15}$ | $1.7\times10^{-14}$ |
| $\lVert A\rVert^2$ | $0.624925925$ | $\mathbf{0.332495633}$ |
| block traces (equal, see below) | $+1.082996$ | $\mathbf{-0.214821}$ |
| Cauchy–Schwarz floor | $0.508248$ | $\mathbf{0.019997}$ |
| cross-block direction, mass outside $\mathcal W_8$ | $1/\sqrt3$ | $1/\sqrt3$ |
| its repaired Rayleigh quotient | $+0.429036$ | $\mathbf{-0.290085}$ |

The bold column is the record's, to every digit it publishes. **So [graded-half.md:219](../findings/graded-half.md#L219)'s numbers are all correct**, and my first reading of them was not. The principal cosines between the two $3$-planes are $(1,0,0)$, so they share a line and are otherwise transverse; $G_2$'s $\mathfrak p$ is spanned by eigenvectors of $W$ of mixed sign, which is why its $\lVert A\rVert^2$ is not $\sum_{\lambda>0}\lambda^2$.

**One sub-claim is still refuted, and it is the one the closure is argued from.** [graded-half.md:221](../findings/graded-half.md#L221) says *"the witness's positive eigenspace is not closed under bracket"*, reporting defects $3.6\times10^{-1}$, $2.0\times10^{-1}$, $1.4\times10^{-1}$. It is closed. I measure

$$\lVert\Pi_{\mathfrak m}[\mathfrak p,\mathfrak p]\rVert=1.16\times10^{-14},\quad\lVert\Pi_{\mathfrak p}[\mathfrak p,\mathfrak m]\rVert=1.16\times10^{-14},\quad\lVert\Pi_{\mathfrak m}[\mathfrak m,\mathfrak m]\rVert=1.22\times10^{-14}$$

against bracket norms $8.12$, $9.49$, $9.49$, i.e. $S_{\mathfrak{mmm}}=1.5\times10^{-28}$ and $S_{\mathfrak{mpp}}=1.4\times10^{-28}$; and $\mathfrak p=E_+$ has Killing spectrum $-2^{\times3}\oplus-6^{\times10}$ and acts on $\mathbb R^8$ with an invariant $3$-plane ($\sum_XXX^{\mathsf T}$ has eigenvalues $2^{\times3},4^{\times5}$), so $E_+=\Lambda^2U\oplus\Lambda^2U^\perp$ exactly. The same holds at seeds 9018 and 9033, defects $1.4\times10^{-14}$ and $8.8\times10^{-12}$. **[bounds.md:222](../findings/bounds.md#L222) is right and [graded-half.md:221](../findings/graded-half.md#L221) is wrong**, and the record contradicts itself between the two files. The correct statement is not "the spectral split is not a grading" but "the witness has at least two gradings, and $\lVert A\rVert^2$ must name which".

### (i) The mass route, the closure STANDS, and it is now better supported than the record knows

Granting the correction, the record's conclusion survives, because the multiplicity of gradings is not confined to the non-equivariant side. **$S^3\times S^5$ has a second grading too.** Running the same $\mathrm{Gr}(3,\mathbb R^8)$ search on the equivariant point finds a splitting with cross-block $1.19\times10^{-14}$ and

$$\lVert A\rVert^2=0.419047619=\tfrac{44}{105},\qquad\text{block traces }-0.199205,\qquad\text{floor }0.017196 .$$

So the comparison the mass route needs is genuinely ill-posed as stated: the witness sits at $0.624926$ **above** the equivariant $0.619048$ under the spectral pairing and at $0.332496$ **below** it under the record's pairing, while the equivariant point itself ranges over $\{0.619048,\ 0.419048\}$ depending on which of *its* gradings is used. **No bound of the form $\lVert A\rVert^2\ge\lVert A_{\mathrm{equiv}}\rVert^2$ is available without first canonicalising the grading**, which is exactly the record's fence post.

**What I would add, and it is the only opening left.** The record's own gradedness apparatus already canonicalises: [bounds.md:190](../findings/bounds.md#L190) defines $\mathfrak p$ as the strictly-positive eigenspace and proves $\Delta=0\iff\mathfrak p\subseteq\mathfrak k(W)$ on that $\mathfrak p$. Under that canonical choice ($\mathfrak p=E_+$, well-defined whenever $\ker W=0$), the inequality holds at every point I can check:

| point | $\theta$ | $\lVert A\rVert^2$ at $\mathfrak p=E_+$ | equivariant closed form |
|---|---|---|---|
| $S^3\times S^5$ (equivariant) | $1.115546702$ | $0.619048=\tfrac{13}{21}$ | $0.619048$, equality |
| seed 9015 | $1.088948053$ | $0.624926$ | above |
| seed 9018 | $1.081549248$ | $0.622350$ | above |
| seed 9033 | $1.079758866$ | $0.624010$ | above |

and Reviewer 307's census, quoted at [graded-half.md:217](../findings/graded-half.md#L217), reports exactly this: $[0.6190476,0.6402034]$ on $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ and $[0.5714286,0.6230080]$ on $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$, with the closed form at the minimum of each and $4/7=0.5714286$ matching my independent $S^4\times S^4$ value. **The record dismisses that as "an artefact of computing the census in the spectral splitting". It is not an artefact, the spectral splitting is the record's own canonical $\mathfrak p$, and at every point tested it is a grading.** So the honest status is: the route is closed *for an arbitrary grading*, and open *for the canonical one*, where the evidence points the right way and no counterexample exists.

**Verdict M5(i): the closure is CONFIRMED as stated (no bound is available across gradings) but it is scoped too widely.** It should be narrowed to "no grading-independent mass bound exists", and the canonical-$\mathfrak p$ version should be reopened as a live question, with the missing ingredient named: a lower bound on the common block trace $t$ at a graded critical point, since Cauchy–Schwarz gives only $\lVert A\rVert^2\ge t^2\big(\tfrac1{\dim\mathfrak p_1}+\tfrac1{\dim\mathfrak p_2}\big)$ and $t$ moves ($1.083$ at the witness against $1.195$ at $S^3\times S^5$).

**One identity worth recording, which makes that a one-variable question.** For any orthogonal $\mathbb R^n=U\oplus U^\perp$ and any Ricci-flat $W$,

$$\mathop{\mathrm{tr}}\big(W|_{\Lambda^2U}\big)=\mathop{\mathrm{tr}}\big(W|_{\Lambda^2U^\perp}\big)=-\tfrac12\mathop{\mathrm{tr}}\big(W|_{U\wedge U^\perp}\big),$$

by summing $\mathrm{Ric}_{ii}=0$ over each factor. It holds in both gradings above, $+1.082996$ twice in $G_1$, $-0.214821$ twice in $G_2$, $-0.199205$ twice at $S^3\times S^5$'s second grading, so the two factor traces in the floor are a *single* unknown, not two.

### (ii) The cross-block route, CONFIRMED, and the leak constant is exact

In the record's grading $G_2$: $\lVert H\rVert=0.143926$, mass outside $\mathcal W_8$ equal to $0.57735\ldots$, repaired Rayleigh quotient after removing the $W$-component $=\mathbf{-0.290085}$, the recorded value exactly. The leak fraction is $1/\sqrt3$ **exactly**, i.e. a third of the squared norm, and it is $1/\sqrt3$ in $G_1$ too ($\lVert H\rVert=0.287852$, quotient $+0.429036$). So the direction is inadmissible in both gradings and fires as a certificate in neither. **Verdict M5(ii): CONFIRMED, and the closure is robust across the grading ambiguity in a way the mass route is not**, which makes it the sounder of the two fence posts.

---

## M6, where the violation lives

The record's table is **reproduced exactly**, in $G_2$. My own table, in $G_1$, is equally exact and completely different. Both were computed twice, in the eigenbasis and in the adapted frame.

| block | record and r314 in $G_2$ | r314 in $G_1$ ($\mathfrak p=E_+$) |
|---|---|---|
| $\mathfrak p\times\mathfrak m$, off the grading | $0.0000$ | $0.0000$ |
| $\mathfrak m\times\mathfrak m$ | $0.7074$ | $0.3355$ |
| $\mathfrak p_2\times\mathfrak p_2$, $\mathfrak{so}(5)$ | $0.1853$ | $0.1432$ |
| $\mathfrak p_1\times\mathfrak p_2$, cross-block | $0.0856$ | $0.3425$ |
| $\mathfrak p_1\times\mathfrak p_1$, $\mathfrak{so}(3)$ | $0.0217$ | $0.1788$ |

**What is robust.** The $\lambda_{\max}$ eigenvector carries $0.0000$ off the grading in *both* gradings, and I extended that to the two further points: at seed 9018 and seed 9033 the off-grading mass in $G_1$ is $0.0000$ as well, with tables $(0.3677,\,0.1638,\,0.3267,\,0.1418)$ and $(0.3385,\,0.1585,\,0.3459,\,0.1571)$. **So "the violating direction is itself graded" is CONFIRMED and now rests on three points rather than one**, and it holds simultaneously for two inequivalent gradings at the witness, which is a stronger statement than the record makes.

**What is not robust, and this is the finding.** The *internal* shares are not invariants of the point; they are invariants of the point *and a choice of grading*, and the two choices give opposite answers. In $G_2$ the violation is $71\%$ on $\mathfrak m\times\mathfrak m$ and $9\%$ on the cross-block; in $G_1$ it is $34\%$ on $\mathfrak m\times\mathfrak m$ and $34\%$ on the cross-block, with two thirds of the total inside $\mathfrak p$. So the route-choosing sentence at [graded-half.md:249](../findings/graded-half.md#L249), *"it is concentrated on $\mathfrak m$. So a successor should deform $B=W|_{\mathfrak m}$ rather than anything inside $\mathfrak p$"*, is a statement about $G_2$ that reverses in $G_1$, and it is being used to choose where a whole successor route should look.

The tension the record then records against Reviewer 307 (*"first order and second order disagree about which block matters"*), dissolves the same way. Reviewer 307's $\mathfrak m$-equation analysis is stated over the canonical $\mathfrak p=E_+$; the second-order table is stated over $G_2$. In $G_1$ both say $\mathfrak p$ matters, and there is nothing to reconcile.

**Verdict M6: the gradedness row is CONFIRMED and extended; the block shares are CONFIRMED as computed but are grading-dependent, and the routing conclusion drawn from them is NOT SUPPORTED.** Before that route is picked up, the record needs to say which grading it means, and if it means the canonical $\mathfrak p=E_+$, the answer flips to $\mathfrak p$.

---

## The push on M3: no refutation of V3, and the cushion is thinner still

The criterion I searched against is the one Lemma L24 supplies, re-derived rather than assumed. With $P(x)=\langle x,Q(x)\rangle$ and $\nabla P=3Q$, the constrained Hessian on $T_WS=W^\perp$ at a critical point is

$$\mathrm{Hess}\,P(h,h)=6\langle L_Wh,h\rangle-3\theta\lVert h\rVert^2=6\theta\Big(\langle L_eh,h\rangle-\tfrac12\Big),$$

so a local maximum forces $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, and Morse–Bott nondegeneracy is exactly $E(\tfrac12)=$ orbit tangent. Both statements are what I measured in M1.

I then hunted for a critical point with $\Delta>0$ and $\lambda_{\max}\le\tfrac12$, using a hand-written Gauss–Newton on the criticality map with a truncated-SVD pseudo-inverse (no [scipy.optimize.least_squares](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.least_squares.html), no [scipy.linalg.svd](https://docs.scipy.org/doc/scipy/reference/generated/scipy.linalg.svd.html), both are far slower than [numpy.linalg.lstsq](https://numpy.org/doc/stable/reference/generated/numpy.linalg.lstsq.html) in this environment), from random starts on the unit sphere of $\mathcal W_n$ and from perturbations of the lowest points found so far ([m3_hunt2.py](../scripts/reviewers/r314/m3_hunt2.py)):

| $n$ | starts | critical points kept | lowest $\lambda_{\max}$ at $\Delta>0$ |
|---|---|---|---|
| $6$ | $500$ | $219$ | $1.645358104$ |
| $7$ | $500$ | $17$ | $6.036251868$ |
| $8$ | $700$ (biased) | $338$ | $0.547291527$ raw, $\mathbf{0.551340110}$ after the padding filter |

**No violation of V3 was found.** That is a null result and it agrees with Reviewer 305's.

**The cushion is thinner than the record's $1.1070\times$, though.** Six $n=8$ points came in below $0.56$; the $\mathrm{Ric}(W^2)$ rank test keeps two of them.

| $\theta$ | $\Delta$ | $\lambda_{\max}(L_e|_{W^\perp})$ | margin over $\tfrac12$ | $\mathrm{rank}\,\mathrm{Ric}(W^2)$ | status |
|---|---|---|---|---|---|
| $1.079511059289$ | $1.217619$ | $0.547291527247$ | $1.094583\times$ | $\mathbf 7$ | **padding, discarded** |
| $1.080092196483$ | $3.494141$ | $\mathbf{0.551340110283}$ | $\mathbf{1.102680\times}$ | $8$ | **certified, the new floor** |
| $1.079758865610$ | $2.762850$ | $0.553480567236$ | $1.106961\times$ | $8$ | seed 9033, re-found |
| $1.079098984360$ | $1.239250$ | $0.555212537840$ | (| $\mathbf 7$ | padding), seed 9003, already excluded |
| $1.079206463159$ | $1.161288$ | $0.557516995053$ | (| $\mathbf 7$ | **padding), new** |
| $1.079148535351$ | $1.254529$ | $0.558348554906$ | (| $\mathbf 7$ | **padding), new** |

**The certified one passes every gate**, run through the same instruments as the r305 points and saved as [out_n8_lam0.551340110.npy](../scripts/reviewers/r314/out_n8_lam0.551340110.npy):

- criticality residual $1.67\times10^{-16}$, unit norm exactly, inside $\mathcal W_8$ to $9.7\times10^{-17}$, Ricci-flat to $3.0\times10^{-16}$, $\ker W=0$;
- $\mathrm{Ric}(W^2)$ has **rank $8$** with least eigenvalue $0.00972389$, so it is **not a padding** in any frame;
- $S_{\mathfrak{mmm}}=2.4\times10^{-28}$, $S_{\mathfrak{mpp}}=1.7\times10^{-28}$, so it is **graded** at $\mathfrak p=E_+$, and on a *different* pair from the r305 points: $\dim\mathfrak p=12$, $\dim\mathfrak m=16$, i.e. $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ rather than $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$;
- $L_e$ on $W^\perp$ tops out at $0.551340110$, with $\tfrac12$ of multiplicity $26$ (the orbit) and a further pair at $0.50135288$ above the bound.

So **the off-locus cushion is at most $1.1027\times$**, on a graded $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ point that is new to the record, the first sub-floor witness that is not on the $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ pair. The record's $1.1070\times$ should move to $\mathbf{1.1027\times}$, and its observation that the floor "is falling as the population grows" continues to hold.

**The padding filter earns its place, and it is what stops the floor going lower.** Four of the six, including the lowest, $\lambda_{\max}=0.547291527$, have $\mathrm{Ric}(W^2)$ of **rank $7$** and $\dim\ker W=7$, so they are $n=7$ points in rotated frames and none of them counts. One is Reviewer 305's seed 9003, already excluded by the record; three are new, and all four would have been reported as witnesses by any coordinate-frame test. **Two thirds of what this hunt turns up below the floor at $n=8$ is padding**, which is the practical reason the $\mathrm{Ric}(W^2)$ rank check belongs in the pipeline rather than in the write-up. All four paddings cluster at $\theta\approx1.0791$–$1.0795$ with $\Delta\approx1.16$–$1.25$, which is itself a usable smell test.

---

## Things the brief did not ask about

**1. The record contradicts itself in three places, and in each the wrong half is the one a route is being built on.**

| the two statements | which is right |
|---|---|
| [bounds.md:133](../findings/bounds.md#L133): the $\mathrm{Sym}_0$ image is not $L_e$-invariant, residual $1.245$, versus [bounds.md:135](../findings/bounds.md#L135): "$L_e$ acts as a scalar on each isotypic component" | the first; I measure $1.2447$ and per-block residuals up to $0.329$ |
| [bounds.md:122](../findings/bounds.md#L122): the $C_5$-edge family is **not** an eigenspace, versus [bounds.md:135](../findings/bounds.md#L135): it "came out an exact eigenspace" | the first; constant compression $0.666666667$ with residual $0.236$ |
| [bounds.md:222](../findings/bounds.md#L222): the $n=8$ witness is graded, all three inclusions to $10^{-29}$, versus [graded-half.md:221](../findings/graded-half.md#L221): its positive eigenspace is not closed under bracket, defects $3.6\times10^{-1}$ etc. | the first; I measure $1.2\times10^{-14}$ against bracket norms near $9$, and the witness turns out to carry **two** gradings rather than none |

The third is the costly one: two closures ([graded-half.md:219](../findings/graded-half.md#L219) and [graded-half.md:249](../findings/graded-half.md#L249)) are built on it, and their numbers are right for the reason the record does not give.

**2. A graded critical point can carry several inequivalent gradings, and no $\mathfrak p$-block quantity is well defined until one is named.** This is the single most consequential thing I found, and it is not on the record. At the $n=8$ witness there are at least two $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ gradings, and [bounds.md:224](../findings/bounds.md#L224) separately notes an $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ one, so at least three splittings in all. Even $S^3\times S^5$ carries a second $3+5$ grading with $\lVert A\rVert^2=44/105$ instead of $13/21$. Every $\mathfrak p$-block statement in [graded-half.md](../findings/graded-half.md), $\lVert A\rVert^2$, the block traces, the Cauchy–Schwarz floor, the cross-block Rayleigh quotient, the $\lambda_{\max}$-eigenvector table, and Reviewer 307's whole census, silently picks one, and different passages pick different ones. **The rule the record needs is: $\mathfrak p$ is the strictly-positive eigenspace, certified by the three bracket inclusions, and any other splitting is named explicitly as such.** That choice is already the one [bounds.md:190](../findings/bounds.md#L190)'s equivalence is stated over, so adopting it costs nothing and makes the census, the mass bound and the eigenvector table comparable for the first time.

To find the extra gradings, minimise $\lVert W_{[\mathfrak p,\mathfrak m]}\rVert$ over $\mathrm{Gr}(k,\mathbb R^n)$ from random starts; at the witness this drives to $1.7\times10^{-14}$ from a majority of $25$ starts, so they are not hard to reach and are unlikely to be confined to $n=8$.

**3. Two identities that fell out and are worth keeping.**

- For **any** orthogonal splitting $\mathbb R^n=U\oplus U^\perp$ and any Ricci-flat $W$, $\mathop{\mathrm{tr}}\big(W|_{\Lambda^2U}\big)=\mathop{\mathrm{tr}}\big(W|_{\Lambda^2U^\perp}\big)$, both equal to $-\tfrac12\mathop{\mathrm{tr}}\big(W|_{U\wedge U^\perp}\big)$. It follows in one line from summing $\mathrm{Ric}_{ii}=0$ over each factor, it is confirmed in all three gradings measured here, and it means the two factor traces in the Cauchy–Schwarz floor are a *single* unknown, not two, which is what turns the mass route into a one-variable question.
- $\mathrm{Ric}(W^2)$ is the frame-independent padding certificate: $O(n)$-covariant, PSD, trace $2\lVert W\rVert^2$, and $\mathrm{rank}=$ the true ambient dimension. It reproduces the record's rank verdict on all four r305 points, and it costs one $n\times n$ eigendecomposition.
- The $\mathfrak p$-internal cross-block direction lies exactly $2/3$ inside $\mathcal W_n$ by squared norm, the recorded $57.7\%$ leak is $1/\sqrt3$ exactly, at every point I tried.

**4. $S^2\times S^{n-2}$ fails Lemma L24 at $n=12$ as well.** Its $L_e$ spectrum on $W^\perp$ is $\{5/9^{\times45},\ \tfrac12^{\times20},\ 4/9^{\times54},\ 0^{\times1411},\ -5/9^{\times108}\}$, so $\lambda_{\max}=5/9>\tfrac12$ on a $45$-dimensional block $\big(=\dim\Lambda^2\mathbb R^{10}\big)$ that has no analogue at $p\ge3$. The record has this at $n=5,6,8$ ([diagonal-half.md:134](../findings/diagonal-half.md#L134)); it holds at the threshold dimension too, so the $p\ge3$ hypothesis in the nondegeneracy theorem is not slack.

---

## What I did not settle

- Whether $\lVert A\rVert^2\ge\lVert A_{\mathrm{equiv}}\rVert^2$ holds for the **canonical** grading $\mathfrak p=E_+$. I confirmed it at four points plus Reviewer 307's two census ranges and found no counterexample; I did not prove it, and I did not search for one systematically. The missing ingredient is named: a lower bound on the common block trace $t$.
- How many gradings a graded critical point can carry, and whether the multiplicity is an $n=8$ accident. I found two at the witness and two at $S^3\times S^5$ by random search, which is a lower bound and nothing more.
- The hunt is a sample, not a census. $700$ starts at $n=8$ and $500$ each at $n=6,7$ is far short of exhaustive, and an $n=10$ sweep was started and abandoned as too slow to finish in this cycle. The null result on V3 is evidence of the same kind the record already has, not more.
- I did not audit the symmetric-space classification itself (Lemmas 37–39, 47–48). M1's alternative proof makes Lemma L69 independent of it, but the rest of the record is not.
