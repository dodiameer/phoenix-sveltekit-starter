import { writable } from "svelte/store"

export const initialUserState = { isLoggedIn: false, data: null } 
export const user = writable(initialUserState)
