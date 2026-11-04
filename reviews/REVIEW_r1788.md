# REVIEW r1788: statement fidelity of L222Swap.lean against Lemma L222

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every headline declaration of [L222Swap.lean](../lean/HamiltonsCubic/Results/L222Swap.lean) (commit bf9f68ac) states what the record's item 3 odd clause says, under weaker hypotheses. The defects are on the record's side of the ledger: [lean/INDEX.md:151](../lean/INDEX.md)'s owed list omits items 5 and 6, and the record's own Lean note at [second-order.md:1575](../findings/second-order.md) still lists item 3's odd clause as owed.

Footing: analysis only. The runs were the axiom audit and one `#print axioms` scratch file. No screen was run, and nothing below is numerical evidence.

## The record, verbatim

[findings/second-order.md:1577](../findings/second-order.md), the preamble:

> *Let $n\ge4$, $j\ne k$, and $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$. Write $\nu\in V_{jk}$ as $\nu=\sum_ax_a\,e_{ja}\odot e_{ka}$ ($a\notin\{j,k\}$, $\sum x=0$, $\lVert\nu\rVert^2=2\lVert x\rVert^2$), $D\in\mathcal D_n$ with sectional matrix $K$, and let $\sigma$ swap $j$ and $k$ with $D=D^++D^-$ its even and odd parts, the odd part having entries $K_{ja}=-K_{ka}$. Let $\xi\in\mathfrak{so}(n)$ be the generator with $\xi e_j=e_k$, $\xi e_k=-e_j$. Sums over $a$ run over $a\notin\{j,k\}$.*

[findings/second-order.md:1580](../findings/second-order.md), item 3:

> *If $W=D+\nu$ is a unit critical point with $\nu\ne0$, then $\langle D,\hat g\rangle=\theta/\sqrt3$ for $\hat g=G_x/\lVert G_x\rVert$, and $2L_{D^+}D^-=\theta D^-$.*

Item 3's proof (line 1587) closes the odd clause with "$G_x$ is swap-even, and $(D\circ D)^-=2D^+\circ D^-$".

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | rotR (swapM j k) is the record's $\sigma$ | CONFIRMED |
| 2 | pair_swap_even: every Weyl operator of character $\varepsilon_j\varepsilon_k$ is $\sigma$-fixed | CONFIRMED |
| 3 | Sjk_odd first conjunct is item 3's $2L_{D^+}D^-=\theta D^-$ | CONFIRMED WITH OBSERVATIONS (O2, O3) |
| 3' | Sjk_odd second conjunct $\nu\circ D^-=0$ is true and consistent with the record | CONFIRMED WITH OBSERVATIONS (O3) |
| 4 | ops_orth is L219_ops_gen at any orthogonal $U$ | CONFIRMED WITH OBSERVATIONS (O4) |
| 5 | INDEX row 151 describes the two files and lists what is owed | REFUTED AS STATED on completeness (O5, O6) |
| 6 | Axioms of pair_swap_even and Sjk_odd | CONFIRMED: propext, Classical.choice, Quot.sound |

## Check 1: $\sigma$

- swapM j k has entry $1$ at $(a,b)$ exactly when $a=s(b)$, $s=(j\,k)$ ([L222Swap.lean:35](../lean/HamiltonsCubic/Results/L222Swap.lean)), so $Me_b=e_{s b}$ and $M^{\mathsf T}=M=M^{-1}$ (swapM_T, swapM_sq).
- [FrameOp2.lean:54](../lean/HamiltonsCubic/Results/FrameOp2.lean)'s rotR_coe gives $(\mathop{\mathrm{rotR}}U\,V)(X)=U\,V(U^{\mathsf T}XU)\,U^{\mathsf T}$.
- With phi a b $=E_{ba}-E_{ab}$ ([WeylReal.lean:45](../lean/HamiltonsCubic/Base/WeylReal.lean)), $M\varphi_{ab}M^{\mathsf T}$ has entry $(p,q)$ equal to $(\varphi_{ab})_{sp,sq}$, which is $\varphi_{sa,sb}$. This is swapM_phi at line 65, derived from swapM_entry.
- Hence $(\sigma V)(\varphi_{sa,sb})=M\,V(\varphi_{ab})\,M$, the push-forward of $V$ by the permutation, and $\sigma(\varphi_{ab}\odot\varphi_{cd})=\varphi_{sa,sb}\odot\varphi_{sc,sd}$. On a diagonal $D$ the sectional matrix transforms as $K'_{ab}=K_{sa,sb}$, so the odd part $\tfrac12(K-K\circ s)$ has $K^-_{ja}=-K^-_{ka}$ and vanishes at $jk$ and at $ab$, which is the record's description of $D^-$. $M$ is the reflection in $e_j-e_k$, the same $\sigma$ L224's step 3 names.

