# Verifier v397, Lemma L65 (the seed is the inclusion padded by cups), its partition bound, and its Lean declarations

The brief [BRIEF_L65r2.md](BRIEF_L65r2.md) was read cold and every step below is worked from its definitions and quoted passages, with no other file of the repository opened. No numerical work was done, no scripts were written, no Lean file was built, and every value reported is exact and derived by hand. Hand screens on constructed objects are labelled as screens and carry no weight for a positive claim. The log is [agent_logs/verify-L65-v397.log](../agent_logs/verify-L65-v397.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | $\mathrm{cup}$ is $O(n)$-invariant and $c_0$ is $O(n)$-equivariant | CONFIRMED | coefficient matrix of $g\cdot\mathrm{cup}$ is $gg^{\mathsf T}=I$, and the diagonal action on $V^{\otimes12}$ factors over the slot blocks |
| 2 | $c_0\ne0$ by the tensor product of nonzero vectors | CONFIRMED | needs $V_\lambda\ne0$, supplied by admissibility through Weyl's theorem in the paragraph before the proof |
| 3 | Contracting the $k$ cups returns $n^k\iota_\lambda$ | CONFIRMED | each cup contracts to $\sum_a\langle e_a,e_a\rangle=n$, and $n^k\ne0$ for $n\ge1$ |
| 4 | Nonzero in $M_\lambda$ equals nonzero as a map | CONFIRMED | $M_\lambda$ is a linear subspace of the maps, with the zero map as its zero |
| 5 | Weyl's construction as imported | CONFIRMED | the classical condition matches admissibility as defined, cited by name only, the "only if" direction is unused by the lemma |
| 6 | $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$, hence admissible when $\lvert\lambda\rvert\le n$, hence every block label at $n\ge12$ | CONFIRMED | a part $p$ contributes $\min(p,2)\le p$ |
| 7 | Witnesses $(2,2)$ at $n=2,3$, $(2,1,1)$ at $n=3$, equality at $(2^6)$ | CONFIRMED | $2+2=4$ and $3+1=4$ exceed $3$, and $6+6=12$ |
| 8 | Seed is $\iota_\lambda$ followed by $k$ padding cups, and is $\iota_\lambda$ at $\lvert\lambda\rvert=12$ | CONFIRMED | $c_0=(\mathrm{id}^{\otimes\lvert\lambda\rvert}\otimes\mathrm{cup}^{\otimes k})\circ\iota_\lambda$ |
| 9 | Passages B and C: the seed is "given in closed form" and "constructed rather than searched for", without A's qualifier "relative to $\iota_\lambda$" | HYPOTHESIS-DEBT | at $\lvert\lambda\rvert=12$ the claim is exactly that $\iota_\lambda$ is explicit, which no passage argues |
| 10 | "The realisation theorem applies to it" | CONFIRMED | the lemma supplies the one requirement Passage A states, a nonzero element of $M_\lambda$ per block |
| 11 | Passages B and C against Passage A | CONFIRMED | same range of $n$, same hypotheses, equivalent conclusions, with the one dropped qualifier of row 9 |
| 12 | Lean declarations of Passage D | CONFIRMED AS ALGEBRA | true as typed, the partition bound is stated, the representation theory is untyped, and seed_ne_zero types $\iota$ as an endomorphism |
| 13 | The boundary: $n=1$, $\lambda=\varnothing$, $\lvert\lambda\rvert=12$, odd $n$, admissible with $\lvert\lambda\rvert>n$, $SO(n)$ | CONFIRMED | every edge case satisfies the hypotheses used, and $n\ge1$ is load-bearing exactly at $\lambda=\varnothing$ |

**Summary: the lemma is proven for every $n\ge1$ and every admissible block label, given Weyl's classical theorem that admissible labels give nonzero $O(n)$-stable subspaces of $V^{\otimes\lvert\lambda\rvert}$, and the only repair owed is to restore "relative to $\iota_\lambda$" in Passages B and C.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$V=\mathbb R^n$ with the standard action of $O(n)$, and $V^{\otimes m}$ with the diagonal action $g\cdot(v_1\otimes\dots\otimes v_m)=gv_1\otimes\dots\otimes gv_m$ and the induced inner product."
- "A **block label** is a partition $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. $\lambda'$ is the conjugate partition, so $\lambda'_1$ is the number of nonzero parts of $\lambda$ and $\lambda'_2$ the number of parts of size at least $2$. $\lambda$ is **$O(n)$-admissible** when $\lambda'_1+\lambda'_2\le n$."
- "$V_\lambda$ is the $O(n)$-representation labelled by $\lambda$, and $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$."
- From Passage A: "$k=(12-\lvert\lambda\rvert)/2$, let $\iota_\lambda:V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion given by Weyl's construction of $V_\lambda$ as the traceless tensors of symmetry type $\lambda$ (classical, unfiled), and let $\mathrm{cup}=\sum_a e_a\otimes e_a\in V\otimes V$ be the invariant metric element."

I read $e_a$ as the standard orthonormal basis of $\mathbb R^n$ (see withdrawn candidate W3). Slots of $V^{\otimes12}$ are ordered as the passage writes them: $\iota_\lambda(x)$ in slots $1,\dots,\lvert\lambda\rvert$, then the cups in the adjacent pairs $(\lvert\lambda\rvert+2j-1,\lvert\lambda\rvert+2j)$ for $j=1,\dots,k$.

## 1. Hypothesis inventory

### 1.1 Hypotheses of the statement

| Hypothesis | Where the proof uses it | Necessary? |
|---|---|---|
| $n\ge1$ | $\mathrm{cup}\ne0$ in the tensor route, $n^k\ne0$ in the contraction route | Yes at $\lambda=\varnothing$: at $n=0$, $V=0$, $\mathrm{cup}$ is the empty sum $0$, $V_\varnothing=V^{\otimes0}=\mathbb R\ne0$, and $c_0=t\mapsto t\cdot0^{\otimes6}=0$. For $\lambda\ne\varnothing$ admissibility already forces $n\ge\lambda'_1\ge1$, so the hypothesis is independent of admissibility only at $\lambda=\varnothing$ |
| $\lambda$ admissible | $V_\lambda\ne0$, so that some $x\ne0$ exists and $\iota_\lambda\ne0$ | Yes: by the "only if" direction of Weyl's theorem, an inadmissible label gives $V_\lambda=0$ and every map out of it is $0$ |
| $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ | $k$ is a nonnegative integer, so $V^{\otimes\lvert\lambda\rvert}\otimes(V\otimes V)^{\otimes k}=V^{\otimes12}$ | Yes for the construction to land in $V^{\otimes12}$ |

### 1.2 Imported theorem: Weyl's construction for $O(n)$

The statement I rely on, as standard mathematics: for a partition $\lambda$ of $d$, let $V^{[d]}\subseteq V^{\otimes d}$ be the traceless tensors (the common kernel of all contractions of two slots) and $S_{[\lambda]}V$ the image of a Young symmetrizer $c_\lambda$ on $V^{[d]}$. Then $S_{[\lambda]}V$ is an $O(n)$-stable subspace, it is irreducible, and it is nonzero if and only if the first two columns of $\lambda$ have total length at most $n$ (Weyl, The Classical Groups, Chapter V, and Fulton and Harris, Representation Theory, §19.5).

| Content | Needed by the lemma? | Status in the passages | Checked against the object |
|---|---|---|---|
| $V_\lambda$ realised inside $V^{\otimes\lvert\lambda\rvert}$ | Yes, it defines $\iota_\lambda$ | Cited by name, "classical, unfiled" | The target degree is $\lvert\lambda\rvert$, matching the slot count |
| The subspace is $O(n)$-stable, so $\iota_\lambda$ is equivariant | Yes, "the equivariant map $\iota_\lambda$" | Assumed, part of the citation | Contractions commute with $g\in O(n)$ because $g$ preserves the inner product, and $c_\lambda$ permutes slots, which commutes with the diagonal action |
| $\iota_\lambda$ injective | Yes, "for $x\ne0$, $\iota_\lambda(x)\ne0$" | True by definition of an inclusion | Immediate |
| Nonzero when $\lambda'_1+\lambda'_2\le n$ | Yes | Asserted before the proof, "Admissibility is what makes $V_\lambda$ nonzero" | The brief's admissibility is exactly the two-column condition |
| Zero when $\lambda'_1+\lambda'_2>n$ | No | Asserted in the side remark on witnesses | Used only for "no nonzero seed exists", which is not part of the lemma |
| Irreducibility | No | Named in Passage C, "the irreducible" | Unused by any step |

### 1.3 Used but unstated, stated but unused

- Used and unstated: the orthonormality of $e_a$, implicit in "invariant metric element" and in $gg^{\mathsf T}$ (withdrawn candidate W3). The field transfer from Weyl's theorem as usually stated to real $V$ (withdrawn candidate W6).
- Stated and unused: irreducibility of $V_\lambda$, the "only if" half of Weyl's theorem, and the specific shape "traceless of symmetry type $\lambda$" beyond giving a nonzero $O(n)$-stable subspace. The lemma holds verbatim for any nonzero equivariant injection $V_\lambda\to V^{\otimes\lvert\lambda\rvert}$.

## 2. Claim 1, equivariance

**The cup.** For $g\in O(n)$ with matrix $(g_{ba})$ in the basis $e_a$, $g\cdot\mathrm{cup}=\sum_a ge_a\otimes ge_a=\sum_a\sum_{b,c}g_{ba}g_{ca}\,e_b\otimes e_c=\sum_{b,c}(gg^{\mathsf T})_{bc}\,e_b\otimes e_c$. Orthogonality gives $gg^{\mathsf T}=I$, so $g\cdot\mathrm{cup}=\mathrm{cup}$. Nothing uses $\det g=1$, so reflections are included as the passage says.

**The seed.** On a pure tensor $u\otimes w_1\otimes\dots\otimes w_k$ with $u\in V^{\otimes\lvert\lambda\rvert}$ and $w_j\in V\otimes V$, the diagonal action on $V^{\otimes12}$ acts factor by factor, so $g\cdot(u\otimes w_1\otimes\dots\otimes w_k)=(g\cdot u)\otimes(g\cdot w_1)\otimes\dots\otimes(g\cdot w_k)$, and this extends to all tensors by linearity, including $\mathrm{cup}$, which is a sum of pure tensors. Hence $g\cdot c_0(x)=g\cdot\iota_\lambda(x)\otimes(g\cdot\mathrm{cup})^{\otimes k}=\iota_\lambda(gx)\otimes\mathrm{cup}^{\otimes k}=c_0(gx)$. The map $x\mapsto\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ is linear because tensoring with a fixed vector is linear. So $c_0\in M_\lambda$. The passage's one-line justification, "the tensor product of the equivariant map $\iota_\lambda$ with invariant vectors is equivariant", is this computation and closes with the slots in the stated order.

No finding.

## 3. Claims 2 to 4, nonvanishing

**Tensor route.** Over a field, $v\otimes w\ne0$ when $v\ne0$ and $w\ne0$ (standard). $\mathrm{cup}$ has coefficient matrix $I_n$ in the basis $e_b\otimes e_c$, nonzero for $n\ge1$, so $\mathrm{cup}^{\otimes k}\ne0$ by induction on $k$, with $\mathrm{cup}^{\otimes0}=1\in\mathbb R$. For $x\ne0$, $\iota_\lambda(x)\ne0$ by injectivity, so $c_0(x)\ne0$. To conclude $c_0\ne0$ one needs some $x\ne0$, which is $V_\lambda\ne0$, which is admissibility through Weyl. The proof block does not name this step, the paragraph before it does (withdrawn candidate W1).

**Contraction route.** Let $\kappa_j$ contract slots $\lvert\lambda\rvert+2j-1$ and $\lvert\lambda\rvert+2j$ with $\langle\cdot,\cdot\rangle$. Applied to $u\otimes\mathrm{cup}^{\otimes j}$ it gives $\big(\sum_a\langle e_a,e_a\rangle\big)u\otimes\mathrm{cup}^{\otimes(j-1)}=n\,u\otimes\mathrm{cup}^{\otimes(j-1)}$. Composing $\kappa_1\circ\dots\circ\kappa_k$ (innermost pair first) gives $n^k\iota_\lambda$ as a map $V_\lambda\to V^{\otimes\lvert\lambda\rvert}$. With $n\ge1$, $n^k\ne0$, and $\iota_\lambda\ne0$ because $V_\lambda\ne0$, so $c_0\ne0$. At $k=0$ the identity reads $\iota_\lambda=1\cdot\iota_\lambda$.

**Claim 4.** $M_\lambda$ is a linear subspace of $\mathop{\mathrm{Hom}}_{\mathbb R}(V_\lambda,V^{\otimes12})$ and its zero is the zero map, so the two readings of "nonzero" coincide.

No finding beyond W1.

## 4. Claims 6 and 7, the partition bound and its witnesses

**The bound.** For each part $p$ of $\lambda$, its contribution to $\lambda'_1+\lambda'_2$ is $[p\ge1]+[p\ge2]=\min(p,2)\le p$. Summing over parts, $\lambda'_1+\lambda'_2\le\sum p=\lvert\lambda\rvert$. The passage's "a part of size $p$ contributes at most $p$" is this, with $\min(p,2)$ left implicit but immediate from the two counting descriptions it gives.

**Consequences.** If $\lvert\lambda\rvert\le n$ then $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert\le n$. For $n\ge12$ and a block label, $\lvert\lambda\rvert\le12\le n$, so every block label is admissible. Sharpness: $(2^6)$ has $\lambda'_1=6$, $\lambda'_2=6$, sum $12$, so it is inadmissible at $n=11$ and the threshold $12$ cannot be lowered.

**Witnesses.** $(2,2)$: $\lambda'_1=2$, $\lambda'_2=2$, sum $4>3\ge2$, inadmissible at $n=2,3$. $(2,1,1)$: $\lambda'_1=3$, $\lambda'_2=1$, sum $4>3$, inadmissible at $n=3$. Both have $\lvert\lambda\rvert=4$, so both are block labels. That their $V_\lambda$ vanish rests on the "only if" half of Weyl, which the lemma does not use. Screen, not evidence: for $(2,2)$ at $n=3$ the traceless tensors with the $(2,2)$ symmetry are the Weyl-curvature-type tensors, classically zero in dimension $3$, consistent with the remark.

No finding beyond W5.

## 5. Claim 8, the seed's description

The padding diagram with $\lvert\lambda\rvert$ through strands followed by $k$ cups is the linear map $P:u\mapsto u\otimes\mathrm{cup}^{\otimes k}$ from $V^{\otimes\lvert\lambda\rvert}$ to $V^{\otimes12}$. Then $P\circ\iota_\lambda=c_0$ identically, so "$\iota_\lambda$ followed by a padding diagram of $k$ cups" is exact. At $\lvert\lambda\rvert=12$, $k=0$, $P=\mathrm{id}$ and $c_0=\iota_\lambda$. At $\lambda=\varnothing$, $k=6$, $\iota_\varnothing=\mathrm{id}_{\mathbb R}$ and $c_0:t\mapsto t\,\mathrm{cup}^{\otimes6}$.

No finding.

## 6. Claim 9, "closed form" in Passages B and C

**Record.**

1. Locate. Passage A says "every block has a seed in closed form **relative to $\iota_\lambda$**" and "Where $\lvert\lambda\rvert=12$, … there the content is Weyl's construction". Passage B's statement ends "so the seed of every block is given in closed form and need not be searched for". Passage C's landscape line says "so it is constructed rather than searched for" and its detail says "The lemma removes a search from the certificate pipeline". B and C carry no qualifier. The claim needs $\iota_\lambda$ to be explicit, and no passage argues that.
2. Exhibit. Take any $\lambda$ with $\lvert\lambda\rvert=12$, for instance $(2^6)$ at $n=12$. Then $k=0$ and $c_0=\iota_\lambda$, so B's "given in closed form and need not be searched for" is at this label precisely the assertion that $\iota_\lambda$ is given in closed form. The lemma proves $c_0\ne0$ and $c_0\in M_\lambda$, and proves nothing about how $\iota_\lambda$ is obtained. Weyl's construction presents $V_\lambda$ as the image of $c_\lambda$ on a subspace cut out by the vanishing of all contractions, and producing a basis of that subspace, which is what writing $\iota_\lambda$ down requires, is not carried out or cited as explicit in any passage.
3. Argue the opposite. The charitable reading is that B and C mean "closed form given Weyl's construction", which is what A says, and that Weyl's construction is itself a construction rather than a search. That reading is available only by importing A's qualifier, which the canonical statements in B and C omit. The mathematical content of the lemma is untouched either way.

**Survives.** HYPOTHESIS-DEBT on the gloss, not on the lemma. What would discharge it: either restore "relative to $\iota_\lambda$" in B and in both lines of C, or cite a statement that Weyl's construction yields $\iota_\lambda$ explicitly (a spanning set of the traceless subspace of symmetry type $\lambda$) for every $n\ge1$ and every admissible $\lambda$ with $\lvert\lambda\rvert\le12$.

## 7. Claim 10, the realisation theorem

Passage A states the theorem's requirement as "one nonzero seed per block generates that block", and identifies a seed with "a nonzero element of $\mathop{\mathrm{Hom}}(V_\lambda,V^{\otimes12})$". The lemma supplies a nonzero element of $M_\lambda$ for every admissible block label and every $n\ge1$. That matches the requirement as A states it. The theorem itself is not quoted in the brief, so any further hypothesis it carries (on $n$, or on what "generates" acts with) is outside what I can check, and the lemma does not claim to check it.

No finding within the brief. See W7 for the missing subscript.

## 8. Claim 11, Passages B and C against Passage A

| Item | A | B | C (landscape) | C (detail) |
|---|---|---|---|---|
| Range of $n$ | $n\ge1$ | $n\ge1$ | $n\ge1$ | $n\ge1$ |
| Admissibility | $\lambda'_1+\lambda'_2\le n$ | "$O(n)$-admissible" | "$O(n)$-admissible" | "$O(n)$-admissible" |
| Size | $\{0,2,\dots,12\}$ | same | same | same |
| $\iota_\lambda$ | Weyl's traceless tensors | "the inclusion" | "the inclusion" | "the inclusion of the irreducible" |
| Conclusion | nonzero element of $M_\lambda$ | nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}$ | nonzero $O(n)$-equivariant map | nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}$ |
| Closed form | "relative to $\iota_\lambda$" | unqualified | "constructed rather than searched for" | "removes a search" |
| $\lvert\lambda\rvert\le n$ gives admissible | yes, argued | yes, stated | yes, stated | yes, with $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ |

