# REVIEW r1741: L214 at the operator (L214Op.lean), and L105Eq's repairs of r1740's O1 and O2

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every typed statement is faithful to Lemma L214 and to r1740's two requested repairs, and every proof is sound as read. The observations are one prose mislabel of a constant (in the file header and the INDEX row, never in a typed statement), one redundant hypothesis, and the global-maximiser clause being covered only through its $\theta>0$ case.

Read from the staged tree: [L214Op.lean](../lean/HamiltonsCubic/Results/L214Op.lean) (new), the staged diff of [L105Eq.lean](../lean/HamiltonsCubic/Results/L105Eq.lean) and [lean/INDEX.md](../lean/INDEX.md), `cubicTri` and its three identifications in [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean), `Pcubic2Lin_selfAdjoint` in [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean), `Pcubic2Quad_selfAdjoint`, `isWeyl2_add`, `isWeyl2_smul` and `L24_weyl` in [L24Weyl.lean](../lean/HamiltonsCubic/Results/L24Weyl.lean), `IsWeyl2`, `normSq2`, `normSq2_eq_zero` and `Qop2` in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), Lemma L214 in [second-order.md](../findings/second-order.md), and [REVIEW_r1740.md](REVIEW_r1740.md). No `lake build` was run. `L214Op.olean` is dated 00:47:54 against its source at 00:47:34, and `L105Eq.olean` 00:48:39 against 00:46:54, so both files as read compiled in the other session's build. Neither file contains `sorry`, `axiom` or `native_decide`. The axiom audit (standard three) is the author's and was not re-run here. Analysis-only footing: every check below is by hand.

## (1) Is `Tsym` the record's polarisation $T(x,y,z)=\langle x\circ y,z\rangle$?

- **`cubicTri X Y Z` is $\langle XY,Z\rangle-\tfrac12\Phi(X;Y,Z)$**, an unsymmetrised trilinear form whose diagonal is $P$ (`Pcubic2_eq_cubicTri`). It is not itself symmetric, which is why the symmetrisation is needed.
- **`Tsym` averages all six permutations** of $(X,Y,Z)$: $(XYZ),(YXZ),(XZY),(ZYX),(YZX),(ZXY)$, each once. So it is totally symmetric, and `Tsym_12`, `Tsym_23` close by `ring`.
- **`Tsym_diag`, `Tsym_lin`, `Tsym_quad` are correct by counting.** With two $R$ and one $H$, the six permutations give each of the three arrangements twice, so $3\,T(R,R,H)=\tfrac12\cdot2\cdot(\text{sum of three})$, which is `Pcubic2Lin_eq_cubicTri`. Likewise for two $H$.
- **Agreement with the record, derived.** For self-adjoint $X$, `Tsym_lin` and `Pcubic2Lin_selfAdjoint` give $T(X,X,Z)=\langle Q(X),Z\rangle$ for every $Z$. Polarising over the self-adjoint subspace, $2T(X,Y,Z)=\langle Q(X+Y)-Q(X)-Q(Y),Z\rangle=2\langle X\circ Y,Z\rangle$. So $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ whenever $X,Y$ are self-adjoint and $Z$ is arbitrary, with no total-symmetry assumption on the record's side.
- **Hence $a=\langle D\circ N,N\rangle=$ `Tsym D N N` for self-adjoint $D,N$**, in particular for Weyl $D,N$. The record's arrangement and the typed one agree. Equivalently `Pcubic2Quad_selfAdjoint` gives `Tsym D N N` $=\langle D,Q(N)\rangle=\langle N\circ N,D\rangle$, which is exactly the form step 1 of the record uses.
- Falsifier: self-adjoint $X,Y$ and any $Z$ with $T(X,Y,Z)\ne\langle X\circ Y,Z\rangle$.

## (2) `Tsym_crit`

