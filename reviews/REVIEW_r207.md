# Gate 2 review r207 -- the apolarity reduction (brief15, claims 1-3)

Under review: [scripts/runs/run_n5_necessary.py](../scripts/runs/run_n5_necessary.py) (commits ec35c0b, 6237a63, 2f20131). Reviewer 207; claims 4-6 belong to reviewer 208.

Everything below is rebuilt from the CP^2 description of W_0 alone -- no repository module is imported by any r207 script, and Weyl_5 is obtained as the so(5)-module W_0 generates (it comes out 35-dimensional, which is itself a check).

## Verdict table

| # | Claim | Verdict |
|---|-------|---------|
| 1 | Cat_F is the adjoint of mu; F -> Cat_F injective; the apolar pairing is O(5)-invariant | **UPHELD** -- every step holds, but the adjointness carries no normalisation content; the apolar structure is load-bearing elsewhere |
| 2 | the split 65 = 36 + 29, block by block, and whether it is a direct sum | **UPHELD** -- every number confirmed independently, including the block rule the file only asserts |
| 3 | F_5 orthogonal to A(W_0^6) after the invariant projection | **UPHELD, with a false statement inside it** -- the catalecticant of A(W_0^6) is the orbit average, of rank 3570, not the rank-one form the file names |

---

## Claim 2 -- UPHELD, and the unproved premise is now measured

The file asserts a block rule and derives 36 + 29 from it. The rule is stated with no proof; this review verifies it exactly, block by block, and finds it right.

### What the rule really says

K = {cubics vanishing on the orbit of W_0} = C^perp, where C = span{(g W_0)^3} inside Sym^3(Weyl_5) under the apolar identification f(v) = &lt;f, v^3&gt;. Blockwise, C meets the lambda-isotypic component in V_lambda (x) N_lambda, so

    codim(K cap M_lambda in M_lambda) = r_lambda := dim N_lambda = rank of the isotypic projection of u = W_0^3.

The file's rule is exactly: r_lambda = 1 on lambda_2-even blocks, 0 on lambda_2-odd blocks.

### Measuring r_lambda exactly

[scripts/reviewers/r207/c2_casimir_blocks.py](../scripts/reviewers/r207/c2_casimir_blocks.py) reads the block set off the **minimal polynomial of the Casimir on the Krylov space of u**, mod p = 46337, in exact arithmetic. A block lambda meets C exactly when its Casimir value c(lambda) = l1^2 + l2^2 + 3 l1 + l2 is a root.

- The Krylov space closes at dimension 15: fifteen distinct Casimir values occur.
- All 16 lambda_2-even blocks have their value among the roots.
- Of the 8 lambda_2-odd blocks, seven -- (2,1), (3,1), (3,3), (4,1), (5,1), (5,3), (6,3) -- have values that are **not** roots, so those blocks lie entirely inside K, exactly as claimed.
- Three Casimir values are degenerate and cannot name their block: c=30 for (3,3)/(4,1) (both already excluded), c=40 for (5,0)/(4,3), c=60 for (5,4)/(6,2).

[scripts/reviewers/r207/c2_ambiguous.py](../scripts/reviewers/r207/c2_ambiguous.py) settles the two live ones by projecting u onto each Casimir eigenvalue and measuring the dimension of the so(5)-module the projection generates, again mod p, with SO(5,F_p) elements from the Cayley transform:

| Casimir value | candidates (dim V) | measured module dim | conclusion |
|---|---|---|---|
| 40 | (5,0) = 91, (4,3) = 231, both = 322 | **91** | (5,0) present, (4,3) absent |
| 60 | (5,4) = 429, (6,2) = 625, both = 1054 | **1054** | both present, one copy each |

So all eight lambda_2-odd blocks are absent and all sixteen lambda_2-even blocks are present.

### r_lambda = 1, not merely >= 1

[scripts/reviewers/r207/c2_orbit_span.py](../scripts/reviewers/r207/c2_orbit_span.py) measures dim C = 3570 over R through the identity &lt;v^3, w^3&gt; = &lt;v, w&gt;^3, so the 7770 cubic coordinates are never formed: the rank of [&lt;g_i W_0, g_j W_0&gt;^3] on 3800 orbit points. The spectral gap is a factor 7.5e9 and the count is stable from tolerance 1e-8 to 1e-12. Degree 1 gives 35 and degree 2 gives 630, as calibration.

