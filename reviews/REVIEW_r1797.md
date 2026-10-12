# Review r1797: the double-rotation inequality (I121, R52)

Brief: [BRIEF_I121_double_rotation.md](BRIEF_I121_double_rotation.md). Claims as quoted from [2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md). Log: agent_logs/r1797-dblrot.log (gitignored, local only).

**Everything below is by hand from the definitions. No computation was run**, because every item reduced to a finite calculation in Pauli coefficients that an argument settles.

| # | claim | verdict |
|---|---|---|
| 1 | one-plane change and its exact condition | CONFIRMED, observations O1 to O3 |
| 2 | structural half: which entries form the blocks, signs | CONFIRMED for the double-rotation section, one wrong sentence in the first-attempt section (O4) |
| 3 | the formula at (pi/4, pi/4) | CONFIRMED, every term and factor |
| 4 | three pairings with Bianchi control the four-set block | CONFIRMED, and Bianchi is exactly what is needed (O6) |
| 5 | beyond second order | CONFIRMED, and it extends to the full Hessian over so(n) (O7) |
| 6 | block-constant corollary | REFUTED AS STATED (a gap in attribution), the corrected statement is CONFIRMED (F1) |
| 7 | classification | CONFIRMED for the agreement with I100, PLAUSIBLE for novelty (search-limited) |

## 1. One plane

- Take $g$ a rotation by $\varphi$ in the plane $(i,j)$. Then $\hat g$ fixes $e_i\wedge e_j$ and every $e_a\wedge e_b$ with $a,b\notin\{i,j\}$. For each $k\notin\{i,j\}$ it rotates the pair $(e_i\wedge e_k,\,e_j\wedge e_k)$ by $\varphi$.
- The new diagonal entry at a bivector $p$ is $(\hat g^{\mathsf T}p)^{\mathsf T}W(\hat g^{\mathsf T}p)$. Since $\hat g^{\mathsf T}p$ stays in $p$'s invariant plane, it depends only on the $2\times2$ block $\left(\begin{smallmatrix}a_{ik}&x_k\\x_k&a_{jk}\end{smallmatrix}\right)$. Conjugating that block by a rotation gives diagonal entries $m_k\pm(\cos2\varphi\,\delta_k\mp\sin2\varphi\,x_k)$, with $m_k$ the mean. The mass change is $2\sum_k[(\cos2\varphi\,\delta_k-\sin2\varphi\,x_k)^2-\delta_k^2]$, where the sign of the $\sin$ term depends on orientation and is immaterial over all $\varphi$. **Exact for every $\varphi$.**
- Maximality against every angle says $c^2\lVert\delta\rVert^2-2cs\langle\delta,x\rangle+s^2\lVert x\rVert^2\le\lVert\delta\rVert^2$ on the whole unit circle, since $(\cos2\varphi,\sin2\varphi)$ covers it. The form attains $\lVert\delta\rVert^2$ at $(1,0)$, so the condition is that $\left(\begin{smallmatrix}0&-p\\-p&\lVert x\rVert^2-\lVert\delta\rVert^2\end{smallmatrix}\right)$ is negative semidefinite. That holds iff $p=\langle\delta,x\rangle=0$ and $\lVert x\rVert\le\lVert\delta\rVert$. **Exactly as stated.** [one_plane](../lean/HamiltonsCubic/Results/DoubleRotation.lean) states this hypothesis over all $(c,s)$ with $c^2+s^2=1$, which is the right reading.
- **O1, the norm of $B_{ij}$.** The quoted text leaves $B_{ij}$ undefined. With $B_{ij}$ read as the pair-block component under the Hilbert–Schmidt norm, each $x_k$ counts twice, so $\lVert B_{ij}\rVert^2=2\lVert x\rVert^2\le2\lVert\delta\rVert^2=\tfrac12\sum_k(a_{ik}-a_{jk})^2$ holds exactly. Read as the profile vector, the bound holds with $\tfrac14$ and the stated $\tfrac12$ is loose by a factor two. It is true under either reading, but the note should say which one.
- **O2, sign convention.** $x_k=W_{ik,jk}$ has to be read as $W(e_i\wedge e_k,e_j\wedge e_k)$. With $e_{ab}$ defined only for $a<b$ and $i<k<j$, the sorted-index reading flips the sign of $x_k$ alone, since $e_j\wedge e_k=-e_{kj}$ while $e_i\wedge e_k=e_{ik}$. That flip changes $\langle\delta,x\rangle$. The double-rotation formula is safe because its planes $(1,2)$ and $(3,4)$ have no index between their two indices, and the two flips at $x^{34}_1,x^{34}_2$ cancel. The other two pairings, and any one-plane statement at a general $(i,j)$, need the wedge-order reading written out. For example, $x^{13}_2=W(e_1\wedge e_2,e_3\wedge e_2)=-W_{12,23}$.
- **O3, wording.** "Moves only the diagonal entries $a_{ik},a_{jk}$ and the pair-block profile" is right about what the diagonal-mass change depends on. It is wrong as a statement about the operator: the rotation also moves, for instance, $W_{ik,lm}$ against $W_{jk,lm}$.

