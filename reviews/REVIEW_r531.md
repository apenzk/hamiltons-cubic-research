# REVIEW r531, Lemma L121 (the 4-set block, its spectrum, one necessary condition per 4-subset)

**Target**: `findings/second-order.md`, `#### Lemma L121` (line 629) through the next heading.
**Reviewer**: r531, cold, adversarial. Analysis-only footing: no searches, sweeps, or censuses.

## Phase plan

- P1 read L121 verbatim; fix conventions against the record's anchors
- P2 derive the matrix G from the structure constants; settle the symmetry question
- P3 derive all three eigenvalues; check the two forms of the radical
- P4 check the constant in the necessary condition against L24's normalisation
- P5 separate what needs "diagonal critical point" from what needs "maximiser"
- P6 cross-check the S^p x S^q specialisation against L26
- P7 audit the 25 citations; sweep findings/ for contradictions
- P8 verdict

VERDICT: **CONFIRMED**

## Findings

### F0. The verbatim text under audit

> **Fix a diagonal critical point $M$ with $\theta>0$ and a $4$-subset $\{i,j,k,l\}$. Let $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$ be the three opposite-pair sums. Then in signed coordinates $L_M$ restricted to the $4$-set space is $\tfrac12G$ with $G=\begin{pmatrix}A&C&B\\C&B&A\\B&A&C\end{pmatrix}$; $G\mathbf 1=(A+B+C)\mathbf 1$, so the Bianchi subspace is $\mathbf 1^\perp$ automatically and the block is traceless with spectrum** $\pm\tfrac12\sqrt{A^2+B^2+C^2-AB-BC-CA}$.

### F1. The brief's premise is wrong: the printed $G$ IS symmetric, CONFIRMED as printed

The brief asserts "as printed the rows are $(A,C,B)$, $(C,B,A)$, $(B,A,C)$, which is **not** symmetric". Read the entries: $G_{12}=C=G_{21}$, $G_{13}=B=G_{31}$, $G_{23}=A=G_{32}$. **It is symmetric**, with diagonal $(A,B,C)$ and the off-diagonal slot $(r,s)$ carrying the third letter, the one that is neither $r$'s nor $s$'s diagonal entry. Nothing needs to force it and nothing is mis-printed. Self-adjointness is genuine, because the three signed basis vectors $\varphi_{ij}\odot\varphi_{kl}$, $-\varphi_{ik}\odot\varphi_{jl}$, $\varphi_{il}\odot\varphi_{jk}$ are mutually orthogonal and of equal norm in $\mathrm{Sym}^2(\Lambda^2)$, so a symmetric coordinate matrix *is* a self-adjoint operator.

### F2. $G$ derived from the structure constants, CONFIRMED, and the "signed coordinates" are pinned

Write $X\circ Y=\tfrac12(XY+YX)+B_\#(X,Y)$ with $B_\#(X,Y)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\varepsilon}c_{\beta\delta\zeta}X_{\gamma\delta}Y_{\varepsilon\zeta}$, the polarisation of $W^\#$ ([conventions.md](../findings/conventions.md), the $\circ$ bullet). Take $\{i,j,k,l\}=\{1,2,3,4\}$ and $X$ supported on the three opposite pairings, $a=X_{12,34}$, $b=X_{13,24}$, $c=X_{14,23}$.

- **The commutator half.** $M$ diagonal in the pair basis gives $(MX+XM)_{\alpha\beta}=(M_\alpha+M_\beta)X_{\alpha\beta}$, so $\tfrac12(MX+XM)=\tfrac12\operatorname{diag}(A,B,C)$ in $(a,b,c)$. **That is $G$'s diagonal.**
- **The $\#$ half.** With $M$ diagonal, $B_\#(M,X)_{\alpha\beta}=\tfrac12\sum_\gamma M_\gamma\sum_{\varepsilon\zeta}c_{\alpha\gamma\varepsilon}c_{\beta\gamma\zeta}X_{\varepsilon\zeta}$. For $\alpha=\varphi_{12}$, $\beta=\varphi_{34}$ exactly four triangles contribute, $\gamma\in\{23,24,13,14\}$. Using $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ the four sign products are $(+1)(-1)$, $(+1)(+1)$, $(-1)(-1)$, $(-1)(+1)$, giving
  $$B_\#(M,X)_{12,34}=\tfrac12\big[-(M_{14}+M_{23})\,b+(M_{13}+M_{24})\,c\big]=\tfrac12\big[-Cb+Bc\big].$$
