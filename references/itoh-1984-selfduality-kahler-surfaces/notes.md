# Notes, Itoh, *Self-duality of Kähler surfaces* (Compositio Math. 51 (1984) 265–273)

Transcribed from [CM_1984__51_2_265_0.txt](http://www.numdam.org/item?id=CM_1984__51_2_265_0), the `pdftotext -layout` extraction of [CM_1984__51_2_265_0.pdf](http://www.numdam.org/item?id=CM_1984__51_2_265_0). Index card in [README.md](README.md). Displayed formulas in the original are typeset as images and do not survive the extraction; the prose statements below do, and are quoted verbatim with the OCR's own spelling of "Kâhler".

## What the paper supplies for this record

Two facts, both about $\mathbb{CP}^2$ with its Fubini–Study metric, in the orientation the complex structure induces.

**1. $W^-=0$.** Page 266, immediately before Theorem 1:

> "It is shown by a straight computation that a Kâhler surface of constant holomorphic curvature is self-dual with respect to the canonical orientation."

The Fubini–Study metric on $P^2(\mathbb C)$ has constant holomorphic sectional curvature, so it is self-dual: $W^-=0$. The classification restates it, pp. 266–267:

> "THEOREM C [2,3,5]: Let $(M,g)$ be a compact, self-dual Kâhler surface. Then $(M,g)$ is either a space of constant holomorphic curvature ($P^2(\mathbb C)$, a compact quotient of unit disk $D^2$ or a Kâhlerian flat torus $T^2$) or a compact quotient of a product space of $P^1(\mathbb C)$ and the Poincaré disk $D^1$ with metrics of opposite curvature."

**2. $W^+\ne0$.** Page 267:

> "THEOREM 2: Let $(M,g)$ be a Kâhler surface. Then it is anti-self-dual if and only if its scalar curvature vanishes everywhere."

$\mathbb{CP}^2$ has constant scalar curvature $s>0$, so it is not anti-self-dual, so $W^+\ne0$.

**Orientation, stated once.** Page 265: *"Note that a self-dual 4-manifold is anti-self-dual if the orientation is reversed."* So which of $W^\pm$ vanishes on $\mathbb{CP}^2$ is a choice of orientation; the rank of $W$ on $\Lambda^2$ is the same either way.

## What the paper does not supply

The three eigenvalues of $W^+$. Theorem 2 gives $W^+\ne0$, which leaves open whether one of the three vanishes, and the rank claim of L176 Corollary 2 needs all three nonzero. Itoh's Lemma 2.2 and formulas (2.1)–(2.4) are displayed images and unreadable in the extraction.

**That gap is closed elsewhere in this folder.** [bourguignon-karcher-1978-pinching](../bourguignon-karcher-1978-pinching/notes.md) §5.1 records the Fubini–Study curvature tensor in closed form, at the normalisation with sectional curvature in $[1,4]$:

$$R_{\mathbb{CP}^n}(a,b,c,d) = (a,c)(b,d) - (a,d)(b,c) + (Ja,c)(Jb,d) - (Ja,d)(Jb,c) + 2(Ja,b)(Jc,d).$$

At $n=2$, in the frame $e_1,\ e_2=Je_1,\ e_3,\ e_4=Je_3$, this gives $s=24$ and $W = R - \tfrac{s}{2\cdot4\cdot3}\,g\owedge g$ with spectrum $(4,-2,-2)$ on $\Lambda^+$ and $(0,0,0)$ on $\Lambda^-$, the ratio $(2,-1,-1)$, no zero eigenvalue, $\Lambda^2$-rank exactly three. The derivation is written out in full in [reviews/REVIEW_r769.md](../../reviews/REVIEW_r769.md) §7, and cross-checks exactly against Bourguignon–Karcher's own §5.2 table for the spectrum of $\hat R_{\mathbb{CP}^n}$.

## Other content, for the record

- **Theorem 1.** A Kähler surface that is self-dual in the canonical orientation and Einstein has constant holomorphic curvature. The converse of the p. 266 sentence.
- **Theorem B [13].** On a Hermitian manifold of complex dimension two, the Bochner curvature tensor is the anti-self-dual part $W^-$ of the Weyl tensor.
- **Theorems 3 and 4.** Classification of compact conformally flat, and compact anti-self-dual, Kähler surfaces.
