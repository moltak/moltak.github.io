---
layout  : post
title   : clojure 기본 문법
summary : clojure 시작하기를 읽으며 만든 나를 위한 cheatsheet
date    : 2022-11-15 22:03:35 +0900
updated : 2024-08-10 18:16:28 +0900
tag     : clojure leiningen
toc     : true
public  : true
parent  : 
latex   : false
---
* TOC
{:toc}

#라이닝언( #Leiningen )
- 클로저 프로젝트 생성기

#REPL (read, eval, print, loop)

첫 코드 실행
```clojure
(+ 1 1)
;=> 2
```

# rational number
```clojure
(type 1/3) 
;=> clojure.lang.Ratio
```

# keyword (키워드)
- 콜론(:)으로 시작하는 식별자. 특별한 속성을 갖고 있고 매우 유용하게 사용됨. (나중에 설명해준다는데?)
- 키워드 역시 단순값. 
- 만약 맵의 키가 키워드라면 키를 함수로 사용할 수 있음.

```clojure
(:jam1 {:jam1 "a" :jam2 "b")`
;=> "a"

(str :jam1)`
;=> "jam1"
```
# Collection(컬렉션)
- list, vector, map, set 가 있음

## list
```clojure
'(1 2 "jam" :marmalade-jar)
```

### list function
```clojure
(first '(1 2 3 4)) ;=> 1
(rest '(1 2 3 4)) ;=> 2 3 4 
(last '(1 2 3 4)) ;=> 4
(cons 5 '(1 2)) ;=> 5 1 2
(cons 3 (cons 4 (cons 5 nil))) ;=> 3 4 5
(conj '(1 2 3) 4 5) => 5 4 1 2 3
```

## vector
```clojure
[1 2 3 4] ;=> [1 2 3 4]
```

### vector function
```clojure
(nth [1 2 3 4] 0)
(conj [1 2] 3 4)
```

## map
```clojure
{:key1 "val1" :key2 "val2"}
;=> {:key1 "val1" :key2 "val2"} ; 맵 정의

(get {:key1 "val1" :key2 "val2"} :key1)
;=> val1

(:key1 {:key1 "val1" :key2 "val2"})
;=> val1 ; 키워드가 키일 경우 함수로 사용 가능.
```

### map function
```clojure
(keys {:key1 "val1" :key2 "val2"})
;=> ("key1" "key2")

(vals {:key1 "val1" :key2 "val2"})
;=> ("val1" "val2
```
assoc - 맵에 새로운 키-값 쌍 연결
dissoc - 맵에서 키를 제거
merge - 여러 맵의 키-값 쌍을 합침

## set
```clojure
#{1 2 3 4} ; 이렇게 하거나

(set [1 2 2 3]) ;=> [1 3 2] ;<- 이렇게 하거나
```

집합을 함수로 사용하기
```clojure
(#{1 3 2} 2)
;=> 2 
```

### set function
union - 합치기
difference - 빼기
intersection - 공통 요소
contains? - 요소가 있는지 확인 - 다른 컬렉션에선?
conj - 요소 추가

# Sequence
- 논리적 list
- list, vector, set, map은 ISeq interface를 구현함

# 심볼과 바인딩
클로저 심볼은 값을 가르킴. 심볼이 평가되면 그 심볼이 가리키는 값을 반환.

문자열 "Alice"에 이름 주기
```clojure
(def developer "Alice")
;=> #'user/developer'

developer
;=> "Alice"

(let [developer "Alice in Wonderland"] developer)
;=> 'Alice in Wonderland' ; 벡터에 이름 값 쌍으로 표현

(let [a "a" b "b"] [a b]) 
;=> ["a" "b"] ; 여러개 정의 가능
```
let 바인딩은 벡터 안에 심볼과 값의 쌍들로 구성됨.
- 전역 var를 만들기 위해 def를 사용한다.
- 지역 바인딩을 만들기 위해 let을 사용한다.

