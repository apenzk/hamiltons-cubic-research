# Reviewer 66, isotropic subspaces of the Cartan 3-form on so(n)

Independent re-implementation throughout; no `b0_*.py` or other project script was read, imported or run. Scripts: [review_r66_core.py](../scripts/review_r66_core.py), [review_r66_c2_proof.py](../scripts/reviewers/r66/review_r66_c2_proof.py), [review_r66_c2_search.py](../scripts/review_r66_c2_search.py), [review_r66_c3.py](../scripts/reviewers/r66/review_r66_c3.py), [review_r66_c45.py](../scripts/reviewers/r66/review_r66_c45.py), [review_r66_c6.py](../scripts/review_r66_c6.py), [review_r66_c6_lambda.py](../scripts/reviewers/r66/review_r66_c6_lambda.py), [review_r66_su.py](../scripts/reviewers/r66/review_r66_su.py). Log: [reviewer66.log](agent_logs/reviewer66.log).

## Headline

**C2 is now a theorem, not a conjecture.** The maximal dimension of a subspace of so(n) on which the Cartan 3-form vanishes is exactly ⌊n²/4⌋, and the proof is four paragraphs of centraliser bookkeeping. **C5's gap at 8 is false**, so(2)+so(4) is a maximal isotropic subspace of dimension 8 at n = 6, and more generally *every* symmetric pair is maximal, so the spectrum contains p(n−p) for every split. **C6(a)'s stated mechanism is false**, though its conclusion survives. C1 and C4 are fine. C3 is unproved but better supported than before.

## Verdicts

| Claim | Verdict | One line |
|---|---|---|
| C1, S = 0 iff the negative eigenspace is isotropic | **CONFIRMED** | Immediate from the assumed formula for S; no off-by-one, no convention slip. |
| C2 (isotropic dim ≤ ⌊n²/4⌋, attained by the symmetric pair | **CONFIRMED) and PROVED** | A complete proof is given below. It is short, elementary, and tight at every step. |
| C3, rigidity at the cap | **PLAUSIBLE, strengthened** | 12/12 at n=5 and 12/12 at n=6, reconstructed *constructively*, the split of Rⁿ is recovered from the commutant of [m,m] rather than fitted. Still not proved. |
| C4, maximality is the rank identity rank[m,m] = N − dim m | **CONFIRMED** | The logic is right, including the point the brief flags: the new vector imposes no extra condition. |
| C5, dimension spectrum {5,6,7,9} at n = 6, gap at 8 | **REFUTED** | so(2)+so(4) is a *maximal* isotropic subspace of dimension **8**. The spectrum is {5,6,7,8,9}; there is no gap. |
| C6(a), the transportation LP cannot see S = 0 | **REFUTED as stated** | At the LP's own maximising spectrum the (−−−) mass is 12, not 0, and imposing S = 0 makes that spectrum **infeasible**. The fence post's *conclusion* nevertheless survives for a different reason. |
| C6(b), the 6/4/2 marginal identity | **CONFIRMED**; the inference drawn from it is **not** | The identity and its multiplicities are exactly right. "S = 0 pushes mass into (+−−)" does not follow from it. |

## Conventions, re-derived from scratch

With ⟨X,Y⟩ = ½ tr(XᵀY) the φ_ij = E_ij − E_ji (i<j) are orthonormal, and

  ω(x,y,z) = ⟨[x,y],z⟩ = **−tr(xyz)**,

verified to machine precision at n = 4,5,6. In the φ basis ω is supported exactly on the *triangles* of K_n (the triples {φ_ij, φ_jk, φ_ik}), with all nonzero values ±1, and the number of nonzero unordered triples equals C(n,3) exactly. Consequently:

> **A coordinate subspace span{φ_e : e ∈ S} is isotropic if and only if the graph S is triangle-free.**

Checked exhaustively over all 2^N coordinate subspaces at n = 4,5,6: zero mismatches. So the coordinate part of C2 *is* Mantel's theorem, and ⌊n²/4⌋ with the complete bipartite extremal graph is exactly the symmetric pair so(p)+so(q). The whole content of C2 is whether a non-coordinate subspace can beat Mantel.

