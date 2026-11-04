# REVIEW r1823: L224 step 5's line at odd n in Lean

*Gate 2 reviewer r1823 on [L224LineOdd.lean](../lean/HamiltonsCubic/Results/L224LineOdd.lean) at commit fd7a87d5, `L224_line_odd`, against [findings/second-order.md](../findings/second-order.md), Lemma L224, step 5. Analysis only: every check below is by hand from the Lean source and the record, plus one compile and one axiom audit of the file. The hand evaluation at n = 5 is exact arithmetic, labelled as such.*

| Claim | Verdict |
|---|---|
| (a) $v_j\ne v_k$ from $W'$'s nonzero odd part at odd $n$ | CONFIRMED |
| (b) $v$ takes exactly the values $v_j,v_k$, the record's "j and k lie in different blocks" | CONFIRMED |
| (c) $\bar u$ lies in the plane, $\langle\bar u,z\rangle=\langle v,z\rangle$ there, and $\bar u$ is the record's centred indicator of $A'$ up to scale | CONFIRMED WITH OBSERVATIONS |
| (d) The conclusion says what the record says, compared with `L224_line_even` | CONFIRMED WITH OBSERVATIONS |
| lean/INDEX.md's L224 row: the L224LineOdd sentence, r1820's O2, O3, O5, O6, and the owed list | CONFIRMED WITH OBSERVATIONS |
| Compile and axiom audit | CONFIRMED |

**Summary.** `L224_line_odd` is a faithful proof of step 5's line at odd $n\ge5$, and every step checks by hand. Its exported conclusion is collinearity of $y$ and $x$ in the plane, with the identification of the line (the projection of $v$, the record's centred indicator of $A'$) proved inside the proof and left unexported, as at even $n$.

## 1. The record

The record's step 5 reads, verbatim:

> $W'$ is an L57 maximiser $B'$ with swap-even part $E$ and nonzero odd part, so $j$ and $k$ lie in different blocks $A\ni j$, $B\ni k$ of $B'$, which is block-constant with values $\alpha_A,\alpha_B$ inside the blocks and $\gamma$ across. Since $G_z$ is swap-even, $q_E=q_{B'}$, and expanding, $q_{B'}(z)=(\alpha_A+\alpha_B-2\gamma)\big(\sum_{a\in A'}z_a\big)^2$ with $A'=A\setminus\{j\}$. On $\{\sum z=0\}$ this is $c\langle\bar u,z\rangle^2$ with $\bar u$ the centred indicator of $A'$, so $\lambda=c\lVert\bar u\rVert^2>0$ has the line of $\bar u$ as its whole eigenspace, and both $y$ and $x$ lie on it: $(y,x)=\sqrt s\,\hat u\,(\cos\psi,\sin\psi)$.

## 2. The declaration

`L224_line_odd` takes $n\ge5$ odd, $j\ne k$, $D$ Weyl of character $1$, $\nu$ Weyl of character $\varepsilon_j\varepsilon_k$, and $P(D+\nu)=\sqrt{\texttt{thetaOddSq}}\,\lVert D+\nu\rVert^3$. It returns $y,x$ in the plane $\{z_j=z_k=0,\ \sum z=0\}$ with $\tfrac12(D-\sigma D)=D^-_y$ and $\nu=\nu_x$, and either $y=x=0$ or some `ub` with `ub j = 0`, `ub k = 0`, $\sum\bar u=0$, $\sum\bar u^2>0$, and $y_l=\frac{\langle\bar u,y\rangle}{\lVert\bar u\rVert^2}\bar u_l$, $x_l=\frac{\langle\bar u,x\rangle}{\lVert\bar u\rVert^2}\bar u_l$ for every $l$. The route is `L224_eq_tight` with `L57_odd`, then `charOne_eq_odd` at $W'=E+D^-_{z_s}$, $z_s=\sqrt s\,z_1$.

## 3. (a) $v_j\ne v_k$

The proof writes $M'=D^-_{z_s}$ as the odd part $\tfrac12(w-w^\sigma)$ of $W'$'s weight $w=tZ'(v)$, through $\sigma M'=-M'$, $\sigma E=E$ and `rotR_swap_coordOp`, and compares weights entrywise at $(j,a)$, $a\notin\{j,k\}$, by `coordOp_weight_eq`. At $(j,a)$ the weight of $D^-_{z_s}$ is $(z_s)_a$, since `uj` is $1$ at $j$ and `vy` vanishes at $j$. The odd part there is $\tfrac12(w_{ja}-w_{ka})$ because the swap sends $(j,a)$ to $(k,a)$. From `Zp`,

$$w_{ja}-w_{ka}=t\Big[v_a(v_j-v_k)+\frac{v_j^2-v_k^2}{n-2}\Big],$$

