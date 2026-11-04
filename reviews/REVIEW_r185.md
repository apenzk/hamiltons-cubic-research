# Review r185, Gate 2, adversarial

Scope: the five claims of the Gate 2 brief, priority on claim 1. Scripts: [scripts/reviewers/r185/](../scripts/reviewers/r185/). All arithmetic exact, over $\mathbb{Q}$ or over $\mathbb{F}_{10007}$; numerics appear only as refutation witnesses.

| # | claim | verdict |
|---|---|---|
| 1 | the polarised diagram evaluation is the apolarity coefficient | **REFUTED, with a witness**, it is a correct *vertex-ordered* multilinear form, and the monomial coefficient is its $S_6$-symmetrisation. The two agree only on $\beta=(6,0,0)$, which is exactly the case the shipped validation tests |
| 2 | the 41 cubic forms have support $1\ldots195$, mean $49$, all within $234$ | **CONFIRMED** on the numbers, and the "within $234$" part **could not have failed**, being forced by the cache's own layout |
| 3 | the extremiser repair passes the undoubled vector | **CONFIRMED in substance, but the test still cannot fail**, $2S-\mathrm{diag}(S)$ satisfies Bianchi and $\mathrm{Ric}=0$ too |
| 4 | $\mathop{\mathrm{tr}}(M^k)=2^k\mathop{\mathrm{tr}}(A^k)$, hence $64$ at degree six | **IDENTITY CONFIRMED, SCOPE OVERSTATED**, the operator-trace subalgebra is $4$ of the $14$ invariant sextics at $n=5$ |
| 5 | $G_{\text{tensor}}=4\,G_{\text{operator}}$ | **CONFIRMED, and proved for every $n$**, and the SDP must be carried in the tensor normalisation |

---

## 1. The polarised diagram, refuted

### What the shipped map is

[eval_polarised](../scripts/runs/run_n5_polarised_diagram.py) contracts the diagram with `tensors[v]` at vertex $v$. That map is *correct*: [independent_polarised.py](../scripts/reviewers/r185/independent_polarised.py) reimplements it as a single `np.einsum` over all six operands, with the matching written straight into the subscript string (no pairwise merging, no letter recycling, no self-pair branch) and the two agree on $8/8$ random matchings under random reorderings of the six tensors. It is also multilinear in **every** slot, not just slot $0$ (the shipped script checks slot $0$ only), and it is invariant under exactly the automorphisms of the labelled diagram and no others: on a matching built as three isomorphic $2$-vertex blocks, the block-internal swap and the block rotation both leave the value fixed while the non-automorphism $0\leftrightarrow2$ changes it.

### What it is not

A monomial names an **unordered multiset** of six basis tensors. Its coefficient is therefore the sum over the $6!/\beta!$ distinct vertex placements, equivalently $(6!/\beta!)$ times the symmetric polarisation, never one ordering. And the shipped map is nowhere near symmetric: over the $720$ permutations of six random Weyl tensors it takes **$701$ distinct values** on one matching and $352$ on another.

Three independent routes, in [attack_polarised.py](../scripts/reviewers/r185/attack_polarised.py) and [repair_coefficient.py](../scripts/reviewers/r185/repair_coefficient.py):

- **finite differences from the unpolarised map.** $J_{\mathrm{sym}}=\frac1{6!}\sum_{\emptyset\ne S}(-1)^{6-|S|}J\!\left(\sum_{i\in S}T_i\right)$, built from reviewer 179's [eval_diagram](../scripts/reviewers/r179/weyl_invariants.py) alone. On three matchings it equals the $S_6$-average of the shipped map and differs from the shipped map itself: $2492$ vs $1638$, $799$ vs $4157$, $9240$ vs $7388$.
- **exact univariate interpolation.** Expanding $J(xA+B)$ as a binary sextic over $\mathbb{F}_p$ by a $7$-point Vandermonde solve, the true coefficient of $x^d$ equals the sum over the $\binom6d$ placements of $A$ (matched on all three matchings) and does **not** equal $\binom6d$ times the shipped value. The ratios are junk, so no constant repair exists.
- **the multi-index table.** Across three matchings and seven multi-indices $\beta$, the finite-difference route and the symmetrisation route agree on all $21$, and the shipped map is right only at $\beta=(6,0,0)$.

