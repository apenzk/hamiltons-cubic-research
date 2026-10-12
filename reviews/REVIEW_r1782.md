# Review r1782: L245Op.lean (aaffcb2c, a4b36c77)

| Claim | Verdict | Reason |
|---|---|---|
| `inner_xk` | CONFIRMED | $\tfrac12\sum_{pq}(\delta_{pk}x_q-x_p\delta_{qk})(\delta_{pj}y_q-y_p\delta_{qj})=\delta_{kj}(x\cdot y)-y_kx_j$ by hand, and the proof's `hterm` is `inner2_phi_phi` with the indices mapped correctly |
| `wedgeS e u` is $e\wedge u$ | CONFIRMED | $\sum_ju_j(e_je^{\mathsf T}-ee_j^{\mathsf T})=ue^{\mathsf T}-eu^{\mathsf T}$, the layer's convention $a\wedge b\mapsto ba^{\mathsf T}-ab^{\mathsf T}$, of inner2-norm $\lvert e\rvert^2\lvert u\rvert^2-(e\cdot u)^2=1$ at unit $e\perp u$ |
| `isoW_rk1_star` | CONFIRMED | $\langle e\wedge e_k,e\wedge u\rangle=u_k-e_k(e\cdot u)=u_k$, so the weight is $\sum_ku_k^2=1$, which is the record's $\langle(e\wedge u)(e\wedge u)^{\mathsf T}e,e\rangle=\lvert u\rvert^2$ |
| `isoW_mono` | CONFIRMED | $P=Q+(P-Q)$, `isoW_add` and `isoW_nonneg` on the difference |
| `L245_star` | CONFIRMED | `hstar` gives $a_0(e)\ge d$ through `isoW_mono`, `isoW_sum` and `isoW_rk1_star`, and `star_h0` turns that into $(\lambda_2-\lambda_0)d\le(n-1)\lambda_2$, the record's $\dim U\le h_0$ multiplied out |
| `hstar` stands in for $E_0\supseteq e\wedge U$ | CONFIRMED | at orthonormal $u_i$ the $e\wedge u_i$ are inner2-orthonormal, so $\sum_i$`rk1` is the projector onto $e\wedge U\subseteq E_0$ and $P_0$ minus it is a projector, hence PSD |
| Star clause for $E_1$, $E_2$ | NOT TYPED | the record states the clause for every $E_c$, the Lean for $E_0$ only (O1) |
| `L245_ceilings` | CONFIRMED | four inequalities, $h_0$, $h_2$ and both halves of $h_1$, each scalar lemma fed the right nonnegativity and order hypotheses |
| `isoW_rk1` | CONFIRMED | $\sum_k(\sum_a\psi_{ka}x_a)^2=\lvert\psi x\rvert^2=\lvert\psi^{\mathsf T}x\rvert^2=\langle\psi\psi^{\mathsf T}x,x\rangle$ at skew $\psi$, index order immaterial under the square |
| Axioms | CONFIRMED | `propext`, `Classical.choice`, `Quot.sound` for all six named theorems, olean newer than source |
| lean/INDEX.md L245 row | CONFIRMED WITH OBSERVATIONS | accurate on what is proved, with the $E_1$, $E_2$ star cases absent from the untyped list (O1) |

**Summary:** both commits prove what they say, at the record's normalisation, from hypotheses implied by the record's. One observation: the record's star clause covers every $E_c$ and the Lean covers $E_0$.

## 1. Is `wedgeS e u` the bivector $e\wedge u$, and is it unit?

