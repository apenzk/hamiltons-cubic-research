# r1111: I73(c) section 10, the seven-frame cap

*Gate 2 review of section 10 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at commit 7588af1f. Log: [agent_logs/r1111-I73c-sec10.log](../agent_logs/r1111-I73c-sec10.log). Analysis comes first. The screens below ran in seconds to minutes on objects constructed for them and are reported as screens.*

## Verdicts

| # | Claim | Verdict |
|---|---|---|
| 1 | Vertex tightness, rows total $8$, frame total $56$ | CONFIRMED |
| 2 | Triangle realisation caps the frame at $44$ | CONFIRMED in its conclusion, one link REFUTED and repaired, the star case settled here, and both realisations total exactly $40$ |
| 3 | Class-level constraint $4R_0+3R_2\le T_7$, LP threshold $54.064$, ascent $\approx40.8$ | Constraint (an exact identity) and LP CONFIRMED, "truth near $41$" REFUTED by explicit frames of total $42$ at $n=7$ and $n=8$ |
| 4 | Open-lemma paragraph scoped honestly | PLAUSIBLE, needs the $42$ correction and an $n$-uniformity remark |
| 5 | Lean rank4_top6 and triangle_frame_total | REFUTED as a statement of the note's claim: rank4_top6 proves the wrong sum, its hypothesis is idle, and the slot list undercounts the kernel couplings |

## 1. Vertex tightness: CONFIRMED