the $\frac{v_a^2}{n-2}$ and $-\frac1{(n-1)(n-2)}$ terms cancelling. So $(z_s)_a=\tfrac12t\big[v_a(v_j-v_k)+(v_j^2-v_k^2)/(n-2)\big]$, and $v_j=v_k$ makes both terms vanish, giving $z_s=0$, hence $\sum z_s^2=0$ against $\sum z_s^2=s>0$. This is exactly the contrapositive the brief names and r1820 O6 asked for. It uses nothing parity-specific, which is correct: at odd $n$ the even-$n$ shortcut $v_j^2=v_k^2$ is unavailable, and the proof does without it. CONFIRMED.

## 4. (b) Two values, different blocks

`charOne_eq_odd` returns $x_0\ne y_0$ with every $v_a\in\{x_0,y_0\}$ and the block sizes differing by one. With $v_j\ne v_k$ both in $\{x_0,y_0\}$, $\{v_j,v_k\}=\{x_0,y_0\}$, so every $v_p\in\{v_j,v_k\}$, which is `h2`, $(v_p-v_j)(v_p-v_k)=0$. The case split in the proof closes the one impossible case ($v_j=v_k$ through $x_0$ or $y_0$) by `hvne` and the rest by rewriting. L57's blocks at odd $n$ are the level sets of $v$ (the maximiser $tZ'(v)$ is block-constant on them), so $v_j\ne v_k$ is precisely "$j$ and $k$ lie in different blocks $A\ni j$, $B\ni k$". The Lean does not name $A$, $B$, which it does not need, since `inner_Zp_Gy_two` consumes only `h2`. CONFIRMED.

## 5. (c) The projection $\bar u$

Define $m=\frac{\sum_{a\notin\{j,k\}}v_a}{n-2}$ and $\bar u=\mathrm{vy}(v)-m\,\mathrm{vy}(\mathbf 1)$.

- **In the plane.** $\bar u_j=\bar u_k=0$ since `vy` vanishes there, and $\sum\bar u=\sum_{\text{off}}v-m(n-2)=0$ (`hind`, `hubs`).
- **Same pairing.** For $z$ in the plane, $\langle\mathrm{vy}(\mathbf 1),z\rangle=\sum z=0$ and $\langle\mathrm{vy}(v),z\rangle=\langle v,z\rangle$ because $z_j=z_k=0$ (`hvzz`, `hvu`). So $\langle\bar u,z\rangle=\langle v,z\rangle$. Since $v-\bar u=v_je_j+v_ke_k+m(\mathbf 1-e_j-e_k)$ lies in the plane's orthogonal complement $\mathop{\mathrm{span}}(e_j,e_k,\mathbf 1)$, $\bar u$ is the orthogonal projection of $v$ onto the plane, as the docstring says.
- **The record's $\bar u$.** Off $\{j,k\}$, $v=v_j$ on $A'=A\setminus\{j\}$ and $v=v_k$ on $B\setminus\{k\}$, so $\mathrm{vy}(v)=v_k\mathrm{vy}(\mathbf 1)+(v_j-v_k)\mathbf 1_{A'}$ and $\bar u=(v_j-v_k)\big(\mathbf 1_{A'}-\tfrac{\lvert A'\rvert}{n-2}\mathrm{vy}(\mathbf 1)\big)$. That is $(v_j-v_k)$ times the indicator of $A'$ centred over the $n-2$ coordinates off $\{j,k\}$, the record's "centred indicator of $A'$" read with that centring set (O1).
- **The constant.** The record's $c=\alpha_A+\alpha_B-2\gamma$ is, from `Zp`, $t\big[v_j^2+v_k^2-2v_jv_k\big]=t(v_j-v_k)^2$ (the $\frac{2v^2}{n-2}$ and constant terms cancel between $\alpha_A+\alpha_B$ and $2\gamma$). So $c\langle\bar u_{\text{rec}},z\rangle^2=t\langle\bar u,z\rangle^2$, and `hq`'s $q_E(z)=t\langle\bar u,z\rangle^2$ is the record's expansion.

`hq` itself is sound: $\langle M',G_z\rangle=0$ by `inner_flip_zero` ($G_z$ swap-even by `Gy_swap`, $M'$ swap-odd), so $q_E(z)=\langle W',G_z\rangle$, then `inner_Zp_Gy_two` with `h2`, then `hvu`. CONFIRMED WITH OBSERVATIONS (O1, O2).

## 6. (d) Coverage

The squeeze is the even file's: $\lambda=q_E(z_1)\le t\lVert\bar u\rVert^2$ by Cauchy-Schwarz (`cs_le`), $\ge$ by `hbound` at $\bar u$, so $\lambda=t\lVert\bar u\rVert^2$, and $\lVert\bar u\rVert^2>0$ because $\bar u=0$ would force $q_E(z_1)=0$ against $\lambda>0$. Then $q_E(w')=\lVert w'\rVert^2\lambda$ is equality in Cauchy-Schwarz, so $w'$ is on the line of $\bar u$ (`cs_eq`), applied to $y$ and $x$ through `hqy`, `hqx`. This is the record's "λ = c‖ū‖² > 0 has the line of ū as its whole eigenspace, and both y and x lie on it".

