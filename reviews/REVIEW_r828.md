# r828: Gate 2 on r826 §6, the collapse of the one-dimensional stabiliser case, and a closure of the case it left untouched

*Cold brief. I was given [r826](REVIEW_r826.md) §6 verbatim and read [r826](REVIEW_r826.md) in full together with [findings/diagonal-half.md](../findings/diagonal-half.md)'s section on the rank-three support question, and nothing else of the record. [r824](REVIEW_r824.md) was outside my permitted reading, so the one step of the claim that cites it is re-derived here from the objects rather than taken on citation. **The programme is on an analysis-only footing. I ran no computation, not even a screen**: every bracket, spectrum, trace and inequality below was worked by hand. Log: [agent_logs/g2-dim1-r828.log](../agent_logs/g2-dim1-r828.log).*

| Item | Verdict |
|---|---|
| **1**: the enumeration of $\mathfrak z(X)$, $X\in\mathfrak{so}(6)$, is exhaustive | **CONFIRMED**, by an independent derivation. Exactly four shapes at dimensions $3,5,7,9$, and the four bullets meet all four. §5.5's list omits the pattern $(c,d,d)$, which is the same shape as $(c,c,d)$, so nothing is missing |
| **2**: the $\mathfrak t^3$ bullet | **CONFIRMED.** $\dim U=3=\dim\mathfrak z(X)$ is what is used, and $\mathfrak z(\mathfrak t^3)=\mathfrak t^3$ holds because no root vanishes on a full Cartan |
| **3**: the $\mathfrak k$ bullet, *"§5 applies verbatim"* | **CONFIRMED.** §5.1 to §5.4 use only $U\subseteq\mathfrak k$, orthonormality and the weight conditions. §5.5's reduction paragraph is the sole place $\dim\mathfrak z(U)=2$ enters, and it is exactly the paragraph this bullet does not need |
| **4**: the $7$-dimensional bullet | **CONFIRMED**, every step. Constraint list complete with one implied redundancy, Sylvester right, **the case split IS exhaustive**, and the appeal to §5.4's lemma legitimate at the objects used. **Two cosmetic defects**: $\mathcal V\mathcal V^{\mathsf T}$ should read $\mathcal V^{\mathsf T}\mathcal V$, and the citation of another report for the $\mathop{\mathrm{rank}}\mathcal U=0$ branch is unnecessary, that branch being §5.4's own lemma at $\gamma=1$ |
| **5**: the representatives $(c,0,0)$ and $(c,c,c)$ | **CORRECT**, and the argument depends only on the conjugacy class, the constraints being $O(6)$-equivariant |
| **6**: scope | Every bullet is **genuinely six-dimensional**, the $\mathfrak k$ block computation alone being dimension-free. The final sentence is **EARNED** on the givens, and is now **SUPERSEDED** by §7 below |
| **7**: the untouched $\mathfrak u(3)$ case | **IT CLOSES.** First Bianchi reads $\sum_i\lambda_i\mathop{\mathrm{adj}}(M_i)=0$, it is an **extra** condition, and it forces every $\mathop{\mathrm{tr}}A_i=0$. Ricci then forces $M_1^2=M_2^2=M_3^2$, and every solution of that has $\dim V=4$. **So $\mathfrak u(3)$ is empty at $\dim V=6$** |
| **8**: falsifiers | Named for each claim I record, and none found. Nothing withdrawn |

**One line.** *Every bullet of §6 stands as written, with two typographical repairs and one needless citation, and the case it declared untouched closes by hand: first Bianchi in $\mathfrak u(3)$ says $\sum_i\lambda_i\mathop{\mathrm{adj}}(M_i)=0$, which forces all three matrices traceless, after which Ricci is a triangle-inequality equality case forcing equal squares and every survivor has four-dimensional support. **The conclusion is therefore not "$\mathfrak z(U)=0$ or $\mathbb RJ$" but "$\mathfrak z(U)=0$": at $\dim V=6$ a solution has trivial stabiliser algebra.***

## 1. Conventions, fixed before anything is derived

$\Lambda^2\mathbb R^6\cong\mathfrak{so}(6)$, a $2$-form being a real skew $6\times6$ matrix, with $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ and the bracket the commutator. With $E_{ab}=e_ae_b^{\mathsf T}-e_be_a^{\mathsf T}$ the assignment $e^{ab}\mapsto E_{ab}$ is an isometry onto an orthonormal basis, since $\langle E_{ab},E_{ab}\rangle=\tfrac12\cdot2=1$.

A **rank-three Weyl tensor** is $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$ with $\omega_1,\omega_2,\omega_3$ orthonormal, every $\lambda_i\neq0$, $\sum_i\lambda_i=0$, **Ricci** $\sum_i\lambda_i\omega_i^2=0$ in $S^2\mathbb R^6$ and **first Bianchi** $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ in $\Lambda^4\mathbb R^6$. $U=\mathop{\mathrm{span}}(\omega_i)$, $\mathfrak z(U)$ its centraliser, $V$ the common support, $\Lambda=\mathop{\mathrm{diag}}(\lambda_1,\lambda_2,\lambda_3)$.

Three normalisations are used repeatedly and each is checked once here.

- A unit self-dual $\omega$ on a $4$-plane $P$ has $\omega^2=-\tfrac12\Pi_P$. Check on $\omega=(E_{12}+E_{34})/\sqrt2$: the two blocks are disjoint so $E_{12}E_{34}=0$, and $E_{12}^2+E_{34}^2=-\Pi_P$, giving $-\tfrac12\Pi_P$ after the $\tfrac12$.
- On $P\cong\mathbb H$, $\Lambda^+P$ is the left multiplications and $\Lambda^-P$ the right ones, normalised as $L_p/\sqrt2$ and $R_v/\sqrt2$ so that the norm of the form is $\lvert p\rvert$ or $\lvert v\rvert$. Indeed $\mathop{\mathrm{tr}}(L_p^{\mathsf T}L_p)=\mathop{\mathrm{tr}}(-L_p^2)=4\lvert p\rvert^2$, so $\lVert L_p/\sqrt2\rVert^2=\lvert p\rvert^2$.
- For unit $\alpha\in\Lambda^+P$ and unit $b\in\Lambda^-P$: $\alpha\wedge\alpha=\mathrm{vol}_P$, $b\wedge b=-\mathrm{vol}_P$, $\alpha\wedge b=0$. Check on $(e^{12}\pm e^{34})/\sqrt2$ directly.

At $\dim V=6$ the star gives $\Lambda^4\cong\Lambda^2$, and $\mathop{\mathrm{Padj}}(\omega)=\tfrac12\star(\omega\wedge\omega)$ sends $\omega=\sum_jc_j\varepsilon_j$ in normal form to $c_2c_3\varepsilon_1+c_1c_3\varepsilon_2+c_1c_2\varepsilon_3$. Bianchi is then $\sum_i\lambda_i\mathop{\mathrm{Padj}}(\omega_i)=0$, $\star$ being an isomorphism.

## 2. Hypothesis inventory

What every argument below is allowed to use, and where each is spent.

