# Gate 2 review r946: Lemma L224 (the pair-block supremum) and Lemma L223 (the stability of L57)

Brief: [BRIEF_L223_L224.md](BRIEF_L223_L224.md). Log: agent_logs/review-r946.log. Analysis only. One screen of a few tenths of a second was run on objects built for it (item 3), and it is reported as a screen.

| # | Item | Verdict |
|---|------|---------|
| 1 | L224 step 1, coordinates | CONFIRMED |
| 2 | L224 step 2, the two squares | CONFIRMED |
| 3 | L224 step 3, the cubic | CONFIRMED |
| 4 | L224 step 4, rank one | CONFIRMED |
| 5 | L224 step 5, equality | CONFIRMED |
| 6 | L224 scope and What it gives | PLAUSIBLE, two wording repairs to What it gives |
| 7 | L224 counterexample hunt | CONFIRMED, no counterexample, and a structural reason padded $W_{\mathbb{CP}^2}$ never meets $\mathcal S_{jk}$ |
| 8 | L224 record | CONFIRMED, consistent with every recorded value, and step 3 is L219 applied at two reflections |
| 9 | L223 step 1 | CONFIRMED |
| 10 | L223 step 2 | CONFIRMED |
| 11 | L223 step 3 | CONFIRMED |
| 12 | L223 steps 4 and 5 | PLAUSIBLE, $w=\operatorname{sign}(v)/\sqrt n$ needs a tie-break at $v_i=0$ |
| 13 | L223 scope | CONFIRMED, with a floor on the radius at odd $n$ recorded |
| L | Lean, both files | PLAUSIBLE, Z_norm_sq checks the pairing and leaves the norm to the paper projection argument |

**Summary.** L224 stands at every $n\ge4$: every step was rederived and the supremum and equality case hold as stated. Its What it gives needs two scope repairs: it is vacuous at $4\le n\le11$, and it reaches global maximisers only. L223 stands once $w$ is given a sign at zero coordinates.

## Claim A, Lemma L224

### Item 1, coordinates: CONFIRMED

- $\sigma$ (swap of $j,k$) acts on $\Lambda^2$ by $e_{ja}\leftrightarrow e_{ka}$, $e_{jk}\mapsto-e_{jk}$, $e_{ab}\mapsto e_{ab}$. On a diagonal tensor it permutes $K_{ja}\leftrightarrow K_{ka}$ and fixes $K_{jk}$ (sign squared) and every $K_{ab}$. So $D^-=\tfrac12(D-\sigma D)$ has entries $\tfrac12(K_{ja}-K_{ka})$ at $ja$, the negative at $ka$, and nothing else, which is $D^-_y$. $E=\tfrac12(D+\sigma D)$ is swap-even. Both lie in $\mathcal D_n$ because $\sigma\in O(n)$ preserves $\mathcal D_n$.
- Row sums of $D^-_y$: row $j$ is $\sum y$, row $k$ is $-\sum y$, row $a$ is $y_a-y_a=0$. So $D^-_y\in\mathcal D_n$ exactly when $\sum y=0$.
- $\nu_x$ has entries $x_a$ at $(ja,ka)$ and $(ka,ja)$. $\sigma$ carries entry $(ja,ka)$ to $(ka,ja)$, which by symmetry carries the same value, so $\sigma\nu_x=\nu_x$. $V_{jk}$ is the $\varepsilon_j\varepsilon_k$ isotypic part, whose only admissible entries are $(ja,ka)$, and Ricci-flatness at $(j,k)$ is $\sum x=0$, so $V_{jk}=\{\nu_x:\sum x=0\}$ of dimension $n-3$.
- Norms in the Frobenius norm over all entries: $\lVert D^-_y\rVert^2=\sum y_a^2+\sum y_a^2=2\lVert y\rVert^2$, $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$. The three pieces are mutually orthogonal ($E\perp D^-$ by parity, diagonal $\perp$ off-diagonal), so $\lVert W\rVert^2=\lVert E\rVert^2+2s$.

### Item 2, the two squares: CONFIRMED

