# Verifier v398, Lemma L65: the seed $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero element of $M_\lambda$, the partition bound $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$, its witnesses, and the Lean declarations

The brief was cold and I worked from its definitions and quoted passages only, opening no other file in the repository. No numerical work was done and every value below is exact. No scripts were written and no Lean build was run, so the Lean files are assessed as statements, not as compiled proofs. Hand screens on constructed objects are reported as screens, never as evidence for a positive claim. The log is at agent_logs/verify-L65-v398.log.

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | $\mathrm{cup}$ is $O(n)$-invariant | CONFIRMED | coefficient matrix of $g\cdot\mathrm{cup}$ is $gg^{\mathsf T}=I$ |
| 2 | $x\mapsto\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ is $O(n)$-equivariant into $V^{\otimes12}$ | CONFIRMED | diagonal action factors over consecutive slot blocks, $\lvert\lambda\rvert+2k=12$ |
| 3 | $c_0\ne0$ by the tensor-product argument | CONFIRMED | needs $V_\lambda\ne0$, supplied by the admissibility paragraph and Weyl's theorem |
| 4 | Contraction of all $k$ cups returns $n^k\iota_\lambda$ | CONFIRMED AS ALGEBRA | each cup's own pair contracts to $n$, $n^k\ne0$ for $n\ge1$ |
| 5 | Nonzero in $M_\lambda$ equals nonzero as a map | CONFIRMED | $M_\lambda$ is a linear subspace of maps with the zero map as zero |
| 6 | Admissible $\Rightarrow V_\lambda\ne0$ with $\iota_\lambda$ injective and equivariant | CONFIRMED | classical Weyl theorem, named as "classical, unfiled", assumed without a reference |
| 7 | $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$, hence admissible whenever $\lvert\lambda\rvert\le n$, hence every block label at $n\ge12$ | CONFIRMED | each part $p$ contributes $\min(p,2)\le p$ |
| 8 | Witnesses $(2,2)$ at $n=2,3$ and $(2,1,1)$ at $n=3$ are non-admissible with zero space, equality at $(2^6)$ | CONFIRMED | arithmetic exact, zero spaces rest on the "only if" half of Weyl, consistent with hand screens |
| 9 | "The seed of every block is given in closed form and need not be searched for" (B), "constructed rather than searched for" (C) | HYPOTHESIS-DEBT | B and C drop Passage A's qualifier "relative to $\iota_\lambda$", and no passage says how $\iota_\lambda$ is obtained explicitly |
| 10 | "The realisation theorem applies to it" | CONFIRMED | Passage A says the theorem needs one nonzero seed per block, the lemma supplies it, the theorem itself is not quoted |
| 11 | Passages B and C state the same result as A | CONFIRMED | same hypotheses and range, "nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}$" equals "nonzero $O(n)$-equivariant map" |
| 12 | The Lean files state L65 | HYPOTHESIS-DEBT | only arithmetic and two generic linear-algebra shapes are typed, and seed_ne_zero types iota as an endomorphism of Vlam, unlike $\iota_\lambda$ |

**Summary: Lemma L65 is proven as stated for every $n\ge1$ and every $O(n)$-admissible $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, given the classical Weyl theorem, and the round should act on two non-mathematical debts: restore "relative to $\iota_\lambda$" to the closed-form rider in Passages B and C, and record that the Lean files do not state the lemma (their seed_ne_zero is typed with an endomorphism iota and cannot take the contraction identity as written).**

## 0. Conventions, fixed once

Quoted from the brief:

- "$V=\mathbb R^n$ with the standard action of $O(n)$, and $V^{\otimes m}$ with the diagonal action $g\cdot(v_1\otimes\dots\otimes v_m)=gv_1\otimes\dots\otimes gv_m$ and the induced inner product."
- "A **block label** is a partition $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. $\lambda'$ is the conjugate partition, so $\lambda'_1$ is the number of nonzero parts of $\lambda$ and $\lambda'_2$ the number of parts of size at least $2$. $\lambda$ is **$O(n)$-admissible** when $\lambda'_1+\lambda'_2\le n$."
- "$V_\lambda$ is the $O(n)$-representation labelled by $\lambda$, and $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$."
- From Passage A: $k=(12-\lvert\lambda\rvert)/2$, $\iota_\lambda:V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ "the inclusion given by Weyl's construction of $V_\lambda$ as the traceless tensors of symmetry type $\lambda$", and $\mathrm{cup}=\sum_a e_a\otimes e_a\in V\otimes V$.