Against `L224_line_even` the statements are the same shape, with $\theta_0(n)$ replaced by $\Theta_n$, $n\ge4$ by odd $n\ge5$, and the even file's extra `Even n ∧` in the second branch absent (at odd $n$ the branch needs no parity witness). The two differ in the proof only at the oddness step and at $\bar u$ (at even $n$, $\bar u=\mathrm{vy}(v)$ since $v_j=-v_k$ makes $m=0$).

The exported second branch is the statement that $y$ and $x$ are collinear in the plane, since `ub` is existential and constrained only to be a nonzero plane vector: when $y\ne0$, `ub := y` satisfies it whenever $x\parallel y$. The record's further content (the line is that of the centred indicator of $A'$, and it is $\lambda$'s whole eigenspace) is proved in the body and not exported. That is enough for the next step of the record, which needs only $(y,x)=\sqrt s\,\hat u(\cos\psi,\sin\psi)$ for some unit $\hat u$, but the rotation step will want $\bar u$ tied to $W'$ (O3). CONFIRMED WITH OBSERVATIONS.

## 7. Hand evaluation at n = 5 (exact, by hand)

This is a hand evaluation, labelled as such, and a screen of the formulas above rather than evidence for the theorem.

- Blocks $A=\{0,1,2\}$, $B=\{3,4\}$, $j=0$, $k=3$. Put $v=r$ on $A$, $v=\beta$ on $B$. $\sum v=0$ gives $\beta=-\tfrac32r$, and $\sum v^2=3r^2+\tfrac92r^2=\tfrac{15}2r^2=1$ gives $r=\sqrt{2/15}$.
- $\mathrm{vy}(v)=(0,r,r,0,-\tfrac32r)$, off-sum $\tfrac r2$, so $m=\tfrac r6$ and $\bar u=(0,\tfrac56r,\tfrac56r,0,-\tfrac53r)=\tfrac56r\,(0,1,1,0,-2)$.
- $\sum\bar u=\tfrac56r(1+1-2)=0$, and $\bar u_0=\bar u_3=0$.
- Plane vector $z=(0,1,0,0,-1)$: $\langle v,z\rangle=r+\tfrac32r=\tfrac52r$ and $\langle\bar u,z\rangle=\tfrac56r+\tfrac{10}6r=\tfrac52r$. Equal.
- The record's $\bar u_{\text{rec}}$: $A'=\{1,2\}$ centred over $\{1,2,4\}$ is $(0,\tfrac13,\tfrac13,0,-\tfrac23)$, and $(v_j-v_k)\bar u_{\text{rec}}=\tfrac52r\cdot\tfrac13(0,1,1,0,-2)=\bar u$. Equal.
- The constants: $c=t(v_j-v_k)^2=t\cdot\tfrac{25}4\cdot\tfrac2{15}=\tfrac56t$, $\lVert\bar u_{\text{rec}}\rVert^2=\tfrac69=\tfrac23$, so $\lambda=c\lVert\bar u_{\text{rec}}\rVert^2=\tfrac59t$, and $t\lVert\bar u\rVert^2=t\cdot\tfrac{25}{36}\cdot\tfrac2{15}\cdot6=\tfrac59t$. Equal.
- **The line** is $\mathbb R\,(0,1,1,0,-2)$ inside the two-dimensional plane $\{z_0=z_3=0,\ z_1+z_2+z_4=0\}$, and at equality $y$ and $x$ are both multiples of $(0,1,1,0,-2)$.

## 8. lean/INDEX.md's L224 row