- **Hypothesis faithful.** `Qop2 W = θ • W` with $Q=R^2+R^\#$ is the record's $W\circ W=\theta W$, and it is the same hypothesis `L24_weyl` takes, so the layer is consistent.
- **The conclusion for every $x\in$ `CurvOp2` is sound.** `Pcubic2Lin_selfAdjoint` needs self-adjointness of $W$ only and holds for arbitrary $H$, so $3T(W,W,x)=3\langle x,\theta W\rangle$ at every $x$. The record's paired form is weaker (it pairs with $D$ and $N$ only), so the typed statement is at least as strong.
- Falsifier: self-adjoint $W$ with $Q(W)=\theta W$ and some $x$ with $T(W,W,x)\ne\theta\langle W,x\rangle$.

## (3) `Tsym_cap`

- **Faithful reading of "$L_W\le\theta/2$ on $W^\perp$"** restricted to Weyl directions, which is the record's ambient space $\mathcal W_n$. By (1), $T(W,X,X)=\langle W\circ X,X\rangle=\langle L_WX,X\rangle$ for Weyl $W,X$.
- **The local-maximum set** $\{\lVert R\rVert^2=1\wedge\text{Weyl}\}$ is the unit sphere of $\mathcal W_n$, and `hθ : 0 < θ` with the derived `hPW : P(W) = θ` (from `Tsym_diag`, `Tsym_crit` and unit norm) feeds `L24_weyl`'s `0 < Pcubic2 a`. That matches "a local one with $\theta>0$".
- **Normalisation sound.** For $\lVert X\rVert^2>0$, $v=X/r$ with $r=\sqrt{\lVert X\rVert^2}$ is Weyl, orthogonal to $W$ and unit, `L24_weyl` gives $\langle W,Q(v)\rangle\le\theta/2$, and $T(W,X,X)=r^2T(W,v,v)$ by the two `smul` lemmas, so the bound scales to $\tfrac\theta2\lVert X\rVert^2$.
- **$X=0$ sound.** `normSq2_eq_zero` forces $X=0$, and $T(W,0,0)=0\le\tfrac\theta2\cdot0$.
- **O1 (scope).** The record also asserts the cap at every GLOBAL maximiser without the $\theta>0$ proviso. The typed statement covers a global maximiser only when $\theta>0$. This is harmless at $n\ge4$, where $P$ is odd and not identically zero on $\mathcal W_n$, so a global maximum has $\theta>0$, but that step is prose.
- Falsifier: a unit Weyl local maximiser on the Weyl sphere with $\theta>0$ and a Weyl $X\perp W$ with $T(W,X,X)>\tfrac\theta2\lVert X\rVert^2$.

## (4) `L214_op`, `L214_op_max`, and the Weyl hypotheses on $D,N$

- **$D$ Weyl is faithful.** In the record $D=\pi_FW$ carries only pair-diagonal entries $R_{ijij}$. It is self-adjoint, satisfies first Bianchi (every Bianchi sum on pair-diagonal entries is $R_{ijij}-R_{ijij}+0$ or zero), and the record cites [L123](../findings/second-order.md) for Ricci-flatness, which is a condition on frame-diagonal entries alone. So $D\in\mathcal W_n$ in the record, and taking `IsWeyl2 D` as a hypothesis is an honest transcription of a fact the record argues.
- **O2 (redundancy).** `hNW : IsWeyl2 N` follows from `hWW`, `hDW` and `hsplit` by `isWeyl2_add` and `isWeyl2_smul (-1)`. It is harmless, and could be derived.
- **The frame input is honestly a hypothesis.** `hperp : Tsym D D N = 0` appears in both signatures, the header says it "enters as a hypothesis", and the INDEX row says it "stays a hypothesis". `⟨D,N⟩ = 0`, `‖D‖² = t` and `‖N‖² = 1-t` are likewise hypotheses and all hold for an orthogonal projection of a unit $W$.
- **`L214_op` takes only $W$ self-adjoint**, with $D,N$ arbitrary. Its relations are true in that generality (they are `rel_one`, `rel_two` on a symmetric form), and `Tsym D N N` is the record's $a$ whenever $D,N$ are self-adjoint, which is the record's setting.
- **`L214_op_max` is the record's inequality.** The test vector $X=tN-(1-t)D$ is Weyl by closure, orthogonal to $W$ and of norm $t(1-t)$ by `test_perp`, `test_norm`, and `Tsym_cap` supplies the cap that `maximiser_ineq` consumes. The conclusion $\tfrac\theta2t(1-t)\le a$ is the record's.
- Falsifiers: for `L214_op`, a self-adjoint critical $W=D+N$ meeting the four hypotheses where either relation fails. For `L214_op_max`, a unit Weyl local maximiser with $\theta>0$ and a Weyl split with $T(D,D,N)=0$ where $a<\tfrac\theta2t(1-t)$.

