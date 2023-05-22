<script lang="ts">
  import todoService from "../services/todo.service";

  enum ButtonAction {
    ADD = "Add",
    SAVE = "Save",
  }

  export let previewMode = false;

  let todos = todoService.fetch();
  let buttonAction = ButtonAction.ADD;
  let showForm = false;
  let value = "";

  const toggleAction = async () => {
    if (buttonAction === ButtonAction.ADD) {
      buttonAction = ButtonAction.SAVE;
      showForm = true;
    } else if (buttonAction === ButtonAction.SAVE) {
      const [success, newTodos] = await todoService.save(value);
      if (success) {
        buttonAction = ButtonAction.ADD;
        showForm = false;
        // update the dom
        todos = newTodos;
        value = "";
      } else {
        // do something here on error
      }
    }
  };
</script>

<h2>Todos</h2>
<ul>
  {#await todos}
    ...
  {:then todos}
    {#each todos as todo}
      <li>{todo}</li>
    {/each}
    {#if showForm}
      <li><input type="text" bind:value /></li>
    {/if}
  {/await}
</ul>
{#if !previewMode}
  <button on:click={toggleAction}>{buttonAction}</button>
{/if}