```
matching 0
  beta=(6,0,0): FD= 4668  Sym= 4668  AGREE | shipped-ep-as-coefficient = 4668 (right)
  beta=(5,1,0): FD= 6160  Sym= 6160  AGREE | shipped-ep-as-coefficient = 4442 (WRONG)
  beta=(4,2,0): FD= 9918  Sym= 9918  AGREE | shipped-ep-as-coefficient = 9564 (WRONG)
  beta=(3,3,0): FD= 7926  Sym= 7926  AGREE | shipped-ep-as-coefficient =  190 (WRONG)
  beta=(2,2,2): FD= 5369  Sym= 5369  AGREE | shipped-ep-as-coefficient = 1684 (WRONG)
  beta=(1,2,3): FD= 6434  Sym= 6434  AGREE | shipped-ep-as-coefficient = 2512 (WRONG)
  beta=(4,1,1): FD=  744  Sym=  744  AGREE | shipped-ep-as-coefficient = 7382 (WRONG)
```

**The validation is the lesson.** $J(W,\ldots,W)$ puts the same tensor in all six slots, so it is blind to every reordering; multilinearity in slot $0$ holds for any multilinear map whatever. The one multi-index where the shipped map is right is precisely the one the diagonal check tests, a check that can only confirm.

### The repair, and it is cheaper than the thing it replaces

The apolarity pairing is $\langle q,J\rangle=q(\partial)J=\sum_\beta q_\beta\,\beta!\,[x^\beta]J$, and $[x^\beta]J=(6!/\beta!)\,J_{\mathrm{sym}}$, so the $\beta!$ cancels and the $14\times36$ system needs $6!\,J_{\mathrm{sym}}$, the **symmetric** polarisation, at every monomial. Two ways to get it, both verified in [repair_coefficient.py](../scripts/reviewers/r185/repair_coefficient.py):

| route | calls | cost per $\beta$ measured |
|---|---|---|
| finite differences on the unpolarised `eval_diagram` | $\prod_a(\beta_a+1)\le64$ | $1$–$12$ ms |
| symmetrising `eval_polarised` | $6!/\beta!\le720$ | $5$–$5700$ ms |

The finite-difference route wins on both counts: it is $20$–$500\times$ faster and it reuses the machinery reviewer 179 already validated, so `eval_polarised` need not enter the pipeline at all.

### The self-pair branch

The brief's suspicion is right that the branch is untested, though the failure is quieter than the PSD verifier's.

- **It is dead code.** [random_matching](../scripts/reviewers/r179/weyl_invariants.py) rejects any matching pairing two slots of the same vertex, so the `while ia:` loop is unreachable through the shipped generator: $0$ of $20\,000$ sampled matchings carry an intra-vertex pair. Both shipped validations therefore leave it entirely unexercised, and [eval_diagram](../scripts/reviewers/r179/weyl_invariants.py) cannot evaluate such a matching at all, so the diagonal check could not reach it even in principle.
- **Forced by hand on the first operand, it is correct.** With $k=2$ and every vertex tracing itself it returns the hand value; with $k=3$, one vertex self-paired and two fully joined, likewise. `np.trace` drops the two axes and preserves the order of the rest, which is what the parallel `ia` update assumes.
- **It raises on the second operand of a merge.** For `[(0,4),(1,5),(2,3),(6,7)]` (both vertices carrying a self-pair and sharing two legs), the letter assignment gives the two slots of vertex $1$'s self-pair the *same* einsum letter while `out` keeps both, and numpy rejects the repeated output subscript: `ValueError: einstein sum subscripts string includes output subscript 'e' multiple times`. Vertex $0$'s self-pair survives correctly, so the handling is asymmetric between the two operands.

