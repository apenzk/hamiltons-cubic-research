# VERIFY v36, Lemma L157's $t$ carries the margin coefficient $1$ where Lemma L149's repaired branch carries $\rho^{\mathrm{eff}}_n$

*Adjudicator v36, 2026-09-05. One candidate, raised as [ROUND_L157](ROUND_L157.md) D6 against [Lemma L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t). **No numerical work was done: no script was run, and every value below is an exact hand evaluation from closed forms already on the record.** Log: [agent_logs/verify-L157-D6-v36.log](../agent_logs/verify-L157-D6-v36.log). No other verifier's report was opened.*

**UPHELD.**

L157's $t$ uses $\sqrt{c_p+w^2}$; the same file's [Lemma L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform) proves the margin coefficient on $w^2$ is $\rho^{\mathrm{eff}}_n$, which is $0.71904364$ at $n=12$. The two numerators are the same object under the same normalisation, on the same branch of the same chain. The coefficient is below $1$, so L157's $t$ is too large, by $1.0867$ at the record's settled minimiser $w_0=\tfrac23$ and by $1.1214$ at $w=1$, the figure the candidate quotes. The consequence runs the unsafe way: the recorded reach is a **lower** bound and it is stated upward. Two clauses of the candidate need amendment rather than acceptance, and both make the finding sharper: the $12\%$ is the $w=1$ value and not the value at the binding direction, and the defect's scope reaches $n=16$ and then reverses sign from $n=18$.

---

## 1. What each lemma actually writes

**L157, [findings/second-order.md:1257](../findings/second-order.md#L1257)**, inside the boxed statement of the lemma:

> **LEMMA L157.** *In units of $\rho$ the two coupled branches are $\eta$ and $t(1-\eta)^2$ with $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$; they cross at the unique root in $(0,1)$*

and again at [findings/second-order.md:1260](../findings/second-order.md#L1260), in the exact identity the same box states:

> $$\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}\,(1-\eta^*)^2 .$$

**L149's repaired branch, [findings/second-order.md:1229](../findings/second-order.md#L1229)**, opening the proof of the uniformity:

> **Proof of the uniformity.** Write $g_\rho(w)=\sqrt{c_p+\rho w^2}\big/\big(a_0n^{1/2}+nw\big)$ with $a_0=\sqrt{2n/(n-2)}$ from [Lemma L146](../findings/second-order.md), $c_p=\kappa/n$ and $\rho=\rho^{\mathrm{eff}}_n$.

and the coefficient it repairs, in the second of L149's two inputs at [findings/second-order.md:1210](../findings/second-order.md#L1210):

> - $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}\,w^2$, the margin being $3\theta_0(\tfrac12-\lambda)$ on each summand of [Lemma L27](../findings/nondegeneracy.md) and the form quadratic, so on $\lVert H\rVert_F=1$ it is a **convex combination** of the summand margins.

**They differ in exactly one factor: the coefficient multiplying $w^2$ under the square root.** L149 writes $\rho^{\mathrm{eff}}_n$; L157 writes $1$. Everything else ($c_p$, the square root, $\lambda$, the placement inside $t$), is common.

