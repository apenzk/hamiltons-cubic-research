# Gate 2 review r248 -- claims 3 and 5

Reviewer 248. Commits under review: 2cdff7b (primary), d82dea0, cf4020b, fbc58b1.
Primary file: [scripts/runs/run_n12_diagram_independence.py](../scripts/runs/run_n12_diagram_independence.py).

| # | Claim | Verdict |
|---|---|---|
| 3 | Cost claim: diagram route avoids the 635,220-column elimination | **CONCLUSION HOLDS, ARITHMETIC REFUTED** -- the route is ~13 orders cheaper, but only in a cost model the file never states; as written ("a closed-graph value at n=12") it is **1.43e21 flops, 236x MORE than the elimination it replaces**. Three over-counts, all against the file: the Gram is block diagonal (485 entries, not 17,020), 720 is the bijection count for degree-6 objects while the 184 are cubics (6), and n=12 need never be evaluated. And "the n=5 machinery already exists" is **false** -- that file's projector is a stub |
| 5 | Applications d82dea0 / cf4020b faithfulness; A2'/A2'' in plan.md | **FAITHFUL ON THE FINDINGS, BUT THE FAILED-REPAIR RECORD IS MATHEMATICALLY WRONG.** "p^T K p = 0 on a spanning set forces K = 0" is **false** (2x2 witness); the reason given for the nonzero t-space **contradicts the theorem in the same file**; and "the interesting case cannot arise in a miniature" is **refuted** by a 4-dimensional twisted-cubic screen with a nonzero t-space whose psd part is {0}. The screen imposes Dp=0, the theorem's *conclusion*, where p^T D p = 0 is its hypothesis. plan.md: A2'' drops the parametrisation-relativity scope note and keeps an unconditional headline over three open hypotheses; A2' is still headed **DONE** above a body saying the solve was never executed |

## Claim 3 -- the cost claim

**Verdict: the conclusion survives, the stated arithmetic does not.** The diagram route is genuinely smaller than the elimination -- by about thirteen orders of magnitude -- but *only under a cost model the file never states*. Read literally, the sentence in the file describes a computation **236x more expensive than an upper bound on the whole 71-block elimination it replaces**. Every one of the three mis-sizings runs against the file's own case.

Everything below is from [c3_cost.py](../scripts/reviewers/r248/c3_cost.py), output in [out_c3_cost.txt](../scripts/reviewers/r248/out_c3_cost.txt).

### The object being costed

Two degree-6 diagrams glued along a bijection sigma of their six Weyl vertices give a closed graph with **6 vertices, each of degree 8** (4 c-side legs, 4 b-side), and 24 edges -- the union of the two perfect matchings. Its evaluation cost is set by the widest cut a contraction order must cross, and that is exactly computable: subset DP over the 2^6 = 64 vertex subsets returns the optimal pairwise order. Over 200 random gluings the optimal width is 9 to 16 open legs, median 13.

Two cost models for the identical graph:

| model | an intermediate with k open legs | one closed graph |
|---|---|---|
| A -- arrays at n = 12, which is what "a closed-graph value at n=12" says | n^k entries | median **1.17e14** flops, max 2.02e17 |
| B -- Brauer coefficients: every Weyl projector is O(n)-equivariant, so the intermediate is an *invariant* tensor and by the FFT lies in the span of the (k-1)!! matchings | (k-1)!! coefficients, **no n at all** | median **3.68e4** ops |

At the worst observed width, model A wants a single array of 12^16 = 1.8e17 entries -- 1.3 million TiB. It is not a slow computation; it does not fit in the universe.

### The comparison the file invites, done

| route | work |
|---|---|
| the file's own sentence: 17,020 entries x 720 bijections x a closed-graph value at n=12 | **1.43e21 flops** = 4,533 years at 1e10 flop/s |
| what was abandoned: 71 blocks, the largest 635,220 columns, dense k^3/3 | <= **6.07e18 flops** |
| the same Gram in model B | 4.51e11 ops = **45 s** |

