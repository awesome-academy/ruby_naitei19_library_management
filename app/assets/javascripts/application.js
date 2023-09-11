import Dropzone from 'dropzone';

document.addEventListener('DOMContentLoaded', () => {
  const dropzoneElement = document.getElementById('my-dropzone');

  if (dropzoneElement) {
    const dropzone = new Dropzone(dropzoneElement, {

    });
  }
});
