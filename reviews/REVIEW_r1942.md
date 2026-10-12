# REVIEW r1942: I124 batch 9, the pair-character closed branch

Log: [agent_logs/r1942-i124-pairchar.log](../agent_logs/r1942-i124-pairchar.log). Section under review: batch 9 of [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md). Footing: analysis only, one symbolic screen of seconds on objects built for it, reported as a screen.

**Verdict: the derivation is correct at every link, and its value consequence is already on the record, unconditionally, as [L224](../findings/second-order.md).** Every unit $W$ in $\mathcal D_n\oplus V_{jk}$ has $P(W)\le\Theta_n$, with no hypothesis $R=0$, so the single pair-character case of I124 was closed before batch 9 was derived. What batch 9 adds is the structural fact that $R=0$ inside one pair character forces $x$ onto two indices.

| # | claim | verdict |
|---|---|---|
| 1 | pattern of $\nu\circ\nu$ | CONFIRMED, and on the record as [L222](../findings/second-order.md) item 2 (`Q_nuX`, `Q_pair`) |
| 2 | diagonal $Q$ with no multiplier | CONFIRMED, citation apt |
| 3 | the three row families | CONFIRMED, recomputed by hand and by a symbolic screen |
| 4 | two distinct values, elimination | CONFIRMED, repeats covered |
| 5 | support on four vectors, value bound | CONFIRMED, with a sharpening: at $n\ge12$ the branch is empty |
| 6 | screens | CONFIRMED as screens |
| 7 | Lean `pair_char_supp` | CONFIRMED, standard axioms, with the non-vacuity witness missing from the file |
| 8 | record search | SUBSUMED in value by L224, the support-two fact new |

## 1. The pattern of $\nu\circ\nu$

Recomputed from $Q(X)=X^2+X^\#X$ with $f_i=\varphi_{ji}\odot\varphi_{ki}$ taken as $e_{ji,ki}+e_{ki,ji}$ (scale free).

