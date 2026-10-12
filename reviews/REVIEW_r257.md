# REVIEW r257 -- Gate 2, the multiplicity test, attempt six (claims 1-3)

Commits under review: ff4ed03 (primary), a157e50, 3f17991. Primary file: [scripts/runs/run_hw_multiplicity_test.py](../scripts/runs/run_hw_multiplicity_test.py). Scripts: [scripts/reviewers/r257/](../scripts/reviewers/r257/).

| # | Claim | Verdict |
|---|---|---|
| 1 | Is the test testing anything? | **REFUTED -- the assert cannot fire on any output of this pipeline.** Proved as a theorem and confirmed by five corruption witnesses that all pass. |
| 2 | Does it read the highest-weight coordinate? | **MIXED -- the ordering premise holds, the use made of it does not.** Position 0 is genuinely the highest-weight vector, but it is a vector expanded into 37-111 monomial rows, not a coordinate, and nothing is evaluated at any point. |
| 3 | The coefficient coercion | **CONFIRMED as written -- the test reads real parts only.** 48.2% of the coefficients it reads carry a nonzero imaginary part and every one is discarded. Inert on this cache, unsound in general. |

## Claim 1 -- the test verifies that a basis is a basis, and cannot do otherwise

**Theorem.** For every block lambda of multiplicity m, [rank_of_block](../scripts/runs/run_hw_multiplicity_test.py#L53) returns m, whatever the rest of the pipeline computed.

*Proof.* Three facts compose.

1. **Position 0 of every copy is the highest-weight vector u_i.** [word_list](../scripts/runs/run_n5_adapted.py#L55) seeds its BFS with `([], u)`, so `words[0]` is the empty word and [replay](../scripts/runs/run_n5_adapted.py#L71) returns u unchanged at index 0. Verified directly against the hw cache in [claim2_position0.py](../scripts/reviewers/r257/claim2_position0.py): `copies[i][0] == {cols[j]: ns[i][j]}` for every copy of every multiplicity block.
2. **The u_i carry an m x m identity submatrix by construction.** The u_i are the rows of [nullspace_G](../scripts/runs/run_n5_highest_weight.py#L67), which for each of the m free columns f writes `v[f] = ONE` in its own basis vector and `ZERO` in the others. So among the monomial indices `cols[f]` there are m whose rows are exactly e_1, ..., e_m over Q, with entries the literals (1,0) and (0,0). [probe_cache.py](../scripts/reviewers/r257/probe_cache.py) locates those rows in all twelve blocks.
3. **Those rows are always read.** [hw_support](../scripts/runs/run_hw_multiplicity_test.py#L49) returns every position at which copy 0 is nonzero, and every replayed vector is nonzero because the copies span V_lambda -- measured, `len(sup) == dim V_lambda` for all twelve blocks, so `sup[:3]` is always `[0, 1, 2]` and t = 0 is always among the components read. [rank_of_block](../scripts/runs/run_hw_multiplicity_test.py#L59) emits one row per monomial key in the union of the supports, so it emits all m unit rows. The (1,0)/(0,0) literals survive the real-part coercion exactly. Hence the row space contains Q^m and the rank is m. QED

The consequence is that [the assert at line 91](../scripts/runs/run_hw_multiplicity_test.py#L91) is unfalsifiable: `rank = m` is a property of `nullspace_G`'s echelon convention, established before a single lowering operator is applied and before any covariant exists. The file's own comment states the position -- "the copies of a block are independent by construction -- they are a basis of the multiplicity space" -- and then ranks them anyway.

**Witnesses.** [witness_corruptions.py](../scripts/reviewers/r257/witness_corruptions.py) reruns the file's verbatim logic against deliberately broken caches:

| Cache | What is destroyed | Verdict the test returns |
|---|---|---|
| W0 | nothing | full rank, 12/12 |
| W1 | every vector past position 0 emptied -- the entire adapted basis gone | full rank, 12/12 |
| W2 | every copy collapsed onto copy 0 past position 0 -- the shared word list identification destroyed | full rank, 12/12 |
| W3 | every imaginary part set to zero | full rank, 12/12 |
| W4 | every imaginary part replaced by noise | full rank, 12/12 |
| W5 | the highest-weight vectors randomised off the nullspace unit columns | full rank, 12/12 |
| W6 (control) | every copy made identical including position 0 | deficient, 12/12 |

W1 and W2 delete precisely the objects the pipeline spent ten minutes building -- reviewer 182's shared word list, reviewer 199's per-copy spanning property -- and the file certifies them. W6 is the only failing input and no run can produce it, since `nullspace_G` writes distinct unit rows by construction.

**What would make the check meaningful.** Each of these has a possible failing input.

- **Rank the images, not the basis.** The programme needs independence of the m covariants after the map that actually acts on them -- padding to n = 12, the isotypic projector r256 showed has a kernel at degree 3, then evaluation. Rank `Phi(u_1), ..., Phi(u_m)` for that composite Phi; a kernel intersection makes it fail.
- **Compare two independently built objects.** Rank the adapted copies against diagram-built covariants spanning the same isotypic. A disagreement is then possible, which is what makes it evidence.
- **Carry a negative control the file must reject.** Append an (m+1)-th vector that is a known combination of the m and require the reported rank to stay at m. The file has no input it is required to fail.
- **Read one scalar functional at genuine sample points.** The two-sidedness argument of the docstring is about the value of a function at the highest-weight coordinate; ranking 111 ambient monomial coefficients of a basis vector is a different object entirely (claim 2).

## Claim 2 -- position 0 is the highest-weight vector; it is not a coordinate, and nothing is sampled

The ordering premise survives. From [claim2_position0.py](../scripts/reviewers/r257/claim2_position0.py), positions 0, 1, 2 of copy 0 of block (4,2) carry the single weights (4,2), (3,3) = lambda + (-1,1) and (4,1) = lambda + (0,-1) -- the highest weight and its two simple lowerings, matching the BFS order of [word_list](../scripts/runs/run_n5_adapted.py#L55). Index 0 is the highest weight, not an arbitrary slot.

Three things the file infers from that do not follow.

- **Position 0 is a vector of V_lambda inside Sym^3, not a coordinate.** [rank_of_block](../scripts/runs/run_hw_multiplicity_test.py#L59) expands it over the ambient monomial basis, contributing 111 rows for (2,2), 37 for (4,2) and 72 for (3,2). The read is the full ambient coefficient vector of a basis vector, which is the object r255 classified as raw diagram values, and the equivariance-plus-polarisation converse the docstring invokes applies to a scalar highest-weight functional of a function value.
- **No sample point exists.** The docstring at [line 25](../scripts/runs/run_hw_multiplicity_test.py#L25) says "at several sample points"; `comps = sup[:3]` are the first three vectors of the word list, and [the unused `import random`](../scripts/runs/run_hw_multiplicity_test.py#L34) is the residue of a sampling step that is absent. Positions 1 and 2 are lowered vectors of the same copy, so they add rows to the same matrix rather than independent evaluations.
- **`hw_support` filters nothing.** Its docstring calls the result "the highest-weight end of the block", but every position of copy 0 is nonzero -- measured, the count equals dim V_lambda in all twelve blocks -- so it returns `range(dim)` and `sup[:3]` is `[0, 1, 2]` unconditionally. The brief's suspicion is right about the mechanism: these are the first entries of a list. They happen to begin at the highest weight because the list is BFS order from u.

## Claim 3 -- the coercion reads real parts only

The cache stores `(r, i)` pairs of `Fraction` (written at [run_n5_adapted.py:173](../scripts/runs/run_n5_adapted.py#L173)), and [run_hw_multiplicity_test.py](../scripts/runs/run_hw_multiplicity_test.py#L37) loads that raw pickle rather than the re-coerced `G`-valued form. So `isinstance(x, tuple)` is true for every stored coefficient, the `hasattr(x, 'r')` branch is dead, and the live branch is `F(x[0])` -- the real part.

From [claim3_coercion.py](../scripts/reviewers/r257/claim3_coercion.py):

- **387,158 of 826,486 cached coefficients (47%) carry a nonzero imaginary part**, and 2,604 of the 5,397 coefficients the test actually reads (48.2%) do.
- **Both error directions are real.** Columns `[[1, i], [i, -1]]` are Q(i)-dependent with real-part rank 2 -- a false pass. Columns `[[1, 1], [i, 2i]]` are Q(i)-independent with real-part rank 1 -- a false deficiency. The bug is therefore unsound in the direction that matters, not merely conservative.
- **It is inert here for the same reason claim 1 is fatal.** The unit rows that force the rank are exactly (1,0) and (0,0), so the discarded halves never reach the pivot. W3 and W4 above make the point operationally: zeroing every imaginary part and replacing every imaginary part with noise both leave the verdict unchanged.

Read as a check on the Gaussian arithmetic, the file therefore has zero coverage of the imaginary half of its own data.

## Bottom line

The file's passing run carries no information about the adapted basis, the word lists, the covariants, or the multiplicity-4 regime it advertises. `rank = m` is a restatement of `nullspace_G`'s echelon convention. This is the sixth attempt and, like the five before it, it passes its own assert; unlike some of them, it would pass with the object under test deleted.
