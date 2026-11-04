# Step 9 sweep, 2026-09-25: an ingredient for I73's sub-step (c) beyond the linear class-level system

*Position file: [2026-09-25-step9-position.md](2026-09-25-step9-position.md). Seven web queries across the four fields it names.*

## Batch 1, curvature operators with few eigenvalues

| query | what came back | verdict |
|---|---|---|
| Weyl curvature operators with three eigenvalues, classification by multiplicity | the Lorentzian algebraic classification of the Weyl tensor through its bivector operator ([1301.2016](https://arxiv.org/pdf/1301.2016), [1011.6168](https://arxiv.org/pdf/1011.6168)); in Euclidean signature self-adjointness restricts the types by eigenvalue degeneracy and kernel dimension | **classification by Petrov-type alignment**, which constrains eigenbivectors in Lorentzian signature; nothing on which multiplicity patterns a Riemannian Weyl operator can carry |
| curvature operators with exactly two eigenvalues, symmetric spaces | Tachibana-type rigidity ([2105.09290](https://arxiv.org/pdf/2105.09290), [2112.08465](https://arxiv.org/pdf/2112.08465)); [Petersen–Stanfield 2025](https://arxiv.org/abs/2508.11236) compute every compact irreducible symmetric space's curvature operator: one, two or three distinct nonzero eigenvalues, all rational, three only for complex Grassmannians | **a catalogue of realised spectra**, of the full curvature operator rather than of a Weyl critical point of $P$; a source of three-value test objects, not a constraint |
| curvature operator spectrum symmetric about zero | Einstein four-manifolds split into self-dual and anti-self-dual parts; nothing on symmetric Weyl spectra | searched, nothing found |

## Batch 2, realisability of an operator with prescribed eigenspaces

| query | what came back | verdict |
|---|---|---|
| algebraic curvature operators with prescribed eigenvalues, Bianchi | Bianchi is orthogonality to $\Lambda^4$ in $\mathrm{Sym}^2(\Lambda^2)$; Gilkey's school on constant-Jordan-form operators ([0811.3180](https://arxiv.org/pdf/0811.3180)) | the Bianchi condition is the record's own row source; nothing new |
| existence of a curvature tensor for given Jacobi operators ([2209.06882](https://arxiv.org/pdf/2209.06882)) | necessary and sufficient compatibility conditions on a family of Jacobi operators | **realisability in the Jacobi picture**, one vector at a time; converting it to eigenspace data on $\Lambda^2$ is not in the paper |

## Batch 3, isotropy of subspaces of $\mathfrak{so}(n)$ as a moment map

| query | what came back | verdict |
|---|---|---|
| subspaces of $\mathfrak{so}(n)$ with equal isotropy | textbook decompositions of Lie algebras only | searched, nothing found under this phrasing |
| moment-map convexity for $O(n)$ on $\Lambda^2$-data, Ricci as a contraction | **Lauret's real GIT of Ricci-negative Lie groups ([1912.06204](https://arxiv.org/pdf/1912.06204))**: the Ricci of a bracket is the $O(n)$-moment map $\Lambda^2(\mathbb R^n)^*\otimes\mathbb R^n\to\mathrm{Sym}(n)$, with Kirwan–Ness convexity on its image | **the one field with traction.** The record's isotropy matrix $A_a=\mathop{\mathrm{Ric}}(P_a)=\sum_{\alpha\in a}\Psi_\alpha\Psi_\alpha^{\mathsf T}$ is a moment map of the same shape, for $O(n)$ on the Grassmannian of $\Lambda^2\mathbb R^n$, so which $(A_-,A_0,A_+)$ an orthogonal eigenspace decomposition can carry is a moment-polytope question, and it is **non-linear in the class values**, the kind of ingredient [post F76](../findings/fence-posts.md) asks for |

**Recorded as searched.** *Batches 1 and 2 produced a catalogue and a Jacobi-picture realisability theorem, neither a constraint at a three-value critical point; batch 3 produced one proposable mechanism.*

## Phase 3a, the screen of R-α against the record

**[Post F66](../findings/fence-posts.md) is the neighbour, and it does not reach R-α.** F66 kills casting $Q(W)=\theta W$ as a moment-map minimal vector: the condition is the Lagrange condition of a cubic, and no reductive group preserves $\mathcal W_n$ while acting non-isometrically; *its own coda names the error of importing Lauret's "Ricci is a moment map" into a setting where the variable is the curvature tensor.* **R-α's variable is an eigenspace, not the tensor**: the map $V\mapsto A_V=\mathop{\mathrm{Ric}}(P_V)$ on subspaces of $\Lambda^2\mathbb R^n$ under the compact $O(n)$, used as a realisability constraint on the eigenspaces a critical point carries, never as a characterisation of criticality. *So R-α claims no minimal-vector structure, and stops being R-α the moment it does.*

**The record met this convexity once before, under a blocked item.** [bounds-relaxations.md](../findings/bounds-relaxations.md) records moment-map convexity (Lauret–Will, Prop 3.2(i)) as the hull condition for the per-row system, with *"the group action whose moment map is the per-row system remains owed"*, and the item is blocked ([I13a](../plan.md#blocked)). **R-α names a candidate action**, $O(n)$ on the eigenspace flag, so working it may unblock I13a as well.

**What R-α can and cannot add.** $A_V$ is LINEAR in the projector $P_V$, so over the convex hull of projectors ($0\preceq P\preceq I$, $\mathop{\mathrm{tr}}P=k$) the image is a linear image and adds only linear constraints, which the class system already carries. **Anything new must come from the projectors themselves**, the non-convex set: through the quadratic data $G_{ab}=\mathop{\mathrm{tr}}A_aA_b$ and the joint spectrum of $(A_-,A_0,A_+)$ at fixed ranks. *That is the named first step's actual content, and if the projector image turns out convex in those coordinates, R-α adds nothing and closes.*

## Phase 3b, the routes, graded on section 1's rubric

| route | closes | attackable | margin | analytic | value | how close it gets to Problem P |
|---|---|---|---|---|---|---|
| **R-α, eigenspace realisability through the isotropy moment map** | 2 | 2 | 1 | 1 | **4** | closes (c) if the moment-polytope constraint on $(A_-,A_0,A_+)$, with the anticommutator identities of section 2 ($\lVert\{U,V\}\rVert^2+\lVert[U,V]\rVert^2=4\mathop{\mathrm{tr}}U^2V^2$) summed within and across classes, excludes every three-value point above $\sqrt{3/2}$. Leaves (b) and spectra with four or more values |
| **R-β, the symmetric-spectrum case by hand** | 1 | 2 | 1 | 1 | **2** | excludes the symmetric three-value spectra, L241's family, using $A_-=A_+$ and Bianchi's $\sum_+\psi\wedge\psi=\sum_-\psi\wedge\psi$; a sub-step of (c), leaving the asymmetric survivors |
| **R32 reopened, invariant curvature cones** | 2 | 1 | 1 | 1 | **2** | the registered route held closed until R30 settles; reopening it concedes R30's instrument and gives the cone method no named first step |

**The recommendation works TWO routes, R-α then R-β, and stops before R32.**

- **R-α first, grade 4.** It is the only candidate that supplies what F76 demands, a non-linear constraint on the class values, and it comes with a named mechanism (Kirwan–Ness convexity for a moment map the record already writes down) and a named first step: the moment image of a $k$-dimensional subspace of $\mathfrak{so}(n)$, bounding $\mathop{\mathrm{tr}}A^2$ and the joint spectrum of $(A_V,A_{V^\perp})$, tested first at L241's point ($k=7$, $n=12$, $G_{aa}=\tfrac{77}2$). *If the projector image is convex in the $G$-coordinates, R-α adds nothing, which is decidable before any other work; if it fails later, it fails at a named polytope inequality, and R-β inherits its tools.*
- **R-β second, grade 2.** It is narrower but concrete, and L241 lives in exactly its family. *Its failure would mean the symmetric three-value case survives every ingredient on file, which is itself the next fence post.*
- **R32 last and not now.** Reopening it gives up R30 while R30 still has a route.
