# REVIEW r704, [DERIVE-j5.md](DERIVE-j5.md) batch 4: the signed decomposition, the sweep refutation, and the defect-free reduced condition

*Cold brief, adversarial. Analysis only, per [analysis-only.md](../.claude/rules/analysis-only.md); no computation was run and none was needed, every verdict below is by hand from the definitions in the brief. The code that produced batch 4 was not read.*

## Verdicts

| claim | verdict |
| --- | --- |
| **C1** $4\,\mathrm{Ric}(C)=\mathring{\lvert W\rvert}(h)+6\mathcal A$ for every Weyl $W$ | **CONFIRMED**, proved by hand below, criticality-free as claimed. One correction: the symbol $\mathring{\ }$ is used in the opposite index order to [conventions.md](../findings/conventions.md) |
| **C2** the boxed four-term identity for $J_5$, first two terms $\ge0$ | **CONFIRMED as an identity, REFUTED as new**, it is [ATTEMPTS.md](../ATTEMPTS.md) Result 1 term for term, and both positivity claims are already manifest in Result 1's own form. The $h$-eigenframe reading is new and correct |
| **C3** the sweep's "indefinite for every $a$" is false, and the route is open | **SPLIT: the correction CONFIRMED, the conclusion REFUTED as stated**, the sign is convention-dependent and C3 as written negates rather than corrects the sweep's display; the sweep gave a second, untouched ground; and the reopened route yields an identity plus a restated conjecture, as batch 4's own item (3) concedes. **A deeper error than the one C3 names is present in the sweep**, see [the eq. 6 finding](#finding-1) |
| **C4** the reduced condition: sufficient, exact at sphere products, fails at $\mathbb{HP}^2$ and $n=5$ | **CONFIRMED with four corrections**, sufficiency and the sphere-product equality are proved by hand below; the "$\mathcal A=0$" qualifier is unnecessary; the $n=5$ failure is unverifiable by argument; and the proof shape omits $\mathcal S^4(\alpha)$, a second equality family with nonzero defect |

## Conventions fixed for this review

Throughout: $R_{ijkl}=\langle R(e_i\wedge e_j),e_k\wedge e_l\rangle$ with $\{e_i\wedge e_j\}_{i<j}$ orthonormal, $\mathrm{Ric}(R)_{ik}=\sum_jR_{ijkj}$, and $\mathring R(s)_{ik}=\sum_{jl}R_{ijkl}s_{jl}$, the brief's and batch 4's definitions. Two facts used repeatedly, both one line: $\mathring R(\mathrm{id})=\mathrm{Ric}(R)$, and $\mathrm{tr}\,\mathring R(s)=\langle\mathrm{Ric}(R),s\rangle$.

---

## Finding 1, the sweep's transcription of BW08 eq. 6 carries the wrong sign, and this is the real fault under C3<a id="finding-1"></a>

