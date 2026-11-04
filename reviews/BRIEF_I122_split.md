# Gate 2 brief, I122's reduction to one simple subalgebra and the Lie table

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions; compute only to refute, the smallest computation that does it, saying why an argument could not (numpy under `sage -python`).

## Definitions and givens

- $\mathfrak{so}(m)=\Lambda^2\mathbb R^m$ with the Frobenius inner product on skew matrices. For symmetric operators $A,B$ on it, Hamilton's sharp is $(A\#B)_{\alpha\beta}=\tfrac12c_\alpha^{\gamma\delta}c_\beta^{\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$ in an orthonormal basis with structure constants $c$, normalised as in the record so that $I\#I=(m-2)I$, and $G^\#=G\#G$.
- $T(G)=\sum_{i,j,k}s_is_js_k\langle[A_i,A_j],A_k\rangle^2$ for $G=\sum_is_iA_iA_i^{\mathsf T}$, $s_i\ge0$, $A_i$ orthonormal. **Claimed identity to check**: $T(G)=\langle G^\#,G\rangle$ in this normalisation.
- Standard Lie data you may use, **each to be checked where the table uses it**: dual Coxeter numbers ($\mathfrak{su}(k):k$, $\mathfrak{so}(k):k-2$, $\mathfrak{sp}(k):k+1$, $\mathfrak g_2:4$, $\mathfrak f_4:9$, $\mathfrak e_6:12$, $\mathfrak e_7:18$, $\mathfrak e_8:30$) and Dynkin indices of the smallest faithful real representations, normalised so that the fundamental of $\mathfrak{su}(k)$ has index $1$.

## The claims