# 함수
## 1. 이름 있는 함수
```clojure
; 인자 없음
(defn test-func [] "off we go!")
;=> 'cljs.user/test-func

(test-func)
;=> "off we go!"

; 인자 여러개
(defn test-func2 [jam1 jam2]
	{
		:name "jam-basket"
		:jam1 jam1
		:jam2 jam2
	}
)
;=> 'cljs.user/test-func2

(test-func2 "a" "b")
;=>{:name "name", :jam2 "b", :jam1 "a"}
```

## 2. anonymous 함수
```clojure
(fn [] (str "off we go!"))
;=> 함수 오브젝트 반환

((fn [] (str "off we go!")))
;=> "off we go!" ; 함수 호출

(#(str "off we go!"))
;=> "off we go!" ; 위 함수와 같음. 축약된 형태

(#(str "first: " %1 " second: " %2) "a" "b")
;=> "first: a second: b" ; 인자를 받을 수 있음.

(#(str "first: " %) "a")
;=> "first: a" ; 인자가 하나일 때, 숫자 제외 가능
```

## 3. 진위함수: 논리 검사의 결과값을 반환하는 함수
```clojure
(defn drinkable? [x] (= x :drinkme))
;=> cljs.user/drinkable?

(every? drinkable? [:drinkme :drinkme])
;=> true
```

## 4. partial
- partial은 클로저에서 currying 하는 방법.
- 커링이란 인수를 부분적으로 적용해서 새로운 함수를 만드는 방법.
 
```clojure
(defn grow [name direction]
	(if (= direction :small)
		(str name " is growing smaller")
		(str name " is growing bigger")))

(grow "Alice" :small)
;=> "Alice is growing smaller"

((partial grow "Alice") :small)
;=> "Alice is growing smaller" ; 사용예를 보면 default parameter 설정해준 느낌인데
```

## 5. comp
- 여러 함수들을 합성해서 하나의 새로운 함수로 만듬.
- 인수로 받은 함수들을 오른쪽에서 왼쪽으로 실행
 
```clojure
(defn toggle-grow [direction]
	(if (= direction :small) :big :small))

(toggle-grow :big)
(toggle-grow :small)

(defn oh-my [direction] 
	(str "Oh my! You are growing " direction))

(defn surprise [direction] 
  ((comp oh-my toggle-grow) direction))

(surprise :small)
```

# if
```clojure
(if true "it is true" "it is false")
;=> "it is true"

(if false "it is true" "it is false")
;=> "it is false"
```

## if-let
- 검사는 하고 싶지만 그 결과를 나중에 사용하고 싶을 때
- 식을 평가한 결과를 심볼에 바인딩한 후 만약 그 결과가 논리적 참이면 첫 번째 인수를 평가, 아니면 마지막 인수를 평가
 
```clojure
(let [A (> 5 3)] (if A "A" "B"))
;=> "A"

(if-let [A (> 5 3)] "A" "B")
;=> "A"
```

# when
- 참이면 본문을 평가. 참이 아니면 nil을 반환
- 어떤 키나, 플래그가 존재할 때만 식을 평가하려고 할 때 유용함.
```clojure
(defn drink [arg1]
	(when arg1 "eval!"))

(drink true)
;=> "eval!"

(drink false)
;=> nil
```

## when-let
- 논리 검사 결과를 심볼에 바인딩하고, 그 결과가 참이면 본문의 식을 평가, 아니면 nil을 반환
 
```clojure
(when-let [arg1 true] "eval!")
;=> eval!

(when-let [arg1 false] "eval!")
;=> nil
```

# cond
- 조건식을 여러개 쓰고 싶을 때, if/else if 와 비슷
 
```clojure
(let [bottle "A"]
	(cond
		(= bottle "A") "A"
		(= bottle "B") "B"
		(= bottle "C") "C"))
;=> "A"

let [bottle "F"]
    (cond
        (= bottle "A") "A"
        (= bottle "B") "B"
        (= bottle "C") "C"
        :else "Z"))
;=> "Z" ; 디폴트값 넣기 ; :else 가 꼭 필요한 키워드는 아님. 참으로 평가되기 때문에 넣었음.
```

