<script lang="ts">
  // import html2canvas from "html2canvas";
  import { toPng } from "html-to-image";
  import download from "downloadjs";
  import Todos from "./Todos.svelte";
  import Note from "./Note.svelte";

  let preview;

  const generatePreview = async () => {
    preview.style.width = "800px";
    preview.style.height = "480px";

    const dataUrl = await toPng(preview);
    download(dataUrl, "billboard.png");
    // const tempCanvas = document.createElement("canvas");
    // tempCanvas.height = 480;
    // tempCanvas.width = 800;

    // const canvas = await html2canvas(preview, {
    //   width: 800,
    //   height: 480,
    //   canvas: tempCanvas,
    // });

    // preview.appendChild(canvas);
    // return;

    // const link = document.createElement("a");
    // link.download = "billboard.png";
    // link.href = canvas.toDataURL();
    // link.click();

    preview.style.width = "initial";
    preview.style.height = "initial";
  };
</script>

<h2>Preview</h2>
<div id="preview" class="light-mode" bind:this={preview}>
  <section id="todos">
    <Todos previewMode={true} />
  </section>
  <section id="note">
    <Note previewMode={true} />
  </section>
</div>
<button on:click={generatePreview}>Generate Preview</button>

<style>
  #preview {
    /* width: 800px;
    height: 480px; */

    display: grid;
    grid-template-columns: auto auto;

    padding: 0.25rem;
  }

  #note {
    border: 1px solid black;
    padding: 0.25rem;
  }
</style>
