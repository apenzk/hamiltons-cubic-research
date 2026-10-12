# Gate 2 review 191, the Sym^3 metric, the coordinate solve, and the cube map

| Claim | Verdict |
|---|---|
| 1. The Sym^3 metric | **Shape correct, name wrong.** The bijection sum is an invariant form on $\mathrm{Sym}^3 V$, a discriminating test now exists and it passes exhaustively, while three competing conventions fail with witnesses. Its normalisation is Fischer, $\langle x^\alpha,x^\alpha\rangle_{H=I}=\alpha!$, which is $3!$ times the metric *induced* from $H$; the docstring's word "induced" names the other one |
| 2. The coordinate solve | **Correct, and correct as a pair.** Conjugating the basis tensor forces $H^{T}$, and the code does both. Exact round-trip error $0$; each single swap breaks it, and the mixed swap agrees with the code on all $27$ coordinates whose $H$ row is real, the invisibility the brief warned about, now with a witness |
| 3. The cube map | **Correct and consistent with 1 and 2.** One identity ties all three, and it holds with a constant $\kappa=6$; breaking any one of the three destroys constancy |
| 4. The shared word list | **Spanning is sufficient**, by equivariance, and the argument is one line. The scale of each cached $u_i$ is arbitrary, so $G$ is defined only up to a diagonal congruence, harmless for positivity |
| 5. The Hermitian Gram | **Confirmed independently.** $45$ of $1225$, none across distinct weights, diagonal in $\{12,24,36,48,64,96\}$, but [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py)'s own version of this check *cannot fail* |
|, | **Two findings the brief did not ask for**, below: [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) runs none of the code under review, and the `IP_CONVENTION` block added to it mid-cycle is mislabelled in a way that would break the file if anyone "fixed" the label |

Scripts: [scripts/reviewers/r191/](../scripts/reviewers/r191/). Everything is exact over $\mathbb{Q}(i)$; no floats appear anywhere.

## 0. The setting, restated so the conventions have somewhere to live

$V=\mathcal W_5$ is the $35$-dimensional Weyl module of $\mathfrak{so}(5)$, realised as rank-4 tensors, and $H_{ab}=\langle f_a,f_b\rangle=\sum_{ijkl}(f_a)_{ijkl}\overline{(f_b)_{ijkl}}$, conjugate on the **second** slot. Since the real form acts by real orthogonal matrices in each slot, the ambient form is $O(5)$-invariant, so $H$ is an invariant Hermitian metric on $V$; $V$ is irreducible, so $H$ is the only one up to scale.

Write $G=H^{T}$, so that $\langle u,v\rangle=v^{\dagger}Gu$. This is the matrix [coords](../scripts/runs/run_n5_evaluate.py) inverts, and the distinction between $w$ (the solved coordinates, contravariant) and $r=Gw=\langle W,f_b\rangle$ (the raw contraction, covariant) turns out to matter in §5.

I derived the lowering operators rather than assuming them: adjointness forces $\hat F=(G\hat E G^{-1})^{\dagger}$, computable exactly from the cache alone. [lowering.py](../scripts/reviewers/r191/lowering.py) then subjects the result to three checks that could each have failed, and all three pass:

- $F_k$ lowers every weight by exactly $\alpha_k$;
- $[E_k,F_k]$ acts as a **scalar** on every weight block, with no cross-block entries;
- that scalar is **linear in the weight**, $[E_1,F_1]|_\mu=4(\mu_1-\mu_2)$ and $[E_2,F_2]|_\mu=2\mu_2$, each proportional to its own coroot.

A wrong $H$, a wrong root vector or a wrong transpose convention breaks the second or third of these. Passing them is what licenses using $F$ as a probe in §1.

## 1. Claim 1, the test that discriminates

