# REVIEW r1798: the double-rotation inequality (I121, route R52)

Brief: [BRIEF_I121_double_rotation.md](BRIEF_I121_double_rotation.md). Log: [agent_logs/r1798-dblrot.log](../agent_logs/r1798-dblrot.log). Claims read from the brief's verbatim quotation of [2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md). Footing: analysis only. No computation was run: every claim was settled by hand from the definitions, and the Gate 1 (b) screen script was read to confirm it conjugates the operator directly.

**Overall: CONFIRMED WITH CORRECTIONS.** The double-rotation formula is right term by term, including signs, the factor $\tfrac14$ and the factor $2$. Two written statements are inaccurate as worded, one conclusion is attributed to the wrong inequality, and one claim is argued only on the torus although it holds on all of $\mathfrak{so}(n)$.

| # | claim | verdict |
|---|---|---|
| 1 | one-plane change and exact maximality condition | CONFIRMED, with a definitional gap ($B_{ij}$ undefined in the quoted text) |
| 2 | structural half: which entries form the blocks, signs | CONFIRMED for the $(\pi/4,\pi/4)$ formula. The framing sentence "moves the diagonal entries of the six pairs" is REFUTED as worded: it moves four |
| 3 | formula at $(\pi/4,\pi/4)$ | CONFIRMED |
| 4 | three pairings with Bianchi control the four-set block | CONFIRMED, with a sharper exact identity |
| 5 | beyond second order | CONFIRMED. The written argument covers only the torus. The statement holds on the full Hessian (argument below) |
| 6 | block-constant corollary | CONFIRMED as a conclusion, with a GAP: the double rotation forces only the sums $x^{12}_3+x^{12}_4$ and $x^{34}_1+x^{34}_2$ to vanish. Vanishing of each entry comes from the one-plane bound |
| 7 | classification | CONFIRMED |

## 1. One plane

