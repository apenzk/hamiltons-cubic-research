# Reviewer 935: Lemma L218, the off-diagonal coupling at a diagonal point

Log: [agent_logs/review-r935.log](../agent_logs/review-r935.log)

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | Reduction to blocks | CONFIRMED | L120's isotypic summands are orthogonal and $L_D$-invariant at every $\Gamma$-fixed $D$, so cross terms vanish and the quotient is a convex combination |
| 2 | Four-set bound | CONFIRMED | the identity holds, the six pairs of a 4-set are distinct, and uniform basis scaling leaves L121's spectrum unchanged |
| 3 | Pair bound | CONFIRMED | each of the three estimates and the disjointness $X+Y+Z\le1$ hold, $\lVert S\rVert_F^2=2Y$ counts ordered entries, and bounding on all of $\mathbb R^{n-2}$ over-estimates the $\mathbf 1^\perp$ block |
| 4 | Normalisation | CONFIRMED | on the diagonal locus the $\Lambda^2$ spectrum is the entries of $K$, so $\lVert D\rVert^2=\sum_{a<b}K_{ab}^2=1$, which is ordered $\lVert K\rVert_F^2=2$ |
| 5 | Lower bound at padded $S^2\times S^2$ | REFUTED | sign of the witness only: the printed entries are those of $-W_{S^2\times S^2}$, with $P=-\sqrt3/2$, and the bound $\sqrt3/2$ stands because $E$ is even in $K$ |
| 6 | Banach's theorem as used | CONFIRMED | $\langle L_DN,N\rangle=T(D,N,N)\le M(n)$, and $M(n)>\Theta_n$ refutes Conjecture A, whose clause is $n\ge12$, so firing at $n=8,10$ would refute nothing |
| 7 | $\theta_0(n)^2>\tfrac54$ from $n=8$ | CONFIRMED | $3n^2-24n+16>0$ exactly from $n=8$, and at odd $n$ the constant $\sqrt5/2$ beats $\Theta_n$ from $n=9$ and fails at $n=7$, which the lemma leaves unstated |
| 8 | "Not a route input" | CONFIRMED | post F67's ceiling uses only $\Lambda_n\ge\Theta_n/2$, so no upper constant moves it |
| 9 | Range $n\ge5$ | CONFIRMED | blocks and bounds hold at $n=5,6,7$ and also at $n=4$, so the hypothesis $n\ge5$ is unused |
| 10 | Sharpness | REFUTED | the pair block's supremum is exactly $\sqrt3/2$ by one Cauchy–Schwarz, so $\Lambda_n=\sqrt3/2$ at every $n\ge4$ and the "not settled" clause is settled |

**Summary: L218 is correct as stated, and should be strengthened to $\Lambda_n=\sqrt3/2$ exactly at every $n\ge4$ by a one-line Cauchy–Schwarz on the pair block, which makes the falsifier fail at every $n\ge5$ rather than every even $n\ge8$, and the lower-bound witness's entries need their sign flipped.**

## 1. The reduction to blocks

