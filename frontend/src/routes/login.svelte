<script lang="ts">
  import { goto } from '$app/navigation';
	import { api } from '$lib/api';
	import { user } from '$lib/stores/user.store';

	let email,
		password,
		error = '';
	const onSubmit = async () => {
		const [json, res] = await api('auth/login', {
			method: 'POST',
			body: { email, password }
		});
		if (res) {
			password = '';
			error = 'Incorrect username or password';
			return;
		}
    const { data } = json
		$user = {
			isLoggedIn: true,
			data: {
				account: data.account,
				token: data.token
			}
		};
    await goto("/")
	};
</script>

<template>
	<p>{error}</p>
	<form on:submit|preventDefault={onSubmit}>
		<input type="email" bind:value={email} name="email" id="email" />
		<input type="password" name="password" bind:value={password} id="password" />
		<button type="submit">Login</button>
	</form>
</template>
