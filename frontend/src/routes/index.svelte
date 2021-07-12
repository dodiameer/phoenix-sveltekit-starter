<script lang='ts'>
  import {user} from "$lib/stores/user.store"
</script>
<template>
  <pre>
    {JSON.stringify($user, null, 2)}
  </pre>
</template>