## 2. Structural half of the double rotation

- $g=R_{12}(\theta_1)R_{34}(\theta_2)$. Under $\hat g$:
  - $e_{12}$, $e_{34}$ and $e_{mn}$ ($m,n\ge5$) are fixed;
  - $(e_{1m},e_{2m})$ rotates by $\theta_1$ and $(e_{3m},e_{4m})$ by $\theta_2$ for $m\ge5$;
  - $\operatorname{span}\{e_{13},e_{14},e_{23},e_{24}\}=V_{12}\otimes V_{34}$ through $e_a\wedge e_b\leftrightarrow e_a\otimes e_b$ ($a\in\{1,2\}$, $b\in\{3,4\}$, always $a<b$, so there are no orientation signs), acted on by $R(\theta_1)\otimes R(\theta_2)$.
- So the only diagonal entries that change are those of $e_{13},e_{14},e_{23},e_{24}$ and of $e_{1m},e_{2m},e_{3m},e_{4m}$ for $m\ge5$. Each depends only on its invariant block, as in §1. **Confirmed.**
- Signs. In the ordered basis $(13,14,23,24)$, the entries are $M_{03}=W_{13,24}=v$ and $M_{12}=W_{14,23}=w$, and $M_{01}=W_{13,14}=W(e_3\wedge e_1,e_4\wedge e_1)=x^{34}_1$ after two sign flips. Likewise $M_{23}=W_{23,24}=x^{34}_2$, $M_{02}=W_{13,23}=x^{12}_3$ and $M_{13}=W_{14,24}=x^{12}_4$. **All consistent with the stated orientation.**
- **O4, one wrong sentence in the first-attempt section.** "moves the diagonal entries of the **six** pairs in $\{i,j,k,l\}$" is false: $e_{ij}$ and $e_{kl}$ are fixed, so four of the six move. The double-rotation section itself gets this right. "Degree two in each angle" should read degree two in $(\cos2\theta,\sin2\theta)$.

## 3. The formula at $(\pi/4,\pi/4)$

- Symmetric $4\times4$ matrices have dimension 10: $\{I,Z,X\}^{\otimes2}$ and $J\otimes J$, all mutually orthogonal with $\operatorname{tr}(P^{\mathsf T}P)=4$. $RZR^{\mathsf T}$ and $RXR^{\mathsf T}$ rotate in the $(Z,X)$ plane by $2\theta$, while $RIR^{\mathsf T}=I$ and $RJR^{\mathsf T}=J$. The diagonal is $\alpha_{II}\pm\alpha_{IZ}\pm\alpha_{ZI}\pm\alpha_{ZZ}$ over the four sign patterns, which gives mass $4(\alpha_{II}^2+\alpha_{IZ}^2+\alpha_{ZI}^2+\alpha_{ZZ}^2)$. **Confirmed.**
- At $2\theta_1=2\theta_2=\pi/2$ the new coefficients are $\alpha_{IZ}\to\pm\alpha_{IX}$, $\alpha_{ZI}\to\pm\alpha_{XI}$ and $\alpha_{ZZ}\to\pm\alpha_{XX}$. The block change is $4(\alpha_{XX}^2-\alpha_{ZZ}^2+\alpha_{IX}^2-\alpha_{IZ}^2+\alpha_{XI}^2-\alpha_{ZI}^2)$.
- The coefficients, from $\alpha_{PQ}=\tfrac14\operatorname{tr}(M\,P\otimes Q)$:
  - $\alpha_{ZZ}=\tfrac14\square$ and $\alpha_{XX}=\tfrac12(v+w)$, giving $(v+w)^2-\tfrac14\square^2$;
  - $\alpha_{IX}=\tfrac12(x^{34}_1+x^{34}_2)$ and $\alpha_{IZ}=\tfrac14(a_{13}-a_{14}+a_{23}-a_{24})=\tfrac12(\delta^{34}_1+\delta^{34}_2)$;
  - $\alpha_{XI}=\tfrac12(x^{12}_3+x^{12}_4)$ and $\alpha_{ZI}=\tfrac12(\delta^{12}_3+\delta^{12}_4)$.
