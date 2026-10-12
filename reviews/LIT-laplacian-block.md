# LIT, the second-variation block structure: does the graph-Laplacian form appear in print?

**Run:** 2026-09-02, prompted by the `Searched:` counter reaching 25 commits with no outside source. **Analysis only; two web searches, nothing fetched or filed because nothing was on point.**

## What was searched, and why

[Lemma L122](../findings/second-order.md) says the pair block of $L_M$ at a diagonal critical point is $-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}$, with $\Delta^{(jk)}$ the **weighted graph Laplacian of the sectional matrix** with rows and columns $j,k$ deleted, and the Ricci cut is exactly the Laplacian's own $\mathbf 1^\perp$. That is a striking enough structure to be worth asking whether anyone has seen it.

**Queries.** *(i)* "graph Laplacian second variation curvature operator sectional curvature matrix Hessian Einstein critical point". *(ii)* "Hamilton curvature operator $Q(R)=R^2+R^\#$ critical points second variation Weyl tensor sphere product stability".

## Verdict: nothing on point, and the near misses are a different subject

**The graph-Laplacian hits are about curvature *on* graphs, not Laplacians arising *from* curvature operators**, Forman–Ricci curvature and the "curvature–Laplacian" equation run the other way round, defining a curvature for a given graph. Nothing found builds a Laplacian out of the sectional matrix of a curvature operator.

**The second-variation literature found is about metric functionals, not about $Q$.** [Critical Metrics for Riemannian Curvature Functionals](https://arxiv.org/pdf/1405.6080) and [On Variational Properties of Quadratic Curvature Functionals](https://arxiv.org/pdf/1801.02017) treat second variations of $\int\lvert\mathrm{Ric}\rvert^2$-type functionals over metrics, where the second variation is a Lichnerowicz Laplacian on tensor fields. **That is a different variational problem**: this programme varies an algebraic curvature operator on a fixed vector space, not a metric on a manifold, and its Hessian is the multiplication operator $L_e$ of a nonassociative algebra rather than a differential operator. The coincidence of the word "Laplacian" is not a connection.

**On $Q(R)=R^2+R^\#$ specifically**: the searches surface [Böhm–Wilking](https://annals.math.princeton.edu/wp-content/uploads/annals-v167-n3-p10.pdf), already filed, and the Hamilton–Ivey line, but nothing on the *critical points* of $\langle R,Q(R)\rangle$ or their second-order structure. That is consistent with what the record already holds: [Bhattacharya](../references/bhattacharya-2013-curvature-ode/notes.md) states the classification open above $n=4$ in print, and [LIT-srg-forward](LIT-srg-forward.md) found the nearest neighbour ([DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md)) has zero forward citations.

## What this changes

**No plan item changes grade, and nothing is filed**, a source is stored only when it is read, and none of these bears on the derivation. **The negative is the result**: the second-order block structure of this cubic on $\mathcal W_n$ appears to be unstudied, which is the same conclusion the programme's three earlier literature passes reached about neighbouring questions. *Recorded so the next cycle does not repeat these two queries.*
