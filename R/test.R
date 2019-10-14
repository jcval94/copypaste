#
# rnorm(n=32)
# n=32;mean=0;sd=1
#
# rnorm(n=32.3)
# n=32.3;mean=0;sd=1
#
# rnorm(n=1+1)
# n=1+1;mean=0;sd=1
#
# #error
# rnorm(n=1+1,32.4)
# rnorm(n=1+1,mean = 32.4)
#
# rnorm(n=c(32.4))
# n=c(32.4);mean=0;sd=1
#
# rnorm(n=rbinom(10,2,.1))
#
# rbinom(10,2,.1)
#
# #Bug & error en R
# (T)+(T)
# rnorm((T==T)+(T==T))
# n=T?T+T?T;mean=0;sd=1

