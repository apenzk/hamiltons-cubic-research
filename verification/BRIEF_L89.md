# Brief, round L89

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the heading and the argument ([findings/sym3-blocks.md](../findings/sym3-blocks.md) line 124, and lines 142-150)

#### Lemma L89, $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$, nullity $51$, by exactness of the invariants functor

## The rank is a theorem on the full space, and an open question on the restricted one

The map carrying a Gram to its sextic is multiplication $\mu:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$, which is surjective and $O(5)$-equivariant. $O(5)$ is reductive and the characteristic is zero, so taking invariants is an **exact** functor, and an exact functor carries a surjection to a surjection. Hence

$$\mathrm{rank}(A)=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14\quad\text{exactly, with nullity }65-14=51.$$

**No sample points are needed for it.** The task list carried "evaluate $B_{ij}$ at $\ge15$ points and read off the rank", which asks a computation for what complete reducibility gives; reviewer 200's observation that rank $14$ *implies* consistency collapses the two stated tests into one, and both are now theorems.

**The theorem is about $\mu$, not about the sampled matrix $A$.** *Reviewer 204.* Surjectivity gives $\mathrm{rank}(\mu|_{\text{inv}})=14$ for the **abstract** map; the pipeline's $A$ is the *sampled* coefficient matrix, whose rank is $\le14$ with equality only when the sample points are unisolvent for the $14$ invariants. No theorem supplies unisolvence, so **the sampled rank check is not retired**, the theorem says what its answer must be, which makes it sharper rather than unnecessary.

## Passage B, the two numbers it imports, given ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 56 and 110)

**The count is an `Observation`.** $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ is the output of [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), and no argument on file derives it or the degree-$3$ to degree-$5$ values beside it. **Only degree $2$ is argued**: $\mathcal W_n$ is an absolutely irreducible real $O(n)$-module, so $\dim(\mathrm{Sym}^2\mathcal W_n)^{O(n)}=1$ at every $n\ge4$.

**Statement, on Observation L83's multiplicities.** Write $U=\mathrm{Sym}^3(\mathcal W_5)=\bigoplus_\lambda V_\lambda\otimes M_\lambda$ under $O(5)$, with $m_\lambda=\dim M_\lambda$. Every $V_\lambda$ here is of real type: it is self-dual, $-1$ lying in the Weyl group of $B_2$, which excludes complex type, and a quaternionic $\mathfrak{so}(5)$-module has half-integral coordinates in the $e$-basis, none of which occur. So Schur's lemma gives $\mathrm{Sym}^2(U)^{O(5)}=\bigoplus_\lambda\mathrm{Sym}^2M_\lambda$ and $\Lambda^2(U)^{O(5)}=\bigoplus_\lambda\Lambda^2M_\lambda$, of dimensions $\sum_\lambda\binom{m_\lambda+1}2$ and $\sum_\lambda\binom{m_\lambda}2$, which on L83's table are $65$ and $24$. **An antisymmetric form vanishes on the diagonal, so the $24$ change no sextic.** *$65+24=89=\sum m_\lambda^2$ holds for every multiplicity list and checks nothing; the two numbers inherit L83's standing as an Observation.*

## Passage C, the canonical statement ([results.md](../results.md) line 294, landscape, and line 976, detail)

- **Lemma L89 (landscape). $\operatorname{rank}(\mu|_{\mathrm{inv}})=14$, nullity $51$, by exactness.** Surjectivity of $\mu$ is elementary and the exactness step is a genuine theorem, so the rank and nullity follow without a measurement.

$\operatorname{rank}(\mu|_{\mathrm{inv}})=14$ and the nullity is $51$, by exactness of the sequence. **Surjectivity of $\mu$ is elementary, neither imported nor measured, and the exactness step is a genuine theorem.** *But no measured link drops: the map's domain is not one the certificate route ranges over, and that route consumes $13$ rather than $14$.*

## Passage D, the Lean files

[lean/HamiltonsCubic/Results/L89.lean](../lean/HamiltonsCubic/Results/L89.lean) and [lean/HamiltonsCubic/Results/InvariantsExact.lean](../lean/HamiltonsCubic/Results/InvariantsExact.lean), read in full.

## Definitions and sources

- $\mathcal W_5$ is the space of algebraic Weyl tensors on $\mathbb R^5$. $\mu:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ is multiplication of polynomials. $A$ in Passage A is named there.
- Averaging over a compact group (the Reynolds operator) is classical and unfiled.
- **This loop does no numerical work**; a statement supported only by a script, a run or a measurement is HYPOTHESIS-DEBT.

## What to attack, beyond the standing list

1. **Surjectivity of $\mu$** and its equivariance, as asserted.
2. **"$O(5)$ is reductive and the characteristic is zero, so taking invariants is an exact functor, and an exact functor carries a surjection to a surjection"**: whether this gives $\mu|_{\mathrm{inv}}$ onto $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, and what the minimal justification is.
3. **The display** "$\mathrm{rank}(A)=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ exactly, with nullity $65-14=51$": which object has rank $14$, the source of the $14$ and the $65$ (Passage B), and whether "nullity" is the domain dimension minus the rank.
4. **"No sample points are needed for it ... both are now theorems"** against the next paragraph on the sampled matrix $A$.
5. **The heading's "an open question on the restricted one"** (section heading) against what the section contains.
6. **Passage C's additions**: "the map's domain is not one the certificate route ranges over, and that route consumes $13$ rather than $14$".
7. **Passage D**: whether the Lean files state the lemma, and what they import.
8. **Scope**: the lemma's dependence on the standing of the $14$ and the $65$.