Throughout, $e_1,\dots,e_n$ is the standard orthonormal basis and $ge_a=\sum_b g_{ba}e_b$.

## 1. Hypothesis inventory

### 1.1 Hypotheses of the statement

| Hypothesis | Where it is used | Load-bearing? |
|---|---|---|
| $n\ge1$ | $\mathrm{cup}\ne0$ in the tensor-product argument, $n^k\ne0$ in the contraction argument | Yes. At $n=0$ the label $\varnothing$ is admissible ($0+0\le0$), $V_\varnothing=\mathbb R$, but $V=0$ so $V^{\otimes12}=0$ and $c_0=0$. Without $n\ge1$ the statement is false. |
| $\lambda$ is $O(n)$-admissible | $V_\lambda\ne0$, needed so that some $x\ne0$ exists and $\iota_\lambda\ne0$ | Yes. Used in the bold paragraph "Admissibility is what makes $V_\lambda$ nonzero", placed between the statement and the proof. The proof paragraph itself says "For $x\ne0$, $\iota_\lambda(x)\ne0$" and never names the existence of such an $x$ (see 11.1). |
| $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ | $k$ is a nonnegative integer and $\lvert\lambda\rvert+2k=12$, so $c_0$ lands in $V^{\otimes12}$ | Yes. Odd $\lvert\lambda\rvert$ gives non-integer $k$, and $\lvert\lambda\rvert>12$ gives $k<0$. |

No step uses a hypothesis that is not stated, once Weyl's theorem (1.2) is admitted as the standard import. No stated hypothesis is unused.

### 1.2 The imported theorem

The passages import "Weyl's construction of $V_\lambda$ as the traceless tensors of symmetry type $\lambda$ (classical, unfiled)". The statement I rely on, as standard mathematics, is the following, recalled from Fulton and Harris, Representation Theory, §19.5 (their Theorem 19.19 in my recollection, not checked against the text): for $d=\lvert\lambda\rvert$, let $V^{[d]}\subset V^{\otimes d}$ be the intersection of the kernels of all pairwise contractions and let $c_\lambda$ be a Young symmetrizer of shape $\lambda$. Then $V_{[\lambda]}=V^{[d]}\cap c_\lambda V^{\otimes d}$ is an irreducible representation of the orthogonal group, and it is zero exactly when $\lambda'_1+\lambda'_2>n$. The source states it over $\mathbb C$.

What the proof needs from it, and its status in the passages:

| Needed fact | Object it is applied to | Status in the passages |
|---|---|---|
| $V_\lambda$ is realised as a subspace of $V^{\otimes\lvert\lambda\rvert}$ | $V_\lambda$ labelled as in the definitions | Assumed ("given by Weyl's construction"). The labelling convention of the definitions, admissible meaning $\lambda'_1+\lambda'_2\le n$, is Weyl's, so the identification of the abstract $V_\lambda$ with Weyl's subspace is consistent. |
| $\iota_\lambda$ is injective | the inclusion | Built into the word "inclusion" and the symbol $\hookrightarrow$. |
| $\iota_\lambda$ is $O(n)$-equivariant | the inclusion | Assumed, not argued. It holds because contractions commute with the diagonal action and $c_\lambda$ acts by slot permutations, so the subspace is $O(n)$-stable. This is standard and the passages say nothing about it. |
| admissible $\Rightarrow V_\lambda\ne0$ | every admissible block label | Asserted ("Admissibility is what makes $V_\lambda$ nonzero"), attributed to Weyl, no reference. This is the direction the lemma uses. |
| non-admissible $\Rightarrow$ zero space | $(2,2)$ at $n=2,3$, $(2,1,1)$ at $n=3$ | Asserted ("Weyl's construction gives the zero space"). Used only in the remark about witnesses, never in the lemma. |
| Transfer from $\mathbb C$ to $\mathbb R$ | $V=\mathbb R^n$, $O(n)$ real | Not addressed. It is standard (the contractions and $c_\lambda$ have rational coefficients, so the real and complex subspaces have equal dimension), and I rely on it as such. It changes no value. |

