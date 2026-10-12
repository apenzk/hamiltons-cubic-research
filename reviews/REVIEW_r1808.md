# REVIEW r1808: L224 step 4 on the operators (L224Step4.lean), the rank-one comparison with a diagonal tensor of equal norm

**Verdict: CONFIRMED WITH OBSERVATIONS.** Commit 21278620 states L224's step 4 as an existence theorem on the record's objects: every $D+\nu$ with $D$ Weyl of character $1$ and $\nu$ Weyl of character $\varepsilon_j\varepsilon_k$ has a Weyl $W'$ of character $1$ with $\lVert W'\rVert=\lVert D+\nu\rVert$ and $P(D+\nu)\le P(W')$, built as the record's $W'=E+D^-_{\sqrt s\,z_*}$. The maximiser formulation gives the record's $\lambda$ and the record's bound, the plane is the record's $\{z\in\mathbb R^{n-2}:\sum z=0\}$ embedded at $z_j=z_k=0$, the $s=0$ branch is the record's, and nothing about $\Theta_n$ or L57 is claimed. The observations concern what the existential leaves unexported for step 5 and two bookkeeping points in [lean/INDEX.md](../lean/INDEX.md).

Footing: analysis only. The runs were one compile with `lake env lean HamiltonsCubic/Results/L224Step4.lean` (exit 0, no output) and one call of `python3 scripts/misc/axiom_audit.py --only L224Step4.lean` (8/8 clean on the standard three). The objects in section 6 are hand evaluations in exact arithmetic at $n=4$ and $n=5$, screens at single points and no evidence for the general claim.

**Summary:** step 4 is faithfully formalised, with the equal-norm reading of "unit" and the maximiser reading of "top eigenvector" both exact, and the INDEX repairs from r1807 are in place except that `Dminus_weight` is still not described as the weight property.

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | `vy_smul`, `Gy_smul`: $v(tz)=tv(z)$, $G_{tz}=t^2G_z$ | CONFIRMED |
| 2 | `qE`, `qE_smul`, `qE_zero`, `continuous_qE`: the record's $q_E(z)=\langle E,G_z\rangle$, homogeneous of degree 2 and continuous | CONFIRMED |
| 3 | `exists_qE_max`: a maximiser on the unit sphere of $\{z_j=z_k=0,\ \sum z=0\}$ with $q_E(z)\le\lVert z\rVert^2q_E(z_*)$ on the plane, the record's $\lambda$ and bound | CONFIRMED WITH OBSERVATIONS (O1) |
| 4 | `cubic_even_odd`: $P(E+D^-_z)=P(E)+3q_E(z)$ at a swap-even Weyl $E$ of character $1$ | CONFIRMED |
| 5 | `L224_step4`: step 4's content with "unit" read as equal norm | CONFIRMED WITH OBSERVATIONS (O2) |
| 6 | The $s=0$ branch, $W'=E$ | CONFIRMED |
| 7 | No claim about $\le\Theta_n$ or L57 | CONFIRMED |
| 8 | [lean/INDEX.md:155](../lean/INDEX.md#L155), the L224 row: step 4 sentence, r1807 repairs O1, O3, O4, owed list | CONFIRMED WITH OBSERVATIONS (O3) |
| 9 | [lean/INDEX.md:152](../lean/INDEX.md#L152), the L222 row's revised Weyl-ness sentence (r1807 O2) | CONFIRMED WITH OBSERVATIONS (O4) |
| 10 | Axiom audit and compile | CONFIRMED |

## 1. The record, verbatim

- L224 step 4, [second-order.md:1619](../findings/second-order.md#L1619): "**Rank one.** Let $\lambda$ be the top eigenvalue of the quadratic form $q_E(z)=\langle E,G_z\rangle$ on $\{\sum z=0\}$ and $z_*$ a unit eigenvector for it. Then $q_E(y)+q_E(x)\le\lambda s=q_E(\sqrt s\,z_*)$, so $W'=E+D^-_{\sqrt sz_*}$ is a unit diagonal tensor with $P(W)\le P(E)+3\lambda s=P(W')\le\Theta_n$ by L57."
- L224 proof preamble, [second-order.md:1615](../findings/second-order.md#L1615): "Indices $a,b$ run over $a\notin\{j,k\}$, and vectors $y,x,z$ live in $\{z\in\mathbb R^{n-2}:\sum z=0\}$. $G_z$ is L222's diagonal tensor with $K_{ja}=K_{ka}=z_a^2$, $K_{jk}=-\lVert z\rVert^2$, $K_{ab}=2z_az_b$."
- L224 step 1: "So $W=E+D^-_y+\nu_x$ and $\lVert W\rVert^2=\lVert E\rVert^2+2s$ with $s=\lVert y\rVert^2+\lVert x\rVert^2$."
- L224 step 3: "$$P(W)=P(E)+3\langle E,G_y\rangle+3\langle E,G_x\rangle=P(E)+3\langle E,\mathcal G(C)\rangle .$$"
- L224 step 5: "At $s=0$, $W=E$ is diagonal."

## 2. The quadratic form and its maximiser (claims 1 to 3)

- `vy j k z` zeroes the entries at $j,k$ and keeps the rest, so `Gy j k z` and hence `qE j k E z` depend only on the entries indexed by $a\notin\{j,k\}$. `Gy`'s off-diagonal entries are the preamble's $G_z$ (checked in r1796 and r1807), and `coordOp` never reads the diagonal. `qE` is `innerOp2 E (coordOp (Gy j k z))`, the record's $\langle E,G_z\rangle$.
- `Gy_smul` follows because every term of `Gy` is quadratic in `vy`, and `vy_smul` is linear. `qE_smul` then uses linearity of `coordOp` and of `innerOp2` in its right slot. `continuous_qE` composes two finite-dimensional linear maps with a polynomial map. All three are routine and compile.
- **The plane.** The Lean plane is $\{z\in\mathbb R^n:z_j=z_k=0,\ \sum_iz_i=0\}$ with the norm $\sum_iz_i^2$. Restricting to the coordinates $a\notin\{j,k\}$ is a linear isometry onto the record's $\{z\in\mathbb R^{n-2}:\sum z=0\}$, since the dropped coordinates are zero and contribute nothing to either sum. The plane is right.
- **Maximiser versus top eigenvalue.** For a quadratic form $q$ on a Euclidean space $V$, $\max_{\lVert z\rVert=1}q(z)$ is the top eigenvalue of $q$'s symmetric matrix (Rayleigh), and every maximiser is a unit eigenvector for it. So Lean's $q_E(z_*)$ is the record's $\lambda$, and `exists_qE_max`'s conclusion $q_E(z)\le\lVert z\rVert^2q_E(z_*)$ on the plane is $q_E(z)\le\lambda\lVert z\rVert^2$. Applied to $y$ and $x$ and added, it gives the record's $q_E(y)+q_E(x)\le\lambda s$. The record's $\lambda s=q_E(\sqrt s\,z_*)$ is `qE_smul` with $t=\sqrt s$. The two formulations agree in value and in the bound.
- The proof of `exists_qE_max` is the standard one: the unit sphere of the plane is closed and bounded, hence compact (`Metric.isCompact_of_isClosed_isBounded`), `IsCompact.exists_isMaxOn` gives $z_*$, and homogeneity extends the bound from the sphere to the plane, with $z=0$ handled by `qE_zero`. The nonemptiness hypothesis `hne` is necessary, since at $n=3$ the plane is $\{0\}$, and `L224_step4` discharges it from $s>0$ (section 4).
- Lean proves that $z_*$ is a maximiser and does not state that it is an eigenvector. Step 4 uses only the value, so this costs step 4 nothing (O1 records what step 5 will need).

## 3. The cubic at even plus odd (claim 4)

- `cubic_even_odd` takes $E$ Weyl, of character $1$, with $\sigma E=E$, and $z$ with $\sum_c(\mathrm{vy}\,z)_c=0$. It sets $M=D^-_z$, which is Weyl (`Dminus_weyl`), of character $1$ (`Dminus_charOne`) and swap-odd (`Dminus_swap_odd`). Then $D:=E+M$ has $\tfrac12(D+\sigma D)=E$ and $\tfrac12(D-\sigma D)=M$, and `L224_cubic_pair` at $\nu=0$ gives $P(E+M)=P(E)+3\langle E,M\circ M\rangle+3\langle E,0\circ0\rangle$. `Q_Dminus` turns $M\circ M$ into $G_z$, and the last term is zero.
- This is the record's $P(W')=P(E)+3q_E(\sqrt s\,z_*)$, the equality in the middle of step 4's chain, at every admissible $z$. The use of step 3 with $\nu=0$ is legitimate: $0$ is Weyl and has every character (`isWeyl2_zero`, `L221Ops.signChar_zero`).

## 4. The step 4 theorem (claims 5 to 7)

- **Hypotheses.** $D$ Weyl of character $1$ is the record's $D\in\mathcal D_n$, and $\nu$ Weyl of character $\varepsilon_j\varepsilon_k$ is the record's element of $V_{jk}$, both as L222Op fixes them (character $1$ for $\mathcal D_n$, character $\varepsilon_j\varepsilon_k$ for $V_{jk}$). There is no unit hypothesis and no bound on $n$, which only widens the statement.
- **One $y,x$.** The proof obtains $y,x$ once from `L224_norm`, whose output carries $\tfrac12(D-\sigma D)=D^-_y$ (`hM`), $\nu=\nu_x$ (`hνx`) and the norm identity (`hnorm`). The cubic identity `hcub` is rebuilt from `L224_cubic_pair` by rewriting with that same `hM` and `hνx`, then `Q_Dminus` and `Q_nuX`. So step 1's $s$ and step 3's pairings are on one pair $(y,x)$, which is r1807 O3's concern discharged inside the proof.
- **$s>0$.** $E=\tfrac12(D+\sigma D)$ is Weyl, of character $1$ and swap-even. With $w=\sqrt s\,z_*$, `hzsn` gives $\lVert w\rVert^2=s$, and $W'=E+D^-_w$ is Weyl and of character $1$. The norm: $\langle E,D^-_w\rangle=0$ by `inner_flip_zero` at the swap, and $\lVert D^-_w\rVert^2=2s$ by `normSq2_Dminus`, so $\lVert W'\rVert^2=\lVert E\rVert^2+2s=\lVert D+\nu\rVert^2$ by `hnorm`. The cubic: $P(D+\nu)=P(E)+3q_E(y)+3q_E(x)\le P(E)+3sq_E(z_*)=P(E)+3q_E(w)=P(W')$. This is the record's chain $P(W)\le P(E)+3\lambda s=P(W')$ exactly, with the record's $W'$.
- **"Unit" read as equal norm.** The record's $W$ is unit, so its "unit diagonal tensor" is $\lVert W'\rVert=\lVert W\rVert=1$. Lean's $\lVert W'\rVert=\lVert D+\nu\rVert$ is that statement with the normalisation lifted, and it specialises to the record's at $\lVert D+\nu\rVert=1$. "Diagonal" is character $1$ plus Weyl, the convention of the whole L222/L224 layer.
- **$s=0$ (claim 6).** The proof shows $y=x=0$ and takes $W'=E$, with $\lVert E\rVert^2=\lVert D+\nu\rVert^2$ from `hnorm` at $s=0$ and $P(D+\nu)=P(E)$ from `hcub` and `qE_zero`. The record's $W'=E+D^-_{\sqrt s\,z_*}$ at $s=0$ is $E+D^-_0=E$, and step 5's "At $s=0$, $W=E$ is diagonal" is the same fact. They match. At $s=0$ the record's $z_*$ may not exist (the plane is $\{0\}$ at $n=3$), and the Lean branch never needs it.
- **$s>0$ and nonemptiness.** `hne` is built by normalising whichever of $y,x$ is nonzero, both lying in the plane. Correct.
- **L57 (claim 7).** The file contains no occurrence of $\Theta_n$, `Theta`, or any L57 declaration outside its module docstring, which says "the last inequality, L57, is a separate link". The theorem's conclusion stops at $P(D+\nu)\le P(W')$. Nothing about $\le\Theta_n$ is claimed.

## 5. lean/INDEX.md (claims 8 and 9)

- **L224 row, step 4 sentence.** It names `qE`, `Gy_smul`, `qE_smul`, `continuous_qE`, `exists_qE_max`, `cubic_even_odd` and **`L224_step4`**, each described as the file states it, with "the record's top eigenvector read as a maximiser" and "one $y,x$ serving both identities (r1807 O3)". Accurate.
- **r1807 O4.** The state column reads **partial**. Repaired.
- **r1807 O1.** The file column lists PairNorm.lean, and L224Step4.lean is added. Repaired.
- **r1807 O3.** Accurate as stated, per section 4.
- **Owed list.** "step 5's $q_E=q_{B'}$ and rotation action; the link from L57Block.lean's proved L57 to `pair_value_le`'s hypothesis and L57's equality clause in block-constant form; and the Statement assembled on the operators." All three owed items are still named.
- The row records r1807 for L224Pair and L224Norm but carries no Gate 2 mention for L224Step4, while [findings/second-order.md](../findings/second-order.md)'s L224 header says "(Gate 2 [r1808](../reviews/REVIEW_r1808.md), pending)" (O3).
- **L222 row, r1807 O2.** It now reads "`Dminus_swap_odd`, PairSquare's `Dminus_weyl`, and `Dminus_weight` with `Dminus_charOne`, conversely every such $D^-_y$ is swap-odd, Weyl and of character $1$ (r1807 O2)". `Dminus_weyl` is in [PairSquare.lean:308](../lean/HamiltonsCubic/Results/PairSquare.lean#L308) and gives Weyl-ness, so the Weyl clause is now credited correctly. `Dminus_weight` ([OddPart.lean:149](../lean/HamiltonsCubic/Results/OddPart.lean#L149)) is still listed without being described as the weight property that `Dminus_charOne` consumes, which was the second half of r1807's repair (O4).

## 6. Hand evaluations (screens)

All exact, with the diagonal cubic $P(K)=\sum_{p<q}K_{pq}^3+3\sum_{p<q<r}K_{pq}K_{pr}K_{qr}$ (from $P(W)=\langle W,W\circ W\rangle$ and the record's diagonal product $(A\circ A)_{pq}=A_{pq}^2+\sum_cA_{pc}A_{cq}$, which counts each triangle three times) and $\lVert K\rVert^2=\sum_{p<q}K_{pq}^2$. Indices $j=1$, $k=2$.

**$n=5$, a case with strict inequality.** $a\in\{3,4,5\}$ and the plane is 2-dimensional.

- $E$: $K_{12}=1$, $K_{13}=K_{23}=1$, $K_{14}=K_{24}=K_{15}=K_{25}=-1$, $K_{34}=K_{35}=-1$, $K_{45}=3$. Every row sums to zero and $E$ is swap-even. $\lVert E\rVert^2=18$.
- On the plane, with $z=(z_3,z_4,z_5)=(-(u+v),u,v)$: $q_E(z)=-\lVert z\rVert^2+2(z_3^2-z_4^2-z_5^2)+2(-z_3z_4-z_3z_5+3z_4z_5)=12uv$, and $\lVert z\rVert^2=2(u^2+uv+v^2)$. The Rayleigh quotient $6uv/(u^2+uv+v^2)$ has extremes $2$ at $u=v$ and $-6$ at $u=-v$. So $\lambda=2$ and $z_*=(-2,1,1)/\sqrt6$.
- $y=(0,1,-1)$ and $x=(-2,1,1)$. Direct pairing with $G_y$ and $G_x$ gives $q_E(y)=-12$ and $q_E(x)=12$, agreeing with $12uv$. $s=2+6=8$.
- $D=E+D^-_y$: $K_{12}=1$, $K_{13}=K_{23}=1$, $K_{14}=0$, $K_{24}=-2$, $K_{15}=-2$, $K_{25}=0$, $K_{34}=K_{35}=-1$, $K_{45}=3$. Rows sum to zero. $\nu=\nu_x$.
- Norm: $\lVert D+\nu\rVert^2=\lVert D\rVert^2+\lVert\nu_x\rVert^2=22+12=34=18+2\cdot8$.
- $W'=E+D^-_w$ with $w=\sqrt8\,z_*=\tfrac{2}{\sqrt3}(-2,1,1)$, $\lVert w\rVert^2=8$, so $\lVert W'\rVert^2=18+16=34$. **Equal norm, confirmed.**
- The $q_E$ bound: $q_E(y)+q_E(x)=0\le\lambda s=16$. **Strict.**
- $P(E)=24+3\cdot16=72$ and $P(D)=12+3\cdot8=36$ by the diagonal formula, and $P(E)+3q_E(y)=72-36=36$ agrees.
- $P(W')$ by the diagonal formula, with $r=1/\sqrt3$ and entries $K_{13}=1-4r$, $K_{23}=1+4r$, $K_{14}=K_{15}=-1+2r$, $K_{24}=K_{25}=-1-2r$: $\sum K^3=40$ and the triangle sum is $80/3$, so $P(W')=40+80=120$. `cubic_even_odd` predicts $P(E)+3q_E(w)=72+3\cdot16=120$. **Agrees, independently of the Lean.**
- $P(D+\nu)=P(E)+3q_E(y)+3q_E(x)=72$ by step 3 (`L224_cubic_G`, machine-checked). The full cubic of the non-diagonal $D+\nu$ was not evaluated by hand, since its sharp term needs the $\Lambda^2$ structure constants, so this value rests on step 3. **$P(D+\nu)=72\le120=P(W')$.**

**$n=4$, the degenerate plane.** $a\in\{3,4\}$, the plane is the line of $(1,-1)$, and every unit vector in it is a maximiser.

- $E$: $K_{12}=K_{34}=2$, the other four entries $-1$. $y=x=(1,-1)$, $s=4$, $D$ has $K_{12}=K_{34}=2$, $K_{13}=K_{24}=0$, $K_{14}=K_{23}=-2$.
- $q_E(t(1,-1))=-12t^2$, so $\lambda=-6$ and $q_E(y)+q_E(x)=-24=\lambda s$, equality as a 1-dimensional plane forces.
- $\lVert D+\nu\rVert^2=16+4=20=12+2\cdot4=\lVert W'\rVert^2$.
- $P(E)=36$, $P(D)=0=36+3(-12)$, $P(W')=-12+3(-8)=-36=36+3(-24)$ by the diagonal formula, and $P(D+\nu)=-36$ by step 3. Equality, as expected at $n=4$.

## 7. Compile and audit (claim 10)

- `lake env lean HamiltonsCubic/Results/L224Step4.lean` from lean/: exit 0, empty output (no warnings, no `sorry`).
- `python3 scripts/misc/axiom_audit.py --only L224Step4.lean`: "auditing 8 declarations across 1 files", "8/8 clean -- resting on the standard three alone".
- The root import [HamiltonsCubic.lean:1029](../lean/HamiltonsCubic.lean#L1029) registers the module.

## 8. Observations

- **O1.** `exists_qE_max` exports $z_*$ as a maximiser with the value bound. Step 5 needs more: "$q_E(y)=\lambda\lVert y\rVert^2$ and $q_E(x)=\lambda\lVert x\rVert^2$" to place $y,x$ in the top eigenspace, and "$\lambda=c\lVert\bar u\rVert^2>0$ has the line of $\bar u$ as its whole eigenspace". The maximiser form supports this, since $q_E(y)=\lambda\lVert y\rVert^2$ makes $y/\lVert y\rVert$ a maximiser, but identifying the maximisers with a line needs `block_form`'s rank-one expression on top. This is owed to step 5 and blocks nothing now.
- **O2.** `L224_step4` is existential. It does not export that $W'=E+D^-_w$ with $\lVert w\rVert^2=s$, that $W'$'s swap-even part is $E$, or the intermediate value $P(E)+3\lambda s$. Step 5's "If $P(W)=\Theta_n$ then $P(W')=\Theta_n$, $q_E(y)=\lambda\lVert y\rVert^2$ and $q_E(x)=\lambda\lVert x\rVert^2$" and "$W'$ is an L57 maximiser $B'$ with swap-even part $E$" use exactly those. A consumer will need a strengthened form carrying the witness's shape, or will have to re-run the construction. The docstring's "namely $W'=E+D^-_{\sqrt s\,z_*}$" is accurate about the proof and is not part of the statement.
- **O3.** The L224 row at [lean/INDEX.md:155](../lean/INDEX.md#L155) records Gate 2 for every other file it lists and carries none for L224Step4.lean, while the record's L224 header marks r1808 as pending. Repair once this report lands: add "Gate 2 on L224Step4: [r1808](../reviews/REVIEW_r1808.md)" with its verdict.
- **O4.** The L222 row at [lean/INDEX.md:152](../lean/INDEX.md#L152) now credits Weyl-ness to `Dminus_weyl`, which is correct. It still lists `Dminus_weight` alongside `Dminus_charOne` as if it contributed a clause of "swap-odd, Weyl and of character $1$". Repair: describe `Dminus_weight` as the weight property that `Dminus_charOne` consumes, as r1807 O2 asked.

## 9. What would falsify each headline

- **Claim 3** falls if the maximum of $q_E$ on the unit sphere of the Lean plane differed from the top eigenvalue of the record's form on $\{z\in\mathbb R^{n-2}:\sum z=0\}$. The isometry of section 2 and Rayleigh's principle exclude this.
- **Claim 4** falls on any swap-even Weyl $E$ of character $1$ and admissible $z$ with $P(E+D^-_z)\ne P(E)+3q_E(z)$. The $n=5$ evaluation ($120=120$) and the $n=4$ one ($-36=-36$) are screens that did not find one.
- **Claim 5** falls if the $W'$ built is not the record's, if its norm differs from $\lVert D+\nu\rVert$, or if the cubic chain uses two different $(y,x)$. Section 4 reads each from the proof, and the $n=5$ screen gives $34=34$ and $72\le120$.
- **Claim 6** falls if the record's $s=0$ reading were anything other than $W'=E$.
- **Claim 7** falls on any statement in L224Step4.lean mentioning $\Theta_n$ or L57's bound. There is none.
- **Claims 8 and 9** fall on any sentence in the rows that misstates a declaration or an owed item. O3 and O4 are the two found.