The conclusions are equivalent (W8 for "map" without "linear"). The definite article on the inclusion is W4. The one surviving difference is the dropped qualifier of section 6.

## 9. Claim 12, the Lean declarations

What each declaration states, over which types:

| Declaration | Statement | Relation to the lemma |
|---|---|---|
| L65Statement.legs, Seed.cups_wellposed | for $f\le12$ even, $2\lfloor(12-f)/2\rfloor+f=12$ | the slot count $\lvert\lambda\rvert+2k=12$, true |
| no_cup_iff | under the same hypotheses, $k=0\iff f=12$ | the $\lvert\lambda\rvert=12$ case, true, and the evenness hypothesis is needed (at $f=11$ the natural-number quotient is $0$) |
| tprod_map_equivariant | for any group $G$ and real representations, the tensor product of two equivariant linear maps is equivariant for Representation.tprod | the abstract step, true. To reach $c_0$ one would take the second map to be $\mathbb R\to(V\otimes V)^{\otimes k}$, $t\mapsto t\,\mathrm{cup}^{\otimes k}$, whose equivariance hypothesis is exactly cup invariance, which is not typed |
| seed_ne_zero | if $\mathrm{cap}\circ c_0=\mathrm{nk}\cdot\iota$ with $\mathrm{nk}\ne0$ and $\iota\ne0$, then $c_0\ne0$, with $\iota$ typed Vlam $\to$ Vlam and cap typed $T\to$ Vlam | true as typed, but the typing does not match the passage (finding L1 below) |
| no_seed_of_trivial | every linear map out of a subsingleton module is $0$ | the "no nonzero seed" remark, true, with no link from inadmissibility to $V_\lambda=0$ |
| rows, rows2, Admissible, admissible | on List ℕ, the counts of parts $>0$ and $\ge2$, and their sum $\le n$ | matches $\lambda'_1$ and $\lambda'_2$ for any list, including unsorted lists and lists with zeros |
| admissibility_witnesses, fails_* | the three inadmissibility facts | arithmetic of section 4, true |
| admissibility_tight, tight_conj, tight_size | $(2^6)$ gives $12$ and sums to $12$ | true |
| Seed.conj_le_size | for every list, rows + rows2 $\le$ sum | the partition bound, stated in full generality, and the case split $p=0$, $p=1$, $p\ge2$ is the $\min(p,2)\le p$ argument |
| admissible_of_size_le | sum $\le n$ gives admissible at $n$ | "admissibility holds whenever $\lvert\lambda\rvert\le n$", stated for all $n$ |
| admissible_in_range | sum $\le12$ gives admissible at $12$ | the $n=12$ case only (W9) |
| witnesses_exceed | $(2,2)$ and $(2,1,1)$ sum to $4$ | true |
| leg_count | $3\cdot4=12$ | no counterpart in Passages A to C |
| diagram_failure_share | $64<71<80$ | no counterpart in Passages A to C |
| the two examples | instantiate seed_ne_zero and tprod_map_equivariant on $\mathbb R$ with identities and trivial representations | sanity instances only |

