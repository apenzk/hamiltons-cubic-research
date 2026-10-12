# Andersen–Stroppel–Tubbenhauer, semisimplicity of Hecke and (walled) Brauer algebras

**arXiv:1507.07676**, open access. Retrieved 2026-09-02. 38 pp.

**Consulted for** the semisimplicity criterion of $B_f(n)$, which [brauer-pairing.md](../../findings/brauer-pairing.md) uses to identify $M_\lambda$ with the abstract cell module. **Theorem 7.1(3)** gives $n\ge f-1$ in characteristic zero; **7.1(5)** is why the criterion is not an *iff* at $\delta=0$.

**Verdict: this is the primary source, and it is readable.** The folder was previously named for Rui's 2005 JCTA paper, which states the same criterion and is paywalled with no preprint. Nothing in the record ever rested on Rui's own text, see [notes.md](notes.md).

---

*The folder's earlier README follows.*

# Rui, A criterion on the semisimple Brauer algebras

| | |
| --- | --- |
| **Source** | H. Rui, *A criterion on the semisimple Brauer algebras*, [J. Combin. Theory Ser. A **111** (2005) 78–88](https://doi.org/10.1016/j.jcta.2004.11.009) |
| **Identifier** | DOI 10.1016/j.jcta.2004.11.009; ScienceDirect PII S009731650400175X. Sequel: Rui, Si, *A criterion on the semisimple Brauer algebras II*, [JCTA **113** (2006) 1199–1203](https://doi.org/10.1016/j.jcta.2005.09.005), PII S0097316505001858 |
| **Authors** | Hebing Rui (East China Normal University, Shanghai); Mei Si on the sequel |
| **Consulted for** | The semisimplicity threshold for $B_f(\delta)$ at $\delta=n$ a positive integer, used here at $f=12$, where the criterion reads $n\ge11$ |
| **Retrieved** | Not obtained, 2026-09-02, see below |

## Verdict

The criterion the programme uses is on file in [notes.md](notes.md), taken from the open-access primary source that r259 found, Andersen, Stroppel, Tubbenhauer, [*Semisimplicity of Hecke and (walled) Brauer algebras*](https://arxiv.org/abs/1507.07676), Theorem 7.1(3), which states $n\ge f-1$ verbatim, together with an independent reproduction via Dickson's criterion at all $32$ pairs with $f\le5$, $n\ge1$. The record does not depend on Rui's own text.

What the criterion buys is also less than this folder's note first claimed: the diagram-realisation theorem needs $M_\lambda$ irreducible over the **image** $\nu(B_{12}(n))$, which the double centraliser gives at every $n$ with no inequality. Rui's criterion only identifies $M_\lambda$ with the abstract cell module $\Delta_\lambda$, which the theorem does not use.

## Not obtained

**Both Rui 2005 and the Rui–Si 2006 sequel are blocked behind Elsevier.** What was tried on 2026-09-02:

- **arXiv.** No preprint exists. The arXiv API returns ten Rui papers on Brauer-type algebras (affine walled, cyclotomic, quantized walled, $q$-Brauer, *Discriminants of Brauer algebras*) and none is either JCTA criterion paper. A title search on `ti:"semisimple Brauer algebras"` returns zero hits.
- **DOI resolution.** `https://doi.org/10.1016/j.jcta.2004.11.009` redirects to `linkinghub.elsevier.com/retrieve/pii/S009731650400175X` and returns a 2.6 KB interstitial, not the article.
- **ScienceDirect PDF endpoints.** `…/pii/S009731650400175X/pdfft?isDTMRedir=true&download=true` and `…/pii/S0097316505001858/pdf` both return **HTTP 403** with a 1.2 MB HTML block page.
- **Headless Chrome render**, both with the default and with a normal desktop user agent: the landing page comes back as the ScienceDirect shell in one case and as a Cloudflare `Just a moment...` challenge in the other. No PDF link is reachable in the rendered DOM.
- **Open-access indexes.** Unpaywall reports `oa_status: closed`, `has_repository_copy: false`, and an empty `oa_locations` list for the 2005 paper. OpenAlex agrees (`is_oa: false`, `oa_url: null`). Semantic Scholar marks it `BRONZE` with the DOI itself as the "open access PDF", which the 403 above contradicts. Unpaywall does list the 2006 sequel as bronze with a publisher PDF URL, but that URL is one of the 403s.
- **Europe PMC**: zero hits, as expected for a combinatorics title.

No institutional access is available in this environment. **A copy is not substituted**: the folder holds no PDF rather than a different paper's PDF. If access is ever obtained, the two things worth checking against the original are the exact characteristic hypothesis ($\operatorname{char}k=0$ or $\operatorname{char}k>f$) and Rui's own treatment of the $\delta=0$ and $\delta<0$ cases, both of which [notes.md](notes.md) currently takes from Andersen–Stroppel–Tubbenhauer.
