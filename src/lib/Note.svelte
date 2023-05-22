<script lang="ts">
  import noteService from "../services/note.service";

  enum ButtonAction {
    EDIT = "Edit",
    SAVE = "Save",
  }

  export let previewMode = false;

  let note = noteService.fetch();
  let buttonAction = ButtonAction.EDIT;
  let showTextarea = false;
  let value = "";

  const toggleAction = async () => {
    if (buttonAction === ButtonAction.EDIT) {
      // set up for editing
      buttonAction = ButtonAction.SAVE;
      showTextarea = true;
    } else if (buttonAction === ButtonAction.SAVE) {
      // save dom content
      const [success, newNote] = await noteService.save(value);
      if (success) {
        buttonAction = ButtonAction.EDIT;
        showTextarea = false;
        // update the dom note
        note = newNote;
        value = "";
      } else {
        // do something here on error
      }
    }
  };
</script>

<h2>Note</h2>
<div class="notes-container">
  {#await note}
    ...
  {:then note}
    {#if showTextarea}
      <textarea bind:value />
    {:else}
      {note.body}
    {/if}
  {/await}
  {#if !previewMode}
    <button on:click={toggleAction}>{buttonAction}</button>
  {/if}
</div>
