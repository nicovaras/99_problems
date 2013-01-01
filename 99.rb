
$contador = 1
def assert(a,b)
  print "#{$contador}: "
  if a != b
    print "#{a} != #{b}\n"
  else
    print "OK\n"
  end	
  $contador += 1
end

lista = [1,2,3,4,5]
lista_anidada = [[1],[2,3],[4,5],[]]
palin = [1,2,3,3,2,1]
rep = [1,1,1,2,2,3,3,3,3,4,5,5,1]

#1
assert(lista[-1],5)

#2
assert(lista[-2..-1],[4,5])

#3
k = 3
assert(lista[k],4)

#4
assert(lista.size,5)

#5
assert(lista.reverse,[5,4,3,2,1])

#6
palin = [1,2,3,3,2,1]
assert(palin == palin.reverse,true)

#7
assert(lista_anidada.flatten,lista)

#8
def no_rep(arr)
  arr.select.with_index{|x,i| x != arr[i+1]}
end
assert(no_rep(rep),[1,2,3,4,5,1])

#9
def pack(arr)
  arr.inject([[]]){ |res, val|
	res << [] if res[-1] != [] and not res[-1].include? val
	res[-1] << val
	res
  }
end
unpacked = %w{a a a a b c c a a d e e e e}
assert( pack(unpacked), [%w{a a a a},%w{b},%w{c c},%w{a a},%w{d},%w{e e e e}] )

#10
def encode(arr)
  pack(arr).map{|sub_arr| [sub_arr.size, sub_arr[0]]}
end
assert(encode(unpacked), [[4, 'a'],[1, 'b'],[2, 'c'],[2, 'a'],[1, 'd'],[4, 'e']])

#11
def encode2(arr)
  encode(arr).map{|x| x[0]==1? x[1] : x}
end
assert(encode2(unpacked), [[4, 'a'],'b',[2, 'c'],[2, 'a'],'d',[4, 'e']])

#12
def decode(arr)
  arr.inject([]) {|res, x| 
	if x.is_a?(String)
	  res << x
	else
	  x[0].times{ res << x[1]}
	end
	res
  }
end
assert(decode([[4, 'a'],'b',[2, 'c'],[2, 'a'],'d',[4, 'e']]),unpacked) 

#13
def encode_direct(arr)
  arr.inject([]){ |res,x|
	if res == [] or res[-1][1] != x
		res << [1,x] 
	else
		res[-1][0] += 1
	end
	res
  }.map{|x| x[0]==1? x[1]: x}
end

assert(encode_direct(unpacked), [[4, 'a'],'b',[2, 'c'],[2, 'a'],'d',[4, 'e']])

#14
def dupli(arr)
	arr.inject([]){ |res,x|
		res << x
		res << x
		res
	}
end
assert(dupli(%w{a b c c d}), %w{a a b b c c c c d d})

#15
def repli(arr,t)
	arr.inject([]){ |res,x|
		t.times{
			res << x
		}
		res
	}
end
assert(repli(%w{a b c},3), %w{a a a b b b c c c})

#16
def drop(arr,i)
  arr.select.with_index{|x,j| (j+1)%i != 0}
end
assert(drop(%w{a b c d e f g h i k},3), %w{a b d e g h k})

#17
def split(arr,t)
  [arr.take_while.with_index{|x,i| i<t}, arr.drop_while.with_index{|x,i| i<t}]
end
assert(split(%w{a b c d e f g h i k},3), [%w{a b c}, %w{d e f g h i k}])
 
#18
assert(%w{a b c d e f g h i k}[2..5], %w{c d e f})

#19
assert(  %w{a b c d e f g h}.rotate(-2),%w{g h a b c d e f})

#20
deleted = %w{a b c d}
deleted.delete_at(2)
assert( deleted ,%w{a b d})

#21
assert( %w{a b c d}.insert(1,'alfa'), %w{a alfa b c d})

#22
assert((4..7).to_a,[4,5,6,7])

#23
%w{a b c d e f}.sample(3)
assert(1,1)

#24
(0..49).to_a.sample(6)
assert(1,1)

#25
%w{a b c d e f}.shuffle
assert(1,1)

#26
assert([1,2,3,4].combination(2).to_a,[[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]])

#27
assert("No","implementado")

#28
def ord1(arr)
  arr.sort {|x,y| 
    if x.size == y.size
	  x <=> y
	else
      x.size <=> y.size 
	end
  }
end
def freq(x,arr)
  arr.select{|y| x.size == y.size }.size
end
def ord2(arr)
  arr.sort {|x,y| 
    if freq(x,arr) == freq(y,arr)
	  x <=> y
	else
      freq(x,arr)<=> freq(y,arr)
	end
  }
end

unord = [%w{a b c}, %w{d e}, %w{f g h}, %w{d e}, %w{i j k l}, %w{m n}, %w{o}]
ordenado1 = [%w{o}, %w{d e}, %w{d e}, %w{m n}, %w{a b c}, %w{f g h},  %w{i j k l} ]
ordenado2 = [%w{i j k l}, %w{o}, %w{a b c}, %w{f g h}, %w{d e}, %w{d e}, %w{m n} ]
assert( ord1(unord) + ord2(unord),  ordenado1 + ordenado2 )