Reviewers 189 and 190 are right that a weight check is powerless here, and the reason is worth stating positively. Every candidate convention is $M'(t,s)=d_t\,\overline{d_s}\,M(t,s)$ with $d_t$ depending only on the repetition pattern of the monomial $t$. Such a rescaling is diagonal inside each weight space, so it commutes with the Cartan and every torus-covariance test sees through it. The weight-$(0,0)$ space alone holds $234$ monomials in three patterns ($209$ with distinct indices, $22$ of type $x^2y$, $3$ of type $x^3$) and a weight check compares none of them against each other.

**What a pattern-diagonal rescaling does not commute with is a root vector.** The induced metric is characterised, up to one global scalar, by the compact form acting anti-Hermitianly:

$$\langle E\,u,\;v\rangle_M \;=\; \langle u,\;F\,v\rangle_M ,\qquad F=E^{\dagger}\text{ on }V .$$

$E$ and $F$ move between weight spaces, so this identity couples the normalisation of one weight space to the next, exactly the coupling a diagonal rescaling breaks. [claim1_metric.py](../scripts/reviewers/r191/claim1_metric.py) runs it on both simple roots:

| candidate | $\langle Eu,v\rangle=\langle u,Fv\rangle$ |
|---|---|
| bijection sum (the code), Fischer, $\langle x^\alpha,x^\alpha\rangle_{H=I}=\alpha!$ | **PASS**, 120/120 sampled pairs |
| bijection sum $/3!$, Bombieri, the induced metric | **PASS**, 120/120 |
| identity bijection only, no sum | **FAIL**, $t=(1,1,1)$, $s=(1,1,5)$: $-1572864$ against $-524288$ |
| $\mathrm{multinom}(t)\,\mathrm{multinom}(s)\cdot$ bijection sum | **FAIL**, same witness, $-28311552$ against $-3145728$ |
| bijection sum $/(\mathrm{multinom}(t)\,\mathrm{multinom}(s))$ | **FAIL**, same witness, $-1048576/3$ against $-3145728$ |

[claim1_exhaustive.py](../scripts/reviewers/r191/claim1_exhaustive.py) removes the sampling: over the adjacent pair of weight spaces $(-5,0)\to(-4,-1)$, all $18\times46=828$ pairs are tested, and the passes are $828/828$ while the failures are $10$ and $13$ pairs out of $828$. The failures are *sparse*, which is precisely why they have survived: a spot check has roughly a one-in-sixty chance of landing on one.

**So the bijection sum is right in shape.** It is wrong in name. The value it returns at $H=I$ is $\langle x^\alpha,x^\alpha\rangle=\alpha!$, the Fischer–Bargmann normalisation, and the metric *induced* from $H$ through the standard embedding $x_ax_bx_c\mapsto\frac1{3!}\sum_\sigma f_{a}\otimes f_{b}\otimes f_{c}$ is $\alpha!/3!$, the Bombieri one. The docstring says "induced". The gap is a uniform factor $3!$, not a per-monomial one, so it is absorbed into the unknown $G_{ij}$ and cannot damage the certificate. It is observable in exactly one place, and that place is the falsifier the file names for itself, see §4.

## 2. Claim 2, the conjugation and the transpose are locked to each other

The derivation is short. $H$ conjugates its second slot, so $\langle W,f_b\rangle=\sum_a w_a\langle f_a,f_b\rangle=\sum_a H_{ab}w_a=(H^{T}w)_b$, and `rhs[b]` is built as $\sum W\cdot\overline{f_b}$, which is that same $\langle W,f_b\rangle$. Conjugating the other slot would demand $H$ rather than $H^{T}$. **The two choices are not independent, and the code has the consistent pair.**

[claim2_coords.py](../scripts/reviewers/r191/claim2_coords.py) builds a real tensor inside the span ($272$ nonzero of $625$, all rational), runs the solve, and reconstructs $\sum_a w_a f_a$:

