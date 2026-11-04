# Gate 2, r837 on the Lefschetz route to the surviving rank-three question: every step is sound, and the last paragraph's $R=0$ hypothesis is inert, which closes the branch at every $m\ge3$

*The brief was cold: the block was read from disk in [findings/diagonal-half.md](../findings/diagonal-half.md) at lines 993 to 1007 and every derivation below was re-run from the givens rather than checked against the block's wording. **Three screens were run**, each seconds of compute on objects built for the purpose, each confirming a claim already established in closed form by hand, and none of them is the evidence for anything positive here: the $\mathbb R^4$ and $\mathbb R^8$ exhibits below are integer matrices whose wedges are done by hand in the text. No search, sweep or census was run. Log: [agent_logs/g2-lefschetz-r837.log](../agent_logs/g2-lefschetz-r837.log).*

## Claim table

| # | Claim under attack | Verdict |
|---|---|---|
| 1 | Hard Lefschetz on a symplectic vector space is linear algebra needing only nondegeneracy; $L$, its adjoint and their commutator are an $\mathfrak{sl}_2$; $L^{m-k}:\Lambda^k\to\Lambda^{2m-k}$ is an isomorphism | **CONFIRMED in substance**, two precision defects: the partner of $L$ is contraction with the INVERSE bivector and not the metric adjoint, and the range is $0\le k\le m$, unstated |
| 2 | $L:\Lambda^2\to\Lambda^4$ injective at every $m\ge3$, because $L^{m-2}$ factors through it | **CONFIRMED**, including $m=3$ where $L^{m-3}=L^0=\mathrm{id}$, and proved below from Darboux without any $\mathfrak{sl}_2$ |
| 3 | At $m=2$, $L:\Lambda^2\to\Lambda^4$ is $6\to1$ and never injective, which is where the witness lives | **CONFIRMED, AND UNDERSTATED**: $\ker L_\gamma$ is the $5$-dimensional wedge-orthocomplement of $\gamma$, the witness's $\alpha$ lies in it, and $\alpha$ is itself NONDEGENERATE, which is what $m\ge3$ forbids |
| 4 | $\alpha\wedge\beta=0$ with a nondegenerate factor gives $\omega_2=\pm\omega_1$, against trace-orthogonality | **CONFIRMED**, $\mathop{\mathrm{tr}}(J_1J_2)=\mp2m$ with the block's own sign pairing |
| 5 | $T=-J_1J_2$ orthogonal, $J_1\pm J_2=J_1(I\pm T)$, $\mathop{\mathrm{tr}}T=2\langle\omega_1,\omega_2\rangle$ | **CONFIRMED**, every sign correct, and $J_1+J_2$ pairs with $-1$ and $J_1-J_2$ with $+1$ as written |
| 6 | $J_1TJ_1^{-1}=T^{-1}$, and $E_\pm$ are $J_1$-invariant and hence even-dimensional | **CONFIRMED**. Evenness needs $J_1$-invariance alone and not $T$ orthogonal, and the same argument gives EVERY eigenvalue of $T$ even multiplicity |
| 7 | On $E_+$, $J_2=J_1$; on $E_-$, $J_2=-J_1$ | **CONFIRMED**. $E_\pm$ are $J_2$-invariant too, and that is not needed |
| 8 | $\alpha=2\omega_1$ on $E_-$ and $0$ on $E_+$, cross terms vanishing by $J_i$-invariance and orthogonality | **CONFIRMED**, with a stronger reason available: $\alpha$ ANNIHILATES $E_+$ outright, so no cross term against $E_+$ exists to cancel |
| 9 | If $R=0$ then the $\Lambda^2E_-\otimes\Lambda^2E_+$ component of $\alpha\wedge\beta$ is nonzero, so $R\ne0$ | **TRUE AS WRITTEN, AND THE HYPOTHESIS $R=0$ IS INERT**: the same component argument runs verbatim with $R\ne0$ |
| 10 | What survives is both $\pm1$ present with even multiplicity and a nontrivial rotation part, at all three pairs | **REFUTED**: that locus is EMPTY, by item 9 run in full. Separately, the sentence is false at $m=2$, where the actual witness has neither $\pm1$ |
| 11 | Falsifiers | a triple at $m=4$ **cannot exist**, and the gap-closing argument **is on this page** |
| **A** | **The block's headline: a gap remains, namely both $J_1+J_2$ and $J_1-J_2$ singular at once** | **REFUTED**, that configuration is inconsistent with $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$ in every dimension |
| **B** | **The record's "OPEN at $m\ge4$"** ([findings/diagonal-half.md](../findings/diagonal-half.md) line 989) | **FALSE on the derivation of section 9**: the surviving question is EMPTY at every $m\ge3$ |