**A third site, which is what makes the two comparable rather than merely adjacent.** [Lemma L158](../findings/second-order.md#lemma-l158-the-branch-comparison-turns-on-one-dimension-dependent-constant-and-it-says-suplvert-prvert-must-grow-before-i31-can-bind)'s settled box, [findings/second-order.md:1301](../findings/second-order.md#L1301), writes branch 2 with L157's prefactor and L149's denominator in one display:

> $$\text{branch }2=\underbrace{\frac{\lambda(1-\eta^*)^2}{\sqrt2\,J}}_{K}\cdot\frac{\sqrt{c_p+w^2}}{a_0n^{1/2}+nw}:\qquad\textbf{$J$ divides $K$.}$$

That is L149's $g_\rho$ with $\rho$ set to $1$, multiplied by a prefactor built from L157's $\eta^*$. The record therefore joins the two numerators itself; they are not two independent objects that happen to look alike.

**And L149's own chain display carries the same coefficient-$1$ form**, at [findings/second-order.md:1214](../findings/second-order.md#L1214):

> $$r(H)\;\gtrsim\;\min\!\left(\frac{c_p+u^2}{S+au},\ \frac{\sqrt{c_p+w^2}}{n^{1/2}+nw},\ \frac{\rho(H)}2\right),$$

so L149's display and L149's proof disagree with each other by the same factor. This matters for the verdict's scope in §5: the defect is not confined to L157.

## 2. Whether they are the same quantity

They are. Four checks, each closed by something the record states rather than by an inference of mine.

**The same $w$.** L149 defines it at [findings/second-order.md:1205](../findings/second-order.md#L1205): *"Write $H=H_s+H_r$ with $H_s$ in the **joint** $\lambda_m$-eigenspace, both copies, and $w:=\lVert H_r\rVert$ the weight outside **both**."* L158's Gate-2 box at [findings/second-order.md:1310](../findings/second-order.md#L1310) records [r716](../reviews/REVIEW_r716.md) re-deriving [L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects)'s normalisation *"confirming $w\in[0,1]$ and $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$ as one quantity written two ways"*, and L157's own text at [findings/second-order.md:1266](../findings/second-order.md#L1266) evaluates its $t$ at $w=0$, at $w^*=0.553$, at $0.829$ and at $w=1$, the same closed interval, the same parametrisation.

**The same normalisation.** Both live on $\lVert H\rVert_F=1$: L149's convex-combination step needs it, and L158's envelope box makes $\lVert H_s\rVert_F=\sqrt{1-w^2}$ an identity from it. There is no rescaling between the two that could absorb a coefficient.

**The same numerator *of*.** L157 says at [findings/second-order.md:1264](../findings/second-order.md#L1264): *"Branch 2 is $\lambda\sqrt c/\lVert A''\rVert$"*. So L157's $\sqrt{c_p+w^2}$ is $\sqrt{c}$ with $c=c(H)$, the margin, exactly the quantity L149's bullet lower-bounds. Tracing $t$ confirms the placement: with $\lVert A''\rVert\le2J\lVert H\rVert_{op}/((1-\eta)^2g_n)$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$, both from L158's settled box,

$$\frac{\text{branch }2}{\rho}=\frac{\lambda\sqrt c\,(1-\eta)^2g_n}{2J\lVert H\rVert_{op}}\cdot\frac{\lVert H\rVert_{op}}{\gamma g_n}=\frac{\lambda\sqrt c}{2J\gamma}(1-\eta)^2,$$

so $t=\lambda\sqrt c/(2J\gamma)$ with $\sqrt c$ the margin's square root and nothing else. The identification is forced by the algebra, not assumed.

**The same branch.** Both are branch 2 of the three-branch chain at [findings/second-order.md:1214](../findings/second-order.md#L1214). L157 does not introduce a fourth branch, and L158's box shows branch 2 in the joint form. **So the "two different branches, both right" reading has no foothold**, it is refuted by a display the record itself writes.

**The coefficient is an equality, not a floor.** L149's derivation is $c(H)\ge c_p(1-w^2)+c_{\min}w^2=c_p+(c_{\min}-c_p)w^2$, and the box at [findings/second-order.md:1223](../findings/second-order.md#L1223) states $\rho^{\mathrm{eff}}_n$ is *"$c_{\min}-c_p$"*. So the coefficient is pinned at $\rho^{\mathrm{eff}}_n$; writing $1$ in its place is licensed only if $c_{\min}\ge c_p+1$, which §3 refutes at $n=12$. There is no slack in which coefficient $1$ could be a weaker-but-valid lower bound.

## 3. The value and sign of $\rho^{\mathrm{eff}}_n$

**Its definition**, L149's box at [findings/second-order.md:1222](../findings/second-order.md#L1222):

> $$\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert,\qquad\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big),$$

with $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ from [conventions.md](../findings/conventions.md), and $c_p=3\theta_0/(n-2)$ from L158's box at [findings/second-order.md:1282](../findings/second-order.md#L1282).

**Exact evaluation at $n=12$.** Since $\tfrac29\cdot9=2$, the penalty term is exactly $2\big(\theta_0-\sqrt{3/2}\big)$ and

$$\rho^{\mathrm{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-2\theta_0+2\sqrt{3/2}=2\sqrt{3/2}-\theta_0(n)\,\frac{n+16}{2(n-2)} .$$

At $n=12$: $\theta_0(12)=\sqrt{220}/12=1.23603308$, $\tfrac{n+16}{2(n-2)}=\tfrac{28}{20}=1.4$, and $2\sqrt{3/2}=2.44948975$, giving

$$\rho^{\mathrm{eff}}_{12}=2.44948975-1.73044631=0.71904344 .$$

This reproduces the record's own printed $0.71904$ at [findings/second-order.md:1223](../findings/second-order.md#L1223). **It is strictly less than $1$, so L157's $t$ is too large.** The closed form for the sign is

$$\rho^{\mathrm{eff}}_n<1\iff\theta_0(n)\,\frac{n+16}{2(n-2)}>2\sqrt{3/2}-1=1.44948975 .$$

**The scope, evaluated exactly at each dimension in the programme's low range.**

| $n$ | $\theta_0(n)$ | $\theta_0\cdot\tfrac{n+16}{2(n-2)}$ | $\rho^{\mathrm{eff}}_n$ | $\rho^{\mathrm{eff}}_n<1$? |
|---|---|---|---|---|
| $12$ | $\sqrt{220}/12=1.23603308$ | $1.73044631$ | $0.71904344$ | yes |
| $14$ | $\sqrt{312}/14=1.26168012$ | $1.57710015$ | $0.87238960$ | yes |
| $16$ | $\sqrt{420}/16=1.28086885$ | $1.46385012$ | $0.98563963$ | yes |
| $18$ | $\sqrt{544}/18=1.29576709$ | $1.37675253$ | $1.07273722$ | no |

**So the coefficient crosses $1$ between $n=16$ and $n=18$, and L157's $t$ is too large at $n\in\{12,14,16\}$ and too small from $n=18$.** This corrects L149's own scope clause at [findings/second-order.md:1210](../findings/second-order.md#L1210), *"It is unsafe exactly on $n\in\{12,14\}$"*, which is read off the **un-penalised** coefficient $3\theta_0\tfrac{n-8}{2(n-2)}$, that quantity is $1.09788758$ at $n=16$ and does exceed $1$ there, but $\rho^{\mathrm{eff}}_{16}=0.98564<1$ once the penalty the same box mandates is subtracted. $n=16$ is unsafe too.

**Robustness to the open debt.** The box at [findings/second-order.md:1225](../findings/second-order.md#L1225) marks the penalty coefficient $\tfrac29$ a `HYPOTHESIS-DEBT` and records the alternative reading at coefficient $1$. All three readings at $n=12$ are below $1$:

- penalty $\tfrac29$ (the box's own): $0.71904344$;
- penalty $1$: $0.74161985-0.10159293=0.64002692$;
- no penalty at all (the $m$-form bullet): $3\theta_0\tfrac{m-4}{2(m-1)}=0.74161985$.

**The finding therefore does not turn on the unresolved $\tfrac29$.** As an internal check on the arithmetic, the $n$-free coefficient $\big(\tfrac{\sqrt2n}{3\sqrt{(n-1)(n-2)}}+\tfrac1\rho\big)^{-1/2}$ of L149's proof evaluates at $n=12$ to $\big(0.53934897+1.39073719\big)^{-1/2}=0.71979787$ under the first reading and to $\big(0.53934897+1.56243528\big)^{-1/2}=0.68977392$ under the second, reproducing both numerals the record prints, $0.7197978$ and $0.689771$.

**One inconsistency inside L149's own box, recorded because it is on the same line.** The box closes *"The $m$-form $3\theta_0\tfrac{m-4}{2(m-1)}$ of the bullet above and this $n$-form are the same quantity under $n=2m$, both equal to $c_{\min}-c_p$."* Under $n=2m$ the two **fractions** do agree, $\tfrac{m-4}{m-1}=\tfrac{n-8}{n-2}$; but the displayed $n$-form subtracts $\tfrac29\lvert\kappa_n\rvert$ and the $m$-form does not, so the two differ by $0.02257641$ at $n=12$. Both are below $1$, so the candidate is unaffected either way.

## 4. The direction of the consequence

**The reach is overstated, and the affected statements are lower bounds.**

**Step one, $t$ rises.** $\sqrt{c_p+w^2}>\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$ for every $w>0$ whenever $\rho^{\mathrm{eff}}_n<1$, and $t$ is proportional to it, so $t$ is overstated at $n\in\{12,14,16\}$.

**Step two, $\eta^*$ rises.** Write $q=\sqrt{4t+1}$, so L157's root rationalises to $\eta^*=(q-1)/(q+1)$. Then $\mathrm d\eta^*/\mathrm dq=2/(q+1)^2$ and $\mathrm dq/\mathrm dt=2/q$, giving

$$\frac{\mathrm d\eta^*}{\mathrm dt}=\frac{4}{q\,(q+1)^2}>0\quad\text{for every }t>0,$$

which is the derivative [findings/second-order.md:1443](../findings/second-order.md#L1443) already states. **So a larger $t$ gives a larger $\eta^*$, hence a larger $\sigma$, hence a larger reach $r=\sigma\rho$**, the direction the brief flags.

**Step three, branch 2 itself rises, and this is the step the record supplies the tool for.** Branch 2 is $K(w)\sqrt{c_p+w^2}/(a_0n^{1/2}+nw)$ with $K$ carrying $(1-\eta^*)^2$, which *falls* as $\eta^*$ rises, so the two effects oppose. L158's dispute-settling box at [findings/second-order.md:1315](../findings/second-order.md#L1315) resolves it, and I re-derive the identity here rather than cite it. With $s$ the numerator, $t=\beta s$ and $q=\sqrt{4t+1}$,

$$\log\big(K s\big)=\text{const}+2\log2-2\log(q+1)+\log s,\qquad \frac{\mathrm d\log(q+1)}{\mathrm d\log s}=\frac{2t}{q(q+1)}=\frac{q-1}{2q},$$

using $4t=q^2-1=(q-1)(q+1)$. Hence

$$\frac{\mathrm d\log\big(K(w)\sqrt{c_p+w^2}\big)}{\mathrm d\log s}=1-\frac{q-1}{q}=\frac1{\sqrt{4t+1}}\in(0,1).$$

**The elasticity is strictly positive, so the shrinking $K$ never overturns the growing numerator: overstating $s$ overstates branch 2.** It is strictly below $1$, so the overstatement of branch 2 is strictly damped relative to the overstatement of $s$, which gives an exact two-sided bracket without any numerical integration.

**The failure, exhibited in closed form at $n=12$.** $c_p=3\theta_0/(n-2)=3(1.23603308)/10=0.37080992$.

| $w$ | $\sqrt{c_p+w^2}$ (L157) | $\sqrt{c_p+\rho^{\mathrm{eff}}_{12}w^2}$ (L149 repaired) | inflation of $t$ |
|---|---|---|---|
| $w_0=\tfrac23$, the settled minimiser | $\sqrt{0.81525436}=0.90291437$ | $\sqrt{0.69038487}=0.83089402$ | $\times1.08667$ |
| $0.829$, the value L157 cites | $\sqrt{1.05805092}=1.02861602$ | $\sqrt{0.86496598}=0.93003547$ | $\times1.10600$ |
| $1$, the endpoint | $\sqrt{1.37080992}=1.17072623$ | $\sqrt{1.08985336}=1.04396042$ | $\times1.12143$ |

**The candidate's "about $12\%$ at $n=12$" is the $w=1$ figure, $12.14\%$.** At the minimiser L158's own Gate 2 settled on, $w_0=\tfrac{n-4}n=\tfrac23$, the inflation is $8.67\%$. **The candidate is right in substance and quotes the wrong point of the interval**, an amendment that weakens the numeral and leaves the finding intact.

**The downstream statements affected, and which of them are lower bounds.**

- **[findings/second-order.md:1301](../findings/second-order.md#L1301), L158's settled branch-2 display**, carries the coefficient-$1$ numerator directly. It is the chain's **lower bound on the tube radius** at $n=12$, since L158 concludes branch 2 binds there. **Overstated, and it is a lower bound: this one fails.**
- **[findings/second-order.md:1318](../findings/second-order.md#L1318), the minimum $0.40347$ at $w_0=\tfrac23$ with $\lambda(12)=6.275$**, the numeral for that same lower bound. Since branch 2 is strictly increasing in $s$, the repaired function at $w_0$ is strictly below $0.40347$, and the repaired *minimum over $w$* is below the repaired value at $w_0$, hence strictly below $0.40347$. The pointwise bracket at $w_0$ is $\big(0.40347/1.08667,\ 0.40347\big)=(0.37129,\ 0.40347)$, the lower end being the undamped limit; the true repaired value sits strictly inside, and the minimiser may itself move. **Overstated, and it is a lower bound: this one fails.**
- **[findings/second-order.md:1214](../findings/second-order.md#L1214), L149's chain display**, same defect, in the same direction, on the same lower bound. **Fails.**
- **[findings/second-order.md:1257](../findings/second-order.md#L1257) and [:1260](../findings/second-order.md#L1260), L157's $t$ and its crossing identity**, the definition and the identity are the origin of the defect. The identity $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$ is a lower bound on $\eta^*\gamma$, hence on the reach. **Fails.**
- **[findings/second-order.md:1437](../findings/second-order.md#L1437), $\sigma=\eta^*(t)$ and the reach $r=\sigma\rho$**, inherits the inflated $t$. **Overstated.**
- **[findings/second-order.md:1262](../findings/second-order.md#L1262), $\sup_wt\to\tfrac18$ at $w=1$**, an asymptotic claim, and asymptotically $\rho^{\mathrm{eff}}_n\to\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.74238>1$, so at large $n$ the same substitution runs the **safe** way and this clause understates rather than overstates. Wrong, but not unsound in direction.
- **L149's order conclusion $r_n\gtrsim n^{-1-\beta}$ and its numeral $0.71979/n$**, **unaffected.** The proof of the uniformity is the one place that already carries $\rho$, and $\rho^{\mathrm{eff}}_n$ is a positive constant bounded away from $0$ over $n\ge12$, so the order survives. This is the one downstream item that stands.
- **L158's qualitative conclusion that branch 2 binds at $n=12$**, **strengthened, not broken.** Lowering branch 2 lowers the ratio $\inf\text{br}1/\inf\text{br}2$ further past the threshold. L149's bullet at [findings/second-order.md:1210](../findings/second-order.md#L1210) says exactly this: *"repairing it lowers branch 2 there, which strengthens rather than weakens [L158]'s conclusion that branch 2 binds."*

## 5. Whether the record already knows

**It knows the form is wrong. It does not know that L157 carries it, and it nowhere states L157's coefficient as deliberate.**

Two passages charge the coefficient-$1$ form, and both charge it against **L149**:

- [findings/second-order.md:1210](../findings/second-order.md#L1210), inside L149's own bullet: *"The bound once written here, $c(H)\gtrsim c_p+w^2$, is **a lower bound stated upward** at the dimensions that matter: the coefficient is $0.7416$ at $n=12$ and $0.9463$ at $n=14$, reaching $1$ only from $n=16$ ([r716](../reviews/REVIEW_r716.md); reproduced here at six dimensions). **It is unsafe exactly on $n\in\{12,14\}$**."*
- [findings/second-order.md:1322](../findings/second-order.md#L1322), L158's box: *"**TWO DEFECTS IN [L149] NEITHER PARTY RAISED, FROM [r716].** Its margin bound $c(H)\gtrsim c_p+w^2$ is **a lower bound stated upward**."*

**Neither names L157.** I read L157's entry in full, [findings/second-order.md:1245–1271](../findings/second-order.md#L1245); the strings $\rho^{\mathrm{eff}}$, "margin coefficient" and "convex combination" do not occur in it, and a repository-wide search for $\rho^{\mathrm{eff}}$ and $g_\rho$ returns L149's box and proof and nothing in L157 or L158. **So there is no reconciliation on file, and no statement anywhere that L157's $w^2$ coefficient is an intentional simplification.** The setting to $1$ is inherited silently, and it is inherited from a form the same file marks unsafe forty lines above.

**The aggravating detail.** L158's box at [findings/second-order.md:1301](../findings/second-order.md#L1301) writes the coefficient-$1$ numerator *thirteen lines before* L158's box at [findings/second-order.md:1322](../findings/second-order.md#L1322) charges that exact form as a defect. The record contradicts itself inside one entry.

## The discrepancy protocol, closed

**Located.** [findings/second-order.md:1257](../findings/second-order.md#L1257), quoted verbatim in §1.

**Exhibited concretely, in closed form.** At $n=12$, $w=\tfrac23$: L157's numerator is $\sqrt{0.81525436}=0.90291437$; L149's repaired numerator is $\sqrt{0.69038487}=0.83089402$; ratio $1.08667$. At $w=1$: $1.17072623$ against $1.04396042$; ratio $1.12143$. Both from $c_p=0.37080992$ and $\rho^{\mathrm{eff}}_{12}=2\sqrt{3/2}-1.4\,\theta_0(12)=0.71904344$.

**Argued the opposite, three readings, all failing.**

1. *"$\sqrt{c_p+w^2}$ is schematic, L157's content is the fixed point $\eta^*(t)$, correct for whatever $t$ is."* **Fails.** L157 does not treat it as a placeholder: it evaluates $t$ numerically off that numerator at [findings/second-order.md:1264](../findings/second-order.md#L1264) (*"$t$ from $0.135$ to $0.206$ at the binding direction"*) and at [findings/second-order.md:1262](../findings/second-order.md#L1262) (*"$\sup_wt\to\tfrac18$ at $w=1$"*, and $(1-\eta^*)^2\to0.808$). A schematic numerator produces no numerals.
2. *"The two numerators belong to different branches and are both right."* **Fails.** L158's settled box writes L157's $K$ and L149's denominator around a single numerator, at [findings/second-order.md:1301](../findings/second-order.md#L1301). One branch, one numerator.
3. *"Coefficient $1$ is a legitimate weaker lower bound on the margin."* **Fails.** The convex-combination step gives $c(H)\ge c_p+(c_{\min}-c_p)w^2$ with $c_{\min}-c_p=\rho^{\mathrm{eff}}_n$ exactly; coefficient $1$ would need $c_{\min}-c_p\ge1$, and $\rho^{\mathrm{eff}}_{12}=0.71904<1$ under every one of the three readings of the disputed $\tfrac29$.

A fourth reading (*"L157 predates the repair"*), is a chronology, not a defence: both sit in one file, in the state the record is in today, and L158 propagates the wrong form after the charge was written.

---

**What the record would have to change if the candidate stands, and it does.** Replace the numerator $\sqrt{c_p+w^2}$ with $\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$ at four sites, L157's box at [findings/second-order.md:1257](../findings/second-order.md#L1257) and its crossing identity at [:1260](../findings/second-order.md#L1260), L149's chain display at [:1214](../findings/second-order.md#L1214), and L158's settled branch-2 display at [:1301](../findings/second-order.md#L1301), and re-derive the branch-2 minimum at [:1318](../findings/second-order.md#L1318), whose $0.40347$ is strictly overstated. **A downstream lower bound does fail: the branch-2 infimum is the chain's lower bound on the tube radius at $n=12$, L158 having established that branch 2 binds there, and it is stated upward by a factor strictly between $1$ and $1.08667$ at the settled minimiser $w_0=\tfrac23$.** Two clauses of L149 need amending in the same edit: its scope line *"unsafe exactly on $n\in\{12,14\}$"* should read $n\in\{12,14,16\}$, since $\rho^{\mathrm{eff}}_{16}=0.98564<1$ under the box's own penalised definition and the sign reverses only from $n=18$; and its claim that the $m$-form and the $n$-form *"are the same quantity"* is false by $\tfrac29\lvert\kappa_n\rvert$. **What survives untouched is L149's order statement $r_n\gtrsim n^{-1-\beta}$, whose proof is the one place already carrying $\rho^{\mathrm{eff}}_n$, and L158's verdict that branch 2 binds at $n=12$, which the repair strengthens.**
