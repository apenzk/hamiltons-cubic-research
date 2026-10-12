# Brief for round L39

**Verbatim extracts. Nothing here is paraphrased. TWO CLOSED FORMS FOR $\theta^2$ APPEAR BELOW, ONE IN THREE INVARIANTS AND ONE IN FOUR. BOTH ARE GIVEN UNLABELLED.**

## A. The canonical entry, results.md lines 525-531

```markdown
##### Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair

Let $(\mathfrak g,\mathfrak k)$ be a symmetric pair with $\mathfrak g\subseteq\mathfrak{so}(n)$, $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, and let $W$ be the two-eigenvalue operator constant on $\mathfrak k$ and on $\mathfrak m$. Then $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ identically and $\theta^2=\frac{(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2}{4p^3q(p+q)^3}$, where $S_{\mathfrak{abc}}$ is the bracket mass on the named blocks. When $\mathfrak g$ is simple with Killing constant $c$, $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$ and $c=2h^\vee(\mathfrak g)/I_\rho$, dual Coxeter number over Dynkin index, so $\theta$ depends on $p$, $q$, $S_{\mathfrak{kkk}}$ and $c$ alone; when $\mathfrak k$ has a centre, $S_{\mathfrak{kkk}}$ is the sum over its simple ideals. The formula gives the value of the point and decides nothing about whether that point is a Weyl tensor: Weyl-ness is a property of the embedding $\rho$, of which there are infinitely many per pair, and two pairs with identical $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})$ can fail it differently.

**Proof:** [target.md](findings/target.md)

##### Observation L40, the surviving target, measured
```

## B. The landscape statement, results.md line 164

```markdown
- **Lemma L39 (landscape). The two-eigenvalue formula for an arbitrary symmetric pair.** For any symmetric pair $(\mathfrak g,\mathfrak k)$ inside $\mathfrak{so}(n)$ with $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, the two-eigenvalue point has $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ and $\theta^2=(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2/(4p^3q(p+q)^3)$; for simple $\mathfrak g$ the constants come from $c=2h^\vee/I_\rho$.
```

## C. The block, findings/target.md lines 655-677

```markdown
#### Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair


> **BOTH VANISHINGS ARE FREE FROM THE GRADING, AND "IDENTICALLY" UNDERSTATES THEM.** $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$ kills $S_{\mathfrak{kkm}}$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$ kills $S_{\mathfrak{mmm}}$, **properties of the decomposition, independent of $W$ and of the two-eigenvalue point.** The third relation $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ is used in neither; it closes the Killing split instead. *The denominator $4p^3q(p+q)^3$ is produced by $a^6$ rather than asserted, and the coefficient $3$ is the multinomial weight on the odd index's three slot placements.*

> **THE REDUCTION IS TO THREE INVARIANTS, NOT FOUR.** Running the same Killing argument on $\mathfrak m$ gives $S_{\mathfrak{kmm}}=cq/2$, hence $S_{\mathfrak{kkk}}=c(p-q/2)$, **so $S_{\mathfrak{kkk}}$ is determined** and
> $$\theta^2=\frac{\big(cq(3p-q)-4p(p-q)\big)^2}{16\,p^3q(p+q)}.$$
> **Two corollaries the record lacked**: $q\le2p$ for every symmetric pair with $\mathfrak g$ simple, with equality exactly when $\mathfrak k$ is abelian; and the record's known equal-$\theta$ pair is **forced**, both members having $(p,q,c)=(7,8,8)$.

> **THE GAP: NO ADMISSIBILITY HYPOTHESIS, AND THIS COPY DROPPED THE GUARD THE CANON CARRIES.** The formula values an operator that is **generically not a Weyl tensor**, and at unbalanced sphere pairs it overshoots the true $\theta$ every time, *$1.389084$ against $\Theta_9^2=1.371429$ at $n=9$, and by $12.6\%$ at $n=5$.* **Restoring the Weyl-ness scope sentence is the load-bearing repair.**

> **THE MAXIMISER IS IN SCOPE, AND THE SIMPLICITY WORRY WAS AIMED ONE LEVEL TOO LOW.** At the balanced pair $(\mathfrak{so}(2k),\mathfrak{so}(k)\oplus\mathfrak{so}(k))$, with $p=k(k-1)$ and $q=k^2$, the numerator collapses to $4k^2(k-1)^2(2k-1)$ and the formula returns $2(n-1)(n-2)/n^2$ **exactly when $c=4(k-1)$**, that is, $c=2h^\vee(\mathfrak{so}(2k))$ with $I_\rho=1$, **so the maximiser decides the $I_\rho$ normalisation rather than table data doing it** ([L39.lean](../lean/HamiltonsCubic/Results/L39.lean), cross-multiplied so no division is taken), the non-simple $\mathfrak{so}(k)\oplus\mathfrak{so}(k)$ is $\mathfrak k$, while $\mathfrak g=\mathfrak{so}(2k)$ is simple. **At odd $n$ the maximiser is an unbalanced pair, which this formula cannot reach**, so its silence at odd $n$ is structural rather than an omission. *Triality is a non-issue: the formula is triality-blind by construction, $\theta$ is triality-invariant, and neither member of the $n=8$ pair is in scope.*

> **THE CONVENTION IS FULLY ORDERED, AND THE RECORD CARRIES BOTH READINGS.** L39's $(1,3,3,1)$ weights are multinomial and close only in the ordered reading; **[Lemma L114](bounds-relaxations.md)'s $6/4/2$ identity is the *unordered* form of the same statement**, one reviewer derived both. *Each is right in its own reading, neither file says which, and under the unordered reading L39's two coefficients become equal.* **$S_{XYZ}$ is defined nowhere on the record, [conventions.md](conventions.md) included.**

*This copy is the stalest of the three: [report/](../report/) carries both the $I_\rho$ normalisation trap and the $\mathfrak k$-centre correction that this file installed 296 lines above the block, and it says "five Cartan series" where this says four. The named section exists and is the derivation, quoted truncated mid-word.*
Nothing in the derivation above used $\su(m)$. For *any* symmetric pair $(\mathfrak g,\kk)$ inside $\so(n)$ with $p=\dim\kk$, $q=\dim\mm$, the two-eigenvalue point has $S_{\kk\kk\mm}=S_{\mm\mm\mm}=0$ identically and
\[
\theta^2\;=\;\frac{\big(S_{\kk\kk\kk}q^2+3S_{\kk\mm\mm}p^2-2p^3+2pq^2\big)^2}{4p^3q(p+q)^3}.
\]
When $\mathfrak g$ is simple with Killing constant $c$, $S_{\kk\kk\kk}+S_{\kk\mm\mm}=cp$, so $\theta$ depends on four invariants only: $p$, $q$, $S_{\kk\kk\kk}$, $c$. The constant is classical table data, $c=2h^\vee(\mathfrak g)/I_\rho$, dual Coxeter number over Dynkin index.

```
