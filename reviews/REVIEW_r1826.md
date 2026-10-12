# REVIEW r1826: FourSquare, L220 step 2's square on one four-set pairing

Gate 2 on [lean/HamiltonsCubic/Results/FourSquare.lean](../lean/HamiltonsCubic/Results/FourSquare.lean) at commit 1983dabb (unchanged at HEAD), on that commit's edits to the docstring of [L224EqRot.lean](../lean/HamiltonsCubic/Results/L224EqRot.lean) and to the L220 and L224 result rows of [lean/INDEX.md](../lean/INDEX.md), against Lemma L220 of [findings/second-order.md](../findings/second-order.md). Analysis only: every construction was re-derived by hand from the definitions, the one evaluation below is exact integer arithmetic done by hand, and the only runs were one compile of the file and the axiom audit the brief names.

| Claim | Verdict |
|---|---|
| Definitions `ind2`, `w4`, `W4`, `sig4` encode $P_{pq}$, $w$, $W_2$ and $\sigma=S_{ik}XS_{jl}+S_{jl}XS_{ik}$ | CONFIRMED WITH OBSERVATIONS |
| Helpers `uj_sq`, `uj_sq'`, `uj_dis`, `uj_sum`, `w4_T`, `w4_hollow`, `w4_weight` | CONFIRMED |
| `Q_w4`, $Q(w\odot\cdot)=W_2\odot\cdot$, the matrix identity $w\odot w+w^2=W_2$ including the diagonal | CONFIRMED |
| `W4_fix1`, `W4_fix2`, every rotation of either plane fixes $W_2\odot\cdot$ | CONFIRMED |
| `c45_facts`, `Rot45_S`, $R\,S\,R^{\mathsf T}=-D_u$ at $45^\circ$ | CONFIRMED |
| `sig_rot`, the double $45^\circ$ rotation carries $\sigma$ to $w\odot\cdot$ | CONFIRMED |
| `sig_eq`, `w4_weyl`, `sig_weyl` | CONFIRMED |
| **`Q_sig`**, $\sigma\circ\sigma=W_2\odot\cdot$ | CONFIRMED |
| (a) $\sigma$ is the record's $\nu$ at $(a,b,c)=(1,0,-1)$ | CONFIRMED WITH OBSERVATIONS |
| (b) $W_2$'s pattern is the record's $x=2a^2-b^2-c^2$ and cyclic at $(1,0,-1)$ | CONFIRMED |
| (d) The rotations' fixing arguments | CONFIRMED |
| (e) The L220 result row of lean/INDEX.md, the new clause and what it leaves owed | CONFIRMED WITH OBSERVATIONS |
| FourSquare's module docstring | CONFIRMED WITH OBSERVATIONS |
| The L224 result row's r1825 citation | CONFIRMED |
| L224EqRot docstring edits, `even_fixed` and the parity note on `L224_eq_even` | CONFIRMED |
| Axiom audit of FourSquare.lean | CONFIRMED, 18/18 on the standard three |

**Summary.** `Q_sig` is sound and faithful to L220 step 2 on the ray $(a,b,c)=(1,0,-1)$ and its relabellings, and the row states that scope honestly. The observations are a sign convention the record leaves implicit (it is invisible at $b=0$ and matters for the general case), a stale declaration name in the module docstring, and a finite route to the general polarisation from three instances of `Q_sig`.

## 1. The record, verbatim

Setting: "**Setting.** $\Pi_Q\subset\mathcal D_n$ is the plane of sectional matrices supported on $Q$, $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ with $x+y+z=0$, unit when $2(x^2+y^2+z^2)=1$. Write $D=q+r$ with $q\in\Pi_Q$, $r\in\mathcal D_n\ominus\Pi_Q$, and in the pairing basis of $V_Q$ with signed coordinates $\nu=a\,e_{ij}\odot e_{kl}+b\,e_{ik}\odot e_{jl}+c\,e_{il}\odot e_{jk}$, $a+b+c=0$."

