# REVIEW r1776: L219Op.lean (abe5db2d)

| Claim | Verdict | Reason |
|---|---|---|
| `cS m` is the reflection $\sigma_{e_m}$ on $\Lambda^2$, with `cS_cS`, `cS_phi`, `cS_br`, `i2_cS` | CONFIRMED | $X\mapsto F^{\mathsf T}XF$ with $F=\mathrm{diag}(\pm1)$ symmetric and orthogonal is $\mathrm{Ad}_F$, a Lie algebra automorphism and an `inner2` isometry acting on $\varphi_{ij}$ by $\varepsilon_i\varepsilon_j$ |
| `sig m` is $R\mapsto\sigma R\sigma$, with `sig_sig`, `sig_comp`, `innerOp2_sig` | CONFIRMED | `cS m ∘ R ∘ cS m` is conjugation by the involution $\mathrm{Ad}_F=\mathrm{Ad}_F^{-1}$, the natural $O(n)$ action on operators of $\Lambda^2$ |
| `phiTri_sig` | CONFIRMED | each summand picks up $(\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l)^2=1$, checked by hand below |
| `Tsym_sig` | CONFIRMED | `cubicTri` is built from `comp`, `innerOp2` and `phiTri`, all three invariant |
| `L219_op` | CONFIRMED WITH OBSERVATIONS | sound and more general than the record (self-adjoint $W$ in place of Weyl), with $b,c\in\mathcal W_n$ left untyped |
| `#print axioms` on `L219_op`, `Tsym_sig`, `phiTri_sig` | CONFIRMED | `propext`, `Classical.choice`, `Quot.sound` on each |
| INDEX row "L219 (statement)" | CONFIRMED WITH OBSERVATIONS | the new sentence describes the code, while the row's Owed clause still lists the reflection's action and omits the untyped parts |

**Summary.** The reflection's action is the right one and every invariance holds, so `L219_op` proves the record's four scalar identities at a coordinate reflection for every self-adjoint critical $W$, with four observations on what stays with the record and one on the INDEX row, none of which changes a verdict.

**Standing rule.** Analysis only. The one computation run is `lake env lean` on a five-line check file for `#print axioms` and `#check`, seconds of work. No numerical screen was run.

## 1. Is `sig m` the reflection's action, and is `Tsym` invariance the right invariance?

