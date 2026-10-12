# Brief for round L44

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md lines 280-284

```markdown
##### Lemma L44, $n\ge12$ is necessary, not merely sufficient

Zero-padded $W_{\mathbb{CP}^2}$ is a critical point of $\mathcal W_n$ at every $n\ge4$ with $\theta=\sqrt{3/2}$, and the curvature operator $cI+W$ it defines lies on $\partial\Omega_0$. Böhm–Wilking's invariance criterion at that point is exactly $\sqrt{3/2}\le\theta_0(n)$ (Lemma L43), which fails for $4\le n\le11$ and holds from $n=12$. So the cone is non-invariant for $4\le n\le11$, by a witness, and the hypothesis $n\ge12$ in the conjecture is forced by the problem rather than by any method. It says nothing about whether the cone is invariant at $n\ge12$, which is the conjecture itself.

**Proof:** [problem.md](findings/problem.md)
```

## B. The landscape statement, from results.md line 102

```markdown
- **Lemma L44. $n\ge12$ is necessary, not merely sufficient.** Zero-padded $W_{\mathbb{CP}^2}$ keeps $\theta=\sqrt{3/2}$ at every $n$, and the operator $cI+W$ it defines lies on $\partial\Omega_0$, so Böhm–Wilking's invariance criterion fails there exactly when $\theta_0(n)<\sqrt{3/2}$. The cone is non-invariant for $4\le n\le11$ by a witness: the dimension hypothesis is the problem's.
```

## C. The block in findings/problem.md, lines 207-217

```markdown
#### Lemma L44, ($n\ge12$ is necessary, not merely sufficient) · (D), canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

**Why it was needed.** Every statement here carries $n\ge12$, and a reader is entitled to ask whether that is the method's limit or the problem's.

**Statement and argument.** Placing the problem inside Böhm–Wilking's cone formulation, the zero-padded $W_{\mathbb{CP}^2}$ keeps $\theta=\sqrt{3/2}$ at every $n$, and **the curvature operator $cI+W$ it defines at the pinned $c$ lies on $\partial\Omega_0$**, *the Weyl tensor itself does not, having $\mathrm{ric}=0$, which is where $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ blows up and $\Omega_0$ is undefined.* By **[Lemma L43](../results.md)**, whose collapse of $dF_R(\Phi(R))\le0$ to $\langle W,Q(W)\rangle\le c(n-1)=\theta_0(n)$ is the block's only step, the invariance criterion fails at that point exactly when $\theta_0(n)<\sqrt{3/2}$, i.e. $n^2-12n+8<0$, i.e. $4\le n\le11$ over the integers. *The criterion demands $\theta_0(n)$ at both parities, the constant is $c(n-1)$, forced by $\lVert I\rVert^2=\binom n2$ and the boundary equation, and is a rational function of $n$ with no parity in it. $\Theta_n$ is what the diagonal locus attains, never what the criterion demands.* Hence $\Omega_0$ is **provably non-invariant for $4\le n\le11$**. $\square$

**Two things the argument uses and did not say.** It needs *invariance $\Rightarrow G\le0$*, where [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s Lemma 2.3.4 supplies only the converse; the direction holds in two lines, by evaluating the flow's normal component at the boundary point, and is now stated rather than assumed. And **the heading's \"not merely sufficient\" presupposes sufficiency, which is the open conjecture**, what is proved is that $n\ge12$ *cannot be weakened*, with sufficiency untouched either way. [results.md](../results.md) carries that guard.

**The conclusion is overdetermined, and the elementary route is one line at both parities.** Padded $W_{\mathbb{CP}^2}$ sits at $\theta=\sqrt{3/2}$ at every $n\ge4$, while the sphere-product maximum is $\Theta_n$, so wherever $\Theta_n<\sqrt{3/2}$ the conjecture's conclusion is **false outright**, with the padded tensor as witness and no cone theory involved. That comparison is $4(n-1)(n-3)<3(n+1)(n-2)$ at odd $n$, i.e. $n^2-13n+18<0$ with upper root $\tfrac{13+\sqrt{97}}2\approx11.42$, against $n^2-12n+8<0$ with upper root $6+2\sqrt7\approx11.29$ at even $n$: **the same integer threshold from two different polynomials**, and [Lemma L2](../results.md) already carries both. *The cone version earns its keep against [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s own conjecture, which states $n\ge12$ without deriving it, and against the Ricci-flow statement that $\Omega_0$ is non-invariant there, neither of which the elementary witness gives.*
```