Hypotheses of the import checked against the object: $V$ carries the standard nondegenerate symmetric form, the group is the full orthogonal group of that form, $d=\lvert\lambda\rvert\le12$, $\lambda$ is a partition. All match.

Finding, graded as a citation note rather than a gap: the one non-trivial input of the lemma is named but carries no reference on file. The lemma is otherwise a two-line consequence of it.

## 2. Equivariance (brief items 3 and 1)

The passage: "$g\cdot\mathrm{cup}=\sum_a ge_a\otimes ge_a$ has coefficient matrix $gg^{\mathsf T}=I$ for every $g\in O(n)$, reflections included."

Following the algebra: $\sum_a ge_a\otimes ge_a=\sum_a\sum_{b,c}g_{ba}g_{ca}\,e_b\otimes e_c=\sum_{b,c}(gg^{\mathsf T})_{bc}\,e_b\otimes e_c$. For $g\in O(n)$, $g^{\mathsf T}g=I$ is equivalent to $gg^{\mathsf T}=I$ for square matrices, so the coefficient matrix is $I$ and $g\cdot\mathrm{cup}=\mathrm{cup}$. The computation uses only orthogonality, so determinant $-1$ is covered. The step closes.

The passage: "the tensor product of the equivariant map $\iota_\lambda$ with invariant vectors is equivariant." Under the associativity identification $V^{\otimes12}=V^{\otimes\lvert\lambda\rvert}\otimes(V\otimes V)^{\otimes k}$, with $\iota_\lambda$ on slots $1,\dots,\lvert\lambda\rvert$ and the $j$-th cup on slots $\lvert\lambda\rvert+2j-1,\lvert\lambda\rvert+2j$, the diagonal action on pure tensors is the tensor product of the diagonal actions on these consecutive blocks. Hence $g\cdot(\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k})=(g\cdot\iota_\lambda(x))\otimes(g\cdot\mathrm{cup})^{\otimes k}=\iota_\lambda(gx)\otimes\mathrm{cup}^{\otimes k}$, using equivariance of $\iota_\lambda$ (assumed, 1.2) and invariance of cup. The map is linear in $x$. The slots are in the stated order and the total count $\lvert\lambda\rvert+2k=12$ uses the range hypothesis. The step closes.

No finding.

## 3. Nonvanishing (brief item 4)

The passage: "For $x\ne0$, $\iota_\lambda(x)\ne0$, and $\mathrm{cup}\ne0$ because $n\ge1$, so $\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ is a tensor product of nonzero vectors and is nonzero."

- $\iota_\lambda(x)\ne0$ for $x\ne0$ is injectivity.
- $\mathrm{cup}\ne0$ for $n\ge1$: its coefficient matrix is $I_n\ne0$.
- Over a field, $u\ne0$ and $w\ne0$ give $u\otimes w\ne0$, and induction over the $k+1$ factors gives the claim.

This shows $c_0(x)\ne0$ for every $x\ne0$, which is injectivity of $c_0$. The conclusion $c_0\ne0$ further needs some $x\ne0$, which is $V_\lambda\ne0$, supplied by admissibility through Weyl (1.2). The chain reaches the stated conclusion.

The contraction version: let $\epsilon_j:V^{\otimes(\lvert\lambda\rvert+2j)}\to V^{\otimes(\lvert\lambda\rvert+2j-2)}$ apply $\langle\cdot,\cdot\rangle$ to the last two slots. Then $\epsilon_j(u\otimes\mathrm{cup})=u\cdot\sum_a\langle e_a,e_a\rangle=n\,u$. Composing $\epsilon_1\circ\dots\circ\epsilon_k$ with $c_0$ gives $n^k\iota_\lambda$. Since $n\ge1$, $n^k\ge1$ is nonzero, and $\iota_\lambda\ne0$ because $V_\lambda\ne0$ and $\iota_\lambda$ is injective. At $k=0$ the composite is the identity and $n^0=1$. The algebra closes. The word "Equivalently" introduces a second argument for the same conclusion rather than an equivalent statement, which is harmless.