| Hypothesis | Spent where |
|---|---|
| $\omega_1,\omega_2,\omega_3$ orthonormal, hence linearly independent | §4 the Gram identity, §5 the Sylvester bound, **§7 the step that forces $\mathop{\mathrm{tr}}A_i=0$** |
| $\sum_i\lambda_i=0$ and every $\lambda_i\neq0$ | §5 the Witt index, §7 the trace identity and the equality case |
| Ricci $\sum_i\lambda_i\omega_i^2=0$ | everywhere |
| First Bianchi $\sum_i\lambda_i\omega_i\wedge\omega_i=0$ | §5 the two cross equations and the $\mathrm{vol}$ equation, §7 the traceless forcing |
| $\dim V=6$ | §3 the ambient identification, §5 and §7 the final contradictions only |
| $\dim\mathfrak z(U)=1$, i.e. $\mathfrak z(U)=\mathbb RX$ with $X\neq0$ | §3 alone, to produce $U\subseteq\mathfrak z(X)$. **§7 does not use it** |
| **Given**: every triple with $\dim\mathfrak z(U)\ge3$ is excluded | the final assembly only |
| **Given**: no solution has $\dim\mathfrak z(U)=2$, at any $\dim V$ | the final assembly only |

One reading has to be fixed for the whole to make sense. $\mathfrak z(U)$ is the centraliser inside $\mathfrak{so}(V)$, and the claim's "$\dim V=6$" therefore means the ambient is $V$ itself. Inside a larger $\mathbb R^n$ the centraliser would contain $\mathfrak{so}(V^\perp)$ and every dimension in §3 would shift. This is the reading the claim needs and it should be written into any statement lifted from it.

## 3. Item 1, the enumeration, derived rather than quoted

Let $X\in\mathfrak{so}(6)$ be nonzero. Its normal form is $c_1J\oplus c_2J\oplus c_3J$ on three orthogonal planes, $c_1\ge c_2\ge c_3\ge0$, the signs being absorbable by an orthogonal conjugation inside one plane.

Group $\mathbb R^6$ into the isotypic pieces of $X$. Let the distinct nonzero values among the $c_j$ be $d_1>d_2>\dots$ with multiplicities $m_1,m_2,\dots$, and let $m_0$ be the multiplicity of $0$, so $\ker X$ has real dimension $2m_0$. On the sum of the blocks carrying one nonzero $d$, $X$ acts as $d$ times a complex structure, and the commutant of a complex structure in $\mathfrak{so}(2m)$ is $\mathfrak u(m)$. A skew map commuting with $X$ preserves each isotypic piece and has no component between pieces with different $d$, because such a component would intertwine $X$-actions with different eigenvalues. On $\ker X$ every skew map commutes. Hence
$$\mathfrak z(X)=\mathfrak u(m_1)\oplus\mathfrak u(m_2)\oplus\dots\oplus\mathfrak{so}(2m_0),\qquad \dim=\textstyle\sum_r m_r^2+m_0(2m_0-1).$$

At $n=3$ the patterns and their centralisers are these, and the list is complete because it is a list of partitions.

| Pattern of $(c_1,c_2,c_3)$ | $\mathfrak z(X)$ | $\dim$ |
|---|---|---|
| $c_1>c_2>c_3>0$ | $\mathfrak u(1)^3=\mathfrak t^3$ | $3$ |
| $c_1>c_2>0$, $c_3=0$ | $\mathfrak u(1)\oplus\mathfrak u(1)\oplus\mathfrak{so}(2)=\mathfrak t^3$ | $3$ |
| $c_1=c_2>c_3>0$, or $c_1>c_2=c_3>0$ | $\mathfrak u(2)\oplus\mathfrak u(1)=\mathfrak k$ | $5$ |
| $c_1=c_2>0$, $c_3=0$ | $\mathfrak u(2)\oplus\mathfrak{so}(2)=\mathfrak k$ | $5$ |
| $c_1>0$, $c_2=c_3=0$ | $\mathfrak{so}(2)\oplus\mathfrak{so}(4)=\Lambda^2Q\oplus\Lambda^2Q^\perp$ | $7$ |
| $c_1=c_2=c_3>0$ | $\mathfrak u(3)$ | $9$ |

**So the four shapes used are exactly the four that exist, and item 1 is CONFIRMED.** Three remarks a reader is owed.

- §5.5's own list writes the $5$-dimensional row as $(c,c,d)$ and $(c,c,0)$ and does not name $(c,d,d)$. That pattern occurs and is a distinct conjugacy class of $X$, but its centraliser is the same shape, the $\mathfrak u(2)$ sitting on the last two blocks rather than the first two. Nothing is missing, and the omission is worth repairing in any version of the list that is recorded.
- The two $5$-dimensional rows give the **same subalgebra**, not merely isomorphic ones: both are $\mathfrak u(2)_P\oplus\Lambda^2P^\perp$ for a $4$-plane $P$, which is r826 §4.3's $\mathbb Ra\oplus\Lambda^-P\oplus\mathbb R\varepsilon$ with $\mathbb Ra$ the centre of $\mathfrak u(2)_P$ inside $\Lambda^+P$.
- The degenerate patterns are where a naive enumeration loses shapes, and they are the rows with $c_3=0$. Both are already in the table, and both collapse onto shapes the list already carries, because $\mathfrak{so}(2)=\mathfrak u(1)$.

The case $X=0$ gives $\mathfrak z(X)=\mathfrak{so}(6)$ and is unreachable here: $\mathfrak z(U)=\mathbb RX$ is one-dimensional, so $X\neq0$.

## 4. Items 2, 3 and 5: the two short bullets and the representatives

### 4.1 The $\mathfrak t^3$ bullet

The dimension argument is exactly $U\subseteq\mathfrak z(X)$ with $\dim U=3=\dim\mathfrak z(X)$, hence $U=\mathfrak t^3$. $\dim U=3$ is free: the $\omega_i$ are orthonormal, hence independent.

$\mathfrak z(\mathfrak t^3)=\mathfrak t^3$ holds. Complexifying, $\mathfrak z(\mathfrak a)_{\mathbb C}=\mathfrak t^3_{\mathbb C}\oplus\bigoplus_{\alpha\vert_{\mathfrak a}\equiv0}\mathfrak g_\alpha$ for any $\mathfrak a\subseteq\mathfrak t^3$, and no root of $D_3$ vanishes identically on the whole Cartan, a root being a nonzero functional on it. So $\mathfrak z(U)=\mathfrak t^3$ has dimension $3$, against the hypothesis $1$. **CONFIRMED.**

### 4.2 The $\mathfrak k$ bullet

The question the brief asks is whether §5's argument uses $\dim\mathfrak z(U)=2$. I re-derived §5.2 independently in the quaternionic model to be sure of what it consumes. With $\omega_i=\alpha_ia+m_i+c_i\varepsilon$, $a=L_j/\sqrt2$ and $m_i=R_{v_i}/\sqrt2$,
$$\omega_i^2=\Big[-\tfrac{\alpha_i^2+\lvert v_i\rvert^2}{2}\Pi_P+\alpha_iL_jR_{v_i}\Big]\oplus\big[-c_i^2\Pi_{P^\perp}\big],\qquad \omega_i\wedge\omega_i=(\alpha_i^2-\lvert v_i\rvert^2)\mathrm{vol}_P+2c_i(\alpha_ia+m_i)\wedge\varepsilon,$$
so Ricci contributes $1+3+1$ scalars and Bianchi $1+1+3$, giving
$$\alpha^{\mathsf T}\Lambda\alpha=0,\quad c^{\mathsf T}\Lambda c=0,\quad \alpha^{\mathsf T}\Lambda c=0,\quad M^{\mathsf T}(\Lambda\alpha)=0,\quad M^{\mathsf T}(\Lambda c)=0,$$
with $M$ the matrix whose rows are the $v_i$. This agrees with §5.2 line for line. **The inputs are $U\subseteq\mathfrak k$, orthonormality, $\sum_i\lambda_i=0$ and $\lambda_i\neq0$, and nothing else.** §5.3's Witt index and §5.4's rank-one lemma add nothing further. The single place $\dim\mathfrak z(U)=2$ appears in §5 is §5.5's reduction paragraph, which manufactures $U\subseteq\mathfrak k$ out of the hypothesis by way of toral, singular and $\mathfrak z(\mathfrak z(U))$. **That paragraph is exactly what the present bullet replaces**, since $\mathfrak z(X)=\mathfrak k$ hands it $U\subseteq\mathfrak k$ outright. So *"§5 applies verbatim"* is true when §5 is read as §5.1 to §5.4, and it would be false if §5.5's reduction were included. **CONFIRMED, with that reading made explicit.**