Untyped: $O(n)$, $V=\mathbb R^n$, $\mathrm{cup}$ and its invariance, $V^{\otimes12}$ with the diagonal action, $V_\lambda$, Weyl's construction, $\iota_\lambda$, $M_\lambda$, the contraction identity, and "admissible implies $V_\lambda\ne0$". I did not build the files. Passage A cites [L65.lean](../lean/HamiltonsCubic/Results/L65.lean) only for the partition bound, and that bound is what Seed.conj_le_size and admissible_of_size_le state, so the record's citation is accurate.

**Finding L1, record.**

1. Locate. seed_ne_zero binds `(iota : Vlam →ₗ[ℝ] Vlam)` and `(cap : T →ₗ[ℝ] Vlam)`. Passage A's identity is "contracting all $k$ cups returns $n^k\iota_\lambda$" with $\iota_\lambda:V_\lambda\to V^{\otimes\lvert\lambda\rvert}$, so the contraction is a map $V^{\otimes12}\to V^{\otimes\lvert\lambda\rvert}$.
2. Exhibit. At $n=2$, $\lambda=(2)$, $V_\lambda$ is the traceless symmetric part of $V^{\otimes2}$, of dimension $2$, while $V^{\otimes2}$ has dimension $4$. The passage's cap has codomain $V^{\otimes2}\ne V_\lambda$ and its $\iota_\lambda$ is not an endomorphism, so the identity is not an instance of seed_ne_zero with Vlam $:=V_\lambda$.
3. Argue the opposite. Composing the contraction with the orthogonal projection of $V^{\otimes\lvert\lambda\rvert}$ onto $V_\lambda$ gives $\mathrm{cap}'\circ c_0=n^k\,\mathrm{id}_{V_\lambda}$, which is an instance with $\iota:=\mathrm{id}$. That route uses a projection no passage mentions and replaces $\iota_\lambda$ by the identity, so the declaration still does not state the passage's identity. The record never claims that Lean formalises the lemma.