| pairing | exact $L^1$ reconstruction error |
|---|---|
| conjugate on $f_b$, matrix $H^{T}$, **the code** | $0$ |
| conjugate on $f_b$, matrix $H$ | $1184/3$ |
| conjugate on $W$, matrix $H^{T}$ | $2368/9$ |
| conjugate on $W$, matrix $H$, the other consistent pair | $0$ |

The brief's worry is real and now has a number attached. $27$ of the $35$ weight indices have an entirely real row of $H$, and on every one of them the mixed pairing returns the same coordinate as the code. It differs on the remaining $8$; the first is $a=6$, weight $(-1,-1)$, where the code gives $1/2$ and the mixed pairing gives $5/6+\tfrac53 i$. **A real-entry spot check has a $27/35$ chance of missing the swap on any single coordinate.**

## 3. Claim 3, one identity ties all three conventions together

$W^3$ as a polynomial is $\big(\sum_a w_a x_a\big)^3=\sum_t \mathrm{multinom}(t)\prod_{a\in t}w_a\cdot x_t$, which is what [cube](../scripts/runs/run_n5_evaluate.py) computes, and the monomial $x_t$ is the object [raise_mono](../scripts/runs/run_n5_highest_weight.py) differentiates. So the multinomial belongs there. That much is a one-line check. The question the brief actually asks (whether the three conventions *agree*), needs the apolarity identity. Under the embedding above, $W^3\mapsto W\otimes W\otimes W$ and $x_s\mapsto\frac1{3!}\mathrm{Sym}(s)$, so

$$\langle W^3,\,x_s\rangle_{\text{induced}}=\prod_{i=1}^{3}\langle W,f_{s_i}\rangle=\prod_i r_{s_i},\qquad r=H^{T}w .$$

Written through the code's own three routines this is $\sum_t \mathrm{cube}(w)[t]\cdot \mathrm{sym3\_ip}(t,s)=\kappa\prod_i (H^{T}w)[s_i]$, and $\kappa$ is a constant **only if all three conventions agree**. [claim3_apolarity.py](../scripts/reviewers/r191/claim3_apolarity.py) measures it over random $w$ and random test monomials:

| combination | $\kappa$ |
|---|---|
| cube $\times$ bijection sum $\times$ $H^{T}w$, **the code as written** | **constant $=6$** over 39 samples |
| cube $\times$ (bijection sum$/3!$) $\times$ $H^{T}w$ | **constant $=1$** over 40 samples |
| cube with the multinomial dropped | not constant, $4$ values, including $1$, $2$, $6$, $10598/9409+\tfrac{420}{9409}i$ |
| bijection sum replaced by the single identity bijection | not constant, $3$ values: $1$, $3$, $6$ |
| the solve without the transpose | not constant, $17$ values over 40 samples |
| the conjugate on the wrong side of the solve | not constant, $15$ values over 40 samples |

**This is the discriminating test the brief asked for, and it discriminates all three claims at once.** It rejects the multinomial-free cube, the sum-free metric and both broken solves, it accepts the code, and the residual $\kappa=6$ is the Fischer-versus-induced factor of §1 read off directly.

## 4. Where the factor $3!$ becomes visible, and a normalisation that is not yet fixed

$B_{ij}=\bar c^{\,i\,T}M_\lambda c^{j}$ is homogeneous of degree one in $M_\lambda$, so replacing the metric by $6M$ scales every $B$ by $6$ and $G$ by $1/6$. Positivity of $G$ is a congruence-invariant property, so **the certificate is untouched**. The file's *own* named falsifier is the exception: "on the trivial block, must reproduce $144^2\operatorname{tr}(W^3)^2$".

On the trivial block $\lambda=(0,0)$ the multiplicity is one, so $B_{11}=|\langle W^3,u\rangle_M|^2/\langle u,u\rangle_M$. [claim1_invariant_cubic.py](../scripts/reviewers/r191/claim1_invariant_cubic.py) evaluates every piece exactly:

- $\langle u,u\rangle$ is $4354560$ in the code's metric, $725760$ in the induced one;
- $\langle W^3,u\rangle_{\text{code}}=6\,P_1$ exactly, at every sample, the apolarity identity again;
- $B_{11}/|P_1|^2=1/120960=3!/725760$, the same rational at every sample.

So $B_{11}$ does **not** come out as $|P_1|^2=144^2\operatorname{tr}(W^3)^2$; it comes out as $3!\,|P_1|^2/\lVert u\rVert^2_{\text{induced}}$. The missing ingredient is not the metric but the **normalisation of $u$**: the cached highest-weight vectors are raw `nullspace_G` output, carrying whatever scale the echelon happened to produce. *The falsifier the docstring names cannot be run until the word basis is normalised, and once it is, the target value moves with that choice.* This belongs in [plan.md](../plan.md)'s table alongside the checks that could not fail, for a different reason: this one cannot be evaluated at all as stated.

## 5. A trap between the two routes: $w$ and $r$ are different vectors

[coords](../scripts/runs/run_n5_evaluate.py) produces two coordinate vectors, `rhs`, the raw contraction $r_b=\langle W,f_b\rangle$, and $w$, the solution of $H^{T}w=r$. Reviewer 189's formula $P_i(W)=\sum_t u[t]\,\omega_{t_1}\omega_{t_2}\omega_{t_3}$ uses $\omega$, and [claim2_convention.py](../scripts/reviewers/r190/claim2_convention.py)'s `omegas(W)` is the plain contraction $\sum_{ijkl}(f_a)_{ijkl}W_{ijkl}=\overline{r_a}$. It is **not** the output of `coords`. Passing from $w$ to $r$ is the metric identification $V\to V^{*}$, and the weight basis is far from orthonormal ($H$'s diagonal runs $12$ to $96$) so the two differ substantially.

Infinitesimal invariance settles which reading is the invariant cubic. A cubic is invariant iff its derivative along $X\!\cdot\!W$ vanishes for every $X$, and in coordinates $(X\!\cdot\!w)_t=\sum_a w_a X[a][t]$:

| coefficients | evaluated at | $\mathfrak{so}(5)$-invariant |
|---|---|---|
| $u$ | $w=\mathrm{coords}(W)$ | **no**, along $E_1$: $-92291/128+\tfrac{3860501}{6912}i$ |
| $u$ | $r=H^{T}w$ | **no** |
| $\bar u$ | $w=\mathrm{coords}(W)$ | **no** |
| $\bar u$ | $r=H^{T}w$ | **yes**, along all four of $E_1,E_2,F_1,F_2$ |

Only the last is invariant, and it is $\overline{P_1}$ in reviewer 190's convention, so 189 and 190 are consistent with each other and with the code. **What is not safe is the natural-looking step of feeding `coords`'s $w$ into 189's formula**: the ratio of the two cubics takes four distinct values over four samples. The evaluation route avoids this because its pairing reintroduces $H$; anyone reading the two routes side by side will not automatically avoid it.

## 6. Claim 4, spanning is sufficient, and the reason is equivariance

Let $\varphi:\;V_\lambda^{(i)}\to V_\lambda^{(j)}$ be the $G$-map with $\varphi(u_i)=u_j$; reviewer 182 is right that it is unique. A word is a fixed string $F_{k_1}\cdots F_{k_m}$ of lowering operators, and $\varphi$ intertwines, so $\varphi(F_{k_1}\cdots F_{k_m}u_i)=F_{k_1}\cdots F_{k_m}u_j$. **Replaying the same strings therefore realises $\varphi$ on the nose, for any list whatever**, comparability is automatic, and spanning is needed only so that the replayed list is a *basis* and the coordinates $c^{j}$ exist. That is exactly the check [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) runs, and the failure mode its docstring describes (a list re-selected per copy), is the case where the strings differ and the argument above no longer applies.

Two remarks that the spanning check does not cover:

- The lowering operators there are `root_vector(-1,1)` and `root_vector(0,-1)`, not the metric adjoints $E^{\dagger}$. In $B_2$ each root space is one-dimensional, so they are proportional, and the proportionality constant multiplies every word of a given length identically across all copies. $M_\lambda$ and the $c^{j}$ absorb it consistently, so **this is harmless**, but it is harmless by an argument, not by inspection.
- Rescaling $u_i\mapsto\lambda_i u_i$ rescales $B_{ij}\mapsto\lambda_i\overline{\lambda_j}B_{ij}$ and $G$ by the inverse congruence. Positive semidefiniteness survives a diagonal congruence, so the certificate is well posed; the *numerical* entries of $G$ are not, and neither is the $144^2$ target of §4.

## 7. Claim 5, confirmed, and the in-file version of it cannot fail

[claim5_gram.py](../scripts/reviewers/r191/claim5_gram.py) computes all $1225$ entries. Result: $45$ nonzero, **$0$ pairing distinct weights**, diagonal $\{12,24,36,48,64,96\}$, Hermitian, positive on the diagonal, block sizes $\{1\!:\!16,\;2\!:\!8,\;3\!:\!1\}$, and every weight block nonsingular, which is what makes `coords` solvable at all.

The file's own version of this line is vacuous. [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) opens its loop with `if WT[a] != WT[b]: continue` and then prints `all(WT[a]==WT[b] for a,b in H)`. **The pairs that would falsify the statement are the ones the `continue` discarded**, so the printed `True` is a property of the loop, not of the tensors. It belongs in [plan.md](../plan.md)'s table.

## 8. Two findings outside the brief

**(a) None of the code under review runs.** `sym3_ip`, `coords`, `cube` and `cconj` are defined in [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) and **never called**, an AST walk of the file finds no call to any of them, and executing the file prints the Gram lines and then two literals. So "stage 2 assembled: coordinates, Sym^3 metric, and the cube map" reports the presence of text on disk. Everything in §§1–3 above was obtained by lifting those routines into [scripts/reviewers/r191/](../scripts/reviewers/r191/) and driving them, which is the first time any of them has been executed.

**(b) The `IP_CONVENTION` block added to the file mid-cycle is mislabelled, and the default is right only by accident.** The file now carries three named branches. Audited by value rather than by name:

| branch as labelled in the file | what it computes | adjointness, 828 exhaustive pairs |
|---|---|---|
| `"IDBIJ"`, **the current default** | the plain bijection sum, i.e. Fischer | **PASS**, 828/828 |
| `"FISCHER"` | bijection sum $/(\mathrm{aut}(t)\,\mathrm{aut}(s))$ | **FAIL**, 815/828 |
| `"BOMBIERI"` | bijection sum $/3!$, the induced metric | **PASS**, 828/828 |
| (the thing "IDBIJ" is named after) | the single identity bijection, no sum | **FAIL**, 818/828 |

The names are crossed. `"IDBIJ"` returns the bijection **sum**, which is the convention my test accepts; the identity-bijection-only rule that the name describes is one my test rejects. `"FISCHER"` returns neither Fischer nor anything invariant. **The live consequence: the file currently produces correct numbers, and renaming the default to the branch called `"FISCHER"` (the obvious tidy-up for anyone who reads §1's verdict as "Fischer passes"), silently installs a non-invariant metric.** The comment above the block is also false as written: it claims the bijection sum and the `"FISCHER"` branch agree when $H$ is diagonal and part company only on $H$'s $10$ off-diagonal within-weight entries. With $H$ diagonal they differ by $\mathrm{aut}(t)^2$ on every repeated monomial, at $t=(0,0,0)$, $1572864$ against $131072/3$.

The safe repair is to keep one convention, name it by the value it returns, and record $\kappa=6$ from §3 next to it.