The conclusion $\alpha=c=0$ gives $U\subseteq\Lambda^-P$, and $\dim U=3=\dim\Lambda^-P$ gives $U=\Lambda^-P$. Its centraliser is $\Lambda^+P\oplus\Lambda^2P^\perp$ of dimension $4$, by the block split of $\mathfrak{so}(6)=\mathfrak{so}(P)\oplus\mathfrak{so}(P^\perp)\oplus(P\otimes P^\perp)$ with $\mathfrak{su}(2)$ centreless and $P\otimes P^\perp$ carrying no invariant vector. Dimension $4$, against the hypothesis $1$. **CONFIRMED.** Note the same conclusion also gives $\dim V=4$, so this branch dies twice over at $\dim V=6$.

### 4.3 Item 5, the representatives

$X=(c,0,0)$ is the general element of the only class whose centraliser has dimension $7$, and $\mathfrak z(X)=\Lambda^2Q\oplus\Lambda^2Q^\perp$ with $Q$ the plane of the nonzero block and $Q^\perp=\ker X$. $X=(c,c,c)$ is the general element of the only class whose centraliser has dimension $9$, and there $X=cJ$ for an orthogonal complex structure $J$, so $\mathfrak z(X)=\mathfrak u(J)=\mathfrak u(3)$ and $\mathbb RX=\mathbb RJ$. **Both are right.**

**The argument depends only on the conjugacy class.** Every $X$ in the first class is $c\,\varepsilon_{gQ_0}$ for some $g\in O(6)$, and every $X$ in the second is $cgJ_0g^{-1}$. Ricci and Bianchi are $O(6)$-equivariant, so conjugating a putative solution to the standard $Q$ or the standard $J$ is free, and the scale $c$ never enters, the centraliser of $X$ and of $cX$ being equal. The one genuine choice is the orientation of $Q^\perp$, which decides which of $\Lambda^\pm Q^\perp$ is called $\mathcal U$ and which $\mathcal V$. That is a convention, and §5.3 below shows the constraint system is invariant under reversing it, which is precisely what the bullet's last sentence spends.

## 5. Item 4: the seven-dimensional bullet, step by step

### 5.1 The decomposition and the constraint list

$\mathfrak z(X)=\Lambda^2Q\oplus\Lambda^2Q^\perp$ with $\dim Q=2$, $\dim Q^\perp=4$, dimensions $1+6=7$. The summands are orthogonal and $\varepsilon_Q$ is unit, so $\omega_i=t_i\varepsilon_Q+\alpha_i+b_i$ with $\alpha_i\in\Lambda^+Q^\perp\leftrightarrow u_i\in\mathbb R^3$ and $b_i\in\Lambda^-Q^\perp\leftrightarrow v_i\in\mathbb R^3$ is a legitimate orthogonal decomposition, and $\langle\omega_i,\omega_j\rangle=t_it_j+u_i\cdot u_j+v_i\cdot v_j$.

Each $\omega_i$ is block diagonal for $\mathbb R^6=Q\oplus Q^\perp$, so $\omega_i^2$ is too. On $Q$, $\varepsilon_Q^2=-\Pi_Q$. On $Q^\perp\cong\mathbb H$, with $\alpha_i=L_{p_i}/\sqrt2$ and $b_i=R_{v_i}/\sqrt2$ and left and right multiplications commuting,
$$(\alpha_i+b_i)^2=-\tfrac{\lvert u_i\rvert^2+\lvert v_i\rvert^2}{2}\,\Pi_{Q^\perp}+L_{p_i}R_{v_i}.$$
$L_pR_v$ is symmetric, since $(L_pR_v)^{\mathsf T}=(-R_v)(-L_p)=L_pR_v$, and trace-free, and $(p,v)\mapsto L_pR_v$ is an isomorphism $\Lambda^+\otimes\Lambda^-\to S^2_0\mathbb R^4$, both sides being the nine-dimensional $(1,1)$ representation of $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$. **The identification the bullet cites is correct and is the reason the traceless Ricci block is a $3\times3$ matrix equation.**

Ricci therefore reads, block by block: $\sum_i\lambda_it_i^2=0$ from $S^2Q$, where only multiples of $\Pi_Q$ occur so the remaining two dimensions of $S^2Q$ give $0=0$; $\sum_i\lambda_i(\lvert u_i\rvert^2+\lvert v_i\rvert^2)=0$ from the trace part of $S^2Q^\perp$; and $\sum_i\lambda_iu_iv_i^{\mathsf T}=0$ from its traceless part. The block $Q\otimes Q^\perp$ is absent because every $\omega_i^2$ is block diagonal.

Bianchi reads: $\varepsilon_Q\wedge\varepsilon_Q=0$; $\sum_i\lambda_i(\lvert u_i\rvert^2-\lvert v_i\rvert^2)=0$ from $\Lambda^4Q^\perp$; and $\sum_i\lambda_it_iu_i=\sum_i\lambda_it_iv_i=0$ from $\Lambda^2Q\wedge\Lambda^2Q^\perp$ split into its two halves. The block $\Lambda^1Q\wedge\Lambda^3Q^\perp$ is absent for the same reason. The dimensions check: $\Lambda^4\mathbb R^6=1+8+6=15$.

**Nothing is dropped and nothing is double-counted, and there is exactly one redundancy, which the bullet resolves correctly by listing its consequence rather than the raw equation.** The two scalar Ricci equations are not independent: $\mathop{\mathrm{tr}}\omega_i^2=-2\lVert\omega_i\rVert^2=-2$, so $\sum_i\lambda_i\mathop{\mathrm{tr}}\omega_i^2=-2\sum_i\lambda_i=0$ identically, which is precisely $\sum_i\lambda_i\big(t_i^2+\lvert u_i\rvert^2+\lvert v_i\rvert^2\big)=0$, the orthonormality relation $t_i^2+\lvert u_i\rvert^2+\lvert v_i\rvert^2=1$ read against $\sum_i\lambda_i=0$. Combining it with Bianchi's $\mathrm{vol}$ equation gives the bullet's
$$\sum_i\lambda_it_i^2=\sum_i\lambda_i\lvert u_i\rvert^2=\sum_i\lambda_i\lvert v_i\rvert^2=0,$$
so the third of these is a consequence and not an extra equation. **Constraint list CONFIRMED complete.** A reader counting Ricci's $1+1+9$ and Bianchi's $1+3+3$ against the bullet's list should be told which one is implied, for the same reason r826 §5.2 flags the analogous omission in the $\mathfrak k$ case.