**Survives** as a coverage observation on Passage D. No claim of the record is broken by it. The natural generalisation (a third module $U$ with $\iota:\mathrm{Vlam}\to U$ and $\mathrm{cap}:T\to U$) would match the passage.

## 10. Claim 13, the boundary

- $n=1$. Admissible block labels satisfy $\lambda'_1+\lambda'_2\le1$ with $\lvert\lambda\rvert$ even, so only $\lambda=\varnothing$. Then $k=6$, $\mathrm{cup}=e_1\otimes e_1$, $c_0:t\mapsto t\,e_1^{\otimes12}\ne0$, and $O(1)=\{\pm1\}$ acts on it by $(\pm1)^{12}=1$. Hypotheses hold and the conclusion holds.
- $n=0$, outside the statement. The conclusion fails at $\lambda=\varnothing$ (section 1.1), so $n\ge1$ is load-bearing there and nowhere else.
- $\lambda=\varnothing$, $k=6$. $V^{\otimes0}=\mathbb R$ has no contractions, so $V_\varnothing=\mathbb R$ with trivial action and $\iota_\varnothing=\mathrm{id}$. The contraction route returns $n^6\ne0$.
- $\lvert\lambda\rvert=12$, $k=0$. $c_0=\iota_\lambda$, admissibility forces $n\ge1$, and the lemma's content is Weyl's theorem, as Passage A says.
- Odd $n$. Nothing in sections 2 and 3 depends on parity. $-I\in O(n)$ acts by $(-1)^{\lvert\lambda\rvert}=1$ on $V_\lambda$ and by $1$ on $V^{\otimes12}$, consistent with a nonzero $M_\lambda$ for even $\lvert\lambda\rvert$.
- Admissible with $\lvert\lambda\rvert>n$. $n=2$, $\lambda=(4)$: $\lambda'_1+\lambda'_2=2\le2$ and $\lvert\lambda\rvert=4>2$. The lemma's hypothesis is admissibility, so this label is covered, and B and C present $\lvert\lambda\rvert\le n$ only as a sufficient condition. Screen, not evidence: $V_{(4)}$ at $n=2$ is the harmonic quartics, spanned by the real and imaginary parts of $(x+iy)^4$, nonzero.
- $SO(n)$. The lemma is stated for $O(n)$. $SO(n)\subseteq O(n)$, so $c_0$ is also $SO(n)$-equivariant and nonzero, but $V_\lambda$ can restrict reducibly, so the $O(n)$ block and the $SO(n)$ blocks differ. The passages make no $SO(n)$ claim, and "reflections included" confirms the group is $O(n)$.

