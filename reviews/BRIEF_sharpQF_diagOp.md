# Gate 2 brief: the closed form of `#` at a diagonal operator

You are an adversarial reviewer. **TWO reviewers on identical briefs**, because this is an argument being made rather than text compared against something fixed. *Your independence comes from your implementation, not from your instructions.*

**Work from the definitions below and from the mathematics alone.** Do not read the findings files or the derivation notes. You may read the Lean files named in the table.

## The definitions, quoted so you can work from them alone

On $\mathbb R^n$, $\varphi_{ij}=e_j\otimes e_i-e_i\otimes e_j$, and $\{\varphi_{ab}\}_{a<b}$ is an orthonormal basis of $\Lambda^2\mathbb R^n$ under $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$. Write $[X,Y]=XY-YX$.

A **weight** $w$ is a real symmetric hollow $n\times n$ matrix. It acts on $\Lambda^2$ entrywise:

$$(\mathrm{diagOp}\,w)(X)_{ij} = w_{ij}X_{ij},\qquad\text{so}\qquad (\mathrm{diagOp}\,w)(\varphi_{ij}) = w_{ij}\,\varphi_{ij}.$$

For an operator $R$ on $\Lambda^2$, the **sharp quadratic form** is

$$\mathrm{sharpQF}(R)(\eta) \;=\; -\tfrac14\sum_{i}\sum_{j}\big\langle\,[\eta,\;R([\eta,\varphi_{ij}])\,],\;\varphi_{ij}\big\rangle,$$

both sums over all of $\{1,\dots,n\}$, ordered pairs, including $i=j$ where $\varphi_{ii}=0$.

**GIVEN, proved and not audited here.** $[\varphi_{ab},\varphi_{cd}] = [a{=}c]\varphi_{bd}+[b{=}d]\varphi_{ac}-[a{=}d]\varphi_{bc}-[b{=}c]\varphi_{ad}$, and at distinct $a,b,d$: $[\varphi_{ab},[\varphi_{ab},\varphi_{ad}]]=-\varphi_{ad}$. Also $\mathrm{diagOp}$ is linear in its argument.

## The claim to attack

| # | claim | Lean |
|---|---|---|
| 1 | $\mathrm{sharpQF}(\mathrm{diagOp}\,w)(\varphi_{ab}) \;=\; \tfrac12\sum_{d\notin\{a,b\}}\big(w_{ad}+w_{bd}\big)$ at every symmetric hollow $w$ and every $a\ne b$, **with no row-sum hypothesis** | `sharpQF_diagOp` in [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean), **stated and carrying a `sorry`** |
| 2 | on the diagonal locus, where $w$ additionally has zero row sums, that collapses to $-w_{ab}$ | none: a corollary of row 1 that no declaration states |
| 3 | the $2(n-2)$ directions sharing exactly one index with $\{a,b\}$ are the only ones contributing, and each contributes its COMPLEMENTARY weight | none: this is the mechanism claimed for row 1 |
| 4 | **the anchor**: at $w$ replaced by the constant operator, i.e. $R=\mathrm{id}$, the same formula must return $(n-2)\lVert\eta\rVert^2$ | `sharpQF_id` in [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean), **proved** |

## What to do

1. **Derive row 1 yourself, from the definitions above.** Do not start from the claimed answer. *The inner bracket $[\varphi_{ab},\varphi_{ij}]$ is given by the quoted structure constants, `diagOp` scales each surviving basis element by its own weight, and the outer bracket returns it.* **Report the closed form you get**, whatever it is.
2. **Row 4 is the control and it is decisive.** `id` is not of the form $\mathrm{diagOp}\,w$ for any hollow $w$ (it is $\mathrm{diagOp}$ of the all-ones matrix, which is not hollow), **so state whether row 1's derivation, run with the all-ones weight, reproduces $(n-2)\lVert\varphi_{ab}\rVert^2 = n-2$.** *If it does not, row 1 is wrong or its hypothesis class is.*
3. **Check the constant.** The $-\tfrac14$, the ordered-pair double count and the $\tfrac12$ in the claimed answer must be consistent. *A factor of two here is invisible to every other check.*
4. **Check the hypothesis class.** Row 1 claims no row-sum condition and no skewness of $\eta$ beyond $\eta=\varphi_{ab}$. Say whether symmetry and hollowness of $w$ are both used, and where.
5. **Row 2 is arithmetic**: verify the collapse under $\sum_d w_{ad}=0$.
6. **State what the claim would look like if it were VACUOUS**, and check that it is not.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED**, with the correct closed form if it differs.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct, and any run finishing in a few minutes on objects in hand.

**A REIMPLEMENTATION IS RUN ON A KNOWN VALUE BEFORE ITS DISAGREEMENT IS BELIEVED.** *Row 4 is that known value, and it is why the brief supplies it.* **One that has not reproduced a known value is evidence about itself and nothing else.** This rule was earned three times over in the session that wrote this brief, the third time on a claim eight results depend on.

**A control is an assertion, never a printed expectation.**

**Report.** Write your own `reviews/REVIEW_rN.md` at the number you are given, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**. Never `git add -A`, never `git commit -a`, never amend. **Do not write to reviews/INDEX.md**, and do not read the other reviewer's report.

**Log** to the path you are given: PID and phase plan on the first line, a line per phase, a heartbeat at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