L120 decomposes $\mathcal W_n=\mathcal D_n\oplus\bigoplus V_{ijkl}\oplus\bigoplus V_{jk}$ into isotypic components of the full diagonal sign group $\Gamma$, whose characters on these summands are pairwise distinct at every $n$ (the given's own remark: fusion happens only for $\Gamma\cap SO(n)$). Isotypic components of an orthogonal representation are mutually orthogonal, so $\mathcal D_n^\perp\cap\mathcal W_n=\bigoplus V_{ijkl}\oplus\bigoplus V_{jk}$ exactly, with $\mathcal D_n$ the trivial-character summand.

$\mathcal D_n$ is exactly the $\Gamma$-fixed subspace, so every $D\in\mathcal D_n$ is $\Gamma$-fixed, and L120 states that $L_M$ preserves each summand at every $\Gamma$-fixed $M$ with criticality unused. The proof's phrase "a support argument needing diagonality alone" matches that given.

Write $N=\sum_aN_a$ with $N_a$ in block $a$. Then $L_DN_a\in V_a\perp V_b$ for $a\ne b$, so $\langle L_DN_a,N_b\rangle=0$ and $\langle L_DN,N\rangle=\sum_a\lVert N_a\rVert^2R_a$ with $R_a$ the Rayleigh quotient of the block and $\sum_a\lVert N_a\rVert^2=1$. That is the convex combination, and it is bounded by the largest block top eigenvalue. The Lean `coupling_le_of_blocks` is this step with orthogonality and vanishing cross terms as hypotheses, which is the right division of labour. Nothing found.

## 2. The four-set bound

The identity: $\tfrac12(A+B+C)^2=\tfrac12(A^2+B^2+C^2)+AB+BC+CA$, so $\tfrac32(A^2+B^2+C^2)-\tfrac12(A+B+C)^2=A^2+B^2+C^2-AB-BC-CA=E$. Dropping the square gives $E\le\tfrac32(A^2+B^2+C^2)$, and $(x+y)^2\le2(x^2+y^2)$ on each sum gives $E\le3(K_{ij}^2+K_{kl}^2+K_{ik}^2+K_{jl}^2+K_{il}^2+K_{jk}^2)$.

The six index pairs $\{ij\},\{kl\},\{ik\},\{jl\},\{il\},\{jk\}$ are the six 2-subsets of $\{i,j,k,l\}$, pairwise distinct, so their squared mass is at most $\sum_{a<b}K_{ab}^2=1$. Lean's `fourset_disc_le` states exactly this with $a,\dots,f$ for the six entries.

Basis normalisation: the three pairings $e_{ij}\odot e_{kl}$, $e_{ik}\odot e_{jl}$, $e_{il}\odot e_{jk}$ are orthogonal of common norm, and the signed coordinates are the $\operatorname{diag}(1,-1,1)$ conjugate, an orthogonal change. A matrix in an orthogonal basis of common norm is the matrix of the operator, so the eigenvalues $\pm\tfrac12\sqrt E$ on $\mathbf 1^\perp$ are the operator's. The units are $L_M$ units at unit $M$, as the lemma needs. I cross-checked this against the record at $S^3\times S^3$: there $\alpha=1/\sqrt{10}$, $\gamma=-2\alpha/3$, a $(2,2)$-split has $E=4(\alpha-\gamma)^2=10/9$ and $\tfrac12\sqrt E=\sqrt{10}/6=\theta_0(6)\cdot\tfrac12$, which is L126's $\mu=\tfrac12$ in $L_e$ units. Nothing found.

## 3. The pair bound

Given 3's matrix is the operator's matrix in $f_i$, since the $f_i$ are orthogonal of common norm $\sqrt2$ and uniform scaling changes no entry of the representing matrix.

The block acts on $V_{jk}=\{\sum_ix_i=0\}$. Because $D$ is Ricci-flat, row $i$ of the bracket sums to $(K_{ji}+K_{ki})-K_{jk}+\sum_{l\notin\{j,k\}}K_{il}=-K_{jk}$, so $\mathbf 1$ is an eigenvector and $\mathbf 1^\perp$ is invariant. The proof bounds the quadratic form on all of $\mathbb R^{n-2}$, which dominates the top eigenvalue on $\mathbf 1^\perp$, so the restriction is harmless.

The three estimates, at unit $x$:

- $\sum_id_ix_i^2\le\max_i\lvert d_i\rvert$. Correct.
- $-\kappa\le\lvert\kappa\rvert=\sqrt Z$. Correct.
- $x^{\mathsf T}Sx\le\lVert S\rVert_F$ by Cauchy–Schwarz over ordered index pairs, Lean's `quad_le_frob`. Correct, and $\lVert S\rVert_F^2=\sum_{i\ne l}K_{il}^2=2Y$ with $Y$ the unordered mass, so the ordered count is the one used.

$d_i^2=(K_{ji}+K_{ki})^2\le2(K_{ji}^2+K_{ki}^2)=2X_i$. The prose puts $X=X_{i^*}$ at the maximiser of $\lvert d_i\rvert$, so $d_i^2\le d_{i^*}^2\le2X$ for every $i$, which is Lean's `hd` as instantiated. Disjointness: $X$ uses $\{j,i^*\},\{k,i^*\}$, $Z$ uses $\{j,k\}$, and $Y$ uses pairs avoiding both $j$ and $k$, so the three sets are disjoint and $X+Y+Z\le1$. The weighted Cauchy–Schwarz $\sqrt2\sqrt X+1\cdot\sqrt Z+\sqrt2\sqrt Y\le\sqrt{5(X+Y+Z)}$ is Lean's `three_term_cs` with $p^2/2=X$, $q^2=Z$, $r^2/2=Y$. The bound $\sqrt5/2$ is therefore proved. It is not sharp, see section 10.

## 4. The normalisation

Conventions fix $K_{ab}=W_{abab}$ and $t=\sum_{a\ne b}K_{ab}^2$ over ordered pairs, with $t=2$ at a unit coordinate-diagonal $W$. On the diagonal locus the $\Lambda^2$ operator is diagonal in the pair basis with entries $K_{ab}$, $a<b$, so $\lVert D\rVert^2=\operatorname{tr}(D^2)=\sum_{a<b}K_{ab}^2$. Unit norm is therefore $\sum_{a<b}K_{ab}^2=1$, equivalently ordered $\lVert K\rVert_F^2=2$, and the lemma uses the unordered form consistently in both blocks. Nothing found.

## 5. The lower bound at padded $S^2\times S^2$

The printed matrix $K_{12}=K_{34}=-2/\sqrt{12}$, cross entries $1/\sqrt{12}$, is hollow, symmetric, has row sums $-2/\sqrt{12}+2/\sqrt{12}=0$, and has unordered mass $2\cdot\tfrac4{12}+4\cdot\tfrac1{12}=1$. It is a unit element of $\mathcal D_n$ at every $n\ge4$ after padding with zeros. $A=-4/\sqrt{12}$, $B=C=2/\sqrt{12}$ give $E=(16+4+4+8-4+8)/12=3$, so $\tfrac12\sqrt3$ is attained on $V_{1234}$, whose top eigenvector lies in $\mathcal D_n^\perp\cap\mathcal W_n$ by section 1.

**The sign is wrong for the name.** The $S^2\times S^2$ Weyl tensor has $\Lambda^2$ spectrum $(2,2,-1,-1,-1,-1)/\sqrt{12}$ with $\theta=\sqrt3/2=\theta_0(4)$, which the record states at [curvature-invariants.md](../findings/curvature-invariants.md) for Euclidean Schwarzschild, and on the diagonal locus that spectrum is the entries of $K$. Directly, with $(W^\#)_{ab,ab}=\sum_cK_{ac}K_{bc}$ (the form that returns $\mathrm{id}^\#=(n-2)\mathrm{id}$) and $s=1/\sqrt{12}$, $K_{12}=K_{34}=2s$, cross $-s$:

- $\sum_{a<b}K_{ab}^3=2\cdot8s^3-4s^3=12s^3$.
- Each of the four triangles has product $2s^3$, so $\langle W^\#,W\rangle=3\cdot8s^3=24s^3$.
- $P=36s^3=3/\sqrt{12}=\sqrt3/2>0$.

So padded $S^2\times S^2$ is $K_{12}=K_{34}=+2/\sqrt{12}$ with cross entries $-1/\sqrt{12}$, and the printed matrix is $-W_{S^2\times S^2}$, with $P=-\sqrt3/2$. **Correction**: flip the sign of all six entries, so $A=4/\sqrt{12}$, $B=C=-2/\sqrt{12}$. The conclusion is unaffected because $E$ is a quadratic form in $K$ and $\mathcal D_n$'s unit sphere is symmetric, and in fact both signs attain $\sqrt3/2$.

## 6. Banach's theorem as used

$L_DN=D\circ N$ and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, so $\langle L_DN,N\rangle=T(D,N,N)$ exactly. $T$ is fully symmetric (conventions, "$T$, third sense"), and $P(x)=\langle x,x\circ x\rangle=T(x,x,x)$ since $Q(x)=x\circ x$. Banach's theorem on a real Hilbert space gives $\sup_{\lVert x\rVert=1}\lvert T(x,x,x)\rvert=\sup\lvert T(x,y,z)\rvert$ over unit triples. $P$ is odd and $T$ changes sign under $x\mapsto-x$, so both suprema can be taken without absolute values, which is the form printed. Hence $\Lambda_n\le M(n)$ for $D,N\in\mathcal W_n$.

$\Lambda_n>\Theta_n$ would give $M(n)>\Theta_n$, contradicting the statement [problem.md](../findings/problem.md) fixes as Conjecture A, $\sup P=\Theta_n$, **which is its $n\ge12$ clause**. At $n=8,10$ the inequality $M(n)>\Theta_n$ already holds through padded $W_{\mathbb{CP}^2}$, and the $8\le n\le11$ clause removes that orbit, which $M(n)$ does not see. So the bold sentence is true as a statement of non-firing, and its "would refute" reading has force at $n\ge12$ only. A sentence saying so would stop a reader taking "even $n\ge8$" as the conjecture's range.

## 7. $\theta_0(n)^2>\tfrac54$ from $n=8$

$2(n-1)(n-2)/n^2>\tfrac54$ is $8n^2-24n+16>5n^2$, that is $3n^2-24n+16>0$, with roots $(24\pm\sqrt{384})/6=4\pm\tfrac{4}{3}\sqrt6$, the larger $\approx7.27$. At $n=7$ the value is $-5$ and at $n=8$ it is $16$, so "from $n=8$" is exact. Lean's `theta_sq_gt_five_quarters` states it over the reals.

Odd $n$: $\Theta_n^2>\tfrac54$ is $8(n-1)(n-3)>5(n+1)(n-2)$, that is $3n^2-27n+34>0$, which is $-8$ at $n=7$ and $34$ at $n=9$. So the lemma's constant also clears every odd $n\ge9$ and fails at $n=7$ ($\Theta_7^2=\tfrac65<\tfrac54$). The lemma compares with $\theta_0(n)$ and concludes at even $n$ only, which is correct, but the odd case it could have stated is left out, and Conjecture A is stated at both parities. With the sharp constant of section 10 the question disappears.

## 8. "Not a route input"

Post F67's argument takes $d=W_0$ and $\nu$ the orbit direction, obtains $\Lambda_n\ge\Theta_n/2$, and shows $\sqrt t\,\Theta_n+\frac{1-t}{\sqrt t}\cdot\frac{\Theta_n}2\ge\Theta_n$. It uses a lower bound on $\Lambda_n$ only, so no upper bound on $\Lambda_n$ can lower that ceiling, and the decoupled bound with the true $\Lambda_n$ is larger still. The lemma's phrase "$\sqrt5/2\ge\Theta_n/2$ leaves that ceiling where it was" is true but idle, since the ceiling is independent of any upper constant. The claim that L218 is not a route input is correct.

## 9. The range $n\ge5$

At $n=5,6,7$ the four-set blocks exist ($n\ge4$), the pair blocks have dimension $n-3\ge2$, L120's decomposition holds with the full sign group, and every step of sections 1–3 is dimension-free. At $n=4$ the four-set block is $V_{1234}$, each pair block is one-dimensional with $x=(1,-1)/\sqrt2$, and all bounds still hold, as does the lower bound. So the statement is true at $n\ge4$ and the hypothesis $n\ge5$ is used nowhere in the proof. With section 10, $\Lambda_4=\sqrt3/2=\Theta_4$, the falsifier sitting exactly at equality there.

## 10. Sharpness

**The pair block's supremum is exactly $\sqrt3/2$, by a single Cauchy–Schwarz that the three-piece estimate breaks apart.** Put $C=[n]\setminus\{j,k\}$ and use the unordered inner product $\langle K,G\rangle=\sum_{a<b}K_{ab}G_{ab}$ on hollow symmetric matrices. For $x\in\mathbb R^C$ the bracket's quadratic form is
$$q(x)=\sum_{i\in C}(K_{ji}+K_{ki})x_i^2-K_{jk}\lVert x\rVert^2+\sum_{i\ne l\in C}K_{il}x_ix_l=\langle K,G_x\rangle,$$
at $\lVert x\rVert=1$, where $G_x$ is the hollow symmetric matrix with $(G_x)_{ji}=(G_x)_{ki}=x_i^2$, $(G_x)_{jk}=-1$ and $(G_x)_{il}=2x_ix_l$ for $i\ne l\in C$. Then
$$\lVert G_x\rVert^2=2\sum_ix_i^4+1+4\sum_{i<l}x_i^2x_l^2=2\Big(\sum_ix_i^2\Big)^2+1=3,$$
so $q(x)\le\lVert K\rVert\,\lVert G_x\rVert=\sqrt3$ at every unit $K$ and unit $x$, and the pair block's top eigenvalue is at most $\tfrac{\sqrt3}2$. This needs neither Ricci-flatness of $K$ nor $x\in\mathbf 1^\perp$.

**It is attained.** Take $x\in\mathbf 1^\perp$ unit and $K=G_x/\sqrt3$. Row $j$ of $G_x$ sums to $\sum_ix_i^2-1=0$, row $k$ likewise, and row $i\in C$ sums to $2x_i^2+2x_i\sum_{l\ne i}x_l=2x_i\sum_lx_l=0$. So $K\in\mathcal D_n$ is unit and $q(x)=\sqrt3$, with $x\in V_{jk}$. At $\{j,k\}=\{1,2\}$ and $x=(e_3-e_4)/\sqrt2$ this $K$ is $K_{12}=K_{34}=-2/\sqrt{12}$ with cross entries $1/\sqrt{12}$, the lemma's own witness, which therefore attains $\sqrt3/2$ on a pair block as well as on the four-set block.

**Consequence.** With section 2, every block's top eigenvalue is at most $\sqrt3/2$ at every unit $D$, and section 5 attains it, so
$$\Lambda_n=\tfrac{\sqrt3}2\qquad\text{at every }n\ge4.$$
$\Lambda_n<\Theta_n$ then reads $\theta_0(n)^2>\tfrac34$, which is $(5n-4)(n-4)>0$, at even $n$, and $5n^2-29n+30>0$ at odd $n$, which holds from $n=5$ ($10>0$). So the falsifier fails at every $n\ge5$ and meets equality at $n=4$. Two consistency checks against the record: $\Lambda_n=\sqrt3/2\ge\Theta_n/2$ as post F67 requires, and the same quadratic form reproduces L122's orbit eigenvalue $\sqrt{10}/6$ and within-factor value $\sqrt{10}/12$ at $S^3\times S^3$.

**Why the proof lost the constant.** $\max_i\lvert d_i\rvert$ is reached only by $x$ concentrated at one index $i^*$, where $x^{\mathsf T}Sx=0$ by hollowness, and $\lVert S\rVert_F$ is reached only by a top eigenvector of $S$. The two cannot be attained together, and splitting $\langle K,G_x\rangle$ into three Cauchy–Schwarz pieces discards that.

**Does the block say more than the proof shows?** The printed claims do not overreach: the two bounds, the $\theta_0$ comparison and "does not fire at any even $n\ge8$" are all proved. The final sentence, "whether $\sqrt5/2$ is attained, or the pair block's true supremum lies nearer $\sqrt3/2$, is not settled here", is accurate about the proof and answered above in the negative for $\sqrt5/2$. **Correction**: replace the statement by $\Lambda_n=\sqrt3/2$ at every $n\ge4$, replace the pair-block paragraph by the $G_x$ argument, conclude non-firing at every $n\ge5$, and drop the sharpness sentence. The Lean side would replace `three_term_cs` and `pair_block_rayleigh` by one Cauchy–Schwarz against $G_x$ where at general $x$ the entry $(G_x)_{jk}$ is $-\lVert x\rVert^2$, so $\lVert G_x\rVert^2=3\lVert x\rVert^4$ and $q(x)\le\sqrt3\lVert x\rVert^2$.

## Overall verdict

**CONFIRMED as stated, with one sign correction and one strengthening.** Every printed inequality is proved and every step I attacked holds. The witness in the lower bound is $-W_{S^2\times S^2}$ rather than $W_{S^2\times S^2}$, harmless to the value. The pair-block estimate is loose, and a single Cauchy–Schwarz gives $\Lambda_n=\sqrt3/2$ exactly at every $n\ge4$, which closes I99's falsifier at every $n\ge5$ at both parities instead of at even $n\ge8$.

Other working-tree state at commit time: [reviews/REVIEW_r936.md](REVIEW_r936.md) was modified by another session and was left untouched and unread.