- $\nu^2$: $f_if_{i'}=0$ for $i\ne i'$ and $f_i^2=e_{ji,ji}+e_{ki,ki}$, so $\nu^2$ contributes $x_i^2$ at $ji$ and $ki$ only.
- $\nu^\#\nu$ at $jk$: only $[\varphi_{ji},\varphi_{ki}]=\mp\varphi_{jk}$ lands there, the two structure constants have product $-1$, and the four ordered terms with the $\tfrac12$ give $-x_i^2$ per $i$, so $-s$.
- $\nu^\#\nu$ at $ii'$: the pairs $(ji,ji')$ and $(ki,ki')$ in both orders, structure constants of product $+1$, give $\tfrac12\cdot4x_ix_{i'}=2x_ix_{i'}$.
- $\nu^\#\nu$ at $ji$: $\{j,i\}$ is not the symmetric difference of $\{j,i'\}$ or $\{k,i'\}$ with any support bivector, so $0$.
- Row sums vanish ($x_i^2\cdot$ row $j$ gives $s-s$, row $i$ gives $2x_i^2+2x_i(-x_i)$), as a Weyl square must.

This is exactly $G_x$ of [L222](../findings/second-order.md) item 2, Gate 2 [r943](REVIEW_r943.md), [r944](REVIEW_r944.md), kernel-checked as `Q_nuX` in [PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean) and on all of $V_{jk}$ as `Q_pair`. **The note should cite L222 item 2 for the pattern** in place of deriving it afresh and citing batch 6 (1) only for diagonality.

## 2. $Q$ on the diagonal locus

- For diagonal $X$ with entries $M_{ab}$, $X^\#X=\tfrac12\sum_{\alpha,\beta}w_\alpha w_\beta[\varphi_\alpha,\varphi_\beta][\varphi_\alpha,\varphi_\beta]^{\mathsf T}$ is diagonal, and the entry at $ab$ collects $(ac,cb)$ and $(cb,ac)$ over $c$, giving $(M^2)_{ab}$ ($M_{aa}=0$). With $I^\#I=(n-2)I$ checked at $M=\mathbf 1\mathbf 1^{\mathsf T}-I$.
- Row sums of $M^{\circ2}+M^2$ off the diagonal are $s_a+0-s_a=0$ when $M\mathbf1=0$, so $Q(M)$ is Weyl as it stands and no multiplier appears. [diagonal-half.md](../findings/diagonal-half.md), "And the multiplier vanishes", is the right citation.
- $Q(\hat A)=p\hat A$ with $\hat A=\kappa M$, $\kappa>0$, reads $Q(M)=(p/\kappa)M$, so $\mu=p/\kappa$.

## 3. The rows

Recomputed by hand:

- $(j,k)$: $(M^2)_{jk}=\sum_iM_{ji}M_{ik}=\sum x_i^4$, so $s^2+\sum x_i^4=-\mu s$.
- $(j,i)$: $(M^2)_{ji}=M_{jk}M_{ki}+\sum_{i'\ne i}M_{ji'}M_{i'i}=-sx_i^2+2x_i(\sigma_3-x_i^3)$, so the row is $-x_i^4-(s+\mu)x_i^2+2\sigma_3x_i=0$, the stated cubic at $x_i\ne0$. The $(k,i)$ row is identical.
- $(i,i')$ with values $u,v$: $(M^2)_{ii'}=2u^2v^2+4uv(s-u^2-v^2)$, so $6u^2v^2+4uv(s-u^2-v^2)=2\mu uv$, which is $\mu=3uv+2s-2(u^2+v^2)$ at $uv\ne0$.

**Screen** (seconds, sympy, four free indices): the four row identities and the six Ricci row sums (after $\sum x=0$) hold identically. A screen of the algebra, not evidence beyond it.

## 4. The elimination

- $\sum x=0$ with $x\ne0$ puts a positive and a negative entry in $x$, which are two distinct nonzero values at two indices. Repeated values elsewhere are irrelevant: the argument uses one such pair, and its conclusion $s=u^2+v^2$ zeroes every other entry.
- Subtracting the cubics at $u\ne v$ gives $u^2+uv+v^2+s+\mu=0$. With the $(i,i')$ row, $3s=u^2-4uv+v^2$, and with $s\ge u^2+v^2$, $2(u+v)^2\le0$. So $v=-u$, $s=2u^2$.
- Consistency (not in the note, worth one line): at $x=(u,-u)$ the $(j,k)$ row gives $\mu=-6u^4/2u^2=-3u^2$, equal to the $(i,i')$ value, and $\sigma_3=0$ makes the cubic $u^3-u^3=0$. So the solution exists, with $p=\kappa\mu<0$.

## 5. The conclusion

- $\hat A\propto M$ vanishes off the six pairs of $\{j,k,i_1,i_2\}$ and $\nu=u(f_{i_1}-f_{i_2})$ lives on them, so $W$ is a padded Weyl tensor of $\mathbb R^4$ and $\theta\le M(4)=\sqrt{3/2}$ ([post F2c](../findings/fence-posts.md), padding by [L164](../findings/INDEX-results.md)).
- $Q(\hat A)=p\hat A$ enters twice, both correctly: through batch 8's formula ($\theta-ap>0$ from $\theta\ge\Theta_n\ge p$) and as the diagonal equation itself.
- The conclusion does not need $u=0$ ($\nu$ an $L_{\hat A}$ eigenvector). Batch 6 (1)'s $q=0$ is not used beyond the diagonality of $\nu\circ\nu$.
- **Sharpening.** At $n\ge12$, $\Theta_n>\sqrt{3/2}$ ($\Theta_{12}^2=\tfrac{55}{36}$, $\Theta_{13}^2=\tfrac{120}{77}$, both formulas increasing), so the hypothesis $\theta\ge\Theta_n$ and the conclusion $\theta\le\sqrt{3/2}$ are incompatible: **the branch is empty at $n\ge12$**, which is stronger than "below $\theta_0$" and should be the stated form.

## 6. The screens

- The first ($\pi_D(\nu\circ\nu)=M(x)$ at $n=8$) tests claim 1 and the second ($Q$ on a Ricci-flat diagonal tensor) tests claim 2, and both are what they say.
- The third ($R=0$ only at support $2$ over fifteen random $x$) tests the elimination on samples. At support $2$, $\sum x=0$ forces $x=(u,-u)$, so it confirms the positive case and samples the negative one. As screens they are correctly labelled.

## 7. Lean

`pair_char_supp` in [I124Circle.lean](../lean/HamiltonsCubic/Results/I124Circle.lean) states exactly the table's claim: $u\ne v$, the two cubics with common $s+\mu$ and $\sigma$, the $(i,i')$ formula for $\mu$, $u^2+v^2\le s$, concluding $v=-u$ and $s=u^2+v^2$. The proof is `linear_combination`, `linarith`, `nlinarith`. No `sorry`, `axiom` or `native_decide` in the file, and the olean postdates the source. **The file carries no non-vacuity example for this theorem** (its only `example` is for `circle_descent`). The witness $u=1$, $v=-1$, $s=2$, $\mu=-3$, $\sigma=0$ satisfies every hypothesis and should be added. `#print axioms` gives `[propext, Classical.choice, Quot.sound]`, and the witness compiles by `norm_num` in a scratch file importing the module. **CONFIRMED**, with the witness owed to the file.

## 8. On the record

- **[L224](../findings/second-order.md)** (Gate 2 [r945](REVIEW_r945.md), [r946](REVIEW_r946.md), Lean): every unit $W\in\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$ has $P(W)\le\Theta_n$, equality only at $(j,k)$-rotations of L57 maximisers. Batch 9's $W=a\hat A+b\nu$ lies in $\mathcal S_{jk}$. So $\theta\le\Theta_n\le\theta_0(n)$ **for every critical point with $\nu$ in one pair character, with no $R=0$ hypothesis and no batch 8**, and $\theta\ge\theta_0$ leaves only the equality points at even $n$, which are diagonal in a rotated frame and so outside I124's "non-diagonal".
- Batch 6 itself cites L224 for "one pair block is capped at $\Theta_n$" and then lists the pair character as left. That listing was the gap batch 9 set out to fill, and it was already filled. [r1941](REVIEW_r1941.md) (line 79) made the same observation about L224 needing no padding.
- The four-set case likewise has [L220](../findings/second-order.md) on the record.
- **Classification.** The value consequence is **agreement with L224, which subsumes it**. The support statement ($R=0$ in one pair character forces $|\operatorname{supp}x|=2$, so $W$ is padded from $\mathbb R^4$) is not on the record and is new, as a structural fact.
- **Consequence for "What it gives".** The sentence "in the $R=0$ branch a non-diagonal critical point above $\theta_0$ has $\nu$ over at least two sign characters" holds in **both** branches by L224 and L220: a single-character $\nu$ is closed whatever $R$ is. The owed list should read: $\nu$ over several characters, in either branch.