**Act on this:** delete the hypothesis $R=0$ from the block's last paragraph and the paragraph becomes a proof that $E_+$ and $E_-$ are never both nonzero, which is exactly the gap the block names two paragraphs earlier, so the rank-three question is empty at every $m\ge3$ and "OPEN at $m\ge4$" must go from line 989. This is the same failure mode the round's own instruction warns about, a constraint derived and then used in a strict weakening.

## 0. Conventions, fixed once

- A $2$-form on $\mathbb R^{2m}$ is identified with a real skew endomorphism by $\omega(x,y)=\langle\omega x,y\rangle$, and $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$ on skew matrices.
- $J$ is an orthogonal complex structure: $J^{\mathsf T}=-J=J^{-1}$ and $J^2=-I$. Then $\lVert\omega_J\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(J^2)=m$, as the brief gives.
- $\omega_1,\omega_2$ are $\sqrt c\,J_1,\sqrt c\,J_2$ for a common $c>0$, by the reduction in [L195](../findings/diagonal-half.md). Every statement below is scale-free in $c$, so $c=1$ is taken throughout and $\omega_i$ and $J_i$ are the same matrix.
- $\alpha=\omega_1-\omega_2$, $\beta=\omega_1+\omega_2$, $T=-J_1J_2$, $E_\pm=\ker(T\mp I)$, and $R$ is the sum of the $T$-eigenspaces at $\lambda\ne\pm1$.
- On $\Lambda^4$ the basis forms $e^i\wedge e^j\wedge e^k\wedge e^l$ with $i<j<k<l$ are used only for their LINEAR INDEPENDENCE. No result here depends on which of the record's two $\Lambda^4$ norms is in force, the two differing by the factor $6$ recorded in [findings/conventions.md](../findings/conventions.md).
- The wedge of two $2$-forms is $(a\wedge b)_{ijkl}=a_{ij}b_{kl}-a_{ik}b_{jl}+a_{il}b_{jk}+b_{ij}a_{kl}-b_{ik}a_{jl}+b_{il}a_{jk}$ for $i<j<k<l$, which is symmetric in $a,b$ as the brief's given states and gives $\omega\wedge\omega=2\,e^{1234}$ at $\omega=e^{12}+e^{34}$ on $\mathbb R^4$.

## Hypothesis inventory

| Hypothesis | Where the block uses it | Where it is really needed |
|---|---|---|
| $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$, i.e. $\alpha\wedge\beta=0$ | throughout | throughout, and it alone carries section 9 |
| $J_i$ orthogonal complex structures | $T$ orthogonal, $J_1^2=-I$ in the factorisations | the factorisations, the $J_1$-invariance of $E_\pm$, and the nondegeneracy of $\omega_1$ on a $J_1$-invariant subspace |
| $T$ ORTHOGONAL | the orthogonal splitting $E_+\oplus E_-\oplus R$ and the block-diagonality of $\alpha,\beta$ | NOWHERE in the closure of section 9, which needs only $E_+\cap E_-=0$ and a complement. It is needed for the even-multiplicity strengthening in section 6 |
| trace-orthogonality $\mathop{\mathrm{tr}}(J_1J_2)=0$ | to exclude $J_2=\pm J_1$, and read as $\mathop{\mathrm{tr}}T=0$ | only to convert "$\omega_2=\pm\omega_1$" into a contradiction, and in section 10's spectral count |
| $m\ge3$ | the Lefschetz injectivity | the Lefschetz step ONLY. Section 9's component argument is dimension-free |
| $\lVert\omega_1\rVert=\lVert\omega_2\rVert$ | $\langle\alpha,\beta\rangle=0$ | nowhere below, that identity being used by no later step |
| Ricci-flatness, first Bianchi, membership of $\mathcal W_n$ | nowhere | nowhere, confirming the block's closing remark |

## 1. Hard Lefschetz as stated, and what it actually needs

**The statement is the linear-algebraic one and it is true.** Let $(V,\gamma)$ be a real symplectic vector space, $\dim V=2m$. Let $\pi\in\Lambda^2V$ be the bivector inverse to $\gamma$, let $L=\gamma\wedge\cdot$ and let $\Lambda=\iota_\pi$ be contraction with $\pi$. Then $[L,\Lambda]=H$ acts on $\Lambda^kV^*$ as multiplication by $k-m$, and $[H,L]=2L$, $[H,\Lambda]=-2\Lambda$. So $\Lambda^\bullet V^*$ is a finite-dimensional $\mathfrak{sl}_2$-module, and in any such the raising operator $e^j$ carries the weight $-j$ space isomorphically onto the weight $+j$ space. Taking $j=m-k$ and noting that $\Lambda^k$ is the weight $k-m$ space gives $L^{m-k}:\Lambda^k\to\Lambda^{2m-k}$ an isomorphism. **No metric, no compatible complex structure, no manifold and no compactness enter**, and the Kähler-manifold theorem is this statement applied pointwise plus Hodge theory, which is the direction of dependence the block asserts. This is standard and is set out for a single vector space in Huybrechts, *Complex Geometry: An Introduction*, section 1.2, and in Yan, *Hodge structure on symplectic manifolds*, Adv. Math. 120 (1996), section 2, where the vector-space statement is separated out precisely to make the point that only nondegeneracy is used. **Those two citations are recalled and were not verified against the volumes in this session**, so section 2 below proves the only consequence the block uses from scratch, and nothing here rests on them.