### 5.2 Sylvester, and whether the case split is exhaustive

With $\mathcal U,\mathcal V$ the $3\times3$ matrices whose columns are the $u_i,v_i$, one has $(\mathcal U\Lambda\mathcal V^{\mathsf T})_{ab}=\sum_i\lambda_i(u_i)_a(v_i)_b$, so the traceless Ricci block is exactly $\mathcal U\Lambda\mathcal V^{\mathsf T}=0$. $\Lambda$ is invertible, so $\mathop{\mathrm{rank}}(\mathcal U\Lambda)=\mathop{\mathrm{rank}}\mathcal U$, and Sylvester's rank inequality $\mathop{\mathrm{rank}}(AB)\ge\mathop{\mathrm{rank}}A+\mathop{\mathrm{rank}}B-n$ at $n=3$ with $AB=0$ gives
$$\mathop{\mathrm{rank}}\mathcal U+\mathop{\mathrm{rank}}\mathcal V\le3 .$$
**CONFIRMED.**

**The case split is EXHAUSTIVE, and this is the item the brief asks about most sharply.** Suppose both $\mathop{\mathrm{rank}}\mathcal U\ge2$ and $\mathop{\mathrm{rank}}\mathcal V\ge2$. Then the sum is at least $4$, against the bound. So at least one of the two has rank at most $1$, and the pair of branches $\mathop{\mathrm{rank}}\mathcal U\in\{0,1\}$ together with $\mathop{\mathrm{rank}}\mathcal V\in\{0,1\}$ covers every admissible pair. Listing them: $(0,0),(0,1),(0,2),(0,3),(1,0),(1,1),(1,2),(2,0),(2,1),(3,0)$, of which the first seven are caught by $\mathop{\mathrm{rank}}\mathcal U\le1$ and the last three by $\mathop{\mathrm{rank}}\mathcal V\le1$. **No pair escapes.**

### 5.3 The two branches, and the legitimacy of the appeal to §5.4's lemma

**$\mathop{\mathrm{rank}}\mathcal U=0$.** Every $u_i=0$, so $\omega_i=t_i\varepsilon_Q+b_i$. The surviving constraints are $t^{\mathsf T}\Lambda t=0$, $\sum_i\lambda_i\lvert v_i\rvert^2=0$ and $\mathcal V\Lambda t=0$, with orthonormality $\mathcal V^{\mathsf T}\mathcal V=I_3-tt^{\mathsf T}$. **This is §5.4's lemma at $\gamma=1$**, with $M:=\mathcal V^{\mathsf T}$ so that $MM^{\mathsf T}=\mathcal V^{\mathsf T}\mathcal V=I-tt^{\mathsf T}$ and $M^{\mathsf T}(\Lambda t)=\mathcal V\Lambda t=0$, and with the isotropic vector taken to be $t$ itself. Both of the lemma's branches then run: if $\lvert t\rvert^2<1$ then $M$ is invertible and $\Lambda t=0$ forces $t=0$. If $\lvert t\rvert^2=1$ then $\lVert M^{\mathsf T}t\rVert^2=t^{\mathsf T}MM^{\mathsf T}t=\lvert t\rvert^2(1-\lvert t\rvert^2)=0$, so $t\in\ker M^{\mathsf T}=\ker MM^{\mathsf T}=\mathbb Rt$, whence $\Lambda t=\kappa t$, $0=t^{\mathsf T}\Lambda t=\kappa\lvert t\rvert^2$ gives $\kappa=0$, and $\Lambda$ invertible gives $t=0$ against $\lvert t\rvert=1$. **So $t=0$.** Then $U\subseteq\Lambda^-Q^\perp$ and by dimension $U=\Lambda^-Q^\perp$, whose centraliser is $\Lambda^+Q^\perp\oplus\Lambda^2Q$, of dimension $4$ and not $1$, and whose support has dimension $4$ and not $6$.

**I record this derivation because the bullet cites another report for it, and the citation is unnecessary.** The step is §5.4's own lemma at $\gamma=1$, available inside the same document. That is a strengthening of the bullet, not a defect in it, but a recorded version should stand on the lemma rather than on a cross-reference.

**$\mathop{\mathrm{rank}}\mathcal U=1$.** Write $u_i=p_i\hat u$ with $\hat u$ unit and $p\neq0$. Then $\sum_i\lambda_i\lvert u_i\rvert^2=0$ reads $p^{\mathsf T}\Lambda p=0$, $\sum_i\lambda_it_iu_i=0$ reads $t^{\mathsf T}\Lambda p=0$, and $\sum_i\lambda_it_i^2=0$ reads $t^{\mathsf T}\Lambda t=0$. So $\mathop{\mathrm{span}}(t,p)$ is totally isotropic for $\Lambda$. Since $\sum_i\lambda_i=0$ with every $\lambda_i\neq0$ forces two weights of one sign and one of the other, $\Lambda$ is nondegenerate of signature $(2,1)$ or $(1,2)$, Witt index $\min(2,1)=1$ in both, so $\dim\mathop{\mathrm{span}}(t,p)\le1$. As $p\neq0$ the span is the line $\mathbb Rp$: pick $\xi$ unit spanning it and write $p=\mathsf p\,\xi$, $t=\mathsf q\,\xi$ with $\mathsf p\neq0$.

The traceless Ricci block becomes $\hat u\,(\sum_i\lambda_ip_iv_i)^{\mathsf T}=0$, so $\mathcal V\Lambda p=0$ and hence $\mathcal V\Lambda\xi=0$. Orthonormality gives $\mathcal V^{\mathsf T}\mathcal V=I_3-(\mathsf p^2+\mathsf q^2)\xi\xi^{\mathsf T}$. **This is §5.4's lemma at $u=\xi$, $\gamma^2=\mathsf p^2+\mathsf q^2>0$, and $M=\mathcal V^{\mathsf T}$.** The lemma is being applied to objects of exactly the type it was proved on: a $3\times3$ real $M$, a real isotropic $u$, a nondegenerate indefinite $\Lambda$ of Witt index one, with $MM^{\mathsf T}=I-\gamma^2uu^{\mathsf T}$ a Gram matrix so that $\gamma^2\lvert u\rvert^2\le1$ automatically and the two branches are exhaustive. **The appeal is legitimate.** Its conclusion is $\xi=0$, which contradicts $\lvert\xi\rvert=1$, so this branch is empty outright.

**$\mathop{\mathrm{rank}}\mathcal V\le1$.** Reversing the orientation of $Q^\perp$ interchanges $\Lambda^+Q^\perp$ and $\Lambda^-Q^\perp$, hence $u_i\leftrightarrow v_i$ and $\mathcal U\leftrightarrow\mathcal V$. The constraint system is invariant: $\sum\lambda_it_i^2=0$ is untouched, $\sum\lambda_i\lvert u_i\rvert^2=0$ and $\sum\lambda_i\lvert v_i\rvert^2=0$ swap, the two cross equations swap, $\sum_i\lambda_iu_iv_i^{\mathsf T}=0$ becomes its transpose, the $\mathrm{vol}$ equation changes sign and so is the same equation, and orthonormality is symmetric. The reversal is conjugation by a reflection of $Q^\perp$, an element of $O(6)$, and Ricci and Bianchi are $O(6)$-equivariant. So the two branches close identically, with $U=\Lambda^+Q^\perp$ in place of $\Lambda^-Q^\perp$ and the same dimensions $4$ and $4$. **This branch is empty. Item 4 CONFIRMED.**