## 11. The standing list

1. **Hypothesis inventory.** Section 1. Every stated hypothesis is used, $n\ge1$ only at $\lambda=\varnothing$. Irreducibility and the "only if" half of Weyl are stated and unused, which is harmless. Nothing is used and unstated beyond W3 and W6.
2. **Quantifier order and scope.** For all $n\ge1$, for all $\lambda$ admissible at that $n$ with the size condition, with $\iota_\lambda$ fixed by Weyl's construction at $(n,\lambda)$, the element $c_0$ is nonzero in $M_\lambda$. $k$ depends on $\lambda$ alone. The existential "every block has a seed" is witnessed by $c_0$ itself. No inversion.
3. **Range edges.** Section 10: $n=1$, $\lambda=\varnothing$, $\lvert\lambda\rvert=12$ and odd $n$ all pass, the smallest dimension $n=1$ admits one label.
4. **Proven against used.** The lemma is proven on admissible block labels and used on blocks, which exist only for those labels (W2). The partition bound is proven for all partitions and used for all. The one gap is the gloss of section 6.
5. **Lean.** Section 9. The partition bound is stated with the right binders over List ℕ. The seed lemma is not stated, and seed_ne_zero's types differ from the passage (L1).

The traps by name: range boundaries, section 10, no failure. Subfamily used in general, W2 and W9, withdrawn. Hypothesis stated but unused, irreducibility and Weyl's "only if", harmless. Hypothesis used but unstated, W1, W3, W6, withdrawn. Universal claim with no witness: every universal claim is either argued (sections 2 to 5) or rests on Weyl's classical theorem, and the negative witnesses of section 4 are exhibited. Imported theorem whose hypotheses were never checked: Weyl's condition is checked against the brief's admissibility in section 1.2 and matches, and the realisation theorem is checked against the one requirement quoted (section 7).