- Source: `phi i j = single j i 1 - single i j 1` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)), so $\varphi_{ij}=e_je_i^{\mathsf T}-e_ie_j^{\mathsf T}$. The layer's convention is $a\wedge b\mapsto ba^{\mathsf T}-ab^{\mathsf T}$, with $\varphi_{ij}=e_i\wedge e_j$.
- `xk x k` $=\sum_ax_a\varphi_{ak}=e_kx^{\mathsf T}-xe_k^{\mathsf T}=x\wedge e_k$ in that convention.
- `wedgeS e u` $=\sum_ju_j\,(e\wedge e_j)=\sum_ju_j(e_je^{\mathsf T}-ee_j^{\mathsf T})=ue^{\mathsf T}-eu^{\mathsf T}=e\wedge u$. It is exactly $e\wedge u$, sign included.
- Norm: by `inner_xk`, $\langle e\wedge u,e\wedge u\rangle=\sum_{k,j}u_ku_j(\delta_{kj}\lvert e\rvert^2-e_ke_j)=\lvert e\rvert^2\lvert u\rvert^2-(e\cdot u)^2=1$ at unit $e\perp u$.
- It matters. `rk1 ψ` $=\langle\cdot,\psi\rangle\psi$ is the orthogonal projector onto $\mathbb R\psi$ only at unit $\psi$, and at a non-unit $\psi$ the weight would be $\lvert\psi\rvert^2$ times the projector's. `isoW_rk1_star` takes unit $e$, unit $u$ and $e\cdot u=0$ as hypotheses and uses all three: `hee` and `heu` in `hin`, `hu` in the final sum. So the value 1 is the projector's, as the record's $\dim U$ count needs.

## 2. Is `inner_xk` right?

- By hand, with inner2 $=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)=\tfrac12\sum_{pq}X_{pq}Y_{pq}$, $X=e_kx^{\mathsf T}-xe_k^{\mathsf T}$ and $Y=e_jy^{\mathsf T}-ye_j^{\mathsf T}$: the four products give $\delta_{kj}(x\cdot y)-x_jy_k-x_jy_k+\delta_{kj}(x\cdot y)$, and half of that is $\delta_{kj}(x\cdot y)-y_kx_j$. This matches the statement.
- Against `inner2_phi_phi` ([Families.lean](../lean/HamiltonsCubic/Base/Families.lean)): $\langle\varphi_{ij},\varphi_{kl}\rangle=[i=k\wedge j=l]-[j=k\wedge i=l]$. At $(i,j,k,l)=(a,k,b,j)$ this is $[a=b\wedge k=j]-[k=b\wedge a=j]$, which is the proof's `hterm`. Summing $x_ay_b$ against it gives $\delta_{kj}\sum_ax_ay_a-x_jy_k$.
- Check at $x=y$ unit, $k=j$: $1-x_k^2=\lvert x\wedge e_k\rvert^2$, as it should be.

## 3. Does `hstar` stand in for $E_0\supseteq e\wedge U$?

- Implied by the record's hypothesis. Take $u_1,\dots,u_d$ an orthonormal basis of $U\perp e$ and $P_0$ the orthogonal projector onto $E_0$. By `inner_xk`, $\langle e\wedge u_i,e\wedge u_j\rangle=(e\cdot e)(u_i\cdot u_j)-(e\cdot u_j)(u_i\cdot e)=\delta_{ij}$, so $Q=\sum_i$`rk1 (wedgeS e (u i))` is the orthogonal projector onto $e\wedge U$. Since $e\wedge U\subseteq E_0$, $P_0-Q$ is the projector onto $E_0\ominus e\wedge U$, which is PSD.
- The Lean does not need orthonormality. It asks only unit $u_i\perp e$ and `hstar`, and proves the conclusion from them, so the orthonormal case is one instance. A non-orthonormal family makes `hstar` harder to satisfy: under the file's hypotheses $P_0\preceq I$ (since $P_1,P_2\succeq0$ and $\sum P_c=I$), so `hstar` forces $\sum_i$`rk1`$(e\wedge u_i)\preceq I$. A repeated $u_i$ fails it at $\psi=e\wedge u_i$, where the left side is 2 and $P_0$ gives at most 1. The generality therefore costs nothing and admits no vacuous $d$.
- `L245_star` also asks only PSD of each $P_c$, not idempotence. This is weaker than the record's projector hypothesis, as in `L245_op` (r1781).