- **Bianchi fixes the signs.** $X_{ijkl}+X_{iklj}+X_{iljk}=0$ reads $a-b+c=0$ in these coordinates, so the **signed coordinates are $(\hat a,\hat b,\hat c)=(a,-b,c)$** and Bianchi becomes $\hat a+\hat b+\hat c=0$. In them the row above is $\tfrac12(A,C,B)$, **row 1 of $\tfrac12G$ exactly.**
- **The other two rows follow by $O(n)$-equivariance and do not need re-deriving.** The transposition $(2\,3)$ sends $(A,B,C)\mapsto(B,A,C)$ and acts on signed coordinates as $-P_{12}$, so it must conjugate $G(A,B,C)$ to $G(B,A,C)$: $P_{12}GP_{12}=\begin{pmatrix}B&C&A\\C&A&B\\A&B&C\end{pmatrix}=G(B,A,C)$. **Matches.** $(2\,4)$ gives $(A,B,C)\mapsto(C,B,A)$ and $P_{13}GP_{13}=G(C,B,A)$. **Matches.**

The record reaches the same sign convention independently at [second-order.md line 889](../findings/second-order.md): *"first Bianchi reads $T_{1234}-T_{1324}+T_{1423}=0$, so L121's signed coordinates negate the middle pairing"*.

**Screen** (constructed objects, seconds; reported as a screen): built $\mathfrak{so}(6)$ structure constants and $Q(W)=W^2+W^\#$ from scratch. It reproduces four of the record's anchors, $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, $\operatorname{tr}M^\#=-1$, $Q(M)=\theta M$ and $\theta(S^3\times S^3)=\sqrt{10}/3$, and $L_M$ on the $4$-set space equals $\tfrac12G$ **at all $15$ four-subsets, and also at a generic NON-critical $M\in\mathcal D_6$**.

### F3. All three eigenvalues, and the two forms of the radical, CONFIRMED

$G$ is symmetric with equal row sums, so $G\mathbf 1=(A+B+C)\mathbf 1$; $\operatorname{tr}G=A+B+C$, hence the other two eigenvalues sum to zero, $\pm r$. Summing squares of entries, $\operatorname{tr}G^2=3(A^2+B^2+C^2)$, so
$$2r^2=3\textstyle\sum A^2-(A+B+C)^2=2\big(\sum A^2-\sum AB\big),\qquad r=\sqrt{A^2+B^2+C^2-AB-BC-CA}.$$
**The three eigenvalues of $\tfrac12G$ are $\tfrac12(A+B+C)$ on $\mathbf 1$ and $\pm\tfrac12 r$ on $\mathbf 1^\perp$**, the printed pair, plus the third the block leaves implicit because $\mathbf 1$ is the direction first Bianchi deletes. The radical identity is immediate: $\tfrac12\sum(A-B)^2=\sum A^2-\sum AB$. Determinant screen at $(A,B,C)=(1,2,3)$: $\det G=-18=-(A{+}B{+}C)r^2$.

**The record restates the same radicand a third way at [post F50](../findings/second-order.md), and it agrees**: $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$ with $\sigma=A+B+C$ is $\sum A^2-\sum AB$.

### F4. The constant $\theta^2$, CONFIRMED, and it is sharp

