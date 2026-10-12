# Verifier v351, L113 step E4: Jacobi and first Bianchi as the only sources that can constrain G_2 beyond positivity and support of g

**Cold brief ([ADJ_L113_E4.md](ADJ_L113_E4.md)), no numerical work, no scripts written, every value exact and derived by hand. Log: [agent_logs/verify-L113-v351.log](../agent_logs/verify-L113-v351.log).**

| Claim | Verdict |
|---|---|
| E4 as written: among the relations the passages hold, only consequences of Jacobi or first Bianchi on $c$ before squaring can constrain $G_2$ beyond positivity and support of $g$ | REFUTED AS STATED |
| The per-index system (A), (B), (C) with $T\ge0$, read one row at a time, gives per-coordinate bounds on $g_k$ that positivity and support of $g$ do not imply | CONFIRMED |
| At the explicit critical point $W^\ast$ of §3 ($n=6$, $\theta=8$) positivity and support allow $G_2=8064$, and the row relations at a single index forbid it | CONFIRMED |
| Strongest defending reading (only sources that can leave the pinned class): the list "Jacobi, first Bianchi" is exhaustive | UNSUPPORTED, signed relations of other origin are on the table (§5) |

**Summary: the step omits a third source that the passages themselves hold, the per-index system (A), (B), (C) with $T\ge0$, which is post-squaring and neither Jacobi nor Bianchi, and at an explicit critical point it cuts the $G_2$ range that positivity and support leave open, so E4 FAILS.**

## 0. Conventions, fixed once

- $W\in\mathcal W_n$ acts on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with orthonormal eigenbasis $v_k$, eigenvalues $\lambda_k$, $N=n(n-1)/2$ indices, $p_j=\sum_k\lambda_k^j$, $\lVert W\rVert^2=p_2$.
- $c_{abc}=\langle[v_a,v_b],v_c\rangle$, $T_{abc}=c_{abc}^2\ge0$, totally symmetric.
- Hamilton's product in this basis is $W^\#_{ab}=\tfrac12\sum_{\beta\gamma}c_{a\beta\gamma}c_{b\beta\gamma}\lambda_\beta\lambda_\gamma$. Its diagonal with $W^\#=\theta W-W^2$ is exactly relation (C), and with $P=p_3+\langle W,W^\#\rangle$ it reproduces $\sum_k\lambda_kg_k=-4P$ from (B), so this normalisation agrees with Passage B.
- At a critical point $P(W)=\langle W,Q(W)\rangle=\theta p_2$. All relations are homogeneous, so no unit normalisation is imposed.
- $c_0:=\sum_kg_k=4(n-1)p_2$, $s:=\sum_k\lambda_kg_k=-4\theta p_2$, $\mu:=s/c_0=-\theta/(n-1)$.
- "Positivity and support" (PS) means: $g_k\ge0$, the measure $\sum_kg_k\delta_{\lambda_k}$ lives on the spectrum, and $c_0,s$ are pinned. Its $G_2$ range is the set of $\sum_k\lambda_k^2g_k$ over such $g$.
- "Row system" (RS) means: $T\ge0$ totally symmetric with (A), (B), (C) holding at every index.

## 1. Hypothesis inventory

- **H1.** (A), (B), (C) hold for every $k$ (Passage B), (C) at a critical point.
- **H2.** $T=c^2\ge0$ and totally symmetric (Definitions).
- **H3.** $\theta>0$. This is the orientation in which Passage C and the Lean statement feasible_iff_theta are posed. Replacing $W$ by $-W$ flips the sign of $\theta$.
- **H4.** The standard formula for $W^\#$ of §0, used only to check that $W^\ast$ is critical.
- **H5 (reading).** "Constrain $G_2$ beyond PS" means: at some critical point, the set of $G_2$ values compatible with the relation and PS is strictly smaller than the PS range. This is the plain reading of "beyond what positivity and support of $g$ give".

## 2. Where the step sits, and the source it leaves out