- Within the seven non-kernel eigenvectors, a negative-class vector ($m_0=4$) has $3$ own-class and $3$ positive-class partners, and a positive-class vector ($m_2=3$) has $4$ negative-class and $2$ own-class partners. The rows are the right partner counts, using $P_{20}=P_{02}$ (both $\mu_c^{(ab)}$ and $t_{abc}$ are symmetric in $a,b$).
- $3\cdot\tfrac{26}{21}+3\cdot\tfrac{10}{7}=\tfrac{78+90}{21}=8$ and $4\cdot\tfrac{10}7+2\cdot\tfrac87=\tfrac{56}7=8$. The ordered total is $4\cdot8+3\cdot8=56=7\kappa_6$.
- Equality in Ky Fan for the row of $X_i$ forces the other six to lie in, hence span, the top-six eigenspace of $-\mathrm{ad}_{X_i}^2$ whenever the sixth and seventh eigenvalues differ. They do in both extremal types: the top value is $\tfrac43$ with multiplicity exactly $6$, and the next is at most $\tfrac34$ (the star's $s_1^2$ slot, $n\ge9$) or $\tfrac13$.

## 2. The triangle-realisation argument

**Link by link.**
- *Extremal of triangle type is $J/\sqrt3$.* CONFIRMED. The signless Laplacian of $K_3$ has the simple top eigenvector $(1,1,1)$ at $\lambda=4$, so $\lvert s\rvert=(1,1,1)/\sqrt3$, and signs choose the orientation of $J$. At $n\ge7$, $J$ is a complex structure on a $6$-dimensional subspace $V$ and $X$ vanishes on $V^\perp$.
- *Top eigenspace is $\mathfrak m$, eigenvalue $\tfrac43$, dimension $6$.* CONFIRMED. On $Y$ with $JY=-YJ$, $\mathrm{ad}_J^2Y=-2Y-2JYJ=-4Y$, so $-\mathrm{ad}_X^2=\tfrac43$. $\dim\mathfrak m=15-\dim\mathfrak u(3)=6$. The couplings $\mathrm{Hom}(V^\perp,V)$ sit at $\tfrac13$ and $\mathfrak u(3)$ at $0$, so the eigenspace is exactly $\mathfrak m(V)$.
- *Every element of $\mathfrak m$ is rank $4$.* CONFIRMED, and more holds. $\mathfrak m$ is the real form of $\Lambda^{2,0}(\mathbb C^3)$, and every $2$-form on $\mathbb C^3$ is decomposable, so a nonzero $Y\in\mathfrak m$ is $\mathrm{Re}(c\,dz_1\wedge dz_2)$ in a unitary frame. After absorbing the phase of $c$ into $dz_1$ this is $\lvert c\rvert(dx_1\wedge dx_2-dy_1\wedge dy_2)$: **the two angles are EQUAL**, $(x,x)$ with $2x^2=1$ at unit norm.
- *"A rank-$4$ element has top-six sum $2(x+y)^2+2(x-y)^2+2\max(x,y)^2\le6$ at unit norm."* **REFUTED as stated for $n\ge6$.** A rank-$4$ element with angles $(x,y)$ in $\mathfrak{so}(n)$ couples to the $n-4$ kernel directions through $\mathrm{Hom}(\mathbb R^{n-4},\mathbb R^4)$, where $-\mathrm{ad}_Y^2$ is $-Y^2\otimes1$: the values $x^2$ and $y^2$ each carry multiplicity $2(n-4)$, which is $4$ or more once $n\ge6$, and $2$ only at $n=5$. For $x\ge y\ge0$ the order is $(x+y)^2\ge x^2\ge\max\big(y^2,(x-y)^2\big)$, so at $n\ge6$ the top-six sum is $2(x+y)^2+4x^2$, whose maximum on the unit circle is $4+2\sqrt2\approx6.83$ at $\tan2t=1$. The rational witness $(x,y)=(2,1)/\sqrt5$ gives $\tfrac{34}5>6$. At $n=5$ the top three of the four slots sum to $3$ minus the smallest, so the note's expression is the wrong sum there too (it drops a $\tfrac12$ at $x=y$), although its bound $6$ happens to hold.
- **Repair.** Only equal-angle elements are needed, and for them the top-six sum at $n\ge6$ is $2(2x)^2+4x^2=12x^2=6$ at unit norm, exactly. So every partner row is at most $6$ and **the conclusion $8+6\cdot6=44$ stands**, carried by the equal-angle fact above in place of the general rank-$4$ bound.
- *Must the frame span $\langle J\rangle\oplus\mathfrak m$?* Yes at the vertex, by the equality case in item 1. For frames that merely contain a triangle-type element the $44$ does not apply, and the note's "such a frame" is correctly scoped to the spanning case.

**The frame is determined, so its total is exact.** The ordered total $\sum_{i\ne j}\lVert[X_i,X_j]\rVert^2$ is the squared Hilbert-Schmidt norm of the bracket restricted to the span, hence a function of the $7$-dimensional subspace alone. For $\langle J\rangle\oplus\mathfrak m$ it is **exactly $40$**: the $J$ row is $8$ and each $\mathfrak m$ row is $\tfrac43+4=\tfrac{16}3$ ($[\mathfrak m,\mathfrak m]\subset\mathfrak u(3)$). Screened at $n=6$ and $n=8$, rows $8$ and $5.3333$.

**The star case, settled.** At $s=(3,1,1,1)/\sqrt{12}$ ($n\ge8$) the top eigenspace is $\mathfrak g_{e_1+e_2}\oplus\mathfrak g_{e_1+e_3}\oplus\mathfrak g_{e_1+e_4}$, eigenvalue $\tfrac43$, dimension $6$, with the next value $\tfrac34$ or $\tfrac13$. An element of it maps the plane $P_1$ to $P_2\oplus P_3\oplus P_4$ through $C=[B_2\,B_3\,B_4]$, each $B_j$ a scaled $2\times2$ orthogonal matrix of one fixed orientation type, so $CC^{\mathsf T}=\sum_j\lvert b_j\rvert^2I_2$. **Every nonzero element therefore has rank $4$ with equal angles**, top-six sum $6$, and the star-realised frame totals at most $44$, in fact **exactly $40$** (screened: rows $8$ and $\tfrac{16}3$, random elements of the eigenspace all have angles $(0.7071,0.7071)$).
- With section 9's classification (the triangle and the star are the only three-slot configurations reaching $4$, strictly), **no seven-frame at any $n$ reaches $56$**: every element would be extremal of one of the two types, and its six partners would have rows of $6<8$. Compactness then gives $\max<56$ at each fixed $n$, a qualitative statement that yields no number and no uniformity in $n$.
- "The star realisation ... not settled" is honest as written, and is now settled. "Frames with no extremal element" is the open lemma itself, and honest.

## 3. Class-level constraint, LP and ascent

- **$4R_0+3R_2\le T_7$ is an identity, not an averaging bound.** With $T_{\alpha\beta\gamma}=0$ for $\gamma\in\{\alpha,\beta\}$ and the eigenvectors of $e$ an orthonormal basis of $\mathfrak{so}(n)$, $P_{ab}$ is the mean of $\lVert[\Psi_\alpha,\Psi_\beta]\rVert^2$ over ordered pairs in $a\times b$, so the ordered total of the seven non-kernel eigenvectors is $\sum_{a,b}m_a(m_b-\delta_{ab})P_{ab}=12P_{00}+24P_{02}+6P_{22}=4R_0+3R_2$. It holds at any $W$, it is linear in $\tau$, and it is invariant under the class permutation group, so L104's averaged $T$ satisfies it. CONFIRMED.
- **LP reproduces.** [screen_I73c_frame7_lp.py](../scripts/misc/screen_I73c_frame7_lp.py): $T_7=56$ gives $1.293719$ (L237's $\tfrac{83\sqrt{21}}{294}$, a consistency check), $T_7=48$ gives $1.0087$, $T_7\in\{44,42,40,36\}$ is empty from $\theta=1$, and the threshold is $54.064$ at both $n=8$ and $n=12$. CONFIRMED as a screen.
- **Ascent reproduces, and undershoots.** [screen_I73c_frame7_max.py](../scripts/misc/screen_I73c_frame7_max.py) returns $39.815$, $40.804$, $39.449$ at $n=6,7,8$. That is below the exact frames of total $40$ at $n=6$ (item 2) and $42$ at $n=7,8$ (next bullet), so the ascent is under-converged at every $n$ it ran.
- **Frames of total exactly $42$.** At $n=8$, the octonion left multiplications $L_{e_1},\dots,L_{e_7}$ are seven pairwise anticommuting orthogonal complex structures. With $X_i=L_{e_i}/2$ (unit, orthonormal because $L_iL_j$ is skew and traceless), $[X_i,X_j]=\tfrac12L_iL_j$, and $L_iL_j$ is an orthogonal complex structure of norm$^2$ $4$, so **every pair brackets to exactly $1$** and the total is $7\cdot6=42$. At $n=7$ the complement of $\mathfrak g_2$ in $\mathfrak{so}(7)$, $v\mapsto(u\mapsto v\times u)$, also totals $42$ with every row $6$. The family $J_i/\sqrt{n/2}$ from $\mathrm{Cl}_7$-modules on $\mathbb R^{n}$, $8\mid n$, has pair value $8/n$, so $n=8$ is its best member. *Screen:* local ascent from the octonion frame under noise $0.02$, $0.1$, $0.3$ climbs back to $41.99$, $41.92$, $41.91$ and never exceeds $42$, consistent with a local maximum and proving nothing about the global one.
- **Exact candidate for the maximum: $42$**, the octonion (or $\mathfrak g_2$-complement) frame, with every pair bracket equal. It sits $12.06$ below the $54.064$ the ray needs, so the margin stays wide.

## 4. The open-lemma paragraph: PLAUSIBLE

- "The screens are screens; nothing here excludes a critical point" is honest. The margin $54.064/56$ is $3.46\%$, as stated.
- **Correct "the evidence puts the truth near $41$" to "explicit frames reach $42$"**, and the ascent sentence ("finds totals no larger than about $40.8$") should say it undershoots known exact frames.
- **Add the $n$-uniformity gap.** The lemma is asserted in every $\mathfrak{so}(n)$, the screens cover $n\le8$, and nothing in the note reduces a seven-frame to bounded $n$. The section's equality analysis gives $T_7(n)<56$ per $n$ by compactness, with no uniform gap.
- The suggested routes (a stability form of the equality analysis, or a direct bracket-energy bound) are reasonable. The repaired equality analysis is cleaner than the note's: at every extremal element the partner space consists of equal-angle rank-$4$ elements, whose top-six sum is $6$.

## 5. Lean

- **rank4_top6** states $2(x+y)^2+2(x-y)^2+2x^2\le6(x^2+y^2)$ under $y^2\le x^2$. The left side is $6x^2+4y^2$, so the inequality holds for all real $x,y$ and **the hypothesis is idle**. Reading $\max(x,y)^2$ as $x^2$ under $y^2\le x^2$ is correct for $\max(\lvert x\rvert,\lvert y\rvert)^2$, and it does not matter.
- **It formalises the wrong sum.** The docstring's slot list ("the $x^2$, $y^2$ of its couplings to kernel directions, each twice") is complete only at $n=5$. At $n\ge6$ each coupling value carries multiplicity $2(n-4)\ge4$, the top six are $2(x+y)^2+4x^2$, and the general bound $6$ is false.
- **triangle_frame_total** is the arithmetic $8+36=44<54$, true. Its docstring's "six rank-$4$ rows of at most $6$" rests on the false general bound and should cite the equal-angle case.
- **Replacements, compiled** with `lake env lean` on a scratch file (exit 0, no sorry):

```lean
theorem r1111_rank4_general_fails :
    ¬ ∀ x y : ℝ, y ^ 2 ≤ x ^ 2 → 2 * (x + y) ^ 2 + 4 * x ^ 2 ≤ 6 * (x ^ 2 + y ^ 2) := by
  intro h
  have := h 2 1 (by norm_num)
  norm_num at this

theorem r1111_equal_angle_top6 (x y : ℝ) (hxy : y = x) :
    2 * (x + y) ^ 2 + 4 * x ^ 2 = 6 * (x ^ 2 + y ^ 2) := by
  subst hxy; ring

theorem r1111_rank4_top6_vacuous (x y : ℝ) :
    2 * (x + y) ^ 2 + 2 * (x - y) ^ 2 + 2 * x ^ 2 ≤ 6 * (x ^ 2 + y ^ 2) := by
  nlinarith [sq_nonneg y]
```

- Recommended: replace rank4_top6 by the equal-angle identity, add the counterexample as a guard, and let the docstring say the top-six ordering, the multiplicities and the equal-angle structure of $\mathfrak m$ and of the star eigenspace are not typed.

## Corrections owed to section 10

1. Replace "a rank-$4$ element has top-six sum $2(x+y)^2+2(x-y)^2+2\max(x,y)^2\le6$" with: every element of $\mathfrak m$ has equal angles (a decomposable $(2,0)$-form), so its top-six sum is $2(2x)^2+4x^2=6$ at unit norm and $n\ge6$. Note that the general rank-$4$ bound is $4+2\sqrt2$.
2. Record that the frame $\langle J\rangle\oplus\mathfrak m$ totals exactly $40$, and that the star realisation is settled the same way (equal angles, exact total $40$), so no seven-frame reaches $56$.
3. Replace "near $41$" with the explicit octonion / $\mathfrak g_2$-complement frames of total $42$, and say the ascent undershoots.
4. Add that the open lemma must hold uniformly in $n$ and the screens stop at $n=8$.
5. Lean: as in section 5 above.