## Check 2: pair_swap_even

- The proof takes $c$ from [L120Ident.lean:64](../lean/HamiltonsCubic/Results/L120Ident.lean)'s pair_block_iff, which writes extendL V as pairMap j k c, that is $\sum_{i\notin\{j,k\}}c_i\,\mathrm{rk2}(\varphi_{ji},\varphi_{ki})$ precomposed with the skew projection ([L120Pair.lean:168](../lean/HamiltonsCubic/Results/L120Pair.lean), [L120PairDim.lean:28](../lean/HamiltonsCubic/Results/L120PairDim.lean)).
- rk2 U V X $=\langle V,X\rangle U+\langle U,X\rangle V$ ([L121Block.lean:102](../lean/HamiltonsCubic/Results/L121Block.lean)) is symmetric in $U,V$ (rk2_comm, line 247), and it is the operator $U\odot V$. The record's $e_{ja}\odot e_{ka}$ is the same object: $\varphi_{ja}=\pm e_{ja}$ and $\varphi_{ka}=\pm e_{ka}$ under one sign convention, so the product carries $(\pm1)^2=1$, and any factor $\tfrac12$ in $\odot$ is absorbed into $x$.
- $\sigma$ sends $\varphi_{ji}\mapsto\varphi_{ki}$ and $\varphi_{ki}\mapsto\varphi_{ji}$ for $i\notin\{j,k\}$, with no sign (lines 143 to 146), and inner2 is conjugation-invariant, so each summand is fixed (act_pairMap). The proof is sound.
- **Attempt to break it, by hand.** A symmetric operator $V$ with character $\varepsilon_j\varepsilon_k$ maps $\varphi_{ab}$ into the span of the $\varphi_{cd}$ with $\{a,b\}\triangle\{c,d\}=\{j,k\}$. That forces $\{a,b\}=\{j,i\}$, $\{c,d\}=\{k,i\}$ or the reverse, so $V=\sum_ic_i\,\varphi_{ji}\odot\varphi_{ki}$ with no other entry. $\sigma$ exchanges the two slots of each summand, so a $\sigma$-odd survivor would need $V\varphi_{ji}=c_i\varphi_{ki}$ and $V\varphi_{ki}=-c_i\varphi_{ji}$, which is antisymmetric. **A $\sigma$-odd operator of character $\varepsilon_j\varepsilon_k$ exists only off the self-adjoint operators**, and IsWeyl2 excludes it. The Weyl hypothesis is used only through its self-adjointness and pair_block_iff's Ricci cut, the latter not needed for the conclusion.

**Non-trivial object.** At $n=5$, $j=0$, $k=1$: $V_\ast=\varphi_{02}\odot\varphi_{12}-\varphi_{03}\odot\varphi_{13}$, the pairMap with $c=e_2-e_3$, $\sum c=0$. It is Weyl by [L120Pair.lean](../lean/HamiltonsCubic/Results/L120Pair.lean)'s pairS_mem, nonzero ($V_\ast\varphi_{02}=\varphi_{12}$), and has character $\varepsilon_0\varepsilon_1$ since each summand carries $\varepsilon_0\varepsilon_i\cdot\varepsilon_1\varepsilon_i$. pair_swap_even asserts $\sigma V_\ast=V_\ast$: $\sigma$ exchanges $\varphi_{02}\leftrightarrow\varphi_{12}$ and $\varphi_{03}\leftrightarrow\varphi_{13}$, and each symmetric product returns to itself. In the record's coordinates $V_\ast$ is $\nu$ with $x=(1,-1,0)$ on $a\in\{2,3,4\}$. This is a hand evaluation of the theorem on a constructed object, not a screen.