## 4. Is `L245_star` the record's $\dim U\le h_0$, and are the $E_1$, $E_2$ cases stated?

- With `hl02 : lam 0 < lam 2`, $(\lambda_2-\lambda_0)d\le(n-1)\lambda_2$ is $d\le h_0=\frac{(n-1)\lambda_2}{\lambda_2-\lambda_0}$ multiplied out by a positive factor. The order hypotheses are weaker than the record's strict $\lambda_0<\lambda_1<\lambda_2$ (`hl12` non-strict, $\lambda_0\le\lambda_1$ unused).
- The chain at source: `isoW_mono hstar e` gives $\sum_i$`isoW (rk1 …) e`$\le$`isoW (P 0) e` after `isoW_sum`, each summand is 1 by `isoW_rk1_star`, so $d\le a_0(e)$. `star_h0` ([L245SymmetricIsotropy.lean](../lean/HamiltonsCubic/Results/L245SymmetricIsotropy.lean)) takes $a_0+a_1+a_2=n-1$, the Ricci identity, $a_1\ge0$, `hl02`, `hl12` and `hd`, all supplied from `L245_op` at $x=e$.
- **Observation O1.** The record's clause reads "if $E_c\supseteq e\wedge U$ … then $\dim U\le h_c$", for every $c$. The Lean states $c=0$ only. Neither the module docstring nor the INDEX row claims more (both say $E_0$), but the INDEX row's "The star clause, PROVED" heading reads as the whole clause and its "Not typed" list omits $c=1,2$.
  - $E_2$ is a relabelling: apply `L245_star` to $(P_2,P_1,P_0)$ with $(-\lambda_2,-\lambda_1,-\lambda_0)$ and $-W$, Weyl by `isWeyl2_smul` (used in [WeylMaximiser.lean](../lean/HamiltonsCubic/Results/WeylMaximiser.lean)). It gives $(\lambda_2-\lambda_0)d\le(n-1)(-\lambda_0)$, the record's $h_2$.
  - $E_1$ needs a scalar lemma pairing $d\le a_1$ with both halves of `ceiling_h1`, which `L245_ceilings` already supplies at the operator level. It is a few lines, and absent.
  - Either typing the two cases or naming them in the INDEX row's untyped list closes this. It is a coverage gap in the Lean, and everything it states is correct.

## 5. Is `isoW_rk1` the record's $\langle\psi\psi^{\mathsf T}x,x\rangle=\lvert\psi x\rvert^2$?

- At source, `hin` computes $\langle x\wedge e_k,\psi\rangle=\sum_a\psi_{ka}x_a=(\psi x)_k$. By hand: $\tfrac12\sum_{pq}(\delta_{pk}x_q-x_p\delta_{qk})\psi_{pq}=\tfrac12\bigl((\psi x)_k-(\psi^{\mathsf T}x)_k\bigr)=(\psi x)_k$ at skew $\psi$.
- Then `rk1_apply` gives $\langle\langle x\wedge e_k,\psi\rangle\psi,x\wedge e_k\rangle=\langle x\wedge e_k,\psi\rangle^2$, summed over $k$: $\lvert\psi x\rvert^2$.
- Index order: $\sum_a\psi_{ka}x_a$ is $(\psi x)_k$, the row-times-vector product, so the statement is literally $\lvert\psi x\rvert^2$. The record's $\langle\psi\psi^{\mathsf T}x,x\rangle=\lvert\psi^{\mathsf T}x\rvert^2=\lvert-\psi x\rvert^2$ equals it at skew $\psi$, and would equal it under the transposed index order too, since the vector changes only by a sign.
- The docstring's "at a sum over an orthonormal basis of $E_c$ it is $\langle A_cx,x\rangle$" follows by `isoW_sum`. It is not itself stated as a theorem, which is harmless.

