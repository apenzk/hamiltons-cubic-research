# Review r369, Gate 2 on Lemma L126 and Lemma L127

*Reviewer r369, cold brief, analysis-only. Every value below was re-derived by hand from the definitions before any code was run; the code appears only as a screen of claims I was about to record, run on objects I built for that purpose, and is reported as a screen. Conventions taken from [adversarial_check1.py](../scripts/lib/adversarial_check1.py): $W$ is the operator on $\Lambda^2$ diagonal in the coordinate-plane basis with entries $\lambda_{ij}=M_{ij}$, $\langle X,Y\rangle=\mathop{\mathrm{tr}}(XY)$ with coordinate planes orthonormal, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $X\circ Y=\tfrac12[Q(X+Y)-Q(X)-Q(Y)]$.*

## Verdicts

| claim | verdict | one line |
|---|---|---|
| **Y1** $DF(M)=\theta(2L_e-\mathrm{Id})$, branch only at $\tfrac12$ | **PLAUSIBLE** | algebra correct; the statement as briefed is vacuous, and [Lemma L126](../findings/second-order.md)'s own gloss turns the only-if into an if |
| **Y2** four-set blocks are orbit-free | **CONFIRMED** | one generator suffices because the $\xi_{jk}$ are a basis and $\xi\mapsto\xi\cdot M$ is linear |
| **Y3** $\mu=\dfrac{n-2}{2(p-1)(q-1)}$, $=\tfrac12$ iff $(3,3)$ | **CONFIRMED at $n=p+q$** | formula and Diophantine step both right; the word **exactly** in "exactly the $(2,2)$-splits" is false under padding |
| **Y4** no $S^2\times S^q$ is a local maximum | **CONFIRMED** | $\mu_{2,q}=q/(2(q-1))$, matching the record's $\tfrac23$ and $\tfrac35$; its supporting scope note is wrong, the conclusion is not |
| **Y5** cross-factor block is $\{\tfrac12,0^{n-4}\}$ | **CONFIRMED** | both Ricci relations are right; only the $0^{n-4}$ half is content |
| **Y6** the third type is the orbit, so $\theta=(n-1)\lvert\gamma\rvert$ | **PLAUSIBLE** | numerically exact, but it is Y5's equation read at the other row, so it cannot be "the check on the whole computation" |
| **Y7** within-factor blocks top at $\dfrac{p-2}{2(p-1)}$ | **REFUTED as stated** | the $\binom q2$ blocks of the family top at $\dfrac{q-2}{2(q-1)}$, $\tfrac7{16}$, not $\tfrac14$, at $S^3\times S^9$ |
| **Y8** $E(\tfrac12)$ is exactly the orbit; no branch | **PLAUSIBLE** | conclusion true and agrees with every number in [nondegeneracy.md](../findings/nondegeneracy.md), but $\mathcal D_n$ is granted rather than computed and no slice is supplied |
| **extra** L126(a)'s "genuine branch direction" at $S^3\times S^3$ | **REFUTED** | [nondegeneracy.md](../findings/nondegeneracy.md) line 556: *"So no branch emanates, but for a third-order reason."* |

## The one refutation that matters, a necessary condition used as a sufficient one

[Lemma L126](../findings/second-order.md)'s statement ends: *"The four-set blocks are orbit-free, so such a direction is a **genuine branch direction** rather than a group direction,"* and its box **(a)** reads *"$S^3\times S^3$ is the **unique** two-factor sphere product **carrying a four-set branch direction**."*

Both are false, and the record already says so.

- A $\tfrac12$-eigenvector is an element of $\ker DF(M)|_{M^\perp}$. That is the tangent space a branch **would** have to lie in, not a branch. Orbit-freeness eliminates one competing reading of the kernel element and establishes nothing positive about the existence of a curve.
- [nondegeneracy.md](../findings/nondegeneracy.md) settles the case directly: at $S^3\times S^3$ the third-order scalar $\Psi_1(v)=\langle\pi Q(v),L^{+}\pi Q(v)\rangle$ equals $-0.5929271$ on the whole zero cone, against $10^{-16}$ on orbit directions, *"as a genuine branch requires. So **no branch emanates**, but for a third-order reason."* Line 411 of the same file adds the corrector evidence: 48 and 262 transverse starts all return to the starting orbit.

