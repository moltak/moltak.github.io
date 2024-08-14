---
layout: post
title: svelte
summary: svelte 해보기
date: 2023-01-20 21:26:15 +0900
updated: 2024-08-14 22:07:16 +0900
tag: svelte
toc: true
public: true
parent:
latex: false
---

* TOC
{:toc}


# Svelte 해보기

## 기본 문법

### Nested components

```svelte
<script>
  // svelte 컴포넌트를 임포트 하기
	import Nested from './Nested.svelte';
</script>

<p>This is a paragraph.</p>
<Nested/>

<style>
	p {
		color: purple;
		font-family: 'Comic Sans MS', cursive;
		font-size: 2em;
	}
</style>
```

### 변수 변경

react에선 state를 써야하지만 svelte에선 값을 바로 변환하면 됨

```svelte
<script>
	let count = 0;

	function incrementCount() {
		count += 1;
	}
</script>

<button on:click={incrementCount}>
	Clicked {count} {count === 1 ? 'time' : 'times'}
</button>
```

### Reactivity

아래와 같은 Reactivity 문법을 통해 변수가 변하는 것을 감지하고 다른 반응을 할 수 있음.

```svelte
$: doubled = count * 2;

$: {
	console.log('the count is ' + count);
	alert('I SAID THE COUNT IS ' + count);
}
```

svelte의 Reactivity는 assignment를 통해서만 반응함. 변수에 값을 `=`연산자로 재지정해야함.

```svelte
function addNumber() {
	numbers.push(numbers.length + 1);
	numbers = numbers;
}

numbers = [...numbers, numbers.length + 1];
```

### Props

변수 export

```svelte
export let answer

<Nested answer={42} />
```

### Logic

```svelte
{#if x > 10}
	<p>{x} is greater than 10</p>
{:else if 5 > x}
	<p>{x} is less than 5</p>
{:else}
	<p>{x} is between 5 and 10</p>
{/if}
```

### foreach

```svelte
<ul>
	{#each cats as { id, name }, i}
		<li><a target="_blank" href="https://www.youtube.com/watch?v={id}" rel="noreferrer">
			{i + 1}: {name}
		</a></li>
	{/each}
</ul>
```

### id

어떤 노드를 선택할지 정확히 알고 싶다면 아래와 같이 (thing.id)를 사용해야한다.
https://svelte.dev/tutorial/keyed-each-blocks

```svelte
{#each things as thing (thing.id)}
	<Thing name={thing.name}/>
{/each}
```

### 비동기

await promise를 사용해 비동기 처리를 할 수 있다.

```svelte
<script>
	async function getRandomNumber() {
		const res = await fetch(`/tutorial/random-number`);
		const text = await res.text();

		if (res.ok) {
			return text;
		} else {
			throw new Error(text);
		}
	}

	let promise = getRandomNumber();

	function handleClick() {
		promise = getRandomNumber();
	}
</script>

<button on:click={handleClick}>
	generate random number
</button>

{#await promise}
	<p>...waiting</p>
{:then number}
	<p>The number is {number}</p>
{:catch error}
	<p style="color: red">{error.message}</p>
{/await}

```