## C2, proof that the maximum is ⌊n²/4⌋

This is the claim the brief calls load-bearing. It is true, and here is a proof.

### The class and the candidate function

Let **C** be the class of compact Lie algebras that are finite direct sums of abelian factors, su(k)'s and so(k)'s, each carrying *any* ad-invariant inner product. Define, additively over the factors,

  Φ(abelian) = dim,  Φ(su(k)) = (k² + k − 2)/2,  Φ(so(k)) = ⌊k²/4⌋.

Φ is consistent under the exceptional isomorphisms: Φ(so(3)) = Φ(su(2)) = 2, Φ(so(4)) = Φ(su(2)⊕su(2)) = 4, Φ(so(6)) = Φ(su(4)) = 9, Φ(so(2)) = Φ(u(1)) = 1.

**Theorem.** For every g ∈ **C** and every subspace m ⊆ g with ω|_m = 0, dim m ≤ Φ(g). In particular an isotropic subspace of so(n) has dim ≤ ⌊n²/4⌋, and the bound is attained by the off-diagonal part of so(⌈n/2⌉)+so(⌊n/2⌋).

### Three lemmas

**Lemma A (the symplectic squeeze).** Let m be isotropic and u ∈ m. Then

  dim m ≤ dim(m ∩ c(u)) + (dim g − z(u))/2,  z(u) := dim c(u).

*Proof.* β_u(x,y) := ⟨[u,x],y⟩ is bilinear, and alternating because β_u(x,x) = ω(u,x,x) = 0. Its radical is {x : [u,x] ⊥ g} = c(u), so β_u descends to a symplectic form on g/c(u), of dimension dim g − z(u). Since u ∈ m and ω vanishes on m, β_u(x,y) = ω(u,x,y) = 0 for x,y ∈ m, so the image of m in g/c(u) is isotropic for that symplectic form, hence of dimension at most half. ∎

**Lemma B (descent).** c(u) is a subalgebra, the inner product restricts to an ad-invariant one, and ω|_{c(u)} is precisely the Cartan 3-form of c(u). Hence m ∩ c(u) is an isotropic subspace of c(u). ∎

**Lemma C (centre split).** If g = z ⊕ g′ with z the centre, then dim m ≤ dim z + F(g′), where F denotes the maximal isotropic dimension. *Proof.* [z,g] = 0 and z ⊥ g′, so ω(x,y,w) depends only on the g′-components; ω|_m = 0 therefore says exactly that ω_{g′} vanishes on the projection π′(m), which is a subspace of g′ all of whose triples lift. So dim π′(m) ≤ F(g′) and dim m ≤ dim ker(π′|_m) + dim π′(m) ≤ dim z + F(g′). ∎

### The master identity

Everything turns on an arithmetic identity, which holds **with equality for every u**, not merely as an inequality.

*In so(k)*: an element u has nonzero eigenvalue-pairs of multiplicities m₁,…,m_s and kernel dimension n₀, with k = 2ΣM + n₀ where M = Σm_j; then c(u) = ⊕_j u(m_j) ⊕ so(n₀) and z(u) = Σm_j² + n₀(n₀−1)/2. With Φ(u(m)) = 1 + Φ(su(m)) = m(m+1)/2,

  Φ(c(u)) + (dim so(k) − z(u))/2 = M² + M n₀ + ⌊n₀²/4⌋ = ⌊k²/4⌋ = Φ(so(k)).

*In su(k)*: u has eigenvalue multiplicities a₁,…,a_t with Σa_j = k; c(u) = s(∏ u(a_j)) = ⊕_j su(a_j) ⊕ R^{t−1} and z(u) = Σa_j² − 1; then

  Φ(c(u)) + (dim su(k) − z(u))/2 = (k² + k − 2)/2 = Φ(su(k)).

