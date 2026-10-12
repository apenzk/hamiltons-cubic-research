import pickle, os, time, random, sympy
RUNS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
nums=set()
for cs in RAW.values():
    for c in cs:
        for v in c:
            for (a,b) in v.values():
                for f in (a,b):
                    if f.numerator: nums.add(abs(f.numerator))
nums=sorted(nums)
random.seed(202); S=random.sample(nums, 400)
t=time.time()
big=0
for n in S:
    fs=sympy.factorint(n)
    if max(fs) > 100000: big+=1
print(f"400 factorint in {time.time()-t:.1f}s; {big} have a factor >1e5")
