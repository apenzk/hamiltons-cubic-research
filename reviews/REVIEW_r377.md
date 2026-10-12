### Reviewer 377: the pair-block matrix $B$, its three exact vectors, and the compression bound on $M^{(jk)}$

*Cold brief, Gate 2. Every claim below was re-derived from the definitions before the record was opened; the record was then read to check attribution and scope. Analysis only, as the programme's standing rule requires, the one numerical act is a screen of identities I was about to record, on sphere-product critical points I constructed and verified critical by hand first, reported as a screen and never as evidence.*

**Headline.** Claims 1 and 2 are **CONFIRMED** in full, signs and factors included, and they agree with [r376](REVIEW_r376.md). Claim 3's chain is **CONFIRMED link by link**, but with two corrections that change what the entry is worth: its stated conclusion is **CORRECTED**, since "the exceptional directions are confined to $\operatorname{span}\{u,v\}$" is false and I give a hand witness; and its **novelty is CORRECTED downward**, since the headline count "at most two eigenvalues of $N$ in $(0,\theta)$" already follows in two lines from a statement the record carries verbatim, by Cauchy interlacing, with no compression needed. What the compression genuinely adds is a **rank refinement the entry did not notice**, and that refinement is strictly stronger exactly in the orbit-free blocks [I18](../plan.md) is about.

---

#### Claim 1, the identity for $B$ and the $L_e$ pair block: CONFIRMED

**(a) The row-sum step.** For $i\in I$, $M\mathbf1=0$ reads $\sum_{l\in I}M_{il}+M_{ij}+M_{ik}=0$, and $\sum_{l\in I}M_{il}=(N\mathbf1)_i$ exactly (the $l=i$ term is $M_{ii}=0$ on both sides). So $(N\mathbf1)_i=-u_i-v_i$, hence $\operatorname{diag}(N\mathbf1)=-\operatorname{diag}(u+v)$ and

$$B:=\Delta^{(jk)}+(\theta+M_{jk})\mathrm{Id}=(\theta+M_{jk})\mathrm{Id}-\operatorname{diag}(u+v)-N .$$

Ricci-flatness is the whole content of the step and the entry says so. **Confirmed.**

**(b) The $L_e$ pair block.** [Lemma L122](../findings/second-order.md) gives the $L_M$ pair block as $-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}$, and its own normalisation line, *"the $\tfrac12$ threshold is in $L_e$ units, L121 and L122 giving $L_M$ eigenvalues whose orbit value is $\theta/2$"*, fixes $L_e=L_M/\theta$. Then

$$\tfrac12\mathrm{Id}-\tfrac1{2\theta}B=\tfrac12\mathrm{Id}-\tfrac{\Delta^{(jk)}}{2\theta}-\tfrac{\theta+M_{jk}}{2\theta}\mathrm{Id}=-\tfrac1{2\theta}\big(\Delta^{(jk)}+M_{jk}\mathrm{Id}\big)=\tfrac1\theta\Big[-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}\Big].$$

**The sign and the factor are both right.** Cross-check on the orbit: $\Delta^{(jk)}o=-(\theta+M_{jk})o$ gives $L_M o=\tfrac12(\theta+M_{jk})o-\tfrac12M_{jk}o=\tfrac\theta2 o$, which is L122's own stated orbit value, and $L_e o=\tfrac12 o$. Consistent. **Confirmed.**

**One place the record's prose is loose, worth a line.** [ATTEMPTS.md](../ATTEMPTS.md)'s earlier paragraph writes *"L122 gives the pair block as $-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}$, so $\tfrac12$ is an $L_e$-eigenvalue exactly when $-(\theta+M_{jk})$ is an eigenvalue of $\Delta^{(jk)}$"*, the equivalence is correct only after dividing by $\theta$, which that sentence does not carry. The new entry's $\tfrac12\mathrm{Id}-B/(2\theta)$ **repairs** it. Recorded as a correction to the older prose, not to the new claim.

