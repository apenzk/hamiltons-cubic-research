# REVIEW r1824: L224Rot, the double-angle action of the (j,k)-rotation

Gate 2 on [lean/HamiltonsCubic/Results/L224Rot.lean](../lean/HamiltonsCubic/Results/L224Rot.lean) at commit e8b16b30, against Lemma L222 item 5 and Lemma L224 step 5 of [findings/second-order.md](../findings/second-order.md) and the L222 and L224 rows of [lean/INDEX.md](../lean/INDEX.md). Analysis only: every identity below was re-derived by hand from the definitions in [PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean), [DiagSquare.lean](../lean/HamiltonsCubic/Results/DiagSquare.lean) and [FrameOp2.lean](../lean/HamiltonsCubic/Results/FrameOp2.lean). The one run is the axiom audit.

| Claim | Verdict |
|---|---|
| sandOp_lin, linearity of a sandwich in its first factor | CONFIRMED |
| Rot_S, $RSR^{\mathsf T}=(c^2-s^2)S-2cs\,D_u$ | CONFIRMED |
| rot_Dminus, $R\cdot D^-_y=(c^2-s^2)D^-_y+2cs\,\nu_y$ | CONFIRMED |
| rot_nuX, $R\cdot\nu_x=(c^2-s^2)\nu_x-2cs\,D^-_x$ | CONFIRMED |
| Rot_mul_off, mul_RotT_off, RtXR_off, rot_out | CONFIRMED |
| rot_even, every symmetric weight with $e_{ja}=e_{ka}$ off $\{j,k\}$ is fixed | CONFIRMED WITH OBSERVATIONS |
| Fidelity to L222 item 5 and L224 step 5 (derivative, double angle, swap-even hypothesis, no infinitesimal claims) | CONFIRMED WITH OBSERVATIONS |
| lean/INDEX.md, the L224Rot sentences, the r1823 O3 wording and the item 5 owed text | CONFIRMED WITH OBSERVATIONS |
| Axiom audit | CONFIRMED, 10/10 on the standard three |

**Summary.** Every declaration states what the brief says and proves it on the standard three axioms. The derivative at $\varphi=0$ reproduces the record's $\xi\cdot D^-_y=\nu_{2y}$ and $\xi\cdot\nu_x=D^-_{-2x}$ with the sign exactly as written. The observations concern bridges the file leaves to the owed step.

## 1. The record, verbatim

L222 item 5 (line 1596): "$\xi\cdot D\in V_{jk}$ with coordinates $K_{ja}-K_{ka}$, and $\xi\cdot\nu\in\mathcal D_n$ with $\lVert\xi\cdot\nu\rVert^2=4\lVert\nu\rVert^2$. At an angle of the $(j,k)$-rotation minimising $\lVert\nu\rVert^2$, with $D$, $K$ and $x$ those of the rotated tensor: $\langle x,K_{j\cdot}-K_{k\cdot}\rangle=0$, and $\lVert\nu\rVert^2\le\tfrac12\sum_a(K_{ka}-K_{ja})^2$."

L224 step 5 (line 1620): "By L222's item 5, $\xi\cdot E=0$, $\xi\cdot D^-_y=\nu_{2y}$ and $\xi\cdot\nu_x=D^-_{-2x}$, so $e^{\varphi\xi}$ fixes $E$ and rotates $(y,x)$ by $2\varphi$, and $W=e^{\varphi\xi}\cdot W'$ with $2\varphi=\psi$ up to the sign convention of $\xi$."

## 2. The definitions the declarations rest on