"Nonzero in $M_\lambda$ and nonzero as a map are the same statement": $M_\lambda$ is a linear subspace of $\mathop{\mathrm{Hom}}_{\mathbb R}(V_\lambda,V^{\otimes12})$ whose zero is the zero map. Confirmed, and $c_0\in M_\lambda$ by section 2.

No finding beyond 11.1.

## 4. The partition bound and its witnesses (brief items 5 and 6)

The passage: "$\lambda'_1$ counts the nonzero parts and $\lambda'_2$ the parts of size at least two, so a part of size $p$ contributes at most $p$ to $\lambda'_1+\lambda'_2$."

A part $p\ge1$ contributes $1$ to $\lambda'_1$ and, if $p\ge2$, $1$ to $\lambda'_2$, so it contributes $\min(p,2)\le p$. Summing over parts, $\lambda'_1+\lambda'_2\le\sum p=\lvert\lambda\rvert$. Confirmed. Hence $\lvert\lambda\rvert\le n$ implies admissibility, and since every block label has $\lvert\lambda\rvert\le12$, every block label is admissible at $n\ge12$. Passages B and C state the sufficient direction only ("holds whenever"), which is what is proven.

Equality: at $(2^6)$, $\lambda'_1=6$ and $\lambda'_2=6$, sum $12$. Confirmed. So at $n=11$ the label $(2^6)$ is not admissible and $n\ge12$ is the sharp threshold for "every block label is admissible".

Witness arithmetic: $(2,2)$ has $\lambda'_1+\lambda'_2=2+2=4>3\ge2$, and $(2,1,1)$ has $3+1=4>3$. Confirmed.

Zero spaces, hand screens only, realising symmetry type $\lambda$ by tensors antisymmetric in the column slots (an isomorphic image of the Young symmetrizer, with tracelessness preserved):

- $(2,2)$ at $n=2$: the column-antisymmetric space is $\Lambda^2\otimes\Lambda^2$, one-dimensional, spanned by $\varepsilon_{ac}\varepsilon_{bd}$. Contracting slots $a,b$ gives $\sum_i\varepsilon_{ic}\varepsilon_{id}=\delta_{cd}\ne0$. No nonzero traceless element.
- $(2,2)$ at $n=3$: write elements as $\varepsilon_{acp}\varepsilon_{bdq}A_{pq}$ with $A$ symmetric. Contracting $a,b$ gives $\delta_{cd}\mathop{\mathrm{tr}}A-A_{dc}$. Vanishing forces $A=(\mathop{\mathrm{tr}}A)I$, so $\mathop{\mathrm{tr}}A=3\mathop{\mathrm{tr}}A$, so $A=0$.
- $(2,1,1)$ at $n=3$: elements $\varepsilon_{abc}v_d$, and contracting $a,d$ gives $\varepsilon_{dbc}v_d$, the Hodge dual of $v$, nonzero for $v\ne0$.

All three screens agree with "Weyl's construction gives the zero space". They are screens, and the claim rests on the classical theorem.

No finding. Candidate 11.3 on uniqueness of the equality case is withdrawn.

## 5. The seed's description and the closed-form rider (brief item 7)

"The seed is $\iota_\lambda$ followed by a padding diagram of $k$ cups": $c_0=(\mathrm{id}_{V^{\otimes\lvert\lambda\rvert}}\otimes\mathrm{cup}^{\otimes k})\circ\iota_\lambda$, the padding being the Brauer diagram from $\lvert\lambda\rvert$ to $12$ points with $\lvert\lambda\rvert$ through-strands and $k$ adjacent cups at the end. Confirmed. At $\lvert\lambda\rvert=12$, $k=0$, $\mathrm{cup}^{\otimes0}=1\in\mathbb R$ and $c_0=\iota_\lambda$. Confirmed, and Passage A says so: "there the content is Weyl's construction."

### 5.1 Candidate: the closed-form rider in B and C is unargued