### 5.4 The two defects, located, exhibited and argued against

**Defect one, a transpose.** The bullet writes $\mathcal V\mathcal V^{\mathsf T}=I-(p^2+q^2)\xi\xi^{\mathsf T}$. $\mathcal V$ has the $v_i$ as **columns**, so $(\mathcal V^{\mathsf T}\mathcal V)_{ij}=v_i\cdot v_j$ is the matrix indexed by the triple, while $(\mathcal V\mathcal V^{\mathsf T})_{ab}=\sum_i(v_i)_a(v_i)_b$ is indexed by $\Lambda^-Q^\perp$. The right-hand side $I-(p^2+q^2)\xi\xi^{\mathsf T}$ carries $\xi\in\mathbb R^3$, which is a vector in the **triple** index, since $p$ and $t$ are. So the identity as written pairs objects living in different copies of $\mathbb R^3$, and the correct statement is $\mathcal V^{\mathsf T}\mathcal V=I-(\mathsf p^2+\mathsf q^2)\xi\xi^{\mathsf T}$. **Argued the opposite:** the most charitable reading is that $\mathcal V$ was meant to have the $v_i$ as rows in this one line, in which case the identity is right and the earlier sentence defining $\mathcal V$ by columns, which the Sylvester step needs, is the one that would have to change. Either way exactly one of the two lines must be re-indexed. It is cosmetic and it changes no conclusion, since §5.4's lemma is stated for $MM^{\mathsf T}$ with $M$'s rows the vectors, and $M=\mathcal V^{\mathsf T}$ makes everything agree. **Recorded as a typographical repair, not a mathematical one.**

**Defect two, a notation collision.** "$p_i=p\,\xi$, $t=q\,\xi$" uses $p$ both for the vector $(p_1,p_2,p_3)$ and for the scalar coefficient. I have written $\mathsf p,\mathsf q$ above. Cosmetic.

**A third candidate I looked for and did not find.** I checked whether the bullet's *"giving $\xi=0$ and so $\mathop{\mathrm{rank}}\mathcal U=0$"* smuggles in a claim that the rank-one branch reduces to the rank-zero one rather than being empty. It does not matter which reading is taken, because the rank-zero branch is itself closed, so both readings terminate. The precise statement is that $\xi=0$ forces $p=0$, contradicting $\mathop{\mathrm{rank}}\mathcal U=1$, so the branch is empty. **Withdrawn as a discrepancy**, since the words support the harmless reading and nothing downstream depends on it.

## 6. Item 6: what is six-dimensional, and whether the last sentence is earned

| Bullet | Dimension-free? |
|---|---|
| $\mathfrak t^3$ | **Six-dimensional.** It needs $\dim\mathfrak t=3=\dim U$. In $\mathfrak{so}(8)$ the Cartan is four-dimensional and $U\subseteq\mathfrak t^4$ would not be an equality |
| $\mathfrak k$ | **The computation is dimension-free**, as r826 §5.5 already established and as §4.2 above re-checks. What is six-dimensional is the input, namely that $\mathfrak k$ is the only shape of that size |
| $\Lambda^2Q\oplus\Lambda^2Q^\perp$ | **Six-dimensional throughout.** It needs $\dim Q^\perp=4$ for the $\Lambda^\pm$ splitting and for $S^2_0\mathbb R^4\cong\Lambda^+\otimes\Lambda^-$, and the Sylvester bound is a $3\times3$ statement whose slack is exactly what makes the two-branch split exhaustive |
| $\mathfrak u(3)$, as closed in §7 | **Six-dimensional.** It works with $3\times3$ hermitian matrices, and the identification of Bianchi with the adjugate is a $\dim V=6$ phenomenon, $\star$ carrying $\Lambda^4$ to $\Lambda^2$ only there |

**The final sentence is earned on the givens.** The four bullets exhaust the possibilities for $\mathfrak z(X)$ by §3, three of them contradict $\dim\mathfrak z(U)=1$, and the fourth leaves $X=cJ$ so that $\mathfrak z(U)=\mathbb RJ$ and $U\subseteq\mathfrak u(3)$. Together with the two given exclusions at dimensions $\ge3$ and $=2$, the disjunction "$\mathfrak z(U)=0$, or $\mathfrak z(U)=\mathbb RJ$ with $U\subseteq\mathfrak u(3)$" follows. **It is nevertheless superseded**, because §7 empties the second alternative.

## 7. Item 7: the $\mathfrak u(3)$ case, attacked, and it closes

### 7.1 The system, rewritten in hermitian matrices

Identify $\mathbb R^6\cong\mathbb C^3$ with $J$ multiplication by $i$. Then $\mathfrak u(3)=\mathfrak z(J)$ is the anti-hermitian $3\times3$ complex matrices, and $A\mapsto\hat A$ into $\mathfrak{so}(6)$ is an injective homomorphism of real associative algebras. Write $A=iM$ with $M$ hermitian. Three identities fix the dictionary.

- **Inner product.** $\langle\hat A,\hat B\rangle=-\tfrac12\mathop{\mathrm{tr}}_{\mathbb R}(\hat A\hat B)=-\mathop{\mathrm{Re}}\mathop{\mathrm{tr}}_{\mathbb C}(AB)=\mathop{\mathrm{tr}}(MN)$ for $A=iM$, $B=iN$, using $\mathop{\mathrm{tr}}_{\mathbb R}\hat C=2\mathop{\mathrm{Re}}\mathop{\mathrm{tr}}_{\mathbb C}C$. So **orthonormality is $\mathop{\mathrm{tr}}(M_iM_j)=\delta_{ij}$**, which is the brief's $\mathop{\mathrm{tr}}A_iA_i^*=1$ read on the diagonal.
- **Ricci.** $\hat A^2=\widehat{A^2}=\widehat{-M^2}$, and the hat map is injective, so $\sum_i\lambda_i\omega_i^2=0$ is exactly $\boxed{\sum_i\lambda_iM_i^2=0}$. This is the brief's $\sum_i\lambda_iA_i^2=0$.
- **Bianchi.** $\mathop{\mathrm{Padj}}(\hat A)=\widehat{i\mathop{\mathrm{adj}}(A)}$. **Proof.** Both sides are quadratic and $U(3)$-equivariant, $\mathop{\mathrm{Padj}}$ because it is $SO(6)$-equivariant and $U(3)\subset SO(6)$, and $\mathop{\mathrm{adj}}$ because $\mathop{\mathrm{adj}}(gAg^{-1})=g\mathop{\mathrm{adj}}(A)g^{-1}$ for every invertible $g$. Every anti-hermitian matrix is $U(3)$-conjugate to a diagonal one, so it is enough to check diagonals. For $A=i\mathop{\mathrm{diag}}(a_1,a_2,a_3)$ one has $\hat A=-\sum_ja_j\varepsilon_j$, so $\mathop{\mathrm{Padj}}(\hat A)=a_2a_3\varepsilon_1+a_1a_3\varepsilon_2+a_1a_2\varepsilon_3$, whose complex form is $\mathop{\mathrm{diag}}(-ia_2a_3,-ia_1a_3,-ia_1a_2)$, while $\mathop{\mathrm{adj}}(A)=-\mathop{\mathrm{diag}}(a_2a_3,a_1a_3,a_1a_2)$, so $i\mathop{\mathrm{adj}}(A)$ is the same matrix. $\square$ Since $\mathop{\mathrm{adj}}(iM)=i^2\mathop{\mathrm{adj}}(M)=-\mathop{\mathrm{adj}}(M)$ and $\star$ is an isomorphism, first Bianchi is exactly $\boxed{\sum_i\lambda_i\mathop{\mathrm{adj}}(M_i)=0}$.