From $(A\circ A)_{pq}=A_{pq}^2+\sum_cA_{pc}A_{cq}$ with $Y_{ja}=y_a$, $Y_{ka}=-y_a$, $Y_{jk}=Y_{ab}=0$:

| entry | $Y_{pq}^2$ | $\sum_cY_{pc}Y_{cq}$ | total | $G_y$ |
|---|---|---|---|---|
| $(j,a)$ | $y_a^2$ | $0$ (needs $Y_{ca}\ne0$ with $c\ne j,k$, or $Y_{jk}$) | $y_a^2$ | $y_a^2$ |
| $(k,a)$ | $y_a^2$ | $0$ | $y_a^2$ | $y_a^2$ |
| $(j,k)$ | $0$ | $\sum_ay_a(-y_a)$ | $-\lVert y\rVert^2$ | $-\lVert y\rVert^2$ |
| $(a,b)$ | $0$ | $Y_{aj}Y_{jb}+Y_{ak}Y_{kb}$ | $2y_ay_b$ | $2y_ay_b$ |

- The formula is the record's $Q=W^2+W^\#$ on diagonal tensors: $(W^2)_{ab,ab}=K_{ab}^2$ and $(W^\#)_{ab,ab}=\sum_cK_{ac}K_{cb}$, the second term of the $\#$ formula vanishing on diagonal tensors. It returns $\mathrm{id}^\#=(n-2)\mathrm{id}$, so the normalisation is the record's.
- L222's $G_x$ is computed from the same $Q$ ($\nu^2$ giving $x_a^2$ at $ja,ka$, $\nu^\#$ giving $2x_ax_b$ and $-\lVert x\rVert^2$). There is no factor of $2$ between the two squares. The item 3 screen checks both squares against a full $Q$ built from $\mathfrak{so}(n)$ structure constants.
- $G_z$ is linear in $zz^{\mathsf T}$ entrywise ($z_a^2$, $\operatorname{tr}zz^{\mathsf T}$, $z_az_b$), so $G_y+G_x=\mathcal G(yy^{\mathsf T}+xx^{\mathsf T})$.

### Item 3, the cubic: CONFIRMED

Expansion of $T(W,W,W)$, $W=E+D+\nu$ with $D=D^-_y$, $T$ totally symmetric:

| term | coefficient | $D$-count | $\nu$-count | fate |
|---|---|---|---|---|
| $P(E)$ | 1 | 0 | 0 | kept |
| $P(D)$ | 1 | 3 | 0 | swap |
| $P(\nu)$ | 1 | 0 | 3 | flip at $j$ |
| $T(E,E,D)$ | 3 | 1 | 0 | swap |
| $T(E,E,\nu)$ | 3 | 0 | 1 | flip at $j$ |
| $T(E,D,D)$ | 3 | 2 | 0 | kept |
| $T(E,\nu,\nu)$ | 3 | 0 | 2 | kept |
| $T(D,D,\nu)$ | 3 | 2 | 1 | flip at $j$ |
| $T(D,\nu,\nu)$ | 3 | 1 | 2 | swap |
| $T(E,D,\nu)$ | 6 | 1 | 1 | either |

- **Swap.** $\sigma\in O(n)$ and conjugation by any orthogonal matrix (determinant $-1$ included) is an automorphism of $\mathfrak{so}(n)$, so $Q(\sigma W)=\sigma Q(W)$ and $T$ is $\sigma$-invariant. $\sigma E=E$, $\sigma\nu=\nu$, $\sigma D=-D$ kill every odd-$D$ term.
- **Character.** The flip $\operatorname{diag}(\dots,-1_j,\dots)$ fixes every diagonal tensor and sends $\nu\mapsto-\nu$ (it negates $e_{ja}$ and fixes $e_{ka}$). That is the $\varepsilon_j\varepsilon_k$ character evaluated at a group element where it is $-1$, which is what the proof cites.
- **Total symmetry.** On the record by L24's argument (quoted in support-dichotomy.md), and $T(E,D,D)=\langle E,D\circ D\rangle=\langle E,G_y\rangle$, $T(E,\nu,\nu)=\langle E,G_x\rangle$.
- **Screen, not evidence.** A script in the scratchpad built $Q=W^2+W^\#$ on full $\binom n2$-square matrices from $\mathfrak{so}(n)$ structure constants (with the $\mathrm{id}^\#=(n-2)\mathrm{id}$ assertion passing), and at $(n,j,k)=(5,0,1),(6,1,4),(6,0,5)$ with random swap-even $E\in\mathcal D_n$ and random centred $y,x$: $\max\lvert Q(D^-_y)-G_y\rvert\le2\times10^{-16}$, $\max\lvert Q(\nu_x)-G_x\rvert\le2\times10^{-16}$, and $P(W)-P(E)-3\langle E,G_y+G_x\rangle$ at most $7\times10^{-15}$ against values of order $10$. It found nothing to report against the hand derivation.

