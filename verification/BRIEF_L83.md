# Brief, round L83

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the setting ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 3, 7, 9 and 13)

The certificate route at $n=5$ asks whether $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$ is a sum of squares on $\mathcal W_5$. Because $O(5)$ acts, the Gram matrix of such a certificate is block-diagonal over the isotypic components of $\mathrm{Sym}^3(\mathcal W_5)$, and this file holds that decomposition together with the objects it needs.

$\mathcal W_5$ is the $O(5)$-irreducible $[2,2]$, of dimension $35$, realised as $\Lambda^2\mathbb R^5\to\mathrm{Sym}^2(\Lambda^2)\to$ first Bianchi $\to$ Ricci-traceless. **The highest weight is $4\omega_2$ rather than $2\omega_2$**: in $B_2=\mathfrak{so}(5)$ the fundamental weight $\omega_2$ is the *spin* weight, so $[2,2]=2e_1+2e_2$ solves to $4\omega_2$. A dimension check cannot separate this from $\omega_1+2\omega_2=[2,1]$, which also has dimension $35$; the Casimir does, at $16$ against $12$.

$\mathfrak{so}(5)$ acts by derivation, and the action is exact over $\mathbb Q$ in [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py): the homomorphism holds on all $45$ generator pairs with residual $0$, and the Casimir is $16\cdot\mathrm{Id}$ with every off-diagonal entry exactly zero.

The normalisation is $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$, which is *positive* definite on the compact real form ($\mathop{\mathrm{tr}}(X^2)=-2$ for $X=E_{12}-E_{21}$) so $\{E_{ij}-E_{ji}\}$ is $B$-orthonormal and self-dual, each $\rho(X_a)$ is skew, and $\rho(X_a)^2$ is negative semi-definite. **The minus in $C=-\sum_a\rho(A_a)^2$ is what makes $\langle\lambda,\lambda+2\rho\rangle=+16$ come out positive.** Neighbouring conventions give $32$, $8$, $8/3$ and $4$; the $8/3$ is [Killing](conventions.md), since $B_K=(N-2)\mathop{\mathrm{tr}}=3\mathop{\mathrm{tr}}=-6B$ and the Casimir scales inversely.

## Passage B, the table and its argument ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 29-42, under the heading of Lemma L83 at line 15)

## The 24 blocks

The table is arithmetic on the highest weights: the Weyl dimension formula for $B_2$ is a product of four linear factors, and $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$. **No linear algebra on the $7770$ is involved.** [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py).

| mult | blocks (highest weight, dimension) | unknowns |
|---|---|---|
| $4$ | $(4,2)_{220}$, $(2,2)_{35}$ | $20$ |
| $3$ | $(3,2)_{105}$ | $6$ |
| $2$ | $(5,2)_{390}$, $(4,3)_{231}$, $(4,4)_{165}$, $(4,1)_{154}$, $(3,1)_{81}$, $(4,0)_{55}$, $(2,1)_{35}$, $(3,0)_{30}$, $(2,0)_{14}$ | $27$ |
| $1$ | $(6,6)_{455}$, $(6,4)_{810}$, $(6,3)_{770}$, $(6,2)_{625}$, $(6,0)_{140}$, $(5,4)_{429}$, $(5,3)_{455}$, $(5,1)_{260}$, $(5,0)_{91}$, $(3,3)_{84}$, $(1,0)_{5}$, $(0,0)_{1}$ | $12$ |

The reconstruction closes four independent ways: $24$ blocks, $\sum m_\lambda d_\lambda=7770$ exactly, multiplicities summing to $41$, unknowns to $65$. The twelve multiplicity-$1$ dimensions sum to $4125$.

**The trivial multiplicity is $1$ here and $2$ from $n\ge6$**, which is the parity-sensitive Lovelock collapse: at $n\le5$, $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$, so the cubic invariant space is one-dimensional.

## Passage C, the canonical statement ([results.md](../results.md) line 284, landscape, and line 942, detail)

- **Lemma L83 (landscape). The $24$-block table of $\mathrm{Sym}^3(\mathcal W_5)$.** All twenty-four blocks with their multiplicities, every subscript from Weyl's formula and the Casimir at $B_2$'s own $\rho$, with one block closed by an external count.

The twenty-four blocks of $\mathrm{Sym}^3(\mathcal W_5)$, with their labels and multiplicities. *Every number re-derives by hand, all $24$ subscripts from Weyl's formula and the Casimir at $B_2$'s own $\rho$, and one block is closed by an external count of $7770$.* **The table is right and the two sentences it was stated with are not**: arithmetic on the highest weights is false of the multiplicities.

## Passage D, the Lean file

[lean/HamiltonsCubic/Results/L83.lean](../lean/HamiltonsCubic/Results/L83.lean), read in full from disk.

## Definitions and sources

- $\mathcal W_5$ is the space of algebraic Weyl tensors on $\mathbb R^5$. $\mathrm{Sym}^3(\mathcal W_5)$ is its third symmetric power, of dimension $\binom{37}3$, decomposed under $O(5)$, equivalently under $SO(5)$ as the passages argue.
- Weyl's dimension formula and the Casimir eigenvalue $\langle\lambda,\lambda+2\rho\rangle$ for $B_2$ are classical and unfiled; say where a step needs their exact form.
- **This loop does no numerical work**; a statement supported only by a script or a run is HYPOTHESIS-DEBT.

## What to attack, beyond the standing list

1. **What the lemma states**: the twenty-four highest weights and their multiplicities in $\mathrm{Sym}^3(\mathcal W_5)$. Whether any argument on file produces the weight list and the multiplicity column, as opposed to the dimension and Casimir columns.
2. **"The table is arithmetic on the highest weights ... No linear algebra on the $7770$ is involved"**: whether that describes how the multiplicities are obtained.
3. **"The reconstruction closes four independent ways"**: whether $24$ blocks, $\sum m_\lambda d_\lambda=7770$, multiplicities summing to $41$ and unknowns to $65$ are independent checks of the table, and what each could detect. Exhibit, if one exists, a different table satisfying all four.
4. **The dimension column**: every subscript against Weyl's $B_2$ formula in the label basis the table uses, and whether that basis is stated.
5. **The label identification**: "$[2,2]=2e_1+2e_2$ solves to $4\omega_2$", "the Casimir ... at $16$ against $12$", and the claim that $SO(5)$ labels serve as an $O(5)$ block table.
6. **"The trivial multiplicity is $1$ here and $2$ from $n\ge6$"** and the Lovelock reason given.
7. **Passage C**: "Every number re-derives by hand" and "one block is closed by an external count of $7770$", against Passage B.
8. **Passage D**: what the Lean file types, and whether it states the lemma.
9. The boundary: blocks of equal dimension (two of dimension $35$, two of dimension $455$), and the multiplicity-$1$ total $4125$.
