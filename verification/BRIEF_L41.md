# Brief for round L41

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical entry, results.md lines 603-607

```markdown
##### Lemma L41, a $\lambda$-weighted identity, and the bound it gives

Let $W\in\mathcal W_n$ be a critical point with eigenbasis $\{v_\gamma\}$ and write $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$. Then $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta(W)$, in two lines from $A(W)=2W$ and the definition of $\#$, and $\sum_\gamma g_\gamma=4(n-1)$ on all of $\mathcal W_n$, critical or not. With $g_\gamma\ge0$, writing $\Delta$ for the mass on the strictly positive eigenspace and $G_0$ for the mass on $\ker W$, $\theta\le\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}4$, with equality exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace. The equality case is the same statement as Lemma L70's, in the coordinates of $g$ rather than of $D$; the record cites them as one piece of evidence. The bound saturates on the whole subalgebra family of Lemma L23, so it separates nothing there.

**Proof:** [target.md](findings/target.md)
```

## B. The landscape statement, results.md line 190

```markdown
- **Lemma L41 (direct). A $\lambda$-weighted identity, and the bound it gives.** With $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ in an eigenbasis, $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ at every critical point, and $\sum_\gamma g_\gamma=4(n-1)$ on all of $\mathcal W_n$. Hence $\theta\le\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)/4$, equality exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace.
```

## C. The block, findings/target.md lines 696-708

```markdown
#### Lemma L41, a $\lambda$-weighted identity, and the bound it gives

*Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the argument is in this file under "The magnitude is convention-dependent; the sign is not"**.*

Write $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ in an eigenbasis of $W$. Then
\[
\sum_\gamma\lambda_\gamma g_\gamma\;=\;-4\,\theta(W),
\]
in two lines from $A(W)=2W$ and the definition of $\#$. With $g_\gamma\ge0$ and $\sum_\gamma g_\gamma=4(n-1)$ this gives
\[
\theta\;\le\;|\lambda_{\min}|\cdot\frac{4(n-1)-\Delta-G_0}{4},\qquad G_0:=\sum_{\gamma\in\ker W}g_\gamma ,
\]
with equality exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace.
```

## D. A NEIGHBOURING LEMMA'S STATEMENT, quoted for its hypothesis only

*This is a different result. It is here because of the clause in bold, and for no other reason.*

```markdown
Let $W\in\mathcal W_n$ be a critical point **with $\lVert W\rVert=1$** (the identity holds at one scale only, its two sides being homogeneous of different degrees) so $\lambda_{\min}<0<\lambda_{\max}$ by $\operatorname{tr}W=0$ at $W\ne0$; *the sign of $D$ needs only $\lambda_{\min}\le0\le\lambda_{
```