### Item 4, rank one: CONFIRMED

- $q_E(z)=\langle E,G_z\rangle$ is a quadratic form (entries of $G_z$ are quadratic in $z$) on the $(n-3)$-dimensional space $\{\sum z=0\}$, with Euclidean norm. Its top eigenvalue $\lambda$ satisfies $q_E(z)\le\lambda\lVert z\rVert^2$ for every $z$, whatever the sign of $\lambda$, so $q_E(y)+q_E(x)\le\lambda s$.
- $W'=E+D^-_{\sqrt sz_*}$ is diagonal, lies in $\mathcal D_n$ since $\sum z_*=0$, and has $\lVert W'\rVert^2=\lVert E\rVert^2+2s=1$. The step 3 identity at $x=0$ gives $P(W')=P(E)+3\lambda s$.
- **L57 applies to every unit diagonal tensor**, as its statement says. The quoted proof runs at critical points $Q(S)=\lambda S$, and the extension is standard and holds here: $Q(\mathcal D_n)\subset\mathcal D_n$ (a $\Gamma$-fixed tensor has a $\Gamma$-fixed square), so the gradient of $P$ restricted to $\mathcal D_n$ is $Q(S)$ itself, and the maximum over the compact unit sphere of $\mathcal D_n$ is a critical point in that sense.
- At $n=4$ the space is a line and $q_E=\lambda\lVert z\rVert^2$ identically. Nothing changes.

### Item 5, equality: CONFIRMED

- $P(W)=\Theta_n$ and the chain $P(W)\le P(W')\le\Theta_n$ force $P(W')=\Theta_n$ and $q_E(y)+q_E(x)=\lambda s$, hence each summand equal to its bound (Lean two_columns_eq).
- **$\lambda>0$.** At $s>0$, $\lVert E\rVert^2=1-2s<1$ and L57 with homogeneity gives $P(E)\le\Theta_n\lVert E\rVert^3<\Theta_n$ (also when $E=0$). So $3\lambda s=\Theta_n-P(E)>0$.
- **L57's equality in coordinates.** $W'$ is a unit diagonal tensor attaining $\Theta_n$, so by L57's equality case (its proof forces the two-valued $v$ and $S\parallel Z(v)$) its vertex matrix is block-constant on a coordinate partition into sizes $\lfloor n/2\rfloor,\lceil n/2\rceil$, at odd $n$ included.
- **Different blocks.** If $j,k$ share a block, $\sigma$ preserves the partition and $B'$ is swap-even, contradicting the nonzero odd part $D^-_{\sqrt sz_*}$. So $j\in A$, $k\in B$.
- **$q_E=q_{B'}$.** $G_z$ is swap-even and $D^-$ is swap-odd, so $\langle D^-,G_z\rangle=0$.
- **The rank-one form, recomputed with $A'=A\setminus\{j\}$, $B''=B\setminus\{k\}$, blocks of any sizes.** Summing $K_{pq}(G_z)_{pq}$ over unordered pairs: pairs $(j,a)$ give $\alpha_A\sum_{A'}z^2+\gamma\sum_{B''}z^2$, pairs $(k,a)$ give $\gamma\sum_{A'}z^2+\alpha_B\sum_{B''}z^2$, pair $(j,k)$ gives $-\gamma\lVert z\rVert^2$, pairs inside $A'$ give $\alpha_A\big(S_A^2-\sum_{A'}z^2\big)$, inside $B''$ give $\alpha_B\big(S_B^2-\sum_{B''}z^2\big)$, across give $2\gamma S_AS_B$. The quadratic diagonal terms cancel exactly, leaving $\alpha_AS_A^2+\alpha_BS_B^2+2\gamma S_AS_B=(\alpha_A+\alpha_B-2\gamma)S_A^2$ with $S_B=-S_A$. This is Lean block_form term for term. Unbalanced blocks at odd $n$ change nothing, since the cancellation is per coordinate.
- **The eigenspace.** Blocks have size at least $2$ at $n\ge4$, so $A'$ and $B''$ are nonempty and $\bar u\ne0$. On $\{\sum z=0\}$, $S_A=\langle\bar u,z\rangle$, so $q=c\langle\bar u,z\rangle^2$. With $\lambda>0$, $c>0$ is forced and the $\lambda$-eigenspace is exactly the line of $\bar u$. Equality $q(y)=\lambda\lVert y\rVert^2$ is equality in Cauchy-Schwarz, so $y$ and $x$ both lie on that line and $z_*=\pm\hat u$.
- **The rotation.** From $\xi\cdot W=[\Lambda^2\xi,W]$ on the $\{ja,ka\}$ block with $\Lambda^2\xi=\begin{pmatrix}0&-1\\1&0\end{pmatrix}$: a diagonal block $\operatorname{diag}(d_1,d_2)$ goes to off-diagonal $d_1-d_2$, and the off-diagonal block with entry $x$ goes to $\operatorname{diag}(-2x,2x)$. $\Lambda^2\xi$ kills $e_{jk}$ and every $e_{ab}$. So $\xi\cdot E=0$, $\xi\cdot D^-_u=\nu_{2u}$, $\xi\cdot\nu_u=D^-_{-2u}$, and on $aD^-_{\hat u}+b\,\nu_{\hat u}$ the generator is $(a,b)\mapsto(-2b,2a)$, rotation at speed $2$. Hence $e^{\varphi\xi}\cdot(E+D^-_{\sqrt s\hat u})=E+\sqrt s\big(\cos2\varphi\,D^-_{\hat u}+\sin2\varphi\,\nu_{\hat u}\big)$, which is $W$ at $2\varphi=\psi$. The sign of $z_*$ is absorbed into $\psi$.
- **Converse.** $P$ is $O(n)$-invariant and $\mathcal S_{jk}$ is preserved by $(j,k)$-rotations (L222 item 1), so every $e^{\varphi\xi}\cdot B$ is a unit element of $\mathcal S_{jk}$ with value $\Theta_n$.

### Item 6, scope and What it gives: PLAUSIBLE

- **$n\ge4$ suffices everywhere.** Used: blocks of size at least $2$ (so $A',B''\ne\emptyset$), L57 at $n\ge4$, and $\dim\{\sum z=0\}=n-3\ge1$. Nothing in steps 1 to 5 uses criticality.
- **Repair (a): the conclusion is vacuous at $4\le n\le11$ and should say so.** conventions.md records $M(n)\ge\sqrt{3/2}$ at every $n\ge4$ (padded $W_{\mathbb{CP}^2}$). $\Theta_n^2<\tfrac32$ reduces to $n^2-12n+8<0$ at even $n$ (so $n\le10$) and to $n^2-13n+18<0$ at odd $n$ (so $n\le11$), with $\Theta_{11}^2=\tfrac{40}{27}$ and $\Theta_{12}^2=\tfrac{55}{36}$ bracketing $\tfrac32$. At those $n$, L224 gives that **no global maximiser lies in any $\mathcal S_{jk}$**, and the sentence "has value at least $\Theta_n$ by H1, hence exactly $\Theta_n$, and is a rotation of an L57 maximiser" describes an empty set. At $n\ge12$ the sentence is a conditional whose hypothesis forces $M(n)=\Theta_n$. Suggested wording: *a unit global maximiser lies in no $\mathcal S_{jk}$ unless $M(n)=\Theta_n$, and then it is a $(j,k)$-rotation of an L57 maximiser. At $4\le n\le11$, where $M(n)\ge\sqrt{3/2}>\Theta_n$, no global maximiser lies in any $\mathcal S_{jk}$.* The logic as written is valid, so this is wording.
- **Repair (b): global maximisers only.** plan.md states I104's pair-block theorem for *every local maximiser at its minimising $(j,k)$-angle*, and its I104 line now reads "PAIR-BLOCK STRATUM DERIVED CLOSED". L224 bounds values, so it says nothing about a local maximiser of value below $\Theta_n$ inside $\mathcal S_{jk}$. The What it gives sentence says "closes for global maximisers", which is right, but "the small-$\nu$ reduction of the gap note and L223's use there are not needed for this stratum" holds only for the global reading. The plan line should carry "for global maximisers".
- **Minor.** "peaks at rank one, which is a diagonal tensor": a rank-one Gram matrix is attained both by $E+D^-_z$ and by $E+\nu_z$, so the peak can be *chosen* diagonal. The proof uses exactly that choice.

### Item 7, counterexample hunt: CONFIRMED (none found)

The falsifier is a unit $W\in\mathcal S_{jk}$ with $P(W)>\Theta_n$, necessarily at $4\le n\le11$ against $\sqrt{3/2}$ or anywhere against a larger value.

- **$\mathcal S_{jk}$ is the fixed space of the $n-2$ coordinate reflections $\varepsilon_a$, $a\notin\{j,k\}$.** An entry $(pq,rs)$ carries the character $\varepsilon_p\varepsilon_q\varepsilon_r\varepsilon_s$, trivial on all those reflections exactly when $\{p,q\}\triangle\{r,s\}\subseteq\{j,k\}$. That leaves $\mathcal D_n$ and $V_{jk}$, since a four-set block has two indices outside $\{j,k\}$ and a pair block $V_{ab}\ne V_{jk}$ has one. (Odd characters like $\varepsilon_j$ alone do not occur, a symmetric difference of two pairs having even size.)
- **Padded $W_{\mathbb{CP}^2}$ in any frame.** Its image is $\Lambda^2U$ for a $4$-plane $U$. A reflection $r_e$ fixing it must preserve $\Lambda^2U$, so $e\in U$ or $e\perp U$. For $e\in U$, $r_e$ reverses orientation on $U$ and exchanges $\Lambda^2_\pm U$, carrying $W^+\ne0$, $W^-=0$ to a tensor with $W^+=0$, so it is not fixed. So at most $n-4$ mutually orthogonal reflections fix it, fewer than the $n-2$ that membership in some rotated $\mathcal S_{jk}$ needs. The structured candidate never meets the subalgebra, in agreement with L224.
- **Padded products with $j,k$ in the padding.** Diagonal with value $\theta_{p,q}\le\Theta_{n-2}<\Theta_n$ ($\Theta_n^2$ increasing in $n$ within each parity, and $\Theta_{n-2}\le\theta_0(n-2)<\theta_0(n)$). Adding $\nu$ is covered by the proof. The recorded post F48 witness, padded $S^6\times S^6$ at $n=14$ with the padding pair, has pair-block eigenvalue $\tfrac6{11}\theta>\tfrac\theta2$, so it ascends inside $\mathcal S_{jk}$, but it starts at $\Theta_{12}=1.2360$ against $\Theta_{14}=1.2617$, so the ascent has room and contradicts nothing.
- **Rank-two Gram at the balanced product.** With $j,k$ in different blocks $q_E$ has rank one (item 5), so any rank-two $C$ strictly loses unless both columns lie on $\bar u$. With $j,k$ in the same block the same expansion gives $q=c\big(S_A^2-\sum_{a\in B}z_a^2\big)$ with $S_A$ summed over $A\setminus\{j,k\}$, and step 4 still bounds it by $\lambda s$. Neither case produces a value above $P(W')$.

### Item 8, record: CONFIRMED

- **On the record in substance.** Step 3 is Lemma L219's split $P(W)=P(b)+3\langle L_bc,c\rangle$ (holding at every $W$, Gate 2 passed) applied twice: at the reflection in $e_j$ with $b=E+D^-$, $c=\nu$, giving $P(E+D^-)+3\langle E,G_x\rangle$ (the $D^-$ part drops by swap parity), then at the reflection in $e_j-e_k$ with $b=E$, $c=D^-$, giving $P(E)+3\langle E,G_y\rangle$. L224 cites neither L219 nor route R26, and the first bullet of item 7 shows L224 is R26's statement at $n-2$ reflections. Citing L219 would shorten step 3 and tie L224 to its route.
- **"Rank one" elsewhere.** second-order.md's other rank-one mentions (the square bound near line 718, the refuted rank-one split on the pair clause near lines 1152 and 1308) concern different quantities, so no duplicate.
- **No contradicting value.** The pair-block note's $\theta^2\le\tfrac97$ for critical points in $\mathcal S_{jk}$ with even part $\tfrac\theta{\sqrt3}\hat g$ is an upper bound, as is L224's $\theta=P(W)\le\Theta_n$ for every critical point in $\mathcal S_{jk}$, so the two cannot conflict. L224 is the sharper of the two at $4\le n\le7$, where $\Theta_n^2\in\{\tfrac34,\tfrac89,\tfrac{10}9,\tfrac65\}$ lies below $\tfrac97$, and the note's bound is the sharper at $n\ge8$ for that special configuration. Its chain slacks are slacks, not values. INDEX-results row 224 matches the lemma.

## Claim B, Lemma L223

### Item 9, step 1: CONFIRMED

- The matrix identity is $S^{\circ2}+S^2=\lambda S+E+\operatorname{diag}(r)$, $r_i=\sum_js_{ij}^2$. Pairing with $vv^{\mathsf T}$: $\sum_{i\ne j}s_{ij}^2v_iv_j+\mu^2=\lambda\mu+v^{\mathsf T}Ev+\sum_ir_iv_i^2$, and $\sum_{i<j}s_{ij}^2(v_i-v_j)^2=\sum_ir_iv_i^2-\sum_{i\ne j}s_{ij}^2v_iv_j$ gives $\lambda\mu+v^{\mathsf T}Ev=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$. The sign of $E$ is as stated.
- $\sum_{i<j}s_{ij}(v_i-v_j)^2=\sum_iv_i^2(\text{row sum})-v^{\mathsf T}Sv=-\mu$ and $\sum_{i<j}(v_i-v_j)^2=n\lVert v\rVert^2-(\sum v)^2=n$, using $v\perp\mathbf1$ (automatic: $\mu>0$ since $\operatorname{tr}S=0$, $S\ne0$, and $\mathbf1$ has eigenvalue $0$). Cauchy-Schwarz gives $\eta_1\ge0$, and dividing by $\mu>0$ gives the displayed inequality with $-v^{\mathsf T}Ev\le e_-$.
- The hypothesis $E\in\mathcal D_n$ is automatic, since $Q(\mathcal D_n)\subset\mathcal D_n$.

### Item 10, step 2: CONFIRMED

- $v^{\mathsf T}Sv=2\sum_{i<j}s_{ij}v_iv_j=2\langle S,(v_iv_j)\rangle=2\langle S,Z(v)\rangle$ by the projection property. $\mu>0$ forces $Z(v)\ne0$ and $\cos\alpha>0$.
- $\sum_{i<j}v_i^2v_j^2=\tfrac12(1-\sum v^4)$, $\sum_{i<j}(v_i^3v_j+v_iv_j^3)=\sum_iv_i^3(\sum v-v_i)=-\sum v^4$, $\sum_{i<j}v_iv_j=-\tfrac12$. Total $\tfrac12-\big(\tfrac12+\tfrac1{n-2}\big)\sum v^4+\tfrac1{2(n-1)(n-2)}$, constant $\frac{(n-1)(n-2)+1}{2(n-1)(n-2)}=\frac{n^2-3n+3}{2(n-1)(n-2)}$, coefficient $-\frac n{2(n-2)}$.
- Substituting $\sum v^4=\tfrac1n+\eta_3$: constant minus $\frac1{2(n-2)}$ is $\frac{(n-2)^2}{2(n-1)(n-2)}=Z_*^2$.
- $\tfrac{n-1}n\cdot2\sqrt{\tfrac{n-2}{2(n-1)}}=\tfrac1n\sqrt{2(n-1)(n-2)}=\bar\Theta$.

### Item 11, step 3: CONFIRMED

- $\langle S\circ S,S\rangle=\sum_{i<j}(s_{ij}^2+(S^2)_{ij})s_{ij}=\tfrac12\sum_{i\ne j}s_{ij}^3+\tfrac12\operatorname{tr}S^3$, the second because $s_{ii}=0$.
- $2s_{ij}=(e_i+e_j)^{\mathsf T}S(e_i+e_j)\le2\mu$. Then $s^3\le\mu s^2$ for every real $s\le\mu$ (it is $s^2(\mu-s)\ge0$), so $\tfrac12\sum_{i\ne j}s_{ij}^3\le\tfrac12\mu\cdot2=\mu$. $\operatorname{tr}S^3=\sum\lambda_i^3\le\mu\sum\lambda_i^2=2\mu$. Total at most $2\mu$.
- $\langle S\circ S,S\rangle=\lambda+\langle E,S\rangle\ge\lambda-\lvert E\rvert$ with $\lvert S\rvert=1$ in the unordered norm.
- $e_-\le\lVert E\rVert_{\mathrm{op}}\le\lVert E\rVert_{F,\text{ordered}}=\sqrt2\lvert E\rvert$. With $\mu\ge(\lambda-\lvert E\rvert)/2>0$ this gives item 1's bound $2\sqrt2\lvert E\rvert/(\lambda-\lvert E\rvert)$.
- Item 2's three bounds: $1-\cos\alpha\le1-r\cos\alpha$ needs $\cos\alpha\ge0$, which holds. $1-r\le1-r\cos\alpha$ needs $r\ge0$. $\eta_1\le\mu\Delta$ is $\eta_1/\mu\le\Delta$ times $\mu>0$. All match Lean chain_defects, including its $0\le c$ hypothesis.

### Item 12, steps 4 and 5: PLAUSIBLE

Confirmed:

- $\eta_3=\tfrac{2(n-2)}nZ_*^2(1-r^2)=\tfrac{(n-2)^2}{n(n-1)}(1-r^2)\le\tfrac{2(n-2)^2}{n(n-1)}\tfrac\Delta{\bar\Theta}$ via $1-r^2\le2(1-r)$.
- $\big\lvert\lvert a\rvert-c\big\rvert\le\lvert a^2-c^2\rvert/c$ at $c=n^{-1/2}$, so $\lVert v-w\rVert^2\le n\eta_3$. $\lvert\sum w\rvert=\lvert\sum(w-v)\rvert\le\sqrt n\lVert v-w\rVert$.
- **Lipschitz.** $\lVert vv^{\mathsf T}-ww^{\mathsf T}\rVert_F^2=2(1-\langle v,w\rangle^2)=\lVert v-w\rVert^2(1+\langle v,w\rangle)\le2\lVert v-w\rVert^2$ at unit $v,w$, and the unordered off-diagonal norm squared is at most half of that. Projection onto $\mathcal D_n$ is non-expansive in the unordered inner product.
- **Invariance.** $\Pi$ commutes with $S_n$, so $\Pi(ww^{\mathsf T})$ is constant on the three pair classes. Row sums give $(p-1)a+qc=0$, $(q-1)b+pc=0$: a line of solutions at $p,q\ge2$ (the product vertex matrix), and only $0$ at $p=1$ or $q=1$ ($c=0$ then $b=0$). At $p=0$ the matrix is constant, of residual form, and projects to $0$. So $\Pi(ww^{\mathsf T})\ne0$ forces $p,q\ge2$.
- **Nonvanishing.** $\lVert v-w\rVert\le\sqrt{2(n-2)^2/(n-1)}\sqrt\delta$ and $\lvert Z\rvert\ge Z_*(1-\delta)$ with $\delta=\Delta/\bar\Theta$, and $\sqrt{2(n-2)^2/(n-1)}/Z_*=2\sqrt{n-2}$, so the hypothesis is exactly $\lVert v-w\rVert<\lvert Z\rvert$, giving $\lvert Z-\Pi\rvert<\lvert Z\rvert$.
- **Constant and sign.** $\lvert S-\hat Z\rvert=\sqrt{2-2\cos\alpha}\le\sqrt2\sqrt\delta$, and Lean unit_diff_le gives $\lvert\hat Z-B\rvert\le2\lVert v-w\rVert/\lvert Z\rvert\le4\sqrt{n-2}\sqrt\delta/(1-\delta)$. $B$ is the positive normalisation of $\Pi$, matching $\hat Z$'s positive normalisation, so the triangle inequality is consistent. The statement's "up to sign" is accurate.

The defect:

- **$w=\operatorname{sign}(v)/\sqrt n$ is not unit when some $v_i=0$** under the usual $\operatorname{sign}(0)=0$. Then $p+q<n$, step 5's "for unit $v,w$" fails, and $\Pi(ww^{\mathsf T})$ is constant on more than three classes, so it is not a sphere product's vertex matrix on $n$ indices. The hypothesis of item 4 does not exclude a zero coordinate by the lemma's own bounds: a zero gives $\eta_3\ge n^{-2}$, while the hypothesis forces only $\delta<\frac1{4(n-2)}$ and so $\eta_3<\frac{n-2}{2n(n-1)}$, and $n^{-2}<\frac{n-2}{2n(n-1)}$ at every $n\ge4$.
- **Repair.** Define $w_i=+n^{-1/2}$ at $v_i=0$ (either fixed sign works). Every inequality survives: at $v_i=0$, $\lvert v_i-w_i\rvert=n^{-1/2}=\sqrt n\lvert v_i^2-\tfrac1n\rvert$, $w$ is unit, and $p+q=n$.

### Item 13, scope: CONFIRMED

- **$n=4$.** All denominators $n-2$, $n-1$ are nonzero, and item 4 forces $p=q=2$. Nothing breaks.
- **$\ker S\ne0$.** Always true ($S\mathbf1=0$) and never used. The proof needs only $\mu>0$, which holds.
- **Odd $n$, a floor.** The proof uses $\sum v^4\ge\tfrac1n$ where L57 uses the odd bound, so $\bar\Theta>\Theta_n$ and at every exact critical point ($E=0$, $\lambda\le\Theta_n$) $\Delta\ge\bar\Theta-\Theta_n>0$. So at odd $n$ the radius bound never falls below roughly $4\sqrt{n-2}\sqrt{(\bar\Theta-\Theta_n)/\bar\Theta}$, of order $n^{-1}$. Item 4's hypothesis still holds at the exact odd maximiser ($\delta\approx0.0377$ at $n=5$ gives $1.35<1.92$, $\delta\approx0.0101$ at $n=7$ gives $0.90<1.98$, hand arithmetic). The statement is correct and claims nothing sharper. What it gives ("radius $O(\sqrt{n\Delta})$") is accurate but would be clearer with the odd-$n$ floor stated.
- **What it gives, second sentence.** "closed outright by L224" inherits item 6's repair (b): L224 closes the global-maximiser reading only.

## Lean

- **L224Statement.lean: CONFIRMED as scalar cores.** two_columns_le/eq, pair_value_le and sub_lt_of_mass are the scalar inequalities of steps 4 and 5 with consistent, non-vacuous hypotheses (the closing example instantiates pair_value_le). block_form is exactly the expansion of $q_{B'}$ in item 5, with $\alpha\oplus\beta$ standing for $A'\sqcup B''$. Steps 1 to 3 (the tensor calculus), the L57 application and the rotation are outside the file, as "polynomial cores" says.
- **L223Statement.lean: PLAUSIBLE.** Z_norm_sq proves $\sum_{i\ne j}Z_{ij}v_iv_j=2\big(\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v^4\big)$ with $n$ a free real, uncoupled from Fintype.card. By hand the identity holds at every real $n>3$ (the double sum is $1$ independently of $n$). So it checks the pairing $\langle Z(v),(v_iv_j)\rangle$, and the step $\lvert Z(v)\rvert^2=\langle Z(v),(v_iv_j)\rangle$, the only place $n$ must be the dimension, rests on L57's paper projection proof. The record's "including L57's norm formula for $Z(v)$" should read "the pairing that gives the norm formula once $Z(v)$ is the projection". The remaining declarations match their uses. balanced_split and theta_gap_odd are not used by L223 as stated. No vacuous hypotheses.