**So the work has not moved -- it has shrunk enormously -- but the file's description of it is the one reading under which it has *grown*, by a factor of 236.** The saving comes entirely from never letting the dimension 12 into an index range, and the file says the opposite.

### Three separate over-counts, all in the file's disfavour

1. **The Gram is not 184 x 184 dense.** J_c takes values in V_{lambda_c}; O(n) irreps are self-dual and inequivalent irreps pair to zero, so &lt;J_c, J_b&gt; = 0 unless lambda_c = lambda_b. M(n) is **block diagonal**. From the record's own [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl): 77 blocks, multiplicities summing to 191, **max 9**. Upper-triangular entries actually needed: **485, not 17,020** -- 35x. And det M(n) is a *product of 77 determinants of size at most 9*, which is a far better object than one 184 x 184 determinant: the Sturm step gets 77 polynomials of degree <= 54 rather than one of degree <= 1104.
2. **720 is the wrong bijection count for the 184.** 6! = 720 glues two **degree-6** diagrams -- which is what [run_n5_diagram_gram.py](../scripts/runs/run_n5_diagram_gram.py) does, its objects being the degree-6 O(5)-*invariants*, counted 14 at n=5 and 89 universally (plan A1). The 184 are degree-3 **covariants** in Sym^3(Weyl_12) (r221: 191 SO(12) multiplicities less 7 chiral pairs). Gluing two cubics identifies **three** vertices: 3! = **6** bijections. The sentence takes the size of one object and the bijection count of another. Under either consistent reading it is wrong: 184 x 184 with 6 bijections, or 89 x 89 with 720.
3. **n = 12 need never be evaluated at all.** Reviewer 240's monomial theorem gives &lt;P,Q&gt; = n^L q_D with q_D *n-independent*, so an entry is fixed by a cycle count L on the glued graph -- an O(24) union-find -- plus one constant. There is no evaluation at a dimension anywhere in the correct procedure.

Priced the way the item actually needs it -- 184 cubic covariants, block diagonal, 6 bijections, 3-vertex glued graphs, model B -- the whole Gram is **2,910 closed graphs and 1.3e6 operations**. Against 6.07e18 for the elimination.

### The load-bearing false statement

> "the n=5 machinery for exactly that gluing already exists (run_n5_diagram_gram.py)"

It does not. [run_n5_diagram_gram.py](../scripts/runs/run_n5_diagram_gram.py)'s `weyl_projector` builds `E = np.zeros((n,)*8)` and returns it unused, and the file's own final print says *"The gluing formula is not yet implemented -- the Weyl projector on eight indices is the missing piece."* Running it confirms this. The parenthetical is the only thing in the reduction offering evidence that the gluing is executable, and it points at a stub. **The item's remaining work is the Weyl projector on eight indices in a form that composes -- which, under model B, is the projector expanded in the Brauer algebra B_4(n), not an array.** That is the piece to build, and naming it is worth more than the parenthetical.

### What should be written instead

The reduction's cost case is *much stronger* than the file makes it, and it rests on a statement the file does not make: **the intermediates are O(n)-invariant tensors, so the entire computation lives in the Brauer algebra and the dimension never appears.** With block diagonality and the degree-3 bijection count on top, the honest headline is 485 entries, 6 gluings each, on 3-vertex graphs, and a Sturm step over 77 polynomials of degree at most 54.

## Claim 5 -- the applications, d82dea0 and cf4020b

**Verdict: faithful on the review findings they were applying, but the FAILED-repair record contains a false theorem and a false impossibility claim, and plan.md's A2''/A2' carry two residual overreaches.**

### 5a. The FAILED-repair record misdescribes the mathematics -- with a witness

[run_a2pp_constant_t.py](../scripts/runs/run_a2pp_constant_t.py), under *"WHY THE TWO CANNOT BE RECONCILED IN THIS MINIATURE"*, and repeated verbatim in d82dea0's commit message:

> "... nonzero because evaluations range over the image of a cubic map, a proper subvariety ... for a symmetric K, p^T K p = 0 on a spanning set forces K = 0 outright. So in a miniature where the samples span, the t-space is necessarily zero and the interesting case cannot arise at all."

**Three things are wrong, and they compound.**

1. **"p^T K p = 0 on a linearly spanning set forces K = 0" is false.** Smallest witness, in [c5_tspace.py](../scripts/reviewers/r248/c5_tspace.py): K = [[0,1],[1,0]], e1 and e2 span R^2, e1^T K e1 = e2^T K e2 = 0, K != 0. The true statement needs the spanning *subspace* (polarise: q(u+v) - q(u) - q(v) = 2 u^T K v), or equivalently needs the rank-one lifts {p p^T} to span Sym. A *set* does not suffice. This is the load-bearing step of the whole diagnosis.
2. **The stated reason contradicts the theorem three paragraphs above it.** The theorem's step is *"the evaluations {p(W)} span the full coordinate space exactly when the covariants are linearly independent as functions"* -- spanning is what the hypothesis *delivers*. The repair note then explains the nonzero t-space by the evaluations *failing* to span linearly, i.e. by the hypothesis failing. Both cannot hold. The correct account: the image of a cubic map **does** span linearly; what it fails to span is Sym, quadratically. **The failure is quadratic, not linear** -- which is precisely why psd-ness has work to do, and psd-ness doing work is the theorem's entire content.
3. **"The interesting case cannot arise at all" is false, and the owed screen is twenty lines.** [c5_tspace.py](../scripts/reviewers/r248/c5_tspace.py) builds it over the image of a genuine cubic map -- the thing the file lists as OWED and not built -- with p(w) = (w1^3, w1^2w2, w1w2^2, w2^3), the twisted cubic in R^4, over 80 exact rational points ([out_c5_tspace.txt](../scripts/reviewers/r248/out_c5_tspace.txt)):

| quantity | independent case (k=4) | PLANT p_4 = 2p_0 (k=5) |
|---|---|---|
| do the evaluations span R^k? | rank 4 -- **yes**, independent as functions | rank 4 of 5 -- no |
| t-space {D sym : p^T D p = 0 on the image} | **dim 3**, of dim Sym = 10 | dim 8 of 15 |
| psd part of the t-space | **{0}**, proved exactly by the zero-diagonal closure on rows 0 then 1 | **nonzero**: D = vv^T, v = 2e_0 - e_4 |
| linear annihilator {D : Dp = 0} -- *what the screen computes* | dim 0 | dim 1 |

So a four-dimensional miniature has a **nonzero** t-space whose psd part is exactly {0}: the theorem's own step, tested, with psd-ness doing the work. The plant puts a nonzero psd element in it. Nothing about the small dimension obstructs this.

**The actual defect, stated correctly.** `psd_in_kernel_span` imposes **D p = 0**, which is the theorem's *conclusion*. The hypothesis to impose is **p^T D p = 0**. That single substitution turns the screen from a tautology into a test, without undersampling and without breaking spanning. The record's account of *what it did wrong* (undersampled, broke spanning) is accurate; its account of *why the right repair is unavailable* is not, and the right repair is available.

**Register.** The record is honest in the sense that matters -- a failed attempt was written down rather than deleted, and the branch's claim was correctly weakened to what it shows. The objection is not to the honesty but to the content: a false lemma is now in the record as the reason an owed item is hard, and it will be cited.

### 5b. plan.md A2'' -- one dropped hypothesis, one unconditional headline