Since every present block contributes at least dim V_lambda and the sixteen present blocks already sum to exactly 3570 (Weyl dimension formula), every r_lambda is exactly 1. That closes the rule:

    r_lambda = 1  <=>  lambda_2 even,   on all 24 blocks of Sym^3(Weyl_5).

### The counting on top of it

- **MULT is independently correct.** [scripts/reviewers/r207/c2_mult_check.py](../scripts/reviewers/r207/c2_mult_check.py) rebuilds it from B_2 characters: the weights of V_(2,2) from the alternant over the Weyl denominator (doubled exponents, integer arithmetic), all multiset sums of three of them, then peeling irreducibles highest weight first. Result: 24 blocks, 41 copies, sum m*dim V = 7770, and the table agrees with the file's entry for entry.
- **65 is right.** Sym^2(U)^G = (+)_lambda Sym^2(M_lambda) because every V_lambda here is of real type, so Sym^2(V_lambda)^G is a line and Lambda^2(V_lambda)^G = 0, and cross terms lambda != mu carry no invariants. Sum m(m+1)/2 = 65.
- **The u (x) v + v (x) u count of m is right.** On an even block, K_lambda is a hyperplane in M_lambda; the symmetric forms vanishing on K_lambda x K_lambda are exactly {u (x) v + v (x) u : v in M_lambda} with u the functional cutting out K_lambda, of dimension m -- not m+1 (u (x) u is already in the family, at v = u/2) and not m-1 (the map v -> u (x) v + v (x) u is injective).
- **29 and 36 are right.** Forms vanishing on K x K: even blocks give m, odd blocks give **0** (K_lambda = M_lambda forces S_lambda = 0), total 29. Forms supported on K: even (m-1)m/2, odd m(m+1)/2, total 36. Blockwise m + m(m-1)/2 = m(m+1)/2, so 36 + 29 = 65 is forced, not a coincidence.

### Is it a direct sum? Yes, once the complement is named -- and the file does not name it

The two subspaces meet in 0 (a form supported on the hyperplane K_lambda and vanishing on K_lambda x K_lambda is zero) and their dimensions add to 65, so the sum is direct. But "supported on K" is not defined without a splitting M_lambda = K_lambda (+) L_lambda: intrinsically, Sym^2(K^*)^G is a **quotient** of the 65, not a subspace. The exact sequence

    0 -> {forms vanishing on K x K} -> Sym^2(U^*)^G -> Sym^2(K^*)^G -> 0,    29 + 36 = 65

is the invariant statement, and the internal direct sum needs the complement K_lambda^perp taken inside the O(5)-invariant (apolar) inner product. That choice is available and canonical, so the claim survives -- but the file's phrase "splits the invariant forms into those supported ON K and those vanishing on K x K" is only true after it, and 36 is best read as the number of unknowns in a Gram supported on K, which is basis-free.

### Two defects worth fixing

1. **Name collision on ANN.** The docstring defines ANN = {F in (Sym^6 Weyl_5)^{O(5)} : Cat_F(K,K) = 0}, a subspace of the 14 of dimension between 1 and 14. The code binds `ANN = sum(m for m in EVEN.values())` = 29 and prints it as "of which vanishing on K x K", which is a different object living in the 65. Two objects, one name, in one file; a reader who takes `rank = 14 - dim ANN` at face value with the printed 29 gets rank = -15.
2. **The block rule is asserted, not derived.** "on a block with lambda_2 ODD, K contains all of M_lambda" and "on a block with lambda_2 EVEN, K has codimension 1" carry no argument in the file. They are the statement that Stab(W_0) is a spherical subgroup of O(5) whose spherical weights are exactly the lambda_2-even ones; this review confirms that on all 24 blocks that occur in Sym^3, and nowhere else. The general rule remains unproved in the record.

---

## Claim 1 -- UPHELD, and the worry in the brief lands somewhere else