The step is Passage A's sentence: "the only sources on the table are the **Jacobi identity and first Bianchi acting on the $c$-tensor itself**, before squaring to $T$". The inference before it establishes that PS, however combined, return a pinned conclusion. The step then passes directly from PS to Jacobi and Bianchi on $c$.

Between those two levels lies the row system. Passage B holds (A), (B), (C) for **each** $k$, and $g_k$ and $G_2$ are contractions of $T$ with these rows. PS keeps only the two $k$-summed moments of $g$ that (A), (B) produce. Passage D records that "the full $3N$-row system" is "far stronger" than the single-row relaxation. Lemma L109 (Passage E) is itself a per-coordinate bound on $g$ derived from $T\ge0$ and (A) alone. None of these uses Jacobi or first Bianchi, and all act after squaring.

**The per-row bounds.** Fix $k$ and let $\mu_k(\alpha)=\sum_\beta T_{k\alpha\beta}\ge0$. By (A) its mass is $2(n-2)$ and by (B) $\sum_\alpha\lambda_\alpha\mu_k(\alpha)=-2\lambda_k$. Expanding $(\lambda_\alpha-\lambda_\beta)^2$ and using symmetry of $T$ in its last two slots and (C):

$$g_k=2\sum_\alpha\lambda_\alpha^2\mu_k(\alpha)-4\lambda_k(\theta-\lambda_k).$$

Since $\mu_k$ lives on $[\lambda_{\min},\lambda_{\max}]$, $\sum_\alpha(\lambda_\alpha-\lambda_{\min})(\lambda_{\max}-\lambda_\alpha)\mu_k(\alpha)\ge0$, which gives $\sum_\alpha\lambda_\alpha^2\mu_k\le-2\lambda_k(\lambda_{\max}+\lambda_{\min})-2(n-2)\lambda_{\max}\lambda_{\min}$. Cauchy-Schwarz gives $\sum_\alpha\lambda_\alpha^2\mu_k\ge2\lambda_k^2/(n-2)$. Hence, for every $k$,

$$\ell_k:=\frac{4(n-1)}{n-2}\lambda_k^2-4\theta\lambda_k\ \le\ g_k\ \le\ u_k:=-4\lambda_k(\lambda_{\max}+\lambda_{\min})-4(n-2)\lambda_{\max}\lambda_{\min}-4\lambda_k\theta+4\lambda_k^2 .$$

At the top eigenvalue this simplifies to $u_{\max}=4\lambda_{\max}\big((n-1)\lvert\lambda_{\min}\rvert-\theta\big)$. PS sees none of these bounds: it allows $g_k=0$ at every index off the two atoms of its extremal measures and allows arbitrary mass at those atoms. Whether they cut the $G_2$ range is a question about a specific critical point, settled next.

## 3. The exhibit: a critical point where the row system cuts the PS range

**Why $n=4$ cannot serve.** In $n=4$, with $W^\pm$ diagonal, $T_{e_1e_2e_3}=2$ on each $\mathfrak{su}(2)$ factor, and (C) forces each nonzero block to be $t(2,-1,-1)$ with $\theta=3t$, the same $t$ in both blocks. Then $g$ is supported on the eigenvalue $-t=\lambda_{\min}$, $\mu=\lambda_{\min}$, and PS pins $G_2$. The same happens for $S^p\times S^q$ and $\mathbb{CP}^m$ type Weyl tensors, because the isotropy algebra annihilates $g$ and its complement carries one eigenvalue. A non-pinned example needs a flat factor.

**The tensor $W^\ast$.** Take $n=6$, blocks $P=\{1,2\}$, $Q=\{3,4,5\}$, and the index $6$. Let $W^\ast$ be diagonal in the basis $e_i\wedge e_j$ with sectional values $K_{12}=6$, $K_{ij}=-2$ for $i\in P,j\in Q$, $K_{34}=K_{35}=K_{45}=2$, and $K_{i6}=0$. This is the $S^2\times S^3$ Weyl tensor extended by zero along a flat line.

