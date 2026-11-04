# Verifier v396, Lemma L65: the cup-padded inclusion is a nonzero element of $M_\lambda$, the partition bound $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$, and the Lean declarations

The brief was cold and I worked from the definitions it quotes. No numerical work was done, every value below is exact, and no scripts were written or run (the Lean files were read, not compiled). Hand screens on objects I constructed are marked as screens and are never offered as evidence for a positive claim. Log: [agent_logs/verify-L65-v396.log](../agent_logs/verify-L65-v396.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | $\mathrm{cup}$ is $O(n)$-invariant, $c_0$ is $O(n)$-equivariant | CONFIRMED | coefficient matrix of $g\cdot\mathrm{cup}$ is $gg^{\mathsf T}=I$, slot order respected by the diagonal action |
| 2 | $c_0\ne0$ (tensor-product argument) | CONFIRMED | needs $V_\lambda\ne0$, which the section supplies from admissibility via a cited Weyl theorem |
| 3 | Contraction of the $k$ cups returns $n^k\iota_\lambda$ | CONFIRMED AS ALGEBRA | exact identity, needs $n^k\ne0$ and $\iota_\lambda\ne0$ |
| 4 | Admissible $\Rightarrow V_\lambda\ne0$, $\iota_\lambda$ equivariant and injective | CONFIRMED | classical (Weyl), cited as "classical, unfiled", used only in the "if" direction |
| 5 | $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$, witnesses, equality at $(2^6)$ | CONFIRMED | each part $p$ contributes $\min(p,2)\le p$, all witness values exact |
| 6 | "At $n\ge12$ every block label is admissible", "holds whenever $\lvert\lambda\rvert\le n$" | CONFIRMED | direct from claim 5, stated as sufficient only |
| 7 | "Given in closed form and need not be searched for" (B), "constructed rather than searched for" (C) | HYPOTHESIS-DEBT | true relative to $\iota_\lambda$ as A says, B and C drop that qualifier and the explicitness of $\iota_\lambda$ has no argument on file |
| 8 | "The realisation theorem applies to it" | CONFIRMED | the only requirement quoted is a nonzero seed per block, which the lemma supplies |
| 9 | B and C agree with A | CONFIRMED | same range $n\ge1$, same hypotheses, "nonzero element of $M_\lambda$" and "nonzero equivariant map" coincide |
| 10 | Lean declarations state the lemma | CONFIRMED AS ALGEBRA | every declaration is a correct abstract fragment, none types $V_\lambda$, $\mathrm{cup}$, $O(n)$ or admissible $\Rightarrow V_\lambda\ne0$, and seed_ne_zero types $\iota$ as an endomorphism |
| 11 | Boundaries $n=1$, $\lambda=\varnothing$, $\lvert\lambda\rvert=12$, odd $n$, admissible with $\lvert\lambda\rvert>n$, $SO(n)$ | CONFIRMED | each case checked in closed form, no failure |

**Summary: the lemma is proven from the stated hypotheses and one cited classical theorem (Weyl: the traceless tensors of symmetry type $\lambda$ form a nonzero $O(n)$-subrepresentation of $V^{\otimes\lvert\lambda\rvert}$ when $\lambda'_1+\lambda'_2\le n$), and the round's only action items are to carry Passage A's qualifier "relative to $\iota_\lambda$" into the closed-form sentences of Passages B and C, and to record that the Lean files check abstract fragments rather than the lemma.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$V=\mathbb R^n$ with the standard action of $O(n)$, and $V^{\otimes m}$ with the diagonal action $g\cdot(v_1\otimes\dots\otimes v_m)=gv_1\otimes\dots\otimes gv_m$ and the induced inner product."
- "A **block label** is a partition $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. $\lambda'$ is the conjugate partition, so $\lambda'_1$ is the number of nonzero parts of $\lambda$ and $\lambda'_2$ the number of parts of size at least $2$. $\lambda$ is **$O(n)$-admissible** when $\lambda'_1+\lambda'_2\le n$."
- "$V_\lambda$ is the $O(n)$-representation labelled by $\lambda$, and $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$."
- From Passage A: "$k=(12-\lvert\lambda\rvert)/2$", "$\iota_\lambda:V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion given by Weyl's construction of $V_\lambda$ as the traceless tensors of symmetry type $\lambda$ (classical, unfiled)", "$\mathrm{cup}=\sum_a e_a\otimes e_a\in V\otimes V$".

I read $e_1,\dots,e_n$ as the standard basis of $\mathbb R^n$, which is orthonormal for the standard inner product. The passages do not say so in words, and every step below that uses orthonormality is flagged.

## 1. Hypothesis inventory

### 1.1 Hypotheses of the statement

| Hypothesis | Where stated | Used by | Use |
|---|---|---|---|
| $n\ge1$ | A, B, C | nonvanishing | $\mathrm{cup}\ne0$ when $k\ge1$, and $n^k\ne0$ in the contraction form |
| $\lambda$ $O(n)$-admissible | A, B, C | nonvanishing | $V_\lambda\ne0$, so that some $x\ne0$ exists (via 1.2) |
| $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ | A, B, C | definition of $c_0$ | evenness makes $k$ an integer, $\lvert\lambda\rvert\le12$ makes $k\ge0$, and $\lvert\lambda\rvert+2k=12$ puts $c_0$ in $V^{\otimes12}$ |
| $e_a$ orthonormal | implicit in "$V=\mathbb R^n$ standard" and "invariant metric element" | equivariance, contraction | $gg^{\mathsf T}=I$ is the coefficient matrix only in an orthonormal basis, and $\langle e_a,e_a\rangle=1$ |

No hypothesis is stated and unused. $n\ge1$ is not redundant: at $n=0$, $\lambda=\varnothing$ is admissible ($0\le0$), $V_\varnothing=\mathbb R$, $\mathrm{cup}$ is the empty sum $0$, and $V^{\otimes12}=0$, so $c_0=0$ and $M_\varnothing=0$. Passage C's "a block label $\lambda$, $O(n)$-admissible with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$" repeats the size condition already in "block label", which is harmless.

### 1.2 The imported theorem

The only imported result is Weyl's construction, cited in Passage A as "classical, unfiled" and in B and C only as "the inclusion". The statement I rely on, stated as standard mathematics: for $d\ge0$ and a partition $\lambda\vdash d$, let $V^{[d]}\subseteq V^{\otimes d}$ be the kernel of all contractions of pairs of slots and $c_\lambda$ a Young symmetriser for $\lambda$. Then $V_{[\lambda]}:=V^{[d]}\cap c_\lambda V^{\otimes d}$ is an $O(n)$-subrepresentation of $V^{\otimes d}$, it is irreducible, and it is nonzero if and only if $\lambda'_1+\lambda'_2\le n$ (Weyl, The Classical Groups, Ch. V, and Fulton and Harris, Representation Theory, §19.5, stated over $\mathbb C$). Over $\mathbb R$ the same statement holds because $V^{[d]}$ and $c_\lambda V^{\otimes d}$ are cut out by linear maps with rational coefficients, so the real intersection has real dimension equal to the complex dimension of its complexification. The passages neither argue nor cite this transfer.

Checked against the object it is applied to:

| Part of Weyl's theorem | Needed by the proof? | Status in the passages |
|---|---|---|
| $V_{[\lambda]}\subseteq V^{\otimes d}$ is $O(n)$-stable, so $\iota_\lambda$ is equivariant | yes, equivariance | assumed ("the equivariant map $\iota_\lambda$") |
| $\iota_\lambda$ is injective | yes, nonvanishing | assumed, and immediate for an inclusion |
| admissible $\Rightarrow V_{[\lambda]}\ne0$ | yes, nonvanishing | cited ("Admissibility is what makes $V_\lambda$ nonzero") |
| non-admissible $\Rightarrow V_{[\lambda]}=0$ | no, used only in the witness remark | cited |
| $V_{[\lambda]}$ is irreducible and is "the representation labelled by $\lambda$" | no, the lemma's statement is true for any nonzero equivariant injection | assumed through the Definitions |

The hypotheses of Weyl's theorem ($\lambda$ a partition of $d=\lvert\lambda\rvert$, $V=\mathbb R^n$ with its standard form, the diagonal action) all hold for the objects of L65. The "exactly" direction is not used by the lemma.

## 2. Equivariance (brief item 3)

Step as written: "$g\cdot\mathrm{cup}=\sum_a ge_a\otimes ge_a$ has coefficient matrix $gg^{\mathsf T}=I$". Following the algebra: $ge_a=\sum_b g_{ba}e_b$, so $\sum_a ge_a\otimes ge_a=\sum_{b,c}\bigl(\sum_a g_{ba}g_{ca}\bigr)e_b\otimes e_c=\sum_{b,c}(gg^{\mathsf T})_{bc}\,e_b\otimes e_c$. For $g\in O(n)$, $g^{\mathsf T}g=I$ gives $gg^{\mathsf T}=I$, so $g\cdot\mathrm{cup}=\mathrm{cup}$. Nothing uses $\det g=1$, so reflections are included. This uses orthonormality of $e_a$ (1.1). Then $g\cdot\mathrm{cup}^{\otimes k}=(g\cdot\mathrm{cup})^{\otimes k}=\mathrm{cup}^{\otimes k}$, because the diagonal action on $V^{\otimes2k}$ acts slot by slot.

Step as written: "the tensor product of the equivariant map $\iota_\lambda$ with invariant vectors is equivariant". With $\iota_\lambda(x)$ in slots $1,\dots,\lvert\lambda\rvert$ and the $j$-th cup in slots $\lvert\lambda\rvert+2j-1,\lvert\lambda\rvert+2j$, the diagonal action on $V^{\otimes12}$ restricted to pure tensors is $g\cdot(u\otimes w)=(g\cdot u)\otimes(g\cdot w)$ for $u\in V^{\otimes\lvert\lambda\rvert}$, $w\in V^{\otimes2k}$, and this extends linearly. So $g\cdot c_0(x)=\iota_\lambda(gx)\otimes\mathrm{cup}^{\otimes k}=c_0(gx)$. The map $x\mapsto\iota_\lambda(x)\otimes w$ is linear because $\otimes$ is bilinear, so $c_0$ lies in $\mathop{\mathrm{Hom}}$. The passages do not state linearity, and it is immediate. The slot order is fixed by writing $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ left to right, and any other placement of the cups would be equally equivariant.

No finding: the step follows as written.

## 3. Nonvanishing (brief item 4)

Step as written: "For $x\ne0$, $\iota_\lambda(x)\ne0$, and $\mathrm{cup}\ne0$ because $n\ge1$, so $\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ is a tensor product of nonzero vectors and is nonzero." Over a field, $u\ne0$ and $w\ne0$ give $u\otimes w\ne0$ (extend each to a basis). $\mathrm{cup}$ has coefficient matrix $I_n\ne0$ for $n\ge1$. So $c_0(x)\ne0$ for every $x\ne0$. To conclude $c_0\ne0$ one needs some $x\ne0$, which is $V_\lambda\ne0$, from admissibility and 1.2. The chain reaches the stated conclusion. Note that the argument shows more than stated: $c_0$ is injective.

Contraction identity: let $C:V^{\otimes12}\to V^{\otimes\lvert\lambda\rvert}$ apply $\langle\cdot,\cdot\rangle$ to slots $\lvert\lambda\rvert+2j-1,\lvert\lambda\rvert+2j$ for $j=1,\dots,k$. On $u\otimes\mathrm{cup}^{\otimes k}$ each cup contributes $\sum_a\langle e_a,e_a\rangle=n$ (orthonormality again), so $C\circ c_0=n^k\iota_\lambda$. At $k=0$, $C$ is the identity and the identity reads $c_0=\iota_\lambda$. If $c_0=0$ then $n^k\iota_\lambda=0$, and $n^k\ne0$ in $\mathbb R$ for $n\ge1$, so $\iota_\lambda=0$, which contradicts $V_\lambda\ne0$ with $\iota_\lambda$ injective. The algebra closes exactly.

"Nonzero in $M_\lambda$ and nonzero as a map are the same statement": $M_\lambda$ is a subspace of $\mathop{\mathrm{Hom}}_{\mathbb R}(V_\lambda,V^{\otimes12})$ with the zero map as its zero, so this is correct.

### 3.1 Candidate, withdrawn: the proof block never invokes $V_\lambda\ne0$

1. Location: the Proof block of Passage A reads "For $x\ne0$, $\iota_\lambda(x)\ne0$ ... is nonzero", which is vacuous if $V_\lambda=0$, and admissibility is not named inside the block.
2. Exhibit: for a non-admissible label, for example $\lambda=(2,2)$ at $n=3$, $V_{[\lambda]}=0$ and the quoted sentence remains true while $c_0=0$. So the block's words alone do not reach $c_0\ne0$.
3. Charitable reading: the paragraph immediately before the proof, headed "Admissibility is what makes $V_\lambda$ nonzero", supplies exactly the missing premise, and Passage C's detail block also says "Admissibility makes $V_\lambda$ nonzero". The section as a whole contains the step.

Withdrawn: the premise is on file in the same section, one paragraph above.

## 4. Weyl's construction, "classical, unfiled" (brief item 2)

What the proof needs, and its status, is the table in 1.2. The passages argue none of it and cite it by name only. Equivariance and injectivity of $\iota_\lambda$ are assumed. Admissible $\Rightarrow V_\lambda\ne0$ is cited and used. The converse is cited and used only for the witness sentence "no nonzero seed exists, witness $\lambda=(2,2)$ at $n=2,3$ and $\lambda=(2,1,1)$ at $n=3$", which is outside the lemma's statement.

Hand screen of that converse on the witnesses (a screen, not evidence, and it leans on the decomposition of $V^{[4]}$ into constituents $V_{[\mu]}$ with $\lvert\mu\rvert=4$, so it checks consistency rather than proving anything): at $n=2$, $S_{(2,2)}\mathbb R^2$ is $\det^{2}$, one-dimensional, and restricts to the trivial $O(2)$-representation $V_\varnothing$. At $n=3$, $S_{(2,1,1)}\mathbb R^3\cong\det\otimes V$ restricts to $\Lambda^2V=V_{(1,1)}$, and $S_{(2,2)}\mathbb R^3$ restricts to $S^2V\cong V_{(2)}\oplus V_\varnothing$. Every constituent carries a label of size less than $4$, so none lies in the traceless part of $V^{\otimes4}$. Both screens agree with $V_{[\lambda]}=0$.

No finding beyond the imprecise citation: the theorem is classical, its hypotheses hold for the objects, and the direction the lemma uses is the one cited as "what makes $V_\lambda$ nonzero".

## 5. The partition bound (brief items 5 and 6)

Step as written: "a part of size $p$ contributes at most $p$ to $\lambda'_1+\lambda'_2$". A part $p$ contributes $[p\ge1]+[p\ge2]=\min(p,2)$, and $\min(p,2)\le p$ for every integer $p\ge0$ ($0\le0$, $1\le1$, $2\le p$ for $p\ge2$). Summing over parts gives $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$. Equality holds exactly when every part is $0$, $1$ or $2$.

Witnesses, exact: $(2,2)$ has $\lambda'_1=2$, $\lambda'_2=2$, sum $4>3\ge2$, so it fails at $n=2$ and $n=3$. $(2,1,1)$ has $\lambda'_1=3$, $\lambda'_2=1$, sum $4>3$. $(2,2,2,2,2,2)$ has $\lambda'_1=6$, $\lambda'_2=6$, sum $12=\lvert\lambda\rvert$, and it is not admissible at $n=11$.

"So at $n\ge12$ every block label is admissible": a block label has $\lvert\lambda\rvert\le12\le n$, so $\lambda'_1+\lambda'_2\le n$. "Admissibility holds whenever $\lvert\lambda\rvert\le n$" (B, C) is the same bound, stated as a sufficient condition, and none of the passages claims the converse.

No finding.

## 6. The seed's description and "closed form" (brief item 7)

"$\iota_\lambda$ followed by a padding diagram of $k$ cups": $c_0=P\circ\iota_\lambda$ with $P:V^{\otimes\lvert\lambda\rvert}\to V^{\otimes12}$, $u\mapsto u\otimes\mathrm{cup}^{\otimes k}$, which is the Brauer map with $\lvert\lambda\rvert$ through-strands and $k$ cups on the last $2k$ output points. Correct. At $\lvert\lambda\rvert=12$, $k=0$, $P=\mathrm{id}$ and $c_0=\iota_\lambda$. Correct, and Passage A says "there the content is Weyl's construction".

### 6.1 Candidate, surviving: B and C drop "relative to $\iota_\lambda$"

1. Location. Passage A: "So every block has a seed in closed form **relative to $\iota_\lambda$**". Passage B: "so the seed of every block is given in closed form and need not be searched for". Passage C landscape: "so it is constructed rather than searched for", and C detail: "The lemma removes a search from the certificate pipeline". The claim the gloss needs is that $\iota_\lambda$ itself is available without search. No passage argues it, and the Definitions define $V_\lambda$ abstractly as "the $O(n)$-representation labelled by $\lambda$", which does not make $\iota_\lambda$ a literal inclusion.
2. Exhibit. Take any block with $\lvert\lambda\rvert=12$, for example $\lambda=(12)$ at $n\ge2$. Then $k=0$ and $c_0=\iota_\lambda$, so the seed's "closed form" is exactly as explicit as $\iota_\lambda$. Passage A's own framing of the problem is "finding a nonzero element of $\mathop{\mathrm{Hom}}(V_\lambda,V^{\otimes12})$", which for $\lvert\lambda\rvert=12$ is finding a nonzero element of $\mathop{\mathrm{Hom}}(V_\lambda,V^{\otimes\lvert\lambda\rvert})$, the object $\iota_\lambda$ is. Weyl's construction presents $V_{[\lambda]}$ as an intersection $V^{[12]}\cap c_\lambda V^{\otimes12}$, a kernel met with an image, and the passages give no formula for a nonzero vector of it or for a basis. For these blocks the lemma moves the construction into $\iota_\lambda$ without performing it, and Passage B states the removal of search for "every block" with no qualifier.
3. Charitable reading. If $V_\lambda$ is taken to be Weyl's subspace by definition, $\iota_\lambda$ is a literal inclusion and there is nothing to search for, so B's sentence means the same as A's. Passage C detail also carries the $\lvert\lambda\rvert=12$ disclosure ("at $\lvert\lambda\rvert=12$ it is $\iota_\lambda$ itself"). This reading clears C detail as an honest disclosure, and it leaves B and C landscape stating unqualified what A qualifies. It also leaves the explicitness of Weyl's subspace as a cited fact with no argument on file, which is the gap between "a subspace defined by linear equations" and "given in closed form".

Grade: HYPOTHESIS-DEBT on the gloss only, with the lemma's mathematical content unaffected. What would have to be proved for B's sentence as written: that for every admissible block label $\lambda$ a nonzero vector (equivalently, since $V_{[\lambda]}$ is irreducible, the whole embedding) of $V^{[\lvert\lambda\rvert]}\cap c_\lambda V^{\otimes\lvert\lambda\rvert}$ is given by an explicit formula. The cheaper repair is to write "relative to $\iota_\lambda$" into B and C landscape, as A already does.

### 6.2 Candidate, withdrawn: "the inclusion" is not unique

1. Location: B "let $\iota_\lambda$ be the inclusion", C "the inclusion of the irreducible into the tensor power".
2. Exhibit: $V_\lambda$ with $\lvert\lambda\rvert=d$ occurs in $V^{\otimes d}$ with multiplicity at least $1$ and in general more, for example $\lambda=(1,1)$, $d=2$ at $n\ge2$ has multiplicity $1$ but $\lambda=(2,1)$, $d=3$ at $n\ge3$ has multiplicity $2$ (the two standard tableaux give independent Young symmetrisers), so "the" inclusion is a choice.
3. Charitable reading: the proof uses only that $\iota_\lambda$ is an injective equivariant linear map, so every choice yields a nonzero seed, and Passage A fixes it as "given by Weyl's construction".

Withdrawn: the definite article names a choice that the argument is uniform over.

## 7. "The realisation theorem applies to it" (brief item 8)

The only property of the realisation theorem quoted is "one nonzero seed per block generates that block". A block is indexed by $\lambda$ and its seeds live in $M_\lambda$. The lemma supplies a nonzero element of $M_\lambda$ for every admissible block label and every $n\ge1$. No finding on what is quoted. The realisation theorem's full hypotheses (field, range of $n$, any requirement on the model of $V_\lambda$) are outside the brief, so I cannot check whether it asks more of a seed than nonvanishing.

## 8. Passages B and C against Passage A (brief item 9)

| Point | A | B | C |
|---|---|---|---|
| range of $n$ | $n\ge1$ | $n\ge1$ | $n\ge1$ |
| admissibility | $\lambda'_1+\lambda'_2\le n$ written out | "$O(n)$-admissible" | "$O(n)$-admissible" |
| size | $\{0,2,\dots,12\}$ | same | same |
| $\iota_\lambda$ | "given by Weyl's construction" | "the inclusion" | "the inclusion (of the irreducible into the tensor power)" |
| conclusion | "nonzero element of $M_\lambda$" | "nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$" | landscape "nonzero $O(n)$-equivariant map $V_\lambda\to V^{\otimes12}$", detail "nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}$" |
| closed form | "relative to $\iota_\lambda$" | unqualified | landscape unqualified, detail discloses $\lvert\lambda\rvert=12$ |
| admissible when | $\lvert\lambda\rvert\le n$, with argument | $\lvert\lambda\rvert\le n$ | $\lvert\lambda\rvert\le n$, "since $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$" |

"Nonzero element of $M_\lambda$" and "nonzero $O(n)$-equivariant map" coincide once "map" is read as linear, which the seed is. The only qualifier that differs in substance is "relative to $\iota_\lambda$", recorded in 6.1. No other finding.

## 9. Passage D, the Lean files (brief item 10, standing item 5)

I read the declarations and did not compile them.

| Declaration | What it states | Types | Relation to A to C |
|---|---|---|---|
| legs | $f\le12$, $f$ even $\Rightarrow 2\cdot((12-f)/2)+f=12$ | $f:\mathbb N$ | $\lvert\lambda\rvert+2k=12$, correct with truncated subtraction and division |
| no_cup_iff | same hypotheses, $(12-f)/2=0\iff f=12$ | $\mathbb N$ | $k=0\iff\lvert\lambda\rvert=12$, correct since even $f\le12$ with $12-f\le1$ forces $f=12$ |
| tprod_map_equivariant | $f,g$ equivariant $\Rightarrow f\otimes g$ intertwines the tensor product representations | any group $G$, real modules | covers "equivariant map tensor invariant vectors" only after taking $W=\mathbb R$ trivial and $g(1)=\mathrm{cup}^{\otimes k}$, and identifying $V_\lambda\otimes\mathbb R\cong V_\lambda$ and $V^{\otimes\lvert\lambda\rvert}\otimes V^{\otimes2k}\cong V^{\otimes12}$, none of which is typed, and invariance of $\mathrm{cup}$ is not stated |
| seed_ne_zero | $cap\circ c_0=nk\cdot\iota$, $nk\ne0$, $\iota\ne0\Rightarrow c_0\ne0$ | $c_0:V_{lam}\to T$, $cap:T\to V_{lam}$, $\iota:V_{lam}\to V_{lam}$ | abstract form of the contraction argument, see 9.1 |
| no_seed_of_trivial | $V_{lam}$ subsingleton $\Rightarrow$ every linear map out of it is $0$ | real modules | "no nonzero seed exists" when $V_\lambda=0$ |
| rows, rows2, Admissible (both files) | counts of entries $>0$ and $\ge2$ in a list, and their sum $\le n$ | List $\mathbb N$ | equal to $\lambda'_1$, $\lambda'_2$ on a partition written as a list of parts, arbitrary lists allowed |
| admissibility_witnesses, fails_* | $\neg$Admissible 2 [2,2], $\neg$ 3 [2,2], $\neg$ 3 [2,1,1] | closed terms | the witnesses, by decide |
| admissibility_tight, tight_conj, tight_size | $(2^6)$ has rows sum $12$, size $12$, admissible at $12$ | closed terms | the equality case |
| conj_le_size | rows $l$ + rows2 $l\le$ sum $l$ for every list | List $\mathbb N$ | the partition bound, on a strictly larger family than partitions, so the use on partitions is a specialisation |
| admissible_of_size_le, admissible_in_range | sum $\le n\Rightarrow$ admissible $n$, and the case $n=12$ | $\mathbb N$, List $\mathbb N$ | "admissible whenever $\lvert\lambda\rvert\le n$" and "at $n\ge12$" |
| witnesses_exceed | $(2,2)$ and $(2,1,1)$ have size $4$ | closed | consistent with 5 |
| cups_wellposed | $s$ even, $s\le12\Rightarrow 2\cdot((12-s)/2)=12-s$ | $\mathbb N$ | $2k=12-\lvert\lambda\rvert$ |
| leg_count | $3\cdot4=12$ | closed | no counterpart in A to C |
| diagram_failure_share | $16\cdot4<71<16\cdot5$ | closed | no counterpart in A to C |
| two examples | seed_ne_zero at $\mathrm{id}_{\mathbb R}$, tprod_map_equivariant at trivial representations on $\mathbb R$ | $\mathbb R$ | sanity instances, far from $O(n)$ and $V_\lambda$ |

What is typed: the arithmetic of $k$, the partition bound on lists, the witness and equality values, and two abstract linear-algebra facts. What is not typed: $V=\mathbb R^n$, $O(n)$, $\mathrm{cup}$ and its invariance, $V_\lambda$, $\iota_\lambda$, the contraction identity with $n^k$, and admissible $\Rightarrow V_\lambda\ne0$. That last implication enters seed_ne_zero only as the bare hypothesis hiota, and the link between Admissible and any representation is absent.

### 9.1 Candidate, surviving as a scope note: seed_ne_zero types $\iota$ as an endomorphism

1. Location: seed_ne_zero binds iota : Vlam →ₗ[ℝ] Vlam and cap : T →ₗ[ℝ] Vlam, with hcap : cap ∘ₗ c0 = nk • iota. Passage A's identity is $C\circ c_0=n^k\iota_\lambda$ with $C:V^{\otimes12}\to V^{\otimes\lvert\lambda\rvert}$ and $\iota_\lambda:V_\lambda\to V^{\otimes\lvert\lambda\rvert}$.
2. Exhibit: for $\lambda=(2)$ at $n=2$, $V_\lambda$ is two-dimensional and $V^{\otimes\lvert\lambda\rvert}=V^{\otimes2}$ is four-dimensional, so $n^k\iota_\lambda$ has type $V_\lambda\to V^{\otimes2}$ and cannot be the iota of seed_ne_zero, whose codomain is $V_\lambda$. The written identity does not typecheck as hcap.
3. Charitable reading: instantiate with cap $:=\pi\circ C$ for the orthogonal projection $\pi:V^{\otimes\lvert\lambda\rvert}\to V_\lambda$ and iota $:=\mathrm{id}$, then hcap holds and hiota is $V_\lambda\ne0$. The theorem is true and applicable, just not in the form written in A.

Surviving as a scope note, not a defect: seed_ne_zero is correct, and it checks "a map with a nonzero scalar multiple of a nonzero map as a left composite is nonzero", which is weaker than and different in typing from the identity A states. Graded with the rest of the Lean as CONFIRMED AS ALGEBRA. leg_count and diagram_failure_share have no counterpart in the lemma and sit in its file, which is a hygiene point for whoever maintains the index.

## 10. Boundaries (brief item 11, standing item 3)

- $n=1$. $\lambda'_1+\lambda'_2\le1$ with $\lvert\lambda\rvert$ even leaves only $\lambda=\varnothing$, since $(m)$ with $m\ge2$ gives $1+1=2$ and $(1,1)$ gives $2+0=2$. Then $O(1)=\{\pm1\}$, $\mathrm{cup}=e_1\otimes e_1$, $c_0(t)=t\,e_1^{\otimes12}$, and $(-1)^{12}=1$. Nonzero and equivariant. Screen of Weyl at $n=1$: traceless $S^2\mathbb R^1$ is the kernel of the isomorphism $S^2\mathbb R^1\to\mathbb R$, which is $0$, consistent with $(2)$ being inadmissible.
- $\lambda=\varnothing$, $k=6$. $V^{\otimes0}=\mathbb R$ has no contractions and $c_\varnothing=1$, so $V_\varnothing=\mathbb R$ with trivial action and $\iota_\varnothing=\mathrm{id}_{\mathbb R}$. $c_0(t)=t\,\mathrm{cup}^{\otimes6}$, the contraction returns $n^6t$, and $n^6\ne0$. Admissible at every $n\ge0$. Lean: rows [] + rows2 [] $=0$.
- $\lvert\lambda\rvert=12$, $k=0$. $c_0=\iota_\lambda$, the tensor-product argument degenerates to "$\iota_\lambda(x)\ne0$" and the contraction to the identity. Both still close. Admissibility is no longer automatic below $n=12$, as $(2^6)$ at $n=11$ shows, and it is a hypothesis of the lemma.
- Odd $n$. No step uses parity of $n$: $\mathrm{cup}$ exists and is invariant for every $n$, and $n^k\ne0$. At $n=3$, $\lambda=(1,1)$ is admissible ($2\le3$) and $V_{(1,1)}=\Lambda^2V\ne0$. No finding.
- Admissible with $\lvert\lambda\rvert>n$. $\lambda=(4)$ at $n=2$: $\lambda'_1+\lambda'_2=2\le2$ and $\lvert\lambda\rvert=4$. Screen: $S^4\mathbb R^2$ has dimension $5$, the trace to $S^2\mathbb R^2$ (dimension $3$) is onto, so the traceless part has dimension $2\ne0$, and the lemma applies with $k=4$. The passages state $\lvert\lambda\rvert\le n$ only as sufficient, so no overclaim.
- $SO(n)$. Nothing in A to C claims $SO(n)$. $c_0$ is also $SO(n)$-equivariant and nonzero, since $\mathop{\mathrm{Hom}}_{O(n)}\subseteq\mathop{\mathrm{Hom}}_{SO(n)}$, but $V_\lambda$ may restrict reducibly (for even $n$ and $\lambda'_1=n/2$) and $V_\lambda$, $V_\lambda\otimes\det$ coincide on restriction, so the block structure differs. The lemma is stated for $O(n)$ and the proof's "reflections included" matches that. No finding.

## 11. Quantifier order and scope (standing item 2), and proven against used (standing item 4)

The statement is: for all $n\ge1$, for all partitions $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ and $\lambda'_1+\lambda'_2\le n$, for any Weyl embedding $\iota_\lambda$, $c_0\ne0$ in $M_\lambda$. The only existential inside the proof is "some $x\ne0$ in $V_\lambda$", discharged by the cited Weyl direction. "Every block has a seed" has the explicit witness $c_0$. The partition bound is proven on all lists of naturals (Lean) and all partitions (A), and used on block labels, a subfamily. "At $n\ge12$" and "whenever $\lvert\lambda\rvert\le n$" follow for all $n$ from admissible_of_size_le, and admissible_in_range covers only $n=12$, which is not used in general. No finding.

## 12. The brief's items, by number

1. Hypotheses: inventory in 1.1. $n\ge1$ gives $\mathrm{cup}\ne0$ and $n^k\ne0$, admissibility gives $V_\lambda\ne0$, the size condition gives $k\in\mathbb Z_{\ge0}$ and the codomain $V^{\otimes12}$. The only unstated hypothesis is orthonormality of $e_a$, carried by "$V=\mathbb R^n$ standard". No finding.
2. Weyl: 1.2 and 4. Equivariance and injectivity assumed, admissible $\Rightarrow$ nonzero cited and used, the converse cited and unused by the lemma. No finding beyond an imprecise citation.
3. Equivariance: section 2. CONFIRMED.
4. Nonvanishing: section 3. CONFIRMED, with a withdrawn candidate in 3.1.
5. Partition bound: section 5. CONFIRMED.
6. "At $n\ge12$" and "whenever $\lvert\lambda\rvert\le n$": section 5. CONFIRMED.
7. Seed description: section 6. The diagram description is correct, and the closed-form gloss is HYPOTHESIS-DEBT in B and C landscape (6.1).
8. Realisation theorem: section 7. CONFIRMED on the quoted requirement.
9. B and C against A: section 8. CONFIRMED except the dropped qualifier of 6.1.
10. Lean: section 9. CONFIRMED AS ALGEBRA, the lemma itself is not typed, seed_ne_zero's iota is an endomorphism (9.1), and two declarations are unrelated to L65.
11. Boundaries: section 10. CONFIRMED in every case.

## 13. What would break it

- An admissible block label $\lambda$ at some $n\ge1$ with $V^{[\lvert\lambda\rvert]}\cap c_\lambda V^{\otimes\lvert\lambda\rvert}=0$. This contradicts Weyl's theorem as stated in 1.2. I screened the smallest cases by hand, $n=1$ with $\varnothing$, $n=2$ with $(4)$, and the inadmissible witnesses at $n=2,3$, and found agreement.
- A $g\in O(n)$ moving $\mathrm{cup}$. Impossible, since the coefficient matrix is $gg^{\mathsf T}=I$ identically.
- A nonzero $u\in V^{\otimes\lvert\lambda\rvert}$ with $u\otimes\mathrm{cup}^{\otimes k}=0$. Impossible over a field for $n\ge1$.
- $n=0$, where the lemma fails ($c_0=0$), is excluded by the hypothesis $n\ge1$.

None was found, and the only surviving items (6.1, 9.1) concern an interpretive sentence and the scope of the Lean, not the lemma's truth.

## 14. Verdict

**PROVEN.** The lemma follows from its stated hypotheses and the cited "if" direction of Weyl's theorem, every range edge holds, and the hypotheses need no correction. Two items remain for the round: the closed-form sentences of Passage B and Passage C landscape should carry Passage A's "relative to $\iota_\lambda$" (HYPOTHESIS-DEBT on the gloss, 6.1), and the Lean record should say that L65's files check the arithmetic of $k$, the partition bound, and abstract fragments of the argument, with $V_\lambda$, $\mathrm{cup}$, $O(n)$ and admissible $\Rightarrow V_\lambda\ne0$ untyped (9.1). I staged and committed only this report. The session's opening snapshot showed plan-verification.md, verification/BRIEF_L65r2.md and verification/ROUND_L65r2.md staged by another thread, and by the time I committed they were no longer staged, so I touched none of them.