## (5) `L105_mult_conv` and `L105_op_odd_min` against r1740's O1 and O2

- **`L105_mult_conv` closes O1.** The certificate checks by expansion: $4(ru-sw)-u(4r-n(n-2))+4w(r+s-\tfrac{n(n-1)}2)-w(4r-n(n-2))=n(n-2)u-n^2w=n((n-2)u-nw)$. With $n\ne0$ it gives $(n-2)u=nw$, and `L105_eq_iff` ← then gives both branches $\ge\theta_0$, which with `L105_closing` is equality. The composite "$4r=n(n-2)\Rightarrow\min=\theta_0$" is two typed steps rather than one declaration, which suffices.
- **`L105_op_odd_min` closes O2.** It states $\neg(\theta_0\le(n-1)w\wedge\theta_0w\le Q)$, which for $w>0$ is $\min\{(n-1)w,Q/w\}<\theta_0$, the strict second inequality. The proof chains `L105_eq_iff` →, `mult_rel`, `L105_mult`, `L105_odd` exactly as r1740 named. It drops criticality, which it does not need, so it is stronger than asked.
- Falsifiers: reals with $ru=sw$, $r+s=N$, $4r=n(n-2)$, $n\ge3$ and $(n-2)u\ne nw$. At the operator, a unit linear Weyl operator at odd $n$ with two eigenvalues $u>0>-w$ and both branch inequalities at $\theta_0(n)$.

## (6) The INDEX rows

- **The L105 row claims only what is typed**, and now carries r1740's disposition ("the converse and the min form added").
- **O3 (prose constant, the one wording repair owed).** The L214 row says "$3\,T(R,H,H)=P''(R)(H,H)$" and the file header says "`Tsym R H H = ⅓ P''(R)(H, H)`". `Pcubic2Quad` is the quadratic part of the increment, which is $\tfrac12P''(R)(H,H)$, so the correct gloss is $3T(R,H,H)=\tfrac12P''(R)(H,H)$, equivalently $T(R,H,H)=\tfrac16P''(R)(H,H)$. The typed `Tsym_quad` (`3 * Tsym R H H = Pcubic2Quad R H`) and its docstring ("a third of the quadratic part") are correct. Only the two prose glosses are off by a factor of two. The linear gloss $3T(R,R,H)=P'(R)H$ is right.
- Otherwise the L214 row states what the file types: criticality and the cap proved at the operator, $D,N$ Weyl and $T(D,D,N)=0$ as hypotheses, L120 untyped.

## Summary

| Item | Verdict |
|---|---|
| `Tsym` as the record's polarisation | faithful on self-adjoint $X,Y$, derived in (1) |
| `Tsym_crit` | faithful, every-$x$ conclusion sound |
| `Tsym_cap` | faithful for local max with $\theta>0$ (O1: global case via $\theta>0$ only) |
| `L214_op`, `L214_op_max` | faithful, frame scalar honest hypothesis (O2: `hNW` redundant) |
| `L105_mult_conv`, `L105_op_odd_min` | close r1740 O1 and O2 |
| INDEX rows | faithful except O3, the $P''$ gloss off by a factor two |
