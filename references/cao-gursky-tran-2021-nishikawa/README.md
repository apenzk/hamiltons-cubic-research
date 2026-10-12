# Cao, Gursky, Tran 2021, Curvature of the second kind and a conjecture of Nishikawa

| | |
| --- | --- |
| **Source** | [Curvature of the Second kind and a conjecture of Nishikawa](https://arxiv.org/abs/2112.01212) |
| **Authors** | Xiaodong Cao, Matthew J. Gursky, Hung Tran |
| **Identifier** | arXiv:2112.01212v1 [math.DG], 2 Dec 2021, 18 pages. Published as Comment. Math. Helv. 98 (2023) |
| **Retrieved** | 2026-09-02 |

## Consulted for

The origin of the $k$-positivity conditions on the second-kind operator $\hat R|_{S^2_0}$ that the record's other second-kind sources build on, it is the [CGT21] that [li-2021-nonnegative-second-kind](../li-2021-nonnegative-second-kind/README.md) improves and that [elhasan-li-npw-2026-calabi-operator](../elhasan-li-npw-2026-calabi-operator/README.md) and [cone-conditions-2025-second-kind](../cone-conditions-2025-second-kind/README.md) inherit their framing from. Read here for its §3 method (a fixed list of explicit trace-free symmetric two-tensors, evaluated against $\hat R$ and summed under the first Bianchi identity) and its §5.1 sharpness models.

## Statements that matter

- **Theorem 1.4**: $\hat R$ two-positive (resp. two-non-negative) on a manifold of dimension $n\ge4$ implies PIC1 (resp. NIC1). **Theorem 1.5**: four-positive (resp. four-non-negative) implies PIC (resp. NIC). Both are pointwise algebraic, proved by testing $\hat R$ against six named tensors and applying the first Bianchi identity.
- **Theorem 1.2**: two-positive $\hat R$ on a closed manifold gives a spherical space form, settling the positive half of **Conjecture 1.1** (Nishikawa) under a weakened hypothesis. **Theorem 1.7**: compact Einstein, $n\ge4$, four-positive $\hat R$ gives constant sectional curvature; four-non-negative gives locally symmetric.
- **Theorem 1.8** gives the block form of $\hat R$ on $S^2_0(TM^4)$ in dimension four, with diagonal blocks $D_i$ built from the $W^\pm$ eigenvalues and $S$, and skew blocks $O_1,O_2,O_3$ vanishing exactly when the metric is Einstein. In the Einstein normalisation $Rc=g$ the eigenvalues of $\hat R$ are $\frac13-\lambda_i-\mu_j$.
- **Theorem 1.9**: a simply connected Einstein four-manifold with five-non-negative $\hat R$ is $S^4$ or $(\mathbb{CP}^2,g_{FS})$ up to scale. Sharpness is carried by two explicit four-dimensional models in §5.1: $(\mathbb{CP}^2,g_{FS})$ is 5-positive but not 4-positive, and $(S^2\times S^2,g_p)$ has $\hat R=4\,\mathrm{diag}(-1,0,0,0,0,1,1,1,1)$, so it fails five-non-negativity while satisfying six-non-negativity.

## Verdict

**A sphere-and-rigidity programme under lower eigenvalue bounds on $\hat R$, carrying nothing about the maximum of the cubic.** What transfers is the §3 technique, bounding an isotropic-curvature expression by evaluating $\hat R$ on a hand-picked orthogonal family in $S^2_0$ and closing with the first Bianchi identity, and the §5.1 eigenvalue lists for $(\mathbb{CP}^2,g_{FS})$ and $(S^2\times S^2,g_p)$, which are usable as reference data. Its own theorems are conclusions about diffeomorphism type, so they answer a different question than the record's.

## Provenance, the folder previously held the wrong paper

From an unknown date until 2026-09-02 this folder held `cgt-2112.08465.pdf`, which was **Xiaolong Li's arXiv:2112.08465**, byte-identical (MD5 `477dfed645f4875552332bca31586347`) to the copy correctly filed in [li-2021-nonnegative-second-kind](../li-2021-nonnegative-second-kind/README.md); the two arXiv ids differ only in their last four digits. The README's earlier **Statements that matter** and **Verdict** were written against that substitute and have been replaced. Two of their claims failed against the real paper: the operator acts on $S^2_0(V)$ rather than $\mathrm{Sym}^2(\Lambda^2)$, and the paper's thresholds count eigenvalues ($k$-positivity) rather than dimensions. The duplicate PDF and its `.txt` were deleted, the correct paper fetched from arXiv, and [notes.md](notes.md) transcribed from it.