L121 works in **$L_M$** units, which the record states in terms at [second-order.md line 739](../findings/second-order.md): *"the $\tfrac12$ threshold is in $L_e$ units, L121 and L122 giving $L_M$ eigenvalues whose orbit value is $\theta/2$."* [Lemma L24](../findings/second-order.md) is stated for $L_e=e\circ(\cdot)$, $e=M/\theta$, so $L_e=L_M/\theta$ and $\lambda_{\max}(L_M|_{W^\perp})\le\theta/2$. The block's top eigenvalue is $\tfrac12 r$, whence $\tfrac12 r\le\tfrac12\theta$, i.e.
$$\Sigma=A^2+B^2+C^2-AB-BC-CA\ \le\ \theta^2 .$$
**No factor of $2$ is dropped or gained.** Two independent confirmations that the constant is right and not merely self-consistent:

| check | value | source |
| --- | --- | --- |
| $S^3\times S^3$: $\tfrac12 r$ against $\theta/2$ | $r=\theta$ exactly, equality in the bound | screen, and [Lemma L126](../findings/second-order.md)'s "$\tfrac12$-threshold met only at $S^3\times S^3$" |
| $S^2\times S^4$ (critical, not a maximiser): $\Sigma$ against $\theta^2$ | $\Sigma=(16/9)\theta^2=1.667$ vs $\theta^2=0.9375$ | [second-order.md line 1202](../findings/second-order.md), reproduced independently here |

The $4$-set block does lie in $W^\perp$, so L24 applies without a projection correction: $M$ spans the trivial $\Gamma$-character and the $4$-set block carries $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$, which is [Lemma L120](../findings/second-order.md)'s "$W^\perp$ cuts $\mathcal D_n$ and nothing else".

### F5. Hypotheses, correctly split as printed, and weaker than stated for the structural half