**(c) The two riders attached to (b).** *"$\ker B=\mathbb Ro$"* and *"the maximiser inequality is $B\succeq0$"* are both correct: $\tfrac12$ is a block eigenvalue iff $\ker B\ne0$, and [Lemma L24](../findings/second-order.md)'s $L_e\le\tfrac12$ on $W^\perp$ reads $\beta\ge0$ for every eigenvalue $\beta$ of $B$, using $\theta>0$. **A step the entry leaves implicit and which is needed:** $\ker B\subseteq\mathbf1^\perp$ is automatic, since $B$ is symmetric and $B\mathbf1=(\theta+M_{jk})\mathbf1$ makes $\mathbf1$ an eigenvector with nonzero eigenvalue whenever $\theta+M_{jk}\ne0$, the same hypothesis the entry already hedges item (1) with. Worth writing down, because without it "the clause is exactly $\ker B=\mathbb Ro$" would need the Ricci cut imposed by hand.

---

#### Claim 2, the three exact vectors: CONFIRMED, and it agrees with r376 on the sign

**(1) $B\mathbf1=(\theta+M_{jk})\mathbf1$.** $\Delta^{(jk)}\mathbf1=\operatorname{diag}(N\mathbf1)\mathbf1-N\mathbf1=0$ for any $N$. **Confirmed**, and it needs nothing beyond $\Delta$ being a Laplacian.

**(2) $Bu=Bv=M_{jk}(u+v)-u\circ v$, checked in the detail the brief asks for.**

*The split.* For $i\in I$ (so $i\ne j$ and $i\ne k$, and criticality applies),
$$(M^2)_{ij}=\underbrace{\textstyle\sum_{l\in I}M_{il}M_{lj}}_{=(Nu)_i}+\underbrace{M_{ij}M_{jj}}_{=0}+\underbrace{M_{ik}M_{kj}}_{=v_iM_{jk}} .$$

- **The $l=j$ term does vanish, and by hollowness $M_{jj}=0$**, used correctly.
- **The $l=i$ term inside $\sum_{l\in I}$ also vanishes**, $M_{ii}M_{ij}=0$, which is exactly why $\sum_{l\in I}M_{il}M_{lj}$ equals $(Nu)_i$ on the nose with $N$ hollow. No discrepancy.
- Criticality $\theta u_i-u_i^2=(M^2)_{ij}$ therefore gives $(Nu)_i=\theta u_i-u_i^2-M_{jk}v_i$, which is the entry's line.

*Substituting.* $(Bu)_i=(\theta+M_{jk})u_i-(u_i+v_i)u_i-(Nu)_i=M_{jk}u_i-u_iv_i+M_{jk}v_i$. So $Bu=M_{jk}(u+v)-u\circ v$. **Confirmed.**

*The $j\leftrightarrow k$ swap.* **It is legitimate, and it is a genuine symmetry rather than a notational one.** The pair $\{j,k\}$ is unordered: $I$, $N$ and $\operatorname{diag}(u+v)$ are all invariant under the swap, $M_{kj}=M_{jk}$ by symmetry, so $B$ is invariant while $u\leftrightarrow v$. The identical computation returns $Bv=M_{jk}(v+u)-v\circ u$, the same vector. **Confirmed.**

**(3) $B(u-v)=0$, and it agrees with [r376](REVIEW_r376.md) including the sign.** $o_i=M_{ki}-M_{ji}=v_i-u_i$, so $o=v-u$ and $Bo=-(Bu-Bv)=0$; equivalently $\Delta^{(jk)}o=-(\theta+M_{jk})o$. I re-derived r376's route independently and it matches term for term:
$$(No)_i=\big[(M^2)_{ik}-u_iM_{jk}\big]-\big[(M^2)_{ij}-v_iM_{jk}\big]=o_i(\theta+M_{jk})-o_i(u_i+v_i),$$
using $u_i^2-v_i^2=-o_i(u_i+v_i)$; then $(\Delta o)_i=-(u_i+v_i)o_i-(No)_i=-(\theta+M_{jk})o_i$. **The two derivations agree, and the sign convention $o=v-u$ is consistent between the entry and r376.** Both use only diagonal criticality and zero row sums; maximality appears in neither.