- Rot j k c s has column $j$ equal to $c\,e_j+s\,e_k$ and column $k$ equal to $-s\,e_j+c\,e_k$, identity elsewhere. So $Re_j=c e_j+s e_k$, $Re_k=-s e_j+c e_k$, as the brief states.
- rotR U V is $X\mapsto U\,V(U^{\mathsf T}XU)\,U^{\mathsf T}$ (rotR_coe, cU_coe).
- coordOp a is $X\mapsto a\odot X$ on skew $X$, and coordOp of $pq^{\mathsf T}+qp^{\mathsf T}$ is sandOp $(D_p,D_q)$, the map $X\mapsto D_pXD_q+D_qXD_p$ (coordOp_rank_two). rotR U of sandOp $(A,B)$ is sandOp $(UAU^{\mathsf T},UBU^{\mathsf T})$ (rotR_sandOp).
- Dminus j k y is the weight $u\,v^{\mathsf T}+v\,u^{\mathsf T}$ with $u=e_j-e_k$ (uj) and $v$ equal to $y$ off $\{j,k\}$ and $0$ at $j,k$ (vy). nuX j k x is sandOp $(S,D_{v})$ with $S=E_{jk}+E_{kj}$.

## 3. The four rotation identities, by hand

- **Rot_diag_u (used).** $RD_uR^{\mathsf T}=(Re_j)(Re_j)^{\mathsf T}-(Re_k)(Re_k)^{\mathsf T}$ has entries $jj$: $c^2-s^2$, $kk$: $s^2-c^2$, $jk=kj$: $cs+sc$. So $(c^2-s^2)D_u+2cs\,S$.
- **Rot_S.** $RSR^{\mathsf T}=(Re_j)(Re_k)^{\mathsf T}+(Re_k)(Re_j)^{\mathsf T}$ has $jj$: $-2cs$, $kk$: $2cs$, $jk=kj$: $c^2-s^2$. So $(c^2-s^2)S-2cs\,D_u$. CONFIRMED, with no use of $c^2+s^2=1$, matching the Lean hypotheses.
- **rot_Dminus.** $D^-_y=\mathrm{sandOp}(D_u,D_v)$, and $RD_vR^{\mathsf T}=D_v$ since $v_j=v_k=0$ (Rot_diag_fix, which does need $c^2+s^2=1$). Linearity (sandOp_lin) gives $(c^2-s^2)\,\mathrm{sandOp}(D_u,D_v)+2cs\,\mathrm{sandOp}(S,D_v)=(c^2-s^2)D^-_y+2cs\,\nu_y$. CONFIRMED.
- **rot_nuX.** The same with Rot_S: $(c^2-s^2)\nu_x-2cs\,D^-_x$. CONFIRMED.
- **rot_out and its three lemmas.** For a weight vanishing on rows and columns $j,k$, $e\odot(R^{\mathsf T}XR)=e\odot X$ because $R^{\mathsf T}XR$ agrees with $X$ off rows and columns $j,k$ (RtXR_off), and $R(e\odot X)R^{\mathsf T}=e\odot X$ because that matrix has zero rows and columns $j,k$ (Rot_mul_off, mul_RotT_off). CONFIRMED. rot_out carries no $c^2+s^2=1$ hypothesis and needs none.

## 4. Fidelity questions

**Q1, the derivative.** At $c=\cos\varphi$, $s=\sin\varphi$: $\tfrac{d}{d\varphi}(c^2-s^2)|_0=0$ and $\tfrac{d}{d\varphi}(2cs)|_0=2$. So rot_Dminus differentiates to $\xi\cdot D^-_y=2\nu_y=\nu_{2y}$ and rot_nuX to $\xi\cdot\nu_x=-2D^-_x=D^-_{-2x}$, using that $\nu$ and $D^-$ are linear in their vector (vy and the sandwich are linear). Both agree with the record exactly, with $\xi$ the generator of Rot's convention, $\xi e_j=e_k$, $\xi e_k=-e_j$. No sign flip is needed. Cross-check against item 5's first clause: for $D=\mathrm{coordOp}\,K$ the odd part is $D^-_y$ with $y_a=\tfrac12(K_{ja}-K_{ka})$, so $\xi\cdot D=\nu_{2y}$ has coordinates $K_{ja}-K_{ka}$, the record's sign. The derivative itself is not typed (O2).