The failure is loud rather than silent, so it cannot corrupt a value, but the support for self-pairs is partial and nothing in the shipped tests would ever discover that.

---

## 2. The cubic forms' support, confirmed, and one part of it is vacuous

Recounted from the cache in [claims_2_to_5.py](../scripts/reviewers/r185/claims_2_to_5.py): $41$ vectors, support $1$ to $195$, mean $48.5$, so the reported figures stand.

**The round-trip is faithful.** [n5_hw_cache.json](../scripts/runs/n5_hw_cache.json) stores every Gaussian rational as four Python integers, a numerator/denominator pair for the real part and one for the imaginary part. No entry is a float, no denominator is zero, and every vector's length equals its block's column count. There is no lossy step to lose exactness in.

**The "$234$" check could not have failed.** Support $\le$ vector length $=$ block column count, and the largest column count in the cache *is* $234$. The bound is forced by the layout rather than measured, so it carries no information about the vectors. What it does confirm (that each $u_i$ lives in a single weight space), is already true by construction of the cache. The informative figure is the one the record buries: the largest support is $195$ and the mean $48.5$, so the products $P_i\overline{P_j}$ really are a few thousand monomials rather than millions.

---

## 3. The extremiser repair, correct object, test still cannot fail

**The repair is genuine.** [sym2_to_R](../scripts/runs/run_n5_weyl_module.py) reads $v_{(a,b)}$ as the matrix entry $S_{ab}$ itself for $a<b$, so the undoubled vector is the right coordinate vector. Read back: building $R=\texttt{sym2\_to\_R}(\mathrm{vec})$ and then $R_{ijkl}$ on the $\Lambda^2$ pair indices reproduces $S$ **entrywise**. It is therefore the same $S$ from which the script computes the spectrum $(2,-1,-1,0^7)$, $\mathop{\mathrm{tr}}(S^2)=6$ and $\mathop{\mathrm{tr}}(S^3)=6$. Claim 3's substance holds.

**But the check the script prints still passes for the wrong object.** $\mathrm{diag}(S)$ is itself a Weyl tensor, hence so is $2S-\mathrm{diag}(S)$ by linearity, and the doubled vector's Bianchi $+$ $\mathrm{Ric}$ residual is identically zero as well. The membership test cannot separate the two vectors it was repaired to separate. It would have mattered: the doubled object has $\mathop{\mathrm{tr}}=15$ and $39/2$, so it would have read $|W|^2=5/2$ and $\mathop{\mathrm{tr}}(W^3)=\tfrac{13}{4}/\sqrt6$, the whole $\theta=\sqrt{3/2}$ conclusion gone.

**The discriminating check, which the script lacks:** apply `sym2_to_R` to the vector and read the result back on $\Lambda^2$; demand it equal $S$. True for the undoubled vector, false for the doubled one. One line, and it is the only test here that could have failed.

---

## 4. The $64$ as a grading, identity true, scope overstated

**The identity holds and has a one-line proof.** `sym2_to_R` sends $S$ to $R=\sum_{a,b}S_{ab}\,f_a\otimes f_b$ with $f_a=e_i\otimes e_j-e_j\otimes e_i$, and the flat $25\times25$ reshape is $M=\sum_{a,b}S_{ab}f_af_b^{\mathsf T}$. Since $\langle f_a,f_b\rangle=2\delta_{ab}$, every step of a trace cycle contributes one factor $2$, so $\mathop{\mathrm{tr}}(M^k)=2^k\mathop{\mathrm{tr}}(A^k)$ for all $k$ and all $n$. Verified exactly over $\mathbb{Q}$ for $k=2,\ldots,6$ on random Weyl tensors. Hence every degree-$d$ product of operator traces scales by $2^d$, and $64$ at degree six.