**One inflation to trim.** The entry calls $B(u+v)=2[M_{jk}(u+v)-u\circ v]$ "the symmetric half of a single identity" and "new here". It is $2\times$ item (2) and carries nothing item (2) does not; item (2) is the new content and the "two halves" framing overstates the decomposition. Cosmetic.

---

#### Claim 3, the compression: every link CONFIRMED, the stated conclusion CORRECTED

**Link 1: $M^2-\theta M\succeq0$ at a pure critical point.** Off the diagonal, criticality gives $(M^2-\theta M)_{il}=-M_{il}^2$; on the diagonal, hollowness gives $(M^2)_{ii}=\sum_lM_{il}^2$ and $\theta M_{ii}=0$. So

$$M^2-\theta M=\operatorname{diag}\big(M^{\circ2}\mathbf1\big)-M^{\circ2}=L\big(M^{\circ2}\big),$$

a weighted graph Laplacian with weights $M_{il}^2\ge0$, hence PSD. **Confirmed, and the scope is right for the use.** It needs symmetry, hollowness and off-diagonal criticality; it does **not** need $M\mathbf1=0$ or $\theta>0$.

*On Reviewer 129's refutation, which the brief asks about.* That witness is a threat only if it is critical, and it is not: [diagonal-half.md:294](../findings/diagonal-half.md) records it with **criticality residual $0.002$**, and the same paragraph states the correct scope (*"$K^2-\lambda K\succeq0$ is a property of diagonal CRITICAL points), REFUTED as a property of the diagonal locus"*. A pure critical point is on the critical side of that line, so **claim 3's foundation is untouched by r129**, and the entry cites it correctly.

**Link 2: the compression identity.** For $i,l\in I$, splitting $\sum_{m\in[n]}$ over $I$, $m=j$, $m=k$ gives $(M^2)_{il}=(N^2)_{il}+M_{ij}M_{jl}+M_{ik}M_{kl}=(N^2)_{il}+u_iu_l+v_iv_l$, using $M_{jl}=M_{lj}=u_l$ and $M_{kl}=v_l$. It holds at $i=l$ too. With $\Pi M\Pi=N$,
$$\Pi\big(M^2-\theta M\big)\Pi=N^2-\theta N+uu^\top+vv^\top .$$
**Confirmed.**

**Link 3: a compression of a PSD matrix is PSD.** $x^\top\Pi A\Pi x=(\Pi^\top x)^\top A(\Pi^\top x)\ge0$. **Confirmed**, and for a coordinate projection it is immediate.

**Link 4: PSD-minus-rank-$r$ bounds the negative count.** Write $C=N^2-\theta N$ and $R=uu^\top+vv^\top\succeq0$, $\operatorname{rank}R=\dim\operatorname{span}\{u,v\}=:r\le2$. Let $V_-$ be the span of $C$'s negative eigenvectors, $d=\dim V_-$, $m=|I|$. If $d>r$ then $\dim(V_-\cap\ker R)\ge d+(m-r)-m=d-r\ge1$; any $0\ne x$ there has $x^\top Rx=0$ and $x^\top Cx<0$, so $x^\top(C+R)x<0$, contradicting $C+R\succeq0$. Hence $d\le r$. **Confirmed**, and note this subspace form needs no case split, whereas the Weyl-inequality form ($\lambda_{i+2}(C)\le\lambda_i(C+R)+\lambda_3(-R)$) needs $m\ge5$ for $\lambda_3(-R)=0$. The entry says "up to the interlacing" without naming an argument; the subspace argument above is the one that works.