## 12. The brief's items 1 to 11

1. **Hypotheses.** $n\ge1$ is used for $\mathrm{cup}\ne0$ and $n^k\ne0$ and is necessary at $\lambda=\varnothing$. Admissibility is used for $V_\lambda\ne0$. The size condition is used for $k\in\{0,\dots,6\}$. No step uses an unstated hypothesis beyond W3 and W6.
2. **Weyl's construction.** Realisation as traceless tensors of type $\lambda$ is cited by name. Equivariance of $\iota_\lambda$ is assumed as part of that citation. Injectivity holds by definition. Nonvanishing for admissible $\lambda$ is asserted with the citation. The "exactly" direction (vanishing for inadmissible $\lambda$) is not used by the lemma, only by the remark that no seed exists for inadmissible labels. No precise reference is filed.
3. **Equivariance.** Confirmed in section 2, reflections included, slots in the stated order.
4. **Nonvanishing.** Both routes confirmed in section 3, and "nonzero in $M_\lambda$" equals "nonzero as a map".
5. **Partition bound.** Confirmed in section 4, with all three witnesses and the equality at $(2^6)$ (W5 on uniqueness).
6. **$n\ge12$ and $\lvert\lambda\rvert\le n$.** Both confirmed in section 4, and the threshold $12$ is sharp.
7. **The seed's description.** "$\iota_\lambda$ followed by $k$ padding cups" is exact, and at $\lvert\lambda\rvert=12$ the seed is $\iota_\lambda$. "Relative to $\iota_\lambda$" in A is accurate. "Given in closed form" and "constructed rather than searched for" in B and C drop that qualifier and are HYPOTHESIS-DEBT (section 6).
8. **Realisation theorem.** The lemma supplies the nonzero seed per block that Passage A says the theorem needs (section 7).
9. **B and C against A.** Section 8: same range, same hypotheses, equivalent conclusions, one dropped qualifier.
10. **Lean against A to C.** Section 9: arithmetic and the partition bound are stated faithfully, the representation-theoretic lemma is untyped, and seed_ne_zero's typing differs from the passage (L1).
11. **Boundary.** Section 10: $n=1$, $\lambda=\varnothing$, $\lvert\lambda\rvert=12$, odd $n$, $(4)$ at $n=2$ and $SO(n)$ all handled, with no failure inside the statement's range.

