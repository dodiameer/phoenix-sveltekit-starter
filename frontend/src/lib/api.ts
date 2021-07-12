type Options = Partial<{
  fetch: typeof fetch,
  method: "GET" | "POST" | "PUT" | "DELETE",
  token: string,
  body: any
}>

type Errorable = [any, null] | [null, Response]

export const api = async (endpoint: string, options: Options = {}): Promise<Errorable> => {
  const {fetch = window.fetch, body, token = "", method = "GET"} = options

  endpoint = endpoint.startsWith("/") ? endpoint.slice(1) : endpoint

  const headers = Object.entries({
    "Content-Type": "application/json",
    ...(token ? {"Authorization": `Bearer ${token}`} : {})
  })

  const res = await fetch(`http://localhost:4000/${endpoint}`, {
    method,
    headers,
    body: JSON.stringify(body),
    credentials: "include",
  })

  if (res.ok) {
    return [await res.json(), null]
  } else {
    return [null, res]
  }
}