**Link 5: the translation to $(0,\theta)$.** $C=p(N)$ with $p(t)=t(t-\theta)$, a polynomial in $N$, so $C$'s eigenvalues are $p(\lambda_i(N))$ on the same eigenvectors, and $p(\lambda)<0\iff\lambda\in(0,\theta)$ given $\theta>0$. So $n_-(C)$ **is** the number of $N$-eigenvalues in $(0,\theta)$, with multiplicity. **Confirmed**; $\theta>0$ is load-bearing and is granted.

##### The stated conclusion is wrong on one clause, REFUTED, with a hand witness

> *"the two exceptional directions are confined to $\operatorname{span}\{u,v\}$ up to the interlacing"*

**What the argument gives is strictly weaker.** If $Nw=\lambda w$ with $\lambda\in(0,\theta)$ then $w^\top Cw<0$, so $w^\top Rw>0$, i.e. $(u^\top w)^2+(v^\top w)^2>0$: **$w$ has a nonzero projection onto $\operatorname{span}\{u,v\}$**. Membership does not follow, and generically fails, because $\operatorname{span}\{u,v\}$ is not $N$-invariant, $Nu=\theta u-u\circ u-M_{jk}v$ carries $u\circ u$, which leaves the plane.

**Witness, entirely by hand.** Take $S^3\times S^4$ with cross entry $c=-1$: then $a=-qc/(p-1)=2$, $b=-pc/(q-1)=1$, $\theta=-(n-1)c=6$, and criticality and $M\mathbf1=0$ both hold exactly. Take the within-factor pair $\{j,k\}=\{1,2\}\subset F_1$, so $I=\{3\}\cup F_2$ and $u=v=(2,-1,-1,-1,-1)$. Then
$$N=\begin{pmatrix}0&-1&-1&-1&-1\\-1&0&1&1&1\\-1&1&0&1&1\\-1&1&1&0&1\\-1&1&1&1&0\end{pmatrix},$$
whose equitable partition gives eigenvalue $-1$ with multiplicity $4$ and, on vectors $(s;t,t,t,t)$, the block $\left(\begin{smallmatrix}0&-4\\-1&3\end{smallmatrix}\right)$ with eigenvalues $4$ and $-1$. **Exactly one eigenvalue, $\lambda=4$, lies in $(0,6)$, and its eigenvector is $w=(-1,1,1,1,1)$.** Here $\operatorname{span}\{u,v\}=\mathbb Ru$ and $w$ is **not** a multiple of $u=(2,-1,-1,-1,-1)$: the ratios are $-2$ and $-1$. The projection is nonzero as the corrected statement predicts, $\langle w,u\rangle=-6$, $\cos=6/\sqrt{40}=0.9487$, and it is not $1$. **The confinement clause is refuted.**

*Screen, reported as a screen.* I evaluated the chain at $S^3\times S^4$, $S^5\times S^7$, $S^4\times S^4$ and $S^2\times S^6$ on matrices built from the closed form above (criticality residual $\le1.8\times10^{-15}$): every identity of claims 1–3 holds to machine zero, and the projection of the exceptional eigenvector is $0.9487$, $0.9889$, $0.9818$ at the within-factor pairs (never $1$) and $1$ at the cross pairs, where $\operatorname{span}\{u,v\}$ is two-dimensional and happens to contain the eigenvector. **The screen corroborates a hand derivation; it is not the evidence for it.**

##### The correct statement, and it is sharper than the entry's in the case I18 needs

> **At every pure critical point and every pair $\{j,k\}$, the number of eigenvalues of $N=M^{(jk)}$ in $(0,\theta)$, with multiplicity, is at most $\dim\operatorname{span}\{u,v\}\le2$; and the span $E$ of the corresponding eigenvectors meets $\{u,v\}^\perp$ trivially, so orthogonal projection embeds $E$ into $\operatorname{span}\{u,v\}$.**

**The rank refinement is the entry's real gain and it did not claim it.** A pair block is **orbit-free** exactly when $o=v-u=0$, i.e. $u=v$; then $R=2uu^\top$ has rank $\le1$ and

> **in every orbit-free pair block, at most ONE eigenvalue of $M^{(jk)}$ lies in $(0,\theta)$.**

