"""r233 claim 3: does the theta=+theta_0 guard fire on the errors it should, and
what class of error walks straight past it?  Each plant is a one-token edit of a
COPY of run_bispectral_catalogue.py; the file under review is never touched."""
import subprocess, sys, os, re, tempfile, shutil
SRC = "scripts/runs/run_bispectral_catalogue.py"
src = open(SRC).read()

PLANTS = {
  "control (unmodified)": lambda s: s,
  "P1 old constructor  b=-1.0 -> b=+1.0": lambda s: s.replace("n=p+q; Lam=np.zeros((n,n)); b=-1.0","n=p+q; Lam=np.zeros((n,n)); b=+1.0"),
  "P2 a1/a2 swapped (identical when p==q)": lambda s: s.replace("a1=-q*b/(p-1); a2=-p*b/(q-1)","a1=-p*b/(q-1); a2=-q*b/(p-1)"),
  "P3 cpm sign flipped (W -> -W for CP^m only)": lambda s: s.replace("    if n and n>d:\n        Wp=np.zeros((n,n,n,n)); Wp[:d,:d,:d,:d]=W; W=Wp\n    return W","    W=-W\n    if n and n>d:\n        Wp=np.zeros((n,n,n,n)); Wp[:d,:d,:d,:d]=W; W=Wp\n    return W"),
  "P4 ring index order iklj -> ikjl (negates omega)": lambda s: s.replace("np.einsum('iklj,kl->ij',W,h)","np.einsum('ikjl,kl->ij',W,h)"),
  "P5 isospectral family Lam -> -Lam": lambda s: s.replace("Lam[i,j]=Lam[j,i]=s","Lam[i,j]=Lam[j,i]=-s"),
}

os.makedirs("/tmp/r233plant", exist_ok=True)
for name, f in PLANTS.items():
    txt = f(src)
    changed = (txt != src)
    path = "scripts/runs/_r233_plant.py"        # same dir: it does sys.path.insert(0, 'scripts/lib')
    open(path,"w").write(txt)
    try:
        r = subprocess.run([sys.executable, path], capture_output=True, text=True, timeout=900)
    finally:
        os.remove(path)
    fired = "AssertionError" in r.stderr
    out = r.stdout
    def grab(lbl):
        m = re.search(rf"^{re.escape(lbl)}\s+n=\s*\d+ theta=([-+][\d.]+).*?sum=([-+][\d.]+)", out, re.M)
        return (m.group(1), m.group(2)) if m else ("?","?")
    s66 = grab("S^6xS^6"); s57 = grab("S^5xS^7"); cp2 = grab("CP^2")
    fam = re.findall(r"P=\s*([-+][\d.]+)", out)
    print(f"{name}")
    print(f"    edit applied: {changed}   GUARD FIRED: {fired}")
    print(f"    S^6xS^6 theta={s66[0]} sum={s66[1]} | S^5xS^7 theta={s57[0]} sum={s57[1]} | CP^2 theta={cp2[0]} sum={cp2[1]} | family P={sorted(set(fam))}")
    if fired:
        print("    message: " + r.stderr.strip().splitlines()[-1][:150])
    print()