**Two checks that the dictionary is not inverted.** For $A=i\mathop{\mathrm{diag}}(1,0,0)$ the form is $\pm e^{12}$, decomposable, $\omega\wedge\omega=0$, and $\mathop{\mathrm{adj}}(A)=0$. For $A=i\mathop{\mathrm{diag}}(1,1,0)$ the form is $\pm(e^{12}+e^{34})$, $\mathop{\mathrm{Padj}}=\varepsilon_3=e^{56}$, and $i\mathop{\mathrm{adj}}(A)=\mathop{\mathrm{diag}}(0,0,-i)$, the same element. Both agree.

**So the $\mathfrak u(3)$ case is exactly this.** *Three hermitian $3\times3$ matrices with $\mathop{\mathrm{tr}}(M_iM_j)=\delta_{ij}$, and a weight vector with $\sum_i\lambda_i=0$ and every $\lambda_i\neq0$, satisfying $\sum_i\lambda_iM_i^2=0$ and $\sum_i\lambda_i\mathop{\mathrm{adj}}(M_i)=0$.* First Bianchi is an **extra** condition, not implied by Ricci, and §7.2 shows it is the condition that closes the case.

### 7.2 Bianchi forces every $A_i$ traceless

Write $s_i=\mathop{\mathrm{tr}}M_i$, so $\mathop{\mathrm{tr}}A_i=is_i$. Cayley–Hamilton in dimension three gives $\mathop{\mathrm{adj}}(M)=M^2-(\mathop{\mathrm{tr}}M)M+c_2(M)I$ with $c_2(M)=\tfrac12\big((\mathop{\mathrm{tr}}M)^2-\mathop{\mathrm{tr}}M^2\big)$, which here is $\tfrac12(s_i^2-1)$ since $\mathop{\mathrm{tr}}M_i^2=1$. Summing against the weights and using $\sum_i\lambda_i=0$,
$$0=\sum_i\lambda_i\mathop{\mathrm{adj}}(M_i)=\underbrace{\sum_i\lambda_iM_i^2}_{=0\ \text{by Ricci}}-\sum_i\lambda_is_iM_i+\tfrac12\Big(\sum_i\lambda_is_i^2\Big)I,$$
so first Bianchi, given Ricci, is the single equation
$$\sum_i\lambda_is_iM_i=\tfrac12\Big(\sum_i\lambda_is_i^2\Big)I .$$
Take the trace: the left side gives $\sum_i\lambda_is_i^2$ and the right gives $\tfrac32\sum_i\lambda_is_i^2$, so $\tfrac12\sum_i\lambda_is_i^2=0$ and hence $\sum_i\lambda_is_i^2=0$. The right-hand side vanishes, leaving $\sum_i\lambda_is_iM_i=0$. **The $M_i$ are orthonormal, hence linearly independent over $\mathbb R$, so $\lambda_is_i=0$ for each $i$, and every $\lambda_i\neq0$ gives $s_i=0$.**

$$\textbf{First Bianchi forces }\mathop{\mathrm{tr}}A_1=\mathop{\mathrm{tr}}A_2=\mathop{\mathrm{tr}}A_3=0,\text{ so } U\subseteq\mathfrak{su}(3).$$

**Argue the opposite.** The step that could fail is the linear independence: if the equation had been $\sum_i\lambda_is_iM_i=cI$ with $c\neq0$, then $I$ might lie in $\mathop{\mathrm{span}}(M_1,M_2,M_3)$ and no conclusion would follow. The trace identity is what removes that possibility, and it removes it unconditionally, using only $\mathop{\mathrm{tr}}M_i^2=1$ and $\sum_i\lambda_i=0$. I also checked the alternative route, pairing the equation with $M_j$ to get $\lambda_js_j=cs_j$, which gives $s_j(\lambda_j-c)=0$ and would leave open a solution with $\lambda_j=c$ for the indices where $s_j\neq0$. The trace identity kills that branch too by forcing $c=0$. **Nothing is left open.**

### 7.3 Ricci then forces the three squares to coincide

Let $M$ be traceless hermitian with $\mathop{\mathrm{tr}}M^2=1$ and eigenvalues $m_1,m_2,m_3$. Newton's identities in three variables give $p_4=e_1p_3-e_2p_2+e_3p_1$ with $p_1=0$, $p_2=1$, $e_1=0$ and $e_2=\tfrac12(p_1^2-p_2)=-\tfrac12$, so $\mathop{\mathrm{tr}}M^4=p_4=\tfrac12$. Hence for the traceless part $(M^2)_0=M^2-\tfrac13I$,
$$\lVert (M^2)_0\rVert^2=\mathop{\mathrm{tr}}M^4-\tfrac23\mathop{\mathrm{tr}}M^2+\tfrac13=\tfrac12-\tfrac23+\tfrac13=\tfrac16 ,$$
**the same value for every traceless unit hermitian $M$.** Three spot checks: $\mathop{\mathrm{diag}}(1,-1,0)/\sqrt2$ gives $(M^2)_0=\mathop{\mathrm{diag}}(\tfrac16,\tfrac16,-\tfrac13)$ of square norm $\tfrac16$; $\mathop{\mathrm{diag}}(1,1,-2)/\sqrt6$ gives $\mathop{\mathrm{diag}}(-\tfrac16,-\tfrac16,\tfrac13)$, again $\tfrac16$; and the eigenvalue triple $(0.8,-0.2586\ldots,-0.5414\ldots)$ gives $\mathop{\mathrm{tr}}M^4=0.5000\ldots$ as the identity requires.

Ricci is $0=\sum_i\lambda_iM_i^2=\sum_i\lambda_i(M_i^2)_0+\tfrac13(\sum_i\lambda_i)I=\sum_i\lambda_iN_i$ with $N_i:=(M_i^2)_0$ and $\lVert N_i\rVert=1/\sqrt6$ for each $i$. Exactly one weight has the minority sign, say the index $k$, and then $\lvert\lambda_k\rvert=\sum_{i\neq k}\lvert\lambda_i\rvert$. Rearranging,
$$\frac{\lvert\lambda_k\rvert}{\sqrt6}=\lVert\lambda_kN_k\rVert=\Big\lVert\sum_{i\neq k}\lambda_iN_i\Big\rVert\le\sum_{i\neq k}\lvert\lambda_i\rvert\,\lVert N_i\rVert=\frac{\lvert\lambda_k\rvert}{\sqrt6}.$$
**The triangle inequality is an equality.** The two vectors $\lambda_iN_i$, $i\neq k$, carry weights of the same sign, so they are positively parallel, and having equal norms they are equal: $N_i=N_j$ for $i,j\neq k$. Substituting back, $\lambda_kN_k=-(\sum_{i\neq k}\lambda_i)N_j=\lambda_kN_j$, so $N_k=N_j$ too. Hence
$$M_1^2=M_2^2=M_3^2=:H,\qquad H\succeq0,\quad \mathop{\mathrm{tr}}H=1 .$$

