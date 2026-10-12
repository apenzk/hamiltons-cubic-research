# Review r1820: L224 step 5's line at even n, and the two-valued pairing

Gate 2 review of commit 4e1b86f7, which adds [L224Line.lean](../lean/HamiltonsCubic/Results/L224Line.lean), the theorem `inner_Zp_Gy_two` in [L224Rank.lean](../lean/HamiltonsCubic/Results/L224Rank.lean) and an `s > 0` export in [L224Eq.lean](../lean/HamiltonsCubic/Results/L224Eq.lean), against Lemma L224 step 5 of [second-order.md](../findings/second-order.md). The review is analysis only: the declarations were read against the record, the algebra was redone by hand, both axiom audits were run, and two exact hand evaluations were made.

| # | Claim | Verdict |
|---|---|---|
| 1 | `lagrange`, `cs_le`, `cs_eq` state Lagrange's identity and the Cauchy-Schwarz equality case | CONFIRMED |
| 2 | `L224_line_even` is the record's "both $y$ and $x$ lie on it" at even $n$ | CONFIRMED WITH OBSERVATIONS |
| 3 | (a) $\bar u=v$ off $\{j,k\}$ is proportional to the record's centred indicator of $A'$ | CONFIRMED WITH OBSERVATIONS |
| 4 | (b) $v_j+v_k=0$ follows from $W'$'s nonzero odd part | CONFIRMED |
| 5 | (c) $\lambda=t\lVert\bar u\rVert^2$ by Cauchy-Schwarz and the maximiser bound at $\bar u$ | CONFIRMED |
| 6 | (d) the conclusion says what the record says and claims nothing beyond it | CONFIRMED WITH OBSERVATIONS |
| 7 | (e) `inner_Zp_Gy_two` has the two-valued hypothesis, the cancellation claim holds, and it fits L57's odd maximiser | CONFIRMED WITH OBSERVATIONS |
| 8 | `L224_eq_tight`'s second branch exports $s>0$ | CONFIRMED |
| 9 | The [L224] row of [lean/INDEX.md](../lean/INDEX.md) | CONFIRMED WITH OBSERVATIONS |
| 10 | Axiom audits of L224Line.lean and L224Rank.lean | CONFIRMED (4/4 and 6/6 on the standard three) |

**Summary.** The commit is sound and faithful: every step of the even-$n$ line argument checks by hand, both audits are clean, and the observations concern labelling, the record's centring set, and the degenerate plane at $n=4$.

## 1. The record

Step 5 of Lemma L224, quoted verbatim: "$W'$ is an L57 maximiser $B'$ with swap-even part $E$ and nonzero odd part, so $j$ and $k$ lie in different blocks $A\ni j$, $B\ni k$ of $B'$, which is block-constant with values $\alpha_A,\alpha_B$ inside the blocks and $\gamma$ across. Since $G_z$ is swap-even, $q_E=q_{B'}$, and expanding, $q_{B'}(z)=(\alpha_A+\alpha_B-2\gamma)\big(\sum_{a\in A'}z_a\big)^2$ with $A'=A\setminus\{j\}$. On $\{\sum z=0\}$ this is $c\langle\bar u,z\rangle^2$ with $\bar u$ the centred indicator of $A'$, so $\lambda=c\lVert\bar u\rVert^2>0$ has the line of $\bar u$ as its whole eigenspace, and both $y$ and $x$ lie on it: $(y,x)=\sqrt s\,\hat u\,(\cos\psi,\sin\psi)$."

## 2. Declarations 1: Lagrange and Cauchy-Schwarz

`lagrange` is $(\sum a_i^2)(\sum y_i^2)-(\sum a_iy_i)^2=\tfrac12\sum_{i,l}(a_iy_l-a_ly_i)^2$, the standard identity with the double sum over ordered pairs, hence the $\tfrac12$. `cs_le` follows by nonnegativity. `cs_eq` takes $\sum a_i^2>0$ and equality and returns $y_l=(\langle a,y\rangle/\lVert a\rVert^2)\,a_l$ for every $l$, derived from $a_iy_l=a_ly_i$ termwise. The statements are the textbook ones with the coefficient written out. CONFIRMED.

## 3. Declaration 2: `L224_line_even`