**Q2, the double angle.** For $V=D^-_y+\nu_x$, the two identities give $R\cdot V=D^-_{(c^2-s^2)y-2cs\,x}+\nu_{2cs\,y+(c^2-s^2)x}$. At $c=\cos\varphi$, $s=\sin\varphi$ this is $(y,x)\mapsto(\cos2\varphi\,y-\sin2\varphi\,x,\ \sin2\varphi\,y+\cos2\varphi\,x)$, the rotation by $+2\varphi$ in $(D^-,\nu)$ coordinates. The reading is exact. With $W'=E+D^-_{\sqrt s\,\hat u}$ at $(y',x')=\sqrt s\,\hat u(1,0)$ and $W$ at $\sqrt s\,\hat u(\cos\psi,\sin\psi)$, Rot's convention gives $2\varphi=\psi$ with no sign adjustment. The combined statement and the parametrisation by $\varphi$ are the reader's assembly, since the file states the two identities separately in $(c,s)$ (O1).

**Q3, the hypothesis of rot_even.** The hypothesis is a symmetric weight $e$ with $e_{ja}=e_{ka}$ for every $a\notin\{j,k\}$. Since coordOp reads only the off-diagonal weight (coordOp_congr_off), and the swap $\sigma$ permutes the weight (rotR_swap_coordOp in [OddPart.lean](../lean/HamiltonsCubic/Results/OddPart.lean)), a coordinate operator is swap-even exactly when its weight satisfies $e_{ja}=e_{ka}$ off $\{j,k\}$, $e_{jk}=e_{kj}$ being symmetry. The diagonal entries $e_{jj},e_{kk}$ are unconstrained and invisible to coordOp, so the hypothesis is exactly swap-evenness in the record's sense. For $E=\tfrac12(D+\sigma D)$ with $D=\mathrm{coordOp}\,K$ of character $1$, $E$ has weight $\tfrac12(K+K^\sigma)$ with $e_{ja}=\tfrac12(K_{ja}+K_{ka})=e_{ka}$, so rot_even applies. The bridge from an operator $E$ to such a weight (charOne_diag, then the swap) is outside this file (O3).

**The decomposition, entry by entry.** The proof writes the weight as $e^{o}+(Pr^{\mathsf T}+rP^{\mathsf T})+\tfrac{e_{jk}}2(PP^{\mathsf T}-uu^{\mathsf T})$ with $P=\mathbf 1_{\{j,k\}}$, $r=\mathrm{vy}(e_{j\cdot})$, $u=e_j-e_k$, and $e^{o}$ the restriction of $e$ off rows and columns $j,k$. Off the diagonal:

| Entry | $e^{o}$ | $Pr^{\mathsf T}+rP^{\mathsf T}$ | $\tfrac{e_{jk}}2(PP^{\mathsf T}-uu^{\mathsf T})$ | Sum | Target |
|---|---|---|---|---|---|
| $(a,b)$, both off $\{j,k\}$ | $e_{ab}$ | $0$ | $0$ | $e_{ab}$ | $e_{ab}$ |
| $(j,a)$ | $0$ | $e_{ja}$ | $0$ | $e_{ja}$ | $e_{ja}$ |
| $(k,a)$ | $0$ | $e_{ja}$ | $0$ | $e_{ja}$ | $e_{ka}=e_{ja}$ by hev |
| $(a,j)$, $(a,k)$ | $0$ | $e_{ja}$ | $0$ | $e_{ja}$ | $e_{aj}$, $e_{ak}$ by symmetry and hev |
| $(j,k)$, $(k,j)$ | $0$ | $r_j+r_k=0$ | $\tfrac{e_{jk}}2(1-(-1))$ | $e_{jk}$ | $e_{jk}=e_{kj}$ |

Each part is fixed. $e^{o}$ is fixed by rot_out. $Pr^{\mathsf T}+rP^{\mathsf T}=\mathrm{sandOp}(D_P,D_r)$ is fixed through Rot_diag_fix, since $P_j=P_k$ and $r_j=r_k=0$, and $PP^{\mathsf T}$ likewise. $uu^{\mathsf T}$ is fixed through sandOp_uu_rot (on the $(j,k)$ block $RD_uR^{\mathsf T}$ is a reflection $M$ and $MJM=\det(M)J=-J=D_uJD_u$). CONFIRMED.

