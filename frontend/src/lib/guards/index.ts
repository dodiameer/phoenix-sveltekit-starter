import { api } from '$lib/api';
import { get } from "svelte/store"
import { user } from '$lib/stores/user.store'; // stores related to app state, auth state
import type { LoadInput, LoadOutput } from '@sveltejs/kit';

export async function authGuard({ page, fetch }: LoadInput): Promise<LoadOutput> {
	let auth = get(user)
  if (!auth.isLoggedIn) {
		let [json, res] = await api('auth/refresh', { fetch });
		if (!res) {
      const { data } = json
			user.set({ isLoggedIn: true, data: { account: data.account, token: data.token } });
      auth = get(user)
		}
	}
	const loggedIn = auth.isLoggedIn;

	if (loggedIn && page.path === '/login') {
		return { status: 302, redirect: '/' };
	} else if (loggedIn || page.path === '/login') {
		return {};
	} else {
		return { status: 302, redirect: '/login' };
	}
}