- The outside sum is the one-plane change at $\varphi=\pi/4$, $2\sum[x^2-\delta^2]$, applied to each of the two planes. **The factor $\tfrac14$ on $\square^2$ and the factor $2$ outside are both right.**
- It matches [block_exchange](../lean/HamiltonsCubic/Results/DoubleRotation.lean) term by term under $0,1,2,3=13,14,23,24$.
- **Independent consistency check against the record.** [r760](REVIEW_r760.md) §2 rotates a coordinate-diagonal operator in the planes $(1,3)$ and $(2,4)$ and finds a four-set entry $\tfrac{\alpha-\gamma}2$. In that pairing $\square=2(\alpha-\gamma)$ and $\alpha_{JJ}=0$, so the prediction is $v'=w'=\alpha'_{XX}=\pm\square/4=\pm\tfrac{\alpha-\gamma}2$. **They agree.**
- Global maximality over $O(n)\supset SO(n)$ makes the change $\le0$. Dropping the nonnegative $x$ terms then bounds $(v+w)^2$ by diagonal data alone.

## 4. The three pairings with Bianchi

- Pairing $(13)(24)$: $V_{13}\otimes V_{24}$ has basis $e_1\wedge e_2=e_{12}$, $e_1\wedge e_4=e_{14}$, $e_3\wedge e_2=-e_{23}$ and $e_3\wedge e_4=e_{34}$. That gives $\alpha_{XX}=\tfrac12(u-w)$.
- Pairing $(14)(23)$: $e_{12}$, $e_{13}$, $e_4\wedge e_2=-e_{24}$ and $e_4\wedge e_3=-e_{34}$. That gives $\alpha_{XX}=-\tfrac12(u+v)$. **Both as stated.**
- Bianchi: $W_{13,42}=-v$, so the identity reads $u-v+w=0$. Correct.
- **O6.** On $(u,v,w)$ the three forms $v+w$, $u-w$ and $u+v$ have rank **2**. Their common kernel is spanned by $(1,-1,1)$, which is exactly the direction Bianchi removes. So without Bianchi the three pairings leave one direction free, and with it they determine the block.
  - On the Bianchi plane any two already suffice. With $w=v-u$, $s_1=v+w=2v-u$ and $s_3=u+v$, so $v=(s_1+s_3)/3$ and $u=(2s_3-s_1)/3$.
  - The note should say that Bianchi is necessary here and not only used.

## 5. Beyond second order

- On the torus, $\alpha'_{ZZ}=c_1c_2\alpha_{ZZ}+c_1s_2\alpha_{ZX}+s_1c_2\alpha_{XZ}+s_1s_2\alpha_{XX}$, up to signs, with $c_i=\cos2\theta_i$ and $s_i=\sin2\theta_i$.
- In $\alpha'^2_{ZZ}$, $\alpha_{XX}$ appears at second order only in $2s_1s_2c_1c_2\alpha_{ZZ}\alpha_{XX}\approx8\theta_1\theta_2\,\alpha_{ZZ}\alpha_{XX}$. $\alpha_{XX}^2$ enters at fourth order. **Confirmed.**
- **O7, stronger.** The statement holds for the full Hessian of the diagonal mass over $\mathfrak{so}(n)$ at the identity:
  - The first-derivative term $([\hat A,W]_{pp})^2$ involves only $W_{pq}$ with $q$ one index from $p$, which are pair entries.
  - In $W_{pp}[\hat A,[\hat A,W]]_{pp}$, a four-set entry $W_{qr}$ arises only through two single-index changes of $p$ in disjoint planes. So it carries coefficient $t_{ac}t_{bd}$ for disjoint planes $(a,c),(b,d)$, which is a double-rotation torus direction.
  - The four-set block therefore enters the full Hessian only through each pairing's $\alpha_{ZZ}\alpha_{XX}$ product.

