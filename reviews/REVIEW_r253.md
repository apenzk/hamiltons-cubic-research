# REVIEW r253 -- Gate 2, claims 1 and 2 (the independence test: is it sound, and does its validation mean anything)

Reviewer 253. Commits under review: 01edd64 (primary), 3a50615.
Primary file: [scripts/runs/run_covariant_independence.py](../scripts/runs/run_covariant_independence.py).
Scripts: [scripts/reviewers/r253/](../scripts/reviewers/r253/).

## Verdict table

| Claim | Subject | Verdict |
|---|---|---|
| 1 | `<P D(W), U> = <D(W), P U> = <D(W), U>` | **STANDS ONLY UNDER A HYPOTHESIS THE FILE NEVER STATES**, and the construction it enables is unnecessary |
| 1b | What happens when U is only approximately in the target | **FAILS TOWARD THE DESIRED CONCLUSION** -- misalignment raises the rank, so an approximate U reports independence. Threshold measured: eps > 3.1e-10 |
| 2 | Is the validation vacuous? | **REFUTED** -- rank 1 is a pointwise Bianchi identity, and a degree-only evaluation scheme passes both asserts |
| -- | Side finding: the "projector-free GRAM" printed for contrast | **FABRICATED** -- hard-coded exponents, three of them wrong, and the comment contradicts the printed rank |

Headline: the mathematics of claim 1 is repairable and in fact true for the projector actually at issue, but the file's *reason* for it is not a reason; the validation of claim 2 is passed by a scheme that reads only the degree of a diagram and throws the diagram away.

---

## Claim 2 -- REFUTED. The validation is vacuous, and the quadratic-vs-quartic control does not catch the wrong scheme.

Witness: [r253_claim2_vacuous.py](../scripts/reviewers/r253/r253_claim2_vacuous.py).

### The rank-1 result is a pointwise identity of the Riemann symmetries