## 6. Axioms

- `lake env lean` on a check file importing `HamiltonsCubic.Results.L245Op`, with the olean (mtime 1790567233) newer than the source (1790567169) at a4b36c77.
- `L245_star`, `L245_ceilings`, `isoW_rk1`, `isoW_rk1_star`, `inner_xk`, `isoW_mono`: each depends on `propext`, `Classical.choice`, `Quot.sound` only. No `sorryAx`, no `Lean.ofReduceBool`.

## 7. The L245 row in lean/INDEX.md

- Every named theorem exists with the stated content: `isoW_id`, `isoW_weyl`, `isoW_nonneg`, `L245_op`, `L245_ceilings` (both halves of $h_1$, r1781 O2 discharged), `isoW_rk1` (r1781 O1 discharged), `isoW_rk1_star`, `isoW_mono`, `L245_star`.
- "standard three axioms" matches section 6.
- The "Not typed" item, the existence of the eigenprojectors, is accurate and is what the hypotheses on $P_c$ state.
- The earlier commit's untyped item "h₁ at the operator level" was correctly removed by a4b36c77.
- O1 applies: the $E_1$ and $E_2$ star cases are neither typed nor listed as untyped.

## 8. Falsifiers and what was done to look for them

| Statement | Falsifying object | Search |
|---|---|---|
| `inner_xk` | vectors $x,y$ and indices $k,j$ with $\langle x\wedge e_k,y\wedge e_j\rangle\ne\delta_{kj}(x\cdot y)-y_kx_j$ | hand expansion from the matrix entries and from `inner2_phi_phi`, both agreeing |
| `wedgeS` as $e\wedge u$ | a pair where $\sum_ju_j(e\wedge e_j)\ne ue^{\mathsf T}-eu^{\mathsf T}$ | direct expansion of `phi` |
| `isoW_rk1_star` | unit $e\perp u$ with $\sum_k\langle e\wedge e_k,e\wedge u\rangle^2\ne1$ | hand computation, $\langle e\wedge e_k,e\wedge u\rangle=u_k$, and the record's matrix identity $(ue^{\mathsf T}-eu^{\mathsf T})(eu^{\mathsf T}-ue^{\mathsf T})e=e$ checked independently |
| `isoW_mono` | PSD $P-Q$ with `isoW Q x > isoW P x` | reduces to `isoW_nonneg`, reviewed in r1781 |
| `L245_star` | a Weyl $W$ with PSD resolution $P_c$ and a star $e\wedge U\subseteq E_0$ of dimension $d>h_0$ | the chain was traced at source. The record's sharp case $S^5\times S^7$ attains $d=h_0=7$, so the bound admits equality and cannot be tightened |
| `L245_ceilings` | a resolution with $a_1$ above either half of $h_1$ | checked that the record's $h_1$ is the minimum of the two halves exactly when the sign condition picks it: the halves compare as $\lambda_1(\lambda_2-\lambda_0)\ge0$, i.e. $\lambda_1\ge0$ selects $\frac{(n-1)\lvert\lambda_0\rvert}{\lambda_1-\lambda_0}$ |
| `isoW_rk1` | skew $\psi$ and $x$ with $\sum_k(\psi x)_k^2\ne\langle\psi\psi^{\mathsf T}x,x\rangle$ | hand derivation above |

- A seconds-long numerical screen of the conventions was written and did not run, since numpy is absent from the system Python. The verdicts rest on the hand derivations and the kernel-checked proofs, which is the programme's footing.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** Every theorem in aaffcb2c and a4b36c77 is correct and matches the record at its normalisation. O1: the star clause is typed for $E_0$ only, while the record states it for every $E_c$, and the INDEX row's untyped list should name the $E_1$ and $E_2$ cases or the file should type them ($E_2$ by relabelling with `isWeyl2_smul`).
