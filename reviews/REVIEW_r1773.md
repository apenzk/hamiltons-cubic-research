# Review r1773: L120DimPerp.lean (f12a55b2) and L120Eigen.lean (69c25d99), with the L120 row's move to proved

| Claim | Verdict | Reason |
|---|---|---|
| `weightOp2` linear and injective | CONFIRMED | the map is `restrict (diagOp w)`, and injectivity reads the weight off the $(b,a)$ entry of the image of $\varphi_{ab}$ |
| `mem_range_weightOp2` | CONFIRMED | on Weyl $V$ it is `trivial_block_iff` (r1771) repackaged through the weight subtype |
| `mem_perp` | CONFIRMED | the image of `perpW M` is exactly the sign-fixed Weyl operators with $\langle M,V\rangle=0$ |
| `finrank_perp` | CONFIRMED | rank-nullity on a functional that is positive at $w_0$, over weights of dimension $\binom n2-n$ |
| `hessQ_eq_Le` | CONFIRMED | a rewrite of `hessQ_op`, with `LeLin a` the product by $a/\theta$, in L24's normalisation |
| `hessQ_nonpos_iff` | CONFIRMED | division by $6\theta>0$ |
| `eigen_blocks` | CONFIRMED | `hess_blocks` (r1770) read through `hessQ_nonpos_iff` block by block |
| L120 row **proved** | CONFIRMED WITH OBSERVATIONS | the statement is typed clause by clause, and the one untyped item in the lemma's block is the $\Gamma\cap SO(n)$ remark, which is commentary on a proof route the lemma does not take |

**Summary.** Both files prove what they say on the three standard axioms, both match the record in its own normalisation, and the row's move to **proved** is right for L120's statement, with the $\Gamma\cap SO(n)$ remark to be recorded in the row as untyped.

## 1. The record's claims

**L120** ([second-order.md](../findings/second-order.md), "#### Lemma L120"), quoted in full:

> **Let $\Gamma=\{\mathop{\mathrm{diag}}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$ be the full diagonal sign group. Then $\mathcal W_n$ decomposes as** $$\mathcal W_n=\underbrace{\mathcal D_n}_{n(n-3)/2}\ \oplus\ \bigoplus_{\{i,j,k,l\}}\underbrace{V_{ijkl}}_{2}\ \oplus\ \bigoplus_{\{j,k\}}\underbrace{V_{jk}}_{n-3},$$ **and at every diagonal $M$, criticality is unused; $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed, the operator $L_M$ preserves each summand. Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and Lemma L24's criterion is checkable block by block once $\mathcal D_n$ is cut by $\langle M\rangle$; the largest block a non-diagonal direction occupies has size $\max(2,n-3)$, and the $\binom n4$ four-set blocks have size $2$.**

together with the callout that $W^\perp$ cuts $\mathcal D_n$ and nothing else, the $n=4$ exception ("the four-set block is $2$ against $n-3=1$"), and the callout that the determinant-one group $\Gamma\cap SO(n)$ fuses complementary blocks exactly at $n=4,6,8$.

**L24** ("#### Lemma L24"): at a critical $W$ with $\theta=P(W)>0$, $e=W/\theta$, $L_e=e\circ(\cdot)$ with $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, the Riemannian Hessian of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $6\theta(L_e-\tfrac12\mathrm{Id})$, so a local maximiser has $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$.

The record prints no single number for $\dim(\mathcal D_n\cap M^\perp)$. The number $n(n-3)/2-1$ is what "cut by $\langle M\rangle$" gives at $M\ne0$ in $\mathcal D_n$, and the file names it as that.

## 2. Question 1: `finrank_perp`

- **It is the record's cut.** `(perpW (weightOp2 w0)).map weightOp2` is, by `mem_perp`, the set of sign-fixed Weyl operators $V$ on $\Lambda^2$ with $\langle M,V\rangle=0$ at $M=$ `weightOp2 w0`. Every member of the range is Weyl, so restricting `mem_perp` to Weyl $V$ loses nothing.
- **The hypothesis is the record's $M$.** The record's $M$ is the critical point $W$ itself, $\Gamma$-fixed and of unit norm, so nonzero. By `trivial_block_iff` a sign-fixed Weyl operator on `CurvOp2` is `restrict (diagOp w)` for a weight $w$, which is `weightOp2 w0`. `h0` is then $W\ne0$. The hypothesis is therefore neither stronger nor weaker than the record's.
- **The pairing is the Hessian's.** The file's orthogonality is `innerOp2 M V = 0`, and `hessQ_op` reads `v.2.2` as `innerOp2 a v = 0`, so `weylPerpR a` is cut by the same form.
- **The arithmetic.** `two_mul_choose_two_sub` gives $2(\binom n2-n)=n(n-3)$ at $n\ge3$, so $\binom n2-n-1=n(n-3)/2-1$ whenever $\binom n2-n\ge1$. The natural-number truncation touches only $n=3$, where $\dim\mathcal D_3=0$, no nonzero weight exists and `h0` cannot be met. *Screen by hand*: $n=4$ gives $6-4-1=1=2-1$, and $n=5$ gives $10-5-1=4=5-1$.
- **Proof.** `hpos` gets $\langle M,M\rangle>0$ from `normSq2_eq_zero`, `hsurj` makes the functional onto $\mathbb R$, and rank-nullity with `finrank_weights` closes by `omega`. Read line by line, nothing is assumed.

**Observation O2.** The file counts `(perpW M).map weightOp2` on `Fin n`, and `eigen_blocks` quantifies over $\{v\in W^\perp:\text{SignChar}\ \mathbf 1\ v\}$ on a general `ι`. The two sets are equal through `mem_perp` and `trivial_block_iff` at $M=a$, and no theorem states $\dim\{v\in W^\perp_a:\text{sign-fixed}\}=n(n-3)/2-1$ at the critical $a$ itself. The join is a two-line reading and does not affect the verdict.

## 3. Question 2: `hessQ_eq_Le` and `eigen_blocks` against L24

- **Normalisation.** `hessQ a v` is $\lVert v\rVert^2$ times the second derivative of $P$ along the unit-speed great circle through $a$ toward $v/\lVert v\rVert$ ([L24HessOp.lean](../lean/HamiltonsCubic/Results/L24HessOp.lean)), which is the Riemannian Hessian form on the unit sphere. `LeLin a` is `foxProd2 (θ⁻¹ • a)`, the record's $e\circ(\cdot)$ with $e=W/\theta$, and `innerOp2_foxProd2_self` ties $\circ$ to $Q$ as the record's polarisation does. The ½ and the $6\theta$ are the record's.
- **θ.** `hessQ_eq_Le` takes $\theta\ne0$, which is what defining $e$ needs, and is an identity valid on both signs. `hessQ_nonpos_iff` and `eigen_blocks` take $\theta>0$, the record's own hypothesis and the second of the "two places" L24's scope paragraph names, the division that turns $\mathrm{Hess}\le0$ into the eigenvalue bound.
- **`eigen_blocks`** takes a unit critical Weyl $a$, $\theta>0$ and $a$ sign-fixed, and states the bound on all of $W^\perp$ iff on every `setChar t` block. `hess_blocks` carries the content (reviewed in r1770), and `simp only [hessQ_nonpos_iff …]` rewrites both sides under their binders. The hypothesis `hfix` is the record's "$\Gamma$-fixed", and `signChar_diag` supplies it at every diagonal $M$.
- Blocks with $\lvert t\rvert\notin\{0,2,4\}$ are zero by `block_card` (r1771), so the extra quantified `t` add only trivial conditions. The $t=\varnothing$ block inside $W^\perp$ is $\mathcal D_n\cap M^\perp$, so the criterion is the record's "once $\mathcal D_n$ is cut by $\langle M\rangle$".

## 4. Question 3: the status call

Clause by clause against the row:

| Record clause | Declaration |
|---|---|
| decomposition, span and directness | `weyl_span`, `weyl_direct` on `weylModuleS`, with `weylPerp_decomp`, `block_card`, `trivial_block_iff`, `pair_block_iff`, `four_block_iff` on `CurvOp2` (the assembled equation read from `sum_comp`, r1771 O1) |
| $\dim\mathcal D_n=n(n-3)/2$ | `diagSummand_finrank`, `two_mul_choose_two_sub` |
| four-set blocks of size 2, $\binom n4$ of them | `fourSummand_finrank`, `card_sorted4`, `sorted4_summand_finrank` |
| pair blocks of size $n-3$ | `pairSummand_finrank` at $n\ge3$ |
| $L_M$ preserves each summand at every $\Gamma$-fixed $M$, criticality unused | `L120_block_diag`, `signChar_diag` |
| Hessian block-diagonal | `hessOp_char`, `hessOp_pair`, `hessOp_four` |
| checkable block by block | `hess_blocks`, `eigen_blocks` |
| cut by $\langle M\rangle$, and $W^\perp$ cuts $\mathcal D_n$ alone | `finrank_perp`, `mem_perp`, `pair_mem_weylPerp`, `four_mem_weylPerp`, `diag_e_eigen`, `diag_in_trivial` |
| largest block $\max(2,n-3)$, the $n=4$ exception | `blockSize_eq` ([L120Cut.lean](../lean/HamiltonsCubic/Results/L120Cut.lean)), `differs_at_four`, `only_exception`, `agrees_from_five` |
| even-subset characters pairwise distinct at every $n$ | `setChar_sep` |
| dimension identity as transcription insurance | `L120_dim_sum` |
| $\Gamma\cap SO(n)$ fuses complementary blocks exactly at $n=4,6,8$ | **none** |

- **Every clause of the statement is typed.** The pair size $n-3$ and the $n=4$ exception are both present, the latter as an implication.
- **Observation O1, the one untyped item.** The callout "THE DETERMINANT-ONE SIGN GROUP DOES NOT SUPPORT THE EQUIVARIANCE ARGUMENT, AND THE FAILURE IS EXACTLY AT $n=4,6,8$" has no declaration. A grep of every `L120*.lean` for `SO`, `det` and `fus` finds nothing. It makes two mathematical claims: $\chi_S=\chi_{S^{\mathsf c}}$ on $\Gamma\cap SO(n)$, and a fusion with $\lvert S\rvert,\lvert S^{\mathsf c}\rvert\in\{0,2,4\}$ forces $n\le8$ with fusions at $n=4,6,8$.
- **The call.** The remark sits in the proof paragraph, and it concerns a group the lemma does not use, explaining why the statement names the full $\Gamma$. It is commentary on a rejected route, outside the statement, so **proved** stands for L120 as stated. Firm recommendation: the row adds one sentence recording the $\Gamma\cap SO(n)$ remark as untyped and outside the statement. Typing it would be a short file (`setChar t = setChar tᶜ` on sign vectors of product $1$, plus the $n\le8$ count by `omega`), and it should be typed if any citation leans on it. If the programme's convention counts every mathematical sentence in a lemma block as a clause, the row is **partial** until that file exists. I read the convention as the statement's, as other proved rows do.
- The row's second alternative-proof sentence, the r345 support argument, is likewise untyped and likewise needs no declaration, since the equivariance route proves the same clause.

## 5. Question 4: axioms

`lake env lean` on a scratch file importing both modules, exit 0:

- `finrank_perp`, `mem_perp`, `mem_range_weightOp2`, `weightOp2_injective`, `eigen_blocks`, `hessQ_eq_Le`, `hessQ_nonpos_iff`: each `[propext, Classical.choice, Quot.sound]`.
- `#check` confirms the signatures quoted above, including `two_mul_choose_two_sub : 3 ≤ n → 2 * (n.choose 2 - n) = n * (n - 3)`.

## 6. Question 5: falsifiers, and what was done

| Statement | Falsifying object | What I did |
|---|---|---|
| `weightOp2_injective` | two distinct weights with equal operators on $\Lambda^2$ | read the proof, which recovers $w_{ab}$ from `diagOp_phi` at $\varphi_{ab}$, and the diagonal from hollowness |
| `mem_range_weightOp2` | a sign-fixed Weyl operator on $\Lambda^2$ that is not diagonal | inherits `trivial_block_iff` (r1771), checked that the subtype repackaging adds no hypothesis |
| `finrank_perp` | a nonzero weight $w_0$ with $\langle M,\cdot\rangle$ zero on the weights | impossible since the functional is $\lVert M\rVert^2>0$ at $w_0$, so rank is $1$, and the formula was screened by hand at $n=3,4,5$ |
| `hessQ_eq_Le` | a unit critical Weyl $a$ and $v\perp a$ where the great-circle second derivative departs from $6\theta(\langle L_ev,v\rangle-\tfrac12\lVert v\rVert^2)$ | traced to `hessQ_eq` and `L24_hessian`, and checked `LeLin` unfolds to $\theta^{-1}a\circ$ |
| `eigen_blocks` | $v\in W^\perp$ violating the bound while every isotypic component meets it | would need a nonzero cross term, which `hess_sum_blocks` excludes through `char_orth` and `LeLin_char` (r1769, r1770) |
| row **proved** | a record clause with no declaration | tabulated every clause in section 4, and found the $\Gamma\cap SO(n)$ remark only |

No numerics were run beyond the hand screen of the dimension formula, in keeping with the analysis-only rule.

## 7. Observations

- **O1.** The L120 row should record the $\Gamma\cap SO(n)$ fusion remark as untyped and outside the statement, or a short file should type it.
- **O2.** No single theorem states the dimension of the sign-fixed part of $W^\perp_a$ at the critical $a$. The join of `finrank_perp` to `eigen_blocks`'s trivial block is by `mem_perp` with `trivial_block_iff` at $M=a$, and is on `Fin n` against a general `ι`.
- **O3.** `hessQ_eq_Le` takes $\theta\ne0$ and the record's L24 takes $\theta>0$. The Lean hypothesis is weaker and the identity holds at either sign, so this is a strengthening.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.**