## 13. Withdrawn candidates

### W1. The proof block never invokes $V_\lambda\ne0$

1. Locate: "For $x\ne0$, $\iota_\lambda(x)\ne0$ … so $\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ … is nonzero" shows $c_0(x)\ne0$ for each $x\ne0$, and "$n^k\iota_\lambda\ne0$" needs $\iota_\lambda\ne0$. Both need $V_\lambda\ne0$.
2. Exhibit: at an inadmissible label such as $(2,2)$ at $n=3$, every sentence of the proof block still reads as written, yet $c_0=0$ because $V_\lambda=0$.
3. Opposite: the paragraph immediately before the proof states "Admissibility is what makes $V_\lambda$ nonzero", and the lemma's hypothesis includes admissibility. **Withdrawn**: the step is present in the section, one paragraph earlier.

### W2. "Every block" ranges over block labels, which include inadmissible ones

1. Locate: A, "So every block has a seed in closed form", B, "the seed of every block". The brief's definition of block label carries no admissibility.
2. Exhibit: $n=2$, $\lambda=(2,2)$ is a block label, $V_\lambda=0$, and no nonzero seed exists.
3. Opposite: A says outright that for such a label "no nonzero seed exists", and B's sentence follows a statement hypothesised on admissibility. A label with $V_\lambda=0$ indexes no summand of $V^{\otimes12}$, so there is no block to seed. **Withdrawn.**

### W3. The basis $e_a$ is undefined

1. Locate: "$\mathrm{cup}=\sum_a e_a\otimes e_a$".
2. Exhibit: for a non-orthonormal basis, say $f_1=e_1$, $f_2=2e_2$ at $n=2$, $\sum_a f_a\otimes f_a$ has coefficient matrix $\mathop{\mathrm{diag}}(1,4)$, and the rotation by a quarter turn sends it to $\mathop{\mathrm{diag}}(4,1)$, which is not invariant.
3. Opposite: the passage calls it "the invariant metric element" and computes with $gg^{\mathsf T}$, which presupposes an orthonormal basis. **Withdrawn.**

### W4. "The inclusion" with a definite article