**Which $k$ and $m$: the isomorphism covers $0\le k\le m$, at every $m\ge1$, and the block does not say so.** For $k>m$ the exponent $m-k$ is negative and the displayed map does not exist. The block's own use is at $k=2$, which needs $m\ge2$, so the omission costs it nothing, but the sentence as written is not a statement for $k>m$.

**Precision defect, and it is real: "its adjoint" is the wrong partner.** The $\mathfrak{sl}_2$ partner of $L$ is $\iota_\pi$ with $\pi=\gamma^{-1}$, and the metric adjoint $L^*$ of $L$ with respect to the Euclidean structure on $\Lambda^\bullet$ is contraction with $\gamma$ itself raised by the metric. Those agree only up to normalisation, and the difference is not cosmetic. Take $m=2$ and $\gamma=a\,e^{12}+b\,e^{34}$ with $ab\ne0$, which is nondegenerate for every such $a,b$. On $\Lambda^0$ the metric-adjoint bracket gives $[L,L^*]1=-L^*(\gamma)=-(a^2+b^2)$, while the $\mathfrak{sl}_2$ relation demands $H=k-m=-2$ there. So the metric-adjoint triple satisfies the relations only when $a^2+b^2=2$, whereas $\iota_\pi(\gamma)=a\cdot a^{-1}+b\cdot b^{-1}=2$ for every $a,b$. **The block applies the statement at $\gamma=\alpha$ and $\gamma=\beta$**, which under trace-orthogonality have $\lVert\alpha\rVert^2=\lVert\beta\rVert^2=2m$ but are in general not metric-compatible, since compatibility is $\alpha^2\in\mathbb R_{<0}\cdot I$ and not a norm condition. So the bivector reading is the one that must be meant. The conclusion is unaffected, because the bivector reading needs only nondegeneracy, which is what the block claims.

*Arguing the opposite.* "Its adjoint" is standard shorthand in the Kähler literature for the operator $\Lambda$, which in the compatible case IS the metric adjoint, so a reader who knows the subject reads it correctly. That is the charitable reading and it is available. The defect is one of statement rather than of mathematics, and it is recorded as a precision defect rather than an error.

## 2. The injectivity step, proved without $\mathfrak{sl}_2$

**The factoring is correct.** At $m\ge3$ the exponent $m-2\ge1$, so $L^{m-2}=L^{m-3}\circ L$ as maps $\Lambda^2\to\Lambda^{2m-2}$, and $\ker L\subseteq\ker L^{m-2}=0$. At $m=3$ this reads $L^{m-3}=L^0=\mathrm{id}$ and $L^{m-2}=L$ is itself the isomorphism $\Lambda^2\mathbb R^6\to\Lambda^4\mathbb R^6$, both spaces of dimension $15$, so the step is a tautology there rather than a failure. At $m=2$ the isomorphism is $L^0=\mathrm{id}:\Lambda^2\to\Lambda^2$, which says nothing about $L:\Lambda^2\to\Lambda^4$, exactly as the block reports.

**And here is an elementary proof of the same thing, which also produces the $m=2$ kernel.** By Darboux choose a basis with $\gamma=\sum_{t=1}^m f_t$, $f_t=e^{2t-1}\wedge e^{2t}$, and write $P_t=\{2t-1,2t\}$ for the Darboux planes. Let $\alpha\wedge\gamma=0$.

- *Off-plane coefficients.* Let $\{i,j\}$ be a pair that is not a Darboux plane. Since $\{i,j\}$ meets at most two planes and $m\ge3$, there is a plane $P_t$ disjoint from it. Evaluate $(\alpha\wedge\gamma)$ on $S=\{i,j\}\cup P_t$. Of the three ways of splitting $S$ into two pairs, the two "crossing" ones pair an element of $P_t$ with an element outside it, and $\gamma$ vanishes on every pair that is not a Darboux plane, so those terms die, and $\gamma_{ij}=0$ for the same reason. What is left is $\pm\alpha_{ij}\gamma_{P_t}=\pm\alpha_{ij}$. Hence $\alpha_{ij}=0$.
- *On-plane coefficients.* For $s\ne t$ evaluate on $S=P_s\cup P_t$. The crossing splits again carry a $\gamma$ on a non-plane pair and vanish, leaving $\pm(\alpha_{P_s}+\alpha_{P_t})=0$. With $m\ge3$ there are three distinct planes, so $\alpha_{P_s}=-\alpha_{P_t}=\alpha_{P_u}=-\alpha_{P_s}$ and every $\alpha_{P_s}=0$.