1. **Location.** Passage A says "every block has a seed in closed form **relative to $\iota_\lambda$**". Passage B says "so the seed of every block is given in closed form and need not be searched for". Passage C landscape says "so it is constructed rather than searched for", and C detail says "The lemma removes a search from the certificate pipeline". The qualifier "relative to $\iota_\lambda$" is dropped in B and C, and no passage states how $\iota_\lambda$ is obtained as an explicit object (a basis of $V^{[d]}\cap c_\lambda V^{\otimes d}$, or one nonzero vector of it).
2. **Concrete exhibit.** Take $\lambda=(2^6)$ at $n=12$, so $k=0$ and $c_0=\iota_\lambda$. Passage A's own motivation says "finding a nonzero element of $\mathop{\mathrm{Hom}}(V_\lambda,V^{\otimes12})$ is the same construction problem the item started with". At this $\lambda$ the lemma returns exactly that element as an input, so any claim that the search is removed is exactly as strong as the claim that $\iota_\lambda$ itself is obtained without search. The passages cite Weyl for the existence and nonvanishing of the subspace and say nothing about producing its elements.
3. **Charitable reading.** "Closed form" may mean "a formula in terms of the classical object $\iota_\lambda$", which is true, and the author may regard extracting $\iota_\lambda$ from Weyl's construction as routine. Under that reading the rider is correct, but the reading needs Passage A's qualifier, which B and C omit, and the routine-ness is not argued on file.

The candidate survives as `HYPOTHESIS-DEBT`, scoped to the interpretive rider and not to the lemma. What would have to be supplied: either restore "relative to $\iota_\lambda$" in B and C, or state, with an argument or a reference, that Weyl's construction yields an explicit $\iota_\lambda$ for every admissible $\lambda$ with $\lvert\lambda\rvert\le12$ by a procedure with no search.

## 6. The realisation theorem (brief item 8)

Passage A says of it only that it "says one nonzero seed per block generates that block". The lemma supplies a nonzero element of $M_\lambda$ for every admissible block label, which is exactly that need. Blocks with non-admissible labels have $V_\lambda=0$ and $M_\lambda=0$, so they are not blocks with content and need no seed. The realisation theorem's own statement and any further hypotheses of it (a range of $n$, for instance) are not quoted in the brief and cannot be checked here. No finding within the brief.

## 7. Passages B and C against Passage A (brief item 9)

| Item | A | B | C landscape | C detail |
|---|---|---|---|---|
| Range of $n$ | $n\ge1$ | $n\ge1$ | $n\ge1$ | $n\ge1$ |
| Admissibility | stated | stated | stated | stated, plus "block label" |
| $\lvert\lambda\rvert$ range | $\{0,2,\dots,12\}$ | same | same | same |
| $\iota_\lambda$ | "the inclusion given by Weyl's construction" | "the inclusion" | "the inclusion" | "the inclusion of the irreducible into the tensor power" |
| Conclusion | nonzero element of $M_\lambda$ | nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$ | nonzero $O(n)$-equivariant map $V_\lambda\to V^{\otimes12}$ | nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$ |
| Closed-form rider | "relative to $\iota_\lambda$" | unqualified | unqualified | "removes a search" |
| Admissibility remark | $\lvert\lambda\rvert\le n$ suffices, witnesses | holds whenever $\lvert\lambda\rvert\le n$ | same | same, with $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ |

"A nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}$" and "a nonzero $O(n)$-equivariant map" are the same statement. C detail's one-line justification ("$\mathrm{cup}$ is $O(n)$-invariant, and a tensor product of nonzero vectors is nonzero") omits $V_\lambda\ne0$, which its final sentence supplies. The only differing qualifier with content is the rider, recorded in 5.1. The definite article in "the inclusion" is candidate 11.2, withdrawn.

## 8. Passage D, the Lean files (brief item 10, standing item 5)

What each declaration states:

| Declaration | Types and binders | Corresponds to |
|---|---|---|
| L65Statement.legs | $f:\mathbb N$, $f\le12$, $f$ even $\Rightarrow 2\cdot((12-f)/2)+f=12$ | $\lvert\lambda\rvert+2k=12$, faithful |
| L65Statement.no_cup_iff | same binders, $(12-f)/2=0\iff f=12$ | $k=0$ exactly at $\lvert\lambda\rvert=12$, faithful |
| tprod_map_equivariant | any group $G$, real representations on four modules, two linear maps each equivariant $\Rightarrow$ TensorProduct.map f g is equivariant for Representation.tprod | a generic two-factor version of the equivariance step. It does not state invariance of cup, does not iterate to $k+1$ factors, and does not handle $V_\lambda\cong V_\lambda\otimes\mathbb R$ needed to read "tensor with an invariant vector" as a tensor product of maps |
| seed_ne_zero | c0 : Vlam → T, cap : T → Vlam, iota : Vlam → Vlam, nk ≠ 0, iota ≠ 0, cap ∘ c0 = nk • iota $\Rightarrow$ c0 ≠ 0 | the shape of the contraction argument, but see 8.1 |
| no_seed_of_trivial | Subsingleton Vlam $\Rightarrow$ every linear map out of it is zero | "no nonzero seed exists" when $V_\lambda=0$, with no link to admissibility |
| rows, rows2, Admissible | lists of naturals, counts of entries $>0$ and $\ge2$ | $\lambda'_1$, $\lambda'_2$ and admissibility, faithful for a partition written as its list of parts |
| admissibility_witnesses, admissibility_tight | decide on concrete lists | arithmetic of the witnesses and of $(2^6)$ |
| two examples | $\mathbb R$, identity maps, trivial representations | sanity instantiations only |
| Seed.conj_le_size | every List ℕ: rows + rows2 ≤ sum | the partition bound, generalised to unordered lists with zeros, faithful |
| Seed.admissible_of_size_le, admissible_in_range | sum ≤ n $\Rightarrow$ admissible n, and the case n = 12 | "admissibility holds whenever $\lvert\lambda\rvert\le n$", faithful. "At $n\ge12$" is one le_trans away and not stated as such |
| Seed.tight_conj, tight_size, fails_*, witnesses_exceed | decide | arithmetic of the witnesses |
| Seed.cups_wellposed | $s$ even, $s\le12\Rightarrow2\cdot((12-s)/2)=12-s$ | $k$ well defined, faithful (duplicates legs) |
| Seed.leg_count | $3\cdot4=12$ | no counterpart in Passages A to C |
| Seed.diagram_failure_share | $16\cdot4<71<16\cdot5$ | no counterpart in Passages A to C |

What is not typed: $O(n)$, $V=\mathbb R^n$, $V_\lambda$, Weyl's construction, the implication admissible $\Rightarrow V_\lambda\ne0$, injectivity or equivariance of $\iota_\lambda$, cup and its invariance, the specific $c_0$, $M_\lambda$, and the conclusion. The step that carries admissibility into the proof, $V_\lambda\ne0$, appears only as the free hypothesis iota ≠ 0.

### 8.1 Candidate: seed_ne_zero is typed against a different identity

1. **Location.** Passage A: "contracting all $k$ cups returns $n^k\iota_\lambda\ne0$", with $\iota_\lambda:V_\lambda\to V^{\otimes\lvert\lambda\rvert}$ and the contraction $V^{\otimes12}\to V^{\otimes\lvert\lambda\rvert}$. Lean: `(cap : T →ₗ[ℝ] Vlam) (iota : Vlam →ₗ[ℝ] Vlam)`, `(hcap : cap ∘ₗ c0 = nk • iota)`.
2. **Concrete exhibit.** Take $n=2$, $\lambda=(1,1)$, $k=5$. Then $V_\lambda$ is one-dimensional (spanned by $e_1\otimes e_2-e_2\otimes e_1$), the contraction goes $V^{\otimes12}\to V^{\otimes2}$ (dimension $4$), and the identity reads $\epsilon\circ c_0=2^5\iota_\lambda$ with $\iota_\lambda:V_\lambda\to V^{\otimes2}$. The Lean hypothesis requires cap to land in Vlam $=V_\lambda$ and iota to be an endomorphism of $V_\lambda$. The identity of Passage A has codomain $V^{\otimes2}\ne V_\lambda$, so it cannot be passed as hcap.
3. **Charitable reading.** The declaration can still be applied by taking iota $=\mathrm{id}$ and cap $=r\circ\epsilon$ for a linear left inverse $r$ of $\iota_\lambda$, which exists over a field. That instantiation needs a retraction that no passage mentions, and it proves the same conclusion. The mathematics is unaffected, and a generalisation with iota : Vlam → U for an arbitrary module U would match Passage A directly.