1. Locate: B and C, "the inclusion", C, "the inclusion of the irreducible into the tensor power".
2. Exhibit: $V_{(2,1)}$ occurs in $V^{\otimes3}$ once for each standard tableau of shape $(2,1)$, so twice, and there is no unique inclusion.
3. Opposite: A fixes the inclusion through Weyl's construction, and the lemma's proof holds for every equivariant injection $V_\lambda\to V^{\otimes\lvert\lambda\rvert}$. **Withdrawn.**

### W5. Equality at $(2^6)$ is not unique

1. Locate: "with equality $\lambda'_1+\lambda'_2=12$ at $\lambda=(2,2,2,2,2,2)$".
2. Exhibit: $(1^{12})$ gives $12+0=12$, and every $\lambda\vdash12$ with parts at most $2$ attains equality.
3. Opposite: the sentence names an instance and makes no uniqueness claim, and one instance is all that sharpness of $n\ge12$ needs. **Withdrawn.**

### W6. Weyl's theorem is often stated over $\mathbb C$, and $V$ is real

1. Locate: "$V=\mathbb R^n$" against the citation of Weyl's construction.
2. Exhibit: a real statement is needed, $V_\lambda\ne0$ as a real space.
3. Opposite: the traceless subspace and the Young symmetrizer are cut out and defined by linear maps with rational coefficients, so the real construction complexifies to the complex one and the two have the same dimension. Weyl's own treatment covers the real orthogonal group. **Withdrawn.**

### W7. $\mathop{\mathrm{Hom}}$ without the subscript $O(n)$

1. Locate: A's opening paragraph, "a nonzero element of $\mathop{\mathrm{Hom}}(V_\lambda,V^{\otimes12})$".
2. Exhibit: the unrestricted $\mathop{\mathrm{Hom}}_{\mathbb R}$ is trivially nonzero, so read literally the search problem would be empty.
3. Opposite: the lemma and every later line use $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}$. **Withdrawn.**

### W8. "Nonzero $O(n)$-equivariant map" omits "linear"

1. Locate: C landscape line.
2. Exhibit: a nonlinear equivariant map would not lie in $M_\lambda$.
3. Opposite: $c_0$ is linear (section 2), and C's detail line says "element of $\mathop{\mathrm{Hom}}_{O(n)}$". **Withdrawn.**

### W9. Lean states the $n=12$ case while A says $n\ge12$

1. Locate: admissible_in_range concludes admissible 12, against A's "at $n\ge12$ every block label is admissible".
2. Exhibit: no declaration has conclusion admissible $n$ for $n\ge12$ with hypothesis sum $\le12$.
3. Opposite: A cites Lean only for "every label with $\lvert\lambda\rvert\le n$ is admissible", which admissible_of_size_le states for every $n$, and the $n\ge12$ sentence is derived in prose from it. **Withdrawn.**

## 14. What would break it

- A falsifier would be an $n\ge1$ and an admissible $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ where $c_0=0$ or $c_0\notin M_\lambda$. Equivariance holds for every $g$ with $gg^{\mathsf T}=I$ by section 2, so the only route is $V_\lambda=0$ at an admissible label, which contradicts Weyl's theorem.
- A falsifier of the hypothesis set would be a range edge where a hypothesis is load-bearing and fails. I checked $n=0$ (outside the statement, fails at $\lambda=\varnothing$, confirming $n\ge1$ is needed), $n=1$, $\lambda=\varnothing$, $\lvert\lambda\rvert=12$, odd $n$ and $(4)$ at $n=2$, and none breaks the statement.
- A falsifier of the partition bound would be a part contributing more than its size to $\lambda'_1+\lambda'_2$. A part contributes $\min(p,2)$, so none exists.
- What would break the canonical statements is the reading in section 6: a label where $\iota_\lambda$ is not available explicitly would falsify "given in closed form". I found no argument either way in the passages and constructed no such label.

## 15. Verdict

**PROVEN**

The lemma as stated in Passages A, B and C holds for every $n\ge1$ and every admissible block label, on the strength of Weyl's classical theorem that admissible labels give nonzero $O(n)$-stable subspaces of $V^{\otimes\lvert\lambda\rvert}$, cited by name in Passage A. The hypotheses need no correction. Two items are owed and neither touches the conclusion: B and C should restore Passage A's "relative to $\iota_\lambda$" (section 6), and seed_ne_zero types $\iota$ as an endomorphism where the passage's $\iota_\lambda$ is not one (section 9, L1). I staged only this report. The session's opening snapshot showed [plan-verification.md](../plan-verification.md), [BRIEF_L65r2.md](BRIEF_L65r2.md) and [ROUND_L65r2.md](ROUND_L65r2.md) staged by other work, and by the time of my commit the index held no file other than this report.