- `Results.flip m` is `diagonal (if i = m then -1 else 1)`, the matrix of $\sigma_{e_m}$, the reflection in $e_m^\perp$. It is symmetric (`flip_T`) and squares to $1$ (`flip_sq`).
- $O(n)$ acts on $\Lambda^2\cong\mathfrak{so}(n)$ by $X\mapsto gXg^{\mathsf T}$. For $g=F$ this is $FXF=F^{\mathsf T}XF$, which is `cS m`. `cS_phi` through `rot_flip` gives $\varphi_{ij}\mapsto\varepsilon_i\varepsilon_j\varphi_{ij}$, the expected action on $e_i\wedge e_j$ (for $n=2$, $m=0$ it reverses the one plane's orientation).
- The induced action on operators is $R\mapsto\mathrm{Ad}_F\circ R\circ\mathrm{Ad}_F^{-1}$, and since $\mathrm{Ad}_F$ is an involution this is `cS m ∘ R ∘ cS m`, which is `sig m`.
- The record's proof uses two facts: $\sigma$ is an isometric algebra automorphism, $\sigma(x\circ y)=\sigma x\circ\sigma y$ and $\langle\sigma x,\sigma y\rangle=\langle x,y\rangle$. Together they give $\langle\sigma x\circ\sigma y,\sigma z\rangle=\langle x\circ y,z\rangle$, which is exactly `hσ` in [L219Statement.lean](../lean/HamiltonsCubic/Results/L219Statement.lean). `Tsym_sig` proves that trilinear invariance directly, and `innerOp2_sig` supplies the isometry used for `horth`. The file never states the product-level automorphism $\sigma(x\circ y)=\sigma x\circ\sigma y$, and the scalar identities do not need it (observation O2 concerns the operator identities that would).
- `Tsym_sig` holds on all of `CurvOp2`, with no self-adjointness or Weyl hypothesis. That is correct: `comp`, `innerOp2` and `phiTri` are each equivariant under conjugation by the automorphism $\mathrm{Ad}_F$ with no condition on the operators.

## 2. Is `phiTri_sig` sound?

- `phiTri A B C` $=-\tfrac14\sum_{ijkl}\langle B[A\varphi_{ij},C\varphi_{kl}],[\varphi_{ij},\varphi_{kl}]\rangle$. Write $s=\varepsilon_i\varepsilon_j$, $t=\varepsilon_k\varepsilon_l$ and $\sigma$ for `cS m`.
- $(\mathrm{sig}\,A)\varphi_{ij}=\sigma A\sigma\varphi_{ij}=s\,\sigma A\varphi_{ij}$, and likewise $t\,\sigma C\varphi_{kl}$.
- Their bracket is $st\,\sigma[A\varphi_{ij},C\varphi_{kl}]$ by `cS_br`. Applying $\mathrm{sig}\,B$ gives $st\,\sigma B[A\varphi_{ij},C\varphi_{kl}]$ by `cS_cS`.
- Pairing with $[\varphi_{ij},\varphi_{kl}]$ and moving $\sigma$ across by `i2_cS` gives $st\,\langle B[\cdot,\cdot],\sigma[\varphi_{ij},\varphi_{kl}]\rangle=st\,\langle B[\cdot,\cdot],[\sigma\varphi_{ij},\sigma\varphi_{kl}]\rangle=(st)^2\langle B[\cdot,\cdot],[\varphi_{ij},\varphi_{kl}]\rangle$.
- $s^2=t^2=1$ (`sgn_sq`), so each term is fixed. The Lean's closing `key` lemma, $a(b(a(bx)))=x$ from $a^2=b^2=1$, is this bookkeeping with the four signs in the order the rewrites produce them. The kernel accepted it, and the hand count agrees.

## 3. Is $T(b,c,c)$ the record's $\langle L_bc,c\rangle$?

- `cubicTri X Y Z` $=\langle X\circ_{\mathrm{comp}}Y,Z\rangle-\tfrac12\Phi(X;Y,Z)$ and `Tsym` is its average over the six orderings. `Tsym_diag` gives $T(R,R,R)=P(R)$ and `Tsym_lin` with `Pcubic2Lin_selfAdjoint` gives $T(W,W,x)=\langle Q(W),x\rangle$ at self-adjoint $W$.
- The record's form $\langle x\circ y,z\rangle$ on $\mathcal W_n$ is trilinear, totally symmetric (the record's proof, step 1) and has diagonal $\langle x\circ x,x\rangle=P(x)$. A symmetric trilinear form is fixed by its diagonal through polarisation, so on $\mathcal W_n$ it equals `Tsym`. Hence $T(b,c,c)=\langle b\circ c,c\rangle=\langle L_bc,c\rangle$ with no rescaling, whenever $b,c\in\mathcal W_n$.
- The normalisation is consistent: $T(W,W,x)=\theta\langle W,x\rangle$ is the record's $Q(W)=\theta W$ paired with $x$, since $W\circ W=Q(W)$. [REVIEW_r1775](REVIEW_r1775.md) confirmed the same identification through `foxProd2` for `Tsym_eq_Le`.
- Off $\mathcal W_n$, `Tsym` is the symmetrisation of a form that need not be symmetric, and the record's $\circ$ is undefined there, so the identification is claimed only on $\mathcal W_n$. The file's docstring says "whose $T(b,c,c)$ is $\langle L_bc,c\rangle$" without that qualifier (folded into O1).

## 4. Does `L219_op` use Weyl?

- It does not. The hypotheses are `IsSelfAdjoint2 W` and `Qop2 W = θ • W`, used only through `Tsym_crit`. `horth` comes from `innerOp2_sig`, and `hb`, `hc` from `sig_sig`.
- This is a STRENGTHENING, not a gap. Every Weyl $W$ is self-adjoint (`IsWeyl2.isSelfAdjoint2`, used in [L214Op.lean](../lean/HamiltonsCubic/Results/L214Op.lean)), and `Qop2` is the record's unprojected $Q$, which maps $\mathcal W_n$ to itself (the record's Gate 1 cites [L209](../findings/curvature-invariants.md) for this). So the record's hypothesis $Q(W)=\theta W$ on $\mathcal W_n$ is exactly `hQ` at a Weyl $W$.
- **O1.** The file does not prove that `sig m` preserves `IsWeyl2`, so it does not type $b,c\in\mathcal W_n$. The four identities hold as stated regardless, but reading $T(b,c,c)$ as $\langle L_bc,c\rangle$ and the split as a split *of $\mathcal W_n$* rests on that preservation, which is the record's "$O(n)$ acts on $\mathcal W_n$". The INDEX sentence "On $\mathcal W_n$ at a coordinate reflection" is true by specialisation, but the membership of the parts is untyped and unlisted.

## 5. The coordinate restriction and what stays untyped