So the nine $(2,2)$-split directions at $S^3\times S^3$ are exactly what the record already calls them, **excess kernel, obstructed at third order**. L126 correctly identifies *which* nine they are, which is real new content and is worth keeping. What must go is the modality: "carries a four-set branch direction" becomes "carries the only four-set **candidate** direction in the two-factor family, and the record's $\Psi_1$ shows the candidate does not lift".

The same slip does not infect **(c)** or **Y8**, which use the only-if in the sound direction (no $\tfrac12$ $\Rightarrow$ no branch).

## Y1, correct algebra, vacuous statement

The derivative is right. $DQ(M)Y=2M\circ Y$; $D\big(P(W)W\big)(M)Y=3\theta\langle M,Y\rangle M+\theta Y$ using $\nabla P=3Q(M)=3\theta M$ and $\lVert M\rVert=1$; on $Y\perp M$ this leaves $\theta(2L_e-\mathrm{Id})Y$. $DF(M)$ does preserve $M^\perp$: $\langle DF(M)Y,M\rangle=2\langle M\circ Y,M\rangle=2\langle Y,Q(M)\rangle=2\theta\langle Y,M\rangle=0$, using full symmetry of $\langle X,Y\circ Z\rangle$, which [adversarial_check1.py](../scripts/lib/adversarial_check1.py)'s check 4 is the test for.

**But as briefed ("a branch leaves $M$ only where *some block* carries $\tfrac12$"), the statement is empty.** By [Lemma L24](../findings/second-order.md) the orbit directions are exact $\tfrac12$-eigenvectors, and by **Y5** they sit in the cross-factor pair blocks. So at every sphere product with a positive-dimensional orbit, some block always carries $\tfrac12$, and $DF(M)|_{M^\perp}$ is **never** invertible. The condition is satisfied at every point it is ever evaluated at.

The content is entirely in the restriction L126 actually writes (*"leaves $M$ **through a four-set block**"*) which is legitimate because $DF(M)$ is block-diagonal, so $\ker DF(M)=\bigoplus_{\text{blocks}}\ker$ and a branch tangent with nonzero four-set component forces that block to carry $\tfrac12$. Ask the vacuity question of the briefed form and it fails; ask it of the lemma's form and it survives.

**One unstated convention.** $F(W)=Q(W)-P(W)W$ presumes $Q(\mathcal W_n)\subseteq\mathcal W_n$, or else a Weyl projection that [bounds.md](../findings/bounds.md) discusses explicitly for $L_W$. The projection, if present, must be the same one $L_e$ carries in [Lemma L24](../findings/second-order.md), and neither L126 nor L127 says so.

## Y2, the group counting survives, and the "one generator" objection fails

With $\xi=\xi_{jk}$ acting by $\xi e_j=e_k$, $\xi e_k=-e_j$, $\xi e_m=0$:

$$\xi\cdot M \;=\; 2\sum_{m\notin\{j,k\}}\big(M_{jm}-M_{km}\big)\,e_{jm}\odot e_{km},$$

since $\xi\cdot e_{jm}=e_{km}$, $\xi\cdot e_{km}=-e_{jm}$, $\xi\cdot e_{jk}=0$, and $\xi$ annihilates every plane missing $j$ and $k$. That is precisely the $\{j,k\}$ pair block, with the coefficients [Lemma L122](../findings/second-order.md) records.

**Checking one generator is a proof, not a plausibility argument**, because $\{\xi_{jk}\}_{j<k}$ is a basis of $\mathfrak{so}(n)$ and $\xi\mapsto\xi\cdot M$ is linear: the image of the whole algebra is the span of the per-generator images, hence contained in $\bigoplus$ pair blocks. The four-set blocks are orthogonal to all of them. The brief's error shape 3 does not bite here.

The dimension count is also right: within a factor $M_{jm}=M_{km}$ for every $m$, so within-factor blocks carry zero orbit tangent; cross-factor blocks carry $\alpha-\gamma$ on $F_1\setminus j$ and $\gamma-\beta$ on $F_2\setminus k$, one direction each, $pq$ in total, matching $\binom n2-\binom p2-\binom q2$. **What L126 imports without saying so** is that the stabiliser is exactly $S(O(p)\times O(q))$ up to components; that is Nienhaus's $\mathbb R^p\otimes\mathbb R^q$ identification, cited in [nondegeneracy.md](../findings/nondegeneracy.md) and not here.

## Y3, the formula is right, the word "exactly" is not

