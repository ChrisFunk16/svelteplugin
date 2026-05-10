<script lang="ts">
	// Svelte 5 Runes example
	let { initial = 0, step = 1 } = $props();
	let count = $state(initial);
	let doubled = $derived(count * 2);

	$effect(() => {
		console.log(`Count is now: ${count}`);
	});

	function increment() {
		count += step;
	}

	function reset() {
		count = initial;
	}
</script>

<!-- Markup section -->
<div class="counter">
	<h2>Counter Demo</h2>

	{#if count > 10}
		<p class="warning">High count!</p>
	{:else if count < 0}
		<p class="error">Negative!</p>
	{:else}
		<p>Normal range</p>
	{/if}

	<button onclick={increment}>
		Clicks: {count} (doubled: {doubled})
	</button>

	<button onclick={reset} disabled={count === initial}>
		Reset
	</button>

	{#each Array(3) as _, i (i)}
		<span class="dot">•</span>
	{/each}

	{#await fetch('/api/data')}
		<p>Loading...</p>
	{:then response}
		<p>Got: {response.status}</p>
	{:catch error}
		<p>Error: {error.message}</p>
	{/await}
</div>

<style>
	.counter {
		padding: 1rem;
		border: 1px solid #ccc;
		border-radius: 8px;
	}

	.warning {
		color: orange;
		font-weight: bold;
	}

	.error {
		color: red;
	}

	button {
		padding: 0.5rem 1rem;
		cursor: pointer;
	}

	button:disabled {
		opacity: 0.5;
		cursor: not-allowed;
	}
</style>
