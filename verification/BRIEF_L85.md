# Brief, round L85

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the heading and the argument ([findings/sym3-blocks.md](../findings/sym3-blocks.md) line 52, and lines 66-71)

#### Lemma L85, $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, a machine count with three hand-checkable rungs

## The constraint count

An SOS certificate faces one equation per basis invariant sextic, so the constraint count is $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$. By Weyl integration in exact Laurent polynomials, $\dim V^G=\tfrac1{|W|}\mathrm{CT}\big[\chi\prod_\alpha(1-t^\alpha)\big]$, with $\mathrm{Sym}^k$ characters from the power sums $p_j(t)=\chi(t^j)$ by Newton, **the answer is $14$**. [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py).

The sequence at $n=5$ is $1,1,4,5,14$ for degrees $2$ through $6$, against the stable-range $1,2,7,19,89$. Every entry is strictly smaller, which is the syzygies, and **degree $3$ being $1$ reproduces the Lovelock collapse by a method sharing nothing with the contraction identity that first gave it**.

## Passage B, the canonical statement ([results.md](../results.md) line 288, landscape, and line 956, detail)

- **Lemma L85 (landscape). $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$.** A machine count with three hand checks. The invariant dimension at degree six is fourteen.

$\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, machine-counted with three hand checks. *The $14$ is measured rather than derived.* **"Every entry is strictly smaller" is false at degree two and forced to be**: $\mathcal W_n$ is absolutely irreducible, so that count is $1$ at every $n$.

## Definitions and sources

- $\mathcal W_5$ is the space of algebraic Weyl tensors on $\mathbb R^5$, of dimension $35$. $(\mathrm{Sym}^k\mathcal W_5)^{O(5)}$ is the space of $O(5)$-invariant polynomials of degree $k$ on it. The "stable range" figures are the invariant dimensions for large $n$.
- Weyl's integration formula and the $B_2$ character theory are classical and unfiled.
- **This loop does no numerical work**; a statement supported only by a script or a run is HYPOTHESIS-DEBT. The Lean file for this result is withheld.

## What to attack, beyond the standing list

1. **The statement**: $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$. Whether any argument on file establishes the $14$, as opposed to a computation.
2. **The method as written**: Weyl integration with $\dim V^G=\tfrac1{|W|}\mathrm{CT}[\chi\prod_\alpha(1-t^\alpha)]$, for a connected group, applied to $O(5)$; whether the passages justify computing the $O(5)$ count with $SO(5)$ tools at each degree of the sequence.
3. **"Three hand-checkable rungs"** (heading): which entries are checkable by hand, and whether any hand check is written.
4. **"The sequence at $n=5$ is $1,1,4,5,14$ ... against the stable-range $1,2,7,19,89$. Every entry is strictly smaller, which is the syzygies"**: each clause, at each degree.
5. **"Degree $3$ being $1$ reproduces the Lovelock collapse by a method sharing nothing with the contraction identity that first gave it"**: whether the degree-$3$ count and the Lovelock relation are the same fact, and whether the independence is argued.
6. **Passage B's additions**: "machine-counted with three hand checks", "The $14$ is measured rather than derived", and the degree-two clause with its reason.
7. The boundary: degree $2$, odd degrees, and $n=5$ against $n\ge6$.