The candidate survives as a Lean-fidelity finding folded into claim 12 (`HYPOTHESIS-DEBT` on "the Lean files state L65"). It is not a defect in the written proof.

The declarations leg_count and diagram_failure_share are true arithmetic with no counterpart in the passages. They are stray content in a file cited for L65, recorded as an editorial note. No Lean build was run by me, so compilation is not asserted.

## 9. The boundary (brief item 11, standing item 3)

Each case below is a screen by hand.

- **$n=1$.** Admissible block labels: only $\varnothing$, since $(2)$ gives $1+1=2>1$ and $(1,1)$ gives $2+0=2>1$. $c_0(t)=t\,e_1^{\otimes12}$. The group $O(1)=\{\pm1\}$ acts on $V^{\otimes12}$ by $(\pm1)^{12}=1$, so $c_0$ is equivariant and nonzero, and the contraction returns $1^6\iota_\varnothing$. Consistent.
- **$\lambda=\varnothing$, $k=6$, any $n\ge1$.** $V^{\otimes0}=\mathbb R$, the traceless condition is vacuous, $\iota_\varnothing=\mathrm{id}_{\mathbb R}$, $c_0(t)=t\,\mathrm{cup}^{\otimes6}$, invariant and nonzero, contraction $n^6$. Consistent.
- **$\lvert\lambda\rvert=12$, $k=0$.** $c_0=\iota_\lambda$ and the lemma is Weyl's theorem, as Passage A says. Smallest admissible dimension for such labels ranges from $n=2$ at $\lambda=(12)$ to $n=12$ at $\lambda=(1^{12})$ or $(2^6)$. No step changes.
- **Smallest admissible dimension in general.** At $n=\lambda'_1+\lambda'_2$, admissibility holds with equality and Weyl gives $V_\lambda\ne0$. Screen: $\lambda=(1,1)$, $n=2$, $V_\lambda=\det$ spanned by $e_1\otimes e_2-e_2\otimes e_1$, on which $g$ acts by $\det g$, so $\iota_\lambda$ is equivariant and $c_0\ne0$. Consistent.
- **Odd $n$.** No step depends on the parity of $n$. At $n=3$, $\lambda=(12)$ is admissible ($2\le3$) and the argument is unchanged.
- **Admissible with $\lvert\lambda\rvert>n$.** $\lambda=(4)$ at $n=2$ ($1+1=2\le2$, $\lvert\lambda\rvert=4$). The lemma never uses $\lvert\lambda\rvert\le n$, only admissibility, so it applies. The passages claim $\lvert\lambda\rvert\le n$ is sufficient for admissibility, never necessary, so this case contradicts nothing.
- **$SO(n)$ in place of $O(n)$.** The equivariance computation uses only $gg^{\mathsf T}=I$, so $c_0$ is also $SO(n)$-equivariant and nonzero. The lemma makes no $SO(n)$ claim, and for $n$ even with $\lambda'_1=n/2$ the restriction of $V_\lambda$ to $SO(n)$ is reducible (for example $\lambda=(2^6)$ at $n=12$), so the block structure would differ. "Reflections included" is what the $O(n)$ statement needs and it is covered. No finding.
- **$n=0$.** Outside the statement. It shows $n\ge1$ is load-bearing (1.1).

## 10. Quantifiers and subfamilies (standing items 2 and 4, and the traps)

- **Quantifier order.** For every $n\ge1$, for every admissible $\lambda$ in range, for every choice of Weyl inclusion $\iota_\lambda$, $c_0\ne0$ in $M_\lambda$. $k$ depends on $\lambda$ only. The proof is uniform in all of these. No finding.
- **Subfamily used in general.** The lemma is proven on the whole stated family. The general statements "every label with $\lvert\lambda\rvert\le n$ is admissible" and "at $n\ge12$ every block label is admissible" are proven in general by section 4. No finding.
- **Hypothesis stated but unused, or used but unstated.** None (1.1). The implicit uses are $V_\lambda\ne0$ and equivariance of $\iota_\lambda$, both parts of the named import.
- **Universal claim with no witness.** "Every block has a seed" is witnessed uniformly by $c_0$. No finding.
- **Imported theorem with hypotheses unchecked.** Checked in 1.2. They match. The import carries no reference.

## 11. Withdrawn candidates