- **L224LineOdd sentence.** It reads "**`L224_line_odd`**, at $P(D+\nu)=\Theta_n\lVert D+\nu\rVert^3$, odd $n\ge5$, either $y=x=0$ or $y$, $x$ are multiples of one $\bar u\ne0$ in the plane, $\bar u$ the projection of $v$ onto it ($v$ off $\{j,k\}$ minus its mean there), through `charOne_eq_odd`, $v_j\ne v_k$ from $W'$'s nonzero odd part (so $v$ takes exactly the values $v_j,v_k$, r1820 O6) and `inner_Zp_Gy_two`; standard three axioms." Every clause matches the proof. The clause "$\bar u$ the projection of $v$ onto it" describes the proof's witness and reads as part of the statement (O3).
- **O2.** "at $n=4$ the plane is a line and the conclusion is immediate, $n=6$ being the first informative case (O2)". Accurate for the even theorem. At odd $n$ the first case, $n=5$, already has a two-dimensional plane and is informative, which the row does not need to say.
- **O3.** `inner_Zp_Gy_two` is described as "the same pairing $t\langle v,z\rangle^2$ whenever every $v_p$ is $v_j$ or $v_k$, which covers L57's maximisers at both parities". The parity tension r1820 O3 named is resolved in the row's wording.
- **O5.** "every term of $Z'$ of the form $f(i)+f(l)$, the $v_p^2/(n-2)$ terms and the constant, cancels identically since $G_z$'s off-diagonal row sums vanish, and the two-valued hypothesis closes the $v_iv_l$ part". Accurate, the constant included.
- **O6.** Carried in the L224LineOdd sentence and in the proof, which derives $v_j\ne v_k$ from both terms vanishing, as §3 checks.
- **Owed list.** It reads "the rotation $e^{\varphi\xi}$ carrying $W'$ to $W$ (L222 item 5); and the Statement's equality clause on the operators assembled from these (r1815 O3)", followed by the L57Block link and L57's block-constant equality clause. It names the rotation and the assembled equality clause, and the odd-$n$ line is gone from it. Accurate.

CONFIRMED WITH OBSERVATIONS (O3, O4).

## 9. Compile and audit

- `lake env lean HamiltonsCubic/Results/L224LineOdd.lean` from lean/: exit 0, no errors, no warnings, no `sorry`.
- `python3 scripts/misc/axiom_audit.py --only L224LineOdd.lean`: "auditing 1 declarations across 1 files", "1/1 clean -- resting on the standard three alone".
- The file matches its state at fd7a87d5 (no diff against HEAD).

CONFIRMED.

## Observations

- **O1, the centring set, carried from r1820 O1.** The record's "the centred indicator of $A'$" is right only when centred over the $n-2$ coordinates off $\{j,k\}$. At odd $n$ the Lean's $\bar u$ equals $(v_j-v_k)$ times that vector (§5, §7). Centred over all $n$ coordinates, the vector is nonzero at $j$ and $k$ and lies outside the plane. A few words in the record ("centred over the coordinates off $\{j,k\}$") would close it.
- **O2, $z_s$ is already on the line.** Since $\sum v=0$, $m=-\frac{v_j+v_k}{n-2}$, so §3's formula reads $(z_s)_a=\tfrac12t(v_j-v_k)(v_a-m)$ off $\{j,k\}$, that is $z_s=\tfrac t2(v_j-v_k)\,\bar u$ at odd $n$ too. This is r1820 O7's by-product at both parities. The Lean uses only its contrapositive, which suffices.
- **O3, the exported conclusion is collinearity.** `ub` is existential with no tie to $v$, $W'$ or the blocks, so the second branch says exactly that $y$ and $x$ are linearly dependent in the plane. The docstring and the INDEX sentence's "$\bar u$ the projection of $v$ onto it" describe the witness the proof chooses. This repeats r1820 O4 at odd $n$. An export such as $\bar u=\mathrm{vy}(v)-m\,\mathrm{vy}(\mathbf 1)$ with $W'=\mathrm{coordOp}(tZ'(v))$, or $\lambda=t\lVert\bar u\rVert^2$, would serve the owed rotation step and would make the INDEX clause a statement fact.
- **O4, the blocks stay implicit.** "j and k lie in different blocks" enters as $v_j\ne v_k$ with $v$ two-valued, which is the same fact in level-set form. The Lean never names $A$, $B$ or $A'$, so the record's $c=\alpha_A+\alpha_B-2\gamma$ appears in Lean only as $t(v_j-v_k)^2$ after rescaling $\bar u$ (§5). Consistent, and worth one clause in the row if a later reader compares the two.

## What would falsify each headline

- **(a)** An entry $(j,a)$, $a\notin\{j,k\}$, where the odd part of $tZ'(v)$ differs from $\tfrac12t[v_a(v_j-v_k)+(v_j^2-v_k^2)/(n-2)]$, or a `coordOp_weight_eq` application at a pair other than $(j,a)$.
- **(b)** A maximiser returned by `charOne_eq_odd` with three distinct values, or a two-valued $v$ with $v_j\ne v_k$ and some $v_p\notin\{v_j,v_k\}$ (impossible when there are only two values).
- **(c)** A plane vector $z$ with $\langle\bar u,z\rangle\ne\langle v,z\rangle$, or a two-valued $v$ at odd $n$ where $\bar u$ is not $(v_j-v_k)$ times the off-$\{j,k\}$ centred indicator of $A'$. §7 is one exact instance of both identities holding.
- **(d)** A pair $(D,\nu)$ at equality with $y,x$ in the plane and linearly independent, which would contradict the Cauchy-Schwarz squeeze of §6.
- **INDEX** A clause in the row not matched by the proof, or the owed list omitting the rotation or the assembled equality clause.