## Check 3: Sjk_odd against item 3

- $\circ$ agrees: foxProd2 X Y $=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ ([FirstVariation.lean:57](../lean/HamiltonsCubic/Results/FirstVariation.lean)) is [conventions.md:136](../findings/conventions.md)'s $X\circ Y$, and $L_XY=X\circ Y$, so $2\,$foxProd2 $D^+\,D^-=\theta D^-$ is $2L_{D^+}D^-=\theta D^-$.
- $\mathcal D_n$ and $V_{jk}$ agree: IsWeyl2 with sign character $1$ is a diagonal Weyl operator, and IsWeyl2 with character $\varepsilon_j\varepsilon_k$ is exactly $V_{jk}$ (pair_block_iff with the Ricci cut $\sum c=0$, the record's $\sum x=0$).
- Criticality agrees: Qop2 maps Weyl to Weyl ([WeylMaximiser.lean:128](../lean/HamiltonsCubic/Results/WeylMaximiser.lean)'s isWeyl2_Qop2), so a critical point of $P$ on the Weyl sphere satisfies $Q(W)=\theta W$ with no projection, which is the hypothesis hQ and the form the record's proof uses ("$D\circ D+G_x=\theta D$").
- Dropping unit norm, $\nu\ne0$ and $n\ge4$ weakens the hypotheses, so the Lean statement implies the record's clause. $\nu\ne0$ is used by the record only for the pinning's division by $\lVert G_x\rVert$, and the odd clause needs neither it nor the norm.

## Check 4: ops_orth

[L222Swap.lean:175](../lean/HamiltonsCubic/Results/L222Swap.lean) is [L219GenOps.lean:95](../lean/HamiltonsCubic/Results/L219GenOps.lean)'s L219_ops_gen line for line, with rotR (Su u) replaced by rotR U and the hypothesis Su_orth u hu replaced by hU : IsOrth U. Only Qop2_rotR uses orthogonality. CONFIRMED.

## Numbered observations

1. **O1, the swap identification is by push-forward**, [L222Swap.lean:65](../lean/HamiltonsCubic/Results/L222Swap.lean). $\sigma=$ rotR M is the conjugation action of the reflection $M$ in $e_j-e_k$, of determinant $-1$. The record writes "$\sigma$ swap $j$ and $k$" without naming the matrix, and L224 step 3 names this reflection, so the two agree.
2. **O2, the Lean's $D^\pm$ are defined, the record's are described.** [L222Swap.lean:203](../lean/HamiltonsCubic/Results/L222Swap.lean) writes $D^\pm=\tfrac12(D\pm\sigma D)$ inline. The record characterises $D^-$ by its entries (line 1577). Check 1 shows they coincide, but the file carries no lemma reading $D^-$'s sectional entries, so the link to "$K_{ja}=-K_{ka}$" is a hand step.
3. **O3, the second conjunct $\nu\circ D^-=0$ holds with no criticality at all.** $\nu\circ D^-$ is Weyl (Q keeps $\mathcal W_n$) of character $\varepsilon_j\varepsilon_k$ (foxProd2_char2), so pair_swap_even makes it $\sigma$-fixed. $\sigma$ is an automorphism of $\circ$ on Weyl operators (Qop2_rotR), so $\sigma(\nu\circ D^-)=\nu\circ(-D^-)$. Hence $\nu\circ D^-=0$ for every diagonal Weyl $D$ and every $\nu\in V_{jk}$. The conclusion is true and consistent with the record: split the $V_{jk}$ equation $2D\circ\nu=\theta\nu$ by $\sigma$-parity and it reads $2D^+\circ\nu=\theta\nu$, $D^-\circ\nu=0$. The docstring at line 199 presents it as a consequence of criticality. It is an identity on $\mathcal S_{jk}$, and stating it so would be the stronger and more reusable lemma. The first conjunct then equals the $\mathcal D_n$ equation's odd part, exactly the record's route.
4. **O4, ops_orth duplicates L219_ops_gen.** [L219GenOps.lean:95](../lean/HamiltonsCubic/Results/L219GenOps.lean) is now ops_orth (Su_orth u hu). A corollary would retire 20 duplicated lines. Maintenance only.
5. **O5, INDEX row 151's owed list is incomplete.** [lean/INDEX.md:151](../lean/INDEX.md) owes "item 1's rotation invariance; item 2 ...; item 4". Items 5 and 6 are also unproved on operators: item 5's $\xi\cdot D\in V_{jk}$, $\xi\cdot\nu\in\mathcal D_n$, $\lVert\xi\cdot\nu\rVert^2=4\lVert\nu\rVert^2$ and the first-order condition $\langle x,K_{j\cdot}-K_{k\cdot}\rangle=0$ have only pair_mass_le's scalar last step ([L222Statement.lean:81](../lean/HamiltonsCubic/Results/L222Statement.lean)), and item 6's $\theta\langle D,G_x\rangle=\langle L_{G_x}D,D\rangle$ has nothing. The row's descriptions of L222Op.lean and L222Swap.lean themselves match the signatures (Sjk_mul, Sjk_crit, Sjk_pin at L222Op.lean:124, 136, 163, and the L222Swap declarations as checked above). The row also ends "item 4 **statement: typed**", which reads as a status grafted onto a list entry.
6. **O6, the record's Lean note is stale.** [second-order.md:1575](../findings/second-order.md) says "The Lean owes item 2, item 3's $2L_{D_+}D_-=\theta D_-$, item 4 and the rotation invariance". bf9f68ac proves item 3's odd clause and did not touch the record, and the note shares O5's omission of items 5 and 6. It also cites only L222Statement.lean and L222Op.lean, not L222Swap.lean.
7. **O7, a concurrent build.** The first axiom_audit run failed with L222Op.olean missing while another session's lake build HamiltonsCubic rebuilt it. After that build finished the audit reported 15/15 clean and the scratch file compiled. The theorem count is 15 because swapM is a def.

## Axioms

`#print axioms` from a scratch file compiled with lake env lean after the concurrent build:

- pair_swap_even: [propext, Classical.choice, Quot.sound]
- Sjk_odd: [propext, Classical.choice, Quot.sound]
- ops_orth and act_pairMap: the same three.
- python3 scripts/misc/axiom_audit.py --only L222Swap.lean: 15/15 clean.

## What would falsify each headline

- **swapM_phi / $\sigma$**: a pair $a,b$ with $M\varphi_{ab}M^{\mathsf T}=-\varphi_{sa,sb}$ or $\ne\pm\varphi_{sa,sb}$. Excluded by the entry formula.
- **pair_swap_even**: a self-adjoint Weyl operator of character $\varepsilon_j\varepsilon_k$ whose $(\varphi_{ji},\varphi_{ki})$ entry differs from its $(\varphi_{ki},\varphi_{ji})$ entry. Self-adjointness excludes it, so only a non-self-adjoint operator of that character is $\sigma$-odd, and it is not Weyl.
- **Sjk_odd, first conjunct**: a diagonal Weyl $D$, a $\nu\in V_{jk}$ and $\theta$ with $Q(D+\nu)=\theta(D+\nu)$ and $2D^+\circ D^-\ne\theta D^-$.
- **Sjk_odd, second conjunct**: any diagonal Weyl $D$ and $\nu\in V_{jk}$ with $\nu\circ D^-\ne0$, critical or not (O3 rules it out).
- **ops_orth**: an orthogonal $U$ and a Weyl $W$ with $Q(W)=\theta W$ and $Q(\sigma W)\ne\theta\,\sigma W$, which Qop2_rotR excludes.

## Recommended repairs

- Add items 5 and 6 to the owed list at [lean/INDEX.md:151](../lean/INDEX.md), and separate "item 4" from its status.
- Update [second-order.md:1575](../findings/second-order.md): item 3's odd clause is proved in L222Swap.lean, owed are items 1 (rotation), 2, 4, 5 and 6.
- Optional: restate Sjk_odd's second conjunct as a hypothesis-free lemma on $\mathcal S_{jk}$ (O3), and derive L219_ops_gen from ops_orth (O4).