Both are elementary two-line computations; both were also machine-checked over **every** multiplicity pattern for every k ≤ 40, **0 violations** ([review_r66_c2_proof.py](../scripts/reviewers/r66/review_r66_c2_proof.py)).

### The induction

Strong induction on dim g, for g ∈ **C** with any invariant inner product.

1. If the centre z is nontrivial, Lemma C plus the inductive bound on g′ (smaller) gives dim m ≤ dim z + Φ(g′) = Φ(g).
2. Otherwise g is semisimple. If m = 0 we are done. Otherwise pick u ∈ m, u ≠ 0. Because the centre is trivial, c(u) ⊊ g, and c(u) ∈ **C** (centralisers of so(k) and su(k) are as listed above, and a centraliser in a direct sum is the direct sum of the centralisers). Lemmas A and B and the inductive hypothesis give

   dim m ≤ dim(m ∩ c(u)) + (dim g − z(u))/2 ≤ Φ(c(u)) + (dim g − z(u))/2,

   and for g a single so(k) or su(k) the last expression *equals* Φ(g) by the master identity, while for g = ⊕g_i it equals Σ_i [Φ(c_i(u_i)) + (dim g_i − z_i)/2] = Σ_i Φ(g_i) = Φ(g), the per-factor identity applying also when u_i = 0 (then c_i = g_i and z_i = dim g_i). ∎

Nothing in the argument depends on the choice of invariant inner product, which is why the direct-sum case goes through even though a *non-product* subspace of g₁⊕g₂ can be isotropic (for instance the graph of an orientation-reversing isometry su(2) → su(2) inside so(4) is isotropic of dimension 3).

### Why the bound is exactly tight

For u ∈ m with distinct nonzero eigenvalues, z(u) = rank so(n) = ⌊n/2⌋ and Lemma A alone already gives dim m ≤ (N + ⌊n/2⌋)/2, which is **identically ⌊n²/4⌋** for every n, even and odd, measured at n = 5,6,7,8 as 6, 9, 12, 16. The symmetric pair does contain regular elements (take A with distinct singular values), so the squeeze is attained. The whole role of the induction is to cover the elements of m that are *not* regular; the master identity says the loss from degeneracy is exactly compensated by the extra room inside the bigger centraliser.

### What this settles downstream

* Every argument in the programme that used ⌊n²/4⌋ as a conjecture may now use it as a theorem.
* The lower bound needs the symmetric pair only, and that is one line: [m,m] ⊆ k ⊥ m.
* Two corollaries fall out. (i) An isotropic m of dimension > ⌊n²/4⌋ would have to consist entirely of non-regular elements, which is what the numerics were unknowingly probing. (ii) C3 ⟹ C2: since the symmetric pair is a *maximal* isotropic subspace (see C4/C5), if every cap-dimensional isotropic were conjugate to it then no (cap+1)-dimensional isotropic could exist, because each of its hyperplanes would be a cap-dimensional isotropic sitting inside something bigger.

### The counterexample hunt, run anyway

An independent Levenberg–Marquardt search on the Stiefel manifold (residuals ω(v_i,v_j,v_k) for i<j<k plus √μ(VᵀV − I), analytic Jacobian, multi-start) finds nothing above the cap:

| n | control at ⌊n²/4⌋ | target at ⌊n²/4⌋+1 |
|---|---|---|
| 5 | mass 9.6e−31, found on the first start | best mass **8.400000** over 60 starts |
| 6 | mass 3.0e−30, found on the first start | best mass **18.000000** over 8 starts |
| 7, 8 | control found | targets not run, C2 became a theorem first |

The n = 5 floor reproduces the reported 8.4 exactly. At n = 6 this reviewer's floor is 18.0 against the reported 16.6, i.e. the project's optimiser found a deeper local minimum than mine over the runs performed; neither is zero, and the discrepancy is a property of the search, not of the geometry. The control succeeds on the *first* start at both n, so the failure at cap+1 is not an optimiser artefact.

## C1, S = 0 ⟺ the negative eigenspace is isotropic