#31
$contador = 31
def is_prime?(n)
  (2..Math.sqrt(n)).select{|x| n % x == 0}.size == 0 and n != 1
end
assert((is_prime?(7) and not is_prime?(51)), true)
								   
#32
def gcd(a,b)
 b == 0 ? a : gcd(b, a% b)
end
assert(gcd(36,63),9)

#33
def coprime?(a,b)
  gcd(a,b) == 1
end
assert(coprime?(35,64), true)

#34
def phi(a)
  (1..a).select{|x| coprime?(x,a)}.size
end
assert(phi(10),4)

#35 FEO
def prime_factors(x)
  res = []
  while x > 1
	  (2..x+1).each{ |y|
		if is_prime?(y) and x % y == 0
		  res << y
		  x /= y
		  break
		end
	  }
   end
   res
end
assert(prime_factors(315), [3,3,5,7])

#36
def prime_factors_2(a)
  encode(prime_factors(a)).map {|x,y| [y,x]}
end
assert(prime_factors_2(315), [[3,2], [5,1], [7,1]])

#37
def phi2(a)
  prime_factors_2(a).inject(0){|res,x| res + (x[0]-1) * x[0] ** (x[1]-1)}
end
assert(phi2(11),10)

#38 nada para hacer
assert(true,true)

#39
def prime_range(a,b)
  (a..b).select{|x| is_prime?(x)}
end
assert(prime_range(1,30), [2, 3, 5, 7, 11, 13, 17, 19, 23, 29] )

#40
def goldbach(a)
  prime_range(1,a).each{|x|
    prime_range(x,a).each{|y|
	  return [x,y] if a == x + y
	}
  }
end
assert(goldbach(28), [5,23])

#41
def goldbach_list(a,b,limit = 0)
  (a..b).inject([]){|res,x|
    res << goldbach(x) if x % 2 == 0 and goldbach(x)[0] > limit
	res
  }
end
assert(goldbach_list(9,20), [[3,7],[5,7],[3,11],[3,13],[5,13],[3,17]])

#41_bis tarda mucho
#assert(goldbach_list(1,2000,50), [[73,919], [61,1321], [67,1789], [61,1867]])

#46 47 48: los salteo

#49
$contador = 49
def gray_code(n)
  return ['0','1'] if n == 1
  previous = gray_code(n-1)
  previous.map{|x| '0'+x} + previous.reverse.map{|x| '1'+x}
end
assert(gray_code(3),  ['000','001','011','010','110','111','101','100'] ) 

#50
assert("No","implementado")

$contador=54
#54 
#Arboles binarios estilo funcional
tree1 = nil
tree2 = ['x', nil , nil]
tree3 = ['x', ['y',nil,['z',nil,nil]], ['l', nil, ['k', nil, ['o',nil,nil]]] ]
no_tree1 = ['x','y',nil]
no_tree2 = ['a',['b',nil,nil]]

def is_tree?(t)
  t == nil or (t.size == 3 and is_tree?(t[1]) and is_tree?(t[2]))
end

assert((is_tree?(tree1) and
		is_tree?(tree2) and
		is_tree?(tree3) and
		!is_tree?(no_tree1) and
		!is_tree?(no_tree2)), true)
		

class Binary_tree
 attr_accessor :l,:r
 
 def initialize(x,l,r)
   @x = x
   @l = l
   @r = r
 end
 def size
   1 + (@l ? @l.size : 0) + (@r ? @r.size : 0) 
 end

 def leaves
   if not @l and not @r 
     return 1
   else
	 return (@l ? @l.leaves : 0) + (@r ? @r.leaves : 0) 
	end
 end
 
 def add(x)
   if x < @x
     if @l
	   @l.add(x)
	 else
       @l = Binary_tree.new(x,nil,nil)
	 end
   else
     if @r
	   @r.add(x)
	 else
       @r = Binary_tree.new(x,nil,nil)
	 end
   end
 end 
 
end

tree_1 = Binary_tree.new('x',Binary_tree.new('y',nil,Binary_tree.new('z',nil,nil)),nil)
assert(tree_1.size,3)

#55
$contador = 55
assert('No','implementado')

#56
tree_2 = Binary_tree.new('x',Binary_tree.new('y',nil,Binary_tree.new('z',nil,nil)),Binary_tree.new('y',Binary_tree.new('z',nil,nil),nil))
def mirror?(a,b)
  if not a and not b
    return true
  elsif (not a or not b) or (not a.l and b.r) or (a.r and not b.l)
    return false
  else
    return (mirror?(a.l,b.r) and mirror?(a.r,b.l))
  end
   
end
def symmetric?(a)
  mirror?(a.l,a.r)
end
assert((!symmetric?(tree_1) and symmetric?(tree_2)), true)

#57
def construct(list)
  h, *t =list
  res = Binary_tree.new(h,nil,nil)
  t.each{|t1| res.add(t1)}
  res
end

assert((symmetric?(construct [5,3,18,1,4,12,21]) and symmetric?(construct [3,2,5,7,1])),true)

#58 salteado
assert(true,true)

#59 salteado
assert('No','implementado')

#60 salteado
assert(true,true)

#61
assert(tree_2.leaves,2)