**Q4, infinitesimal claims.** No declaration mentions $\xi$, a derivative, $\xi\cdot D\in V_{jk}$, $\xi\cdot\nu\in\mathcal D_n$ or $\lVert\xi\cdot\nu\rVert^2=4\lVert\nu\rVert^2$. The module docstring quotes item 5 and step 5 and then says "the finite rotation reads", which is accurate. As a hand screen only: $\lVert\xi\cdot\nu_x\rVert^2=\lVert D^-_{-2x}\rVert^2=2\lVert2x\rVert^2=8\lVert x\rVert^2=4\lVert\nu_x\rVert^2$ by normSq2_Dminus and normSq2_nuX, consistent with the record. The L222 row lists these as untyped. CONFIRMED.

## 5. Exact hand evaluation

Labelled as a hand evaluation. $n=4$, $j=0$, $k=1$, $c=3/5$, $s=4/5$, $y=(0,0,1,-1)$, $\varphi_{ab}=e_ae_b^{\mathsf T}-e_be_a^{\mathsf T}$.

- $R^{\mathsf T}e_0=c e_0-s e_1$ and $R^{\mathsf T}e_2=e_2$, so $R^{\mathsf T}\varphi_{02}R=c\varphi_{02}-s\varphi_{12}$.
- The weight of $D^-_y$ has $W_{02}=u_0v_2=1$ and $W_{12}=u_1v_2=-1$. So $D^-_y(c\varphi_{02}-s\varphi_{12})=c\varphi_{02}+s\varphi_{12}$.
- $R\varphi_{02}R^{\mathsf T}=c\varphi_{02}+s\varphi_{12}$ and $R\varphi_{12}R^{\mathsf T}=-s\varphi_{02}+c\varphi_{12}$. The result is $(c^2-s^2)\varphi_{02}+2cs\,\varphi_{12}=-\tfrac7{25}\varphi_{02}+\tfrac{24}{25}\varphi_{12}$.
- Right side: $D^-_y\varphi_{02}=\varphi_{02}$, and $\nu_y\varphi_{02}=S\varphi_{02}D_v+D_v\varphi_{02}S=e_1e_2^{\mathsf T}-e_2e_1^{\mathsf T}=\varphi_{12}$ (nuX_phi_ja with $y_2=1$). So $(c^2-s^2)D^-_y\varphi_{02}+2cs\,\nu_y\varphi_{02}=-\tfrac7{25}\varphi_{02}+\tfrac{24}{25}\varphi_{12}$.

The two sides agree exactly.

## 6. lean/INDEX.md

- **L224 row, L224Rot sentences.** "**The rotation $e^{\varphi\xi}$ on $\mathcal S_{jk}$, PROVED** in L224Rot.lean, with $R=\mathrm{Rot}_{jk}(c,s)$, $c^2+s^2=1$: `sandOp_lin`; `Rot_S`, …; **`rot_Dminus`**, …; **`rot_nuX`**, $R\cdot\nu_x=(c^2-s^2)\nu_x-2cs\,D^-_x$, so $(y,x)$ turns by the double angle; … **`rot_even`**, every swap-even weight ($e_{ja}=e_{ka}$) is fixed, split as its off-$\{j,k\}$ part, $Pr^{\mathsf T}+rP^{\mathsf T}$ and $\tfrac{e_{jk}}2(PP^{\mathsf T}-uu^{\mathsf T})$; standard three axioms." Every formula matches the file. The heading names $e^{\varphi\xi}$ while the file proves the finite Rot at unit $(c,s)$, which is the same group with the identification $c=\cos\varphi$ untyped (O1).
- **r1823 O3 wording.** "(the proof's witness is the projection of $v$ onto the plane, $v$ off $\{j,k\}$ minus its mean there, which the statement does not export, r1823 O3)". This is the repair r1823 O3 asked for: the clause now reads as a fact about the proof. Accurate.
- **Owed list.** "the choice of angle carrying $W'$ to $W$ from `rot_Dminus`, `rot_nuX` and `rot_even`; and the Statement's equality clause on the operators assembled from these (r1815 O3)". Accurate, and O4 names what that step still needs from the line lemmas.
- **L222 row, item 5 owed text.** "item 5, of which the scalar step `pair_mass_le` is typed (L222Statement.lean) and the finite rotation action on $\mathcal S_{jk}$ is proved in L224Rot.lean (`rot_Dminus`, `rot_nuX`, `rot_even`), the infinitesimal form $\xi\cdot D$ with coordinates $K_{ja}-K_{ka}$, $\lVert\xi\cdot\nu\rVert^2=4\lVert\nu\rVert^2$ and the minimising angle being untyped". Accurate. It omits the clause $\xi\cdot\nu\in\mathcal D_n$ from the untyped list and L224Rot.lean from the row's file column (O5).