- The record's $\sigma_u$ is at any unit $u$, and the Lean has $u=e_m$ only. The file's header and the INDEX row both say a general $u$ needs `CurvOp2` carried through a frame rotation, and that this is not done. That is recorded accurately. The mathematics of the extension is routine ($\sigma_u=g\sigma_{e_m}g^{\mathsf T}$ for $g\in O(n)$, with `Tsym` equivariant under $\mathrm{Ad}_g$), but no `Tsym` equivariance under a general $g$ is in this file, so the restriction is real.
- Untyped parts of the record's Statement, as instantiated on `CurvOp2`:
  - **$\langle b\circ b,c\rangle=0$ (O2).** The abstract `even_even_odd_zero` proves $T(b,b,c)=0$, but `L219_op` does not export it. It is one extra conjunct from the same hypotheses.
  - **The operator identities $b\circ b+c\circ c=\theta b$ and $2\,b\circ c=\theta c$ (O2).** Only their pairings with $b$ and $c$ are typed. Neither the INDEX row nor the file's header names them as left out.
  - **The diagonality corollary.** Untyped, and the INDEX row's Owed list names it. A working-tree file `lean/HamiltonsCubic/Results/L219Diag.lean` from another session is in progress, outside this commit, and not reviewed here.
  - **$\lVert c_u\rVert^2\le\tfrac34$.** Only the arithmetic `odd_mass_le` is typed, with the plane cubic $\tfrac\theta2(3\alpha-\alpha^3)$ and global maximality entering as `hmax`. `L219_op` supplies the two relations that give the plane cubic, but nothing composes them into `hmax`. The INDEX row says the plane cubic enters as a hypothesis, which is accurate.

## 6. Axioms

`lake env lean` on a check file (after waiting for another session's `lake env` to exit):

```
'HamiltonsCubic.L219Op.L219_op' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219Op.Tsym_sig' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219Op.phiTri_sig' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The olean was newer than the source (mtime 1790565439 against 1790565311), and the file contains no `sorry`, `native_decide` or `axiom`. `#check @L219_op` printed the statement quoted in the file, with `sig m` applied as a `LinearMap`.

## 7. The INDEX row

- The new sentence matches the code: `cS` and its four properties, `sig` and its invariances, `L219_op`'s four identities through the abstract theorems on `RecCurv`, standard axioms, and the frame-rotation caveat.
- **O3.** The trailing **Owed** clause still reads "$\mathcal W_n$, the reflection's action, and the diagonality corollary". The reflection's action is now supplied at coordinate directions, so the clause contradicts the sentence added before it. It should read, in effect: the reflection's action at a non-coordinate $u$, $b,c\in\mathcal W_n$ (sig preserving Weyl), the operator identities $b\circ b+c\circ c=\theta b$, $2b\circ c=\theta c$, and the diagonality corollary.
- **O4.** The row ends in two copies of "statement: typed" (one italic at the head, one bold at the tail), and "(statement)" rows carry **proved** in the status column while the Owed list is non-empty. Both predate this commit and are cosmetic.

## 8. Falsifiers

| Statement | Falsifying object | What was done |
|---|---|---|
| `cS m` is the reflection's action | a pair $i,j$ with `cS m φ_ij` $\ne\varepsilon_i\varepsilon_j\varphi_{ij}$, or $\mathrm{Ad}_F$ failing to be $X\mapsto FXF^{\mathsf T}$ | derived $F^{\mathsf T}\varphi_{ij}F$ entrywise from the definitions of `flip` and `phi`, and checked the $n=2$ case by hand |
| `phiTri_sig`, `Tsym_sig` | a quadruple $(i,j,k,l)$ whose summand changes sign | the sign count in section 2, $(st)^2=1$ for every quadruple, then the kernel check |
| `L219_op` models the record | a Weyl critical $W$ for which the record's $Q(W)=\theta W$ is not `Qop2 W = θ • W`, or $\langle x\circ y,z\rangle\ne$ `Tsym` on $\mathcal W_n$ | compared `Qop2` (unprojected) with the record's $Q$ on $\mathcal W_n$ through L209, and `Tsym` with $\langle x\circ y,z\rangle$ by polarisation from `Tsym_diag` |
| `L219_op` itself | a self-adjoint $W$, $\theta$ and $m$ violating one identity | none exists given the kernel check, whose proof depends only on `Tsym_12`, `Tsym_23`, `Tsym_sig`, `Tsym_crit` and `innerOp2_sig` |
| INDEX row | a clause the code does not support | read the row against every declaration, which found O3 |

No numerical screen was run, since every claim reduced to a hand derivation or a kernel check.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** O1: $b,c\in\mathcal W_n$ is untyped, as `sig` is not shown to preserve Weyl. O2: $\langle b\circ b,c\rangle=0$ is not exported and the two operator identities are untyped and unlisted. O3: the INDEX row's Owed clause is stale. O4: cosmetic duplication in the row, predating the commit.