## 6. The block-constant corollary: F1

- With $\{1,2\}$ in one block and $\{3,4\}$ in another of a block-constant diagonal:
  - $a_{1m}=a_{2m}$ and $a_{3m}=a_{4m}$ for every $m$, so every $\delta^{12}$ and $\delta^{34}$ vanishes.
  - $a_{13}=a_{14}=a_{23}=a_{24}$ is one cross entry, so $\square=0$.
  - This holds for any block-constant pattern in the record's sense ([diagonal-half.md:96](../findings/diagonal-half.md)), cross constants differing between blocks included, and so for products of spheres in particular. **Confirmed.**
- **F1, the gap.** The double-rotation inequality then reads $(v+w)^2+(x^{34}_1+x^{34}_2)^2+(x^{12}_3+x^{12}_4)^2+2\sum_{m\ge5}[(x^{12}_m)^2+(x^{34}_m)^2]\le0$. It forces $v+w=0$ and $x^{12}_m=x^{34}_m=0$ for $m\ge5$. For the in-block entries it forces **only the sums** $x^{12}_3+x^{12}_4=0$ and $x^{34}_1+x^{34}_2=0$. It does not force $x^{12}_3$, $x^{12}_4$, $x^{34}_1$ or $x^{34}_2$ individually to vanish.
- **Corrected statement.** The one-plane bound of §1 gives $\lVert x^{12}\rVert\le\lVert\delta^{12}\rVert=0$, and likewise for $x^{34}$, so every pair profile vanishes. That is true, but it comes from the one-plane inequality alone. **The double rotation's only new content at a block-constant diagonal is $v+w=0$.** The note should also say that the corollary presupposes a globally maximising frame.

## 7. Classification

- **Agreement with I100.** I re-derived the second derivative of $t(\varphi)=\lVert\pi_F(e^{-\varphi\,\mathrm{ad}_\xi}(D+N))\rVert^2$ at $0$:
  - $\pi_F\,\mathrm{ad}_\xi D=0$ for diagonal $D$, and $\langle D,\mathrm{ad}^2_\xi D\rangle=-\lVert\mathrm{ad}_\xi D\rVert^2$.
  - So $t''=2\lVert\pi_F\mathrm{ad}_\xi N\rVert^2-2\lVert\mathrm{ad}_\xi D\rVert^2-2\langle\mathrm{ad}_\xi D,\mathrm{ad}_\xi N\rangle$. That is [2026-09-14-I100-derivation.md](2026-09-14-I100-derivation.md) line 13's condition.
  - At a plane rotation the one-plane form has second-order coefficient $4(\lVert x\rVert^2-\lVert\delta\rVert^2)$ and first-order coefficient $\propto\langle\delta,x\rangle$, matching $\langle n_{kl},x^{(kl)}\rangle=0$.
  - Mind the notation swap: I100's $x^{(kl)}$ is the diagonal difference, so $x^{(kl)}_i=K_{il}-K_{ik}$, a multiple of $\delta$, and $n_{kl}$ is the profile.
  - Given the first-order condition, the finite-angle condition and the second-order condition coincide. **CONFIRMED.**
- **Novelty.** A grep of findings/ for double rotation, two-plane, rectangle difference and $\pi/4$ finds no prior statement. [r353](REVIEW_r353.md) and [r760](REVIEW_r760.md) have the reverse flow, and it is consistent with §3's formula. **PLAUSIBLE**, since this is a search and not a proof of absence.

## Lean

The three declarations match the claims they are listed against (§1 and §3). Nothing in the Lean file covers the structural half, the pairings, the Hessian statement or the corollary, as the table says. The prose of §2, §4, §5 and §6 above is the check for those.