On a $(2,2)$-split $\{i,j\}\subset F_1$, $\{k,l\}\subset F_2$: $A=\alpha+\beta$, $B=C=2\gamma$, so $\Sigma=(A-B)^2$ and the block eigenvalue is $\pm\tfrac12\lvert\alpha+\beta-2\gamma\rvert$. Normalising $\gamma=-1$ and using both Ricci relations, $\alpha=q/(p-1)$, $\beta=p/(q-1)$:

$$\alpha+\beta-2\gamma=\frac{q(q-1)+p(p-1)+2(p-1)(q-1)}{(p-1)(q-1)}=\frac{n^2-3n+2}{(p-1)(q-1)}=\frac{(n-1)(n-2)}{(p-1)(q-1)},$$

and dividing by $2\theta=2(n-1)$ gives $\mu=\dfrac{n-2}{2(p-1)(q-1)}$. Splits $(3,1)$ and $(4,0)$ give $A=B=C$, hence $\Sigma=0$. Diophantine step: $u=p-1$, $v=q-1$, $u+v=uv\iff(u-1)(v-1)=1\iff u=v=2$; $u=1$ is impossible. **All correct.**

**Where it breaks.** At a *padded* sphere product the four-sets touching a padding index are nonzero:

| four-set type | $\Sigma^{1/2}$ | $L_e$ value |
|---|---|---|
| $2$ in $F_1$, $1$ in $F_2$, $1$ pad | $\lvert\alpha-\gamma\rvert$ | $\dfrac1{2(p-1)}$ |
| $1$ in $F_1$, $2$ in $F_2$, $1$ pad | $\lvert\beta-\gamma\rvert$ | $\dfrac1{2(q-1)}$ |
| $2$ in $F_1$, $2$ pad | $\alpha$ | $\dfrac q{2(p-1)(n_0-1)}$ |
| $1$ in $F_1$, $1$ in $F_2$, $2$ pad | $\lvert\gamma\rvert$ | $\dfrac1{2(n_0-1)}$ |

The first row is **exactly $\tfrac12$ when $p=2$**. Counting them gives excess $q\,(n-n_0)$ for $S^2\times S^q$ and $4(n-4)$ for $S^2\times S^2$, which is, digit for digit, the measured excess [nondegeneracy.md](../findings/nondegeneracy.md) records at lines 377 and 409. I take that agreement, reached from L121+L122 alone with no access to those figures, as the strongest available corroboration of the two block lemmas.

## Y4, right, and stronger than its own supporting note

$\mu_{2,q}=q/(2(q-1))>\tfrac12$: correct, and $\mu_{2,4}=\tfrac23$, $\mu_{2,6}=\tfrac35$ match [diagonal-half.md](../findings/diagonal-half.md)'s recorded $0.666667$ at $S^2\times S^4$ and [second-order.md](../findings/second-order.md)'s padding-invariant $0.6\overline6$ and $0.6$. The logic is sound: a local maximum is critical, the four-set space carries a non-trivial sign character so it is orthogonal to the diagonal $M$, hence inside $W^\perp$ where [Lemma L24](../findings/second-order.md) applies.

**The parenthetical is wrong and the claim is better without it.** It says *"the statement is made for the padded object the record catalogues"*, but the lemma's own "exactly the $(2,2)$-splits" is false for the padded object, per Y3 above. The right defence is the opposite one: **$\mu$ is padding-invariant** because the $(2,2)$-split four-sets and $\theta$ both survive padding unchanged, which is what [second-order.md](../findings/second-order.md) line 135 already measures.

**And L126 is doing work L27 cannot do here.** The Nienhaus decomposition [Lemma L27](../findings/nondegeneracy.md) rests on fails at $p=2$: at $(p,q)=(2,4)$ its ten summands total $1+0+10+8+2+9+18+6+0+32=86$ against $\dim\mathrm{Weyl}_6=84$, over by exactly $\dim S^2_0(\mathbb R^2)=2$, the departure [nondegeneracy.md](../findings/nondegeneracy.md) flags. [Lemma L120](../findings/second-order.md)'s block decomposition has no such gap. That is a real gain and L126 undersells it.

## Y5, confirmed, with one trap and one vacuity note

**Both Ricci relations check out against the record's own convention.** Ricci-flatness is $\sum_b M_{ab}=0$ with $M$ hollow. For $a\in F_1$ the row is $(p-1)$ entries $\alpha$ and $q$ entries $\gamma$, giving $(p-1)\alpha+q\gamma=0$; for $b\in F_2$ it is $(q-1)\beta+p\gamma=0$. Both as stated.