[The sweep](2026-09-03b-LIT-step8-sweep.md) batch 2 quotes eq. 6 as $\mathrm{Ric}(R^2+R^\#)_{ij}=\sum_{kl}\mathrm{Ric}_{kl}R_{kijl}$, and builds its whole rewrite on the polarisation of that. **The index pattern is the negative of the one the record's own $D(R)$ identity uses.** [ATTEMPTS.md](../ATTEMPTS.md) Result 2 writes the contraction as $\sum_{kl}\mathrm{Ric}(R)_{kl}T_R(k,i,l,j)$ with $T_R(k,i,l,j)=R_{kilj}=-R_{kijl}$.

**The $R=\mathrm{Id}$ test the brief asked for settles which is right, and it takes four lines.** For $R=\mathrm{Id}$ on $\Lambda^2$, $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ and $\mathrm{Ric}(R)=(n-1)\mathrm{id}$. Since $\mathrm{Id}^2=\mathrm{Id}$ and $I\#I=(n-2)I$ ([BW08 Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md)), the left side is $\mathrm{Ric}((n-1)\mathrm{Id})=(n-1)^2\mathrm{id}$. Then

- the record's pattern gives $(n-1)\sum_kR_{kikj}=(n-1)(n\delta_{ij}-\delta_{ij})=+(n-1)^2\delta_{ij}$, **correct**;
- the sweep's pattern gives $(n-1)\sum_kR_{kijk}=(n-1)(\delta_{ij}-n\delta_{ij})=-(n-1)^2\delta_{ij}$, **wrong by a sign**.

$\mathrm{Id}$ is Bianchi, so the $\mathrm{Alt}$ correction is zero and the test is clean. The same test identifies the record's contraction with $\mathring{\ }$ in the brief's order: $R_{kilj}=R_{ikjl}$ after two antisymmetry flips, so $\sum_{kl}h_{kl}T_R(k,i,l,j)=\mathring R(h)_{ij}$ exactly, and $\mathring{\mathrm{Id}}(\mathrm{id})=(n-1)\mathrm{id}$ as the brief demands.

**Consequences.** The [BW08 notes](../references/boehm-wilking-2008-space-forms/notes.md) transcribe eq. 6 verbatim as $\sum_k\mathrm{Ric}_{kk}R_{kijk}$ with no convention warning; that is BW's own sign convention for the 4-tensor and it does not survive transplanting into the record's. **The notes file needs the warning**, and [the sweep](2026-09-03b-LIT-step8-sweep.md) needs a correction saying its chain was built on the flipped form. This is the substantive fault under C3 and batch 4 does not name it.

---

## C1, CONFIRMED, and the proof is five lines

**Proof.** Only these inputs are used, none of them criticality:

- $\lvert W\rvert=W+2W_-$ and bilinearity of $\#$ give $\lvert W\rvert^\#=W^\#+4W_+\#W_-=W^\#+4C$ (the $W_-^\#$ terms cancel), so $4\mathrm{Ric}(C)=\mathrm{Ric}(\lvert W\rvert^\#)-\mathrm{Ric}(W^\#)$;
- $W$ is Weyl, so $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$; the $D(R)$ identity at $R=W$ therefore reads $\mathrm{Ric}(W^2+W^\#)=0$, i.e. $\mathrm{Ric}(W^\#)=-\mathrm{Ric}(W^2)$;
- $W_+W_-=0$ gives $\lvert W\rvert^2=W_+^2+W_-^2=W^2$;
- the $D(R)$ identity at $R=\lvert W\rvert$ reads $\mathrm{Ric}(W^2)+\mathrm{Ric}(\lvert W\rvert^\#)=\mathring{\lvert W\rvert}(h)+\tfrac32\,\mathcal A(\lvert W\rvert)$;
- $\mathrm{Alt}$ is linear and $\mathrm{Alt}(W)=0$, so $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$ and $\tfrac32\mathcal A(\lvert W\rvert)=6\mathcal A$.

Subtracting the second bullet from the fourth gives $4\mathrm{Ric}(C)=\mathring{\lvert W\rvert}(h)+6\mathcal A$. $\square$

**$\mathcal A\succeq0$ is genuine.** $\mathrm{Alt}(R)$ is the $\Lambda^4$ component of $R$ and is therefore totally antisymmetric in its four indices, so $\mathcal A_{ij}=\langle v_i,v_j\rangle$ with $v_i=\mathrm{Alt}(W_-)_{i\,\cdot\,\cdot\,\cdot}\in\mathbb R^{n^3}$ is a Gram matrix in the strict sense (symmetric and PSD) and the choice of which slot carries the free index is immaterial. The contraction really does make one.

**The coefficient $\tfrac32$ and the index pattern check out against the record's own trace statement.** Taking traces in the $D(R)$ identity and using $\mathrm{tr}\,\mathring R(s)=\langle\mathrm{Ric}(R),s\rangle$ gives $\mathrm{tr}\,D(R)=\tfrac32\sum_{iklm}\mathrm{Alt}(R)_{iklm}^2=6\lVert\mathrm{Alt}(R)\rVert^2$ once $\lVert\cdot\rVert$ is read in the bivector-basis (operator) norm, $\lVert A\rVert^2=\sum_{i<j,k<l}A_{ijkl}^2$. That is exactly [ATTEMPTS.md](../ATTEMPTS.md) Result 2's $\mathrm{tr}\,D=6\lVert\mathrm{Alt}\,R\rVert^2$, with the factor $4$ between the two norms accounting for the apparent gap. **The batch reads the identity correctly.**

### Correction owed on C1, the symbol $\mathring{\ }$ collides with the record

[conventions.md:77](../findings/conventions.md) defines $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$ (Li's $iklj$ order) and [conventions.md:69](../findings/conventions.md) says in terms that the other order "negates $\mathring W$". Batch 4's $\mathring R(s)_{ik}=\sum_{jl}R_{ijkl}s_{jl}$ is the other order. So

$$\mathring{\ }^{\text{(batch 4)}}=-\,\mathring{\ }^{\text{(conventions.md)}},$$

and C1 recorded as written contradicts the record's own convention file by a sign: in the record's order the identity is $4\mathrm{Ric}(C)=-\mathring{\lvert W\rvert}(h)+6\mathcal A$. The check is immediate, in Li's order the round sphere has $\mathring R=+\mathrm{Id}$ on $S^2_0$ and $\mathring R(\mathrm{id})=-\mathrm{Ric}$, against batch 4's $\mathring R(\mathrm{id})=+\mathrm{Ric}$.

**Fix, and it is not cosmetic.** Either amend [conventions.md](../findings/conventions.md) and every file written in Li's order, or (cheaper and safer), record batch 4's operator under a fresh name, or in the two forms that are convention-free: $\langle\mathring{\lvert W\rvert}(h),h\rangle=\langle\lvert W\rvert,h\owedge h\rangle=\sum_{a\ne b}\eta_a\eta_bw_{ab}$. Leaving one symbol with two opposite meanings inside [findings/](../findings/) is how the next reader loses a sign.

---

## C2, the identity is right, the decomposition is not new, and the two positivity claims were already on the record

### The arithmetic is correct

$J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),h\rangle$ with Theorem A's $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2$; $\mathrm{Ric}(W_-)=h/2$ turns $-2\theta\mathrm{Ric}(W_-)$ into $-\theta h$; C1 handles $4\mathrm{Ric}(C)$. The boxed identity follows. **CONFIRMED.**

### The eigenframe reading is correct, and the frame question has a clean answer

In a frame diagonalising $h$, $\langle\mathring{\lvert W\rvert}(h),h\rangle=\sum_{ijkl}\lvert W\rvert_{ikjl}h_{kl}h_{ij}$ collapses to $\sum_{a,b}\eta_a\eta_b\lvert W\rvert_{abab}=\sum_{a\ne b}\eta_a\eta_bw_{ab}$, since only $k=l$ and $i=j$ survive and $w_{aa}=0$. **CONFIRMED.**

The brief's question (does $\eta=\mathbf w\mathbf 1$ need the eigenframe), separates into two halves:

- **$h_{aa}=\sum_bw_{ab}$ holds in every orthonormal frame.** It is the definition of $\mathrm{Ric}$ read on the diagonal, nothing more.
- **The eigenframe is needed twice over**: for $\eta_a=h_{aa}$ to be $h$'s spectrum, and for the quadratic form to collapse to the diagonal sum. Off the eigenframe, $\langle\mathring{\lvert W\rvert}(h),h\rangle$ picks up terms in $\lvert W\rvert_{ikjl}$ with all four indices free, and the reduction fails.

**Two harmless degeneracies checked.** When $h$ has repeated eigenvalues the frame is not unique and $\mathbf w$ genuinely depends on the choice, but the two scalars that carry the claim do not: $\mathbf 1^{\mathsf T}\mathbf w^2\mathbf 1=\lVert h\rVert^2$ and $\mathbf 1^{\mathsf T}\mathbf w^3\mathbf 1=\langle\mathring{\lvert W\rvert}(h),h\rangle$ are frame-free by construction. And $\mathbf w$ is symmetric, because negating a bivector twice is the identity.

### Both "$\ge0$" braces were already on the record, in a form where the sign is more obvious

**This is the substantive objection to C2 as a deliverable.** [ATTEMPTS.md](../ATTEMPTS.md) Result 1 states, at every critical point,

$$\theta r^2=\sqrt2\,r^2\sqrt{1-\mathrm{tr}S^4}\sqrt{1-e^2}-2\langle\mathrm{Ric}(W_-^2),h\rangle+J_4-J_5,\qquad r=\lVert h\rVert,\ S=h/r.$$

Rearranged, that is $J_5=\sqrt2r^2\sqrt{1-\mathrm{tr}S^4}\sqrt{1-e^2}+J_4-\theta\lVert h\rVert^2-2\langle\mathrm{Ric}(W_-^2),h\rangle$. **The two identifications that make this C2 verbatim are both provable by hand:**

1. **$J_4=6\langle\mathcal A,h\rangle$.** $J_4=\langle D(\lvert W\rvert),h\rangle$ and $D(\lvert W\rvert)=\tfrac32\mathcal A(\lvert W\rvert)=\tfrac32\cdot4\,\mathcal A=6\mathcal A$.
2. **$\langle\mathring{\lvert W\rvert}(h),h\rangle=\sqrt2\,r^2\sqrt{1-\mathrm{tr}S^4}\sqrt{1-e^2}$.** With $(A\owedge B)_{ijkl}=A_{ik}B_{jl}+A_{jl}B_{ik}-A_{il}B_{jk}-A_{jk}B_{il}$ one gets $\langle R,h\owedge h\rangle=\sum_{ijkl}R_{ijkl}h_{ik}h_{jl}=\langle\mathring R(h),h\rangle$; and $\lVert S\owedge S\rVert^2=\sum_{ijkl}(S_{ik}S_{jl}-S_{il}S_{jk})^2=2\big((\mathrm{tr}S^2)^2-\mathrm{tr}S^4\big)=2(1-\mathrm{tr}S^4)$. Jäger's $e$-decomposition $\lvert W\rvert=\sqrt{1-e^2}\,\tfrac{h\owedge h}{\lVert h\owedge h\rVert}+E$ with $E\perp h\owedge h$ then gives $\langle\lvert W\rvert,h\owedge h\rangle=\sqrt{1-e^2}\,\lVert h\owedge h\rVert=\sqrt{1-e^2}\cdot\sqrt2\,r^2\sqrt{1-\mathrm{tr}S^4}$.

So C2's leading term is Jäger's leading term, **and in Result 1's parametrisation its nonnegativity is a product of two square roots, visible without any argument at all.** $J_4\ge0$ likewise follows from $D\succeq0$, which [ATTEMPTS.md](../ATTEMPTS.md) Result 3 already states and uses. Batch 4's headline ("one signed decomposition"), therefore claims as new a pair of signs the record has carried since Result 1.

**What is genuinely new, and it is worth keeping:** the reduction of the leading term to $\mathbf 1^{\mathsf T}\mathbf w^3\mathbf 1$ on the sectional matrix of $\lvert W\rvert$, which replaces $\sqrt{1-\mathrm{tr}S^4}\sqrt{1-e^2}$ by an entrywise-nonnegative bilinear form; and the reading of $J_4$ as $6\langle\mathcal A(W_-),h\rangle$ at $W_-$ rather than at $\lvert W\rvert$. The batch should be recorded as a **reparametrisation of Result 1**, with the sign claims attributed there.

### And the decomposition is subject to the file's own standing fence

[DERIVE-j5.md](DERIVE-j5.md) records: *"Splitting $J_5$ into two nonnegative pieces is inert, an unsigned difference of two nonnegative numbers is strictly weaker than the signed block bound."* C2 is a difference of two nonnegative terms and two nonpositive ones (nonpositive whenever $\theta\ge0$, since $W_-^2\succeq0$ forces $\mathrm{Ric}(W_-^2)\succeq0$ and $h\succeq0$). **It signs nothing.** Batch 4's item (3) concedes exactly this; the boxed display should carry the concession rather than the fence being left to the reader.

### One overstatement in batch 4 item (1)

> "the sectional part of the grant is a statement about one nonnegative $n\times n$ matrix and the scalar $\theta$."

**False as written.** $\mathbf 1^{\mathsf T}\mathbf w^3\mathbf 1$ and $\lVert h\rVert^2=\mathbf 1^{\mathsf T}\mathbf w^2\mathbf 1$ are functions of $\mathbf w$; the third term of the exact sectional part, $2\langle\mathrm{Ric}(W_-^2),h\rangle$, is **not**, it reads $(W_-^2)_{abab}=\sum_{c<d}(W_-)_{abcd}^2$, i.e. the full off-diagonal content of $W_-$, which $\mathbf w$ discards. The relaxed condition of item (3) needs $\lambda_{\max}(W_-)$ in addition, also not a function of $\mathbf w$. The accurate sentence is: *the first term and $\lVert h\rVert^2$ are functions of the sectional matrix alone.*

---

## C3, the correction stands, the conclusion does not

### The sweep's "indefinite for every $a$" is wrong, and for the reason C3 gives

For skew $\omega$ and $g\succeq0$, $\mathrm{tr}\big((\omega g)^2\big)=-\mathrm{tr}(\omega g\,\omega^{\mathsf T}g)=-\lVert g^{1/2}\omega g^{1/2}\rVert_F^2\le0$. Screened by hand at $n=2$ with $\omega=\left(\begin{smallmatrix}0&1\\-1&0\end{smallmatrix}\right)$, $g=\mathrm{diag}(1,2)$: $\mathrm{tr}((\omega g)^2)=-4$ and $\lVert g^{1/2}\omega g^{1/2}\rVert_F^2=4$. **So $\sum_a\lambda_a\mathrm{tr}((\omega_ag)^2)$ is definite, not indefinite, whenever $g\succeq0$ and $\lambda_a\ge0$**, and in [the sweep](2026-09-03b-LIT-step8-sweep.md)'s own display $g=\mathrm{Ric}(W_-)\succeq0$ and $\lambda_a$ are eigenvalues of $W_+\succeq0$. The sweep's error is the omission of the hypothesis $g\succeq0$: $\mathrm{tr}(N^2)=\lVert N_{\mathrm{sym}}\rVert^2-\lVert N_{\mathrm{skew}}\rVert^2$ is indeed indefinite over all symmetric $g$, and the sweep quantified over the wrong set. Its own check at $g=E_{11}$ returns $0$, which is the boundary of $\le0$ and never a positive value. **CONFIRMED.**

### But C3 negates the sweep's display rather than correcting it, and the sign is convention-dependent

C3 asserts "$\langle\mathring{(\omega\otimes\omega)}g,g\rangle=\mathrm{tr}(\omega g\omega^{\mathsf T}g)$", i.e. $-\mathrm{tr}((\omega g)^2)$, while presenting it as the same object as the sweep's $\langle\mathring W_+g,g\rangle=\sum_a\lambda_a\mathrm{tr}((\omega_ag)^2)$. **The two displays differ by exactly the $\mathring{\ }$ convention gap of Finding 1 above, and each is correct in its own order**, the sweep's is right in [conventions.md](../findings/conventions.md)'s Li order, C3's in the brief's. So the sweep's formula is not sign-wrong; only its word "indefinite" is, and indefiniteness is invariant under negation, which is why the correction survives the convention question intact.

The corollary "$\langle\mathring Rg,g\rangle\ge0$ for all $R,g\succeq0$" is **true in batch 4's order and false in the record's**, where the same quantity is $\le0$. Record it as $\sum_{a,b}\gamma_a\gamma_bR_{abab}\ge0$ in $g$'s eigenframe, which is convention-free and, incidentally, a shorter proof than the $g^{1/2}\omega g^{1/2}$ route.

### "The route the sweep closed on that ground is open", REFUTED as stated

Three objections, any one of which is enough:

- **The sweep closed the route on two grounds, and C3 answers one.** Its final sentence is *"The rewrite is one more rearrangement of the grant through $W$'s spectral parts, which is the class [post F56](../findings/second-order.md) closes; it is dropped."* Batch 4's identity is read at $R=\lvert W\rvert$ and $R=W$, both inside $\mathrm{span}\{W_+,W_-\}$, squarely the class F56 names. It may well escape F56 in substance, since F56 is about the polarised scalar-curvature identity and batch 4 uses the $D(R)$ identity, and since it extracts the $\mathcal A$ Gram term that F56's rank-one argument cannot see. **But batch 4 does not make that argument, and it owes it.**
- **Signing the leading term does not sign $J_5$.** By batch 4's own item (3) the leading term loses to the negative terms at every defect point it screened. A route that returns an identity plus an inequality of the same difficulty as the original is reopened as a reformulation, not as a proof.
- **The sweep's leading term is at $W_+$, batch 4's is at $\lvert W\rvert$.** They are different objects in different decompositions; the sweep's chain additionally rests on the flipped eq. 6 (Finding 1), so it needs re-deriving before anything is claimed about what it does or does not deliver.

**The honest sentence:** *the sweep's stated reason for dropping the route is wrong, and the route deserves reopening; what this batch has extracted from it is an identity, not a sign.*

---

## C4, sufficient and exact at sphere products, both proved by hand; four corrections

### Sufficiency, CONFIRMED

$W_-\succeq0$ gives $W_-^2\preceq\lambda_{\max}(W_-)W_-$; $\mathrm{Ric}$ is a positive map ($\langle\mathrm{Ric}(A)x,x\rangle=\sum_j\langle A(x\wedge e_j),x\wedge e_j\rangle$, the record's own lemma), so $\mathrm{Ric}(W_-^2)\preceq\lambda_{\max}(W_-)\,h/2$, and pairing against $h\succeq0$ gives $2\langle\mathrm{Ric}(W_-^2),h\rangle\le\lambda_{\max}(W_-)\lVert\eta\rVert^2$. With $6\langle\mathcal A,h\rangle\ge0$ discarded, $J_5\ge\eta^{\mathsf T}\mathbf w\eta-(\theta+\lambda_{\max}(W_-))\lVert\eta\rVert^2$. $\square$

**Correction 1: the "when $\mathcal A=0$" qualifier is unnecessary.** The $\mathcal A$ term is discarded downwards, so the condition is sufficient for $J_5\ge0$ at every critical point, defect or none. $\mathcal A=0$ is needed only for the *converse* discussion, for the condition to be nearly necessary.

### Exactness at every sphere product, CONFIRMED, by hand, for all $p,q\ge2$

The brief asks whether this is provable from [r697](REVIEW_r697.md)'s closed forms. It is, in one page, and the arithmetic is exact.

Take $S^p\times S^q$, $n=p+q$, $p,q\ge2$ (at $p=1$ the block $\Lambda^2\mathbb R^p$ is empty and $\mathrm{Ric}(W)=0$ forces $c=0$). $W$ is diagonal with eigenvalue $a$ on $\Lambda^2\mathbb R^p$, $b$ on $\Lambda^2\mathbb R^q$, $c$ on the mixed planes. $\mathrm{Ric}(W)=0$ row by row gives $(p-1)a=-qc$ and $(q-1)b=-pc$, whose sum is r697's $a(p-1)+b(q-1)=-cn$. Normalise $c=-1$, so $a=q/(p-1)>0$, $b=p/(q-1)>0$, and $\theta=\lvert c\rvert(n-1)=n-1$.

**$W_-$ is one eigenvalue times a projection.** $W_-$ is $1$ on the mixed block and $0$ elsewhere, so $\lambda_{\max}(W_-)=1$ and $W_-^2=W_-$ **exactly**, the $\lambda_{\max}$ relaxation above is an equality here, which is the first half of the sharpness.

**The defect vanishes.** $W_-$ is a multiple of the projection onto $\mathbb R^p\wedge\mathbb R^q$, whose 4-tensor is supported on $\{i,j\}=\{k,l\}$; $\mathrm{Alt}$ is the $\Lambda^4$ component and is determined by four distinct indices, where every entry is zero. So $\mathcal A=0$ and the defect-free condition is the right one to test.

**The sectional matrix and its row sums.** $w_{ab}=q/(p-1)$ for $a\ne b\le p$, $w_{ab}=1$ mixed, $w_{ab}=p/(q-1)$ for $a\ne b>p$. Row sums: $(p-1)\tfrac q{p-1}+q=2q$ for $a\le p$, and $2p$ for $a>p$, which is $\eta$, confirming $\eta=\mathbf w\mathbf 1$ independently.

**The two sides.** With $u=2q$, $v=2p$,

$$\eta^{\mathsf T}\mathbf w\eta=p(p-1)\tfrac q{p-1}u^2+2pq\,uv+q(q-1)\tfrac p{q-1}v^2=pq(u+v)^2=4pq\,n^2,$$
$$\lVert\eta\rVert^2=pu^2+qv^2=4pq(p+q)=4pq\,n,\qquad(\theta+\lambda_{\max}(W_-))\lVert\eta\rVert^2=n\cdot4pq\,n=4pq\,n^2 .$$

**Equal. $\square$** The same numbers give $J_5=4pqn^2-(n-1)4pqn-4pqn=0$ directly, reproducing [r697](REVIEW_r697.md)'s $X_{\mathrm{inv}}=0$ at the level of the grant. Batch 4's hand check "$1.8=1.8$ at $S^2\times S^4$" is this identity at $p=2,q=4$.

**A structural remark this proof hands over, worth recording.** $\mathbf w\eta=n\eta$ at every sphere product: the condition is not merely satisfied, $\eta$ is an eigenvector of $\mathbf w$ at eigenvalue exactly $\theta+\lambda_{\max}(W_-)$. Since $\mathbf w\ge0$ entrywise and $\eta>0$, that eigenvalue is $\mathbf w$'s Perron root. **So the condition reads "the Rayleigh quotient of $\mathbf w$ at its own row-sum vector is at least $\theta+\lambda_{\max}(W_-)$", and $\lambda_{\mathrm{Perron}}(\mathbf w)\ge\theta+\lambda_{\max}(W_-)$ is a necessary condition for it**, a cheap, frame-free screen on any candidate critical point.

### Failure at $\mathbb{HP}^2$, CONFIRMED, and it is an argument, not a screen

At $\mathbb{HP}^2$ the record has $J_5=0$ ([L154](../findings/bounds.md), and [ATTEMPTS.md](../ATTEMPTS.md) Result 4) and $J_4\ne0$ ([ATTEMPTS.md](../ATTEMPTS.md) Result 3, ratio $3$ against $\delta^2\mathrm{scal}$). Then

$$\eta^{\mathsf T}\mathbf w\eta-\theta\lVert\eta\rVert^2-2\langle\mathrm{Ric}(W_-^2),h\rangle=J_5-6\langle\mathcal A,h\rangle=-J_4<0,$$

and since $\lambda_{\max}(W_-)\lVert\eta\rVert^2\ge2\langle\mathrm{Ric}(W_-^2),h\rangle$ the reduced condition fails a fortiori. **Note what this proves and the batch does not say:** the deficit appears *before* the $\lambda_{\max}$ relaxation, so the failure is attributable to discarding $\mathcal A$ and not to the relaxation. That is what licenses "$\mathrm{Alt}(W_-)$ must be used quantitatively", and the batch leaves the licensing step out.

### Failure at the $n=5$ critical point, UNVERIFIED

This is a claim about one numerically located point, carried in [j5cross_n5_newcrit_th0.882.npy](../agent_logs/j5cross_n5_newcrit_th0.882.npy). No argument reaches it: the point has no closed form, so its $\mathbf w$, $\theta$, $\lambda_{\max}(W_-)$ and $\mathcal A$ are not derivable. It could be settled only by reading that witness, which is a reserved computation on an object I did not construct, and it is a screen either way, not evidence. **The batch's $-0.72$ and $-0.33$ there are internally consistent**, the gap $0.39$ between margin and $J_5^{\mathrm{sec}}$ is the $\lambda_{\max}$ slack, which is nonzero exactly when $W_-$ has more than one eigenvalue, and zero at $\mathbb{HP}^2$ where the batch reports the two numbers equal. That consistency is a point in the numbers' favour and nothing more.

**Correction 2: "It fails at every point with nonzero defect" is unsupported.** Item (3) states this generally from two points. What follows from C2 is only the tautology *it fails wherever $J_5<6\langle\mathcal A,h\rangle$, plus slack*. A point with small $\mathcal A\ne0$ and $J_5$ bounded away from zero would satisfy the condition and carry a defect; nothing in the record rules one out, and $SU(3)$, where the batch reports margin $+2.73$, numerically equal to $J_5$, is consistent with being such a point up to $\mathcal A=0$ there. **Restrict the claim to the points screened.**

### "Any proof must use $\mathrm{Alt}(W_-)$ quantitatively and be exact at $\mathbb{HP}^2$"

**Correction 3: "any proof" overreaches; "any proof routed through this decomposition" is what is proved.** The $\mathbb{HP}^2$ computation above shows that *within* C2's split, the $\mathcal A$ term cannot be bounded below by zero. It says nothing about a proof that never forms the split, for instance one through [L155](../findings/bounds.md)'s graded-subalgebra characterisation of $X_{\mathrm{inv}}=0$, or through the PSD-pairing form (2), neither of which mentions $\mathrm{Alt}$.

**Correction 4, the substantive one: $\mathcal S^4(\alpha)$ is a second equality family with nonzero defect, and the proposed proof shape drops it.** Batch 4 names "the sphere products and $\mathbb{HP}^2$ as the two equality families". But $\mathcal S^4(\alpha)$ has $X_{\mathrm{inv}}=0$ identically, hence $J_5=0$, **and** it has $\delta\ne0$, [ATTEMPTS.md](../ATTEMPTS.md) Result 3 quotes its ratio $(J_4-J_5)/(\delta^2\mathrm{scal})=6$ exactly, which presupposes $\delta\ne0$, and states $J_4=\tfrac{24}9\cdot\tfrac{\mathrm{scal}}4$ there. So $\mathcal S^4(\alpha)$ satisfies $J_5^{\mathrm{sec}}=-6\langle\mathcal A,h\rangle$ exactly as $\mathbb{HP}^2$ does, and is a **third** family any candidate bound must be tight on. Since the batch's own header lists $\mathcal S^4(\alpha)$ among the sharp points, this is an omission in the proof shape rather than a disagreement about the facts, and it matters, because $\mathcal S^4(\alpha)$ is the one sharp family that is not coordinate-diagonalisable and so is the one most likely to break a candidate bound. **"Must be exact at $\mathbb{HP}^2$" should read "must be exact at $\mathbb{HP}^2$ and at $\mathcal S^4(\alpha)$."**

---

## Summary of corrections owed before this batch is recorded

1. **Convention.** Rename batch 4's $\mathring{\ }$ or state at every use that it is the negative of [conventions.md:77](../findings/conventions.md)'s. Prefer the convention-free forms $\langle\lvert W\rvert,h\owedge h\rangle$ or $\sum_{a\ne b}\eta_a\eta_bw_{ab}$.
2. **Attribution.** The boxed identity is [ATTEMPTS.md](../ATTEMPTS.md) Result 1 reparametrised; $J_4=6\langle\mathcal A,h\rangle$ and $\langle\mathring{\lvert W\rvert}(h),h\rangle=\sqrt2r^2\sqrt{1-\mathrm{tr}S^4}\sqrt{1-e^2}$ are the two identifications, both proved above. The two "$\ge0$" braces are not new.
3. **The sweep's real error.** Its eq. 6 has the index pattern $R_{kijl}$, the negative of the record's $T_R$; the $R=\mathrm{Id}$ test settles it. Correct [the sweep](2026-09-03b-LIT-step8-sweep.md) and add a convention warning to the [BW08 notes](../references/boehm-wilking-2008-space-forms/notes.md), whose eq. 6 is transcribed in BW's own sign convention.
4. **"The route is open."** Weaken to "the sweep's stated reason for dropping it is wrong"; the F56 ground is untouched and batch 4 owes the argument that the $D(R)$ route escapes it.
5. **Item (1)'s headline.** The exact sectional part is not a function of $(\mathbf w,\theta)$, $2\langle\mathrm{Ric}(W_-^2),h\rangle$ needs $W_-$'s off-diagonal entries and the relaxation needs $\lambda_{\max}(W_-)$.
6. **Item (3)'s generalisation.** "Fails at every point with nonzero defect" is asserted from two points; restrict it.
7. **Item (4)'s equality families.** Add $\mathcal S^4(\alpha)$, and restrict "any proof" to "any proof routed through this decomposition".

## What survives, and it is worth keeping

- **C1 is a theorem**, criticality-free, with the five-line proof above and $\mathcal A\succeq0$ a genuine Gram matrix.
- **The sectional reading** $\langle\mathring{\lvert W\rvert}(h),h\rangle=\mathbf 1^{\mathsf T}\mathbf w^3\mathbf 1$, $\lVert h\rVert^2=\mathbf 1^{\mathsf T}\mathbf w^2\mathbf 1$, $\eta=\mathbf w\mathbf 1$, both scalars frame-free.
- **The sphere-product equality is a proved identity**, for all $p,q\ge2$, with the sharper statement that $\eta$ is $\mathbf w$'s Perron vector at eigenvalue exactly $\theta+\lambda_{\max}(W_-)$, which yields the free necessary screen $\lambda_{\mathrm{Perron}}(\mathbf w)\ge\theta+\lambda_{\max}(W_-)$.
- **The sweep's "indefinite" is refuted**, and the refutation is convention-independent.