**Statement.** Hypotheses $4\le n$, $j\ne k$, $D,\nu$ Weyl, $D$ of character $1$, $\nu$ of character `setChar {j, k}`, and $P(D+\nu)=\frac{\sqrt{2(n-1)(n-2)}}{n}\lVert D+\nu\rVert^3$, which is $\theta_0(n)$. Conclusion: $y,x$ zero at $j,k$ with zero sum, $\tfrac12(D-\sigma D)=D^-_y$, $\nu=\nu_x$, and either $y=x=0$ or ($n$ even and some $\bar u$ with $\bar u_j=\bar u_k=0$, $\sum\bar u=0$, $\sum\bar u^2>0$, and $y$, $x$ each equal to $(\langle\bar u,\cdot\rangle/\lVert\bar u\rVert^2)\,\bar u$). This is the brief's reading exactly.

**Route.** `L224_eq_tight` at $\Theta=\theta_0(n)$ gives the two branches. In the second, $W'=E+M'$ with $M'=D^-_{z_s}$, $z_s=\sqrt s\,z_1$. $\langle E,M'\rangle=0$ by `inner_flip_zero` (E swap-even, $M'$ swap-odd), so $\lVert W'\rVert^2=\lVert E\rVert^2+2s>0$, and `charOne_eq_even` returns $W'=$ `coordOp` of $w=t\,Z'(v)$ with $t>0$, $v_a^2=1/n$, $\sum v=0$ and `Even n`.

### 3.1 Question (b): oddness

Off $\{j,k\}$, by the definitions of `Dminus`, `uj` and `vy` in [DiagSquare.lean](../lean/HamiltonsCubic/Results/DiagSquare.lean), $(D^-_{z_s})_{aj}=z_{s,a}$. The swap-odd weight of $w$ at $(a,j)$ is $\tfrac12(w_{aj}-w_{ak})$, and with $Z'_{ab}=v_av_b+(v_a^2+v_b^2)/(n-2)-\frac1{(n-1)(n-2)}$ this is $\tfrac12t\,v_a(v_j-v_k)+\tfrac12t\,(v_j^2-v_k^2)/(n-2)$. The second term vanishes since $v_j^2=v_k^2=1/n$. The identification of $M'$ with $\tfrac12(w-\sigma w)$ goes through `rotR_swap_coordOp`, `coordOp_sub`, and $\sigma W'=E-M'$, and `coordOp_weight_eq` reads it entrywise at $a\ne j$ (both weights symmetric, which `hoT` and `vv_sym` supply). So $z_{s,a}=\tfrac12t\,v_a(v_j-v_k)$. If $v_j+v_k\ne0$ then $v_j=v_k$ (from $v_j^2=v_k^2$), $z_s=0$, $\sum z_s^2=s=0$, contradicting $s>0$. Sound. CONFIRMED.

### 3.2 Question (a): $\bar u$ against the centred indicator

At even $n$, $v=\pm1/\sqrt n$ with $\sum v=0$ puts $n/2$ indices in each block, and $v_j=-v_k$ puts $j$ and $k$ in different blocks, which is the record's "$j$ and $k$ lie in different blocks". Then $\bar u=v$ off $\{j,k\}$ is $\epsilon/\sqrt n$ on $A'=A\setminus\{j\}$ and $-\epsilon/\sqrt n$ on $B'=B\setminus\{k\}$, $\epsilon=\sqrt n\,v_j$, with $|A'|=|B'|=n/2-1$. The indicator of $A'$ centred over the $n-2$ coordinates off $\{j,k\}$ is $\pm\tfrac12$ on $A'$, $B'$, so $\bar u_{\text{Lean}}=\epsilon\,(2/\sqrt n)\,\bar u_{\text{rec}}$. Proportional, and the proportionality is all the line needs. CONFIRMED WITH OBSERVATIONS (O1 on the centring set).

The constants agree: $\alpha_A=\alpha_B=t\big(\tfrac1n+\tfrac2{n(n-2)}-\tfrac1{(n-1)(n-2)}\big)$ and $\gamma=t\big(-\tfrac1n+\tfrac2{n(n-2)}-\tfrac1{(n-1)(n-2)}\big)$, so $c=\alpha_A+\alpha_B-2\gamma=4t/n$. On $\sum z=0$, $\langle\bar u_{\text{rec}},z\rangle=\tfrac12\sum_{A'}z-\tfrac12\sum_{B'}z=\sum_{A'}z$, matching the record's $(\sum_{a\in A'}z_a)^2$. Then $c\lVert\bar u_{\text{rec}}\rVert^2=(4t/n)(n-2)/4=t(n-2)/n=t\lVert\bar u_{\text{Lean}}\rVert^2$.

### 3.3 Question (c): $\lambda$

`hq` gives $q_E(z)=t\langle\bar u,z\rangle^2$ on the plane: $q_E(z)=\langle W',G_z\rangle$ since $\langle G_z,M'\rangle=0$ (`Gy_swap`, `inner_flip_zero`), then `inner_Zp_Gy` and `hvu` (only the plane coordinates of $v$ are read). $\sum\bar u=0$ comes from $\sum v=0$ and $v_j+v_k=0$. Upper: $q_E(z_1)=t\langle\bar u,z_1\rangle^2\le t\lVert\bar u\rVert^2$ by `cs_le` and $\lVert z_1\rVert=1$. Lower: `hbound` at $\bar u$ gives $t\lVert\bar u\rVert^4=q_E(\bar u)\le\lVert\bar u\rVert^2q_E(z_1)$, divided by $\lVert\bar u\rVert^2>0$. Positivity of $\lVert\bar u\rVert^2$ comes from $\lambda>0$: $\bar u=0$ would make $q_E\equiv0$. Then $q_E(y)=\lambda\lVert y\rVert^2$ becomes Cauchy-Schwarz equality after cancelling $t>0$, and `cs_eq` puts $y$ (and $x$) on the line. CONFIRMED.

### 3.4 Question (d): scope

The record's "both $y$ and $x$ lie on it" is exactly the second branch. The record's "the line of $\bar u$ as its whole eigenspace" is delivered in the form the step uses, that every plane vector attaining the Rayleigh maximum is on the line (`hline`), which is stronger than needed for $y$, $x$ and is kept internal. `Even n` in the branch is a consequence of `charOne_eq_even`, consistent with r1812's reading that the $\theta_0$ equality case is empty at odd $n$. Nothing beyond the record is claimed. The parametrisation $(y,x)=\sqrt s\,\hat u(\cos\psi,\sin\psi)$ is not stated, and follows at once from $y=a\bar u$, $x=b\bar u$ with $\lVert y\rVert^2+\lVert x\rVert^2=s$. The rotation $e^{\varphi\xi}$ is outside the theorem and is on the owed list. CONFIRMED WITH OBSERVATIONS (O2, O4).

## 4. Declaration 3: `inner_Zp_Gy_two`

**Hypothesis.** `h2 : ∀ p, (v p - v j) * (v p - v k) = 0`, which says every $v_p$ lies in $\{v_j,v_k\}$. It admits $v_j=v_k$ (constant $v$), where both sides vanish since $\langle v,z\rangle=v_j\sum z=0$. No normalisation or zero-sum hypothesis on $v$ is taken.

**Algebra, by hand.** The pairing is $\tfrac12\sum_{i\ne l}t\,Z'_{il}G_{il}$ (`innerOp2_coordOp`). Off the diagonal $G_{il}=u_i^2z_l^2+z_i^2u_l^2+Vu_iu_l+2z_iz_l$ with $V=\lVert z\rVert^2$, and the diagonal of the same expression is $Vu_i^2+2z_i^2$ because $u_iz_i=0$. The full row sum is $Vu_i^2+2z_i^2+Vu_i\sum u+2z_i\sum z=Vu_i^2+2z_i^2$, so **every off-diagonal row sum of $G$ is zero**. Any term of $Z'$ of the form $f(i)+f(l)$ therefore pairs to zero identically, which covers both $(v_i^2+v_l^2)/(n-2)$ and the constant $-\frac1{(n-1)(n-2)}$. The rest is $\sum_{i\ne l}v_iv_lG_{il}=v^\top Gv-\sum_iv_i^2G_{ii}=2(v_j+v_k)\sum v_az_a^2+V(v_j-v_k)^2+2\langle v,z\rangle^2-V(v_j^2+v_k^2)-2\sum v_a^2z_a^2$. The two-valued hypothesis gives $v_a^2=(v_j+v_k)v_a-v_jv_k$, so $(v_j+v_k)\sum v_az_a^2-\sum v_a^2z_a^2=v_jv_kV$, which is the Lean's `h2v`, and the remainder collapses to $2\langle v,z\rangle^2$. Halving gives $t\langle v,z\rangle^2$. The commit's "the $v_p^2/(n-2)$ terms of $Z'$ cancel identically" is true (O5 on the wording).

**Odd $n$.** L57's odd maximiser takes two values on sets of sizes $(n\pm1)/2$. When $j$ and $k$ lie in different blocks, those two values are $v_j$ and $v_k$ and the hypothesis holds. When they share a block the hypothesis fails, and that case is the one the oddness argument must exclude at odd $n$, which is owed (O6). Faithful for the case step 5 uses. CONFIRMED WITH OBSERVATIONS.

## 5. `L224_eq_tight`'s $s>0$

The diff adds `0 < ∑ i, y i ^ 2 + ∑ i, x i ^ 2` to the second branch, discharged by the existing `hspos`. The docstring line records it. CONFIRMED.

## 6. INDEX row

- **L224Line sentence.** It reads "either $y=x=0$, or $n$ is even and $y$, $x$ are multiples of one $\bar u\ne0$ in the plane, through `charOne_eq_even` at $W'$ … $v_j=-v_k$ from $W'$'s nonzero odd part, $q_E=q_{B'}$ through `Gy_swap`, $q_E=t\langle\bar u,\cdot\rangle^2$ with $\bar u=v$ off $\{j,k\}$, and $\lambda=t\lVert\bar u\rVert^2$". It matches the proof.
- **`inner_Zp_Gy_two` sentence.** It reads "the same pairing $t\langle v,z\rangle^2$ whenever every $v_p$ is $v_j$ or $v_k$, which covers L57's maximisers at both parities (r1815 O1)". It matches the statement.
- **r1815 repairs.** O2: the heading now reads "Step 5, the rank-one pairing at even $n$, PROVED", with $c=4t/n$. O3: the owed list is rejoined cleanly. O4: "L57's equality clause in block-constant form, off step 5's path (r1815 O4)". O5: "the Cauchy-Schwarz step uses the projection of $v$ onto the plane (r1815 O5)". All present.
- **Owed list.** It names the odd-$n$ line ("at odd $n$, the line argument with `charOne_eq_odd` and `inner_Zp_Gy_two`"), the rotation ("the rotation $e^{\varphi\xi}$ carrying $W'$ to $W$ (L222 item 5)") and the assembled equality clause ("the Statement's equality clause on the operators assembled from these (r1815 O3)"). All three are present.

CONFIRMED WITH OBSERVATIONS (O3).

## 7. Audits

- `python3 scripts/misc/axiom_audit.py --only L224Line.lean`: "4/4 clean -- resting on the standard three alone", exit 0.
- `python3 scripts/misc/axiom_audit.py --only L224Rank.lean`: "6/6 clean -- resting on the standard three alone", exit 0.
- The working tree of the three Lean files and lean/INDEX.md matches HEAD, so the audits ran on the committed text.

## 8. Hand evaluations (exact, by hand)

**n = 5, `inner_Zp_Gy_two`.** Indices $0..4$, $j=0$, $k=1$, $t=1$, $z=(0,0,1,-1,0)$, so $u=(1,-1,0,0,0)$ and $V=2$. Off-diagonal $G$ over unordered pairs: $(0,1)\mapsto-2$, $(0,2),(0,3),(1,2),(1,3)\mapsto1$, $(2,3)\mapsto-2$, all others $0$. Every row sums to $0$.

- $v=(1,0,1,0,1)$, $v_j\ne v_k$, unnormalised. $Z'$ with $n-2=3$ and $\frac1{(n-1)(n-2)}=\tfrac1{12}$: $(0,1)\ \tfrac14$, $(0,2)\ \tfrac{19}{12}$, $(0,3)\ \tfrac14$, $(1,2)\ \tfrac14$, $(1,3)\ -\tfrac1{12}$, $(2,3)\ \tfrac14$. Pairing $=-\tfrac12+\tfrac{19}{12}+\tfrac14+\tfrac14-\tfrac1{12}-\tfrac12=1$. And $t\langle v,z\rangle^2=1$. Agrees.
- $v=(3,-2,3,-2,-2)$, L57-shaped at odd $n$ (blocks of sizes 2 and 3, $\sum v=0$, up to the scale $1/\sqrt{30}$), $j$ and $k$ in different blocks. By the zero row sums only $\sum_{\text{pairs}}v_iv_lG_{il}$ survives: $12+9-6-6+4+12=25$. And $\langle v,z\rangle^2=(3+2)^2=25$. Agrees.

**n = 4, `L224_line_even` on the sphere-product example.** Blocks $\{0,2\}$, $\{1,3\}$, $j=0$, $k=1$, $v=\tfrac12(1,-1,1,-1)$, so $v_j+v_k=0$. $Z'$: $\tfrac13$ within a block, $-\tfrac16$ across. Swap-odd part of $tZ'$: $(0,2)\ \tfrac t4$, $(1,2)\ -\tfrac t4$, $(0,3)\ -\tfrac t4$, $(1,3)\ \tfrac t4$, and $0$ at $(0,1)$, $(2,3)$. Read as $D^-_{z_s}$ this is $z_s=(0,0,\tfrac t4,-\tfrac t4)$, which equals $\tfrac12t\,v_a(v_j-v_k)$ entrywise and is $\tfrac t2\bar u$ with $\bar u=(0,0,\tfrac12,-\tfrac12)$. Direct $q(z)$ at $z=(0,0,1,-1)$: $\tfrac13+\tfrac13+\tfrac13+\tfrac13-\tfrac16-\tfrac16=1$ times $t$, equal to $t\langle\bar u,z\rangle^2=t$. Rayleigh quotient $t/2=t\lVert\bar u\rVert^2=t(n-2)/n$, and the record's $c\lVert\bar u_{\text{rec}}\rVert^2=t\cdot\tfrac12$. All agree. At $n=4$ the plane is the single line spanned by $(0,0,1,-1)$, so the line conclusion itself holds trivially here (O2).

## 9. Observations

- **O1, the record's centring set.** "the centred indicator of $A'$" does not say over which coordinates. Centred over the $n-2$ coordinates off $\{j,k\}$ it lies in the plane and equals $\pm\tfrac{\sqrt n}2\bar u_{\text{Lean}}$. Centred over all $n$ it is nonzero at $j$ and $k$ and outside the plane, where "the line of $\bar u$ as its whole eigenspace" has no meaning. The record could say "centred over the coordinates off $\{j,k\}$".
- **O2, $n=4$ is degenerate.** The plane $\{z_j=z_k=0,\sum z=0\}$ has dimension $n-3$, so at $n=4$ the line conclusion is automatic and the first informative case is $n=6$. The $n=4$ check still exercises the oddness derivation and the value of $\lambda$.
- **O3, INDEX heading parity.** `inner_Zp_Gy_two` sits under the heading "the rank-one pairing at even $n$" although it holds at both parities. A clause such as "and at both parities by `inner_Zp_Gy_two`" in the heading would remove the tension. `L224_line_even` itself uses `inner_Zp_Gy`, the even form.
- **O4, what the theorem keeps internal.** $\lambda=t\lVert\bar u\rVert^2$, the Rayleigh-maximiser line statement `hline`, and the value $v=\bar u$ off $\{j,k\}$ are proved inside the proof and not exported. The rotation step will need to relate $\bar u$ to $W'$, so an exported $\bar u=$ `vy j k v` with the $W'$ weight may save a later round.
- **O5, wording of the cancellation.** The commit and INDEX say the $v_p^2/(n-2)$ terms cancel identically. The constant $-\frac1{(n-1)(n-2)}$ term also cancels identically, by the same zero row sums of $G$, so the two-valued hypothesis is needed only for the $v_iv_l$ part.
- **O6, odd $n$ oddness step.** At odd $n$ the analogue of §3.1 gives $z_{s,a}=\tfrac12t\,v_a(v_j-v_k)+\tfrac12t(v_j^2-v_k^2)/(n-2)$, and $v_j^2=v_k^2$ is no longer available. The owed odd-$n$ line should derive "$j$, $k$ in different blocks" from the fact that $v_j=v_k$ makes both terms vanish, which holds, before applying `inner_Zp_Gy_two`.
- **O7, a stronger by-product.** §3.1's identity $z_s=\tfrac t2(v_j-v_k)\,\bar u$ (at even $n$) already places $z_*$ on the line of $\bar u$ directly. The Lean uses only its contrapositive, which is enough.

## 10. What would falsify each headline

- **Claim 2 (faithful line).** A reading of the record under which $\bar u$ is outside the plane (O1's all-$n$ centring) and the record's line differs from the Lean's, or an even-$n$ equality configuration with $y$ not proportional to $v$ off $\{j,k\}$. The second is excluded by the kernel-checked proof on the audited axioms.
- **Claim 4 (oddness).** A symmetric weight whose `coordOp` equals $D^-_{z_s}$ but whose $(a,j)$ entry differs from $z_{s,a}$, which `coordOp_weight_eq` rules out for symmetric weights off the diagonal.
- **Claim 7 (two-valued pairing).** A two-valued $v$, a plane vector $z$ and $n\ge3$ with $\tfrac12\sum_{i\ne l}Z'_{il}G_{il}\ne\langle v,z\rangle^2$. The hand derivation and both $n=5$ evaluations agree with the identity.
- **Claim 9 (INDEX).** A missing owed item or a sentence that misstates a declaration. None was found beyond O3.