Checked in two ways: by re-derivation, and by [scripts/reviewers/r207/c1_apolarity.py](../scripts/reviewers/r207/c1_apolarity.py), which rebuilds the entire reduction in a miniature where every object is computable exactly -- V = R^3, G the 48 signed permutations, w_0 = (1,1,0), cubics against sextics -- and runs a sabotage plant against each step.

### Step by step

| step | status | why |
|---|---|---|
| Cat_F(f,g) = &lt;F, fg&gt; is the adjoint of mu | holds, and is a **tautology** | &lt;F, mu(B)&gt; = sum_ij B_ij &lt;F, m_i m_j&gt; = sum_ij B_ij Cat_F(m_i,m_j) is linearity, once B is read as an element of Sym^2(U) and Cat_F as one of Sym^2(U^*) -- the pairing of the two is canonical, needing no metric on U and no basis |
| F annihilates mu(Sym^2 K) &lt;=&gt; Cat_F(K,K) = 0 | holds | the same identity applied to B in Sym^2(K), plus polarisation in characteristic zero |
| F -> Cat_F injective | holds | mu : Sym^2(Sym^3 W^*) -> Sym^6 W^* is onto (sixth powers span), so its adjoint is one-to-one; measured rank 28 of 28 in the miniature |
| the apolar pairing is O(5)-invariant | holds | it is built from the Euclidean structure of Weyl_5, and O(5) acts on Weyl_5 through Lambda^2, which is orthogonal for the Frobenius product; measured over all 48 group elements in the miniature |
| invariants may be taken throughout | holds | invariants is an exact functor for a reductive group in characteristic zero, so image^G = mu((Sym^2 K)^G); and for invariant F, &lt;F, mu(B)&gt; = &lt;F, mu(Reynolds B)&gt;, so F _|_ image^G &lt;=&gt; F _|_ image |
| rank = 14 - dim ANN, and F_5 in image &lt;=&gt; F_5 _|_ ANN | holds | needs the pairing restricted to the invariant sextics to be nondegenerate; the apolar pairing is positive definite over R (&lt;x^a, x^b&gt; = delta * a!/d!), so it is. The miniature reproduces the whole statement: dim (Sym^6)^G = 3, dim ANN = 1, dim image = 2 = 3 - 1, and "in the image &lt;=&gt; orthogonal to ANN" holds on 30 random invariant sextics |

The 14 and the 65 were also re-derived from scratch by Weyl integration in [scripts/reviewers/r207/c1_counts.py](../scripts/reviewers/r207/c1_counts.py) -- characters of Sym^k from the power sums by Newton, so neither the 7770- nor the 3838380-dimensional space is ever formed -- giving dim (Sym^6 Weyl_5)^{O(5)} = 14, dim Sym^2(Sym^3)^{O(5)} = 65, dim Lambda^2(Sym^3)^{O(5)} = 24. (O(5)-invariants equal SO(5)-invariants here: O(5) = SO(5) x {+-I} and -I acts trivially through Lambda^2.)

### Where the normalisation actually matters

The brief asks whether Cat_F is the adjoint "with the normalisation the argument needs". It needs none: the adjointness identity holds for **any** bilinear form on Sym^6, provided the same form defines Cat_F. The plant confirms it -- with the naive coefficient pairing the identity still holds (2 = 2), and it breaks only when the two conventions are mixed, Cat_F apolar against a coefficient-pairing evaluation of &lt;F, mu(B)&gt; (2 against -116/5).

What the apolar normalisation a!/d! **is** load-bearing for is a different pair of statements the file makes downstream: &lt;v^6, h&gt; = h(v) exactly (the plant that drops the weights gives 43631 instead of 0), which is what turns "Cat_{v^6} is the rank-one form at v" and "&lt;F, A(W_0^6)&gt; proportional to F(W_0)" into equalities; and positive definiteness, which is what makes "in the image &lt;=&gt; orthogonal to ANN" an equivalence rather than one implication. The file's sentence attaches the normalisation worry to the step that does not need it.

### One thing the file gets right that is easy to miss

