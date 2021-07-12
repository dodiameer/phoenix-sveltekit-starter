<script context="module" lang='ts'>
import { authGuard } from '$lib/guards';

import type { Load } from '@sveltejs/kit';

  export const load: Load = async(input) => {
    return await authGuard(input)
  }
</script>
<script>
	import '../app.postcss';
</script>

<slot />