### 7.4 Equal squares leave only four-dimensional support

Each $M_i$ commutes with $M_i^2=H$, so each preserves every eigenspace of $H$. On an eigenspace $E_h$ with $h>0$, $M_i\vert_{E_h}/\sqrt h$ is a hermitian involution, and on $E_0$ it vanishes. The multiplicity patterns of $H$ on $\mathbb C^3$ are $(1,1,1)$, $(2,1)$ and $(3)$, and each is settled.

**$(1,1,1)$, three distinct eigenvalues $h_1,h_2,h_3\ge0$.** Every $M_i$ is diagonal in $H$'s eigenbasis with entries $\sigma_{ik}\sqrt{h_k}$, $\sigma_{ik}=\pm1$. Put $w_i\in\mathbb R^3$ with $(w_i)_k=\sigma_{ik}\sqrt{h_k}$. Then $\mathop{\mathrm{tr}}(M_iM_j)=w_i\cdot w_j=\delta_{ij}$ and $\mathop{\mathrm{tr}}M_i=w_i\cdot(1,1,1)=0$. Three orthonormal vectors in $\mathbb R^3$ span $\mathbb R^3$, yet all three lie in the $2$-plane $(1,1,1)^\perp$. **Contradiction.**

**$(3)$, $H=\tfrac13I$.** $M_i=\tfrac{1}{\sqrt3}S_i$ with $S_i$ a hermitian involution on $\mathbb C^3$, whose trace is $\pm3$ or $\pm1$, never $0$. Tracelessness fails. **Contradiction.**

