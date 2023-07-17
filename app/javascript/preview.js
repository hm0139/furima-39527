document.addEventListener("turbo:load",() => {
  const postImage = document.getElementById("item-image");

  if(!postImage)return;

  const previewList = document.getElementById('previews');
  postImage.addEventListener("change",(e) => {
    const alreadyPreview = document.querySelector('.preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    const previewWrapper = document.createElement("div");
    previewWrapper.setAttribute("class","preview");

    const previewImage = document.createElement("img");
    previewImage.setAttribute("class","preview-image");
    previewImage.setAttribute("src",blob);

    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
  });
});