Step 2: "2. **Three products.** $\Pi_Q$ is a subalgebra of $\mathcal D_n$, since a hollow matrix supported on $Q$ with zero row sums has $S^{\circ2}+S^2$ supported on $Q$ off the diagonal with zero row sums. $\nu\circ\nu\in\Pi_Q$, with $x=2a^2-b^2-c^2$ and cyclically: it has character $\chi_Q^2=1$, so it lies in $\mathcal D_n$, in $(\nu\#\nu)_{\alpha\alpha}$ a pair $\alpha$ leaving $Q$ forces a factor of $\nu$ outside its support, and on $Q$ the pattern is $(\nu\#\nu)_{ij,ij}=2bc$ plus $(\nu^2)_{ij,ij}=a^2$. And $D\circ\nu\in V_Q$ by L120."

## 2. The declarations

Conventions read from the source: `phi p q` $=E_{qp}-E_{pq}$ ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean#L45)), `coordOp a` $X=\tfrac12\big(a\odot X-(a\odot X)^{\mathsf T}\big)$, which at symmetric $a$ and skew $X$ is $a\odot X$ and reads only the off-diagonal entries of $a$, and `sandOp A B` $X=AXB+BXA$ ([PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean#L37)).

### 2.1 Definitions

- [ind2](../lean/HamiltonsCubic/Results/FourSquare.lean#L30) is the indicator of $\{p,q\}$, [w4](../lean/HamiltonsCubic/Results/FourSquare.lean#L33) is $u_{ik}u_{jl}^{\mathsf T}+u_{jl}u_{ik}^{\mathsf T}$ with $u_{pq}=e_p-e_q$, [W4](../lean/HamiltonsCubic/Results/FourSquare.lean#L37) is $P_{ik}P_{jl}^{\mathsf T}+P_{jl}P_{ik}^{\mathsf T}+2(u_{ik}u_{ik}^{\mathsf T}+u_{jl}u_{jl}^{\mathsf T})$, and [sig4](../lean/HamiltonsCubic/Results/FourSquare.lean#L42) is `sandOp (Smat i k) (Smat j l)` with `Smat p q` $=E_{pq}+E_{qp}$. All as the header says. CONFIRMED.
- `W4` carries the diagonal $2$ on each index of $Q$. `coordOp` ignores it, so every theorem about `coordOp (W4 …)` is unaffected, but `W4` itself is no weight and no sectional matrix. Its hollow part has entries $1$ on $ij,il,kj,kl$ and $-2$ on $ik,jl$, row sums $1+1-2=0$, so it lies in $\Pi_Q$. That membership is by reading and is untyped (O2).

### 2.2 Helpers

- `uj_sq`, `uj_sq'`: $u_{pq}(r)^2=P_{pq}(r)$, by cases. `uj_dis`: $u_{ik}(r)u_{jl}(r)=0$ from the four cross distinctness hypotheses. `uj_sum`: $\sum_r u_{ab}(r)=0$. `w4_T` from `vv_sym`. `w4_hollow` from `uj_dis`. `w4_weight`: symmetric, hollow, zero row sums from `uj_sum`. CONFIRMED. The linter reports unused section hypotheses on several of these and unused simp arguments in `W4_fix1` and `W4_fix2`, which are cosmetic (O5).

### 2.3 `Q_w4` and question (c)

- [Q_w4](../lean/HamiltonsCubic/Results/FourSquare.lean#L94) rewrites with `Qop2_coordOp` ([DiagSquare.lean](../lean/HamiltonsCubic/Results/DiagSquare.lean#L47)), $Q(a\odot\cdot)=(a\odot a+a\,a)\odot\cdot$ at symmetric hollow $a$, then `congr 1` and `ext p q`, so it proves the full matrix identity $w\odot w+w^2=W_2$ at every entry, diagonal included. This is stronger than the operator statement needs.
- By hand: with $\langle u_{ik},u_{ik}\rangle=\langle u_{jl},u_{jl}\rangle=2$ and $\langle u_{ik},u_{jl}\rangle=0$, $w^2=2(u_{ik}u_{ik}^{\mathsf T}+u_{jl}u_{jl}^{\mathsf T})$. With $u_{ik}(r)u_{jl}(r)=0$ and $u^{\circ2}=P$, $w\odot w=P_{ik}P_{jl}^{\mathsf T}+P_{jl}P_{ik}^{\mathsf T}$. The sum is `W4` at every entry: at $(i,i)$ it is $0+2=2$, at $(i,j)$ it is $1+0$, at $(i,k)$ it is $0+2u_{ik}(i)u_{ik}(k)=-2$, and at $(i,m)$, $m\notin Q$, it is $0$. CONFIRMED.

### 2.4 The rotations and question (d)

- [W4_fix1](../lean/HamiltonsCubic/Results/FourSquare.lean#L119) writes $W_2\odot\cdot$ as $\mathrm{sandOp}(D_{P_{ik}},D_{P_{jl}})+\mathrm{sandOp}(D_{u_{ik}},D_{u_{ik}})+\mathrm{sandOp}(D_{u_{jl}},D_{u_{jl}})$ through `coordOp_rank_two` and `coordOp_vv` (the $2\cdot\tfrac12$ cancels). Under $\mathrm{Rot}_{ik}(c,s)$ with $c^2+s^2=1$: $D_{P_{ik}}$ is fixed since $P_{ik}(i)=P_{ik}(k)=1$, $D_{P_{jl}}$ and $D_{u_{jl}}$ are fixed since they vanish at $i$ and $k$ (`Rot_diag_fix` needs only equal entries at the plane's two indices), and $\mathrm{sandOp}(D_{u_{ik}},D_{u_{ik}})$ is fixed by `sandOp_uu_rot`, though $D_{u_{ik}}$ itself is not. `W4_fix2` is the mirror. CONFIRMED.
- In `Q_sig`, `hfixT` turns "$U$ fixes" into "$U^{\mathsf T}$ fixes" through `rotR_inv` at orthogonal $U$: from $\mathrm{rotR}\,U\,Y=Y$, applying $\mathrm{rotR}\,U^{\mathsf T}$ and cancelling gives $Y=\mathrm{rotR}\,U^{\mathsf T}Y$. Sound. CONFIRMED.

### 2.5 `c45_facts`, `Rot45_S`, `sig_rot`

- `c45_facts`: $c^2-c^2=0$, $-2c^2=-1$, $2c^2=1$ at $c=\sqrt2/2$. `Rot45_S` then specialises `Rot_S`, $RSR^{\mathsf T}=(c^2-s^2)S-2cs\,D_u$, to $-D_{u_{pq}}$. CONFIRMED.
- [sig_rot](../lean/HamiltonsCubic/Results/FourSquare.lean#L162): $\mathrm{Rot}_{ik}$ sends $\mathrm{sandOp}(S_{ik},S_{jl})$ to $\mathrm{sandOp}(-D_{u_{ik}},S_{jl})$ ($S_{jl}$ is supported off $\{i,k\}$, `Rot_mul_off`, `mul_RotT_off`). $\mathrm{Rot}_{jl}$ then fixes $-D_{u_{ik}}$ (equal entries $0$ at $j,l$) and sends $S_{jl}$ to $-D_{u_{jl}}$. The two signs cancel and `coordOp_rank_two` gives $w\odot\cdot$. CONFIRMED.

### 2.6 `sig_eq`, `w4_weyl`, `sig_weyl`, `Q_sig`

- `sig_eq` inverts the two rotations with `rotR_inv`. `w4_weyl` is `coordOp_eq_restrict` at the weight `w4`. `sig_weyl` transports it through `rotR_isWeyl2`. CONFIRMED.
- [Q_sig](../lean/HamiltonsCubic/Results/FourSquare.lean#L206): $Q(\sigma)=Q(R_1^{\mathsf T}\cdot R_2^{\mathsf T}\cdot(w\odot\cdot))=R_1^{\mathsf T}\cdot R_2^{\mathsf T}\cdot Q(w\odot\cdot)$ by `Qop2_rotR` twice at Weyl arguments, $=R_1^{\mathsf T}\cdot R_2^{\mathsf T}\cdot(W_2\odot\cdot)=W_2\odot\cdot$ by `Q_w4` and both fixings. Hypotheses: the six distinctness conditions, and nothing on $n$ beyond what they force. CONFIRMED.

## 3. Fidelity

### 3.1 Question (a): which $(a,b,c)$ is $\sigma$

By hand, in the instance of §5, $\sigma(\varphi_{ij})=\varphi_{kl}$, $\sigma(\varphi_{kl})=\varphi_{ij}$, $\sigma(\varphi_{il})=-\varphi_{jk}$, $\sigma(\varphi_{jk})=-\varphi_{il}$, $\sigma(\varphi_{ik})=\sigma(\varphi_{jl})=0$, and $\sigma$ vanishes on every $\varphi_{pm}$ with $m\notin Q$ (a factor $E_{\cdot m}$ or $E_{m\cdot}$ cannot survive both swap matrices). So in the record's pairing basis $\sigma=1\cdot e_{ij}\odot e_{kl}+0\cdot e_{ik}\odot e_{jl}-1\cdot e_{il}\odot e_{jk}$, that is $(a,b,c)=(1,0,-1)$, with the normalisation $\nu(e_{ij})=a\,e_{kl}$ that the record's $(\nu^2)_{ij,ij}=a^2$ presumes. CONFIRMED.

The sign convention behind "signed coordinates" matters beyond this ray (O1). The same hand computation for the other two sandwiches, with the orientation $e_{pq}=\varphi_{pq}$ read literally, gives $\mathrm{sandOp}(S_{ij},S_{kl})=(0,1,1)$ and $\mathrm{sandOp}(S_{il},S_{jk})=(-1,-1,0)$. Both are Weyl by `sig_weyl`, and neither satisfies $a+b+c=0$. The first Bianchi identity in this orientation reads $\langle\nu e_{ij},e_{kl}\rangle+\langle\nu e_{jk},e_{il}\rangle+\langle\nu e_{ki},e_{jl}\rangle=a+c-b=0$, and all three sandwiches satisfy it. The record's $a+b+c=0$ is therefore the literal coordinates with $b$ negated (the orientation $e_{ki}$ in the middle slot), and in those coordinates the three sandwiches are $(1,0,-1)$, $(0,-1,1)$, $(-1,1,0)$. The quadratic $x=2a^2-b^2-c^2$ is blind to the sign of $b$, and $(\nu\#\nu)_{ij,ij}=2bc$ is not: in literal coordinates it reads $-2bc$. At $b=0$ nothing changes, which is why this commit is unaffected.

### 3.2 Question (b): the pattern

At $(a,b,c)=(1,0,-1)$: $x=2a^2-b^2-c^2=2-0-1=1$, $y=2b^2-c^2-a^2=0-1-1=-2$, $z=2c^2-a^2-b^2=2-1-0=1$. With the record's "$K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$" this is $1$ on $ij,kl,il,jk$ and $-2$ on $ik,jl$, which is `W4`'s off-diagonal pattern ($kj=jk$). Also $x+y+z=0$. The record's second form agrees: $(\nu^2)_{ij,ij}+(\nu\#\nu)_{ij,ij}=a^2+2bc=1$, $(\nu^2)_{ik,ik}+(\nu\#\nu)_{ik,ik}=b^2+2ca=-2$. As a cross-check of O1, `sig4 i j k l` puts $-2$ on $ij,kl$, and the signed coordinates $(0,-1,1)$ give $x=0-1-1=-2$, $y=2-1-0=1$, $z=2-0-1=1$. CONFIRMED.

### 3.3 Question (e): what step 2 still owes

`Q_sig` holds for every choice of distinct labels, so it gives $\nu\circ\nu$ with its pattern on the three rays of the three sandwiches, with no statement that they lie in or span $V_Q$. Still owed for step 2:

1. The identification of $V_Q$ with the span of the three sandwiches: each has character $\chi_Q$, and they span the two-dimensional $V_Q$. Untyped, and the module docstring asserts it ("The four-set block is spanned by sandwiches of swap matrices") without a theorem (O3).
2. The polarisation to general $(a,b,c)$. This is finite (O4): on $\Lambda^2(Q)$ the three sandwiches satisfy $\sigma_1+\sigma_2+\sigma_3=0$ (by hand, $(1,0,-1)+(0,1,1)+(-1,-1,0)=0$ in literal coordinates, all three vanishing off $\Lambda^2(Q)$), so $2\,\sigma_1\circ\sigma_2=Q(\sigma_3)-Q(\sigma_1)-Q(\sigma_2)$, three instances of `Q_sig`, and each is $\odot$ by a matrix whose hollow part lies in $\Pi_Q$.
3. $\Pi_Q$ a subalgebra of $\mathcal D_n$.
4. $D\circ\nu\in V_Q$ as an operator statement.

The row's new clause says "**Step 2's square on one pairing, PROVED** … the record's pattern at $(a,b,c)=(1,0,-1)$", and its owed list keeps "step 2's products, that $\Pi_Q$ is a subalgebra of $\mathcal D_n$, $\nu\circ\nu\in\Pi_Q$ with its pattern, and $D\circ\nu\in V_Q$ as an operator statement". That is accurate and does not overclaim: items 3 and 4 are named, and items 1 and 2 are inside "$\nu\circ\nu\in\Pi_Q$ with its pattern". It does not itemise 1 and 2, which is what a next round needs (O3). CONFIRMED WITH OBSERVATIONS.

## 4. The other edits

- **L224 row.** The added sentence reads "Gate 2 on L224EqRot: [r1825](../reviews/REVIEW_r1825.md), CONFIRMED WITH OBSERVATIONS, the three pieces together being the whole Statement on the operators at every $n\ge4$ and the state **proved** justified; the closure $e^{\varphi\xi}\cdot\mathcal D_n\subseteq\mathcal S_{jk}$ and $\mathrm{Rot}_{jk}(c,s)=e^{\varphi\xi}$ hold by reading and are untyped (O2, O3)". It matches r1825's claim table (the whole-Statement row and the INDEX row are both CONFIRMED WITH OBSERVATIONS) and its O2 and O3, and the link target exists. This closes r1825 O4 for the INDEX. CONFIRMED.
- **L224EqRot docstring.** The header bullet now names `even_fixed`, which is the declaration at line 72 (r1825 O1). The new note on `L224_eq_even`, "Stated with `θ₀(n)`, it carries no parity hypothesis. At odd `n`, `θ₀(n) > Θ_n` and its hypothesis forces `D + ν = 0`, so `L224_eq_odd` is the odd case", is what r1825 O5 asked for and agrees with r1813 O4 as r1825 cites it. CONFIRMED.
- **FourSquare header.** It lists `W4_fix`, and no declaration of that name exists: the file has `W4_fix1` and `W4_fix2`. This is the same defect r1825 O1 found in L224EqRot (O2).

## 5. Hand evaluation (exact, by hand, labelled as such)

$n=4$, $(i,k,j,l)=(0,2,1,3)$, so $S_{ik}=E_{02}+E_{20}$, $S_{jl}=E_{13}+E_{31}$, $\varphi_{pq}=E_{qp}-E_{pq}$, and $E_{ab}E_{cd}=\delta_{bc}E_{ad}$.

- $\sigma(\varphi_{01})$, $X=E_{10}-E_{01}$: $S_{ik}X=-E_{21}$, then $-E_{21}S_{jl}=-E_{23}$. $S_{jl}X=E_{30}$, then $E_{30}S_{ik}=E_{32}$. Sum: $E_{32}-E_{23}=\varphi_{23}$.
- $\sigma(\varphi_{03})$, $X=E_{30}-E_{03}$: $S_{ik}X=-E_{23}$, then $-E_{23}S_{jl}=-E_{21}$. $S_{jl}X=E_{10}$, then $E_{10}S_{ik}=E_{12}$. Sum: $E_{12}-E_{21}=-\varphi_{12}$.
- $\sigma^2(\varphi_{01})=\sigma(\varphi_{23})$, $X=E_{32}-E_{23}$: $S_{ik}X=-E_{03}$, then $-E_{01}$. $S_{jl}X=E_{12}$, then $E_{10}$. Sum: $\varphi_{01}$. So $(\sigma^2)_{01,01}=1=a^2$.
- $(\sigma\#\sigma)_{01,01}$: every term pairs a bracket decomposition $\varphi_{01}\sim[\varphi_{0m},\varphi_{m1}]$, $m\in\{2,3\}$, with another, and needs two entries of $\sigma$ among $\{\varphi_{02},\varphi_{03},\varphi_{21},\varphi_{31}\}$ matched crosswise. On that set $\sigma$'s only nonzero entries are $\sigma_{03,12}$ and $\sigma_{12,03}$, and each term needs a partner entry $\sigma_{13,02}$ or $\sigma_{02,13}$, both $0$ (as $\sigma(\varphi_{02})=\sigma(\varphi_{13})=0$). So $(\sigma\#\sigma)_{01,01}=0$, which is the record's $2bc$ at $b=0$.
- Total: $(\sigma\circ\sigma)_{01,01}=1+0=1$, and $W_2$'s entry at $(0,1)=(i,j)$ is $P_{ik}(0)P_{jl}(1)+0+2\big(u_{ik}(0)u_{ik}(1)+u_{jl}(0)u_{jl}(1)\big)=1$. They agree.

This is a screen of the construction at one point and establishes nothing by itself.

## 6. Runs

- `lake env lean HamiltonsCubic/Results/FourSquare.lean`: exit 0, with linter warnings only (unused section variables, unused simp arguments).
- `python3 scripts/misc/axiom_audit.py --only FourSquare.lean`: "auditing 18 declarations across 1 files", "18/18 clean -- resting on the standard three alone". CONFIRMED.

## 7. Observations

- **O1.** The record's "signed coordinates … $a+b+c=0$" is the literal $\varphi_{pq}$ coordinates with $b$ negated. Read literally, Bianchi is $a-b+c=0$, $\mathrm{sandOp}(S_{ij},S_{kl})=(0,1,1)$ and $(\nu\#\nu)_{ij,ij}=-2bc$. At $b=0$ the two readings coincide, so `Q_sig`'s "$(a,b,c)=(1,0,-1)$" is right in both. The polarisation round must fix the convention in its statement: $\nu=a\,e_{ij}\odot e_{kl}-b\,e_{ik}\odot e_{jl}+c\,e_{il}\odot e_{jk}$ in $\varphi_{pq}$ orientation, equivalently the middle basis vector $e_{ki}\odot e_{jl}$. A one-line gloss in the record's Setting would prevent the misreading.
- **O2.** FourSquare's module header lists `W4_fix`, which does not exist. Fix: name `W4_fix1` and `W4_fix2`. Relatedly, `W4` has diagonal $2$ on $Q$, harmless under `coordOp`, and the membership of its hollow part in $\Pi_Q$ (zero row sums, support on $Q$) is untyped. A consumer stating "$\nu\circ\nu\in\Pi_Q$" needs that lemma.
- **O3.** The L220 row's owed list is accurate but does not itemise the two steps between `Q_sig` and "$\nu\circ\nu\in\Pi_Q$ with its pattern": the identification of $V_Q$ with the span of the three sandwiches (character $\chi_Q$ and spanning), and the polarisation. The module docstring asserts the spanning without a theorem.
- **O4.** The polarisation is a finite step, and here is a route. Prove $\sigma_{ik,jl}+\sigma_{ij,kl}+\sigma_{il,jk}=0$ as operators (a hand identity on $\Lambda^2(Q)$, all three vanishing elsewhere), then $2\,\sigma_1\circ\sigma_2=Q(\sigma_3)-Q(\sigma_1)-Q(\sigma_2)$ from bilinearity of $Q$'s polar form and three instances of `Q_sig`. The general $\nu=\alpha\sigma_1+\beta\sigma_2$ then has $\nu\circ\nu$ equal to $\odot$ by an explicit combination of three `W4` matrices.
- **O5.** Cosmetic: unused section hypotheses on `uj_sq`, `uj_sq'`, `uj_dis`, `uj_sum`, `w4_T`, `ind2_T`, `W4_fix1`, `W4_fix2`, and unused simp arguments at lines 122 and 135. They widen the hypotheses of the helpers without affecting any conclusion.

## 8. What would falsify each headline

- **`Q_sig`.** An off-diagonal pair $(p,q)$ with $(\sigma\circ\sigma)$'s coefficient on $\varphi_{pq}$ different from `W4 p q`, or a nonzero off-diagonal entry of $\sigma\circ\sigma$ in the $\varphi$ basis. The kernel check excludes both. A failed compile or an axiom beyond the standard three would reopen it.
- **(a).** A computation of $\sigma(\varphi_{ij})$ other than $\varphi_{kl}$, or of $\sigma(\varphi_{ik})$ other than $0$, in the orientation $\varphi_{pq}=E_{qp}-E_{pq}$. §5 computes both at one instance.
- **(b).** A reading of the record's labels in which $K_{ik}$ is not $y$. The Setting quoted in §1 fixes it.
- **O1.** A proof that $\mathrm{sandOp}(S_{ij},S_{kl})$ has $\langle\sigma\varphi_{ik},\varphi_{jl}\rangle=-1$, or that the literal Bianchi form is $a+b+c=0$. The first contradicts the hand computation $\sigma(\varphi_{02})=\varphi_{13}$ at $(i,j,k,l)=(0,1,2,3)$.
- **(e).** A theorem in the repository already stating $V_Q=\mathrm{span}$ of the sandwiches, or the polar form on $V_Q$, which would make the owed list stale. None is cited in the row or the module.