**CONFIRMED**, and it really is immediate. Taking the assumed formula S = Σ c′²_{αβγ} over triples of negative indices at face value: S is a sum of squares, so S = 0 ⟺ c′_{αβγ} = ⟨[v_α,v_β],v_γ⟩ = 0 for every triple of negative indices ⟺ ω vanishes on a basis of m ⟺ ω|_m = 0 by trilinearity. The two places an off-by-one could hide are both harmless: triples with a repeated index contribute 0 automatically (ω is alternating, verified with zero antisymmetry error at n = 4,5,6), and ordered-versus-unordered summation changes only a factor 6, not the vanishing locus. No correction.

## C4, maximality is the rank identity

**CONFIRMED**, including the specific worry the brief raises.

* *Does the new vector impose extra conditions?* No. Enlarging m to m ⊕ Rw requires ω to vanish on all triples from the larger space. Triples with three vectors from m vanish by hypothesis; triples with two copies of w vanish because ω is alternating; so the only genuine condition is ω(u,v,w) = 0 for u,v ∈ m, i.e. w ⊥ [m,m]. It is linear in w, exactly as claimed.
* *Is rank[m,m] ≤ N − dim m automatic?* Yes: isotropy says [m,m] ⊆ m^⊥, so rank[m,m] ≤ dim m^⊥ = N − dim m. Equivalently m ⊆ [m,m]^⊥ always, so maximality ⟺ [m,m]^⊥ = m ⟺ rank[m,m] = N − dim m. Sanity check in the other direction: random *non*-isotropic subspaces of so(6) of dimension 7 and 9 give rank[m,m] = 15 > N − d, as they must.
* One necessary condition worth recording, which the rank criterion makes free: a maximal isotropic subspace needs C(d,2) ≥ N − d, since [m,m] is spanned by C(d,2) brackets. At n = 6 this already rules out d ≤ 4 **for all subspaces, not just generic ones**, C(4,2) = 6 < 11.

## C5, the dimension spectrum at n = 6: the gap at 8 does not exist

**REFUTED.** The counterexample is not exotic:

> **Every symmetric pair is a maximal isotropic subspace.** For m = the off-diagonal block of so(p)+so(q), [m,m] = so(p) ⊕ so(q) = m^⊥ exactly (including p = 1, where [φ_{0j},φ_{0k}] = −φ_{jk} spans so(q)). Hence [m,m]^⊥ = m and m cannot be enlarged, at any n and any split.

So the spectrum of maximal isotropic dimensions of so(n) contains **{p(n−p) : 1 ≤ p ≤ n/2}**. At n = 6 that is {5, **8**, 9}. Verified directly by solving the linear system {w : ω(u,v,w) = 0 ∀u,v ∈ m} and checking its solution space *equals* m: at n = 6, so(2)+so(4) has dim m = 8, rank[m,m] = 7 = N − d, and ‖(I − P_m)[m,m]^⊥‖ = 0. Same at n = 7 (dims 6, 10, 12 all maximal) and n = 8 (7, 12, 15, 16 all maximal).

