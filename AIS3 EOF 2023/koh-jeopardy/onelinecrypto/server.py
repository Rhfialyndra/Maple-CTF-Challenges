(nu:=__import__('Crypto.Util.number').Util.number,e:=65537,n:=(p:=nu.getPrime(512))*(q:=nu.getPrime(512)),d:=pow(e,-1,(p-1)*(q-1)),r:=7,k:=32,m:=nu.getRandomRange(0,r**k),print(f'{n = }'),c:=pow(m,e,n),print(f'{c = }'),[print(pow(int(input('c = ')),d,n)%r) for _ in range(k)],print(__import__('os').environ['FLAG']) if int(input('m = '))==m else None)