| finding | status |
|---|---|
| "$S_n$ is bounded ... **conditionally**", with r245's independence/separation/blockwise preconditions named | **faithful** to r245's claim 1 |
| "the nullity constant on $n\ge12$, an obligation nothing in the record yet discharges" | **faithful** to r245's claim 2 |
| **DROPPED: "'constant $t$' is parametrisation-relative to the chosen $(B_p, K_i)$."** The file carries this scope note; the plan does not. The plan's *"or a Farkas witness that none exists"* then reads as absolute non-existence of a constant $t$, when what the machinery can deliver is non-existence **within the chosen parametrisation** | **overclaim** -- and it is the same failure mode r246 caught with the dropped $v(n)\ne0$ hypothesis: a caveat living in the file and not in the plan |
| **Headline "the *negative* side is finitely certifiable", unconditional**, while its own body names three open hypotheses (independence, nullity constancy, separation) | **overclaim**, one notch softer than the "decidable" headline r246 refuted, and the same shape. It should read *"finitely certifiable once three named hypotheses are discharged"* |
| r245's softening -- only $S_{12}$ compact is needed -- and the $n=20$ nullity jump making a refutation family-relative | in the file, absent from the plan; an omission rather than an overclaim |

### 5c. plan.md A2' -- the status word contradicts its own body

**"A2'. DONE, audited"** heads an entry whose body says *"the solve has not been executed at the real system, so this is the theorem's conclusion, not a report."* An item whose central computation has not been run is not DONE. The reviews it cites returned **"TRUE IN SUBSTANCE, FALSE AS STATED"** (r244 claim 3) and two REFUTED sub-claims (r243: the rationality claim *false as written*, the odd-$n$ argument *refuted in its stated reason*). "DONE, audited" is stronger than that record supports; **DERIVED, NOT EXECUTED** is what it is.

Everything cf4020b actually changed in A2' is faithful: the $v(n)\ne0$ hypothesis restored, "entries in Q(n)" moved to the subjunctive, the unnormalised covector and its reason, "no Sturm item is added" corrected to the pivot minor being retired while the root-freeness check survives. Only the status word was left behind.

**One omission, for completeness.** r243's odd-$n$ verdict -- conclusion confirmed, *stated reason refuted*, "it argues soundness where losslessness is what is owed" -- appears nowhere in plan.md or the file. It is not an overclaim, but it is an audited refutation with no home in the record.

### 5d. A cross-check from claim 3 that lands here

r245 phrases the independence obligation as *"root-freeness of the 184x184 covariant-Gram determinant"*. By the block-diagonality shown under claim 3, that determinant is a **product of 77 determinants of size at most 9**, and independence is 77 separate small obligations rather than one large one. r245's own body already says the right thing (*"the per-block multiplicity space R^{m_lambda}"*); the summary sentence, which is what gets quoted forward, does not.

## What to change

Ordered by what the record loses if it is left alone.

1. **Delete the false lemma.** "for a symmetric K, p^T K p = 0 on a spanning set forces K = 0 outright" is wrong and is currently the stated reason an owed item is hard. Replace with: the image spans linearly, but its rank-one lifts fail to span Sym -- and psd-ness is what closes that gap.
2. **Build the screen; it is twenty lines.** [c5_tspace.py](../scripts/reviewers/r248/c5_tspace.py) is a working instance. Change `psd_in_kernel_span` to impose p^T D p = 0 rather than D p = 0.
3. **Say the cost claim in the model that makes it true.** The intermediates are O(n)-invariant tensors, so the whole Gram lives in the Brauer algebra and the dimension never enters. Written as "a closed-graph value at n=12" the route is 236x *more* expensive than the elimination it replaces.
4. **Correct the two sizes.** The Gram is block diagonal -- 485 entries over 77 blocks of size at most 9, not 17,020 -- and the bijection count for cubic covariants is 6, not 720.
5. **Drop the parenthetical that points at a stub.** "the n=5 machinery for exactly that gluing already exists" is false. The honest replacement names what is missing: the Weyl projector expanded in the Brauer algebra B_4(n).
6. **Fix two status words.** A2' is DERIVED, NOT EXECUTED. A2''s headline needs its three hypotheses, and the parametrisation-relativity scope note belongs in the plan, not only in the file.