- **Invariant subspaces.** With $g$ a rotation in the plane $(i,j)$, $\hat g$ fixes $e_i\wedge e_j$ (it multiplies by $\det=1$) and every $e_a\wedge e_b$ with $\{a,b\}\cap\{i,j\}=\emptyset$. It acts on each $\mathop{\mathrm{span}}\{e_i\wedge e_k,e_j\wedge e_k\}$, $k\notin\{i,j\}$, as the $2\times2$ rotation $R(\varphi)$. The diagonal entry of $\hat gW\hat g^{\mathsf T}$ at $P$ is $(\hat g^{\mathsf T}e_P)^{\mathsf T}W(\hat g^{\mathsf T}e_P)$, and $\hat g^{\mathsf T}e_P$ stays in $P$'s invariant subspace, so only the compressions of $W$ to those subspaces matter. For each $k$ the compression is $\left(\begin{smallmatrix}a_{ik}&x_k\\x_k&a_{jk}\end{smallmatrix}\right)=\mu_kI+\delta_kZ+x_kX$, with $x_k=W_{ik,jk}$ in the antisymmetrically extended convention (the pair $e_i\wedge e_k,e_j\wedge e_k$ is the one that rotates as a vector pair, whatever the order of $k$ relative to $i,j$).
- **The change.** Its diagonal mass is $2(\mu_k^2+\delta_k^2)$, and conjugation by $R(\varphi)$ sends $\delta_k\mapsto\cos2\varphi\,\delta_k-\sin2\varphi\,x_k$ (sign of the sine fixed by the rotation's orientation, irrelevant below). So the change is $2\sum_k[(\cos2\varphi\,\delta_k-\sin2\varphi\,x_k)^2-\delta_k^2]$, exactly, for every $\varphi$.
- **The condition.** With $\psi=2\varphi$, $A=\lVert x\rVert^2-\lVert\delta\rVert^2$, $B=\langle\delta,x\rangle$, the change is $2[A\sin^2\psi-B\sin2\psi]=A(1-\cos2\psi)-2B\sin2\psi$, whose maximum over $\psi$ is $A+\sqrt{A^2+4B^2}$. That is $\le0$ iff $B=0$ and $A\le0$. Exactly as claimed.
- **Gap, definitional.** $\lVert B_{ij}\rVert$ is not defined in the quoted text. Read as the Hilbert–Schmidt norm of $W$'s $\chi_{ij}$ component (entries $(ik,jk)$ and $(jk,ik)$, the pairs $P,Q$ with $P\triangle Q=\{i,j\}$), $\lVert B_{ij}\rVert^2=2\lVert x\rVert^2\le2\lVert\delta\rVert^2=\tfrac12\sum_k(a_{ik}-a_{jk})^2$, which is the stated bound. Under the reading $\lVert B_{ij}\rVert=\lVert x\rVert$ the bound would hold with room to spare. The note should state the reading.
- **Second order coincides with finite angle.** CONFIRMED: the change is a quadratic form in $(\cos2\varphi,\sin2\varphi)$ minus a constant, and its second-order conditions at $\psi=0$ ($B=0$, $A\le0$) are the finite-angle ones.

## 2. The structural half

- **Which bivectors move.** $g=R_{12}(\theta_1)R_{34}(\theta_2)$. Then $\hat g$ fixes $e_{12}$, $e_{34}$ and $e_{mn}$ for $m,n\ge5$. It acts as $R(\theta_1)$ on $\mathop{\mathrm{span}}\{e_{1m},e_{2m}\}$ and as $R(\theta_2)$ on $\mathop{\mathrm{span}}\{e_{3m},e_{4m}\}$ for each $m\ge5$, and as $R(\theta_1)\otimes R(\theta_2)$ on $V=\mathop{\mathrm{span}}\{e_{13},e_{14},e_{23},e_{24}\}$. The last holds with no sign, since $e_{ab}=e_a\wedge e_b\mapsto g_1e_a\wedge g_2e_b$ and every $a\in\{1,2\}$ is less than every $b\in\{3,4\}$, so $e_{ab}\leftrightarrow e_a\otimes e_b$ is orientation-consistent. By the argument in section 1 only the compressions to these subspaces enter. **So the diagonal entries that change are those of $e_{13},e_{14},e_{23},e_{24}$ and of $e_{1m},e_{2m},e_{3m},e_{4m}$, $m\ge5$, as the brief asks. CONFIRMED.**
- **Correction to the framing sentence.** "A rotation in two planes $(i,j)$ and $(k,l)$ moves the diagonal entries of the six pairs in $\{i,j,k,l\}$" is wrong as written. The diagonal entries of $e_{ij}$ and $e_{kl}$ are fixed, so four of the six move (plus the pairs with an outside index). The later, exact section has it right.
- **Also loose**: "a trigonometric polynomial of degree two in each angle" is degree two in $(\cos2\theta_r,\sin2\theta_r)$, i.e. degree four in $\theta_r$. Harmless, but worth stating in the doubled angle as the one-plane bullet does.
- **The pair blocks inside $V$.** The $\chi_{12}$ profile at $k=3,4$ is $x^{12}_3=W_{13,23}$, $x^{12}_4=W_{14,24}$. The $\chi_{34}$ profile at $k=1,2$ is $x^{34}_1=W_{31,41}=W_{13,14}$ and $x^{34}_2=W_{32,42}=W_{23,24}$ (two sign flips cancel). These sit in the $4\times4$ block, not in separate $2\times2$ blocks, which is why the formula carries their sums.

## 3. The formula at $(\pi/4,\pi/4)$

Write the block $M$ of $W$ on $V$ as $\sum\alpha_{\sigma\tau}\,\sigma\otimes\tau$ over $\sigma,\tau\in\{I,Z,X\}$, plus $\alpha_{JJ}J\otimes J$: that is $9+1=10$ symmetric generators, the dimension of symmetric $4\times4$. With $\alpha_{\sigma\tau}=\tfrac14\mathop{\mathrm{tr}}(M\,\sigma\otimes\tau)$:

- $M_{ab,ab}=\alpha_{II}+s_b\alpha_{IZ}+s_a\alpha_{ZI}+s_as_b\alpha_{ZZ}$ ($s=+1$ on $1,3$ and $-1$ on $2,4$), so the block's diagonal mass is $4(\alpha_{II}^2+\alpha_{IZ}^2+\alpha_{ZI}^2+\alpha_{ZZ}^2)$ by orthogonality of the four sign characters. CONFIRMED.
- $\alpha_{ZZ}=\tfrac14(a_{13}-a_{14}-a_{23}+a_{24})=\tfrac14\square$. $\alpha_{IZ}=\tfrac14(a_{13}-a_{14}+a_{23}-a_{24})=\tfrac12(\delta^{34}_1+\delta^{34}_2)$. $\alpha_{ZI}=\tfrac14(a_{13}+a_{14}-a_{23}-a_{24})=\tfrac12(\delta^{12}_3+\delta^{12}_4)$.
- $X\otimes X$ swaps $e_{13}\leftrightarrow e_{24}$ and $e_{14}\leftrightarrow e_{23}$, so $\alpha_{XX}=\tfrac12(v+w)$. $I\otimes X$ swaps $e_{13}\leftrightarrow e_{14}$, $e_{23}\leftrightarrow e_{24}$, so $\alpha_{IX}=\tfrac12(x^{34}_1+x^{34}_2)$. $X\otimes I$ swaps $e_{13}\leftrightarrow e_{23}$, $e_{14}\leftrightarrow e_{24}$, so $\alpha_{XI}=\tfrac12(x^{12}_3+x^{12}_4)$. All with plus signs, as stated.
- $J\otimes J$ sends $e_{13}\mapsto e_{24}$, $e_{14}\mapsto-e_{23}$, so $\alpha_{JJ}=\tfrac12(v-w)$, invariant under the torus. $I$ and $J$ commute with every $R(\theta)$, and $(Z,X)$ rotates by $2\theta$ in each factor. CONFIRMED.
- At $\theta_1=\theta_2=\pi/4$ each factor sends $Z\mapsto\pm X$, so the new diagonal coefficients are $\alpha_{II},\pm\alpha_{IX},\pm\alpha_{XI},\pm\alpha_{XX}$. The block change is $4[(\alpha_{XX}^2-\alpha_{ZZ}^2)+(\alpha_{IX}^2-\alpha_{IZ}^2)+(\alpha_{XI}^2-\alpha_{ZI}^2)]=(v+w)^2-\tfrac14\square^2+[(x^{34}_1+x^{34}_2)^2-(\delta^{34}_1+\delta^{34}_2)^2]+[(x^{12}_3+x^{12}_4)^2-(\delta^{12}_3+\delta^{12}_4)^2]$.
- Each $2\times2$ block at $m\ge5$ contributes $2(x_m^2-\delta_m^2)$ by section 1 at $\varphi=\pi/4$, which gives the factor $2$ on the outside sum.
- **Sign conventions are immaterial**: every rotation-orientation sign enters squared, so $(\pm\pi/4,\pm\pi/4)$ all give the same formula. The formula uses symmetry only (Weyl and criticality unused), as the note says. "$\le0$ at a global maximiser" is immediate, since the rotated frame is a competitor. Local maximality would not suffice, and the note correctly asks for global.

## 4. The three pairings with Bianchi

- Pairing $\{13|24\}$, planes $(1,3),(2,4)$: $V'=\mathop{\mathrm{span}}\{e_1,e_3\}\otimes\{e_2,e_4\}$ with basis $e_1\wedge e_2,e_1\wedge e_4,e_3\wedge e_2,e_3\wedge e_4$. $\alpha'_{XX}=\tfrac12(W(e_{12},e_{34})+W(e_{14},e_3\wedge e_2))=\tfrac12(u-w)$.
- Pairing $\{14|23\}$, planes $(1,4),(2,3)$: basis $e_1\wedge e_2,e_1\wedge e_3,e_4\wedge e_2,e_4\wedge e_3$. $\alpha''_{XX}=\tfrac12(W(e_{12},e_4\wedge e_3)+W(e_{13},e_4\wedge e_2))=-\tfrac12(u+v)$. CONFIRMED up to sign, as stated.
- Bianchi $W_{12,34}+W_{13,42}+W_{14,23}=u-v+w=0$ leaves the four-set block two-dimensional, parametrised by $(v,w)$ with $u=v-w$. The three combinations are $v+w$, $v-2w$, $2v-w$, any two of which are independent (determinants $-3$, $-3$, $3$). **Sharper and exact**: $(v+w)^2+(u-w)^2+(u+v)^2=6(v^2-vw+w^2)=3(u^2+v^2+w^2)$. So the three inequalities summed bound three times the four-set block's squared entries by the three rectangle differences plus slack. The note's "control" is right and this identity is the form to record.

## 5. Beyond second order

- **On the torus**: with $c_r=\cos2\theta_r$, $s_r=\sin2\theta_r$, the new $\alpha_{ZZ}=c_1c_2\alpha_{ZZ}-c_1s_2\alpha_{ZX}-s_1c_2\alpha_{XZ}+s_1s_2\alpha_{XX}$. Squared, $\alpha_{XX}$ appears as $2c_1c_2s_1s_2\alpha_{ZZ}\alpha_{XX}$ (second order, $\approx8\theta_1\theta_2\alpha_{ZZ}\alpha_{XX}$) and as $s_1^2s_2^2\alpha_{XX}^2$ (fourth order), and nowhere else in the block or the $m\ge5$ blocks. CONFIRMED.
- **Gap**: "second-order frame data sees the four-set block only through the rectangle difference" is a claim about the Hessian on all of $\mathfrak{so}(n)$, and the written step computes only the torus. It does hold. With $F(R)=\sum_PR_{PP}^2$, $F''$ along generators $A,B$ is $2\sum_P([A,R]_{PP}[B,R]_{PP}+R_{PP}[A,[B,R]]_{PP})$ (symmetrised). For a plane generator $[\hat L_{ij},R]_{PP}$ involves only pair-profile entries, so the first term carries no four-set entry. In the second term, an entry $R_{Q,Q'}$ with $Q\cap Q'=\emptyset$ reached from $P$ by one move of each generator needs both indices of $P$ moved, one by each generator, which forces the two planes to be disjoint. Generators sharing an index ($\hat L_{12},\hat L_{13}$) never reach a disjoint pair. So four-set entries appear only in the cross entries $H(L_{ij},L_{kl})$ with $\{i,j\}\cap\{k,l\}=\emptyset$, weighted by diagonal entries, and the torus computation identifies that weight as the pairing's rectangle difference. The note should carry this argument, or restrict its claim to the torus.

## 6. The block-constant corollary

- For a block-constant diagonal with $\{1,2\}$ in one factor and $\{3,4\}$ in the other, $a_{1m}=a_{2m}$ and $a_{3m}=a_{4m}$ for every $m$ (the two indices share a factor), so every $\delta^{12}_m$ and $\delta^{34}_m$ vanishes, including $m\in\{1,2,3,4\}$. $a_{13},a_{14},a_{23},a_{24}$ are all cross-factor, hence equal, so $\square=0$. CONFIRMED.
- The inequality then reads (sum of squares) $\le0$, forcing $v+w=0$, $x^{12}_m=x^{34}_m=0$ for $m\ge5$, and **only the sums** $x^{12}_3+x^{12}_4=0$ and $x^{34}_1+x^{34}_2=0$. **Gap**: "forces every pair profile $x^{12},x^{34}$ to vanish" does not follow from the double rotation at the four in-set entries. It does follow, and more simply, from the one-plane bound $\lVert x\rVert\le\lVert\delta\rVert=0$, which kills every entry of every pair profile whose $\delta$ vanishes. So the double rotation's new content at a block-constant diagonal is exactly $v+w=0$ for pairings aligned with the factors. The pairings $\{13|24\}$ and $\{14|23\}$ cross the factors, so their $\delta$ and $\square$ need not vanish and give no conclusion. Correct the attribution.

## 7. Classification

- **Agreement with the I100 derivation.** Its first-order condition $\langle n_{kl},x^{(kl)}\rangle=0$ uses $x^{(kl)}$ for the diagonal differences and $n_{kl}$ for the off-diagonal profile, the reverse of this note's letters, and is $\langle\delta,x\rangle=0$ here. Its second-order condition $\lVert\pi_F\mathop{\mathrm{ad}}_\xi N\rVert^2\le\lVert\mathop{\mathrm{ad}}_\xi D\rVert^2+\langle\mathop{\mathrm{ad}}_\xi D,\mathop{\mathrm{ad}}_\xi N\rangle$ at a plane generator has cross term $0$ (the entries $[\xi,N]_{ik,jk}$ involve $N$'s diagonal, which is zero), $\lVert\pi_F\mathop{\mathrm{ad}}_\xi N\rVert^2=8\lVert x\rVert^2$ and $\lVert\mathop{\mathrm{ad}}_\xi D\rVert^2=8\lVert\delta\rVert^2$, giving $\lVert x\rVert\le\lVert\delta\rVert$. CONFIRMED. The notational swap of $x$ between the two notes is worth a sentence.
- **New to the record.** A grep of [findings/](../findings/) for "rectangle", "double rotation" and "two-plane rotation" returns nothing. [r353](REVIEW_r353.md) (line 51) and [r760](REVIEW_r760.md) record the reverse flow: a coordinate-diagonal operator acquiring four-set entries under a two-plane rotation. CONFIRMED.

## Corrections owed to the note

1. "moves the diagonal entries of the six pairs in $\{i,j,k,l\}$" should read "four of the six pairs (those of $e_{ik},e_{il},e_{jk},e_{jl}$)", since $e_{ij},e_{kl}$ are fixed.
2. Define $\lVert B_{ij}\rVert$ as the HS norm of the $\chi_{ij}$ component, so that $\lVert B_{ij}\rVert^2=2\lVert x\rVert^2$.
3. Block-constant corollary: attribute the vanishing of the pair profiles to the one-plane bound. The double rotation contributes $v+w=0$ and only the sums at $k\in\{1,2,3,4\}$.
4. "Beyond second order": add the all-generators argument of section 5, or restrict to the torus.
5. Record the exact identity $(v+w)^2+(u-w)^2+(u+v)^2=3(u^2+v^2+w^2)$ under Bianchi.