That the cubics in any SOS decomposition lie in K needs an argument, and it is available: F_5 is O(5)-invariant with F_5(W_0) = 0, so it vanishes on the whole orbit, and a real sum of squares vanishing at a point has every summand vanishing there. F_5 is homogeneous, so the unit-sphere constraint adds no multiplier and the decomposition is a genuine identity of sextics. Verified numerically here: F_5(W_0) = (3/2)|W_0|^6 - 9 tr(W_0^3)^2 = 3/2 - 9/6 = 0 exactly.

---

## Claim 3 -- the conclusion is right; the sentence carrying it is false

Two halves, and they fail differently.

### Half one: "A(W_0^6) has catalecticant (f,g) -> f(W_0) g(W_0)" is FALSE

Averaging commutes past the catalecticant, not through it:

    Cat_{A(v^6)}(f,g) = &lt;A(v^6), fg&gt; = &lt;v^6, A(fg)&gt; = integral over O(5) of f(g v) g(g v),

which is the **orbit average** of rank-one forms, not one of them. The file writes this correctly four paragraphs later, when it derives the v^3-in-C criterion; the sentence under claim 3 contradicts it.

The difference is not a normalisation:

- **Rank.** The averaged form has rank equal to dim span{ev_{g W_0}} = dim C = **3570** (measured above); the form the file names has rank 1.
- **Invariance.** Cat_F of an invariant sextic is an O(5)-invariant bilinear form. (f,g) -> f(W_0) g(W_0) is invariant only under Stab(W_0), so it cannot be the catalecticant of any invariant sextic at all -- which is enough to refute the sentence with no computation.
- The miniature exhibits it concretely: the true catalecticant of A(w_0^6) equals the orbit average exactly (constant 1), rank 6, while the stated rank-one form has rank 1, with witness pair (m_0, m_0) = (z^3, z^3) where the truth is 2/3 and the stated form gives 0.

**Does the difference matter?** For the K x K claim, no: every term f(g W_0) h(g W_0) of the average vanishes when f, h vanish on the orbit, so the average kills K x K and dim ANN >= 1 and rank &lt;= 13 stand. But the file's stated *reason* -- "because every f in K vanishes at W_0" -- is the reason the rank-one form kills K x K. The reason the true one does is that every f in K vanishes on the whole ORBIT, which is how K is defined. The right premise is one line away and the file uses the wrong one.

### Half two: "&lt;F, A(W_0^6)&gt; proportional to F(W_0)" is right, and is an equality

A is the Reynolds projection, self-adjoint for the invariant pairing, so for invariant F

    &lt;F, A(W_0^6)&gt; = &lt;A F, W_0^6&gt; = &lt;F, W_0^6&gt; = F(W_0),

with constant exactly 1 in the normalisation &lt;x^a, x^b&gt; = delta * a!/d!. Confirmed on 20 random invariant sextics in the miniature; the plant that drops invariance of F breaks it (20/3 against 13), which is the hypothesis that does the work. So F_5 _|_ A(W_0^6) follows from F_5(W_0) = 0, and the invariant projection does **not** disturb it -- the projection is on the other side of the pairing.

Also checked: A(W_0^6) is nonzero, so the obstruction it names is real. &lt;A(W_0^6), A(W_0^6)&gt; = &lt;W_0^6, A(W_0^6)&gt; = the average of &lt;g W_0, W_0&gt;^6, an integral of a nonnegative function that is 1 at g = e.

---

## Summary

The reduction survives. Claim 1 is correct at every step, claim 2 is correct in every number, and claim 3's conclusion is correct. Three things should change in the file:

1. `ANN` names two different objects, one of dimension &lt;= 14 and one of dimension 29. Rename the second.
2. "A(W_0^6) has catalecticant (f,g) -> f(W_0) g(W_0)" is false -- it is the orbit average of those, of rank 3570 -- and the reason given for it killing K x K is the reason for the false version. Both are repaired by saying "the orbit average" and "vanishes on the orbit".
3. The lambda_2-even/odd block rule is asserted with no argument. This review measures it -- exactly, on all 24 blocks -- but the record still has no proof of it, and it is the single premise the 36 and the 29 rest on.

None of these changes any number or any conclusion in the file.