# case
- cond의 단축형으로 검사할 심볼이 같고 = 으로 검사 가능하면 사용
 
```clojure
(let [bottle "A"]
	(case bottle
		"A" "A"
		"B" "B"
		"C" "C"))
;=> "A"

(let [bottle "Z"]
    (case bottle
        "A" "A"
        "B" "B"
        "C" "C"))
;=> ERROR - No matching clause: Z 
; cond는 일치되는 값이 없으면 nil을 반환한다. 하지만 case는 exception을 발생시킴

(let [bottle "Z"]
    (case bottle
        "A" "A"
        "B" "B"
        "C" "C"
        "default"))
;=> "defalut" ; 기본값을 제공하려면 마지막에 식을 하나 주면됨
```

# for
- 처리하고자 하는 컬렉션의 요소를 심볼레 바인딩
 
```clojure
(for [animal [:mouse :duck :lory]]
	(str animal))
;=> (":mouse" ":duck" ":lory")

(for [animal [:mouse :duck :lory] 
	  color [:red :blue]]
	(str color animal))
;=> (":red:mouse" ":blue:mouse" ":red:duck" ":blue:duck" ":red:lory" ":blue:lory")


(for [animal [:mouse :duck :lory] 
	  color [:red :blue]
	  :let [animal-str (str "animal-"(name animal))
			color-str (str "color-"(name color))
			display-str (str animal-str "-" color-str)]]
	display-str)
;=> ("animal-mouse-color-red" "animal-mouse-color-blue" "animal-duck-color-red" "animal-duck-color-blue" "animal-lory-color-red" "animal-lory-color-blue")
```

# loop, recur
- recur를 이용해 자신을 다시 호출할 수 있음
- loop 키워드가 있을 때, loop 부터 시작
 
```clojure
(def adjs ["normal" "too small" "too big" "is swimming"])

(defn alice-is [in out]
    (if (empty? in) ;
      out ;
      (alice-is ;
        (rest in) ;
        (conj out ;
          (str "Alice is " (first in))))))

(defn alice-is2 [input]
  (loop [in input out []]
    (if (empty? in)
      out
      (recur (rest in) ;
             (conj out (str "Alice is " (first in)))))))

(alice-is2 adjs)
```

# lazy
- range 같은 함수는 무한대의 지연 시퀀스를 반환함.
- `(range 5)` 와 같이 끝을 지정하지 않으면 무한이 반환됨.
- 지연 시퀀스를 안전하게 처리하기 위해 take 함수를 함께 사용. 그러면 take가 요구하는 개수 만큼만 평가한다.
 
```clojure
(count (take 10 (range)))
```

# destructuring
- vector, map 같은 컬렉션에서 가능
- 특정 요소들에 이름을 붙일 수 있다.
- 가장 마지막 예제는 함수에 맵을 넣어 destructuring 하는 것이다.
 
```clojure
(let [[color size] ["blue" "small"]]
	(str "The " color " door is " size))
;=>  "The blue door is small"

(let [[color [size]] ["blue" ["very small"]]]
  (str "The " color " door is " size))
;=> "The blue door is very small"

(let [{flower1 :flower1 flower2 :flower2 :or {flower2 "missing"}} {:flower1 "red"}]
  (str "The flowers are " flower1 " and " flower2))
;=> "The flowers are red and missing"

(defn flower-colors [colors]
  (str "The flowers are "
       (:flower1 colors)
       " and "
       (:flower2 colors)))

(flower-colors {:flower1 "red" :flower2 "blue"})
;=> "The flowers are red and blue"

(for [[a b :as all] param])
```


# threading macro
TODO: ->, ->>, as->

# 지연 
- cycle, repeat, repeatly, range는 무한의 리스트를 반환
- 지연 시퀀스를 사용함.
- 무한을 반환하기 때문에 조심히 사용해야한다.
- take는 필요한 만큼만 평가하기 때문에 함께 사용하면 됨.

# reduce
```clojure
(reduce (fn [r x] (+ r x)) [1 2 3])
```