The Laplacian is the one L122's bracket form forces: $\Delta^{(jk)}=D-A$ with $D_{ii}=-(M_{ij}+M_{ik})$, which equals the submatrix row sum $\sum_{m\notin\{j,k\}}M_{im}$ **only under Ricci-flatness**, exactly the scope correction L123 records. On the cross-factor block:

| eigenvector | $\Delta$ eigenvalue | after Ricci | block value | mult |
|---|---|---|---|---|
| sum-zero on $F_1\setminus j$ | $(p-1)\alpha+(q-1)\gamma$ | $-\gamma$ | $0$ | $p-2$ |
| sum-zero on $F_2\setminus k$ | $(q-1)\beta+(p-1)\gamma$ | $-\gamma$ | $0$ | $q-2$ |
| constant on each part | $(n-2)\gamma$ |, | $-\tfrac12(n-1)\gamma$ | $1$ |

I verified the third row independently on both parts, which is a non-trivial consistency check: on $F_1\setminus j$ it gives $a[-(p-1)\alpha+(p-2)\gamma]=a(n-2)\gamma$, on $F_2\setminus k$ it gives $b[-(q-1)\beta+(q-2)\gamma]=b(n-2)\gamma$, and the two agree only because both Ricci relations hold. The three types span $(p-2)+(q-2)+1=n-3$, which is the whole of $\mathbf 1^\perp$, so the list is complete.

> **A trap for anyone recomputing this.** The natural basis $f_i$, $i\notin\{j,k\}$, has $n-2$ elements and the Ricci cut removes $\mathbf 1$. The discarded $\mathbf 1$-direction carries $L_e$ eigenvalue $\tfrac1{2(n-1)}$ ($\tfrac1{14}$ at $n=8$, $\tfrac1{22}$ at $n=12$) so a block computed without the cut shows a spurious third value and the row reads as false. This is worth a sentence in the lemma.

**Vacuity.** Half of Y5 is free: $\tfrac12$ appears because the orbit tangent is in the block and orbit tangents are always $\tfrac12$-eigenvectors. The content is the $0^{n-4}$ (that *nothing else* in a cross-factor block reaches $\tfrac12$) and that is genuinely new.

## Y6, true, but it is Y5's equation read at the other row

$\theta=(n-1)\lvert\gamma\rvert$ is correct: with $\lVert W\rVert^2=\sum_{a<b}M_{ab}^2$ it reproduces the record's own $\theta$ to every printed digit, $1.145643924$ at $S^4\times S^4$, $1.2$ at $S^5\times S^5$, $1.228239158$ at $S^5\times S^7$, all from [nondegeneracy.md](../findings/nondegeneracy.md)'s table.

**What is wrong is the epistemic claim.** L127's table entry "$\{\tfrac12$ simple, $0^{n-4}\}$" is *obtained* by identifying the third eigenvector type with the orbit and therefore setting $-\tfrac12(n-1)\gamma=\theta/2$. Y6 then solves that same equation for $\theta$ and calls the answer "recovered rather than assumed", and the box calls it *"the check on the whole computation"*. It cannot be a check on a computation that used it. This is the shape the record has already been burned by once, *"both of the programme's standing spectral bounds are one system read at two rows"*. Exactly one of Y5's $\tfrac12$ and Y6's $\theta$ is content.

Two repairs are available and either would fix it: cite $\theta=(n-1)\lvert\lambda_{\min}\rvert$ independently, or (better), state the actual consequence, which is sharper than "recovered": **$\lambda_{\min}=\gamma$ at $S^p\times S^q$, so the sphere products attain equality in [the $\Pi$-bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$](../findings/bounds.md).** Saturation of a standing bound along a whole family is a result; a restated definition is not.

**And it fails off $n=p+q$.** Screened at $S^4\times S^4$ padded to $n=10$: $\theta$ stays $1.145643924$ while $(n-1)\lvert\gamma\rvert=1.472970759$. Correct, since padding freezes $\theta$; but it means the identity is a statement about the native dimension only, and neither the box nor the table says so.

## Y7, the table row is wrong

The within-factor computation is right for the first factor. With $j,k\in F_1$ the block's third eigenvector type (constant on $F_1\setminus\{j,k\}$ and on $F_2$, inside $\mathbf 1^\perp$) has $\Delta$ eigenvalue $(n-2)\gamma$ and block value $-\tfrac12(n-2)\gamma-\tfrac12\alpha$, which collapses:

$$\frac{(n-2)-\alpha}{2(n-1)}=\frac{(p-2)(n-1)/(p-1)}{2(n-1)}=\frac{p-2}{2(p-1)}.$$

The other two types give $0$ (multiplicity $p-3$) and $-\mu$ (multiplicity $q-1$), so $(p-2)/(2(p-1))$ is indeed the top of a **first-factor** block, and it is $<\tfrac12$ at every $p$.

**But L127's table assigns that single value to a family of $\binom p2+\binom q2$ blocks**, and the $\binom q2$ blocks of the second factor top at $(q-2)/(2(q-1))$ by the identical argument with $p\leftrightarrow q$. The row is therefore false as a statement about the family it names. At $S^3\times S^9$ the row asserts $\tfrac14$ while the family's actual top is $\tfrac7{16}$, a factor of $1.75$, and the error grows with the asymmetry.

The conclusion *"no, at any $p$"* survives, since both values are $<\tfrac12$. The row needs to read $\max\!\big(\tfrac{p-2}{2(p-1)},\tfrac{q-2}{2(q-1)}\big)$, or be split into two rows.

## Y8, the conclusion is right; two steps of the proof are missing

**It agrees with every number in [nondegeneracy.md](../findings/nondegeneracy.md).** Assembling $\dim E(\tfrac12)$ from the block table: $pq$ from the cross-factor blocks, plus $\binom p2\binom q2$ from the four-sets only when $\mu=\tfrac12$. That gives $16$ at $S^4\times S^4$, $25$ at $S^5\times S^5$, $35$ at $S^5\times S^7$, $8$ at $S^2\times S^4$, and $9+9=18$ at $S^3\times S^3$, matching the recorded table row for row, including the unbalanced $S^5\times S^7$ that Reviewer 15 flagged as structurally different. I found **no** disagreement with the record.

I also reconciled the block table against [Lemma L27](../findings/nondegeneracy.md)'s isotypic spectrum, which is an independent route. The blocks account for $\dim(\Lambda^2\!\otimes\!\Lambda^2)=\binom p2\binom q2$ copies of $+\mu$ exactly; the $-\mu$ deficit against $\dim(S^2_0\!\otimes\!S^2_0)$ is $(p-1)(q-1)$, the $\lambda_p$ deficit is $p-1$, the $\lambda_q$ deficit is $q-1$, and the zero deficit is whatever is left, and at $(3,3)$ these total $1+2+2+4=9=\dim\mathcal D_6$ on the nose, with the block zeros $30$ equalling $\dim(X_3\!\otimes\!\mathbb R^3)^{\oplus2}=30$ exactly. The two pictures are the same operator.

**Hole 1, $\mathcal D_n$ is granted, and the grant is the wrong shape.** L127's fourth table row reads *"$\mathcal D_n\mid1\mid$ the diagonal locus $\mid$ granted by README.md"*. Y8 needs **strict** $<\tfrac12$ on $\mathcal D_n\cap W^\perp$ to conclude "$E(\tfrac12)$ is EXACTLY the orbit". The diagonal case of the conjecture gives at most $\le\tfrac12$, by L24, and only at a maximiser; it gives no strict inequality and no spectrum. So the consequence box's *"every non-orbit direction is strictly below $\tfrac12$"* is not established by the table it is read off, and the claim *"what is new is a proof for all $p,q$ and all $n$"* overstates: on the largest summand the proof is still [Lemma L27](../findings/nondegeneracy.md)'s. The row is also mislabelled, $\mathcal D_n$ has dimension $n(n-3)/2$, not count $1$.

*Screen:* the grant is dischargeable. The top of $\mathcal D_n\cap W^\perp$ is $\max(\lambda_p,\lambda_q)$ with no $\tfrac12$ anywhere, $\tfrac13$ at $(4,4)$, $\tfrac5{12}$ at $(5,7)$, $\tfrac7{16}$ at $(3,9)$, $\tfrac14$ at $(3,3)$, $\tfrac13$ at $(2,4)$, matching the isotypic prediction. So the lemma can be repaired rather than withdrawn, but it must be repaired.

**Hole 2, "no non-diagonal critical point branches off it" needs a slice, and is literally false as written.**

