# Adjudication brief, round L65-r2, step J1

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From Passage B, "so the seed of every block is given in closed form and need not be searched for", and Passage C's landscape line, "so it is constructed rather than searched for", each read as a claim of the result.

**The step: for every block label covered by the lemma, the seed $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is given in closed form and is obtained without a search, and this follows from the passages.**

## Passage A, the section carrying the argument ([findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 86-98)

## The seed is the inclusion padded by cups

The realisation theorem says one nonzero seed per block generates that block, and says nothing about **where a seed comes from**. That gap is what kept obligation (ii) open: if the seed must be found by search, finding a nonzero element of $\operatorname{Hom}(V_\lambda,V^{\otimes12})$ is the same construction problem the item started with, once per block.

**It need not be searched for.** Let $\lambda$ be a block label, so $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, write $k=(12-\lvert\lambda\rvert)/2$, let $\iota_\lambda:V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion given by Weyl's construction of $V_\lambda$ as the traceless tensors of symmetry type $\lambda$ (classical, unfiled), and let $\mathrm{cup}=\sum_a e_a\otimes e_a\in V\otimes V$ be the invariant metric element.

> **Lemma.** *Let $n\ge1$, and let $\lambda$ be $O(n)$-admissible, $\lambda'_1+\lambda'_2\le n$, with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$.* Then $c_0:=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$, the map $x\mapsto\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$, is a **nonzero** element of $M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$.

**Admissibility is what makes $V_\lambda$ nonzero.** For a label that is not admissible, Weyl's construction gives the zero space and no nonzero seed exists, witness $\lambda=(2,2)$ at $n=2,3$ and $\lambda=(2,1,1)$ at $n=3$. **Every label with $\lvert\lambda\rvert\le n$ is admissible**, because $\lambda'_1$ counts the nonzero parts and $\lambda'_2$ the parts of size at least two, so a part of size $p$ contributes at most $p$ to $\lambda'_1+\lambda'_2$ ([L65.lean](../lean/HamiltonsCubic/Results/L65.lean)). So at $n\ge12$ every block label is admissible, with equality $\lambda'_1+\lambda'_2=12$ at $\lambda=(2,2,2,2,2,2)$.

**Proof.** *Equivariance.* $g\cdot\mathrm{cup}=\sum_a ge_a\otimes ge_a$ has coefficient matrix $gg^{\mathsf T}=I$ for every $g\in O(n)$, reflections included, so $\mathrm{cup}$ is invariant, and the tensor product of the equivariant map $\iota_\lambda$ with invariant vectors is equivariant. *Nonvanishing.* For $x\ne0$, $\iota_\lambda(x)\ne0$, and $\mathrm{cup}\ne0$ because $n\ge1$, so $\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ is a tensor product of nonzero vectors and is nonzero. Equivalently, the contraction applying $\langle\cdot,\cdot\rangle$ to the two factors of one cup returns $\sum_a\langle e_a,e_a\rangle=n$, so contracting all $k$ cups returns $n^k\iota_\lambda\ne0$. **Nonzero in $M_\lambda$ and nonzero as a map are the same statement**, $M_\lambda$ being a space of maps. $\square$

So every block has a seed in closed form relative to $\iota_\lambda$, and the realisation theorem applies to it. **The seed is $\iota_\lambda$ followed by a padding diagram of $k$ cups.** Where $\lvert\lambda\rvert=12$, $k=0$ and the seed is $\iota_\lambda$ itself, so there the content is Weyl's construction.

## Passage B, the result's block in the same file ([findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 112 and 116)

#### Lemma L65, the seed is the inclusion padded by cups

Let $n\ge1$ and let $\lambda$ be an $O(n)$-admissible label with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. Write $k=(12-\lvert\lambda\rvert)/2$, let $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion and $\mathrm{cup}=\sum_ae_a\otimes e_a$ the invariant metric element. Then $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero element of $\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$, so the seed of every block is given in closed form and need not be searched for. Admissibility is what makes $V_\lambda$ nonzero, and it holds whenever $\lvert\lambda\rvert\le n$.

## Passage C, the canonical statement ([results.md](../results.md) line 229, landscape, and lines 800 and 802, detail)

- **Lemma L65 (direct). The seed is the inclusion padded by cups.** For $n\ge1$ and an $O(n)$-admissible label $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, with $k=(12-\lvert\lambda\rvert)/2$ and $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ the inclusion, the seed $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero $O(n)$-equivariant map $V_\lambda\to V^{\otimes12}$, so it is constructed rather than searched for. Admissibility holds whenever $\lvert\lambda\rvert\le n$.

##### Lemma L65, the seed is the inclusion padded by cups

For $n\ge1$ and a block label $\lambda$, $O(n)$-admissible with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, write $k=(12-\lvert\lambda\rvert)/2$, let $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion of the irreducible into the tensor power, and let $\mathrm{cup}=\sum_ae_a\otimes e_a$ be the invariant metric element. Then the seed $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero element of $\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$: $\mathrm{cup}$ is $O(n)$-invariant, and a tensor product of nonzero vectors is nonzero. The seed is $\iota_\lambda$ followed by a padding diagram of $k$ cups, and at $\lvert\lambda\rvert=12$ it is $\iota_\lambda$ itself. Admissibility makes $V_\lambda$ nonzero and holds whenever $\lvert\lambda\rvert\le n$, since $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$. The lemma removes a search from the certificate pipeline and adds no certificate.

## Definitions

- $V=\mathbb R^n$ with the standard action of $O(n)$, and $V^{\otimes m}$ with the diagonal action $g\cdot(v_1\otimes\dots\otimes v_m)=gv_1\otimes\dots\otimes gv_m$ and the induced inner product.
- A **block label** is a partition $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. $\lambda'$ is the conjugate partition, so $\lambda'_1$ is the number of nonzero parts of $\lambda$ and $\lambda'_2$ the number of parts of size at least $2$. $\lambda$ is **$O(n)$-admissible** when $\lambda'_1+\lambda'_2\le n$.
- $V_\lambda$ is the $O(n)$-representation labelled by $\lambda$, and $M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$.
- **This loop does no numerical work.** A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim.

## The question

**Prove the step above valid as written, from the passages and standard mathematics, or exhibit exactly where it fails.** Give the strongest reading the words support, including a hypothesis the author may have meant but not written, and say which hypotheses that reading needs. Return a verdict of VALID or FAILS, with the argument.
