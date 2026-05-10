<script>
	let todos = $state([
		{ id: 1, text: 'Lerne Svelte', done: false },
		{ id: 2, text: 'Notepad++ Plugin bauen', done: true }
	]);
	let newTodo = $state('');

	let remaining = $derived(todos.filter(t => !t.done).length);

	function addTodo() {
		if (!newTodo.trim()) return;
		todos.push({ id: Date.now(), text: newTodo, done: false });
		newTodo = '';
	}

	function toggle(id) {
		const todo = todos.find(t => t.id === id);
		if (todo) todo.done = !todo.done;
	}
</script>

<h1>Todos ({remaining} offen)</h1>

<form onsubmit={(e) => { e.preventDefault(); addTodo(); }}>
	<input bind:value={newTodo} placeholder="Neues Todo..." />
	<button type="submit">+</button>
</form>

<ul>
	{#each todos as todo (todo.id)}
		<li class:done={todo.done}>
			<input type="checkbox" checked={todo.done} onchange={() => toggle(todo.id)} />
			{todo.text}
		</li>
	{/each}
</ul>

<style>
	.done {
		text-decoration: line-through;
		opacity: 0.6;
	}
	ul { list-style: none; padding: 0; }
	li { padding: 0.5rem; }
</style>