- **Weyl.** A tensor diagonal on decomposable 2-forms satisfies first Bianchi, since $\omega\wedge\omega=0$ for decomposable $\omega$. Ricci vanishes: vertex 1 gives $6-2-2-2+0=0$, vertex 3 gives $-2-2+2+2+0=0$, vertex 6 gives $0$.
- **Structure constants.** In this basis $T_{(ij)(jl)(il)}=1$ for distinct $i,j,l$ and $T=0$ otherwise, which gives (A) as $2(n-2)=8$ ordered pairs per row.
- **(B).** Row $ij$ gives $\sum_{l}(K_{il}+K_{jl})=\mathrm{Ric}_i+\mathrm{Ric}_j-2K_{ij}=-2K_{ij}$.
- **(C) with $\theta=8$.** Row $(ij)$ reads $\sum_{l\ne i,j}K_{il}K_{jl}=K_{ij}(\theta-K_{ij})$. Row $12$: $3\cdot4=12=6\cdot2$. Row $13$: $6\cdot(-2)+2\cdot(-2\cdot2)=-20=-2\cdot10$. Row $34$: $4+2\cdot4=12=2\cdot6$. Rows through $6$: both sides vanish.
- **Critical.** Two distinct edges $a\ne b$ never complete the same triangle with a common pair $(\beta,\gamma)$, so $W^{\ast\#}$ is diagonal. With (C) its diagonal is $\theta\lambda_k-\lambda_k^2$, so $Q(W^\ast)=\theta W^\ast$.

**Spectrum and PS data.** The values are $6$ (once), $-2$ (six times), $2$ (three times), $0$ (five times). The trace is $6-12+6=0$ and $p_2=36+24+12=72$. So $c_0=20\cdot72=1440$, $s=-4\cdot8\cdot72=-2304$, and $\mu=-8/5\in(-2,6)$. Lemma L107 holds strictly, since $8<5\cdot2$.

**Check against the true $T$.** From $g_{ij}=2\sum_{l}(K_{il}-K_{jl})^2$: $g_{12}=0$, $g_{PQ}=2(64+16+16)=192$ on six edges, $g_{34}=0$, $g_{i6}=2(36+12)=96$ for $i\in P$, and $g_{j6}=2(8+8)=32$ for $j\in Q$. Then $\sum g=1152+192+96=1440$ and $\sum\lambda g=-2304$, as pinned. The true value is $G_2(W^\ast)=4\cdot1152=4608$.

**The PS range.** The support is $\{-2,0,2,6\}$. The PS maximum is $(\lambda_{\max}+\lambda_{\min})s-\lambda_{\max}\lambda_{\min}c_0=-9216+17280=8064$. It is attained only by measures carrying mass at the values $-2$ and $6$ alone. The mass at $6$ is $c_0(\mu-\lambda_{\min})/(\lambda_{\max}-\lambda_{\min})=1440\cdot\tfrac25/8=72$, and it all sits on the single index $12$. The PS minimum sits on the adjacent values $-2,0$ and equals $(-2)(-2304)=4608$.

**The row system at index $12$.** Here $u_{12}=4\cdot6\cdot(5\cdot2-8)=48$. Directly: $\mu_{12}$ has mass $8$ and $\sum\lambda\mu_{12}=-12$, so $\sum\lambda^2\mu_{12}\le4\cdot(-12)+12\cdot8=48$ and $g_{12}\le96-4\cdot6\cdot2=48$. So every $T$ satisfying (A), (B), (C) and $T\ge0$ at row $12$ has $g_{12}\le48<72$. **The PS maximiser is excluded by one row of the row system.** The PS feasible set is compact and the maximising face is excluded, so the RS supremum of $G_2$ is strictly below $8064$. An explicit bound: with $g_{12}=t\le48$ and the remaining mass on $\{-2,0,2\}$, $G_2\le4(1440-t)+36t=5760+32t\le7296$.

The row system is nonempty here, since the true $T$ lies in it with $g_{12}=0$. The relations used are (A), (B), (C) and $T\ge0$ on one row. None is Jacobi or first Bianchi on $c$, and all live after squaring.

## 4. The failure, located

- **Quoted line:** "the only sources on the table are the **Jacobi identity and first Bianchi acting on the $c$-tensor itself**, before squaring to $T$" (Passage A).
- **What fails:** the exhaustivity. §3 exhibits a source on the table (Passage B's per-index relations with $T\ge0$) that constrains $G_2$ at a critical point strictly beyond PS, and it is neither of the two named.
- **Argued the opposite.** A defender might say (B) comes from Bianchi. Passage B attributes (A), (B), (C) to "the Killing form, Ricci-flatness and criticality", and §3 used (B) only in the Ricci-flat form $\mathrm{Ric}_i+\mathrm{Ric}_j=0$. More to the point, the step restricts its sources to relations "acting on the $c$-tensor itself, before squaring", and (A), (B), (C) are relations on $T$. A defender might also say the row cut "cannot leave the pinned class". That is a different claim from the one written, which takes PS as the baseline. §5 treats it.

## 5. The strongest defending reading, and why it is still not established

**Reading D.** The step means: the only relations that could produce a conclusion outside the pinned class (the consequences of the row system) are Jacobi and first Bianchi on $c$. Under D the §3 cut is harmless, because it is a consequence of the row system by definition. D needs two hypotheses the words do not carry:

- **D1.** "Positivity and support of $g$" is replaced by "the row system (A), (B), (C) with $T\ge0$". This is contrary to the sentence and to the lemma's title, which concern moment analysis of $g$.
- **D2.** The list of signed relations lost by squaring consists of Jacobi and first Bianchi only.

**D2 is false as a description of the table.** The definitions and Passage B hold further relations on $c$ before squaring, and their origin is neither Jacobi nor first Bianchi:

- **Off-diagonal criticality.** $W^\#$ is diagonal in the eigenbasis, so $\sum_{\beta\gamma}c_{a\beta\gamma}c_{b\beta\gamma}\lambda_\beta\lambda_\gamma=0$ for $a\ne b$. (C) is its diagonal after squaring.
- **Killing orthogonality.** $\sum_{\beta\gamma}c_{a\beta\gamma}c_{b\beta\gamma}=2(n-2)\delta_{ab}$, the off-diagonal part of the Killing form, whose diagonal is (A). This follows from simplicity of $\mathfrak{so}(n)$, not from Jacobi.
- **Orbit condition.** $c$ is the structure tensor of $\mathfrak{so}(n)$ in an orthonormal basis. This is strictly stronger than Jacobi together with (A).
- **Wording.** First Bianchi is an identity of $W$, and in terms of the $v_k$ it is quartic ($\sum_k\lambda_kv_k\wedge v_k=0$ in $\Lambda^4$). It is not a relation on $c$ alone, so "first Bianchi acting on the $c$-tensor itself" needs a gloss.

Whether any of these constrains $G_2$ beyond the row system at some critical point is not decided by an argument here. So under D the step is an unproved exhaustivity claim with visible omissions, not a theorem.

## 6. Verdict

**E4 FAILS.**

- **Literal reading (H1 to H5).** Refuted in closed form. At the critical point $W^\ast$ ($n=6$, $\theta=8$, spectrum $\{6,-2^{\times6},2^{\times3},0^{\times5}\}$), positivity and support allow $G_2=8064$ only with $g_{12}=72$. Relations (A), (B), (C) with $T\ge0$ at row $12$ force $g_{12}\le48$, so $G_2\le7296$ there. That source is on the table and is neither Jacobi nor first Bianchi on $c$.
- **Reading D.** A VALID reading would need D1 (replace positivity and support by the full row system) and D2 (Jacobi and first Bianchi exhaust the signed relations lost by squaring). D1 contradicts the text. D2 is contradicted by off-diagonal criticality, Killing orthogonality and the $\mathfrak{so}(n)$ orbit condition, whose power over $G_2$ remains open.