The orbit-free blocks are precisely the ones [I18](../plan.md)'s pair clause is about, so this is the case that matters. **And the bound is attained** (the witness above is an orbit-free block with exactly one eigenvalue in $(0,\theta)$) so it cannot be improved to zero.

---

#### Claim 4, novelty accounting: one direction CONFIRMED, the other CORRECTED

**The confirmation half is right.** [findings/diagonal-half.md:235](../findings/diagonal-half.md) carries the boxed $K^2-\lambda K\succeq0$ **together with the phrasing "equivalently $K$ has no eigenvalue in $(0,\lambda)$"**, and the next paragraph names it *"exactly the weighted graph Laplacian $L(w)$ with $w_{ab}=K_{ab}^2$"* with the same one-line proof. Line 294 supplies the critical-points-not-locus scope. **The entry's self-assessment ("recorded here as a confirmation reached by a different route, claiming nothing new"), is accurate**, and its screen fired correctly.

**The other half needs correcting: the compression *step* is new, but its *headline conclusion* is not, and the entry does not notice.**

- *The step.* I searched [findings/](../findings/), [reviews/](../reviews/) and [results.md](../results.md) for the compression to a deleted-two-rows submatrix and for the rank-two form $uu^\top+vv^\top$: **no prior occurrence.** The identity $(M^2)_{il}=(N^2)_{il}+u_iu_l+v_iv_l$ and the display $\Pi(M^2-\theta M)\Pi=N^2-\theta N+uu^\top+vv^\top$ are new here. **Confirmed new.**
- *The conclusion.* **"At most two eigenvalues of $N$ in $(0,\theta)$" follows from the already-recorded statement in two lines, with no compression.** $N$ is a principal submatrix of $M$ of codimension $2$, so Cauchy interlacing gives $\lambda_i(M)\ge\lambda_i(N)\ge\lambda_{i+2}(M)$. Suppose $N$ had three eigenvalues in $(0,\theta)$; being an interval, they occupy consecutive positions $a,a+1,a+2$. Then $\lambda_{a+2}(M)\ge\lambda_{a+2}(N)>0$ and $\lambda_{a+2}(M)\le\lambda_a(N)<\theta$, so $\lambda_{a+2}(M)\in(0,\theta)$, contradicting *"$M$ has no eigenvalue in $(0,\theta)$"*, which [diagonal-half.md:235](../findings/diagonal-half.md) states outright. **So the boxed conclusion of the new entry was already available from the same file the entry cites for its confirmation half.**

**Net accounting, then.** The entry over-credits itself on the count and under-credits itself on the structure. What the compression genuinely buys over interlacing is (i) the localisation $E\cap\{u,v\}^\perp=0$, which interlacing cannot see at all, and (ii) the rank refinement to $\dim\operatorname{span}\{u,v\}$, **strictly stronger than interlacing in exactly the orbit-free blocks**, where interlacing still permits two and the compression permits one. Those two items are the ones to record.

---

#### What still does not follow, and what I could not check

- **The gap the entry itself names is real and correctly named.** $B$ carries $\operatorname{diag}(u+v)$, which is not a polynomial in $N$; the compression constrains $\sigma(N)$ and says nothing about $\sigma(B)$. Nothing in claim 3 moves $\ker B=\mathbb Ro$ or $B\succeq0$, and the entry does not pretend otherwise.
- **The band is still unspent.** $\theta\ge\sqrt{3/2}$ enters nowhere in claims 1–3; every statement above holds at every pure critical point regardless of $\theta$ beyond $\theta>0$. The entry's closing line says the band "has not been used yet", which is correct, and the compression does not change that.
- **Checked entirely by hand:** all of claims 1, 2 and 3, the witness, and the interlacing shortcut. **Nothing was left unchecked for want of computation.** The only claim I did not attempt to settle is whether the orbit-free one-eigenvalue bound can be pushed to a statement about $B$, that is a derivation, not a run, and it is the natural successor item.

*Reviewer 377, Gate 2, analysis only.*