**It covers $4$ of the $14$.** [claim4_scope.py](../scripts/reviewers/r185/claim4_scope.py): the degree-six trace words $\mathop{\mathrm{tr}}(A^2)^3$, $\mathop{\mathrm{tr}}(A^2)\mathop{\mathrm{tr}}(A^4)$, $\mathop{\mathrm{tr}}(A^3)^2$, $\mathop{\mathrm{tr}}(A^6)$ span a $4$-dimensional space of functionals on $\mathcal W_5$ ($\mathop{\mathrm{tr}}A=0$ on the sample, as $\mathrm{Ric}=0$ requires), while the diagram functionals reach rank $14$ on the same $60$ points. So the grading reaches $29\%$ of the degree-six invariants.

**Which of the two earlier readings is true.** Neither, and the question is malformed for the invariants it is about. A sextic outside the trace subalgebra contracts single indices *across* the antisymmetric pairs and has no expression in $A$ at all, so there is no operator version of it to be scaled or to be wrong, it is one pure contraction of $R$ with one value. The dichotomy applies only inside the subalgebra, and there "scaled" is right: uniformly by $2^d$. $F_5=\tfrac32\mathop{\mathrm{tr}}(A^2)^3-9\mathop{\mathrm{tr}}(A^3)^2$ is a trace word, so the $64$ applies to it, and the record's conclusion stands for the reason it gives.

---

## 5. The normalisation factor, confirmed, proved, and the SDP's convention

**$G_{\text{tensor}}=4\,G_{\text{operator}}$ entrywise, exactly.** Checked over $\mathbb{Q}$ on $144$ basis pairs, and proved for every $n$ by the same computation as claim 4: $\langle R_A,R_B\rangle_{\text{tensor}}=\sum_{a,b,a',b'}A_{ab}B_{a'b'}\langle f_a,f_{a'}\rangle\langle f_b,f_{b'}\rangle=4\mathop{\mathrm{tr}}(AB)$. So $|W_0|^2$ reads $4$ through [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py) and $1$ through [run_n5_extremiser.py](../scripts/runs/run_n5_extremiser.py), as the record says.

**The SDP must be carried in the tensor normalisation.** Both ingredients of $F_5$ in [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) ($q(W)=\sum_{ijkl}W_{ijkl}^2$ and $\mathop{\mathrm{tr}}(M^3)$ on the flat reshape), are pure contractions of the rank-4 tensor, exactly as the $14$ diagram functionals are. So the $14$ coordinates $-39,-\tfrac34,\ldots$ are the coordinates of $64\,F_5^{\text{record}}$ in a basis of tensor contractions, and the cubic forms $P_i(W)=\langle W^3,u_i\rangle$ must be formed with $G_{\text{tensor}}$, the Gram that [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py) builds, for the two sides of $\langle P_i\overline{P_j},J_b\rangle=\langle F_5,J_b\rangle$ to live in one normalisation. Mixing in $G_{\text{operator}}$ leaks a $4^3$ into the cubic side against a $4^3\cdot$ nothing on the sextic side.

**A consistency check that the two conventions do agree where it counts:** in the tensor convention $|W_0|^2=4$ and $\mathop{\mathrm{tr}}(W_0^3)=8/\sqrt6$, so $\tfrac32\cdot4^3-9\cdot\tfrac{64}{6}=96-96=0$. $F_5$ vanishes at the extremiser in both.

---

## What to change

1. **Stop treating [eval_polarised](../scripts/runs/run_n5_polarised_diagram.py) as the coefficient map.** Extract $[x^\beta]J_b$ by finite differences on `eval_diagram`, fewer calls, faster calls, and machinery already under review.
2. **Retire the diagonal check as evidence.** $J(W,\ldots,W)$ and one-slot multilinearity are jointly satisfied by every vertex-ordered multilinear form; the discriminating check is agreement with the finite-difference polarisation on a mixed multi-index.
3. **Add the round-trip to [run_n5_extremiser.py](../scripts/runs/run_n5_extremiser.py)** (`sym2_to_R(vec)` read back on $\Lambda^2$ must equal $S$) and drop the claim that the Bianchi/$\mathrm{Ric}$ residual confirms the repair.
4. **Record the $64$'s scope as the trace subalgebra**, $4$ of the $14$ at $n=5$, rather than as a statement about degree-six invariants in general.
