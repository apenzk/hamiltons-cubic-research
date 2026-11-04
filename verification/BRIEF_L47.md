# Brief for round L47

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md lines 531-535

```markdown
##### Lemma L47, the dimension lemma for symmetric spaces

For a compact irreducible symmetric space of rank $\ge2$, and for $\mathbb{OP}^2$, normalised to Einstein constant $\tfrac12$ so that $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$ (Lemma L46), Cauchy–Schwarz over the isotropy blocks gives $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}$, and that dimension bound implies $\lVert W\rVert^2\ge\frac16$, i.e. $\theta\le\sqrt{3/2}$, each space by a nonnegative-coefficient certificate. Among the irreducible spaces equality holds only at $\mathbb{CP}^2$. The rank-one spaces other than $\mathbb{OP}^2$ are the families of Lemmas 10 and 38.

**Proof:** [problem.md](findings/problem.md)
```

## B. The landscape statement, from results.md line 170

```markdown
- **Lemma L47 (landscape). The dimension lemma for symmetric spaces.** Cauchy–Schwarz over the isotropy blocks gives $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\frac16$, covering every compact irreducible symmetric space of rank $\ge2$ plus $\mathbb{OP}^2$, each by a nonnegative-coefficient certificate.
```

## C. The block in findings/problem.md, lines 221-233

```markdown
#### Lemma L47, (the dimension lemma for symmetric spaces) · (B), canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

**Why it was needed.** For a locally symmetric Einstein space $Q(W)=\lambda W$, so $\theta=\lambda/\lVert W\rVert$ and the cubic becomes a *quadratic* condition on $\lVert W\rVert$. Normalising to Einstein constant $\tfrac12$ forces $\mathop{\mathrm{tr}}R=n/4$, makes the centre constant universal at $c=\frac1{2(n-1)}$, and gives $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$. What is then needed is a lower bound on $\lVert R\rVert^2$.

**Statement and argument.** Cauchy–Schwarz over the isotropy blocks, whose eigenvalues are [Petersen–Stanfield](https://arxiv.org/abs/2508.11236) Prop 2.2, gives $\lVert R\rVert^2\ge(n/4)^2/\dim\mathfrak h$, so

$$\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\ \Longrightarrow\ \lVert W\rVert^2\ge\tfrac16 .$$

This covers **every compact irreducible symmetric space of rank $\ge2$**, plus the rank-one $\mathbb{OP}^2$: each classical family reduces to a polynomial positivity statement with an all-nonnegative-coefficient certificate after shifting to its first admissible rank, each with a strictly positive constant term ($616$, $48$, $7200$, $114$, $3696$, $2192$, $236$, $84$), and the twelve exceptional spaces check directly, mostly by an order of magnitude. The residue is exactly the compact rank-one spaces: $S^n$ and $\mathbb{RP}^n$ have $W=0$, while $\mathbb{CP}^m$ and $\mathbb{HP}^m$ have closed forms with minima $\tfrac16$ at $\mathbb{CP}^2$ and $\tfrac{45}{224}$ at $\mathbb{HP}^2$. Hence $\theta\le\sqrt{3/2}$ on every compact irreducible symmetric space, **equality only at $\mathbb{CP}^2$**. $\square$


```