So $\alpha=0$. **Both bullets consume $m\ge3$ and consume it visibly**, the first needing a spare plane and the second needing a third one, which is the sharpest available account of why the threshold sits where it does.

## 3. The $m=2$ exception is the right reason, not a coincidence of dimensions

**The kernel.** At $m=2$ the pairing $(\delta,\delta')\mapsto\delta\wedge\delta'$ on $\Lambda^2\mathbb R^4$ is a symmetric nondegenerate form of signature $(3,3)$, positive on $\Lambda^+$ and negative on $\Lambda^-$, and $L_\gamma\delta=\delta\wedge\gamma$ is the linear functional it pairs with $\gamma$. So for nondegenerate $\gamma$, which has $\gamma\wedge\gamma\ne0$, $\ker L_\gamma=\gamma^{\perp_w}$ is $5$-dimensional. At $\gamma=e^{12}+e^{34}$ the computation of section 2 returns it explicitly, the second bullet surviving and the first dying: $\ker L_\gamma=\{\delta:\delta_{12}+\delta_{34}=0\}$, of dimension $5$.

**The witness's $\alpha$ lies in it, and lies in it while being nondegenerate.** Take the quaternionic triple $\omega_1=e^{12}+e^{34}$, $\omega_2=e^{13}-e^{24}$, $\omega_3=e^{14}+e^{23}$, an orthogonal basis of $\Lambda^+\mathbb R^4$. Each has $\omega_i\wedge\omega_i=2\,e^{1234}$, and $\omega_1\wedge\omega_2=0$ because every one of its six terms repeats an index. Then $\alpha=\omega_1-\omega_2$ and $\beta=\omega_1+\omega_2$ satisfy $\alpha\wedge\beta=\omega_1\wedge\omega_1-\omega_2\wedge\omega_2=0$, so $\alpha\in\ker L_\beta$, and $\alpha\wedge\alpha=\beta\wedge\beta=4\,e^{1234}\ne0$, so **both $\alpha$ and $\beta$ are nondegenerate**. A nondegenerate form in the kernel of $L$ at another nondegenerate form is precisely what section 2 forbids at $m\ge3$. So the block's "which is exactly where the witness lives" is true in a stronger form than it states.

**The same fact, said structurally.** On $\Lambda^+\mathbb R^4$ the wedge pairing is $\delta\wedge\delta'=2\langle\delta,\delta'\rangle\,e^{1234}$, so the self-wedge of a unit self-dual form is the CONSTANT $2\,e^{1234}$. Every orthonormal triple in $\Lambda^+$ therefore shares its self-wedge automatically, with nothing to check. That is the witness, it is a five-parameter family for the reason already on record at line 830, and it is the same statement as the failure of injectivity of $L$, not a second accident at the same dimension.

**And the witness sits outside the gap the block names.** With $J_1e_1=e_2,\ J_1e_3=e_4$ and $J_2e_1=e_3,\ J_2e_2=-e_4$ one computes $Te_1=-e_4$, $Te_2=-e_3$, $Te_3=e_2$, $Te_4=e_1$, so $T^2=-I$ and $T$ has no real eigenvalue at all. The witness has $E_+=E_-=0$ and $R$ everything, which is the case the Lefschetz step alone kills at $m\ge3$.

## 4. The conclusion from nondegeneracy

If $\beta$ is nondegenerate then $\alpha\wedge\beta=0$ and section 2 give $\alpha=0$, that is $\omega_2=\omega_1$. If $\alpha$ is nondegenerate then $\beta\wedge\alpha=\alpha\wedge\beta=0$ gives $\beta=0$, that is $\omega_2=-\omega_1$. **Both contradict trace-orthogonality.** At $J_2=J_1$, $\mathop{\mathrm{tr}}(J_1J_2)=\mathop{\mathrm{tr}}(J_1^2)=\mathop{\mathrm{tr}}(-I)=-2m$; at $J_2=-J_1$ it is $+2m$. Neither is zero at any $m\ge1$, and the block's "$\mp2m$" matches its own "$\pm$" ordering. In the form language, $\langle\omega_1,\omega_2\rangle=\pm m\ne0$. **CONFIRMED.**

## 5. $T=-J_1J_2$, and the signs

$T$ is a product of the orthogonal matrices $-I$, $J_1$, $J_2$, hence orthogonal, and it is invertible with $T^{-1}=(-J_1J_2)^{-1}=-J_2^{-1}J_1^{-1}\cdot(-1)^{-1}\cdot(-1)= -J_2J_1$, using $J_i^{-1}=-J_i$.

$J_1(I+T)=J_1+J_1(-J_1J_2)=J_1-J_1^2J_2=J_1+J_2$, and $J_1(I-T)=J_1+J_1^2J_2=J_1-J_2$. **So $J_1+J_2$ is singular exactly when $I+T$ is, that is when $-1\in\mathop{\mathrm{spec}}T$, and $J_1-J_2$ exactly when $+1\in\mathop{\mathrm{spec}}T$**, which is the pairing the block writes and in the order it writes it.

$\mathop{\mathrm{tr}}T=-\mathop{\mathrm{tr}}(J_1J_2)$, and $\langle\omega_1,\omega_2\rangle=-\tfrac12\mathop{\mathrm{tr}}(J_1J_2)$, so $\mathop{\mathrm{tr}}T=2\langle\omega_1,\omega_2\rangle$ and trace-orthogonality is exactly $\mathop{\mathrm{tr}}T=0$. **CONFIRMED, with every sign as written.**

*What the constraint gives in full.* $\mathop{\mathrm{tr}}T=0$ is one linear condition and, as the block says, permits both singularities and forbids neither. It is not the only free constraint available: $\det T=(-1)^{2m}\det J_1\det J_2=1$, since a complex structure on $\mathbb R^{2m}$ has determinant $1$, and $\det T=(-1)^{\dim E_-}$ once the rotation blocks are accounted for, so $\dim E_-$ is even. That recovers half of the block's evenness claim from the determinant alone, independently of section 6.

## 6. $J_1TJ_1^{-1}=T^{-1}$, and what the invariance really buys

$J_1TJ_1^{-1}=J_1(-J_1J_2)(-J_1)=J_1^2J_2J_1=-J_2J_1=T^{-1}$, matching section 5's computation of $T^{-1}$ and the block's own chain. Equivalently $TJ_1=J_1T^{-1}$, so for $Tv=\lambda v$ one has $T(J_1v)=J_1T^{-1}v=\lambda^{-1}J_1v$, in the complexification as well since $J_1$ is real and extends complex-linearly. At $\lambda=\pm1$ this is $\lambda^{-1}=\lambda$, so $E_+$ and $E_-$ are $J_1$-invariant.

**Is $J_1$-invariance what gives evenness? Yes, and $T$ orthogonal is not needed for it.** $J_1$ restricted to a $J_1$-invariant subspace squares to $-I$, which makes that subspace a complex vector space and its real dimension even. Nothing else enters. $T$ orthogonal is needed for two other things the block relies on: the splitting $V=E_+\oplus E_-\oplus R$ with no generalised eigenvectors, and the mutual orthogonality of the pieces, which also follows in one line, since $x\in E_+$, $y\in E_-$ give $\langle x,y\rangle=\langle Tx,Ty\rangle=-\langle x,y\rangle$.

**The constraint in full, which is more than the block takes.** Let $\lambda$ be any eigenvalue of $T$ and $W_\lambda\subset V\otimes\mathbb C$ its eigenspace. Since $T$ is orthogonal, $|\lambda|=1$, so $\bar\lambda=\lambda^{-1}$. Complex conjugation $c$ carries $W_{\lambda^{-1}}$ to $W_\lambda$ and $J_1$ carries $W_\lambda$ to $W_{\lambda^{-1}}$, so $\sigma=c\circ J_1$ is an antilinear endomorphism of $W_\lambda$, and $\sigma^2=cJ_1cJ_1=J_1^2=-1$ because $J_1$ is real. **A quaternionic structure forces $\dim_{\mathbb C}W_\lambda$ to be even**, so every eigenvalue of $T$, not only $\pm1$, has even multiplicity. At $\lambda=\pm1$ this reproduces the block's evenness. *Screened, and reported as a screen*: $600$ random pairs of orthogonal complex structures at $\dim=6,8,10$ gave even multiplicities in $600$ cases out of $600$. The exact check is the closed-form one on $\mathbb R^4$: for $J_1=a\cdot\sigma$ and $J_2=b\cdot\sigma$ in $\Lambda^+$ the quaternion relations give $T=(a\cdot b)I-(a\times b)\cdot\sigma$ with $((a\times b)\cdot\sigma)^2=-|a\times b|^2I$, whose eigenvalues are $(a\cdot b)\pm i|a\times b|$ each twice.

The block's "both singularities together need $\dim\ge4$ before anything else is imposed" is correct and, in the light of section 9, moot.

## 7. The restriction claim

On $E_+$, $Tx=x$ means $-J_1J_2x=x$, so $J_2x=-J_1^{-1}x=J_1x$. On $E_-$, $-J_1J_2x=-x$ gives $J_2x=J_1^{-1}x=-J_1x$. **Both as claimed.** The two are consistent with section 5: $J_1-J_2=J_1(I-T)$ kills exactly $\ker(I-T)=E_+$, which is where $J_2=J_1$.

**$E_\pm$ are $J_2$-invariant as well**, immediately since $J_2=\pm J_1$ there, and also from $J_2TJ_2^{-1}=J_2(-J_1J_2)(-J_2)=-J_2J_1=T^{-1}$, the same relation with the roles exchanged. **It is not needed.** Section 8's cross terms and section 9's component both go through on $J_1$-invariance alone.

## 8. The cross terms, checked explicitly

Write $V=E_-\oplus E_+\oplus R$. As matrices, $\alpha=J_1(I-T)$ and $\beta=J_1(I+T)$, and each of the three pieces is invariant under both $T$ and $J_1$, hence under $\alpha$ and $\beta$. A skew matrix preserving a subspace also preserves its orthogonal complement and is therefore block-diagonal, so:

- $\alpha x=0$ for $x\in E_+$, since $(I-T)x=0$. **So $\alpha$ has no leg on $E_+$ at all**, and every cross term of $\alpha$ pairing $E_+$ with anything vanishes for that reason, which is stronger and simpler than the block's "each piece is $J_i$-invariant and they are orthogonal".
- $\alpha x=2J_1x\in E_-$ for $x\in E_-$, so $\alpha(x,y)=\langle 2J_1x,y\rangle=0$ for $y\in R$, the $E_-$-against-$R$ cross terms vanishing because $E_-$ is $J_1$-invariant and $E_-\perp R$. This is the one place the block's stated reason is the operative one.
- $\alpha|_{E_-}=2\omega_1|_{E_-}$, and symmetrically $\beta$ annihilates $E_-$, equals $2\omega_1$ on $E_+$, and has no $E_+$-against-$R$ cross term.

**One thing the block's sentence does not say and should not be read as saying**: $\alpha|_R=J_1(I-T)|_R$ is in general nonzero, and likewise $\beta|_R$. The sentence describes $\alpha$ on $E_\pm$ only, so it is accurate, but a reader who takes it as a complete description of $\alpha$ has imported $R=0$ without noticing. **CONFIRMED.**

## 9. The rotation-free contradiction, and the hypothesis it does not use

**The component is where the block says.** Suppose $E_+\ne0$ and $E_-\ne0$. Pick any complement, and decompose $\Lambda^4V^*=\bigoplus_{p+q+r=4}\Lambda^pE_-^*\otimes\Lambda^qE_+^*\otimes\Lambda^rC^*$. By section 8, $\alpha$ has no $E_+$ leg and $\beta$ has no $E_-$ leg. A term of $\alpha\wedge\beta$ lands in the $(p,q,r)=(2,2,0)$ summand only if one factor contributes two $E_-$ legs and the other two $E_+$ legs, and $\alpha$'s only such option is $\alpha|_{\Lambda^2E_-}$ while $\beta$'s is $\beta|_{\Lambda^2E_+}$. **There is exactly one contribution and so nothing to cancel against:**
$$(\alpha\wedge\beta)\big|_{\Lambda^2E_-\otimes\Lambda^2E_+}=\alpha|_{E_-}\wedge\beta|_{E_+}.$$

**Both factors are nonzero.** $\alpha|_{E_-}=2\omega_1|_{E_-}$ and $E_-$ is a nonzero $J_1$-invariant subspace, so for $0\ne x\in E_-$ the vector $J_1x$ lies in $E_-$ and $\omega_1(x,J_1x)=\langle J_1x,J_1x\rangle=|x|^2\ne0$. In fact $\omega_1|_{E_-}$ is nondegenerate, though only nonvanishing is used. Same for $\beta|_{E_+}$. And the wedge map $\Lambda^2E_-^*\otimes\Lambda^2E_+^*\to\Lambda^4V^*$ is injective, being one summand of the canonical decomposition, so $\alpha|_{E_-}\wedge\beta|_{E_+}\ne0$. Hence $\alpha\wedge\beta\ne0$.

**The hypothesis $R=0$ was never used.** The rotation part contributes only to summands carrying at least one $C$ leg, which is a different summand of $\Lambda^4$. What $R=0$ buys is the block's phrasing "nondegenerate forms on complementary subspaces", which needs $E_-\oplus E_+=V$. What the argument needs is that $\alpha$ misses $E_+$ and $\beta$ misses $E_-$, which holds always. **So the paragraph as written is TRUE, and it is a strict weakening of what its own computation delivers.**

**Exhibited in closed form, in the setting and at the block's own surviving shape.** On $\mathbb R^8$ take
$$J_1=e^{12}+e^{34}+e^{56}+e^{78},\qquad J_2=e^{12}-e^{34}+e^{57}-e^{68},$$
both orthogonal complex structures, with $\mathop{\mathrm{tr}}(J_1J_2)=0$, so the pair is trace-orthogonal. Then $T=-J_1J_2$ has $E_+=\langle e_1,e_2\rangle$, $E_-=\langle e_3,e_4\rangle$ and $R=\langle e_5,e_6,e_7,e_8\rangle$ with $T^2=-I$ on $R$, so $\mathop{\mathrm{spec}}T=\{1,1,-1,-1,i,i,-i,-i\}$: both $\pm1$ present with even multiplicity and a nontrivial rotation part, which is EXACTLY the configuration the block says survives. And
$$(\omega_1\wedge\omega_1-\omega_2\wedge\omega_2)_{1234}=2(1)(1)-2(1)(-1)=4\ne0,$$
which is $\alpha|_{E_-}\wedge\beta|_{E_+}=(2e^{34})\wedge(2e^{12})=4\,e^{1234}$ as predicted. *Screened, and reported as a screen*: the full $\Lambda^4$ difference for this pair has nine nonzero coefficients, the $(1234)$ one being $4$, and with the rotation block replaced by an arbitrary complex structure on $\langle e_5,\dots,e_8\rangle$ the $(1234)$ coefficient stayed $4$ in every trial, as it must, since it does not see $R$.

**The smallest instance of the same phenomenon is on $\mathbb R^4$ and needs no screen at all.** $\omega_1=e^{12}+e^{34}$ self-dual and $\omega_2=e^{12}-e^{34}$ anti-self-dual give $T=\mathop{\mathrm{diag}}(1,1,-1,-1)$, so both $E_\pm$ are nonzero, and $\alpha=2e^{34}$, $\beta=2e^{12}$, $\alpha\wedge\beta=4e^{1234}=\omega_1\wedge\omega_1-\omega_2\wedge\omega_2=2-(-2)$ times $e^{1234}$. The two self-wedges differ because one form is self-dual and the other anti-self-dual, which is the whole of the obstruction in that dimension.

**What follows, stated as a candidate lemma.**

> *Let $J_1,J_2$ be orthogonal complex structures on $\mathbb R^{2m}$ with $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. If $m\ge3$ then $J_2=\pm J_1$.*

*Proof.* By the component argument, $E_+$ and $E_-$ are not both nonzero. If $E_-=0$ then $-1\notin\mathop{\mathrm{spec}}T$, so $I+T$ and hence $\beta=J_1(I+T)$ is invertible, that is $\beta$ is nondegenerate, and section 2 turns $\alpha\wedge\beta=0$ into $\alpha=0$, that is $J_2=J_1$. If $E_+=0$ then symmetrically $\alpha$ is nondegenerate and $\beta=0$, that is $J_2=-J_1$. If both vanish either branch applies. $\square$

**Corollary.** Adding trace-orthogonality, which excludes $J_2=\pm J_1$ by section 4, there is no trace-orthogonal PAIR of orthogonal complex structures on $\mathbb R^{2m}$ with a common self-wedge at any $m\ge3$. A fortiori there is no such triple, so **the surviving rank-three question is empty at every $m\ge3$**, and the record's "OPEN at $m\ge4$" at line 989 of [findings/diagonal-half.md](../findings/diagonal-half.md) is false. The pair statement also reaches the rank-two entry at line 830, whose "OPEN at $\dim V\ge8$" rests on the same configuration once [L195](../findings/diagonal-half.md) has reduced it to $A=c\,\mathrm{Id}$. Tracing that spread is the parent's to do, since the rank-two hypotheses were not part of this brief.

*Locating the discrepancy exactly.* The line is "*If $R=0$ then $\alpha$ and $\beta$ are nondegenerate forms on complementary subspaces, and their wedge has $\alpha\otimes\beta\ne0$ as its $\Lambda^2E_-\otimes\Lambda^2E_+$ component, against $\alpha\wedge\beta=0$.*" The hypothesis it needs is that $\alpha$ misses $E_+$ and $\beta$ misses $E_-$. The hypothesis it takes is $R=0$, which is strictly stronger and which the component in question does not see.

*Arguing the opposite, most charitably.* Read literally the sentence asserts an implication with $R=0$ as its hypothesis, and that implication is TRUE, so the block states nothing false here. Its words "nondegenerate forms on complementary subspaces" and "$\alpha\otimes\beta$" for the whole forms rather than their restrictions are only correct when $R=0$, so the author may have been describing the objects rather than the component and may have believed the component reading fails without it. It does not fail. **The discrepancy is one of understatement, and it survives all three tests: located, exhibited in closed form on $\mathbb R^4$ and $\mathbb R^8$, and read as charitably as the words allow.**

## 10. What survives, and what is cheap at $m=4$

**"At all three pairs" is correctly inherited.** The three self-wedges are equal, so each of the three pairs $(1,2)$, $(1,3)$, $(2,3)$ satisfies $\alpha_{ij}\wedge\beta_{ij}=0$ and is pairwise trace-orthogonal, and every step above applies to each pair separately. The three operators are not independent: $T_{12}T_{23}=(-J_1J_2)(-J_2J_3)=J_1J_2^2J_3=-J_1J_3=T_{13}$, so $T_{12}T_{23}T_{31}=I$.

**Two defects in the summary sentence.**

- *It is refuted as a description of what survives.* By section 9 the locus "both $\pm1$ present, each with even multiplicity, and a nontrivial rotation part" is EMPTY, at one pair let alone at three. What survives the whole Lefschetz route is nothing.
- *It is false at $m=2$ if the $m\ge3$ it inherits is not supplied.* The block's own witness, the quaternionic triple, has $T^2=-I$ at every pair, hence no $\pm1$ eigenvalue and $E_+=E_-=0$. So the shape the sentence names is not merely narrow at $m=2$, it excludes the one configuration known to exist. The preceding paragraph does carry "$m\ge3$" and the phrase "the whole Lefschetz route" points at it, which is the charitable reading, but the sentence is the block's summary line and it is the line that will be quoted.

**What was cheap at $m=4$, had the branch not closed.** Suppose the surviving shape held on $\mathbb R^8$. Write $\dim E_+=2a$, $\dim E_-=2b$, and let the rotation eigenvalues be $e^{\pm i\theta_r}$ with complex multiplicity $2c_r$ each, even by section 6. Then $2a+2b+4\sum_rc_r=8$ with $a,b\ge1$ and $\sum_rc_r\ge1$, which forces $a=b=1$ and a single rotation eigenvalue pair with $c=1$. Then $\mathop{\mathrm{tr}}T=2-2+4\cos\theta=0$ gives $\theta=\pi/2$. **So every $T_{ij}$ would have spectrum $\{1,1,-1,-1,i,i,-i,-i\}$, with $T_{ij}^4=I$ and $T_{ij}^2=-I$ on the rotation part**, at all three pairs, subject to $T_{12}T_{23}=T_{13}$. Without the even-multiplicity lemma the trace alone leaves the two rotation angles free with $\cos\theta_1+\cos\theta_2=0$, and excludes the splittings $(4,2,2)$ and $(2,4,2)$ because they would force a rotation angle to be $0$ or $\pi$. That rigidity is what made the $\mathbb R^8$ exhibit in section 9 easy to write down by hand, and it is now only of expository use.

## 11. Falsifiers, and what was done to look for them

**What would falsify the block's headline claim that a gap remains**: an argument closing the rotation case. Section 9 is that argument, and it closes not the rotation case but the entire configuration the block calls the gap, without touching the rotation part at all.

**What would falsify section 9 and restore the block's reading**: a pair $J_1,J_2$ of orthogonal complex structures on some $\mathbb R^{2m}$ with $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$ and both $E_+\ne0$ and $E_-\ne0$. Section 9 proves none exists, in any dimension, with no dimension hypothesis and without trace-orthogonality. The two closed-form places where such a pair might have hidden were checked by hand: on $\mathbb R^4$, one form self-dual and the other anti-self-dual is the only way to get both eigenvalues, and its self-wedges are $+2\,\mathrm{vol}$ and $-2\,\mathrm{vol}$; on $\mathbb R^4\oplus\mathbb R^4$ with $J_1=(A,A)$ and $J_2=(B,C)$, matching the $\Lambda^2\otimes\Lambda^2$ cross term forces $B\otimes C=A\otimes A$, hence $B=C=\pm A$ by the same rank-one reading [L195](../findings/diagonal-half.md) uses.

**What would falsify the corollary**: a trace-orthogonal triple at $m=4$. On the derivation above none exists. **No search was run for one**, in keeping with the analysis-only footing: the exhibits here are integer matrices written down to display a mechanism already proved, and the three screens named in the standfirst confirm claims that were established in closed form before they were run.

## Verdict

**Every derivation in the block is correct, and the block is CONFIRMED step by step: items 1 through 8 stand, with two precision defects at item 1 and a stronger reason available at item 8.** Item 9 is true as written and its hypothesis $R=0$ is inert. Removing that hypothesis turns the paragraph into a proof that $E_+$ and $E_-$ are never both nonzero, which is exactly the gap named three paragraphs earlier, so **the gap does not exist and the block's closing summary at item 10 is REFUTED: the locus it says survives is empty**.

**The consequence is larger than the block.** Two orthogonal complex structures on $\mathbb R^{2m}$ with a common self-wedge are equal up to sign at every $m\ge3$, so the surviving rank-three question is empty at every $m\ge3$ and the record's "OPEN at $m\ge4$" falls. That claim is mine and not the block's, it is derived above in full and screened, and it should be adjudicated before line 989 is edited.