### 11.1 The proof paragraph never invokes admissibility

1. **Location.** "*Nonvanishing.* For $x\ne0$, $\iota_\lambda(x)\ne0$ ... is nonzero." The conclusion $c_0\ne0$ needs some $x\ne0$ in $V_\lambda$, and the proof paragraph does not say one exists.
2. **Exhibit.** For a non-admissible label, for example $(2,2)$ at $n=3$, the same sentence is true vacuously and $c_0=0$, so the existence of $x$ is essential.
3. **Charitable reading.** The paragraph "Admissibility is what makes $V_\lambda$ nonzero", placed between the lemma and the proof, supplies it, and C detail's last sentence does the same.

Withdrawn: the fact is written in the argument, one paragraph earlier. A one-clause pointer inside the proof would remove the ambiguity.

### 11.2 "The inclusion" is not unique

1. **Location.** "let $\iota_\lambda$ be the inclusion" (A, B, C), and "the inclusion of the irreducible into the tensor power" (C detail).
2. **Exhibit.** For $\lambda=(2,1)$, $V_{[2,1]}$ occurs in the traceless part of $V^{\otimes3}$ with multiplicity equal to the number of standard tableaux of shape $(2,1)$, which is $2$, so there are non-proportional equivariant inclusions, one per Young symmetrizer.
3. **Charitable reading.** "The inclusion" means the one fixed by a chosen Young symmetrizer in Weyl's construction, and the proof uses only injectivity and equivariance, so it holds for every choice.

Withdrawn: the lemma is true for every inclusion. C detail's phrasing is the loosest, since it drops the reference to Weyl's construction.

### 11.3 Equality in the bound holds at more labels than $(2^6)$

1. **Location.** "with equality $\lambda'_1+\lambda'_2=12$ at $\lambda=(2,2,2,2,2,2)$".
2. **Exhibit.** Equality $\lambda'_1+\lambda'_2=\lvert\lambda\rvert=12$ holds at every $(2^a,1^{12-2a})$, $a=0,\dots,6$, for example $(1^{12})$ with $12+0=12$.
3. **Charitable reading.** The sentence gives an instance showing $n\ge12$ is sharp and claims no uniqueness.

Withdrawn.

## 12. What would break it

- **A falsifier of the lemma** would be an admissible $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ and some $n\ge1$ at which Weyl's subspace is zero, or an inclusion that is not equivariant. The first contradicts the "if" half of the classical theorem, the second contradicts $O(n)$-stability of the traceless and Young-symmetrised subspaces. I looked at the boundary: $n=1$, $\lambda=\varnothing$, $\lvert\lambda\rvert=12$, the smallest admissible $n$ for $(1,1)$, and admissible labels with $\lvert\lambda\rvert>n$. All screens were consistent.
- **A falsifier of the step "cup invariant"** would be an orthogonal $g$ with $gg^{\mathsf T}\ne I$, which does not exist.
- **A falsifier of the partition bound** would be a part contributing more than its size to $\lambda'_1+\lambda'_2$, impossible since the contribution is $\min(p,2)$.
- **A falsifier of the $n\ge1$ hypothesis's necessity** is $n=0$ with $\lambda=\varnothing$, which does break the statement, confirming the hypothesis is needed rather than refuting the lemma.
- **A falsifier of the closed-form rider** would be an admissible $\lambda$ at which no nonzero traceless tensor of type $\lambda$ can be written without search. The passages give no procedure either way, which is why 5.1 is graded as debt and not as refuted.

## 13. Verdict

**PROVEN**

The lemma holds as stated in Passages A, B and C, for $n\ge1$ and every $O(n)$-admissible $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, given the classical Weyl theorem (admissible labels give a nonzero $O(n)$-stable subspace of $V^{\otimes\lvert\lambda\rvert}$), which the passages name without a reference. The open items are outside the mathematics of the statement: the closed-form rider in B and C needs Passage A's qualifier "relative to $\iota_\lambda$" (5.1), and the Lean files type only arithmetic and generic shapes, with seed_ne_zero typed against an endomorphism iota rather than $\iota_\lambda:V_\lambda\to V^{\otimes\lvert\lambda\rvert}$ (8.1). The index was clean when I checked it, with no file from another session staged.