- **$G$, its symmetry, $G\mathbf 1=(A+B+C)\mathbf 1$, tracelessness on $\mathbf 1^\perp$, and the spectrum $\pm\tfrac12\sqrt\Sigma$** need **diagonality of $M$ alone**. My derivation uses no row sum, no criticality, no unit norm and no $\theta$; the screen confirms it at a non-critical $M\in\mathcal D_6$. The block states it for a "diagonal *critical* point", which is **stronger than needed**, a looseness the record already corrects one heading below, at [Lemma L123](../findings/second-order.md): *"L121 holds under **diagonality alone**, verified from the structure constants, with no row sum of $M$ entering, although this file states it for a diagonal *critical* point"*. **Agreement, reached independently.**
- **$\Sigma\le\theta^2$** needs **maximality**, and the block says so in its own words, "at every maximiser and every $4$-subset". It also needs $\theta>0$ (L24's scope) and needs $M$ to be the maximiser in its own eigenframe, so that the block sits in $W^\perp$. **No hypothesis-free part is run together with a maximality-needing part here.** The record independently marks the same boundary twice: at [line 769](../findings/second-order.md), where $S^2\times S^4$ is *"pure, critical and Morse–Bott nondegenerate"* with $\mu_{2,4}=\tfrac23>\tfrac12$, and at [line 1202](../findings/second-order.md).

### F6. Agreement with Lemma L26, CONFIRMED, and PROVEN at every $(p,q)$, not screened

Let $P=p-1$, $Q=q-1$, $n=p+q$, and let $M\in\mathcal D_n$ be $S^p\times S^q$: $M_{ab}=\alpha$ inside the $p$-block, $\beta$ inside the $q$-block, $\gamma$ across. Ricci-flatness gives $\alpha=-q\gamma/P$, $\beta=-p\gamma/Q$.

**(a) Only $(2,2)$-splits are nonzero.** A $(4,0)$-split has $A=B=C=2\alpha$; a $(3,1)$-split has $A=B=C=\alpha+\gamma$. Both give $\Sigma=0$. A $(2,2)$-split has $A=\alpha+\beta$, $B=C=2\gamma$, so $\Sigma=(A-2\gamma)^2$ and $\tfrac12 r=\tfrac12\lvert\alpha+\beta-2\gamma\rvert$. **Both clauses of the block confirmed** (and matching [line 890](../findings/second-order.md), *"$L_e=0$, since $A=B=C$ there"*).

**(b) The value.** $\alpha+\beta-2\gamma=-\gamma(n-1)(n-2)/(PQ)$ and $\lVert M\rVert=1$ forces $\gamma^2=2PQ/\big(pq(n-1)(n-2)\big)$. So the claim $\tfrac12 r/\theta=\mu=\tfrac{n-2}{2PQ}$ collapses to the single identity
$$\boxed{\ \theta=(n-1)\lvert\gamma\rvert\ }$$
which the record already holds, independently derived, at [second-order.md line 739](../findings/second-order.md): *"its value is $\theta/2$ and $\theta=(n-1)\lvert\gamma\rvert$"*.

**(c) And that identity is a theorem, not a check.** For diagonal $M$, $\theta=\sum_{a<b}M_{ab}^3+\tfrac12\operatorname{tr}_n(M^3)$ (the $\#$ diagonal being $(M^\#)_{(ab)(ab)}=\sum_m M_{am}M_{bm}$). The $n\times n$ spectrum of $M$ is $\{-\alpha^{(P)},-\beta^{(Q)},0,-n\gamma\}$, so $\theta=\gamma^3\big[-\tfrac{q^3}{2P}-\tfrac{p^3}{2Q}+pq-\tfrac{n^3}{2}\big]$, and $\theta=(n-1)\lvert\gamma\rvert$ becomes the polynomial identity
$$p^3(p-1)+q^3(q-1)-2pq(p-1)(q-1)+(p+q)^3(p-1)(q-1)=pq(p+q-1)^2(p+q-2).$$
In $s=p+q$, $m=pq$ the left side collapses to $m(s^3-4s^2+5s-2)=m(s-1)^2(s-2)$, which **is** the right side. $\square$ **So L121's closed form and L26's $\mu=\frac{n-2}{2(p-1)(q-1)}$ agree at every $(p,q)$, by two independent derivations.** This is the strongest single piece of evidence in the audit, and it validates both lemmas.

**(d) The eigenvector agrees too.** With $B=C=t$, $G(2,-1,-1)^{\mathsf T}=(A-t)(2,-1,-1)^{\mathsf T}$, so the $+\tfrac12 r$ eigenvector is $(2,-1,-1)$ in signed coordinates; undoing the middle sign gives $(\tfrac23,\tfrac13,-\tfrac13)$ after normalisation, **verbatim L26's recorded coefficients** ("$X$ is supported on the three pairings of four indices, with coefficients $\tfrac23,\tfrac13,-\tfrac13$"), and verbatim [line 889](../findings/second-order.md). The screen returns $(0.816497,-0.408248,-0.408248)=(2,-1,-1)/\sqrt6$.

**(e) The $(3,4)$ exception added to L26 today does not touch this.** It concerns which eigenvalue is *second-largest* overall at $(3,4)$, not $\mu$'s value; $\mu_{3,4}=\tfrac5{12}$ satisfies the identity above ($2160=2160$).

### F7. The subsidiary numbers in the block, all CONFIRMED

| claim | check |
| --- | --- |
| $\dim E(\tfrac12)=18$ at $S^3\times S^3$ = $9$ orbit $+\ 9$ four-set | $\dim O(6)-\dim(O(3)\times O(3))=15-6=9$; $(2,2)$-splits number $\binom32^2=9$; screen gives $+\tfrac12$ once per $(2,2)$ block and $0$ on the other six four-sets |
| $\mu=\tfrac{n-2}{2(p-1)(q-1)}=\tfrac2{n-2}=\tfrac12$ at $n=6$ | holds; the middle form $\tfrac2{n-2}$ is **balanced-split only**, which is safe in context and which [line 889](../findings/second-order.md) makes explicit by writing $\mu_{m,m}$ |
| $\tfrac23$ at $S^2\times S^4$, $\tfrac35$ at $S^2\times S^6$ | $\tfrac4{2\cdot1\cdot3}=\tfrac23$; $\tfrac6{2\cdot1\cdot5}=\tfrac35$ |
| the second eigenvalue $-\mu$ is new | follows from the traceless restriction; nothing earlier in the record prints it |

### F8. Two presentational defects in the printed sentence (repairable, not refuting)

1. **The "so" points the wrong way.** The text reads *"$G\mathbf 1=(A+B+C)\mathbf 1$, **so** the Bianchi subspace is $\mathbf 1^\perp$ automatically"*. The Bianchi subspace is $\mathbf 1^\perp$ because first Bianchi reads $\hat a+\hat b+\hat c=0$ **in the signed coordinates**, a fact about the Weyl condition and the chosen signs, which owes nothing to $G$. What $G\mathbf 1=(A+B+C)\mathbf 1$ actually buys is that $\mathbf 1^\perp$ is **$G$-invariant**, so the restriction to the Bianchi subspace is an operator rather than a compression. Suggested repair: *"first Bianchi reads $\hat a+\hat b+\hat c=0$, so the Bianchi subspace is $\mathbf 1^\perp$; and $G\mathbf 1=(A+B+C)\mathbf 1$, so $\mathbf 1^\perp$ is $G$-invariant"*.
2. **"the block is traceless" has the wrong antecedent as printed.** $\operatorname{tr}(\tfrac12G)=\tfrac12(A+B+C)$, which is nonzero in general (it is $-0.2108$ at $S^3\times S^3$ in the screen). Only the restriction to $\mathbf 1^\perp$ is traceless. The reading is recoverable from context, and [INDEX-results.md](../findings/INDEX-results.md) row 121 inherits the same wording ("the $4$-set block in closed form, traceless, …").

### F9. The 25 citations in [second-order.md](../findings/second-order.md), what each takes

19 distinct lines carry the 25 mentions. **None takes a strengthening of the lemma; none contradicts it.**

| lines | what is taken | verdict |
| --- | --- | --- |
| 85 ([L125](../findings/second-order.md)) | the necessary condition, in the projection-corrected form $\Sigma\le\theta^2(1+c^2)^2$ | consistent, reduces to $\Sigma\le\theta^2$ at $c=0$, which is the diagonal-eigenframe case L121 states |
| 674, 676, 813 ([L123](../findings/second-order.md), post F44) | the matrix and spectrum, explicitly **rescoped to diagonality alone** | agrees with F5; 674 correctly warns that L24's $X\perp W$ fails off the eigenframe |
| 700, 702, 704 ([L124](../findings/second-order.md)) | the necessary condition and $G$'s eigenvector, in three **withdrawn** readings | consistent. 704's *"at padded $\mathbb{CP}^2$ the top eigenvector of $G$ is $(A,B,C)$ itself"* checks out: there $A{+}B{+}C=0$ and $B=C$, and $G(2,-1,-1)^{\mathsf T}=3c(2,-1,-1)^{\mathsf T}$ |
| 712 ([L127](../findings/second-order.md)) | the spectrum, as "$\tfrac12$-eigenvalue $\iff\Sigma=\theta^2$" | correct: $\tfrac12\sqrt\Sigma/\theta=\tfrac12\iff\Sigma=\theta^2$ |
| 720 ([L126](../findings/second-order.md)) | the $S^p\times S^q$ values; $\mu_{2,q}=\tfrac q{2(q-1)}>\tfrac12$ | correct from L26's closed form at $p=2$ |
| 739 | the **normalisation clause** ($L_M$ vs $L_e$ units) | correct, and it is the clause the brief flagged; it is right |
| 769, 787, 1202 | the necessary condition, with maximality correctly required | correct |
| 805, 811 (post F44) | the closed form as an evaluable test | correct |
| 877, 889, 890 | the spectrum and eigenvector at $(2,2)$, $(3,1)$, $(4,0)$ splits | correct, independently re-derived here |
| 629, 1197 | the statement itself; a meta-note on a failed grep | n/a |

**One miscitation, outside the target file.** [plan.md:207](../plan.md) reads *"I21 CLOSED, the compactness half is one line, $\mathcal D_n$ being a linear subspace ([Lemma L121](../findings/second-order.md))"*. $\mathcal D_n$ is [Lemma L120](../findings/second-order.md)'s summand, not L121's; L121 says nothing about $\mathcal D_n$. The conclusion is unaffected, $\mathcal D_n$ is a linear subspace by its definition in [conventions.md](../findings/conventions.md), but the pointer should read L120.

### F10. Contradiction sweep

Swept [findings/](../findings/) for every restatement of $\Sigma$, of the radicand, and of the $\Sigma$-vs-$\theta$ ordering. Everything found is consistent:

- $\Sigma\le\theta^2$ (2 sites), $\Sigma_{ijkl}=\theta^2$, $\Sigma\ne\theta^2$, $\Sigma>\theta^2$ at non-maximising critical points, $\sqrt\Sigma\le\theta(1+c^2)$ and $\Sigma\le\theta^2(1+c^2)^2$, **one constant, used consistently**.
- $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$ ([post F50](../findings/second-order.md)) and $\Sigma=\tfrac32(A^2+B^2+C^2)$ when $A+B+C=0$ ([L124](../findings/second-order.md)(i)) are both the same radicand.
- $2b\Sigma\le\theta$ in [stratum-two-negative.md](../findings/stratum-two-negative.md) is a **different $\Sigma$** (a stratum quantity), not this one.
- [L124](../findings/second-order.md)'s withdrawal box, *"$\Sigma$ is frame-dependent and $\theta$ is not"*, is a warning about applying L121 off the eigenframe. It does **not** touch L121 as stated, which fixes a diagonal $M$ and so fixes the frame.


## Verdict

**CONFIRMED.**

Every load-bearing claim of Lemma L121 is right, and two of them are right for reasons stronger than the record claimed.

- **$G$ as printed is symmetric** and is exactly what the structure constants give; the brief's suspicion is unfounded. The signed coordinates are $(a,-b,c)$, forced by first Bianchi.
- **The spectrum is right**, and the unprinted third eigenvalue is $\tfrac12(A+B+C)$ on the direction Bianchi deletes. The two forms of the radical are equal.
- **The constant $\theta^2$ is right and sharp.** L121 is in $L_M$ units, L24 in $L_e$ units, and the conversion is done correctly; equality holds at $S^3\times S^3$, so a factor of $2$ either way would be visible.
- **The hypotheses are correctly split in the printed sentence**: the block is diagonality-only (weaker than the stated "critical"), the inequality says "at every maximiser".
- **The agreement with [Lemma L26](../findings/nondegeneracy.md) is a theorem, not a coincidence.** It reduces to $\theta=(n-1)\lvert\gamma\rvert$, i.e. to $m(s^3-4s^2+5s-2)=m(s-1)^2(s-2)$, proven above at every $(p,q)$. Two closed forms derived by wholly different routes meet exactly.

**Two presentational repairs owed** (F8): the "so" in *"$G\mathbf 1=(A+B+C)\mathbf 1$, so the Bianchi subspace is $\mathbf 1^\perp$"* derives the right conclusion from the wrong premise, and *"the block is traceless"* is true only of the restriction to $\mathbf 1^\perp$. Neither changes a value or a citation.

**One miscitation to fix elsewhere** (F9): [plan.md:207](../plan.md) attributes "$\mathcal D_n$ is a linear subspace" to L121; it belongs to [Lemma L120](../findings/second-order.md).

*Compute used: one screen of constructed objects (an $\mathfrak{so}(6)$ structure-constant build of $Q$ and $\circ$), seconds, reported as a screen. It reproduced four record anchors and matched $\tfrac12G$ at all fifteen four-subsets. Every positive claim above rests on the hand derivation, not on it.*