**$(2,1)$, eigenvalue $h$ of multiplicity two on $E$ and $h'\neq h$ of multiplicity one on $F$, with $2h+h'=\mathop{\mathrm{tr}}H=1$.** Write $M_i\vert_F=\sigma_i\sqrt{h'}$.

- $h>0$ and $h'>0$. Then $M_i\vert_E=\sqrt h\,S_i$ with $S_i$ a hermitian involution on $\mathbb C^2$, so $\mathop{\mathrm{tr}}S_i\in\{2,0,-2\}$, and tracelessness $\sqrt h\mathop{\mathrm{tr}}S_i=-\sigma_i\sqrt{h'}\neq0$ forces $\mathop{\mathrm{tr}}S_i=\pm2$, hence $S_i=\epsilon_iI_2$. Then $2\epsilon_i\sqrt h=-\sigma_i\sqrt{h'}$ gives $h'=4h$, so $6h=1$ and $M_i=\epsilon_i\sqrt{1/6}\,\mathop{\mathrm{diag}}(1,1,-2)$. Now $\mathop{\mathrm{tr}}(M_iM_j)=\epsilon_i\epsilon_j\cdot6h=\pm1$ for $i\neq j$, against orthogonality. **Contradiction.**
- $h>0$ and $h'=0$. Then $\mathop{\mathrm{tr}}S_i=0$, so $S_i=n_i\cdot\vec\sigma$ for a unit $n_i\in\mathbb R^3$, and $\mathop{\mathrm{tr}}(M_iM_j)=2h\,n_i\cdot n_j=\delta_{ij}$ gives $h=\tfrac12$ and $n_1,n_2,n_3$ orthonormal. **This is consistent**, and it is the only consistent branch: $M_i=\tfrac{1}{\sqrt2}(n_i\cdot\vec\sigma)\oplus0$. But every $M_i$ annihilates the complex line $F$, so every $\omega_i$ annihilates the real $2$-plane $F_{\mathbb R}$, and $V\subseteq E_{\mathbb R}$ has $\dim V=4$. **Excluded by $\dim V=6$.**
- $h=0$, so $h'=1$. Then $M_i\vert_E=0$ and $M_i\vert_F=\pm1$, so $\mathop{\mathrm{tr}}M_i=\pm1\neq0$. **Contradiction.**

$$\boxed{\textbf{At }\dim V=6\textbf{ the case }U\subseteq\mathfrak u(3)\textbf{ is empty.}}$$

### 7.5 Three checks that this does not prove too much, and what it also re-proves

**It lands on the padded family and does not empty it.** The surviving branch $M_i=\tfrac{1}{\sqrt2}(n_i\cdot\vec\sigma)\oplus0$ is exactly $\mathfrak{su}(2)$ acting on $\mathbb C^2=\mathbb R^4$, which is one of the two $\mathfrak{su}(2)$ factors of $\mathfrak{so}(4)$, that is $\Lambda^+P$ or $\Lambda^-P$ for the $4$-plane $P=E_{\mathbb R}$. Every traceless weight vector solves it, since $\sum_i\lambda_iM_i^2=(\sum_i\lambda_i)H=0$ and $\mathop{\mathrm{adj}}(M_i)=M_i^2-\tfrac12I=\mathop{\mathrm{diag}}(0,0,-\tfrac12)$ is $i$-independent so $\sum_i\lambda_i\mathop{\mathrm{adj}}(M_i)=0$. **This is the record's known inhabited family at $\dim V=4$, recovered rather than destroyed.** It also re-verifies both dictionary identities on a case whose answer is known independently: $\omega_i\wedge\omega_i=\pm\mathrm{vol}_P$ for each $i$, so Bianchi reads $(\sum_i\lambda_i)\mathrm{vol}_P=0$, and the adjugate form says the same thing.

**It re-proves the $\mathfrak t^3$ bullet independently.** $\mathfrak t^3\subset\mathfrak u(3)$ is the diagonal anti-hermitian matrices, so §7 covers it. Following the argument there: Bianchi forces $\mathop{\mathrm{tr}}M_i=0$, Ricci forces a common $H$, and $H$ diagonal falls into the same three patterns, all of which fail or drop the support to four. That agrees with the $\mathfrak t^3$ bullet and with the record's own emptying of the simultaneously block-diagonal family, reached by a different route.

**§7 does not use $\dim\mathfrak z(U)=1$ at all.** Its only structural hypothesis is $U\subseteq\mathfrak u(3)$. So the statement it proves is stronger than the bullet needs: **no rank-three Weyl tensor at $\dim V=6$ has all three image forms commuting with one complex structure**, whatever the dimension of its stabiliser.

### 7.6 The revised conclusion

Assembling the four bullets with §7 in place of the fourth, and with the two given exclusions:

$$\textbf{At }\dim V=6\textbf{, a solution has }\mathfrak z(U)=0 .$$

The disjunction in the claim's last sentence loses its second alternative. What remains open is unchanged in substance and sharper in statement: whether a **constrained** triple with trivial centraliser exists at $\dim V=6$. r826 §3 exhibits an unconstrained orthonormal triple with $\mathfrak z(U)=0$, so the stratum is inhabited among triples, and the question is whether Ricci and Bianchi meet it.

## 8. Item 8: falsifiers, and what I did to look for them

| Claim I record | What would falsify it | What I did |
|---|---|---|
| The enumeration has exactly four shapes (§3) | A conjugacy class of nonzero $X$ whose centraliser is none of $\mathfrak t^3,\mathfrak k,\Lambda^2Q\oplus\Lambda^2Q^\perp,\mathfrak u(3)$ | Derived $\mathfrak z(X)=\bigoplus_r\mathfrak u(m_r)\oplus\mathfrak{so}(2m_0)$ from the isotypic decomposition and ran every partition of the three blocks, degenerate patterns included, checking each dimension against $\sum m_r^2+m_0(2m_0-1)$ |
| The case split in the $7$-dimensional bullet is exhaustive (§5.2) | An admissible pair $(\mathop{\mathrm{rank}}\mathcal U,\mathop{\mathrm{rank}}\mathcal V)$ with both entries at least $2$ | Enumerated all ten admissible pairs under $\mathop{\mathrm{rank}}\mathcal U+\mathop{\mathrm{rank}}\mathcal V\le3$ and matched each to one of the two branches |
| The constraint list is complete (§5.1) | A block of Ricci or Bianchi with no equation attached | Counted $S^2\mathbb R^6$ and $\Lambda^4\mathbb R^6$ block by block against $1+1+9$ and $1+3+3$, identified the single redundancy as the automatic tracelessness, and checked that $Q\otimes Q^\perp$ and $\Lambda^1Q\wedge\Lambda^3Q^\perp$ are absent because each $\omega_i$ is block diagonal |
| $\mathop{\mathrm{rank}}\mathcal U=0$ closes without an outside citation (§5.3) | A step in that branch not supplied by §5.4's lemma | Re-derived it as the lemma at $\gamma=1$, $u=t$, $M=\mathcal V^{\mathsf T}$, running both of its branches including the degenerate one |
| Bianchi in $\mathfrak u(3)$ is $\sum_i\lambda_i\mathop{\mathrm{adj}}(M_i)=0$ (§7.1) | A quadratic $U(3)$-equivariant correction term vanishing on diagonals | Proved the identity by equivariance plus diagonalisability, then checked it on two concrete forms with independently known wedges, $\pm e^{12}$ and $\pm(e^{12}+e^{34})$, and on the padded family where the answer is $(\sum_i\lambda_i)\mathrm{vol}_P=0$ |
| Bianchi forces $\mathop{\mathrm{tr}}A_i=0$ (§7.2) | A solution with $I\in\mathop{\mathrm{span}}(M_1,M_2,M_3)$ and $\sum_i\lambda_is_iM_i=cI$, $c\neq0$ | Looked for exactly that and closed it: the trace of the equation forces $\sum_i\lambda_is_i^2=0$, hence $c=0$, unconditionally. Also ran the pairing route, which leaves $\lambda_j=c$ open, and confirmed the trace identity closes it |
| Ricci then forces $M_1^2=M_2^2=M_3^2$ (§7.3) | A traceless unit hermitian $M$ with $\lVert (M^2)_0\rVert\neq1/\sqrt6$, which would break the equality case | Proved $\mathop{\mathrm{tr}}M^4=\tfrac12$ from Newton's identities at $p_1=0$, $p_2=1$ and checked three spectra by hand, including a non-symmetric one |
| $\mathfrak u(3)$ is empty at $\dim V=6$ (§7.4) | A common square $H$ whose spectral pattern I did not treat, or a solution in the surviving branch with $\dim V=6$ | Split on all three multiplicity patterns of a PSD $H$ with $\mathop{\mathrm{tr}}H=1$, and inside $(2,1)$ on all three sign cases for $h,h'$. The single consistent branch has every $M_i$ annihilating a complex line, so $\dim V=4$ |
| **The whole claim** | **A triple with $\dim\mathfrak z(U)=1$ whose centre is not $\mathbb RJ$** | Each of the three non-$\mathfrak u(3)$ shapes was re-derived from the definitions rather than read: $\mathfrak t^3$ gives $\dim\mathfrak z(U)=3$, $\mathfrak k$ and the $7$-dimensional shape both give $U=\Lambda^\mp P$ and $\dim\mathfrak z(U)=4$. In every case the surviving object has $\dim V=4$, so the falsifier would have to be a solution whose support drops, which contradicts the branch's own hypothesis. **None found.** By §7 the falsifier for the strengthened statement is a triple with $\dim\mathfrak z(U)=1$ at all, and the same sweep found none |

**Computation.** *None was run. The standing analysis-only rule was in force, the screening allowance was available and unused, and every trace, spectrum and inequality above was worked by hand. The numerical spot check in §7.3 is arithmetic on a closed-form spectrum, done on paper, and it is a check on an identity I prove rather than evidence for it.*

## 9. Protocol

- **Located exactly.** The two defects are in the third bullet of [r826](REVIEW_r826.md) §6: the identity written $\mathcal V\mathcal V^{\mathsf T}=I-(p^2+q^2)\xi\xi^{\mathsf T}$, and the phrase *"$u_i=p_i\hat u$ and $(p,t)$ is a totally isotropic pair"* followed by *"a line $p=p\,\xi$, $t=q\,\xi$"*. The unnecessary citation is *"[r824] §7 forces $t=0$"* in the same bullet. The completeness gap in the enumeration is in §5.5, which omits the pattern $(c,d,d)$.
- **Exhibited concretely.** §3's table and its dimension formula, §5.1's block-by-block constraint derivation, §5.2's enumeration of the ten admissible rank pairs, §5.3's re-derivation of the $\mathop{\mathrm{rank}}\mathcal U=0$ branch, §7.1's two-example verification of the adjugate dictionary, §7.2's trace identity, §7.3's Newton computation and §7.4's spectral case split.
- **Argued the opposite.** §5.4 gives the transpose slip its charitable reading, under which a different line would need re-indexing instead, and withdraws a third candidate outright. §7.2 constructs the one escape route from the traceless forcing and closes it. §7.5 checks that §7 recovers the padded family rather than emptying it, and that it agrees with the $\mathfrak t^3$ bullet reached by a different route.

**One candidate withdrawn**, recorded so the next reviewer does not spend on it: the reading of *"giving $\xi=0$ and so $\mathop{\mathrm{rank}}\mathcal U=0$"* as a claim that the rank-one branch reduces to the rank-zero branch rather than being empty. The words support the harmless reading, both readings terminate, and nothing downstream depends on which is meant.

## 10. Verdict

**CONFIRMED AND STRENGTHENED.**

1. **Every bullet of [r826](REVIEW_r826.md) §6 stands**, and the enumeration it rests on is exhaustive. The repairs owed are one transpose, one notation collision, one unnecessary citation replaced by §5.4's own lemma at $\gamma=1$, and one missing pattern in §5.5's list that changes no shape.
2. **The case declared untouched closes.** In $\mathfrak u(3)$, Ricci is $\sum_i\lambda_iM_i^2=0$ and first Bianchi is $\sum_i\lambda_i\mathop{\mathrm{adj}}(M_i)=0$ for trace-orthonormal hermitian $M_i$. Bianchi is an extra condition, it forces every $M_i$ traceless, Ricci then forces $M_1^2=M_2^2=M_3^2$ by an equality case of the triangle inequality that rests on $\lVert (M^2)_0\rVert^2=\tfrac16$ being constant, and every solution of that has a common kernel, hence $\dim V=4$.
3. **The recorded statement should therefore be the stronger one.** At $\dim V=6$ a solution has $\mathfrak z(U)=0$. The one-dimensional case is empty, not narrowed.
4. **§7 also proves something the claim did not ask for**, and it should be recorded separately because it is dimension-of-stabiliser-free: no rank-three Weyl tensor at $\dim V=6$ has all three image forms commuting with a single compatible complex structure.
5. **What remains open** is the trivial-stabiliser case at $\dim V=6$, and it is now the whole of the question.