- **I122 is the sharp half of Hamilton's cubic on positive operators.** The operator $\beta(G\otimes G)\beta^{\mathsf T}$ in $T(G)=\mathop{\mathrm{tr}}\big(G\,\beta(G\otimes G)\beta^{\mathsf T}\big)$ is Hamilton's sharp, $(A\#B)_{\alpha\beta}=\tfrac12c_\alpha^{\gamma\delta}c_\beta^{\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$, so in the record's normalisation ($I\#I=(m-2)I$, which reproduces $T(I/\lVert I\rVert)=\tfrac{m-2}{\sqrt{\binom m2}}$) **$T(G)=\langle G^\#,G\rangle$ for $G\succeq0$ on $\Lambda^2\mathbb R^m$ with $\lVert G\rVert=1$**, with no Bianchi or Weyl condition. The self-dual extremal is the normalised projection onto $\Lambda^2_+\subset\Lambda^2\mathbb R^4$. **This is [I117](../plan.md)'s question on a different class**: I117 bounds $\langle M^\#,M\rangle$ on unit Weyl $M$, I122 on unit positive $G$. *Searched, nothing found*: a bound on $\mathop{\mathrm{tr}}(RR^\#)$ for positive $R$ in the Ricci-flow literature on Hamilton's ODE.
- **I122 split: the maximiser lives on one simple subalgebra (proved), and a Lie-theoretic table gives the conjectured value.** *Derived here, unreviewed.*
  1. **The maximiser is a positive sharp-eigenoperator.** At a maximum of $\langle G^\#,G\rangle$ over $\{G\succeq0,\lVert G\rVert=1\}$, directions supported on $\mathop{\mathrm{range}}G$ give $P_R(G^\#-\lambda G)P_R=0$ with $\lambda=\langle G^\#,G\rangle$, and positive directions on $\ker G$ give $P_KG^\#P_K\preceq0$; Hamilton's $G\succeq0\Rightarrow G^\#\succeq0$ (each $aa^{\mathsf T}\#bb^{\mathsf T}$ is positive) then forces $G^\#P_K=0$, so **$G^\#=\lambda G$**.
  2. **Its range is a semisimple subalgebra, and it splits.** $\mathop{\mathrm{range}}G^\#$ is spanned by the brackets $[A_i,A_j]$ of $G$'s eigenvectors, so $V=\mathop{\mathrm{range}}G$ contains its brackets: a subalgebra of $\mathfrak{so}(m)$, reductive, and semisimple since a centre would give $\mathop{\mathrm{range}}G^\#\subseteq[V,V]\subsetneq V$. Brackets between distinct ideals vanish, so $G^\#$ is block-diagonal over the simple ideals and $G^\#=\lambda G$ forces $G=\bigoplus_\ell G_\ell$. With $T$ cubic and $\sum\lVert G_\ell\rVert^2=1$, $T(G)=\sum_\ell\lVert G_\ell\rVert^3T(\hat G_\ell)\le\max_\ell T(\hat G_\ell)$: **the supremum is attained on a single simple subalgebra $\mathfrak h$**.
  3. **The value of the scalar operator on $\mathfrak h$** is $\kappa(\mathfrak h,\rho)=\tfrac{2h^\vee}{I(\rho)\sqrt{\dim\mathfrak h}}$, $h^\vee$ the dual Coxeter number and $I(\rho)$ the Dynkin index of $\mathfrak h$ acting on $\mathbb R^m$ (the vector representation of $\mathfrak{so}(k)$ has $I=2$, which gives $\mathfrak{so}(k)$ the value $\tfrac{k-2}{\sqrt{\binom k2}}$). Over compact simple algebras and their smallest faithful real representations: $\mathfrak{sp}(1)\cong\mathfrak{su}(2)$ on $\mathbb R^4=\mathbb H$ gives $\tfrac2{\sqrt3}$ (the self-dual case); $\mathfrak{so}(k)$ gives $\tfrac{k-2}{\sqrt{\binom k2}}$, largest at $k=m$; $\mathfrak{su}(k)$, $k\ge3$, at most $1.061$; $\mathfrak{sp}(k)$, $k\ge2$, at most $0.949$; $\mathfrak g_2$ on $\mathbb R^7$ $1.069$; $\mathfrak{spin}(7)$ on $\mathbb R^8$ $1.091$; $\mathfrak f_4$, $\mathfrak e_6$, $\mathfrak e_7$, $\mathfrak e_8$ below $0.42$. **The maximum over this table is exactly the screened formula $\max\{\tfrac2{\sqrt3},\tfrac{m-2}{\sqrt{\binom m2}}\}$.**
  4. **Open: on a simple $\mathfrak h$, the positive maximiser is the scalar one** (or lies on a smaller simple subalgebra, which the table already covers). For $\mathfrak{su}(2)$ this is AM–GM: in $G$'s eigenbasis $T=6g_1g_2g_3\tau^2\le6\tau^2(1/\sqrt3)^3$. In general it asks whether a positive $G$ with $G^\#=\lambda G$ and full range on a simple $\mathfrak h$ is scalar, which the record has not settled.

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| $T(G)=\langle G^\#,G\rangle$ | none: a normalisation identity; check it, including the factor | |
| 1, the maximiser is a positive sharp-eigenoperator | none: a first-order optimality argument on the positive cone plus Hamilton's positivity; check it | |
| 2, range a semisimple subalgebra, the split, the power mean | none: check each step | |
| 3, the value $\tfrac{2h^\vee}{I(\rho)\sqrt{\dim\mathfrak h}}$ and the table | none: Lie-theoretic data; check the formula and every entry | |
| 4 | open, not under review; say whether claims 1 to 3 are complete without it | |

## What to attack

1. **Claim 1's optimality argument**: are the feasible directions on the positive cone correctly described at a boundary point, and does $P_KG^\#P_K\preceq0$ with $G^\#\succeq0$ really give $G^\#P_K=0$? Is Hamilton's positivity of $G^\#$ for $G\succeq0$ true without a Bianchi condition?
2. **Claim 2**: is $\mathop{\mathrm{range}}G^\#$ exactly the span of the brackets of $G$'s eigenvectors with positive weights? Does a nonzero centre really contradict $G^\#=\lambda G$ (what if $\lambda=0$)? Is $G$ forced block-diagonal over simple ideals, and is the power-mean step right?
3. **Claim 3's formula**: derive the value of the normalised projection onto a simple $\mathfrak h\subset\mathfrak{so}(m)$ from the Casimir, and check it gives $\tfrac{k-2}{\sqrt{\binom k2}}$ for $\mathfrak{so}(k)$ and $\tfrac2{\sqrt3}$ for $\mathfrak{su}(2)$ on $\mathbb R^4$.
4. **The table**: every entry, and whether any compact simple algebra with a faithful real representation of dimension at most $m$ beats $\max\{\tfrac2{\sqrt3},\tfrac{m-2}{\sqrt{\binom m2}}\}$. Watch the low-rank coincidences ($\mathfrak{so}(3)$, $\mathfrak{so}(4)$, $\mathfrak{so}(5)\cong\mathfrak{sp}(2)$, $\mathfrak{so}(6)\cong\mathfrak{su}(4)$, $\mathfrak{spin}(7)$, triality in $\mathfrak{spin}(8)$) and reducible representations.
5. **Scope**: do claims 1 to 3 establish that the supremum is attained on a single simple subalgebra, so that claim 4 is the only gap?

## Protocol

- Your log file is already created empty (see the dispatch); first line your PID and phase plan, a heartbeat at least every three minutes with live state, closing with a line opening `DONE` or `FAILED`.
- Commit a skeleton to your `reviews/REVIEW_rN.md` (already created empty as your claim) in your first phase, every verdict `NOT REACHED`, then overwrite rows. **Do not edit [reviews/INDEX.md](INDEX.md). Never use `git commit --amend`.** Commit only your own files, named after `--`.