An exhaustive enumeration of coordinate subspaces makes the same point combinatorially: **all 211 edge-maximal triangle-free graphs on 6 labelled vertices give maximal isotropic subspaces**, and their edge counts are 5 (6 graphs), 7 (180), 8 (15 (these are the K_{2,4}'s), 9 (10), the K_{3,3}'s). Coordinate maximal dimensions are {5,7,8,9}; adding the non-coordinate polished draws at d = 6 gives

  **spectrum at n = 6 = {5, 6, 7, 8, 9}, no gap.**

**Why the reported search missed it.** The reported protocol polishes *random* isotropic subspaces of dimension 8. A random isotropic 8-plane is a generic hyperplane inside a 9-dimensional cap subspace, hence extendable; the K_{2,4} stratum is a measure-zero subvariety that random starts will never land on. The d = 8 row is therefore a true statement about generic 8-planes and a false one about the spectrum. The same caution applies to reading "d = 2,3,4 generic subspace EXTENDS" as a spectrum statement, there the conclusion happens to be right, but for the independent reason C(d,2) < N − d, not because the sampling was exhaustive.

This reviewer's independent per-dimension polish at n = 6 (8 draws each, all polished to mass < 1e-30):

| d | random polished draws that are maximal | verdict |
|---|---|---|
| 2, 3, 4 | 0/8 | always extend, provable, C(d,2) < N − d |
| 5 | 8/8 | maximal dimension |
| 6 | 8/8 | maximal dimension |
| 7 | 8/8 | maximal dimension |
| 8 | **0/8** | random draws extend, **but so(2)+so(4) does not**, 8 is in the spectrum |
| 9 | 8/8 | the cap |
| 10 | no isotropic subspace exists | now a theorem |

**Rows that do survive.** d = 5, 6, 7 maximal (8/8 each in this reviewer's independent polish, matching 14/14 and 13/14), and d = 10 impossible, now a theorem, not an observation, since 10 > ⌊36/4⌋ = 9.

## C3, rigidity at the cap

**PLAUSIBLE**, and the evidence is now stronger than a fitted group element, but it is still not proved.

Instead of fitting g ∈ SO(n) to minimise ‖Λ²(g) P Λ²(g)ᵀ − P_sym‖², this reviewer reconstructs the splitting *from the subspace itself*: form k = [m,m] as a set of n×n matrices, compute the commutant of k inside the symmetric matrices on Rⁿ, and read the isotypic decomposition off a generic element of that commutant. If m is conjugate to a symmetric pair the commutant is exactly 2-dimensional and its two eigenprojections are the projections onto V and V′; the test then checks that every element of m has *zero* block-diagonal part in that frame. This produces the conjugating rotation rather than assuming one exists, and it fails loudly if the commutant has the wrong dimension.

Results (random cap-dimensional isotropic subspaces, polished to mass < 1e−18):

| n | cap | draws reconstructed as a symmetric pair |
|---|---|---|
| 5 | 6 | 12/12, split 2+3 |
| 6 | 9 | 12/12, split 3+3 |
| 7 | 12 | control passes (split 3+4); the draw loop was killed for CPU before finishing |
| 8 | 16 | not reached |

In every case the commutant of [m,m] came out exactly 2-dimensional, the isotypic decomposition had exactly two blocks of the right sizes, and the block-diagonal part of every element of m was zero to 1e-15 relative to the off-block scale. The control (the symmetric pair fed in directly) passes, and a deliberately non-isotropic subspace fails the commutant-dimension test, so the test is not vacuous.

**Lemma A is an equality at the cap, measured.** On random SO(n)-conjugates of the cap symmetric pair, for every u drawn from m: dim(m ∩ c(u)) = z(u) exactly and dim m = z(u) + (N − z(u))/2, at n = 5,6,7,8, 6/6 draws each. So m does swallow the whole centraliser of each of its regular elements, the structural handle below is real, not hypothetical.

**What the proof of C2 already gives towards C3.** At the cap the induction is tight at every step, so for *every* nonzero u ∈ m simultaneously: (i) dim(m ∩ c(u)) = Φ(c(u)), i.e. m meets each centraliser in a cap-dimensional isotropic subspace of it, and (ii) the image of m in g/c(u) is Lagrangian for β_u. Taking u ∈ m with distinct nonzero eigenvalues and trivial kernel, c(u) is a maximal torus of dimension p and Φ(c(u)) = p, so **m contains the entire maximal torus through u**. That is a strong structural handle (the symmetric pair does contain maximal tori ({A diagonal} inside {[[0,A],[−Aᵀ,0]]})) and it is the natural starting point for a proof of C3. This reviewer did not complete one.

**On the risk the brief names.** A least-squares fit ‖Λ²(g)PΛ²(g)ᵀ − P_sym‖² ≤ 1.1e−10 is a *sufficient* certificate, not a false positive risk: the residual is a genuine distance between two projectors, and a residual that small over a 15- or 28-dimensional space cannot be produced by a near-miss. The weakness of that protocol is coverage, not soundness, it can only ever confirm the subspaces it is handed. The commutant test above has the same coverage limitation.

## C6(a), the transportation LP and S = 0

**REFUTED as stated; the conclusion the fence post draws survives on other grounds.**

This reviewer rebuilt the relaxation independently from the identity θ = Σ_α λ_α³ + 3 Σ_{α<β<γ} T_{αβγ} λ_α λ_β λ_γ, relaxing T to any nonnegative totally symmetric tensor with the row marginal Σ_{β,γ} T_{αβγ} = 2(n−2) and the pair cap Σ_γ T_{αβγ} ≤ 2. Hill-climbing over unit trace-free spectra at n = 6 returns **1.7222**, which matches the project's corrected figure 1.7227 on the same constraint set, so the reconstruction is the same LP.

Three findings, in increasing order of damage:

1. **The (−−−) mass is not always 0 at an optimum.** At random spectra with 8 negative eigenvalues the free optimum carries (−−−) mass 1.33 and 2.00, not 0.
2. **Imposing S = 0 therefore does change the value at a fixed spectrum.** Measured drops: 1.024962 → 1.024841 and 1.232827 → 1.227597.
3. **At the LP's own maximising spectrum the constraint is not merely binding, it is fatal.** The maximiser has 12 negative eigenvalues out of 15 and carries (−−−) mass **12.0**; with T forced to vanish on (−−−) triples the LP at that spectrum is **infeasible**. Re-running the hill-climb *inside* the S = 0 constraint tops out at **1.704030** (9 negatives) against **1.722172** free, the constrained optimum genuinely sits lower.

Findings 1–3 are exact LP solves at fixed spectra, so they do not depend on the climb converging; only the comparison 1.7040 vs 1.7222 does, and both climbs are lower bounds on their respective maxima.

The reasoning error is the step "those triples carry λ_αλ_βλ_γ < 0, so a maximiser empties them anyway". A maximiser empties a negative-coefficient variable only when it is free to; here the row marginals are *equalities*, so every index must dispose of mass n−2, and when negative indices outnumber positive ones the pair caps leave nowhere else to put it. That is precisely the regime (many negative eigenvalues) where the overshoot lives.

**What survives.** At the *fixed* spectrum in finding 2 the constrained LP still returns 1.2276 > √(3/2) = 1.2247, so S = 0 does not by itself pull the relaxation below the target. The fence post's operational conclusion, *any argument for item B must use S = 0 through something other than the bracket tensor's marginals*, therefore stands. But it stands because the S = 0-constrained LP still overshoots, **not** because S = 0 is invisible to it. Those are different statements, and the recorded one is false. Worth re-running the project's own LP with the full constraint set to see how much value the S = 0 restriction actually recovers; on this reviewer's evidence it recovers a great deal, up to and including cutting off the worst spectra entirely, which would make S = 0 a *useful* LP constraint rather than an inert one.

## C6(b), the 6/4/2 identity

**CONFIRMED**, with the derivation, and the multiplicities are forced.

Row marginal: Σ_{β,γ} T_{αβγ} = ‖ad(e_α)‖²_HS = −tr(ad(e_α)²) = −K(e_α,e_α) = 2(n−2), using the Killing form K(X,Y) = (n−2)tr(XY) = −2(n−2)⟨X,Y⟩ on so(n). Measured: every row marginal equals 8.000000000000 at n = 6, in random orthonormal frames.

Summing that over the d indices in m gives 2d(n−2). On the left, an unordered triple with distinct indices is counted once for each of its m-indices in the first slot, times 2 for the order of the other two: an all-m triple 3×2 = **6** times, a two-in-m triple 2×2 = **4**, a one-in-m triple 1×2 = **2**. Triples with repeated indices contribute 0. Hence

  6 S_mmm + 4 S_mmh + 2 S_mhh = 2d(n−2).

Verified over random orthonormal frames of so(6) at *every* split size d, max deviation 4.3e−14. The multiplicities are not fittable: replacing (6,4,2) by (6,4,3), (6,5,2), (5,4,2) or (3,2,1) gives 64.44, 63.52, 54.49, 28.00 against the true 56.00.

**The inference drawn from it does not follow.** "S = 0 deletes a negative contribution and pushes its mass into (+−−)" reads the identity as a conservation law for mass, which it is not: it constrains one *weighted* combination, with unequal weights 6, 4, 2. Setting S_mmm = 0 leaves 4 S_mmh + 2 S_mhh = 2d(n−2), which is satisfied by moving the freed mass into S_mmh, into S_mhh, or into any mixture, and the three blocks carry different signs in θ. So the identity is compatible with S = 0 raising θ, lowering it, or leaving it alone; it does not select the first. The honest statement is that this identity provides **no** bound on θ under S = 0 in either direction, which is enough to make it a fence post, but the causal story attached to it should be dropped.

## What I attacked and failed to break

* **C2 by construction.** Tried and failed: abelian subalgebras, every one tried came out far below n²/4, e.g. the abelian nilradical Λ²Cᵐ of the Siegel parabolic in so(2m) has dimension m(m−1)/2 ≈ n²/8; nilpotent and parabolic nilradicals; Cartan-plus-root-space assemblies; three-block "path" configurations Hom(V₁,V₂) ⊕ Hom(V₂,V₃), which are triangle-free but give n₂(n−n₂) ≤ n²/4 again; graphs of linear maps m₀ → k₀ twisting the symmetric pair. Every construction that works is a Mantel extremal graph in disguise, and the proof now explains why.
* **C2 numerically.** Multi-start Levenberg–Marquardt with analytic Jacobian at ⌊n²/4⌋+1 for n = 5, 6, with a control at ⌊n²/4⌋ that succeeds on the first start every time. Nothing found; residual floors 8.4 (n=5, matching the project) and 18.0 (n=6).
* **C4's logic.** Looked specifically for the extra conditions the new vector might impose. There are none; the alternating property kills every triple that repeats w.
* **C3 by finding two inequivalent cap subspaces.** Nothing found; every draw reconstructed a genuine orthogonal splitting of Rⁿ from [m,m] alone.

## Gaps in arguments I nonetheless believe

1. **C3 is unproved.** The equality analysis of the C2 proof gets as far as "m contains a maximal torus and meets every centraliser in a cap subspace of it". Closing that to conjugacy is real work that was not done here. The numerics are consistent and now constructive, but they are numerics.
2. **The C2 proof's only soft spot is bookkeeping, not logic.** The class **C** must be closed under centralisers, and the identity must hold for every multiplicity pattern; both were checked, the second exhaustively to k = 40 and by hand. If a reader wants one thing double-checked, make it the centraliser of a real skew matrix in so(k): ⊕_j u(m_j) ⊕ so(n₀), with u(m_j) attached to the *complex* eigenspace of a conjugate pair, so its dimension is m_j² and not 2m_j².
3. **C6(a)'s constraint set.** This reviewer's LP carries nonnegativity, total symmetry, row marginals and pair caps, and reproduces the project's 1.7227 at n = 6. It does *not* carry the full vector identity Rλ = −2λ that the project's later constraint set adds. The refutation of "S = 0 is invisible" should be re-run against that fuller set before it is treated as final, though it would be surprising for extra constraints to restore invisibility, since they only shrink the feasible set further and the S = 0 restriction was already infeasible at the maximiser.

## Side-check: the su(k) branch of the induction

The so(n) induction consumes Φ(su(k)) = (k²+k−2)/2 through the u(m_j) factors of a centraliser, so that value is load-bearing and was checked separately from scratch ([review_r66_su.py](../scripts/reviewers/r66/review_r66_su.py)): su(k) built as traceless skew-Hermitian with ⟨X,Y⟩ = −tr(XY), the Cartan 3-form formed, the symmetric pair su(k)/so(k) (m = i·(traceless real symmetric), dimension k(k+1)/2 − 1 = (k²+k−2)/2), confirmed isotropic, and the same LM search run one dimension above.

| k | Φ(su(k)) | control | target Φ+1 |
|---|---|---|---|
| 2 | 2 | found, mass 1.3e−32 | best mass **12.0**, none found |
| 3 | 5 | found, mass 2.6e−27 | best mass **12.0** over 30 starts, none found (reproduced twice) |
| 4 | 9 | found, mass 8.5e−30 | not run, su(4) ≅ so(6), already covered |

So Φ(su(2)) = 2 and Φ(su(3)) = 5 are confirmed by search as well as by the induction. su(2) is a complete check: ω on a 3-dimensional space is a volume form, whose maximal isotropic dimension is exactly 2, matching Φ. The consistency of Φ across the exceptional isomorphisms (Φ(so(3)) = Φ(su(2)), Φ(so(6)) = Φ(su(4)) = 9, Φ(so(4)) = Φ(su(2))+Φ(su(2))) is a further four independent constraints on the pair of formulas, all satisfied.

## Housekeeping

Files added: this report, seven scripts under [scripts/](../scripts/) with entries in [scripts/README.md](../scripts/README.md), and [reviewer66.log](agent_logs/reviewer66.log). Nothing was committed. No project script was read or executed.


---

## Synthesis carried in REVIEW.md

### Reviewer 66: the same claims, on an identical brief

Full report in [reviews/REVIEW_r66.md](reviews/REVIEW_r66.md). **Proved C2 independently, by a different route**, a centraliser induction. With $\beta_u(x,y)=\langle[u,x],y\rangle$ alternating with radical $\mathfrak c(u)$, one gets $\dim\mathfrak m\le\dim(\mathfrak m\cap\mathfrak c(u))+(\dim\mathfrak g-z(u))/2$; $\mathfrak m\cap\mathfrak c(u)$ is isotropic in $\mathfrak c(u)$, a subalgebra of the same class; and the master identity $\Phi(\mathfrak c(u))+(\dim\mathfrak g-z(u))/2=\Phi(\mathfrak g)$ holds for every eigenvalue-multiplicity pattern, checked at every $k\le40$ with zero violations. Induction on $\dim\mathfrak g$ closes it. Tightness confirmed: on cap subspaces $\dim(\mathfrak m\cap\mathfrak c(u))=z(u)$ and the first lemma is an equality, $6/6$ at $n=5,\dots,8$.

**Refuted the dimension spectrum.** Every symmetric pair is maximal isotropic at every $n$, since $[\mathfrak m,\mathfrak m]=\mathfrak{so}(p)\oplus\mathfrak{so}(q)=\mathfrak m^\perp$ exactly. At $n=6$, $\mathfrak{so}(2)\oplus\mathfrak{so}(4)=K_{2,4}$ puts **8** in the spectrum. Further: **all $211$ edge-maximal triangle-free graphs on six labelled vertices give maximal isotropic subspaces**, at dimensions $5,7,8,9$, so the spectrum is $\{5,6,7,8,9\}$ and the recorded gap does not exist. The earlier census missed it because random polished $8$-planes are generic hyperplanes inside $9$-dimensional cap subspaces while $K_{2,4}$ is a measure-zero stratum; its own random draws reproduce $0/8$ maximal at $d=8$.

**Refuted fence post F17 as stated.** At the free maximiser the $(---)$ mass is $12.0$, not $0$, and imposing $S=0$ there is infeasible; the constrained maximum over spectra drops to $1.7040$. The error was assuming a maximiser empties negative-coefficient triples, the row marginals are equalities, so when negatives outnumber positives there is nowhere else to put the mass. The conclusion survives for a different reason, and its own suggested follow-up (re-running against the vector identity), is done above and also survives.

**In the $\varphi$ basis $\omega$ is supported exactly on the triangles of $K_n$**, so a coordinate subspace is isotropic iff its graph is triangle-free: the coordinate case of the cap is literally Mantel's theorem.