The three carriers at [run_covariant_independence.py:65-69](../scripts/runs/run_covariant_independence.py#L65) are not merely dependent as functions on Weyl_n -- they are proportional at every point of the ambient space of Riemann-symmetric tensors, with constant ratios (1, 1/2, 1):

- `c3 = W_abcd W_cdab = W_abcd W_abcd = c1` by the pair symmetry alone, which the file's own sampler imposes at [line 60](../scripts/runs/run_covariant_independence.py#L60).
- `c2 = W_abcd W_acbd = c1/2` by the first Bianchi identity alone.

Measured column ratios are exactly `[1, 0.5, 1]` on every sample. Rank 1 therefore also holds on tensors with their traces intact -- not in Weyl_n at all -- and at n = 4, where Weyl_n is not O(n)-irreducible:

| n | tensor class | rank | column ratios |
|---|---|---|---|
| 4 | Riemann, traces intact | 1 | 1, 0.5, 1 |
| 5 | Weyl (traceless) | 1 | 1, 0.5, 1 |
| 5 | Riemann, traces intact | 1 | 1, 0.5, 1 |
| 12 | Weyl (traceless) | 1 | 1, 0.5, 1 |
| 12 | Riemann, traces intact | 1 | 1, 0.5, 1 |

The docstring's premise -- "any two degree-2 carriers must be dependent AS FUNCTIONS **however different their carriers look**" ([lines 43-46](../scripts/runs/run_covariant_independence.py#L43)) -- is where it goes wrong. The carriers do not look different. Two of them are the same contraction, and the third differs by a factor of two. Tracelessness, the projector and the pairing are all untouched by the measurement.

### A wrong evaluation scheme that passes both asserts

Take the scheme S: **evaluate a diagram by reading its degree and discarding its index matching**, `S(D)(W) := ||W||^(2 deg D)`.

| the file's check | what it demands | what S returns |
|---|---|---|
| three degree-2 carriers, assert at [line 94](../scripts/runs/run_covariant_independence.py#L94) | rank 1 | rank **1** -- passes |
| quadratic-vs-quartic control, assert at [line 116](../scripts/runs/run_covariant_independence.py#L116) | rank 2 | rank **2** -- passes |

S is wrong in precisely the way that matters at n = 12: it returns rank 1 for any set of same-degree carriers, so it would report the 184 degree-3 covariants as spanning one dimension -- the maximal false dependence. The control at [line 113](../scripts/runs/run_covariant_independence.py#L113) cannot catch it, because it varies the **degree** (`c1` against `c1**2`) and so tests degree-sensitivity. The n = 12 run varies the **diagram at fixed degree**, which neither of the file's two checks touches at all.

So the closing claim at [lines 119-120](../scripts/runs/run_covariant_independence.py#L119), that the rank-1 results are "the irreducibility of Weyl_n, not a blind check", is exactly backwards on both halves.

### The control the file needs

Two same-degree invariants that are genuinely independent as functions on Weyl_n, e.g. `I1 = W_abcd W_cdef W_efab` and `I2 = W_abcd W_aecf W_bedf`:

| n | correct scheme on I1, I2 | wrong scheme S |
|---|---|---|
| 6 | rank 2 | rank 1 |
| 8 | rank 2 | rank 1 |
| 12 | rank 2 | rank 1 |

This separates S from a correct scheme. It costs three lines and reuses machinery already in the file.

---

## Claim 1 -- the identity is true for the projector at issue, but not for the reason given, and the U it needs is the expensive object the construction claims to avoid.

Witnesses: [r253_claim1_identity.py](../scripts/reviewers/r253/r253_claim1_identity.py), [r253_pairing_choice.py](../scripts/reviewers/r253/r253_pairing_choice.py), [r253_claim1_cost_and_repair.py](../scripts/reviewers/r253/r253_claim1_cost_and_repair.py).

### Step one, `<P D(W), U> = <D(W), P U>`: needs self-adjointness, which holds for the orthogonal Weyl projector

Built explicitly as pair antisymmetry, pair exchange, first Bianchi and trace removal -- the same pipeline as [weyl_random](../scripts/runs/run_covariant_independence.py#L50) -- and checked in the full-contraction pairing:

| n | `||P^2 X - P X|| / ||P X||` | `|<PX,Y> - <X,PY>| / |<PX,Y>|` |
|---|---|---|
| 6 | 1.1e-16 | 8.3e-16 |
| 12 | 9.9e-17 | 2.0e-16 |

So step one is sound for that P in that pairing. What the file offers as justification is not that, however.

### The stated reason is idempotence, and idempotence is not enough

The docstring's phrase, in capitals at [lines 25 and 31-32](../scripts/runs/run_covariant_independence.py#L25) -- "THE PROJECTOR MOVING ONTO U, WHERE IT ACTS AS THE IDENTITY" -- names two properties: `Q^2 = Q` and `Q U = U` for U in the target. Both are satisfied by operators for which the identity is false. Concretely, `Q = P + P B (I - P)` with B the index transposition b<->c is O(n)-equivariant with the same image as P:

| property | measured (n = 6) |
|---|---|
| `||Q^2 X - Q X|| / ||Q X||` | 1.5e-16 -- idempotent |
| `||Q U - U|| / ||U||` for U in the target | 1.1e-16 -- acts as the identity on the target |
| `|<QX,Y> - <X,QY>| / |<QX,Y>|` | **3.0e+00** -- not self-adjoint |
| `\|<Q D, U> - <D, U>\| / \|<Q D, U>\|` | **6.2e-01** -- **the identity fails** |

Such operators exist rather than being a formal worry: the traceless (2,2) block has multiplicity 2 in the 4-fold tensor power, so the space of equivariant idempotents onto a fixed copy is positive-dimensional and only one of them is orthogonal.

### And "the pairing the covariants are defined with" is not pinned down by invariance

Because of that same multiplicity, the O(n)-invariant symmetric forms on the ambient space are a multi-parameter family, and P is self-adjoint only for those making the target orthogonal to its complement. A one-parameter witness, `<A,C>_t = <A,C> + t<A, B C>` with B the same transposition (invariant, symmetric, positive definite for small `|t|`), where P and B fail to commute by a relative 1.2:

| t | `\|<P X, U>_t - <X, U>_t\| / \|<P X, U>_t\|` |
|---|---|
| 0 (full contraction) | 1.9e-16 |
| 1e-3 | 4.6e-04 |
| 0.1 | 4.4e-02 |
| 0.5 | 1.9e-01 |

The identity therefore carries a real hypothesis: *the pairing is the full contraction, and P is the orthogonal projector for it.* The file states neither, and asserts neither in code -- it never constructs a projector at all.

### Step two, `P U = U`: exact U is fine; approximate U fails in the dangerous direction

For U exactly in the target, step two holds for **any** idempotent with that image, so it is the weaker of the two. The sharp question is the brief's: any constructed U is only approximately in the target.

Decompose `U = U_par + U_perp` with `||U_perp|| = eps ||U||`. What the test computes is `a_c = <D_c(W), U>`; what it wants is `b_c = <F_c(W), U> = <D_c(W), U_par>`. The error is `a_c - b_c = <D_c(W), U_perp>`, and it is paired against the **projector-free** carrier, whose whole point is that it has mass outside the target. The relative contamination is `eps * kappa` with `kappa = ||D(W)|| / ||P D(W)||`.

Measured kappa for genuine degree-3 projector-free carriers: 1.02 to 2.42 across n = 6, 8, 12 -- O(1) for these, so the amplification is mild here and the failure is not about kappa blowing up. It is about the **direction**.

The witness: three carriers `D1`, `D2`, `D3 = D1 + K` with `K_abcd = delta_ab delta_cd I1(W)`, so `P K = 0` exactly (measured `||P K|| / ||K|| = 0`) and hence `F_3 = F_1` -- the true function rank is 2. At n = 8:

| U | sv3/sv1 | rank at the file's 1e-10 relative cut |
|---|---|---|
| exactly in the target | 3.2e-17 | 2 -- correct, dependence seen |
| eps = 1e-2 | 3.19e-03 | **3 -- false independence** |
| eps = 1e-6 | 3.19e-07 | **3 -- false independence** |
| eps = 1e-10 | 3.19e-11 | 2 |
| eps = 1e-14 | 3.20e-15 | 2 |

The spurious singular value tracks `0.32 * eps` exactly, so the cut at [line 86](../scripts/runs/run_covariant_independence.py#L86) is crossed at **eps > 3.1e-10**. Two consequences:

- The error is one-sided. Contamination adds generic content to the value matrix, so it can only **raise** the rank. A misaligned U reports independence -- which is the conclusion A2'' and A3 are waiting for. This is the failure mode that reads as a result, the same shape as the bug the file records at [lines 76-79](../scripts/runs/run_covariant_independence.py#L76).
- The tolerance is tight enough to matter. `eps < 3e-10` is reachable in float64, but only if U is produced by applying the target projector to a tensor -- which is exactly the operation the construction advertises as avoided.

### The construction is unnecessary, because the cost it is avoiding is not the cost the test pays

The stated motivation, at [lines 15-17 and 31-32](../scripts/runs/run_covariant_independence.py#L15), is that the projector's "dense 8-index form at n = 12 is 3.20 GB". That figure is right for P as an **operator** (12^8 doubles = 3.20 GB). The test never needs the operator; it needs P applied to n^4-entry tensors, which the file itself already does inside [weyl_random](../scripts/runs/run_covariant_independence.py#L50):

| object at n = 12 | size / cost |
|---|---|
| dense 8-index operator | 429,981,696 entries, 3.20 GB |
| P applied to one tensor | 0.16 MB, **0.4 ms** |

So the direct route -- form `F_c(W) = P(D_c(W))` and take the rank of the flattened value tensors -- is available, has no U to misalign and no eps, and gives the right answer on the same three carriers:

| n | direct-route rank | singular values | time |
|---|---|---|---|
| 8 | 2 | 1.47e+03, 1.95e+02, 7.1e-13 | 0.46 s |
| 12 | 2 | 8.13e+03, 1.20e+03, 2.9e-11 | 12.2 s |

The U-trick thus trades a cost it does not remove for a failure mode it introduces. (Its one structural cost saving would be the value matrix's width, which is claim 3's territory and belongs to r254.)

### The code does not exercise any of this

Independently of the mathematics: the three [CARRIERS](../scripts/runs/run_covariant_independence.py#L65) are scalar-valued, and no test tensor U, no projector P and no pairing appear anywhere in the executable part of the file. At degree 2 the target is the trivial representation, U is a scalar and P is the identity on it, so the identity holds vacuously. The validated case is therefore the one dimension in which the claim-1 machinery cannot be validated even in principle.

---

## Side finding -- the "projector-free GRAM" printed for contrast is hard-coded, and wrong

At [lines 104-109](../scripts/runs/run_covariant_independence.py#L104) the Gram is typed in as literal exponents rather than computed. The three carriers are the quadratic forms `X -> X_abcd X_sigma(abcd)`, whose Frobenius pairings are `n^cycles(sigma^-1 tau)`. Exponents, confirmed both combinatorially and by explicit n^4-by-n^4 form matrices at n = 5:

| | abcd | acbd | cdab |
|---|---|---|---|
| **true** | 4, 3, **2** | 3, 4, **1** | **2**, **1**, 4 |
| **file's** | 4, 3, **4** | 3, 4, **3** | **4**, **3**, 4 |

Three entries are wrong. Consequences:

- The true ambient Gram has rank **3** at n = 5 and n = 12; the file's matrix has rank 2 and that is what it prints.
- The comment at [line 101](../scripts/runs/run_covariant_independence.py#L101) says the Gram "has full rank", which the file's own printed 2 contradicts.

The rhetorical point survives -- the ambient Gram does exceed the function rank of 1 -- and is in fact stronger with the correct matrix. But a hard-coded matrix presented as a measurement is the same category of error as claim 2's: a number that reads as a result and is not one.

---

## What would have to change

1. **Replace the control.** Two same-degree carriers independent as functions on Weyl_n, so that the check tests diagram-sensitivity rather than degree-sensitivity. `I1` and `I2` above suffice and cost three lines.
2. **Replace the rank-1 target.** The degree-2 triple is dependent by Bianchi alone; a validation that exercises irreducibility needs carriers that are independent on the ambient space and dependent only on Weyl_n.
3. **State the identity's hypothesis** -- full-contraction pairing, orthogonal projector -- and assert self-adjointness in code, since idempotence plus acting-as-identity-on-the-target does not imply it.
4. **Either bound `eps` for the U's actually used, or drop the U-trick** for the direct route, which is cheap and has no eps.
5. **Compute the contrast Gram** instead of typing it in.