## 7. Axiom audit

`python3 scripts/misc/axiom_audit.py --only L224Rot.lean` printed "auditing 10 declarations across 1 files" and "10/10 clean -- resting on the standard three alone". The ten are the nine the brief lists plus lin_T, a transpose helper for $aA+bA'$.

## 8. Observations

- **O1, the double angle is assembled by the reader.** The file states rot_Dminus and rot_nuX separately in $(c,s)$. The rotation of the pair $(y,x)$ by $2\varphi$ follows in one line from them and the linearity of $D^-$ and $\nu$ in their vector, and the identification $e^{\varphi\xi}=\mathrm{Rot}_{jk}(\cos\varphi,\sin\varphi)$ is standard. A lemma rot_pair, $R\cdot(D^-_y+\nu_x)=D^-_{y'}+\nu_{x'}$ with $(y',x')$ the rotated pair, would make the INDEX clause "so $(y,x)$ turns by the double angle" a statement fact and is what the owed angle step consumes.
- **O2, the derivative is untyped.** Q1's agreement with the record is a hand computation. The file correctly claims only the finite action.
- **O3, operator to weight.** rot_even is stated on weights. The owed step must pass from the swap-even Weyl operator $E$ of character $1$ to coordOp $e$ with the hypothesis hev, through charOne_diag (or the weight of $D$) and rotR_swap_coordOp with coordOp_weight_eq. Every piece exists, and the bridge is short.
- **O4, the angle step still needs r1823 O3's export.** To write $W=R\cdot W'$ the owed step needs $W'=E+D^-_{\sqrt s\,\hat u}$ with $\hat u$ on the same line as $y$ and $x$. L224_line_even and L224_line_odd export only collinearity of $y$ and $x$, and $W'$ is built from the maximiser $z_*$. Tying $z_*$ to that line needs the line to be $\lambda$'s whole eigenspace, which is proved in the body and not exported (r1823 O3). This is a dependency of the owed step, and the L224Rot file is complete for its own part.
- **O5, L222 row bookkeeping.** The item 5 untyped list omits "$\xi\cdot\nu\in\mathcal D_n$", and L224Rot.lean is absent from the L222 row's file column though the row now cites it for item 5, as r1813 O2 added PairConv to a row that cited it.
- **O6, the module docstring lists four of ten declarations.** The bullet list stops at rot_nuX. rot_out and rot_even, the half of step 5's sentence that fixes $E$, appear only in their own docstrings.

## 9. What would falsify each headline

- rot_Dminus or rot_nuX: an entry of $RD_uR^{\mathsf T}$ or $RSR^{\mathsf T}$ other than §3's, or a Rot whose column $j$ is $c e_j-s e_k$. The definition and the hand evaluation of §5 rule out both at $(3/5,4/5)$.
- The double angle: a weight on $\nu_y$ in rot_Dminus other than $\sin2\varphi$, or matching signs on the cross terms of rot_Dminus and rot_nuX (which would give a hyperbolic, not a rotation, action). The signs are $+2cs$ and $-2cs$.
- rot_even: an off-diagonal entry where §4's table fails. The $(j,k)$ entry is the only one using the third part, and $1-(-1)=2$ closes it.
- The agreement with the record's sign: $\xi\cdot D$ with coordinates $K_{ka}-K_{ja}$. The odd part's weight $y_a=\tfrac12(K_{ja}-K_{ka})$ fixes the sign as the record writes it.
- The audit: any declaration resting on sorryAx or a project axiom. The audit reports none.