- The conclusion asserted is that $\mathrm{Crit}(P)$ near $M$ is exactly the orbit. $DF(M)|_{M^\perp}$ is *never* injective, so the plain implicit function theorem is unavailable. The argument that works: the $O(n)$-action is compact, so a slice $S$ transverse to $\mathcal O$ at $M$ exists; $\ker DF(M)|_{M^\perp}=T_M\mathcal O$ makes $dF|_S(M)$ injective; injectivity gives $\lVert F|_S(x)\rVert\ge c\lVert x-M\rVert$ near $M$, so $M$ is an isolated zero in the slice, so $\mathrm{Crit}(P)$ is locally $\mathcal O$. Three ingredients (slice, injectivity, the lower bound), none of them in the lemma.
- As a sentence it is false: every point of $\mathcal O$ other than the frame-adapted ones **is** a non-diagonal critical point, arbitrarily close to $M$. The claim only ever meant "modulo the orbit", which the preceding clause says and this one drops.

**Scope.** Everything in Y8 is stated at $n=p+q$ and must stay there. Under padding the cross-factor index set $(F_1\setminus j)\cup(F_2\setminus k)\cup\text{pad}$ is a **three**-block equitable partition, so the proof's "equitable two-block partition" step does not survive, and by Y3 new four-set values appear. That the record's padded points still come out nondegenerate for $p,q\ge3$ is consistent (the new values are $\tfrac1{2(p-1)}\le\tfrac14$) but it is not what L127 proves.

## The two hunts that came back clean

**Frame-dependence.** No instance. The concern is real for [Lemma L124](../findings/second-order.md)'s $\Sigma$, which is a frame-dependent quantity ordered against the invariant $\theta$. It does not transfer: L120's decomposition is frame-dependent, but it is a *complete orthogonal decomposition into $L_M$-invariant summands*, so the union of the block spectra is the spectrum of $L_e$, which is an invariant. The dimension identity closes ($\tfrac{n(n-3)}2+2\binom n4+(n-3)\binom n2$), invariance is L120, and the diagonalising frame for $S^p\times S^q$ is the standard one. $\lambda_{\max}(L_e|_{W^\perp})$ read off the blocks is therefore genuinely frame-invariant. The screen agrees: the same values arise from a basis-free $B(W,\cdot)$ that never diagonalises anything.

**Category error.** No instance. Every citation of L121/L122 in L126 and L127 lands on $\mathrm{Sym}^2(\Lambda^2)$: the four-set block is the span of $e_{ij}\odot e_{kl}$ and its two partners, the pair block is the span of $e_{ji}\odot e_{ki}$, and $\Delta^{(jk)}$ is a matrix on the *index set* $i\notin\{j,k\}$ built from $W$'s $\Lambda^2$-diagonal, a coefficient matrix, not an operator on $\Lambda^2$. Nothing here reads an invariant plane of $W$ on $\Lambda^2$ off a block of $L_M$, which is what L124 was caught doing.

## What I would change

1. **L126 statement and box (a):** delete "genuine branch direction"; replace with "candidate branch direction", and cite [nondegeneracy.md](../findings/nondegeneracy.md)'s $\Psi_1=-0.5929271$ for the fact that no branch actually emanates at $(3,3)$.
2. **L127 within-factor row:** $\max\!\big(\tfrac{p-2}{2(p-1)},\tfrac{q-2}{2(q-1)}\big)$, or two rows.
3. **L127 $\mathcal D_n$ row:** dimension $n(n-3)/2$, and either discharge it (its spectrum is $\{1;\lambda_p^{\,p-1};\lambda_q^{\,q-1};(-\mu)^{(p-1)(q-1)};0^{\text{rest}}\}$, which the isotypic reconciliation above forces) or mark the consequence box conditional. As it stands "the proof for all $p,q$ and all $n$" is not one.
4. **Y6's box:** replace "recovered rather than assumed" with the saturation statement (sphere products attain equality in the $\Pi$-bound) and drop "the check on the whole computation".
5. **L126(b)'s parenthetical:** the defence is padding-invariance of $\mu$, not that the lemma is stated for the padded object; and record the gain, that L120/L121 reach $p=2$ where the Nienhaus decomposition does not.
6. **Y8's last clause:** "modulo its orbit", and a sentence naming the slice.
7. **L127 proof:** one line warning that the pair-block basis is $(n-2)$-dimensional and the discarded $\mathbf 1$-direction carries $\tfrac1{2(n-1)}$.

*Screening note, per the standing analysis-only rule: the only computation run was a few seconds of re-derivation on sphere-product sectional matrices I constructed myself, checking values I had already obtained by hand. It is reported as a screen. No positive claim above rests on it.*
